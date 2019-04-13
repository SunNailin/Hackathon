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
		#print(sql)
		return self.select_db_data(sql)
		
	def get_SectPropertyByIndex(self, property, id):
		sql = "SELECT %s FROM t_sects WHERE id = %s" % (property, id)
		#print(sql)
		return self.select_db_data(sql)
		
	def get_EquipmentProperties(self, property, attribute, class_, type, level):
		sql = "SELECT %s FROM t_equipment WHERE attribute = %s AND class = %s AND require_level <= %s AND type = %s ORDER BY require_level DESC LIMIT 1" % (property, attribute, class_, level, type)
		#print(sql)
		return self.select_db_data(sql);

	def get_sectDescriptions(self, selfId, oppId):
		selfData = self.get_PlayerProperties('t_player', 'id', selfId)
		oppData = self.get_PlayerProperties('t_player', 'id', oppId)
		selfSect = selfData[3]
		oppSect = oppData[3]
		#print(selfSect)
		#print(oppSect)
		selfDesc = self.get_SectPropertyByIndex('pk_self', selfSect)[0]
		#print(selfDesc)
		oppDesc = self.get_SectPropertyByIndex('pk_opp', oppSect)[0]
		#print(selfDesc + oppDesc)
		return selfDesc + oppDesc
	
	def get_StageProrerties(self, property, id):
		sql = "SELECT %s FROM t_stage WHERE id = %s" % (property, id)
		return self.select_db_data(sql)
		
	def get_EquipmentRecommend(self, selfData, oppData):
		selfId = selfData[0]
		oppId = oppData[0]
		selfLevel = selfData[4]
		oppLevel = oppData[4]
		selfSect = selfData[3]
		oppSect = oppData[3]
		selfAttribute = self.get_SectPropertyByIndex('attribute', selfSect)[0]
		oppAttribute = self.get_SectPropertyByIndex('attribute', oppSect)[0]
		#print(oppAttribute)
		selfType = self.get_SectPropertyByIndex('type', selfSect)[0]
		oppType = self.get_SectPropertyByIndex('type', oppSect)[0]
		
		if(selfLevel + 15 < oppLevel):
			return "对方等级高你太多了，别鸡蛋碰石头了"
		elif(oppLevel + 20 < selfLevel):
			return "你等级高对方很多，基本可以虐他，就不给你建议了哈"
		else:
			weaponName = self.get_EquipmentProperties('name', selfAttribute, '1', selfType, selfLevel)[0]
			weaponDesc = self.get_EquipmentProperties('description', selfAttribute, '1', selfType, selfLevel)[0]
			weaponGetway = self.get_EquipmentProperties('get_way', selfAttribute, '1', selfType, selfLevel)[0]
			weaponStageName = self.get_StageProrerties('name', weaponGetway)[0]
			weaponStr = "当前最适合您的装备是%s,可以在%s获得，" % (weaponName, weaponStageName)
			
			armorName = self.get_EquipmentProperties('name', oppAttribute, '2', 0, selfLevel)[0]
			armorDesc = self.get_EquipmentProperties('description', oppAttribute, '2', 0, selfLevel)[0]
			armorGetway = self.get_EquipmentProperties('get_way', oppAttribute, '2', 0, selfLevel)[0]
			#print(armorGetway)
			armorStageName = self.get_StageProrerties('name', armorGetway)[0]
			oppAttributeDesc = "无"
			#print(oppAttribute)
			if(oppAttribute == 1):
			  oppAttributeDesc = "冰"
			elif(oppAttribute == 2):
			  oppAttributeDesc = "火"
			elif(oppAttribute == 3):
			  oppAttributeDesc = "毒"  
			armorStr = "你最好装备上%s,可防对方%s属性攻击，在%s副本掉落。" % (armorName, oppAttributeDesc, armorStageName)
			#print(weaponStr)
			return weaponStr + armorStr;
		
	def start_suggestion(self, str, selfName, oppName):
		if re.search(u'PK',str) or re.search(u'pk',str):
			#print(selfName)
			selfData = self.get_PlayerProperties('t_player','name', selfName)			
			selfId = selfData[0]
			oppData = self.get_PlayerProperties('t_player','name', oppName)
			oppId = oppData[0]
			my_SectSuggestion = self.get_sectDescriptions(selfId, oppId)
			my_equipmentRecommend = self.get_EquipmentRecommend(selfData, oppData)
			#print(my_SectSuggestion + my_equipmentRecommend)
			#print(my_suggestion)
			return my_SectSuggestion + my_equipmentRecommend
		return '';
			
if __name__ == '__main__':
	obj = PKSuggestion(conn)
	str = obj.start_suggestion(u'嗷嗷PK嗷嗷')
	print(str)
		
		
	
	