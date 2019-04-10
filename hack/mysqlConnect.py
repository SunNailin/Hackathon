#!/usr/bin/python
# -*- coding: UTF-8 -*-
import pymysql

class MysqlConnect:
	instance = None
	
	def __init__(self,name):
		self.name = name
		self.db = pymysql.connect("localhost","root","12345","Hackathon",charset='utf8')
		self.cursor = self.db.cursor()
	
	def __del__(self):
		if self.db != None:
			self.db.close()
			self.cursor = None
	
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


	