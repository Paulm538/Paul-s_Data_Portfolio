

---cleaning data 


SELECT Date, CONVERT(date,Date)
FROM [Conflict data].[dbo].['Yemen Data Project Published Ai$']

ALTER TABLE [Conflict data].[dbo].['Yemen Data Project Published Ai$']
ADD Date_converted date; 

UPDATE [Conflict data].[dbo].['Yemen Data Project Published Ai$']
SET Date_converted = CONVERT(date,Date)


Alter TABLE [Conflict data].[dbo].['Yemen Data Project Published Ai$']
ADD Year_1 int; 

UPDATE [Conflict data].[dbo].['Yemen Data Project Published Ai$']
SET Year_1 = Year(Date_converted)


--- over view of the war: number of Air strikes and civialin causlties


CREATE VIEW Tragets1 AS
SELECT Target, count(Target) as #_of_airstrikes, sum([Civilian Casualties]) as Civilian_Casualties, sum(Fatalities) as Total_Fatalities, 
	sum([Woman fatalities]) as Woman_fatalities , sum([Child fatalities]) as Child_fatalities

FROM [Conflict data].[dbo].['Yemen Data Project Published Ai$']
Group By Target
--Order BY Civilian_Casualties DESC


CREATE VIEW Main_category1 AS
SELECT [Main category], count([Main category]) as #_of_airstrike, sum([Civilian Casualties]) as Civilian_Casualties, sum(Fatalities) as Total_Fatalities, 
	sum([Woman fatalities]) as Woman_fatalities , sum([Child fatalities]) as Child_fatalities

FROM [Conflict data].[dbo].['Yemen Data Project Published Ai$']
Group By [Main category]
--Order BY Civilian_Casualties DESC


CREATE VIEW Sub_category1 AS
SELECT [Sub-category], count([Sub-category]) as #_of_airstrikes, sum([Civilian Casualties]) as Civilian_Casualties, sum(Fatalities) as Total_Fatalities, 
	sum([Woman fatalities]) as Woman_fatalities , sum([Child fatalities]) as Child_fatalities

FROM [Conflict data].[dbo].['Yemen Data Project Published Ai$']
Group By [Sub-category]
--Order BY Civilian_Casualties DESC



CREATE VIEW Governorate1 AS
SELECT Governorate, count(Governorate) as #_of_airstrikes, sum([Civilian Casualties]) as Civilian_Casualties, sum(Fatalities) as Total_Fatalities, 
	sum([Woman fatalities]) as Woman_fatalities , sum([Child fatalities]) as Child_fatalities

FROM [Conflict data].[dbo].['Yemen Data Project Published Ai$']
Group By Governorate
--Order BY Civilian_Casualties DESC

CREATE VIEW District1 AS
SELECT District, count(District) as #_of_airstrikes, sum([Civilian Casualties]) as Civilian_Casualties, sum(Fatalities) as Total_Fatalities, 
	sum([Woman fatalities]) as Woman_fatalities , sum([Child fatalities]) as Child_fatalities

FROM [Conflict data].[dbo].['Yemen Data Project Published Ai$']
Group By District
--Order BY Civilian_Casualties DESC

CREATE VIEW Time_of_Day1 AS
SELECT [Time of Day], count([Time of Day]) as #_of_airstrikes, sum([Civilian Casualties]) as Civilian_Casualties, sum(Fatalities) as Total_Fatalities, 
	sum([Woman fatalities]) as Woman_fatalities , sum([Child fatalities]) as Child_fatalities

FROM [Conflict data].[dbo].['Yemen Data Project Published Ai$']
Group By [Time of Day]
--Order BY Civilian_Casualties DESC


CREATE VIEW Year_1 AS
SELECT Year_1 , count(Year_1) as #_of_airstrikes, sum([Civilian Casualties]) as Civilian_Casualties, sum(Fatalities) as Total_Fatalities, 
	sum([Woman fatalities]) as Woman_fatalities , sum([Child fatalities]) as Child_fatalities

FROM [Conflict data].[dbo].['Yemen Data Project Published Ai$']
Group By Year_1 
--Order BY Year_1  Asc




--- number of air artikes and casualties per year

