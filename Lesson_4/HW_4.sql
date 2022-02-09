/*3.��� ����� ��������� ������� ������� Row Number, Rank � Dense Rank ������ ���������� ���������?*/

-- ���� �������� � ������� ����� �����������

/*4.������� ������ � ������� Production.UnitMeasure. 
���������, ���� �� ����� UnitMeasureCode, ������������ �� ����� �Ғ. ������� ����� ��������� ����� ����� ����? */

SELECT UnitMeasureCode as TCode 
FROM AdventureWorks2017.Production.UnitMeasure
WHERE UnitMeasureCode LIKE 'T%'

SELECT COUNT(UnitMeasureCode) as Unit_Code_count
FROM AdventureWorks2017.Production.UnitMeasure

---��� (���� ����� ������� ����� 1 ������)---

SELECT DISTINCT UnitT =
CASE WHEN UnitMeasureCode LIKE 'T%'
     THEN COUNT(UnitMeasureCode)
	 ELSE 0
	 END,
UnitCount= COUNT(UnitMeasureCode) OVER ()
FROM AdventureWorks2017.Production.UnitMeasure
GROUP BY UnitMeasureCode

/*�������� ��������� ����� ������ � �������: 
TT1, Test 1, 9 �������� 2020 
TT2, Test 2, getdate() */

INSERT INTO AdventureWorks2017.Production.UnitMeasure (UnitMeasureCode,Name, ModifiedDate)
VALUES ('TT1','Test 1', CONVERT (DATETIME, '09.09.2020', 104)) , ('TT2','Test 2', GETDATE())


--��������� ������, ���� �� ����� UnitMeasureCode, ������������ �� ����� �Ғ.  

SELECT COUNT(UnitMeasureCode) as Unit_Code_T
FROM AdventureWorks2017.Production.UnitMeasure
WHERE UnitMeasureCode LIKE 'T%'


/* b)������ ��������� ����������� ����� � �����, �� ������������ ������� Production.UnitMeasureTest. ��������� ���� ���������� �� Production.UnitMeasure �� UnitMeasureCode = �CAN�.
���������� ��������� � ��������������� ���� �� ����. */

SELECT UnitMeasureCode,Name,ModifiedDate
INTO AdventureWorks2017.Production.UnitMeasureTest
FROM AdventureWorks2017.Production.UnitMeasure
WHERE UnitMeasureCode in ('TT1','TT2')

/*��������� ���� ���������� �� Production.UnitMeasure �� UnitMeasureCode = �CAN�.*/

INSERT INTO AdventureWorks2017.Production.UnitMeasureTest (UnitMeasureCode,Name,ModifiedDate)
SELECT UnitMeasureCode,Name,ModifiedDate
FROM AdventureWorks2017.Production.UnitMeasure
WHERE UnitMeasureCode = ('CAN')

/*���������� ��������� � ��������������� ���� �� ����. */

SELECT* 
FROM AdventureWorks2017.Production.UnitMeasureTest
ORDER BY UnitMeasureCode

/*c) �������� UnitMeasureCode ��� ����� ������ �� Production.UnitMeasureTest �� �TTT�. */

UPDATE AdventureWorks2017.Production.UnitMeasureTest
SET UnitMeasureCode='TTT'

/*d)������� ��� ������ �� Production.UnitMeasureTest. */

DELETE 
FROM AdventureWorks2017.Production.UnitMeasureTest

/*e) ������� ���������� �� Sales.SalesOrderDetail �� ������� 43659,43664.  � ������� ������� ������� MAX, MIN, AVG ������ �������� �� LineTotal ��� ������� SalesOrderID. */

SELECT DISTINCT SalesOrderID,
MAX (LineTotal) OVER (PARTITION BY SalesOrderID) AS SUM,
MIN (LineTotal) OVER (PARTITION BY SalesOrderID) AS MIN,
AVG (LineTotal) OVER (PARTITION BY SalesOrderID) AS AVG
FROM AdventureWorks2017.Sales.SalesOrderDetail
WHERE SalesOrderID in ('43659', '43664')

/*f)������� ������ � ������� Sales.vSalesPerson. �������� ������� c���� ��������� �� ������ ������� ������ SalesYTD, ��������� ����������� ������� �������.
�������� ���� Login, ��������� �� 3 ������ ���� ������� � ������� �������� + �login� + TerritoryGroup (Null �������� �� ������ ��������). */

SELECT
RANK() OVER ( ORDER BY SalesYTD DESC) as Rank,
CONCAT (LEFT (UPPER(LastName),3), 'Login', ISNULL(TerritoryGroup,'')) AS UserName 
FROM AdventureWorks2017.Sales.vSalesPerson

/* ��� ����������� �������? � ��� ���������� ������� � ������� ���� (SalesLastYear).   */

SELECT DISTINCT 
FIRST_VALUE (Name) OVER (ORDER BY (CurrentYearRank)) as CurrentLeader,
FIRST_VALUE (Name) OVER (ORDER BY (LastYearRank)) as LYLeader
FROM (
SELECT
RANK() OVER (ORDER BY SalesYTD DESC) AS CurrentYearRank,
RANK() OVER (ORDER BY SalesLastYear DESC) AS LastYearRank,
CONCAT (FirstName,'',LastName) as Name
FROM AdventureWorks2017.Sales.vSalesPerson) as RankQuery
 

/*g) ������� ������ ������ ���� ������ (FROM �� ����������). ����� ����������� ��� �� ��� �������. */

SELECT
CASE DATEPART(dd, DATEADD (day, DATEPART (DAY,	GETDATE()-1)*(-1),GETDATE()))
WHEN 6 THEN DATEADD (DAY,3,EOMONTH(GETDATE(),-1))
WHEN 7 THEN DATEADD (DAY,2,EOMONTH(GETDATE(),-1))
ELSE DATEADD (DAY,1,EOMONTH(GETDATE(),-1))
END FirstWorkingDay

/*5. ������� ��� ��� ����������� � ������� ��������� ������� count. ������� �������� count(1), count(name), count(id), count(*) ��� ��������� �������: */

COUNT(1)=4
COUNT(NAME)=2
COUNT(id)=4
COUNT(*)=4 
