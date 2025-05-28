select *
from scores

-- 1. What is the average SAT score (Math/Reading/Writing) by borough?

select Borough, avg(Avg_Score_Math) Math_avg, avg(Avg_Score_Reading) Reading_avg, 
avg(Avg_Score_Writing) Writing_avg
from scores
group by Borough;

-- 2. Which schools have the highest and lowest average SAT scores?

select School_Name, Avg_Score_Math, Avg_Score_Reading, Avg_Score_Writing,
ROW_NUMBER() over(order by Avg_Score_Math desc) as RN
from scores
where Avg_Score_Math is not null

-- 3. Is there a relationship between student enrollment size and SAT performance?

select Student_Enrollment, Avg_Score_Math, Avg_Score_Reading, Avg_Score_Writing
from scores
where Student_Enrollment is not null
order by Student_Enrollment desc
-- yes, the higher the size of student enrolled, the higher SAT performance

-- 4. How does SAT performance vary across ZIP codes or boroughs?

select Borough, Avg_Score_Math, Avg_Score_Reading, Avg_Score_Writing
from scores
order by Avg_Score_Math desc, Avg_Score_Reading, Avg_Score_Writing

-- 5. Are schools in certain geographic areas (e.g., Upper Manhattan) performing better?

with cte as(
select Borough, Avg_Score_Math, Avg_Score_Reading, Avg_Score_Writing,
row_number() over(partition by borough order by Avg_Score_Math desc) RN
from scores)
select *
from cte
where RN <= 3
-- schools in manhattan had higher scores, brooklyn had lower scores 

-- 6. Do schools with longer school hours (start to end time) perform better on the SAT?

select School_Name, datediff(hour, Start_Time, End_Time) School_Duration,
(Avg_Score_Math + Avg_Score_Reading + Avg_Score_Writing) Total_Avg
from scores
order by School_Duration desc
-- school hours doesn't relate to longer school hours

-- 7. What are the average school hours across different boroughs?

select Borough, AVG(datediff(hour, Start_Time, End_Time)) Avg_School_Duration
from scores
group by Borough

-- 8. Is there a correlation between racial/ethnic composition and SAT performance?

select School_Name, Percent_White, Percent_Black, 
Percent_Asian, Percent_Hispanic,
(Avg_Score_Math + Avg_Score_Reading + Avg_Score_Writing) Total_Avg
from scores 
where Avg_Score_Math is not null
order by Total_Avg desc
-- asians and whites had the best scores