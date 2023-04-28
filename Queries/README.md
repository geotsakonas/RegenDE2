STAGE 1
First We Restore The Database Chiinok2021 and Chinook2022 ( .bak files )

STAGE 2
Using the sql code from 1_Chinook_DataWarehouse_Staging.sql we create the staging Database and load it with the data from the OLTP database so we dont use it anymore

STAGE 3
We used the sql code from 2_Chinook_DataWarehouse_CreatingDWTables.sql to create the datawarehouse

STAGE 4
We have to load data for the first load to our datawarehouse and we achieved that by using the code from 4_Chinook_DataWarehouse_LoadData.sql 

STAGE 5
We load the datawarehouse again with the extra data from Chinook2022 by using the code 5_Chinook_DataWarehouse_SCD.sql so we can compare and use them to our pipeline
