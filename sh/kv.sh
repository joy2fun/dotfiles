#!/bin/bash

cd ~/temp

git clone git@github.com:joy2fun/kv.git

cd kv

g++ -o kv -DHAVE_MMAP kv.cpp md5.cpp indexfile.cpp levenshtein.cpp

mv kv ~/bin
