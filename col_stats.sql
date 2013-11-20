-- col_stats
-- Jerzy Kedra 2010
-- some parts were collected at random Internet sities, blogs
-- and Oracle Metalink
--
col table_name   form a15 word wrap
col column_name  form a22 word wrap
col data_type    form a12
col num_vals     form 99999,999
col dnsty        form 0.9999
col num_nulls    form 99999,999
col bks          form 999
col loval        form a18
col hival        form a18
col data_type    form a10
col hist         form a4
col avcl         form 9999
set lines 160
set pagesize 80
set verify off


ACCEPT vowner CHAR PROMPT "owner  [current]: "
ACCEPT vtable CHAR PROMPT "table  [all    ]: "
ACCEPT vcol   CHAR PROMPT "column [all    ]: "

PROMPT     BKS = BUCKETS
PROMPT    AVCL = AVG_COLUMN_LEN
PROMPT   HIST  = HISTOGRAM HBAL=HEIGH BALANCED
PROMPT LANALZD = LAST ANALYZED
PROMPT     NDV = Number of Distinct Values
SELECT column_name,data_type,avg_col_len avcl,density,num_distinct ndv,
       DECODE(histogram, 'FREQUENCY', 'FREQ', 'HEIGHT BALANCED', 'HBAL',
              histogram) hist,
       num_buckets bks,sample_size,
       TO_CHAR(last_analyzed, 'DD-MM-YY') lanalzd,
       DECODE(avg_col_len, 0, NULL,
       DECODE(data_type
      ,'NUMBER'       ,to_char(utl_raw.cast_to_number(low_value))
      ,'VARCHAR2'     ,to_char(utl_raw.cast_to_varchar2(low_value))
      ,'CHAR'         ,to_char(utl_raw.cast_to_varchar2(high_value))
      ,'NVARCHAR2'    ,to_char(utl_raw.cast_to_nvarchar2(low_value))
      ,'BINARY_DOUBLE',to_char(utl_raw.cast_to_binary_double(low_value))
      ,'BINARY_FLOAT' ,to_char(utl_raw.cast_to_binary_float(low_value))
      ,'DATE',
     lpad(to_char(to_number(substr(low_value, 7, 2 ), 'xx' )),2,'0') || '-' ||
     lpad(to_char(to_number(substr(low_value, 5, 2 ), 'xx' )),2,'0') || '-' ||
     lpad(to_char
     (  (to_number(substr(low_value, 1, 2 ), 'xx')-100)*100
       + (to_number(substr(low_value, 3, 2 ), 'xx')-100)
     ),4,'0') || ' ' ||
     lpad(to_char(to_number(substr(low_value, 9, 2 ), 'xx' )-1),2,'0') || ':' ||
     lpad(to_char(to_number(substr(low_value,11, 2 ), 'xx' )-1),2,'0') || ':' ||
     lpad(to_char(to_number(substr(low_value,13, 2 ), 'xx' )-1),2,'0'),
     '...'
      )) loval,
      DECODE(avg_col_len, 0, NULL,
      DECODE(data_type
      ,'NUMBER'       ,to_char(utl_raw.cast_to_number(high_value))
      ,'VARCHAR2'     ,to_char(utl_raw.cast_to_varchar2(high_value))
      ,'CHAR'         ,to_char(utl_raw.cast_to_varchar2(high_value))
      ,'NVARCHAR2'    ,to_char(utl_raw.cast_to_nvarchar2(high_value))
      ,'BINARY_DOUBLE',to_char(utl_raw.cast_to_binary_double(high_value))
      ,'BINARY_FLOAT' ,to_char(utl_raw.cast_to_binary_float(high_value))
      ,'DATE',
     lpad(to_char(to_number(substr(high_value, 7, 2 ), 'xx' )),2,'0') || '-' ||
     lpad(to_char(to_number(substr(high_value, 5, 2 ), 'xx' )),2,'0') || '-' ||
     lpad(to_char
     (  (to_number(substr(high_value, 1, 2 ), 'xx')-100)*100
       + (to_number(substr(high_value, 3, 2 ), 'xx')-100)
     ),4,'0') || ' ' ||
     lpad(to_char(to_number(substr(high_value, 9, 2 ), 'xx' )-1),2,'0') || ':' ||
     lpad(to_char(to_number(substr(high_value,11, 2 ), 'xx' )-1),2,'0') || ':' ||
     lpad(to_char(to_number(substr(high_value,13, 2 ), 'xx' )-1),2,'0'),
     '...'
      )
      ) hival
FROM all_tab_columns
    WHERE owner=NVL(UPPER('&vowner'), user)
      AND table_name=NVL(UPPER('&vtable'), table_name)
      AND column_name=NVL(UPPER('&vcol'), column_name);


