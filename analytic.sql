-- vim:ts=4
-- http://asktom.oracle.com/pls/asktom/f?p=100:11:0::::P11_QUESTION_ID:47910227585839

--
-- below examples of usage
--
select min(err_ivc_seq_nr), max(err_ivc_seq_nr),
	count(*), nt
from ( select err_ivc_seq_nr, ntile(10)
		over (order by err_ivc_seq_nr) nt
               from tasr_errivclog
         )
group by nt
ORDER BY NT;


SELECT min(brd_flt_dt), max(brd_flt_dt), count(*), nt
FROM (
	SELECT i.brd_flt_dt, ntile(10) 
        	OVER(ORDER BY brd_flt_dt) nt
        FROM tasr_ivc i, tasr_apcppdf a
        	WHERE i.ivc_seq_nr=a.ctr_ivc_seq_nr
			AND .brd_flt_dt < SYSDATE-15
	)
GROUP BY NT
 ORDER BY NT;        


