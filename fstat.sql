-- do pokazywania statystyk zapisow i odczytow
-- plikow z danymi

SET VERIFY OFF
COL NAME FORMAT A30
COL ID FORMAT 99
SET NUMWIDTH 6


SELECT	df.file# id,
	'..' || substr(name,-27, 27) name,
	phyrds/1000, phywrts/1000
FROM	v$datafile df, v$filestat fs
WHERE	df.file#=fs.file#
AND	UPPER(name) LIKE UPPER('%&1%')
ORDER BY id
/

SET VERIFY ON
COLUMN NAME CLEAR
COLUMN ID CLEAR


