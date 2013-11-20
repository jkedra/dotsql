SET LINESIZE 120
SET WRAP OFF
COL MESSAGE FORMAT A80

SELECT	decode(facility, 'Log Transport Services', 'LTS',
                         'Remote File Server',     'RFS',
		facility) fac,
	to_char(timestamp, 'DDMMYY HH24MI') as "DDMMYY HHMI",
	message
FROM v$dataguard_status;

