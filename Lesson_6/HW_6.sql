-- 3.	�������� ������ � ����������� ��� ���������� �������� NationalIDNumber � ������� HumanResources.Employee ��� ���������� BusinessEntityID.
--      �.�. ������� ����� ���������� 2 ��������: BusinessEntityID (��� ���� �������� ������) � NationalIDNumber (�� ����� �������� ��������).
--      � ������� ������� ������� ���������� �������� NationalIDNumber �� 879341111 ��� BusinessEntityID= 15.



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
