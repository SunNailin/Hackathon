#!/usr/bin/python
# -*- coding: UTF-8 -*-
import sys
from hack.GameAssistant import GameAssistant
from hack.mysqlConnect import MysqlConnect 
if __name__ == '__main__':
	obj = GameAssistant()
	ques = sys.argv[1]
	if ques == None:
		ques = u'你好，我是吴鸭子'
	print(ques)
	str = obj.question_begin(ques)
	print(str)
	'''conn = MysqlConnect.get_instance('db')
	db = conn.db
	cursor = db.cursor()
	str = '"王大锤"'
	sql = "SELECT * FROM t_player WHERE name = %s"%(str)
	print(sql)
	try:
		cursor.execute(sql)
		data = cursor.fetchone()
		print("success!")
	except:
		print('Error: unable to fecth data!!!')'''