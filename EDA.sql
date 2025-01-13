# US Household Income Exploratory Data Analysis

SELECT *
FROM US_Household_Income.Income
;

SELECT *
FROM US_Household_Income.Income_Statistics
;

#looking at which states have the biggest area for land and water
select State_name, sum(ALand), sum(AWater)
FROM US_Household_Income.Income
Group by State_name
order by 2 desc
limit 10
;

select State_name, sum(ALand), sum(AWater)
FROM US_Household_Income.Income
Group by State_name
order by 3 desc
limit 10
;
#using the 'limit' to discover the top 10 states with most land and water
#using the order by to discover the largest area for either 'ALand' and 'AWater'

#I have joined both datasets together into on dataset by using the the 'id' as their corresponding value
SELECT *
FROM US_Household_Income.Income u
join US_Household_Income.Income_Statistics us
on u.id = us.id
;

SELECT *
FROM US_Household_Income.Income u
inner join US_Household_Income.Income_Statistics us
on u.id = us.id
where Mean <> 0
;

#breaking down the data and looking at the States with the lowest average income
SELECT u.State_Name, Round(AVG(Mean),1), Round(AVG(Median),1)
FROM US_Household_Income.Income u
inner join US_Household_Income.Income_Statistics us
on u.id = us.id
where Mean <> 0
group by u.State_Name
order by 2
limit 5
;

#also I decided to look a the states with the highest household income
SELECT u.State_Name, Round(AVG(Mean),1), Round(AVG(Median),1)
FROM US_Household_Income.Income u
inner join US_Household_Income.Income_Statistics us
on u.id = us.id
where Mean <> 0
group by u.State_Name
order by 2 desc
limit 10
;

#looking further into the data by comparing the 'Type' household people live in according to their household income
SELECT type, count(type), Round(AVG(Mean),1), Round(AVG(Median),1)
FROM US_Household_Income.Income u
inner join US_Household_Income.Income_Statistics us
on u.id = us.id
where Mean <> 0
group by type
order by 3 desc
limit 20
;

SELECT type, count(type), Round(AVG(Mean),1), Round(AVG(Median),1)
FROM US_Household_Income.Income u
inner join US_Household_Income.Income_Statistics us
on u.id = us.id
where Mean <> 0
group by type
order by 4 desc
limit 20
;

#with 'Community' almost being an anomaly to the other 'Type''s of household income, by looking further into the data I have discovered they were located in Puerto Rico which had the lowest overall household income
select *
from US_Household_Income.Income
where type = 'Community'
;

#using the 'having' function to filter out any outliners within the dataset
SELECT type, count(type), Round(AVG(Mean),1), Round(AVG(Median),1)
FROM US_Household_Income.Income u
inner join US_Household_Income.Income_Statistics us
on u.id = us.id
where Mean <> 0
group by 1
having count(type) > 100
order by 4 desc
limit 20
;

#further analysis into finding the highest income in each state
SELECT u.State_Name, City, round(avg(mean),1), round(avg(median),1)
FROM US_Household_Income.Income u
join US_Household_Income.Income_Statistics us
on u.id = us.id
group by u.State_Name, City
Order by round(avg(mean),1) desc
;