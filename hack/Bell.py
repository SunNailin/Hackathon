#!/usr/bin/python
# -*- coding: UTF-8 -*-
import re
import sys

class Activity:
	def __init__(self,conn):
		self.conn = conn
		#self.act = []
		#self.get_act_config(self)
	
	'''def get_act_config(self):
		if os.path.exists('act.txt'):
			f = open('act.txt','r')
			index = 0
			while(data = f.readline()):
				item = data.replace('\n','')
				item = item.strip()
				info = item.split(',')
				self.act[index] = info
				index += 1
			f.close()'''
	
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
	
	def set_act(self,data):
		str = u'今天的活动时间如下：'
		index = 0
		for item in data:
			#self.act[index] = []
			#self.act[index][0] = item[1]
			#self.act[index][1] = item[2]
			time = item[2].split(':')
			hour = time[0]
			min = time[1].replace('00','0')
			str += u'活动%d,%s,开始时间:%s点%s分.'%(index+1,item[1],hour,min)
			index += 1
		str += u'需要预约活动吗？预约后活动开始前我会提醒呀.'
		return str	
	def start_suggestion(self,str):
		ans = ''
		if (re.search(u'全部',str) or re.search(u'所有',str)) and re.search(u'活动',str) and re.search(u'时间',str):
			sql = "SELECT * FROM t_activities"
			data = self.select_db_data_all(sql)
			ans = self.set_act(data)
		elif re.search(u'活动',str) and re.search(u'时间',str):
			pass
		return ans	