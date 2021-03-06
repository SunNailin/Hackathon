﻿#!/usr/bin/python
# -*- coding: UTF-8 -*-
import pymysql
import sys
class MysqlConnect:
	instance = None
	
	def __init__(self,name):
		self.name = name
		try:
			self.db = pymysql.connect("localhost","root","root","Hackathon",charset='utf8')
			self.cursor = self.db.cursor()
		except:
			print('db connect failed!!!')
			sys.exit()
	
	def __del__(self):
		if hasattr(self,'db') and self.db is not None:
			self.db.close()
			self.cursor.close()
	
	@classmethod
	def get_instance(cls,name):
		if cls.instance:
			return cls.instance
		else:
			obj = cls(name)
			cls.instance = obj
			return obj

if __name__ == '__main__':
	conn1 = MysqlConnect.get_instance('db')
	conn2 = MysqlConnect.get_instance('sb2')
	print(conn1)
	print(conn2)


	