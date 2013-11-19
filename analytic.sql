-- http://asktom.oracle.com/pls/asktom/f?p=100:11:0::::P11_QUESTION_ID:47910227585839
select min(err_ivc_seq_nr), max(err_ivc_seq_nr),
	count(*), nt
from ( select err_ivc_seq_nr, ntile(10)
		over (order by err_ivc_seq_nr) nt
               from tasr_errivclog
         )
group by nt
ORDER BY NT;
