/*Revisión de data*/
select top 10*
from dbo.Superstore;

/*Cantidad de Registros*/
SELECT COUNT(*) AS Total_Registros
FROM dbo.Superstore;

/*Buscar valores nulos*/

SELECT
SUM(CASE WHEN [Order_ID] is NULL THEN 1 ELSE 0 END) AS OrderID_Nulos,
SUM(CASE WHEN [Customer_Name] is NULL THEN 1 ELSE 0 END) AS Cliente_Nulos,
SUM(CASE WHEN [Sales] is NULL THEN 1 ELSE 0 END) AS Sales_Nulos,
SUM(CASE WHEN [Profit] is NULL THEN 1 ELSE 0 END) AS Profit_Nulos
FROM dbo.Superstore;

/*Buscar duplicados*/

SELECT 
[ROW_ID],
COUNT(*) AS Repeticiones
FROM Dbo.Superstore
GROUP BY [Row_ID]
HAVING COUNT(*)>1;

/*Revisar categorias inconsistentes*/

SELECT DISTINCT Category
FROM dbo.Superstore;

SELECT DISTINCT Region
FROM dbo.Superstore;

SELECT DISTINCT Segment
FROM dbo.Superstore;

/*Dectectar ventas negativos*/
SELECT*
FROM dbo.Superstore
WHERE Sales <0;

/*Detectar cantidades negativas*/
SELECT*
FROM dbo.Superstore
WHERE Quantity<0;

/*Detectar descuentos irregulares*/
SELECT*
FROM dbo.Superstore
WHERE Discount >1
OR Discount <0;

/*Analizar ganancias negativas*/
SELECT*
FROM dbo.Superstore
WHERE Profit<0;

/*Crear métricas derivadas*/
ALTER TABLE dbo.Superstore
ADD Order_Year INT;
UPDATE dbo.Superstore
SET Order_Year = YEAR([Order_Date]);

ALTER TABLE dbo.Superstore
ADD Order_Month VARCHAR(20);
UPDATE dbo.Superstore
SET Order_Month = DATENAME(month,[Order_Date]);

ALTER TABLE dbo.SuperStore
ADD Profit_Margin DECIMAL(10,2);
UPDATE dbo.Superstore
SET Profit_Margin = 
CASE
	WHEN Sales = 0 THEN 0
	ELSE (Profit/Sales)*100
END;

/*Creamos una vista para Tableu*/

CREATE VIEW vw_Superstore_Clean AS
SELECT
    Row_ID,
    Order_ID,
    Order_Date,
    Ship_Date,
    Segment,
    Country,
    City,
    State,
    Region,
    Category,
    Sub_Category,
    Product_Name,
    Sales,
    Quantity,
    Discount,
    Profit,
    Order_Year,
    Order_Month,
    Profit_Margin
FROM dbo.Superstore;

/*Agregamos una columna derivada más*/

ALTER VIEW vw_Superstore_Clean AS
SELECT
	*,
	CASE 
		WHEN Profit <0 THEN 'Loss'
		ELSE 'Profit'
	END AS Profit_Status
FROM dbo.Superstore;

SELECT TOP 10 *
FROM vw_Superstore_Clean;

/*Analisis Exploratorio*/

SELECT 
	SUM(Profit) AS Total_Sales
FROM vw_Superstore_Clean;

SELECT
	AVG(Profit) AS Total_Profit
FROM vw_Superstore_Clean;

SELECT
	AVG(Profit_Margin) AS Avg_Margin
FROM vw_Superstore_Clean;

SELECT 
	Category,
	ROUND(SUM(Sales),2) AS Total_Sales
FROM vw_Superstore_Clean
GROUP BY Category
ORDER BY Total_Sales DESC;

SELECT 
	Category,
	ROUND(SUM(Profit),2) AS Total_Profit
FROM vw_Superstore_Clean
GROUP BY Category
ORDER BY Total_Profit DESC;

SELECT 
	Sub_Category,
	ROUND(SUM(Sales),2) AS Total_Sales
FROM vw_Superstore_Clean
GROUP BY Sub_Category
ORDER BY Total_Sales DESC;

SELECT TOP 10
    Product_Name,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM vw_Superstore_Clean
GROUP BY Product_Name
ORDER BY Total_Sales DESC;

SELECT TOP 10
    Product_Name,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM vw_Superstore_Clean
GROUP BY Product_Name
ORDER BY Total_Profit DESC;

SELECT TOP 10
	Product_Name,
	ROUND(sum(Profit),2) AS Total_Profit
FROM vw_Superstore_Clean
GROUP BY Product_Name
ORDER BY Total_Profit ASC;
	
SELECT
	Region,
	ROUND(SUM(Sales),2) AS Total_Sales
FROM vw_Superstore_Clean
GROUP BY Region
ORDER BY Total_Sales DESC;

SELECT
    Region,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM vw_Superstore_Clean
GROUP BY Region
ORDER BY Total_Profit DESC;

SELECT
    Segment,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM vw_Superstore_Clean
GROUP BY Segment
ORDER BY Total_Sales DESC;

SELECT
    Segment,
    ROUND(SUM(Profit),2) AS Total_Profit
FROM vw_Superstore_Clean
GROUP BY Segment
ORDER BY Total_Profit DESC;

SELECT TOP 10
    Customer_Name,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM vw_Superstore_Clean
GROUP BY Customer_Name
ORDER BY Total_Sales DESC;

SELECT
    Order_Year,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM vw_Superstore_Clean
GROUP BY Order_Year
ORDER BY Order_Year;

SELECT
    Order_Year,
    Order_Month,
    ROUND(SUM(Sales),2) AS Total_Sales
FROM vw_Superstore_Clean
GROUP BY Order_Year, Order_Month
ORDER BY Order_Year;

SELECT
    MIN(Order_Date) AS Fecha_Inicio,
    MAX(Order_Date) AS Fecha_Fin,
    COUNT(*) AS Registros
FROM vw_Superstore_Clean;

SELECT
    COUNT(DISTINCT Customer_ID) AS Clientes,
    COUNT(DISTINCT Order_ID) AS Pedidos
FROM vw_Superstore_Clean;

SELECT *
FROM vw_Superstore_Clean;