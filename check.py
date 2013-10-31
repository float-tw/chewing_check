#!/usr/bin/env python
# -*- coding: utf-8 -*-

import codecs
import locale
import sys

# Wrap sys.stdout into a StreamWriter to allow writing unicode.
sys.stdout = codecs.getwriter(locale.getpreferredencoding())(sys.stdout) 

moedict_f = codecs.open('./moedict_bopomo', 'r', 'utf-8')
tsi_src_f = codecs.open('./tsi.src', 'r', 'utf-8')
#tsi_src_f = codecs.open('./test.src', 'r', 'utf-8')

line_num = 0
moe_index = 0

tsi_src = sorted(tsi_src_f)
moedict = sorted(moedict_f)
moedict_f.close()
tsi_src_f.close()

moe = moedict[ moe_index ]
moe_split = moe.split(u' ')
moe_word = moe_split[0]

for line in tsi_src:
	line_num += 1
	sp_line = line.split(u' ')
	word = sp_line[0]
	zhu_yin = u' '.join(sp_line[2:]).rstrip()

	while moe_word < word:
		try:
			moe_index += 1
			moe = moedict[ moe_index ]
			moe_split = moe.split(u' ')
			moe_word = moe_split[0]
		except IndexError:
			break

	if len(moe_word) == 1:
		continue
	elif moe_word == word:
		moe_zhu_yin = u' '.join(moe_split[1:]).rstrip()
		if moe_zhu_yin != zhu_yin:
			print u'{} [{}] [{}]'.format(word, zhu_yin, moe_zhu_yin)
	else:
		pass

print line_num
