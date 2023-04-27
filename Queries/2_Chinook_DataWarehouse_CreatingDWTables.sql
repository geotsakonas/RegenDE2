USE ChinookDW
GO

DROP TABLE IF EXISTS DimCustomer
GO
DROP TABLE IF EXISTS DimTrack
GO
DROP TABLE IF EXISTS DimEmployee
GO
DROP TABLE IF EXISTS FactSales
GO


CREATE TABLE DimCustomer(
			CustomerKey INT IDENTITY(1,1) NOT NULL,
			CustomerId INT NOT NULL,
			CustomerFirstName NVARCHAR(40) NOT NULL,
			CustomerLastName NVARCHAR(40) NOT NULL,
			CustomerCompany NVARCHAR(70),
			CustomerAddress NVARCHAR(200) NOT NULL,
			CustomerCity NVARCHAR(40) NOT NULL,
			CustomerPostalCode NVARCHAR(20),
			CustomerState NVARCHAR(15),
			CustomerCountry NVARCHAR(40) NOT NULL,
			RowIsCurrent INT DEFAULT 1 NOT NULL,
			RowStartDate DATE DEFAULT '2018-01-01' NOT NULL,
			RowEndDate DATE DEFAULT '2999-12-31' NOT NULL,
			RowChangeReason varchar(200) NULL
);

CREATE TABLE DimEmployee(
			EmployeeKey INT IDENTITY(1,1) NOT NULL,
			EmployeeId INT NOT NULL,
			EmployeeLastName NVARCHAR(40) NOT NULL,
			EmployeeFirstName NVARCHAR(40) NOT NULL,
			EmployeeTitle NVARCHAR(40) NOT NULL,
			EmployeeBirthDate DATE NOT NULL,
			EmployeeHireDate DATE NOT NULL,
			RowIsCurrent INT DEFAULT 1 NOT NULL,
			RowStartDate DATE DEFAULT '2018-01-01' NOT NULL,
			RowEndDate DATE DEFAULT '2999-12-31' NOT NULL,
			RowChangeReason varchar(200) NULL
			)


CREATE TABLE DimTrack(
			TrackKey INT IDENTITY(1,1) NOT NULL,
			TrackId INT NOT NULL,
			TrackName NVARCHAR(MAX) NOT NULL,
			TrackGenre NVARCHAR(30) NOT NULL,
			TrackAlbumTitle NVARCHAR(MAX) NOT NULL,
			TrackAlbumArtist NVARCHAR(100) NOT NULL,
			TrackMediaType NVARCHAR(40) NOT NULL,
			RowIsCurrent INT DEFAULT 1 NOT NULL,
			RowStartDate DATE DEFAULT '2018-01-01' NOT NULL,
			RowEndDate DATE DEFAULT '2999-12-31' NOT NULL,
			RowChangeReason varchar(200) NULL
			)
CREATE TABLE FactSales(
			TrackKey INT NOT NULL,
			CustomerKey INT NOT NULL,
			EmployeeKey INT NOT NULL,
			DateKey INT NOT NULL,
			InvoiceId INT NOT NULL,
			UnitPrice FLOAT(2) NOT NULL,
			Quantity TINYINT NOT NULL

		)


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

