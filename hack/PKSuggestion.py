#!/usr/bin/python
# -*- coding: UTF-8 -*-
import re
from mysqlConnect import MysqlConnect 


clasee PKSuggestion:
	def __init__(self):
		conn = MysqlConnect.get_instance('db')
		
	def get_PlayerProperties(conn,table,index,value):
		if not conn:
			return;
		db = conn.db;
		cursor = conn.db.cursor();
		sql = "SELECT * FROM %s WHERE %s = %s" % (table,index,value);
		try:
			cursor.execute(sql);
			data = cursor.fetchone();
			#print(data);
			return data;
		except:
			print "Error: unable to fecth data!!!";

	def start_suggestion(str):
		if re.search(u'PK',str):
			data = get_PlayerProperties(conn,'t_player','name',"'吴鸭子'");
			level = data[4];
			money = data[8];
			weapon = data[10];
			armour = data[12];
			weaponlevel = data[11];
			armourlevel = data[13];
			skilllevel = data[14];
			itemid = data[15];
			vip = data[9];
			playerid = data[0];
		
			my_suggestion = money_spend_suggestion(playerid,level,money,weapon,armour,weaponlevel,armourlevel,skilllevel,vip);
			#print(my_suggestion);
			return my_suggestion;
		return '';
	
	def get_sectDescriptions(selfid, oppid):
	
	