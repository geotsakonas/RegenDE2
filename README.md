# Regeneration - Data Engineering Vol.2

## Database Restorage

In the first stage, the Microsoft SQL Server Management Studio (MSSMS) was used to restore the project's chin2022 and chin2022 databases.
The OLTP database is created with the utilization of chin2021 and chin2022.

## Data Warehouse (Star/Snowflake)

In the second stage we developed a staging database (ChinookStaging) in order for the data to be transferred from the OLTP database and perform the ETL process.
This phase is required since the adjustments that will be performed, they should also not overload OLTP.

Additionally, we created the DataWarehouse (ChinookDW) database which will be the final one. Moreover, a dimension table (DimDate) is developed with the dates included in the final Data Warehouse (ChinookDW).

## Data Warehouse Load

During the third stage we loaded the staging database and the data warehouse database (queries no.4 and no.5).

As a first step, we loaded data from the Chinook2021 database into the DataWarehouse (query no4).

Following that, the data warehouse database is updated with additional data from Chinook2022 database (query no.5) for comparison and inclusion in the pipeline.

## Azure Data Facroty ETL

After completing the ETL process on MSSMS, we continued it in Azure Cloud.

During this process, we used two approaches.

The first method is aimed at the creation of a pipeline with the Data Factory (ETL folder) and the second option aimed at the link of the Azure Cloud Server to our on-premises server and completing the migration through MSSMS (Azure Migration folder).

## Power BI Report

Finally, Power BI depicted the growth of sales from 2018 until 2022.
