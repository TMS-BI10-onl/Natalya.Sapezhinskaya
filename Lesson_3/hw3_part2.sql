-- 1. Объеденить адрес и город в таблице [Person].[Address], вывести информацию одной строкой

SELECT CONCAT (AddressLine1,AddressLine2, City,PostalCode) as FullAddress
FROM AdventureWorks2017.Person.Address

-- 2. Найти StandardCost округленный до целого в таблице [ProductCostHistory]

SELECT DISTINCT ROUND (StandardCost,0) 
FROM AdventureWorks2017.Production.ProductCostHistory

-- 3. Вывести имя продукта в верхнем регистре

SELECT UPPER (Name) as UPPER_Name
FROM AdventureWorks2017.Production.ProductModel

-- 4. Вывести количество символов в описании продукта 

SELECT ProductDescriptionID, LEN (Description) as Lengh
FROM AdventureWorks2017.Production.ProductDescription

-- 5. Найти продукты, которые начали продавать в мае

SELECT Name
FROM AdventureWorks2017.Production.Product
WHERE MONTH(SellStartDate)= 5

-- 6. Вывести имя в обратном порядке

SELECT FirstName, REVERSE (FirstName) as ReverseFN
FROM AdventureWorks2017.Person.Person

-- 7. Найти возраст работников в годах

SELECT *,
DATEDIFF (YEAR, BirthDate, SYSDATETIME()) as AGE
FROM AdventureWorks2017.HumanResources.Employee

-- 8. Определить имя без пробелов 
SELECT Name, LTRIM (RTRIM (Name))
FROM AdventureWorks2017.Production.Product

--9. Определить средний StandardCost
 
SELECT FLOOR (AVG (StandardCost)) as AVG_StandardCost
FROM AdventureWorks2017.Production.Product

-- 10. Найти определен ли цвет для продукта

SELECT Name, IIF (Color is NULL, 'without color', Color) as AvalibleColor
FROM AdventureWorks2017.Production.Product

-- 11. Преобразовать e-mail адрес без @adventure-works.com

SELECT Replace (EmailAddress, '@adventure-works.com' ,'') as EmailUserName
FROM AdventureWorks2017.Person.EmailAddress

--  12. Преобразовать дату начала действия спец.предложения в формат YYYY-MM-DD

SELECT
CONVERT (date, StartDate, 103) as ConvertStartDate  
FROM AdventureWorks2017.Sales.SpecialOffer

-- 13. Определить сотрудников мужского пола, которые были на больничном меньше 25 часов, 25-40, больше 40 часов.

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

-- 14. Указать номер телефона в новом формате

SELECT Translate(PhoneNumber, '( )' , '- -')
FROM AdventureWorks2017.Person.PersonPhone

-- 15. Посчитать количество специальных предложений, завершенных на конец месяца

SELECT EOMONTH (EndDate), COUNT (1)
FROM AdventureWorks2017.Sales.SpecialOffer
GROUP BY EOMONTH (EndDate)
ORDER BY COUNT (1)