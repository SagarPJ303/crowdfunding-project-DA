create database projectss;
use projectss;
select * from projects;
-- q5.1 Total Number of Projects based on outcome 
     
     
     

select count(projectID),state from projects group by state order by count(projectID) desc;
-- q5.2 Total Number of Projects based on Locations
select count(projectID) number_of_projects,displayable_name from projects inner join crowdfunding_location on projects.location_id=crowdfunding_location.ï»¿id
 group by displayable_name order by count(projectID) desc;
-- q5.3 Total Number of Projects based on  Category
select crowdfunding_category.name,count(projectID) as number_of_projects from projects inner join crowdfunding_category on projects.category_id= crowdfunding_category.id group by name
order by count(projectID) desc;
-- q5.4 Total Number of Projects created by Year , Quarter , Month
ALTER TABLE calender CHANGE `I d` ID INT;
ALTER TABLE calender CHANGE `month fullname` month_fullname varchar(30);
select calender.year,calender.Quarter,calender.month_fullname,count(projectID) from projects inner join calender
 on projects.projectID=calender.ID group by calender.year,calender.Quarter,calender.month_fullname order by count(projectID) desc;
 
 -- q6.1  (successful)Amount Raised 
 select sum(pledged)as sucessful_amount from projects where state = "successful";
 -- q6.2 (successful) Number of Backers
 select count(backers_count) as successful_backers from projects where state = "successful";
 -- q6.3  Avg NUmber of Days for successful projects
  select dacreated_at,deadline from projects;
 select avg(datediff(created_at,successful_at)) as successful_backers from projects  where state = "successful";

select avg('Weekdaynumber') as AvgNumberofDays
 from calender_table inner join  projects
on calender_table.Id=projects.ProjectID
where state="successful" ;

SELECT AVG(DATEDIFF(successful_at, created_at)) AS avg_days_for_successful_projects
FROM projects
WHERE state = 'successful';
 
 -- q7.1 Top Successful Projects : Based on Number of Backers
 select projects.name,sum(backers_count) as top_successful_backers from projects where state="successful" 
 group by projects.name order by sum(backers_count) desc limit 10;
 
 -- q7.2 Top Successful Projects :   Based on Amount Raised.     
  select projects.name,pledged from projects where state="successful" 
 order by pledged desc limit 10;
 
 -- q8.1  Percentage of Successful Projects  by Category
 select crowdfunding_category.name, count(*) as total_project,count(case when state="successful" then 1 end) as successful_project,
 (count(case when state="successful" then 1 end)*100.00)/count(*) as sucess_percent
 from projects  inner join crowdfunding_category on projects.category_id=crowdfunding_category.id 
 group by crowdfunding_category.name order by successful_project desc ;
 
 -- 8.1
 select c.name as category, concat(round((count(projects.projectID)/(select count(projects.projectID) as numberofprojects 
 from projects inner join crowdfunding_category c
 on projects.category_id=c.id where state="successful"))*100),"%") as percentage_of_projects
 from projects inner join crowdfunding_category c
  on projects.category_id=c.id where state="successful" group by category order by percentage_of_projects desc limit 10;
  
  -- 8.2  Percentage of Successful Projects by Year , Month etc..
   select  year , concat((count(Id)/(select count(Id) from calender_table))*100,'%')as Percentage_of_Projects
from calender_table group by year; 
  
  select  Quarter , concat((count(Id)/(select count(Id) from calender_table))*100,'%')as Percentage_of_Projects
from calender_table group by Quarter;
 
   select  `month fullname` , concat((count(Id)/(select count(Id) from calender_table))*100,'%')as Percentage_of_Projects
from calender_table group by `month fullname`;

 -- Q8.3 Percentage of Successful projects by Goal Range.
 select case 
 when goal= "10000" then "0K-10k"
 when goal between "10000" and "20000" then "11k-20k"
 when goal between "21000" and "30000" then "21k-30k"
 when goal between "31000" and "40000" then "31k-40k"
 when goal between "41000" and "50000" then "41k-50k"
 else ">51K"
 end as goal_range,
 ((count(projectid))/(select count(projectid) from projects where state="successful")*100)
 as percentage_of_project from projects
where state="successful"
group by 
case 
 when goal= "10000" then "0K-10k"
 when goal between "10000" and "20000" then "11k-20k"
 when goal between "21000" and "30000" then "21k-30k"
 when goal between "31000" and "40000" then "31k-40k"
 when goal between "41000" and "50000" then "41k-50k"
 else ">51K"
 end;
 
 
 select 
 case
 when goal between 0 and 1000 then '0-1000'
 when goal between 1001 and 5000 then '1001-5000'
 when goal between 5001 and 10000 then '5001-10000'
 else '10001+'
 end
as goal_range,
((count(projectid)/(select count(ProjectID) from projects where state="successful"))*100)
 as PercentageProject from projects
  where state="successful"
 group by 
 case
 when goal between 0 and 1000 then '0-1000'
 when goal between 1001 and 5000 then '1001-5000'
 when goal between 5001 and 10000 then '5001-10000'
 else '10001+'
 end;
 
 
 

  
   

 
 