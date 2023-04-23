
USE [ChinookStaging]
GO


DROP TABLE IF EXISTS Employee
GO
SELECT EmployeeId,LastName,FirstName,Title,BirthDate,HireDate
INTO Employee
FROM [Chinook2021].[dbo].[Employee]
GO

DROP TABLE IF EXISTS Customer
GO

SELECT CustomerId,FirstName,LastName,Company,Address,City,State,Country,PostalCode
INTO Customer
FROM [Chinook2021].[dbo].[Customer]
GO

DROP TABLE IF EXISTS Track
GO


SELECT t.TrackId,t.Name AS TrackName,g.Name AS GenreName,al.Title AS AlbumTitle,ar.Name as ArtistName,md.Name AS MediaType
INTO Track
FROM Chinook2021.dbo.Track t
INNER JOIN Chinook2021.dbo.Album al ON t.AlbumId = al.AlbumId
INNER JOIN Chinook2021.dbo.Artist ar ON al.ArtistId=ar.ArtistId
INNER JOIN Chinook2021.dbo.Genre g ON t.GenreId = g.GenreId
INNER JOIN Chinook2021.dbo.MediaType md ON t.MediaTypeId=md.MediaTypeId
GO


DROP TABLE IF EXISTS Sales
GO

SELECT TrackId,EmployeeId,i.CustomerId,i.InvoiceDate,il.UnitPrice,il.Quantity,i.InvoiceId
INTO Sales
FROM Chinook2021.dbo.InvoiceLine il
INNER JOIN [Chinook2021].[dbo].[Invoice] i ON  il.InvoiceId = i.InvoiceId
INNER JOIN [Chinook2021].[dbo].[Customer] c ON c.CustomerId=i.CustomerId
INNER JOIN [Chinook2021].[dbo].[Employee] e ON e.EmployeeId=c.SupportRepId

DROP TABLE IF EXISTS Dates

SELECT MIN(InvoiceDate) AS MinDate, MAX(InvoiceDate) AS MaxDate
INTO Dates
FROM Chinook2022.dbo.Invoice
