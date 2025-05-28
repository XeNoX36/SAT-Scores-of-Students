# Analyzing Student SAT Scores

## Schema
```sql
select *
from scores
```
## 1. What is the average SAT score (Math/Reading/Writing) by borough?
```sql
select Borough, avg(Avg_Score_Math) Math_avg, avg(Avg_Score_Reading) Reading_avg, 
avg(Avg_Score_Writing) Writing_avg
from scores
group by Borough;
```
![](https://github.com/XeNoX36/SAT-Scores-of-Students/blob/main/SAT%20one.png)

## 2. Which schools have the highest and lowest average SAT scores?
```sql
select School_Name, Avg_Score_Math, Avg_Score_Reading, Avg_Score_Writing,
ROW_NUMBER() over(order by Avg_Score_Math desc) as RN
from scores
where Avg_Score_Math is not null
```
![](https://github.com/XeNoX36/SAT-Scores-of-Students/blob/main/SAT%202.png)

## 3. Is there a relationship between student enrollment size and SAT performance?
```sql
select Student_Enrollment, Avg_Score_Math, Avg_Score_Reading, Avg_Score_Writing
from scores
where Student_Enrollment is not null
order by Student_Enrollment desc
```
![](https://github.com/XeNoX36/SAT-Scores-of-Students/blob/main/SAT3.png)
```sql
-- yes, the higher the size of student enrolled, the higher SAT performance
```

## 4. How does SAT performance vary across ZIP codes or boroughs?
```sql
select Borough, Avg_Score_Math, Avg_Score_Reading, Avg_Score_Writing
from scores
order by Avg_Score_Math desc, Avg_Score_Reading, Avg_Score_Writing
```
![](https://github.com/XeNoX36/SAT-Scores-of-Students/blob/main/SAT4.png)

## 5. Are schools in certain geographic areas (e.g., Upper Manhattan) performing better?
```sql
with cte as(
select Borough, Avg_Score_Math, Avg_Score_Reading, Avg_Score_Writing,
row_number() over(partition by borough order by Avg_Score_Math desc) RN
from scores)
select *
from cte
where RN <= 3
```
![](https://github.com/XeNoX36/SAT-Scores-of-Students/blob/main/SAT5.png)
```sql
-- schools in manhattan had higher scores, brooklyn had lower scores 
```

## 6. Do schools with longer school hours (start to end time) perform better on the SAT?
```sql
select School_Name, datediff(hour, Start_Time, End_Time) School_Duration,
(Avg_Score_Math + Avg_Score_Reading + Avg_Score_Writing) Total_Avg
from scores
order by School_Duration desc
-- school hours doesn't relate to longer school hours
```

## 7. What are the average school hours across different boroughs?
```sql
select Borough, AVG(datediff(hour, Start_Time, End_Time)) Avg_School_Duration
from scores
group by Borough
```
![](https://github.com/XeNoX36/SAT-Scores-of-Students/blob/main/SAT7.png)

## 8. Is there a correlation between racial/ethnic composition and SAT performance?
```sql
select School_Name, Percent_White, Percent_Black, 
Percent_Asian, Percent_Hispanic,
(Avg_Score_Math + Avg_Score_Reading + Avg_Score_Writing) Total_Avg
from scores 
where Avg_Score_Math is not null
order by Total_Avg desc
```
![](https://github.com/XeNoX36/SAT-Scores-of-Students/blob/main/SAT8.png)
```sql
-- asians and whites had the best scores
```
