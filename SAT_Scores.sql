select *
from scores

alter table scores
drop column latitude, longitude

exec sp_rename
'SCORES.average score (SAT Math)', 'Avg_Score_Math', 'COLUMN'
exec sp_rename
'SCORES.percent tested', 'Percent_tested', 'COLUMN'