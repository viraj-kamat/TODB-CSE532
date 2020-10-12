1. Stored Procedure
* To run the SQL stored procedure connect to your database first. The stored procedure assumes table EMPLOYEE is already created and loaded in the database. 
* Create and run the stored procedure with the command :- db2 -td@ -f sp.sql
* Modify the file at the end to compute the CumulativeHistogram for a custom set of values or use the command-line utility to directly invoke it with custom parameters using db2 CALL CUMULATIVEHISTOGRAM(binstart, binend, numbins) .


2. Java Version using UDF
* In order to run the java based routine that calculates the Cumulative histogram first update the file Cumulative_Histogram.java and enter your database credentials. 
* By default the script connects to a database empl with a table EMPLOYEE; modify as needed. 
* Compile the java file with javac Cumulative_Histogram.java
* Run the program with java Cumulative_Histogram binstart binend numbins; 

