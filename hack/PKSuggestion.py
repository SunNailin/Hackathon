#!/usr/bin/python
# -*- coding: UTF-8 -*-
import re

class PKSuggestion:
	def __init__(self,conn):
		self.conn = conn
		
	def select_db_data(self,sql):
		db = self.conn.db
		cursor = self.conn.db.cursor()
		try:
			cursor.execute(sql)
			data = cursor.fetchone()
			return data
		except:
			print('Error: unable to fecth data!!!' + sql)
	
	def get_PlayerProperties(self,table,index,value):
		sql = "SELECT * FROM %s WHERE %s = %s" % (table,index,value)
		return self.select_db_data(sql)
		
	def get_SectPropertyByIndex(self, property, id):
		sql = "SELECT %s FROM t_sects WHERE id = %s" % (property, id)
		return self.select_db_data(sql)

	def get_sectDescriptions(self, selfId, oppId):
		selfData = self.get_PlayerProperties('t_player', 'id', selfId)
		oppData = self.get_PlayerProperties('t_player', 'id', oppId)
		selfSect = selfData[3]
		oppSect = oppData[3]
		selfDesc = self.get_SectPropertyByIndex('pk_self', selfSect)[0]
		oppDesc = self.get_SectPropertyByIndex('pk_opp', oppSect)[0]
		print(selfDesc + oppDesc)
		return selfDesc + oppDesc
		
	def start_suggestion(self, str):
		if re.search(u'PK',str):
			data = self.get_PlayerProperties('t_player','name',"'吴鸭子'")
			level = data[4]
			money = data[8]
			weapon = data[10]
			armour = data[12]
			weaponlevel = data[11]
			armourlevel = data[13]
			skilllevel = data[14]
			itemid = data[15]
			vip = data[9]
			playerid = data[0]
		
			my_suggestion = self.get_sectDescriptions(playerid, playerid)
			#print(my_suggestion)
			return my_suggestion
		return '';
			
if __name__ == '__main__':
	obj = PKSuggestion(conn)
	str = obj.start_suggestion(u'嗷嗷PK嗷嗷')
	print(str)
		
		
	
	