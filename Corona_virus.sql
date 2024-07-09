create table corona_virus_dataset
(
Provinces char(50),
Country char(50),
Latitude decimal,
Longitude decimal,
Date varchar(10),
confirmed int(10),
Deaths int(10),
Recovered int (10)
);
select * from corona_virus_dataset;

select * from corona_virus_dataset where 
Provinces is Null or 
Country is Null or
Latitude is Null or
Longitude is Null or
Date is Null or
Deaths is Null or 
Recovered  IS null;


#Count the total no of rows in the dataset 
select count(*) from corona_virus_dataset;

# select the Start date and End date ( Date value was in string, converted it into Date value)#
update corona_virus_dataset set Date=str_to_date(Date, "%d-%m-%Y");
select Min(Date) as Start_Date, Max(Date) as End_Date from corona_virus_dataset;

# select the total no of months#
set @Start_date = "2020-01-22";
set @End_date = "2021-06-13";
select timestampdiff(month, @Start_date, @End_date) as Number_of_months;

#Find monthly average for confirmed, deaths, recovered
select year(Date) as YEARS , month(Date) as MONTHS, Floor(Avg(confirmed)) as AVG_CONFIRM, 
Floor(Avg(Deaths)) as AVG_DEATH, Floor(Avg(Recovered)) as AVG_RECOVER 
from corona_virus_dataset group by year(Date), month(Date);

## Find most frequent value for confirmed, deaths, recovered each month 
SELECT month(date) as month, confirmed, Deaths, recovered, COUNT(*) AS frequency
FROM corona_virus_dataset
GROUP BY confirmed, Deaths, recovered, month
ORDER BY frequency desc;

## Find minimum values for confirmed, deaths, recovered per year
select year(Date), min(confirmed), min(Deaths), min(recovered) 
from corona_virus_dataset group by year(Date);

## Find maximum values of confirmed, deaths, recovered per year
select year(Date), max(confirmed), max(Deaths), max(recovered) 
from corona_virus_dataset group by year(Date);

## The total number of case of confirmed, deaths, recovered each month
select year(Date) as Year, month(Date) as Months, sum(confirmed) as Total_confirmed, 
sum(Deaths) as Total_Deaths, sum(recovered) as Total_recovered 
from corona_virus_dataset group by year(Date), month(Date);

 select monthname(date), sum(Deaths) from corona_virus_dataset group by monthname(date);

##  Check how corona virus spread out with respect to confirmed case
select sum(confirmed) as Total_confirmed, avg(confirmed), variance(confirmed),
 stddev(confirmed) from corona_virus_dataset;

##  Check how corona virus spread out with respect to death case per month
--      (Eg.: total confirmed cases, their average, variance & STDEV )
select year(Date) as Year, month(Date) as Months, round(sum(Deaths),2) 
as Total_Deaths, round(avg(Deaths),2) as Avg_Deaths, round(variance(Deaths),2) 
as Variance_Deaths, round(stddev(Deaths),2) as Stddev_Deaths 
from corona_virus_dataset group by year(Date), month(Date);

## Check how corona virus spread out with respect to recovered case
--      (Eg.: total confirmed cases, their average, variance & STDEV )
select sum(recovered) as Total_recovered, round(avg(recovered),2) 
as Avg_recovered, round(variance(recovered),2) as variance_recovered, 
round(stddev(recovered),2) as stddev_recovered 
from corona_virus_dataset;

## Find Country having highest number of the Confirmed case
select country, sum(confirmed) as total_confirmed from 
corona_virus_dataset group by Country order by total_confirmed desc limit 1;

## Find Country having lowest number of the death case
select country, sum(Deaths) as Total_Deaths 
from corona_virus_dataset group by Country 
order by Total_Deaths asc limit 4;

## Find top 5 countries having highest recovered case
select country, sum(recovered) as Total_recovered 
from corona_virus_dataset group by country 
order by Total_recovered desc limit 5;