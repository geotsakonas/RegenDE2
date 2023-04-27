USE ChinookStaging
GO
                       --------------------Dropping the Staging tables in case they already exist-----------------------
DROP TABLE IF EXISTS [dbo].[Customer]
GO
DROP TABLE IF EXISTS [dbo].[Employee]
GO
DROP TABLE IF EXISTS [dbo].[Sales]
GO
DROP TABLE IF EXISTS [dbo].[Track]
GO

                        --------------------- Ingesting the data from the new source------------------------------------
SELECT EmployeeId,LastName,FirstName,Title,BirthDate,HireDate
INTO Employee
FROM [Chinook2022].[dbo].[Employee]

GO
SELECT CustomerId,FirstName,LastName,Company,Address,City,State,Country,PostalCode
INTO Customer
FROM [Chinook2022].[dbo].[Customer]
GO

SELECT TrackId,t.Name AS TrackName,g.Name AS GenreName,al.Title AS AlbumTitle,ar.Name as ArtistName,md.Name AS MediaType
INTO Track
FROM Chinook2022.dbo.Track t
INNER JOIN Chinook2022.dbo.Album al ON t.AlbumId = al.AlbumId
INNER JOIN Chinook2022.dbo.Artist ar ON al.ArtistId=ar.ArtistId
INNER JOIN Chinook2022.dbo.Genre g ON t.GenreId = g.GenreId
INNER JOIN Chinook2022.dbo.MediaType md ON t.MediaTypeId=md.MediaTypeId;
GO

SELECT TrackId,EmployeeId,i.CustomerId,i.InvoiceDate,il.UnitPrice,il.Quantity,i.InvoiceId
INTO Sales
FROM Chinook2022.dbo.InvoiceLine il
INNER JOIN [Chinook2022].[dbo].[Invoice] i ON  il.InvoiceId = i.InvoiceId
INNER JOIN [Chinook2022].[dbo].[Customer] c ON c.CustomerId=i.CustomerId
INNER JOIN [Chinook2022].[dbo].[Employee] e ON e.EmployeeId=c.SupportRepId


USE ChinookDW
GO

					------------------------------Droping foreign key constraints---------------------------------
ALTER TABLE factSales DROP CONSTRAINT fact_cust_fk;
ALTER TABLE  [ChinookDW].[dbo].[DimCustomer]  DROP CONSTRAINT cust_PK
GO





					------------------------------Merging the DimCustomer table------------------------------------

INSERT INTO DimCustomer([CustomerID],[CustomerFirstName] ,[CustomerLastName],[CustomerCompany],
	[CustomerAddress], [CustomerCity], [CustomerPostalCode], [CustomerState],[CustomerCountry]
	,[RowStartDate],[RowChangeReason])

SELECT [CustomerID],[FirstName],[LastName],[Company],[Address],[City],[PostalCode],[State],[Country],CAST(GetDate() AS Date),ActionName
FROM	 

(MERGE [ChinookDW].[dbo].DimCustomer AS target
		USING [ChinookStaging].[dbo].[Customer] as source
		ON target.[CustomerID] = source.[CustomerID]

WHEN MATCHED AND source.city <> target.[CustomerCity] then 
  update set
   target.RowIsCurrent = 0,
   target.RowEndDate = dateadd(day, -1, CAST(GetDate() AS Date)) ,
   target.RowChangeReason = 'moved to new city'

WHEN NOT MATCHED THEN
	INSERT([CustomerID],[CustomerFirstName] ,[CustomerLastName],[CustomerCompany],
	[CustomerAddress], [CustomerCity], [CustomerPostalCode], [CustomerState],[CustomerCountry]
	,[RowStartDate])
	VALUES(source.[CustomerID]
	, ISNULL(source.[FirstName],'')
	, ISNULL(source.[LastName] ,'')
	, ISNULL(source.[Company],'')
	, ISNULL(source.[Address],'')
	, ISNULL(source.[City],'')
	, ISNULL(source.[PostalCode],'')
	, ISNULL(source.[State],'')
	, ISNULL(source.[Country],'')
	, GETDATE()
	 )

WHEN NOT MATCHED BY Source THEN
UPDATE SET 	Target.RowEndDate= dateadd(day, -1, CAST(GetDate() AS Date))
			,target.RowIsCurrent = 0
			,Target.RowChangeReason  = 'SOFT DELETE'

OUTPUT
	source.[CustomerID]
	, ISNULL(source.[FirstName],'')[FirstName]
	, ISNULL(source.[LastName] ,'')[LastName]
	, ISNULL(source.[Company],'')[Company]
	, ISNULL(source.[Address],'')[Address]
	, ISNULL(source.[City],'')[City]
	, ISNULL(source.[PostalCode],'')[PostalCode]
	, ISNULL(source.[State],'')[State]
	, ISNULL(source.[Country],'')[Country]
	, $Action as ActionName   
	) as Message
WHERE Message.ActionName='UPDATE'
AND [CustomerID] IS NOT NULL;
GO



                        -----------------------------Merging the DimEmployee table---------------------------------------------------


ALTER TABLE [ChinookDW].[dbo].FactSales drop constraint fact_employee_fk;
GO
ALTER TABLE  [ChinookDW].[dbo].[DimEmployee]  drop constraint employee_PK ;
GO


INSERT INTO DimEmployee([EmployeeId],[EmployeeLastName],[EmployeeFirstName],[EmployeeTitle],[EmployeeBirthDate]
	,[EmployeeHireDate],[RowStartDate],[RowChangeReason])

