# Regeneration - Data Engineering Vol.2

## Database Restorage

In the first stage, we used Microsoft SQL Server Management Studio (MSSMS) to restore the project's chin2022 and chin2022 databases.
The OLTP batabase is made up of Chin2021 and Chin2022.

## Data Warehouse (Star/Snowflake)

In the second stage we constructed a staging database (ChinookStaging) so that we could transfer data from the OLTP database and perform the ETL process.
This phase is required since the adjustments that will be performed should not overload OLTP.

In addition we created the DataWarehouse (ChinookDW) database which will be our final database and a dimension table (DimDate) with the dates that will be included in the final Data Warehouse (ChinookDW).

## Data Warehouse Load

In the third stage we loaded the staging database and the data warehouse database (queries no.4 and no.5).

First, we load data from the Chinook2021 database into the DataWarehouse (question #4).
Following that, the data warehouse database is updated with additional data from Chinook2022 database (querie no.5) for comparison and inclusion in the pipeline.

## Azure Data Facroty ETL

After completed the ETL process on MSSMS, we continued it in Azure Cloud.

In this process, we used two approaches.

The first method was to create a pipeline with the Data Factory (ETL folder) and the second option was to link the Azure Cloud Server to our on-premises server and complete the migration through MSSMS (Azure Migration folder).

## Power BI Report

Finally, Power BI depicted the growth of sales from 2018 until 2022.
