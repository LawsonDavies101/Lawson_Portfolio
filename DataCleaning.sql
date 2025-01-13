# US Household Income Data Cleaning

SELECT *
FROM US_Household_Income.Income
;

SELECT *
FROM US_Household_Income.Income_Statistics
;
#recording the count of each dataset to discover is they had similar or equal amount of records recorded when importing into MySQl
select count(id)
from US_Household_Income.Income
;

select count(id)
from US_Household_Income.Income_Statistics
;

#Running a query to discover any duplicates within the dataset
select id, count(id)
from US_Household_Income.Income
group by id
having count(id) > 1
;

select *
from (
select row_id, id, row_number () over(partition by id order by id) row_num
from US_Household_Income.Income
) duplicates
where row_num > 1
;

#running this query to delete the duplicates recorded previously from the previous query and keeping the intiial one records within the dataset
delete from US_Household_Income.Income
where row_id in (
select row_id
from (
select row_id, id,row_number () over(partition by id order by id) row_num
from US_Household_Income.Income
) duplicates
where row_num > 1 )
;

#Running another query but for the statistic dataset to ensure the duplicates have been removed from both datasets 
select id, count(id)
from US_Household_Income.Income_Statistics
group by id
having count(id) > 1
;

#Looking over the 'State_Name' for any grammatical errors which subsequentially result in an issue in the overall amount of records for each state
select State_Name, count(State_Name)
from US_Household_Income.Income
group by State_Name
;

update US_Household_Income.Income
set State_Name = 'Georgia'
where State_name = 'georia'
;

update US_Household_Income.Income
set State_Name = 'Alabama'
where State_name = 'alabama'
;

#Discovered an unpopulated record and update this record accordingly to the 'Place' where all the other similar records had for its location for 'Place'
select *
from US_Household_Income.Income
where County = 'Autauga County'
;

update US_Household_Income.Income
set Place = 'Autaugaville'
where County = 'Autauga County'
and City = 'Vinemont'
;

#further investigation within the columns I discovered a typo error 'Borough' and 'CDP'
select type, count(type)
from US_Household_Income.Income
group by type
;

update US_Household_Income.Income
set type = 'Borough'
where type = 'Boroughs'
;

update US_Household_Income.Income
set type = 'CDP'
where type = 'CPD'
;

