--Main Query
Select 
Country, 
Report, 
Class, 
Account, 
FORMAT([2018], 'N0') as '2018', FORMAT([2019], 'N0') as '2019', FORMAT([2020], 'N0') as '2020'

--Adding Subquery and Adding Table1  
FROM 
(
Select Country, GL.Account_key, Report, Class, Account, YEAR(Date) as Year, SUM(Amount) as Amount from GL
JOIN 
COA 
ON GL.Account_key = COA.Account_key

JOIN 
Territory 
ON GL.Territory_key = Territory.Territory_key

Where Report = 'Profit and Loss'
Group by Country, Report, Class, Account, GL.Account_key, 
YEAR(Date)
) 
as Table1

-- Using Pivot
PIVOT
( SUM(Amount) FOR Year IN ([2018], [2019], [2020])) as Table2
;
