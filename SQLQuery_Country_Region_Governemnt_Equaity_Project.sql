

--Data flitering

SELECT [Code],[Name],[Region],[LifeExpectancy],[GNP],[GovernmentForm],COUNT([Language]) as Number_of_Language
FROM [SQL class].[dbo].['country(1)$']
INNER JOIN [SQL class].[dbo].[countrylanguage$] ON [Code]=[CountryCode]
GROUP BY [Code],[Name], [Region],[LifeExpectancy],[GNP],[GovernmentForm],[CountryCode]
ORDER BY COUNT([Language]) DESC;



SELECT [CountryCode],[Language],[Percentage],[IsOfficial]
FROM [SQL class].[dbo].['country(1)$']
INNER JOIN [SQL class].[dbo].[countrylanguage$] ON [Code]=[CountryCode]
WHERE [Percentage] > 50 ;



SELECT [Country],[Year], [Gini index]
FROM [SQL class].[dbo].[economic-inequality-gini-index]
WHERE [Year] LIKE '%2014%';


SELECT [Entity],[Code],[Year],[Expense (% of GDP)]
FROM [SQL class].[dbo].[total-gov-expenditure-gdp-wdi]
WHERE [Code] <> '' AND [Year] LIKE '%2014%';


-- Making temp tables for futher caluations 

Create TABLE #Temp_6 (
Code varchar(100),
Name varchar(100),
Region varchar(100),
LifeExpectancy Float,
GNP float,
GovernmentForm varchar(100),
Number_of_Language int,
)


INSERT INTO #Temp_6
SELECT [Code],[Name],[Region],[LifeExpectancy],[GNP],[GovernmentForm],COUNT([Language]) as Number_of_Language
FROM [SQL class].[dbo].['country(1)$']
INNER JOIN [SQL class].[dbo].[countrylanguage$] ON [Code]=[CountryCode]
GROUP BY [Code],[Name], [Region],[LifeExpectancy],[GNP],[GovernmentForm],[CountryCode]



Create TABLE #Temp_5 (
CountryCode varchar(100),
Language varchar(100),
Percentage float,
IsOfficial varchar (100),
)

INSERT INTO #Temp_5
SELECT [Name],[Language],[Percentage],[IsOfficial]
FROM [SQL class].[dbo].['country(1)$']
INNER JOIN [SQL class].[dbo].[countrylanguage$] ON [Code]=[CountryCode]
WHERE [Percentage] > 50 ;


Create TABLE #Temp_7 (
Country varchar(100),
Year varchar(100),
Gini_index float,
)

INSERT INTO #Temp_7
SELECT [Country],[Year], [Gini index]
FROM [SQL class].[dbo].[economic-inequality-gini-index]
WHERE [Year] LIKE '%2014%';


Create TABLE #Temp_8 (
Entity varchar(100),
Code varchar(100),
Year varchar (100),
Expense_precent_of_GDP float,
)


INSERT INTO #Temp_8
SELECT [Entity],[Code],[Year],[Expense (% of GDP)]
FROM [SQL class].[dbo].[total-gov-expenditure-gdp-wdi]
WHERE [Code] <> '' AND [Year] LIKE '%2014%';


--- Caluations for anwersing the RQ

SELECT [Region], SUM([LifeExpectancy])/COUNT([Region]) AS AVG_LifeExpectancy, SUM(Number_of_Language)/COUNT([Region]) As AVG_Number_of_Langaugues, 
SUM(Gini_index)/COUNT([Region]) AS AVG_Gini_index, SUM(Expense_precent_of_GDP)/COUNT([Region]) AS _AVG_Expense_Precentage_of_GDP 
FROM #Temp_6 
JOIN #Temp_5  ON [Code]=[CountryCode] 
JOIN #Temp_7  ON [Name]=[Country] 
JOIN #Temp_8  ON [Name]=[Entity] 
WHERE [LifeExpectancy] IS Not Null
GROUP BY [Region]


SELECT [Region], SUM([LifeExpectancy])/COUNT([Region]) AS AVG_LifeExpectancy, SUM(Number_of_Language)/COUNT([Region]) As AVG_Number_of_Langaugues, 
SUM(Gini_index)/COUNT([Region]) AS AVG_Gini_index, SUM(Expense_precent_of_GDP)/COUNT([Region]) AS _AVG_Expense_Precentage_of_GDP 
FROM #Temp_6 
JOIN #Temp_5  ON [Code]=[CountryCode] 
JOIN #Temp_7  ON [Name]=[Country] 
JOIN #Temp_8  ON [Name]=[Entity] 
WHERE [LifeExpectancy] IS Not Null
GROUP BY [Region]


