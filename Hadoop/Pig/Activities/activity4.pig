-- Load the CSV file
salesTable = LOAD 'hdfs:///user/niteshpanda/sales.csv' USING PigStorage(',') AS (Product:chararray,Price:chararray,Payment_Type:chararray,Name:chararray,City:chararray,State:chararray,Country:chararray);
-- Group data using the country column
GroupByCountry = GROUP salesTable BY Country;
-- Generate result format
CountByCountry = FOREACH GroupByCountry GENERATE CONCAT((chararray)$0, CONCAT(':', (chararray)COUNT($1)));
-- To remove the old output folder
rmf /user/niteshpanda/salesOutput
-- Save result in HDFS folder
STORE CountByCountry INTO '/user/niteshpanda/salesOutput' USING PigStorage('\t');
