
select decode(message_level, 5, 'WARNING', 1, 'CRITICAL') alert_level,
reason from dba_outstanding_alerts where reason like '%resumable%';

