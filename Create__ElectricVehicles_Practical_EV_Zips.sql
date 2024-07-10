DROP TABLE IF EXISTS testing.dbo.ElectricVehicles_Practical_EV_Zips;
CREATE OR ALTER PROCEDURE Create__ElectricVehicles_Practical_EV_Zips
@ExcludeMake nvarchar(30), @MinCountStar INT AS
SELECT
	PostalCode,
	SUM(CASE WHEN ElectricRange > 200 THEN 1.0 ELSE 0.0 END)/COUNT(*) AS Practical_EV_Rate,
	COUNT(*) as NumEVs
INTO testing.dbo.ElectricVehicles_Practical_EV_Zips 
FROM testing.dbo.ElectricVehicles 
WHERE Make != @ExcludeMake
GROUP BY PostalCode
HAVING COUNT(*) > @MinCountStar
GO;
-- EXEC Create__ElectricVehicles_Practical_EV_Zips @ExcludeMake = 'MINI', @MinCountStar = 30;
-- SELECT * FROM testing.dbo.ElectricVehicles_Practical_EV_Zips ORDER BY 2 DESC; 
