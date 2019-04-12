#!/usr/bin/python
# -*- coding: UTF-8 -*-
import re
import sys

class CultivateSuggestion:
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
			print('Error: unable to fecth data!!!')
			sys.exit()
	
	def select_db_data_all(self,sql):
		db = self.conn.db
		cursor = self.conn.db.cursor()
		try:
			cursor.execute(sql)
			data = cursor.fetchall()
			return data
		except:
			print('Error: unable to fecth data!!!')
			sys.exit()	
	
	def get_level_str(self,level):
		sql = "SELECT name,require_level FROM t_stage"
		data = self.select_db_data_all(sql)
		num = 0;
		for item in data:
			if level >= item[1]:
				num = num + 1;
		str = u'少侠当前等级为%d级 '%level
		if num < len(data):
			str += '当前可进入场景%d个,可以通过完成任务、通关副本等方式提升等级,下一场景%s等级要求为%d级,少侠请再接再厉！'%(num,data[num][0],data[num][1])
		else:
			str += '天下之大随处可去！'
		return str
		
	def get_equip_str(self,level,equip,equiplevel):
		str = ''
		#获取装备数据
		sql = "SELECT * FROM t_equipment WHERE id = %s" % (equip)
		data = self.select_db_data(sql)
		name = data[1]
		eclass = data[2]
		req_level = data[9]
		type = u'武器' if eclass < 2 else u'防具'
		if (req_level + 10 <= level) and (req_level < 50):
			#可以更换下一等级装备
			str = u'少侠的%s用的太久了,可以更换更高级的%s '%(name,type)
			return str
		if equiplevel < level:
			str = u'少侠的%s%s等级太低了,快去升级吧 '%(type,name)
			return str
		return str
	
	def get_skill_str(self,level,skilllevel):
		if level > skilllevel:
			return u'少侠的技能等级太低了,快去升级吧 '
		return ''
	
	def get_sect_str(self,sect):
		sql = "SELECT * FROM t_sects WHERE id = %d"%sect
		data = self.select_db_data(sql)
		name = data[1]
		des = data[7]
		des = re.sub(u'我方',' ',des,1)
		str = u'少侠的师门是%s%s选购装备时可以根据门派特性变换搭配。'%(name,des)
		return str
	
	def get_achieve_str(self,achieve):
		str = ''
		sql = "SELECT * FROM t_achievements WHERE id = %d"%achieve
		data = self.select_db_data(sql)
		name = data[1]
		progress = data[2]
		des = data[3]
		str = u'少侠当前目标成就%s:%s进度为百分之%d '%(name,des,progress)
		if progress > 90:
			str += u'就差一步啦,加油加油！'
		else:
			str += u'请继续努力。'
		return str
	
	def cultivate_suggestion(self,playerid,level,money,weapon,armour,weaponlevel,armourlevel,skilllevel,vip,sect,achieve):
		ans = ''
		#等级相关
		ans += self.get_level_str(level)
		#技能相关
		ans += self.get_skill_str(level,skilllevel)
		#装备相关
		ans += self.get_equip_str(level,weapon,weaponlevel)
		ans += self.get_equip_str(level,armour,armourlevel)
		#门派建议
		ans += self.get_sect_str(sect)
		#成就建议
		if achieve > 0:
			ans += self.get_achieve_str(achieve)
		#vip建议
		if vip > 0:
			ans += u'作为一名响当当的大侠,没有一件专属vip套装怎么行呢，快去商店看看吧！'
		return ans
		
	def start_suggestion(self,name,str):
		if (re.search(u'养成',str) or re.search(u'成长',str) ) and ((re.search(u'方案',str) or re.search(u'建议',str))):
			if len(name) <= 0:
				return u'少侠哪位啊'
			sql = "SELECT * FROM t_player WHERE name = %s" % name
			data = self.select_db_data(sql)
			sect = data[3]
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
			achieve = data[17]
			
			my_suggestion = self.cultivate_suggestion(playerid,level,money,weapon,armour,weaponlevel,armourlevel,skilllevel,vip,sect,achieve)
			#print(my_suggestion)
			return my_suggestion
		return ''

if __name__ == '__main__':
	print('11111')
	#obj = CultivateSuggestion()
	#str = obj.start_suggestion(u'我需要一个购物方案啊啊啊')
	#print(str)	
