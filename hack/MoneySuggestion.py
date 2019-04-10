#!/usr/bin/python
# -*- coding: UTF-8 -*-
import re

class MoneySuggestion:
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
	
	def get_PlayerProperties(self,table,index,value):
		sql = "SELECT * FROM %s WHERE %s = %s" % (table,index,value)
		return self.select_db_data(sql)

	def get_next_level_equip(self,eclass,etype,ereq,money):
		sql = "SELECT name, cost FROM t_equipment WHERE class = %d AND type = %d AND require_level = %d AND cost < %d ORDER BY cost DESC" % (eclass,etype,ereq,money)
		return self.select_db_data(sql)

	def get_bag_item(self,itemid,playerid):
		sql = "SELECT name, number FROM t_bag WHERE itemid = %d AND belong = %d" % (itemid,playerid)
		return self.select_db_data(sql)
		
	def get_cost_factor(self,attack = 0,defend = 0,health = 0):
		return 1.5*attack + 1.2*defend + 2*health

	def get_skill_str(self,level,money,itemlevel):
		money_left = money
		cost_factor = 0
		str = ''
		cost_factor = self.get_cost_factor(100)
		cur = itemlevel
		while cur < level:
			if cur*cost_factor <= money_left:
				money_left =  money_left - cur*cost_factor
				cur = cur + 1
			else:
				break
		if cur == level:
			str = u'将技能升至人物等级 '
		elif cur > itemlevel:
			str = u'将技能升至%d级 '%cur
		return str
			
	def get_equipment_str(self,playerid,level,money,itemlevel,name,eid,vip):
		str = ''
		#获取装备数据
		data = self.get_PlayerProperties('t_equipment','id',eid)
		name = data[1]
		eclass = data[2]
		etype = data[8]
		req_level = data[9]
		if (req_level + 10 <= level) and (req_level <= 50):
			#可以更换下一等级装备
			equip = self.get_next_level_equip(eclass,etype,req_level+10,money)
			if equip:
				#equipdata = equip[0]
				str = u'建议购买高级装备%s替换现有装备%s，需要金币%d '%(equip[0],name,equip[1])
				return str
		if itemlevel < level:
			if req_level < 30:
				itemid = 1
			else:
				itemid = 2
			itemid = (eclass-1)*2+itemid
			item = self.get_bag_item(itemid,playerid)
			if item != None:
				num = item[1]
				need = (level-1+itemlevel)*(level-itemlevel)/2 - num
				if need > 0:
					str = u'建议购买%d个%s将现有装备%s提升至人物等级 '%(need,item[0],name)
					return str
		
			
	def money_spend_suggestion(self,playerid,level,money,weapon,armour,wlevel,alevel,slevel,vip):
		str = u'推荐方案如下: '
		money_left = money
		#技能升级
		if level > slevel:
			str = str+self.get_skill_str(level,money,slevel)
		#装备更换/升级
		if level > wlevel:
			str = str+self.get_equipment_str(playerid,level,money,wlevel,'weapon',weapon,vip)
		#防具更换/升级
		if level > alevel:
			str = str+self.get_equipment_str(playerid,level,money,alevel,'armour',armour,vip)
		#药品购买
		#购买套装
		return str
		
	def start_suggestion(self,name,str):
		if re.search(u'购物方案',str):
			if len(name) <= 0:
				name = "'吴鸭子'"
			data = self.get_PlayerProperties('t_player','name',name)
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
			
			my_suggestion = self.money_spend_suggestion(playerid,level,money,weapon,armour,weaponlevel,armourlevel,skilllevel,vip)
			#print(my_suggestion)
			return my_suggestion
		return ''
	
if __name__ == '__main__':
	print('11111')
	#obj = MoneySuggestion()
	#str = obj.start_suggestion(u'我需要一个购物方案啊啊啊')
	#print(str)
	
	
	
	