SELECT [EmployeeId],[LastName],[FirstName],[Title],[BirthDate],[HireDate],CAST(GetDate() AS Date),ActionName
FROM	 


(MERGE [ChinookDW].[dbo].DimEmployee AS target
		USING [ChinookStaging].[dbo].Employee as source
		ON target.[EmployeeId] = source.[EmployeeId]

WHEN MATCHED AND target.EmployeeTitle <>  source.Title THEN
UPDATE SET
		target.RowIsCurrent = 0,
		target.RowEndDate = dateadd(day, -1, CAST(GetDate() AS Date)) ,
		target.RowChangeReason = 'His job title has changed'

WHEN NOT MATCHED THEN
INSERT (EmployeeId,EmployeeLastName,EmployeeFirstName,EmployeeTitle,EmployeeBirthDate,EmployeeHireDate,RowStartDate)
VALUES (source.EmployeeId,
		isnull(source.LastName,''),
		isnull(source.FirstName,''),
		isnull(source.Title,''),
		isnull(source.BirthDate,''),
		isnull(source.HireDate,''),
		getdate()
		)
		
WHEN NOT MATCHED BY Source THEN
UPDATE SET 	Target.RowEndDate= dateadd(day, -1, CAST(GetDate() AS Date))
			,target.RowIsCurrent = 0
			,Target.RowChangeReason  = 'SOFT DELETE'

OUTPUT
	source.EmployeeId,
		isnull(source.LastName,'')[LastName],
		isnull(source.FirstName,'')[FirstName],
		isnull(source.Title,'')[Title],
		isnull(source.BirthDate,'')[BirthDate],
		isnull(source.HireDate,'')[HireDate],
		$Action as ActionName   
	) as Message
WHERE Message.ActionName='UPDATE'
AND [EmployeeId] IS NOT NULL;
GO

                  
				  ------------------------------Ìerging the DimTrack table-----------------------------------
ALTER TABLE [ChinookDW].[dbo].[FactSales] drop constraint fact_track_fk;
ALTER TABLE [ChinookDW].[dbo].[DimTrack]  drop constraint track_PK ;


MERGE INTO [ChinookDW].[dbo].DimTrack AS target
USING [ChinookStaging].[dbo].Track AS  source
ON target.TrackId=source.TrackId

WHEN NOT MATCHED THEN
INSERT (TrackId,TrackName,TrackGenre,TrackAlbumTitle,TrackAlbumArtist,TrackMediaType,RowStartDate)
VALUES (source.TrackId,source.TrackName,source.GenreName,source.AlbumTitle,source.ArtistName,source.MediaType,dateadd(day, -1, CAST(GetDate() AS Date)))

WHEN NOT MATCHED BY source THEN
UPDATE SET 	Target.RowEndDate= dateadd(day, -1, CAST(GetDate() AS Date))
			,target.RowIsCurrent = 0
			,Target.RowChangeReason  = 'SOFT DELETE'
OUTPUT inserted.*;


				---------------------------Inserting the new records into the FactSales table-------------------------------------
INSERT INTO FactSales (TrackKey, CustomerKey, EmployeeKey, DateKey, InvoiceId, UnitPrice, Quantity)
SELECT dt.TrackKey, dc.CustomerKey, de.EmployeeKey, dd.DateKey, s.InvoiceId, s.UnitPrice, s.Quantity
FROM [ChinookStaging].[dbo].[Sales] s
INNER JOIN DimCustomer dc ON dc.CustomerId = s.CustomerId
INNER JOIN DimEmployee de ON de.EmployeeId = s.EmployeeId
INNER JOIN DimTrack dt ON dt.TrackId = s.TrackId
INNER JOIN DimDate dd ON dd.Date = s.InvoiceDate
WHERE s.InvoiceDate > (SELECT MAX(InvoiceDate) FROM [ChinookStaging].[dbo].[Sales])


INSERT INTO FactSales (TrackKey, CustomerKey, EmployeeKey, DateKey, InvoiceId, UnitPrice, Quantity)
SELECT dt.TrackKey, dc.CustomerKey, de.EmployeeKey, dd.DateKey, s.InvoiceId, s.UnitPrice, s.Quantity
FROM [ChinookStaging].[dbo].[Sales] s
INNER JOIN DimCustomer dc ON dc.CustomerId = s.CustomerId
INNER JOIN DimEmployee de ON de.EmployeeId = s.EmployeeId
INNER JOIN DimTrack dt ON dt.TrackId = s.TrackId
INNER JOIN DimDate dd ON dd.Date = s.InvoiceDate
WHERE dd.DateKey > (SELECT ISNULL(MAX(DateKey), 0) FROM FactSales)


 
alter table [ChinookDW].[dbo].DimCustomer
add constraint cust_PK   primary key (CustomerKey);
GO

alter table [ChinookDW].[dbo].[factSales]  add constraint fact_cust_fk
foreign key (CustomerKey) references  [ChinookDW].[dbo].DimCustomer(CustomerKey);
GO

alter table [ChinookDW].[dbo].DimTrack
add constraint track_PK   primary key (TrackKey);
GO

alter table [ChinookDW].[dbo].[factSales]  add constraint fact_track_fk
foreign key (TrackKey) references  [ChinookDW].[dbo].DimTrack(TrackKey);
GO

alter table [ChinookDW].[dbo].DimEmployee
add constraint employee_PK   primary key (EmployeeKey);
GO

alter table [ChinookDW].[dbo].[factSales]  add constraint fact_employee_fk
foreign key (EmployeeKey) references  [ChinookDW].[dbo].DimEmployee(EmployeeKey);
GO

