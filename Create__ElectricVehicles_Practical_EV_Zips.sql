CREATE OR ALTER PROCEDURE Create__ElectricVehicles_Practical_EV_Zips
@ExcludeMake nvarchar(30), @MinCountStar INT, @database nvarchar(30) AS
BEGIN 
	SET NOCOUNT ON;
	DECLARE @Sql NVARCHAR(MAX);
	SET @Sql = N'DROP TABLE IF EXISTS ' + QUOTENAME(@database) + '.dbo.ElectricVehicles_Practical_EV_Zips;
		SELECT
			PostalCode,
			SUM(CASE WHEN ElectricRange > 10 THEN 1.0 ELSE 0.0 END)/COUNT(*) AS Practical_EV_Rate,
			COUNT(*) as NumEVs
		INTO ' + QUOTENAME(@database) + '.dbo.ElectricVehicles_Practical_EV_Zips 
		FROM ' + QUOTENAME(@database) + '.dbo.ElectricVehicles 
		WHERE Make != @ExcludeMake GROUP BY PostalCode
		HAVING COUNT(*) > @MinCountStar';
 	EXECUTE sp_executesql @Sql, N'@ExcludeMake nvarchar(30), @MinCountStar INT', @ExcludeMake, @MinCountStar;
 end;


-- EXEC Create__ElectricVehicles_Practical_EV_Zips @ExcludeMake = 'MINI', @MinCountStar = 50, @database = 'core';
-- SELECT * FROM core.dbo.ElectricVehicles_Practical_EV_Zips ORDER BY 2 DESC; 
