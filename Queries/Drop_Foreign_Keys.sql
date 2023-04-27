USE ChinookDW
GO


alter table factSales drop constraint fact_cust_fk;
GO
alter table  [ChinookDW].[dbo].[DimCustomer]  drop constraint cust_PK ;
GO

alter table factSales drop constraint fact_employee_fk;
GO
alter table  [ChinookDW].[dbo].[DimEmployee]  drop constraint employee_PK ;
GO

alter table factSales drop constraint fact_track_fk;
GO
alter table  [ChinookDW].[dbo].[DimTrack]  drop constraint track_PK ;
GO

alter table factSales drop constraint fact_date_fk;
GO
alter table  [ChinookDW].[dbo].[DimDate]  drop constraint date_PK ;
GO
