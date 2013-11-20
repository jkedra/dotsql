Followup   December 24, 2004 - 1pm UTC:

there are precisely two columns in print_table output!


ops$tkyte@ORA9IUTF> create or replace type printTblScalar as object
  2  ( cname  varchar2(30),
  3    cvalue varchar2(4000)
  4  )
  5  /
 
Type created.
 
ops$tkyte@ORA9IUTF> show errors
No errors.
ops$tkyte@ORA9IUTF>
ops$tkyte@ORA9IUTF> create or replace type printTblTable as table of printTblScalar
  2  /
 
Type created.



ops$tkyte@ORA9IUTF> create or replace function print_table_pipelined
  2  ( p_query in varchar2,
  3    p_date_fmt in varchar2 default 'dd-mon-yyyy hh24:mi:ss' )
  4  return printTblTable
  5  authid current_user
  6  PIPELINED
  7  is
  8      pragma autonomous_transaction;
  9      l_theCursor     integer default dbms_sql.open_cursor;
 10      l_columnValue   varchar2(4000);
 11      l_status        integer;
 12      l_descTbl       dbms_sql.desc_tab2;
 13      l_colCnt        number;
 14      l_cs            varchar2(255);
 15      l_date_fmt      varchar2(255);
 16
 17      -- small inline procedure to restore the sessions state
 18      -- we may have modified the cursor sharing and nls date format
 19      -- session variables, this just restores them
 20      procedure restore
 21      is
 22      begin
 23         if ( upper(l_cs) not in ( 'FORCE','SIMILAR' ))
 24         then
 25             execute immediate
 26             'alter session set cursor_sharing=exact';
 27         end if;
 28         if ( p_date_fmt is not null )
 29         then
 30             execute immediate
 31                 'alter session set nls_date_format=''' || l_date_fmt || '''';
 32         end if;
 33         dbms_sql.close_cursor(l_theCursor);
 34      end restore;
 35  begin
 36      -- I like to see the dates print out with times, by default, the
 37      -- format mask I use includes that.  In order to be "friendly"
 38      -- we save the date current sessions date format and then use
 39      -- the one with the date and time.  Passing in NULL will cause
 40      -- this routine just to use the current date format
 41      if ( p_date_fmt is not null )
 42      then
 43         select sys_context( 'userenv', 'nls_date_format' )
 44           into l_date_fmt
 45           from dual;
 46
 47         execute immediate
 48         'alter session set nls_date_format=''' || p_date_fmt || '''';
 49      end if;
 50
 51      -- to be bind variable friendly on this ad-hoc queries, we
 52      -- look to see if cursor sharing is already set to FORCE or
 53      -- similar, if not, set it so when we parse -- literals
 54      -- are replaced with binds
 55      if ( dbms_utility.get_parameter_value
 56           ( 'cursor_sharing', l_status, l_cs ) = 1 )
 57      then
 58          if ( upper(l_cs) not in ('FORCE','SIMILAR'))
 59          then
 60              execute immediate
 61             'alter session set cursor_sharing=force';
 62          end if;
 63      end if;
 64
 65      -- parse and describe the query sent to us.  we need
 66      -- to know the number of columns and their names.
 67      dbms_sql.parse(  l_theCursor,  p_query, dbms_sql.native );
 68      dbms_sql.describe_columns2
 69      ( l_theCursor, l_colCnt, l_descTbl );
 70
 71      -- define all columns to be cast to varchar2's, we
 72      -- are just printing them out
 73      for i in 1 .. l_colCnt loop
 74          if ( l_descTbl(i).col_type not in ( 113 ) )
 75          then
 76              dbms_sql.define_column
 77              (l_theCursor, i, l_columnValue, 4000);
 78          end if;
 79      end loop;
 80
 81      -- execute the query, so we can fetch
 82      l_status := dbms_sql.execute(l_theCursor);
 83
 84      -- loop and print out each column on a separate line
 85      -- bear in mind that dbms_output only prints 255 characters/line
 86      -- so we'll only see the first 200 characters by my design...
 87      while ( dbms_sql.fetch_rows(l_theCursor) > 0 )
 88      loop
 89          for i in 1 .. l_colCnt loop
 90              if ( l_descTbl(i).col_type not in ( 113 ) )
 91              then
 92                  dbms_sql.column_value
 93                  ( l_theCursor, i, l_columnValue );
 94                  pipe row( printTblScalar( l_descTbl(i).col_name,
 95                                            substr(l_columnValue,1,4000) ) );
 96              end if;
 97          end loop;
 98          pipe row( printTblScalar( rpad('-',10,'-'), null ) );
 99      end loop;
100
101      -- now, restore the session state, no matter what
102      restore;
103      return;
104  exception
105      when others then
106          restore;
107          raise;
108  end;
109  /
 
Function created.



ops$tkyte@ORA9IUTF> column cname format a10
ops$tkyte@ORA9IUTF> column cvalue format a40
ops$tkyte@ORA9IUTF> select *
  2    from table( print_table_pipelined('select * from scott.emp where rownum = 1' ));
 
CNAME      CVALUE
---------- ----------------------------------------
EMPNO      7369
ENAME      SMITH
JOB        CLERK
MGR        7902
HIREDATE   17-dec-1980 00:00:00
SAL        800
COMM
DEPTNO     20
----------
 
9 rows selected.
 
ops$tkyte@ORA9IUTF> select *
  2    from table( print_table_pipelined('select * from scott.dept' ));
 
CNAME      CVALUE
---------- ----------------------------------------
DEPTNO     10
DNAME      ACCOUNTING
LOC        NEW YORK
----------
DEPTNO     20
DNAME      RESEARCH
LOC        DALLAS
----------
DEPTNO     30
DNAME      SALES
LOC        CHICAGO
----------
DEPTNO     40
DNAME      OPERATIONS
LOC        BOSTON
----------
 
16 rows selected.



it does remove the 1,000,000 buffer limit of dbms_output and increased the column value being 
displayed from a max of 200 characters to 4000

 
