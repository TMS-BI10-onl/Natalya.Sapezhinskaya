-- 1. ���������� ����� � ����� � ������� [Person].[Address], ������� ���������� ����� �������

SELECT CONCAT (AddressLine1,AddressLine2, City,PostalCode) as FullAddress
FROM AdventureWorks2017.Person.Address

-- 2. ����� StandardCost ����������� �� ������ � ������� [ProductCostHistory]

SELECT DISTINCT ROUND (StandardCost,0) 
FROM AdventureWorks2017.Production.ProductCostHistory

-- 3. ������� ��� �������� � ������� ��������

SELECT UPPER (Name) as UPPER_Name
FROM AdventureWorks2017.Production.ProductModel

-- 4. ������� ���������� �������� � �������� �������� 

SELECT ProductDescriptionID, LEN (Description) as Lengh
FROM AdventureWorks2017.Production.ProductDescription

-- 5. ����� ��������, ������� ������ ��������� � ���

SELECT Name
FROM AdventureWorks2017.Production.Product
WHERE MONTH(SellStartDate)= 5

-- 6. ������� ��� � �������� �������

SELECT FirstName, REVERSE (FirstName) as ReverseFN
FROM AdventureWorks2017.Person.Person

-- 7. ����� ������� ���������� � �����

SELECT *,
DATEDIFF (YEAR, BirthDate, SYSDATETIME()) as AGE
FROM AdventureWorks2017.HumanResources.Employee

-- 8. ���������� ��� ��� �������� 
SELECT Name, LTRIM (RTRIM (Name))
FROM AdventureWorks2017.Production.Product

--9. ���������� ������� StandardCost
 
SELECT FLOOR (AVG (StandardCost)) as AVG_StandardCost
FROM AdventureWorks2017.Production.Product

-- 10. ����� ��������� �� ���� ��� ��������

SELECT Name, IIF (Color is NULL, 'without color', Color) as AvalibleColor
FROM AdventureWorks2017.Production.Product

-- 11. ������������� e-mail ����� ��� @adventure-works.com

SELECT Replace (EmailAddress, '@adventure-works.com' ,'') as EmailUserName
FROM AdventureWorks2017.Person.EmailAddress

--  12. ������������� ���� ������ �������� ����.����������� � ������ YYYY-MM-DD

SELECT
CONVERT (date, StartDate, 103) as ConvertStartDate  
FROM AdventureWorks2017.Sales.SpecialOffer

-- 13. ���������� ����������� �������� ����, ������� ���� �� ���������� ������ 25 �����, 25-40, ������ 40 �����.

SELECT  DISTINCT SickLeaveHours, JobTitle,
CASE WHEN SickLeaveHours<25
     THEN 'Less then 25 hours'
	 WHEN SickLeaveHours between 25 and 40
	 THEN '25-40 hours'
	 WHEN SickLeaveHours>40
	 THEN 'More then 40 hours'
	 END SickLeaveCategory
FROM AdventureWorks2017.HumanResources.Employee
WHERE Gender='M'

-- 14. ������� ����� �������� � ����� �������

SELECT Translate(PhoneNumber, '( )' , '- -')
FROM AdventureWorks2017.Person.PersonPhone

-- 15. ��������� ���������� ����������� �����������, ����������� �� ����� ������

SELECT EOMONTH (EndDate), COUNT (1)
FROM AdventureWorks2017.Sales.SpecialOffer
GROUP BY EOMONTH (EndDate)
ORDER BY COUNT (1)