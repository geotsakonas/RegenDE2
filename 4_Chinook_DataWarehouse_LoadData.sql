USE ChinookDW
GO
 


INSERT INTO DimCustomer(
			CustomerId,CustomerFirstName,CustomerLastName,CustomerCompany,CustomerAddress,CustomerCity,
			CustomerPostalCode,CustomerState,CustomerCountry)
SELECT CustomerId,FirstName,LastName,Company,Address,City,PostalCode,State,Country
FROM [ChinookStaging].[dbo].[Customer]
GO



INSERT INTO DimEmployee(EmployeeId,EmployeeLastName,EmployeeFirstName,
			EmployeeTitle,EmployeeBirthDate,EmployeeHireDate
			)
SELECT EmployeeId,LastName,FirstName,Title,BirthDate,HireDate
FROM [ChinookStaging].[dbo].[Employee]
GO


INSERT INTO DimTrack(TrackId,
			TrackName,
			TrackGenre,
			TrackAlbumTitle,
			TrackAlbumArtist,
			TrackMediaType)
SELECT TrackId,TrackName,GenreName,AlbumTitle,ArtistName,MediaType
FROM [ChinookStaging].[dbo].[Track]
GO


INSERT INTO FactSales(TrackKey,CustomerKey,EmployeeKey,DateKey,InvoiceId,UnitPrice,Quantity)
SELECT TrackKey,CustomerKey,EmployeeKey,DateKey,InvoiceId,UnitPrice,Quantity
FROM [ChinookStaging].[dbo].[Sales] s
INNER JOIN DimCustomer dc ON dc.CustomerId=s.CustomerId
INNER JOIN DimEmployee de ON de.EmployeeId=s.EmployeeId
INNER JOIN DimTrack dt ON dt.TrackId=s.TrackId
INNER JOIN DimDate dd ON dd.date=s.InvoiceDate
GO



select * from FactSales
