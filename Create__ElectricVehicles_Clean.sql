CREATE OR ALTER PROCEDURE Create__ElectricVehicles_Clean
@ExcludeClause nvarchar(30), @database nvarchar(30) AS
BEGIN 
	SET NOCOUNT ON;
	DECLARE @Sql NVARCHAR(MAX);
	SET @Sql = N'DROP TABLE IF EXISTS ' + QUOTENAME(@database) + '.dbo.ElectricVehicles_Clean;
				SELECT
					VIN, County, City, State, PostalCode, ModelYear, Make, Model, ElectricVehicleType, 
					CAFVEligibility, ElectricRange, BaseMSRP, LegislativeDistrict, DOLVehicleID, VehicleLocation,
					ElectricUtility, CensusTract
				INTO ' + QUOTENAME(@database) + '.dbo.ElectricVehicles_Clean
				FROM ' + QUOTENAME(@database) + '.dbo.ElectricVehicles 
				WHERE 1=1 @ExcludeClause';
 	EXECUTE sp_executesql @Sql, N'@ExcludeClause nvarchar(30)', @ExcludeClause;
 end;

-- EXEC Create__ElectricVehicles_Clean @ExcludeClause = 'AND TRUE', @database = 'testing';

