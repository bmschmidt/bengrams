USE ngrams;

CREATE TABLE IF NOT EXISTS 3grams1
   (word1 VARCHAR(25),word2 VARCHAR(25),word3 VARCHAR(25),year SMALLINT,words MEDIUMINT,
    pages TINYINT,books MEDIUMINT, INDEX (word1 (15) ,word3(15),word2 (15),year,words))
DATA DIRECTORY = "/media/omoo/mysql" INDEX DIRECTORY = "/media/omoo/mysql";

CREATE TABLE IF NOT EXISTS 3grams2
   (word1 VARCHAR(25),word2 VARCHAR(25),word3 VARCHAR(25),year SMALLINT,words MEDIUMINT,
    pages TINYINT,books MEDIUMINT, INDEX (word1 (15) ,word3(15),word2 (15),year,words)) 
DATA DIRECTORY = "/media/omoo/mysql" INDEX DIRECTORY = "/media/omoo/mysql";


LOAD DATA LOCAL INFILE '/media/Iomega HDD/3grams1.txt' INTO TABLE 3grams1;
LOAD DATA LOCAL INFILE '/media/Iomega HDD/3grams2.txt' INTO TABLE 3grams2;
