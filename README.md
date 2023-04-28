# Regeneration - Data Engineering Vol.2

## Database Restorage

In the first stage, the Microsoft SQL Server Management Studio (MSSMS) was used to restore the project's chin2022 and chin2022 databases.
The OLTP batabase is made up of Chin2021 and Chin2022.

## Data Warehouse (Star/Snowflake)

In the second stage a staging database (ChinookStaging) is constructed so that it is possible to transfer data from the OLTP database and perform the ETL process.
This phase is required since the adjustments that will be performed should not overload OLTP.

In addition the DataWarehouse (ChinookDW) database is created which will be the final database and a dimension table (DimDate) with the dates that will be included in the final Data Warehouse (ChinookDW).

## Data Warehouse Load

In the third stage the staging database is loaded and the data warehouse database (queries no.4 and no.5).

First, the data from the Chinook2021 databaseare loaded into the DataWarehouse (querie no.4).
Following that, the data warehouse database is updated with additional data from Chinook2022 database (querie no.5) for comparison and inclusion in the pipeline.

## Azure Data Facroty ETL

After the ETL process on MSSMS is completed, thr process continues in the Azure Cloud.

In this process, two approaches are handled.

The first method was to create a pipeline with the Data Factory (ETL folder) and the second option was to link the Azure Cloud Server to the on-premises server and complete the migration through MSSMS (Azure Migration folder).

## Power BI Report

Finally, Power BI depicted the growth of sales from 2018 until 2022.
