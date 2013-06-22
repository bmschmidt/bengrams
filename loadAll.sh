#!/usr/sh

#Download all the files. Even this could be streamed, but that's likely to be a nightmare.

#This creates a pipe and gets gunzip ready to run 

find . -name "*3grams*zip" | xargs -n 1 -I file sh -c "rm -f file.pipe; mkfifo file.pipe; gunzip -c file | sed 's/ /\t/g' > file.pipe &"

mkfifo /tmp/sqlLoadTable.pipe;

find . -name "*3grams*pipe" | xargs -n 10000 ./collate > /tmp/sqlLoadTable.pipe &

#Now that pipe can be loaded into sql without a single unzipped file ever cluttering the hard drive.

echo '
USE ngrams;
CREATE TABLE IF NOT EXISTS ngrams.3grams (word1 VARCHAR(20),word2 VARCHAR(20),word3 VARCHAR(20),year,words,books);
LOAD DATA LOCAL INFILE "/tmp/sqlLoadTable.pipe" INTO TABLE ngrams.3grams;
'