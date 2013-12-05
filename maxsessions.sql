select max(max_utilization),limit_value
from DBA_HIST_RESOURCE_LIMIT
WHERE resource_name in ('sessions')
GROUP BY limit_value;