CREATE VIEW TS_Main_category2 AS
SELECT [Main category],Year_1,count([Main category]) As #_of_Airstrikes , sum([Civilian Casualties]) as Civilian_Casualties, sum(Fatalities) as Total_Fatalities, 
	sum([Woman fatalities]) as Woman_fatalities , sum([Child fatalities]) as Child_fatalities

FROM [Conflict data].[dbo].['Yemen Data Project Published Ai$']
Group By [Main category], Year_1 
--Order BY Year_1  Asc



CREATE VIEW TS_Governorate2 AS
SELECT Governorate, Year_1, count(Governorate) As #_of_Airstrikes , sum([Civilian Casualties]) as Civilian_Casualties, sum(Fatalities) as Total_Fatalities, 
	sum([Woman fatalities]) as Woman_fatalities , sum([Child fatalities]) as Child_fatalities

FROM [Conflict data].[dbo].['Yemen Data Project Published Ai$']
Group By Governorate, Year_1
--Order BY Year_1 ASC

CREATE VIEW TS_District2 AS
SELECT District , Year_1, count(District) As #_of_Airstrikes , sum([Civilian Casualties]) as Civilian_Casualties, sum(Fatalities) as Total_Fatalities, 
	sum([Woman fatalities]) as Woman_fatalities , sum([Child fatalities]) as Child_fatalities

FROM [Conflict data].[dbo].['Yemen Data Project Published Ai$']
Group By District, Year_1
--Order BY Year_1 ASC


CREATE VIEW TS_Time_of_Day_2 AS
SELECT [Time of Day], Year_1, count([Time of Day]) As #_of_Airstrikes , sum([Civilian Casualties]) as Civilian_Casualties, sum(Fatalities) as Total_Fatalities, 
	sum([Woman fatalities]) as Woman_fatalities , sum([Child fatalities]) as Child_fatalities

FROM [Conflict data].[dbo].['Yemen Data Project Published Ai$']
Group By [Time of Day], Year_1
--Order BY Year_1 ASC



---- Types and nummber of times a Tragets is attacked  



CREATE VIEW Air_Strike_By_Traget1 AS
SELECT Year_1 , count(Year_1) As T#_of_Airstrikes, 

--Unknown

count(case when [Sub-category] = 'Unknown' then 1 else null end)  As #_of_Airstrikes_on_Unknown_Tragets,

-- food production

count(case when [Sub-category] = 'Farms' then 1 else null end)  As #_of_Airstrikes_on_Farms,
count(case when [Sub-category] = 'Food (storage/transportation)' then 1 else null end)  As #_of_Airstrikes_on_Food,

--medical facailties 

count(case when [Sub-category] = 'Hospital' then 1 else null end)  As #_of_Airstrikes_on_Hospitals,
count(case when [Sub-category] = 'Medical centres' or [Sub-category] = 'Other-Medical' then 1 else null end)  As #_of_Airstrikes_on_Medical_facailties,
count(case when [Sub-category] = 'Clinic' then 1 else null end)  As #_of_Airstrikes_on_Clinics,

--military or war related tragets 

count(case when [Sub-category] = 'Military Site' or [Sub-category] = 'Other-Military' then 1 else null end)  As #_of_Airstrikes_on_Military_buildings,
count(case when [Sub-category] = 'Gov. Compounds' then 1 else null end)  As #_of_Airstrikes_on_Gov_Compounds,
count(case when [Sub-category] = 'HQ' then 1 else null end)  As #_of_Airstrikes_on_HQs,
count(case when [Sub-category] = 'Checkpoints' then 1 else null end)  As #_of_Airstrikes_on_Checkpoints,
count(case when [Sub-category] = 'State resources' then 1 else null end)  As #_of_Airstrikes_on_State_resources,
count(case when [Sub-category] = 'Weapon storage' then 1 else null end)  As #_of_Airstrikes_on_Weapon_storage,
count(case when [Sub-category] = 'Moving Traget (weapons/figthers)' or [Sub-category] = 'Forces' then 1 else null end)  As #_of_Airstrikes_on_Forces,

--education facailties 

count(case when [Sub-category] = 'University' then 1 else null end)  As #_of_Airstrikes_on_Universities,
count(case when [Sub-category] = 'School' or [Sub-category] = 'Other-Educational' then 1 else null end)  As #_of_Airstrikes_on_Schools,

--civilain infursturture

