<h1>First we create a CLOUD SQL SERVER in which our Database will be hosted.<h1/>

![alt text](https://github.com/geotsakonas/RegenDE2/blob/main/ETL/1.ETL_steps.png)

![alt text](https://github.com/geotsakonas/RegenDE2/blob/main/ETL/2.ETL_steps.png)

**Then we create the SQL Database instance in which our Data Warehouse will be loaded.**

![alt text](https://github.com/geotsakonas/RegenDE2/blob/main/ETL/3.ETL_steps.png)
**In our case we chose a Serverless instance so we could minimize the overal costs that are associated with the Data Warehouse development.**

![alt text](https://github.com/geotsakonas/RegenDE2/blob/main/ETL/4.ETL_steps.png)

**Then we create a new Azure Data Factory in which we will orchestrate the whole ETL proccess.**

![alt text](https://github.com/geotsakonas/RegenDE2/blob/main/ETL/5.ETL_steps.png)

![alt text](https://github.com/geotsakonas/RegenDE2/blob/main/ETL/6.ETL_steps.png)

**In order to connect our on-premise SQL Server with it's corresponding cloud instance we need to create a self-hosted Integration Runtime.**


![alt text](https://github.com/geotsakonas/RegenDE2/blob/main/ETL/7.1.ETL_steps.png)

![alt text](https://github.com/geotsakonas/RegenDE2/blob/main/ETL/8.ETL_steps.png)

![alt text](https://github.com/geotsakonas/RegenDE2/blob/main/ETL/9.ETL_steps.png)

**The Integration Runtime has been successfuly installed.**

![alt text](https://github.com/geotsakonas/RegenDE2/blob/main/ETL/10.1_ETL_steps.png)

**Now we need to deploy a new linked service that will create a connection between the aforementioned Integration Runtime and the Data Factory.**

![alt text](https://github.com/geotsakonas/RegenDE2/blob/main/ETL/12.ETL_steps.png)

**At this point we can start the ETL proccess and create the tables in the Data Warehouse.**

![alt text](https://github.com/geotsakonas/RegenDE2/blob/main/ETL/13.ETL_steps.png)

**Now it is time to copy the data by setting the source and the target destination using a copy data activity.**

![alt text](https://github.com/geotsakonas/RegenDE2/blob/main/ETL/14.ETL_steps.png)

![alt text](https://github.com/geotsakonas/RegenDE2/blob/main/ETL/15.ETL_steps.png)

**After performing the same steps for all the tables it is time to commit our changes and publish them into the LOADDWPipeline.**

![alt text](https://github.com/geotsakonas/RegenDE2/blob/main/ETL/16.ETL_steps.png)

**We can now trigger the pipeline.**

![alt text](https://github.com/geotsakonas/RegenDE2/blob/main/ETL/17.ETL_steps.png)

**Now we are ready to query our new cloud Data Warehouse.**

![alt text](https://github.com/geotsakonas/RegenDE2/blob/main/ETL/18.ETL_steps.png)

![alt text](https://github.com/geotsakonas/RegenDE2/blob/main/ETL/19.ETL_steps.png)

![alt text](https://github.com/geotsakonas/RegenDE2/blob/main/ETL/20.ETL_steps.png)

![alt text](https://github.com/geotsakonas/RegenDE2/blob/main/ETL/21.ETL_steps.png)

![alt text](https://github.com/geotsakonas/RegenDE2/blob/main/ETL/22.ETL_steps.png)

![alt text](https://github.com/geotsakonas/RegenDE2/blob/main/ETL/23.ETL_steps.png)
