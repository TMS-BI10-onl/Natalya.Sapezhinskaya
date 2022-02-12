/* 6.� ���� ������ AdventureWorks2017 ������� ������� Patients ��� ������� ���������� �� ������������ ��������� ��������. ������� ������ ��������� ����: 
ID � �������� ����. ���� �����������. 
FirstName � ��� ��������. 
LastName � ������� ��������. 
SSN � ���������� ������������� ��������. 
Email � ����������� ����� ��������. ����������� �� ���������� �������: ������ ������� ����� FirstName + ��������� 3 ����� LastName + @mail.com (��������, Akli@mail.com). �������� ������ �����.  
Temp � ����������� ��������. 
CreatedDate � ���� ���������.*/

CREATE TABLE Patients
(
ID        int IDENTITY (1,1),
FirstName NVARCHAR(70),
LastName  NVARCHAR(100),
SSN        uniqueidentifier DEFAULT NEWID(),
Email     AS CONCAT(UPPER(LEFT(FirstName,1)),LOWER(LEFT(LastName,3)),'@mail.com'),
Temp      numeric (3,1) CHECK (Temp <45),
CreatedDate DATE
)

SELECT*FROM Patients


/*7.�������� � ������� ��������� ������������ �������.  */

INSERT INTO dbo.Patients (FirstName,LastName, Temp, CreatedDate)
VALUES
('Ivan','Petrov','36.6','2018-01-01'),
('Natalya','Sidorova','36.9','2019-06-09'),
('Maria','Sheyko','37.2','2020-11-23'),
('Pavel','Krezo','38.9','2021-08-15'),
('Konstantin','Frolov','39.0','2022-01-07')

--SELECT*FROM Patients

/*8.�������� ���� TempType �� ���������� ���������� �< 0�C�,  �> 0�C� �� ������ �������� �� ���� Temp ( ����������� ALTER TABLE ADD column AS ). ���������� �� ������, ������� ����������. */

ALTER TABLE Patients
ADD TempType AS 
(CASE 
      WHEN Temp>=0 THEN '>0' 
      WHEN Temp<0 THEN '<0' 
	  END)
ALTER TABLE Patients
DROP Column TempType

/*9.������� ������������� Patients_v, ������������ ����������� � �������� ���������� (�F = �Cx9/5 + 32) */

CREATE VIEW Patients_v AS
SELECT ID, FirstName,LastName,SSN,Email, Temp*9/5+32 as TempF, CreatedDate
FROM Patients

-- SELECT* FROM Patients_v

/*10. ������� �������, ������� ���������� ����������� � �������� ����������, ��� ������ �� ���� ������� � ��������. */

CREATE FUNCTION dbo.TempF (@TempF numeric (3,1))
RETURNS numeric (3,1) 
AS
BEGIN
RETURN 	@TempF*9/5+32
END

SELECT dbo.tempF (36.6) as TempFResult

/*11.���������� ������� ������ g �� �������� �� � �������������� ����������, ����������� ������� select. */

DECLARE @date DATETIME
SET @date = DATEPART (dd,GETDATE())
SELECT 
CASE WHEN DATEPART(DW, DATEADD(DAY, 1, EOMONTH(GETDATE(), -1)))<=5 
        THEN DATEADD(DAY, 1, EOMONTH(GETDATE(), -1))
    ELSE DATEADD(DAY, (7-DATEPART(DW, DATEADD(DAY, 1, EOMONTH(GETDATE(), -1)))+1), DATEADD(DAY, 1, EOMONTH(GETDATE(), -1))) 
END FirstWorkingDay	

