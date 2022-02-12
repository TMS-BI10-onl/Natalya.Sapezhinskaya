/* 6.¬ базе данных AdventureWorks2017 создать таблицу Patients дл€ ведени€ наблюдений за температурой пациентов больницы. “аблица должна содержать пол€: 
ID Ц числовое поле. јвто заполн€етс€. 
FirstName Ц им€ пациента. 
LastName Ц фамили€ пациента. 
SSN Ц уникальный идентификатор пациента. 
Email Ц электронна€ почта пациента. ‘ормируетс€ по следующему правилу: перва€ больша€ буква FirstName + маленькие 3 буквы LastName + @mail.com (например, Akli@mail.com). ѕолезна€ ссылка здесь.  
Temp Ц температура пациента. 
CreatedDate Ч дата измерений.*/

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


/*7.ƒобавить в таблицу несколько произвольных записей.  */

INSERT INTO dbo.Patients (FirstName,LastName, Temp, CreatedDate)
VALUES
('Ivan','Petrov','36.6','2018-01-01'),
('Natalya','Sidorova','36.9','2019-06-09'),
('Maria','Sheyko','37.2','2020-11-23'),
('Pavel','Krezo','38.9','2021-08-15'),
('Konstantin','Frolov','39.0','2022-01-07')

--SELECT*FROM Patients

/*8.ƒобавить поле TempType со следующими значени€ми С< 0∞CТ,  С> 0∞CТ на основе значений из пол€ Temp ( используйте ALTER TABLE ADD column AS ). ѕосмотрите на данные, которые получились. */

ALTER TABLE Patients
ADD TempType AS 
(CASE 
      WHEN Temp>=0 THEN '>0' 
      WHEN Temp<0 THEN '<0' 
	  END)
ALTER TABLE Patients
DROP Column TempType

/*9.—оздать представление Patients_v, показывающее температуру в градусах ‘аренгейта (∞F = ∞Cx9/5 + 32) */

CREATE VIEW Patients_v AS
SELECT ID, FirstName,LastName,SSN,Email, Temp*9/5+32 as TempF, CreatedDate
FROM Patients

-- SELECT* FROM Patients_v

/*10. —оздать функцию, котора€ возвращает температуру в градусах ‘аренгейта, при подаче на вход градусы в ÷ельси€х. */

CREATE FUNCTION dbo.TempF (@TempF numeric (3,1))
RETURNS numeric (3,1) 
AS
BEGIN
RETURN 	@TempF*9/5+32
END

SELECT dbo.tempF (36.6) as TempFResult

/*11.ѕерепишите решение задачи g из прошлого дз с использованием переменной, максимально упроща€ select. */

DECLARE @date DATETIME
SET @date = DATEPART (dd,GETDATE())
SELECT 
CASE WHEN DATEPART(DW, DATEADD(DAY, 1, EOMONTH(GETDATE(), -1)))<=5 
        THEN DATEADD(DAY, 1, EOMONTH(GETDATE(), -1))
    ELSE DATEADD(DAY, (7-DATEPART(DW, DATEADD(DAY, 1, EOMONTH(GETDATE(), -1)))+1), DATEADD(DAY, 1, EOMONTH(GETDATE(), -1))) 
END FirstWorkingDay	

