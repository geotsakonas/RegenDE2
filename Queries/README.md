1_Chinook_DataWarehouse_Staging.sql this script creates a staging database from the OLTP

2_Chinook_DataWarehouse_CreatingDWTables.sql creates the datawarehouse with the tables but with no data

3_Chinook_DataWarehouse_DimDate.sql adds the dimdate data to datawarehouse

4_Chinook_DataWarehouse_LoadData.sql we use this to load data from the staging database to datawarehouse

5_Chinook_DataWarehouse_SCD.sql with this script we load the data again with the slowly changing dimensions method

