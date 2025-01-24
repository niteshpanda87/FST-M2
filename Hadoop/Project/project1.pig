-- Load data from HDFS
dialougeFile = Load '/root/inputs' USING PigStorage('\t') AS (name:chararray, line:chararray);

-- Group by name
groupByName = GROUP dialougeFile BY name;

-- Count the number of lines be Each Character
names = FOREACH groupByName GENERATE $0 AS name_of_character, COUNT ($1) AS no_of_lines;
namesOrder = ORDER names BY no_of_lines DESC;

-- Remove Output Folder
rmf /root/PigProjectOutput;

-- Store result in HDFS
STORE namesOrder INTO '/root/PigProjectOutput' USING PigStorage('\t');

