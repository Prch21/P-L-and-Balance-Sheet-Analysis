-- Main query
Select  
  Report, 
  Class, 
  SubClass, 
  SubClass2, 
  Account, 
  SubAccount, 
  [2018], [2019], [2020]

---Creating Subquery and Adding Table1
from 
(
Select DISTINCT YEAR(Date) as YEAR,  
  Report, 
  Class, 
  SubClass, 
  SubClass2, 
  Account, 
  SubAccount,
 SUM(Amount) OVER (PARTITION by  SubAccount Order by Year(Date) ) as Amount

from GL
JOIN 
  COA 
  ON GL.Account_key = COA.Account_key
JOIN 
  Territory 
  ON GL.Territory_key = Territory.Territory_key

  Where Report = 'Balance Sheet' 
  ) 
  as Table1

-- Pivoting for year 
PIVOT (SUM(Amount) FOR YEAR IN([2018], [2019], [2020]) ) as Table2

Order by Class, SubClass, SubClass2, Account, SubAccount
;
