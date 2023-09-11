-- Load input file from HDFS
inputFile1 = LOAD 'hdfs:///user/saranya/episodeIV_dialogues.txt' using PigStorage('\t') AS (name,line);
inputFile2 = LOAD 'hdfs:///user/saranya/episodeV_dialogues.txt' using PigStorage('\t') AS (name,line);
inputFile3 = LOAD 'hdfs:///user/saranya/episodeVI_dialogues.txt' using PigStorage('\t') AS (name,line);

-- Filter out the first 2 lines from each file
ranked4 = RANK inputFile1;
OnlyDialogues4 = FILTER ranked4 BY (rank_inputFile1 > 2);

ranked5 = RANK inputFile2;
OnlyDialogues5 = FILTER ranked5 BY (rank_inputFile2 > 2);

ranked6 = RANK inputFile3;
OnlyDialogues6 = FILTER ranked6 BY (rank_inputFile3 > 2);

-- Combine all data
InputData = UNION OnlyDialogues4, OnlyDialogues5, OnlyDialogues6;

-- Group the data
InputData1 = Group InputData by name;

-- Output

Output1 = FOREACH InputData1 GENERATE $0 as Name, COUNT($1) as No_of_lines;

-- Sorted Output
Sorted_Output = order Output1 by No_of_lines desc;

-- Store the data in HDFS
	
STORE Sorted_Output INTO 'hdfs:///user/saranya/Output_Characters';








