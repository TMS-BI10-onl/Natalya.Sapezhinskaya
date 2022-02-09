/*3.При каких значениях оконные функции Row Number, Rank и Dense Rank вернут одинаковый результат?*/

-- Если значения в столбце будут уникальными

/*4.Изучите данные в таблице Production.UnitMeasure. 
Проверьте, есть ли здесь UnitMeasureCode, начинающиеся на букву ‘Т’. Сколько всего различных кодов здесь есть? */

SELECT UnitMeasureCode as TCode 
FROM AdventureWorks2017.Production.UnitMeasure
WHERE UnitMeasureCode LIKE 'T%'

SELECT COUNT(UnitMeasureCode) as Unit_Code_count
FROM AdventureWorks2017.Production.UnitMeasure

---ИЛИ (если нужно сделать через 1 запрос)---

SELECT DISTINCT UnitT =
CASE WHEN UnitMeasureCode LIKE 'T%'
     THEN COUNT(UnitMeasureCode)
	 ELSE 0
	 END,
UnitCount= COUNT(UnitMeasureCode) OVER ()
FROM AdventureWorks2017.Production.UnitMeasure
GROUP BY UnitMeasureCode

/*Вставьте следующий набор данных в таблицу: 
TT1, Test 1, 9 сентября 2020 
TT2, Test 2, getdate() */

INSERT INTO AdventureWorks2017.Production.UnitMeasure (UnitMeasureCode,Name, ModifiedDate)
VALUES ('TT1','Test 1', CONVERT (DATETIME, '09.09.2020', 104)) , ('TT2','Test 2', GETDATE())


--Проверьте теперь, есть ли здесь UnitMeasureCode, начинающиеся на букву ‘Т’.  

SELECT COUNT(UnitMeasureCode) as Unit_Code_T
FROM AdventureWorks2017.Production.UnitMeasure
WHERE UnitMeasureCode LIKE 'T%'


/* b)Теперь загрузите вставленный набор в новую, не существующую таблицу Production.UnitMeasureTest. Догрузите сюда информацию из Production.UnitMeasure по UnitMeasureCode = ‘CAN’.
Посмотрите результат в отсортированном виде по коду. */

SELECT UnitMeasureCode,Name,ModifiedDate
INTO AdventureWorks2017.Production.UnitMeasureTest
FROM AdventureWorks2017.Production.UnitMeasure
WHERE UnitMeasureCode in ('TT1','TT2')

/*Догрузите сюда информацию из Production.UnitMeasure по UnitMeasureCode = ‘CAN’.*/

INSERT INTO AdventureWorks2017.Production.UnitMeasureTest (UnitMeasureCode,Name,ModifiedDate)
SELECT UnitMeasureCode,Name,ModifiedDate
FROM AdventureWorks2017.Production.UnitMeasure
WHERE UnitMeasureCode = ('CAN')

/*Посмотрите результат в отсортированном виде по коду. */

SELECT* 
FROM AdventureWorks2017.Production.UnitMeasureTest
ORDER BY UnitMeasureCode

/*c) Измените UnitMeasureCode для всего набора из Production.UnitMeasureTest на ‘TTT’. */

UPDATE AdventureWorks2017.Production.UnitMeasureTest
SET UnitMeasureCode='TTT'

/*d)Удалите все строки из Production.UnitMeasureTest. */

DELETE 
FROM AdventureWorks2017.Production.UnitMeasureTest

/*e) Найдите информацию из Sales.SalesOrderDetail по заказам 43659,43664.  С помощью оконных функций MAX, MIN, AVG найдем агрегаты по LineTotal для каждого SalesOrderID. */

SELECT DISTINCT SalesOrderID,
MAX (LineTotal) OVER (PARTITION BY SalesOrderID) AS SUM,
MIN (LineTotal) OVER (PARTITION BY SalesOrderID) AS MIN,
AVG (LineTotal) OVER (PARTITION BY SalesOrderID) AS AVG
FROM AdventureWorks2017.Sales.SalesOrderDetail
WHERE SalesOrderID in ('43659', '43664')

/*f)Изучите данные в объекте Sales.vSalesPerson. Создайте рейтинг cреди продавцов на основе годовых продаж SalesYTD, используя ранжирующую оконную функцию.
Добавьте поле Login, состоящий из 3 первых букв фамилии в верхнем регистре + ‘login’ + TerritoryGroup (Null заменить на пустое значение). */

SELECT
RANK() OVER ( ORDER BY SalesYTD DESC) as Rank,
CONCAT (LEFT (UPPER(LastName),3), 'Login', ISNULL(TerritoryGroup,'')) AS UserName 
FROM AdventureWorks2017.Sales.vSalesPerson

/* Кто возглавляет рейтинг? А кто возглавлял рейтинг в прошлом году (SalesLastYear).   */

SELECT DISTINCT 
FIRST_VALUE (Name) OVER (ORDER BY (CurrentYearRank)) as CurrentLeader,
FIRST_VALUE (Name) OVER (ORDER BY (LastYearRank)) as LYLeader
FROM (
SELECT
RANK() OVER (ORDER BY SalesYTD DESC) AS CurrentYearRank,
RANK() OVER (ORDER BY SalesLastYear DESC) AS LastYearRank,
CONCAT (FirstName,'',LastName) as Name
FROM AdventureWorks2017.Sales.vSalesPerson) as RankQuery
 

/*g) Найдите первый будний день месяца (FROM не используем). Нужен стандартный код на все времена. */

SELECT
CASE DATEPART(dd, DATEADD (day, DATEPART (DAY,	GETDATE()-1)*(-1),GETDATE()))
WHEN 6 THEN DATEADD (DAY,3,EOMONTH(GETDATE(),-1))
WHEN 7 THEN DATEADD (DAY,2,EOMONTH(GETDATE(),-1))
ELSE DATEADD (DAY,1,EOMONTH(GETDATE(),-1))
END FirstWorkingDay

/*5. Давайте еще раз остановимся и отточим понимание функции count. Найдите значения count(1), count(name), count(id), count(*) для следующей таблицы: */

COUNT(1)=4
COUNT(NAME)=2
COUNT(id)=4
COUNT(*)=4 