SELECT [GovernmentForm], Count([GovernmentForm]) AS Number_of_Gov, SUM([LifeExpectancy])/COUNT([GovernmentForm]) AS AVG_LifeExpectancy, SUM(Number_of_Language)/COUNT([GovernmentForm]) As AVG_Number_of_Langaugues, 
SUM(Gini_index)/COUNT([GovernmentForm]) AS AVG_Gini_index, SUM(Expense_precent_of_GDP)/COUNT([GovernmentForm]) AS _AVG_Expense_Precentage_of_GDP 
FROM #Temp_6 
JOIN #Temp_5  ON [Code]=[CountryCode] 
JOIN #Temp_7  ON [Name]=[Country] 
JOIN #Temp_8  ON [Name]=[Entity] 
WHERE [LifeExpectancy] IS Not Null
GROUP BY [GovernmentForm]



--- Placing data and Caluations into views for export to make visualsations 


CREATE VIEW View_5 AS
SELECT [Code],[Name],[Region],[LifeExpectancy],[GNP],[GovernmentForm],COUNT([Language]) as Number_of_Language
FROM [SQL class].[dbo].['country(1)$']
INNER JOIN [SQL class].[dbo].[countrylanguage$] ON [Code]=[CountryCode]
GROUP BY [Code],[Name], [Region],[LifeExpectancy],[GNP],[GovernmentForm],[CountryCode]
;

CREATE VIEW View_6 AS
SELECT [CountryCode],[Language],[Percentage],[IsOfficial]
FROM [SQL class].[dbo].[countrylanguage$]
WHERE [Percentage] > 50 ;



CREATE VIEW View_7 AS
SELECT [Country],[Year], [Gini index]
FROM [SQL class].[dbo].[economic-inequality-gini-index]
WHERE [Year] LIKE '%2014%';

CREATE VIEW View_8 AS
SELECT [Entity],[Code],[Year],[Expense (% of GDP)]
FROM [SQL class].[dbo].[total-gov-expenditure-gdp-wdi]
WHERE [Code] <> '' AND [Year] LIKE '%2014%';


CREATE VIEW Countries_Data_1 AS
SELECT [Name],[LifeExpectancy],[Language], Number_of_Language, CONVERT(float,[Gini index]) AS Gini_index, CONVERT(float,[Expense (% of GDP)]) AS Expense_Precent_of_GDP 
FROM View_5 
JOIN View_6  ON [Code]=[CountryCode] 
JOIN View_7  ON [Name]=[Country] 
JOIN View_8  ON [Name]=[Entity] 


CREATE VIEW [Regions_Data] AS
SELECT [Region], SUM([LifeExpectancy])/COUNT([Region]) AS AVG_LifeExpectancy, SUM(Number_of_Language)/COUNT([Region]) As AVG_Number_of_Langaugues, 
SUM(CONVERT(float,[Gini index]))/COUNT([Region]) AS AVG_Gini_index, SUM(CONVERT(float,[Expense (% of GDP)]))/COUNT([Region]) AS _AVG_Expense_Precentage_of_GDP 
FROM View_5 
JOIN View_6  ON [Code]=[CountryCode] 
JOIN View_7  ON [Name]=[Country] 
JOIN View_8  ON [Name]=[Entity] 
WHERE [LifeExpectancy] IS Not Null
GROUP BY [Region]


CREATE VIEW [Government_types_Data] AS
SELECT [GovernmentForm], Count([GovernmentForm]) AS Number_of_Gov, SUM([LifeExpectancy])/COUNT([GovernmentForm]) AS AVG_LifeExpectancy, SUM(Number_of_Language)/COUNT([GovernmentForm]) As AVG_Number_of_Langaugues, 
SUM(CONVERT(float,[Gini index]))/COUNT([GovernmentForm]) AS AVG_Gini_index, SUM(CONVERT(float,[Expense (% of GDP)]))/COUNT([GovernmentForm]) AS _AVG_Expense_Precentage_of_GDP 
FROM View_5 
JOIN View_6  ON [Code]=[CountryCode] 
JOIN View_7  ON [Name]=[Country] 
JOIN View_8  ON [Name]=[Entity] 
WHERE [LifeExpectancy] IS Not Null
GROUP BY [GovernmentForm]

