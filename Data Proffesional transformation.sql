# First_Hands on project #=========

show databases;
use new_project;
select * from data_professionals_survey_analysis;

rename table data_professionals_survey_analysis to survey_analysis;

select * from survey_analysis;
select count(*) from survey_analysis;
describe survey_analysis;

set sql_safe_updates = 0;

alter table survey_analysis
drop column Browser,
drop column OS,
drop column City,
drop column survey_country,
drop column Referrer;

alter table survey_analysis
rename column `ï»¿Unique ID` to `Unique_id`;

alter table survey_analysis
add column Dates_taken date;

update survey_analysis
set Dates_taken = STR_TO_DATE(replace(trim(`Date Taken (America/New_York)`),'-','/'), '%m/%d/%Y');

alter table survey_analysis
drop column `Date Taken (America/New_York)`;

alter table survey_analysis
add column Time_taken time;

update survey_analysis
set Time_taken = STR_TO_DATE(trim(`Time Taken (America/New_York)`), '%H:%i');

alter table survey_analysis
drop column `Time Taken (America/New_York)`;

select education, count(education) 
from survey_analysis
where education = ''
group by education;

update survey_analysis
set education = 'Unknown'
where education = '';

alter table survey_analysis add column Current_working_Role varchar(100);

update survey_analysis
set Current_working_Role = 
trim(case
	when lower(current_role) like 'other%'
    then substring(current_role,locate(':',current_role)+1)
    else current_role
end );


delete from survey_analysis
where Current_working_Role in
(select Current_working_Role from 
(select Current_working_Role , count(*) as cnt
from survey_analysis
group by Current_working_Role
having cnt < 2) as dd);

alter table survey_analysis add column Working_Industry varchar(100);

update survey_analysis
set Working_Industry = 
trim(case 
	when industry like 'Other%'
	then substring(industry, locate(':',industry) + 1)
    else industry
end);

delete from survey_analysis
where Working_Industry in
(select Working_Industry from 
(select  Working_Industry, count(*) as cnt
from survey_analysis
group by Working_Industry
having cnt = 1) as dd);

alter table survey_analysis
drop column current_role,
drop column industry;

select job_pref, count(*)
from survey_analysis
group by job_pref;

update survey_analysis
set job_pref = 
	case when job_pref like 'Other%' then 'Other' else job_pref end;

select residence_country, count(*)
from survey_analysis
group by residence_country;

update survey_analysis
set residence_country = trim(substring_index(residence_country, ':',-1))
where residence_country like 'Other%';

select ethnicity, count(*)
from survey_analysis
group by ethnicity;

update survey_analysis
set ethnicity = 
	case when ethnicity like 'Other%' then 'Other' else ethnicity end;
    
update survey_analysis as s
inner join (
select ethnicity
from survey_analysis
group by ethnicity
having count(*) < 5) as rare
on s.ethnicity = rare.ethnicity
set s.ethnicity = 'Other';

select fav_language, count(*)
from survey_analysis
group by fav_language;

update survey_analysis
set fav_language =
trim(
	 case
		when lower(fav_language) like 'other:%'
		then substring(fav_language, locate(':',fav_language) + 1)
		else fav_language
     end
)
where fav_language like 'Other%';

update survey_analysis
set fav_language = 'No'
where lower(fav_language) like '%no%';

update survey_analysis
set fav_language = 'sql'
where lower(fav_language) like '%sql%';

update survey_analysis
set fav_language = 'excel'
where lower(fav_language) like '%excel%';

delete from survey_analysis
where fav_language in (
select fav_language from (
select fav_language, count(*)
from survey_analysis
group by fav_language
having count(*) < 10) as tt );

select fav_language, count(*)
from survey_analysis
group by fav_language;

select * from survey_analysis;

# ================Now Finding Insights================#

# Q1. Distribution of education levels
select education, count(*) as count
from survey_analysis
group by education
order by count desc;

# Q2. Ethnicity breakdown
select Ethnicity, count(*) as count
from survey_analysis
group by Ethnicity
order by count desc;

# Q3. Respondents by country
select residence_country, count(*) as count
from survey_analysis
group by residence_country
having count(*) > 10
order by count desc;

#Q4. Age distribution (grouped by range)
select 
case
	when age between 18 and 24 then '18-24'
    when age between 25 and 34 then '25-34'
    when age between 35 and 44 then '35-44'
    when age between 45 and 54 then '45-54'
    else '+54'
end as age_group,
count(*) as count 
from survey_analysis
group by age_group
order by count desc;

#Q5. Top 3 Working roles
select Current_working_Role, count(*) as count
from survey_analysis
group by Current_working_Role
order by count(*) desc
limit 3;

#Q6. Top 3 Working Industry
select Working_Industry, count(*) as count
from survey_analysis
group by Working_Industry
order by count(*) desc
limit 3;

#Q7. Job preference distribution
with cte1 as (
select job_pref, count(*) as count
from survey_analysis
group by job_pref),
cte2 as (
select count(*) as total_count from survey_analysis)
select job_pref, concat(100*(c1.count/c2.total_count), '%') as count_percentage
from cte1 c1 , cte2 c2
order by count_percentage desc;

#Q8. Career switch trends (Yes vs No)
with cte1 as (
select career_switch, count(*) as count
from survey_analysis
group by career_switch
order by count desc), 
cte2 as (
select count(*) as total_count from survey_analysis)
select career_switch, concat(100*(c1.count/c2.total_count),'%') as  count_percentage
from cte1 c1, cte2 c2 
order by count_percentage desc;

#Q9. Most popular tools/languages
select fav_language, count(*) as count
from survey_analysis
group by fav_language
order by count desc;

#Q10. Favorite language by working role
select Current_working_Role, fav_language, count(*) as count
from survey_analysis
group by Current_working_Role, fav_language
order by count desc
limit 5;

#Q11. Satisfaction Metrics
#Average happiness across dimensions (salary, worklife, coworkers, management, etc.)
select 
	round(avg(happy_salary),2) as avg_salary,
	round(avg(happy_worklife),2) as avg_worklife,
	round(avg(happy_coworkers),2) as avg_coworkers,
	round(avg(happy_management),2) as avg_management,
	round(avg(happy_mobility),2) as avg_mobility,
	round(avg(happy_learning),2) as avg_leaning
from survey_analysis;

#Q12. Top 5 happiest roles based on average work-life happiness
select Current_working_Role, round(avg(happy_worklife),2) as avg_worklife
from survey_analysis
group by Current_working_Role
having count(*) > 3
order by avg_worklife desc
limit 3;

#Q13.Relationship between salary satisfaction and career switch
select career_switch, round(avg(happy_salary),2) as avg_salary_happiness
from survey_analysis
group by career_switch;

#Q14.Which countries have respondents who are least happy with management?
select residence_country, round(avg(happy_management),2) as avg_management
from survey_analysis
group by residence_country
having count(*) > 5
order by avg_management 
limit 5;

#Q15.Most common language/tool used by people aged under 30
select fav_language, count(*) as count
from survey_analysis
where age < 30
group by fav_language
order by count desc;

#Q16.Education level vs average salary happiness
select education, round(avg(happy_salary), 2) as avg_salary_happiness
from survey_analysis
group by education
order by avg_salary_happiness desc;

#Q17. Does job preference influence work-life balance satisfaction?
select job_pref, round(avg(happy_worklife),2) as avg_worklife
from survey_analysis
group by job_pref
order by avg_worklife desc;

#Q18. Sum of salary by Current_working_Role
select Current_working_Role, sum(salary_usd) as total_salary_in_usd
from survey_analysis
group by Current_working_Role
having count(*) > 10;

