#!/bin/bash

moe_bopomo="moedict_bopomo"

wget http://kcwu.csie.org/~kcwu/tmp/moedict/development.sqlite3.bz2
bzip2 -d development.sqlite3.bz2

sqlite3 development.sqlite3 'SELECT title, heteronyms.bopomofo
							FROM entries
							JOIN heteronyms ON entry_id = entries.id;' > $moe_bopomo

sed -i 's/\(^.*\)|\(.*\)　(變)\(.*\)/\1|\2\n\1|　\3/' $moe_bopomo
sed -i 's/　/\ /g' $moe_bopomo
sed -i 's/^\(.*\)|\ \?/\1\ /' $moe_bopomo
sed -i 's/｜/ㄧ/g' $moe_bopomo
sed -i 's/˙\(\S\+\)/\1˙/g' $moe_bopomo
sed -i 's/(.*)//g' $moe_bopomo
sed -i 's/（.*）//g' $moe_bopomo
sed -i 's/[㊀㊁㊂㊃]//g' $moe_bopomo