count(case when [Sub-category] = 'Residential area' then 1 else null end)  As #_of_Airstrikes_on_Residential_areas,
count(case when [Sub-category] = 'Private factory' or [Sub-category] = 'factory' then 1 else null end)  As #_of_Airstrikes_on_factories,
count(case when [Sub-category] = 'Water & Electricity' then 1 else null end)  As #_of_Airstrikes_on_Water_Electricity,
count(case when [Sub-category] = 'Communication' then 1 else null end)  As #_of_Airstrikes_on_Communications,
count(case when [Sub-category] = 'Mosque' then 1 else null end)  As #_of_Airstrikes_on_Mosques,
count(case when [Sub-category] = 'Market place' then 1 else null end)  As #_of_Airstrikes_on_Market_place,
count(case when [Sub-category] = 'Vehicle/Bus' then 1 else null end)  As #_of_Airstrikes_on_Vehicles_Bus,
count(case when [Sub-category] = 'Transport' then 1 else null end)  As #_of_Airstrikes_on_Transport


FROM [Conflict data].[dbo].['Yemen Data Project Published Ai$']

Group By Year_1
Order BY Year_1  Asc


Select Year_1, T#_of_Airstrikes,

(T#_of_Airstrikes * 100) / (SELECT sum(T#_of_Airstrikes) FROM Air_Strike_By_Traget1) AS Total_Percentage1,

#_of_Airstrikes_on_Unknown_Tragets,

(#_of_Airstrikes_on_Unknown_Tragets * 100) / sum(Year_1) OVER() AS Total_Percentage1

From Air_Strike_By_Traget1




--Civilian_Casualties



CREATE VIEW Air_Strike_By_Traget_Civilian_Casualties AS
SELECT Year_1, sum([Civilian Casualties]) as T#_Civilian_Casualties,

--Unknown

sum(case when [Sub-category] = 'Unknown' then [Civilian Casualties] else null end)  As #_of_Civilian_Casualties_at_Unknown_Tragets,

-- food production

sum(case when [Sub-category] = 'Farms' then [Civilian Casualties] else null end)  As #_of_Civilian_Casualties_on_Farms,
sum(case when [Sub-category] = 'Food (storage/transportation)' then [Civilian Casualties] else null end)  As #_of_Civilian_Casualties_at_Food,

--medical facailties 

sum(case when [Sub-category] = 'Hospital' then [Civilian Casualties] else null end)  As #_of_Civilian_Casualties_at_Hospitals,
sum(case when [Sub-category] = 'Medical centres' or [Sub-category] = 'Other-Medical' then [Civilian Casualties] else null end)  As #_of_Civilian_Casualties_at_Medical_facailties,
sum(case when [Sub-category] = 'Clinic' then [Civilian Casualties] else null end)  As #_of_Civilian_Casualties_at_Clinics,

--military or war related tragets 

sum(case when [Sub-category] = 'Military Site' or [Sub-category] = 'Other-Military' then [Civilian Casualties] else null end)  As #_of_Civilian_Casualties_at_Military_buildings,
sum(case when [Sub-category] = 'Gov. Compounds' then [Civilian Casualties] else null end)  As #_of_Civilian_Casualties_at_Gov_Compounds,
sum(case when [Sub-category] = 'HQ' then [Civilian Casualties] else null end)  As #_of_Civilian_Casualties_at_HQs,
sum(case when [Sub-category] = 'Checkpoints' then [Civilian Casualties] else null end)  As #_of_Civilian_Casualties_at_Checkpoints,
sum(case when [Sub-category] = 'State resources' then [Civilian Casualties] else null end)  As #_of_Civilian_Casualties_at_State_resources,
sum(case when [Sub-category] = 'Weapon storage' then [Civilian Casualties] else null end)  As #_of_Civilian_Casualties_at_Weapon_storage,
sum(case when [Sub-category] = 'Moving Traget (weapons/figthers)' or [Sub-category] = 'Forces' then [Civilian Casualties] else null end)  As #_of_Civilian_Casualties_at_Forces,

--education facailties 

sum(case when [Sub-category] = 'University' then [Civilian Casualties] else null end)  As #_of_Civilian_Casualties_at_Universities,
sum(case when [Sub-category] = 'School' or [Sub-category] = 'Other-Educational' then [Civilian Casualties] else null end)  As #_of_Civilian_Casualties_at_Schools,

--civilain infursturture

sum(case when [Sub-category] = 'Residential area' then [Civilian Casualties] else null end)  As #_of_Civilian_Casualties_in_Residential_areas,
sum(case when [Sub-category] = 'Private factory' or [Sub-category] = 'factory' then [Civilian Casualties] else null end)  As #_of_Civilian_Casualties_at_factories,
sum(case when [Sub-category] = 'Water & Electricity' then [Civilian Casualties] else null end)  As #_of_Civilian_Casualties_at_Water_Electricity,
sum(case when [Sub-category] = 'Communication' then [Civilian Casualties] else null end)  As #_of_Civilian_Casualties_at_Communications,
sum(case when [Sub-category] = 'Mosque' then [Civilian Casualties] else null end)  As #_of_Civilian_Casualties_on_Mosques,
sum(case when [Sub-category] = 'Market place' then [Civilian Casualties] else null end)  As #_of_Civilian_Casualties_at_Market_place,
sum(case when [Sub-category] = 'Vehicle/Bus' then [Civilian Casualties] else null end)  As #_of_Civilian_Casualties_in_Vehicles_Bus,
sum(case when [Sub-category] = 'Transport' then [Civilian Casualties] else null end)  As #_of_Civilian_Casualties_at_Transport
FROM [Conflict data].[dbo].['Yemen Data Project Published Ai$']

Group By Year_1
Order BY Year_1  Asc




--Total_Fatalities

CREATE VIEW Air_Strike_By_Traget_Total_Fatalities AS
SELECT Year_1, sum(Fatalities) as Total_Fatalities,

--Unknown

sum(case when [Sub-category] = 'Unknown' then Fatalities else null end)  As #_of_Fatalities_at_Unknown_Tragets,

-- food production

sum(case when [Sub-category] = 'Farms' then Fatalities else null end)  As #_of_Fatalities_on_Farms,
sum(case when [Sub-category] = 'Food (storage/transportation)' then Fatalities else null end)  As #_of_Fatalities_at_Food,

--medical facailties 

sum(case when [Sub-category] = 'Hospital' then Fatalities else null end)  As #_of_Fatalities_at_Hospitals,
sum(case when [Sub-category] = 'Medical centres' or [Sub-category] = 'Other-Medical' then Fatalities else null end)  As #_of_Fatalities_at_Medical_facailties,
sum(case when [Sub-category] = 'Clinic' then Fatalities else null end)  As #_of_Fatalities_at_Clinics,

--military or war related tragets 

sum(case when [Sub-category] = 'Military Site' or [Sub-category] = 'Other-Military' then Fatalities else null end)  As #_of_Fatalities_at_Military_buildings,
sum(case when [Sub-category] = 'Gov. Compounds' then Fatalities else null end)  As #_of_Fatalities_at_Gov_Compounds,
sum(case when [Sub-category] = 'HQ' then Fatalities else null end)  As #_of_Fatalities_at_HQs,
sum(case when [Sub-category] = 'Checkpoints' then Fatalities else null end)  As #_of_Fatalities_at_Checkpoints,
sum(case when [Sub-category] = 'State resources' then Fatalities else null end)  As #_of_Fatalities_at_State_resources,
sum(case when [Sub-category] = 'Weapon storage' then Fatalities else null end)  As #_of_Fatalities_at_Weapon_storage,
sum(case when [Sub-category] = 'Moving Traget (weapons/figthers)' or [Sub-category] = 'Forces' then Fatalities else null end)  As #_of_Fatalities_at_Forces,

--education facailties 

sum(case when [Sub-category] = 'University' then Fatalities else null end)  As #_of_Fatalities_at_Universities,
sum(case when [Sub-category] = 'School' or [Sub-category] = 'Other-Educational' then Fatalities else null end)  As #_of_Fatalities_at_Schools,

--civilain infursturture

sum(case when [Sub-category] = 'Residential area' then Fatalities else null end)  As #_of_Fatalities_in_Residential_areas,
sum(case when [Sub-category] = 'Private factory' or [Sub-category] = 'factory' then Fatalities else null end)  As #_of_Fatalities_at_factories,
sum(case when [Sub-category] = 'Water & Electricity' then Fatalities else null end)  As #_of_Fatalities_at_Water_Electricity,
sum(case when [Sub-category] = 'Communication' then Fatalities else null end)  As #_of_Fatalities_at_Communications,
sum(case when [Sub-category] = 'Mosque' then Fatalities else null end)  As #_of_Fatalities_on_Mosques,
sum(case when [Sub-category] = 'Market place' then Fatalities else null end)  As #_of_Fatalities_at_Market_place,
sum(case when [Sub-category] = 'Vehicle/Bus' then Fatalities else null end)  As #_of_Fatalities_in_Vehicles_Bus,
sum(case when [Sub-category] = 'Transport' then Fatalities else null end)  As #_of_Fatalities_at_Transport
FROM [Conflict data].[dbo].['Yemen Data Project Published Ai$']

Group By Year_1
Order BY Year_1  Asc





---Woman_fatalities,




CREATE VIEW Air_Strike_By_Traget_Woman_fatalities AS
SELECT Year_1, sum(Fatalities) as Total_Fatalities, sum([Woman fatalities]) as Woman_fatalities,

--Unknown

sum(case when [Sub-category] = 'Unknown' then [Woman fatalities] else null end)  As #_of_Woman_fatalities_at_Unknown_Tragets,

-- food production

sum(case when [Sub-category] = 'Farms' then [Woman fatalities] else null end)  As #_of_Woman_fatalities_on_Farms,
sum(case when [Sub-category] = 'Food (storage/transportation)' then [Woman fatalities] else null end)  As #_of_Woman_fatalities_at_Food,

--medical facailties 

sum(case when [Sub-category] = 'Hospital' then [Woman fatalities] else null end)  As #_of_Woman_fatalities_at_Hospitals,
sum(case when [Sub-category] = 'Medical centres' or [Sub-category] = 'Other-Medical' then [Woman fatalities] else null end)  As #_of_Woman_fatalities_at_Medical_facailties,
sum(case when [Sub-category] = 'Clinic' then [Woman fatalities] else null end)  As #_of_Woman_fatalities_at_Clinics,

--military or war related tragets 

sum(case when [Sub-category] = 'Military Site' or [Sub-category] = 'Other-Military' then [Woman fatalities] else null end)  As #_of_Woman_fatalities_at_Military_buildings,
sum(case when [Sub-category] = 'Gov. Compounds' then [Woman fatalities] else null end)  As #_of_Woman_fatalities_at_Gov_Compounds,
sum(case when [Sub-category] = 'HQ' then [Woman fatalities] else null end)  As #_of_Woman_fatalities_at_HQs,
sum(case when [Sub-category] = 'Checkpoints' then [Woman fatalities] else null end)  As #_of_Woman_fatalities_at_Checkpoints,
sum(case when [Sub-category] = 'State resources' then [Woman fatalities] else null end)  As #_of_Woman_fatalities_at_State_resources,
sum(case when [Sub-category] = 'Weapon storage' then [Woman fatalities] else null end)  As #_of_Woman_fatalities_at_Weapon_storage,
sum(case when [Sub-category] = 'Moving Traget (weapons/figthers)' or [Sub-category] = 'Forces' then [Woman fatalities] else null end)  As #_of_Woman_fatalities_at_Forces,

--education facailties 

sum(case when [Sub-category] = 'University' then [Woman fatalities] else null end)  As #_of_Woman_fatalities_at_Universities,
sum(case when [Sub-category] = 'School' or [Sub-category] = 'Other-Educational' then [Woman fatalities] else null end)  As #_of_Woman_fatalities_at_Schools,

--civilain infursturture

sum(case when [Sub-category] = 'Residential area' then [Woman fatalities] else null end)  As #_of_Woman_fatalities_in_Residential_areas,
sum(case when [Sub-category] = 'Private factory' or [Sub-category] = 'factory' then [Woman fatalities] else null end)  As #_of_Woman_fatalities_at_factories,
sum(case when [Sub-category] = 'Water & Electricity' then [Woman fatalities] else null end)  As #_of_Woman_fatalities_at_Water_Electricity,
sum(case when [Sub-category] = 'Communication' then [Woman fatalities] else null end)  As #_of_Woman_fatalities_at_Communications,
sum(case when [Sub-category] = 'Mosque' then [Woman fatalities] else null end)  As #_of_Woman_fatalities_on_Mosques,
sum(case when [Sub-category] = 'Market place' then [Woman fatalities] else null end)  As #_of_Woman_fatalitiesat_Market_place,
sum(case when [Sub-category] = 'Vehicle/Bus' then [Woman fatalities] else null end)  As #_of_Woman_fatalities_in_Vehicles_Bus,
sum(case when [Sub-category] = 'Transport' then [Woman fatalities] else null end)  As #_of_Woman_fatalities_at_Transport
FROM [Conflict data].[dbo].['Yemen Data Project Published Ai$']

Group By Year_1
Order BY Year_1  Asc





-- Child_fatalities



CREATE VIEW Air_Strike_By_Traget_Child_fatalities AS
SELECT Year_1, sum(Fatalities) as Total_Fatalities, sum([Child fatalities]) as Child_fatalities,

--Unknown

sum(case when [Sub-category] = 'Unknown' then [Child fatalities] else null end)  As #_of_Child_fatalities_at_Unknown_Tragets,

-- food production

sum(case when [Sub-category] = 'Farms' then [Child fatalities] else null end)  As #_of_Child_fatalities_on_Farms,
sum(case when [Sub-category] = 'Food (storage/transportation)' then Fatalities else null end)  As #_of_Child_fatalities_at_Food,

--medical facailties 

sum(case when [Sub-category] = 'Hospital' then [Child fatalities] else null end)  As #_of_Child_fatalities_at_Hospitals,
sum(case when [Sub-category] = 'Medical centres' or [Sub-category] = 'Other-Medical' then [Child fatalities] else null end)  As #_of_Child_fatalities_at_Medical_facailties,
sum(case when [Sub-category] = 'Clinic' then [Child fatalities] else null end)  As #_of_Child_fatalities_at_Clinics,

--military or war related tragets 

sum(case when [Sub-category] = 'Military Site' or [Sub-category] = 'Other-Military' then [Child fatalities] else null end)  As #_of_Child_fatalities_at_Military_buildings,
sum(case when [Sub-category] = 'Gov. Compounds' then [Child fatalities] else null end)  As #_of_Child_fatalities_at_Gov_Compounds,
sum(case when [Sub-category] = 'HQ' then [Child fatalities] else null end)  As #_of_Child_fatalities_at_HQs,
sum(case when [Sub-category] = 'Checkpoints' then [Child fatalities] else null end)  As #_of_Child_fatalities_at_Checkpoints,
sum(case when [Sub-category] = 'State resources' then [Child fatalities] else null end)  As #_of_Child_fatalities_at_State_resources,
sum(case when [Sub-category] = 'Weapon storage' then [Child fatalities] else null end)  As #_of_Child_fatalities_at_Weapon_storage,
sum(case when [Sub-category] = 'Moving Traget (weapons/figthers)' or [Sub-category] = 'Forces' then [Child fatalities] else null end)  As #_of_Child_fatalities_at_Forces,

--education facailties 

sum(case when [Sub-category] = 'University' then [Child fatalities] else null end)  As #_of_Child_fatalities_at_Universities,
sum(case when [Sub-category] = 'School' or [Sub-category] = 'Other-Educational' then [Child fatalities] else null end)  As #_of_Child_fatalities_at_Schools,

--civilain infursturture

sum(case when [Sub-category] = 'Residential area' then [Child fatalities] else null end)  As #_of_Child_fatalities_in_Residential_areas,
sum(case when [Sub-category] = 'Private factory' or [Sub-category] = 'factory' then [Child fatalities] else null end)  As #_of_Child_fatalities_at_factories,
sum(case when [Sub-category] = 'Water & Electricity' then [Child fatalities] else null end)  As #_of_Child_fatalities_at_Water_Electricity,
sum(case when [Sub-category] = 'Communication' then [Child fatalities] else null end)  As #_of_Child_fatalities_at_Communications,
sum(case when [Sub-category] = 'Mosque' then [Child fatalities] else null end)  As #_of_Child_fatalities_on_Mosques,
sum(case when [Sub-category] = 'Market place' then [Child fatalities] else null end)  As #_of_Child_fatalities_at_Market_place,
sum(case when [Sub-category] = 'Vehicle/Bus' then [Child fatalities] else null end)  As #_of_Child_fatalities_in_Vehicles_Bus,
sum(case when [Sub-category] = 'Transport' then [Child fatalities] else null end)  As #_of_Child_fatalitiesat_Transport
FROM [Conflict data].[dbo].['Yemen Data Project Published Ai$']

Group By Year_1
Order BY Year_1  Asc
