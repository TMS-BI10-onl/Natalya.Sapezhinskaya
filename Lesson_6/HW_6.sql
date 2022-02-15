-- 3.	Создайте объект с параметрами для обновления значения NationalIDNumber в таблице HumanResources.Employee для указанного BusinessEntityID.
--      Т.е. объекту будет подаваться 2 значения: BusinessEntityID (для кого изменяем данные) и NationalIDNumber (на какое значение изменяем).
--      С помощью данного объекта попробуйте заменить NationalIDNumber на 879341111 для BusinessEntityID= 15.



CREATE PROCEDURE dbo.UpDatedIDNumber
@NationalIDNumber NVARCHAR(40),
@BusinessEntityID INT
AS
UPDATE HumanResources.Employee
SET NationalIDNumber=@NationalIDNumber
WHERE BusinessEntityID = @BusinessEntityID


EXECUTE UpDatedIDNumber @NationalIDNumber='879341111', @BusinessEntityID= '15'

SELECT NationalIDNumber,BusinessEntityID
FROM AdventureWorks2017.HumanResources.Employee
WHERE BusinessEntityID =15
