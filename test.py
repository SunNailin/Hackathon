#!/usr/bin/python
# -*- coding: UTF-8 -*-
import MySQLdb

db = MySQLdb.connect("localhost","root","12345","gamehelper",charset='utf8')
cursor = db.cursor()
sql = """INSERT INTO Player(name,sex,profession,money,level,attack,defend,health,vip,weapon,armour,weaponlevel,armourlevel,skilllevel)
	VALUES ('Lily',1,2,90000,5,150,120,300,1,2,10,3,4,4)"""
try:
	cursor.execute(sql)
	db.commit()
	print "done!"
except:
	db.rollback()
	print "failed!"
db.close()