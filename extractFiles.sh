#!/bin/sh

#A regular expression to only match lexical three grams; allowed to en with a quote. The rest is disposable. 
#Well, the sed to replace spaces with tabs is good, but obvious.

find . -name '*3gram*.zip' | xargs gunzip -c | egrep "^[A-Za-z][a-z']* [-A-Za-z][a-z']* [A-Za-z][a-z']*\s" | sed 's/\s/\t/gi' >> 3grams.txt;