#!/usr/bin/python
# -*- coding: UTF-8 -*-
import re
import sys
import time
class Activity:
	trans_word = [u'一',u'二',u'三',u'四',u'五',u'六',u'七',u'八',u'九',u'十']
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
	
	def get_actinfo_str(self,str):
		ans = ''
		idstr = re.findall(u'活动(.*?)的',str)
		if len(idstr) > 0:
			for index in range(len(self.trans_word)):
				if idstr[0] == self.trans_word[index]:
					idstr = index+1
					break;
			id = idstr
			sql = "SELECT * FROM t_activities WHERE id = %d"%(id)
			print(sql)
			data = self.select_db_data(sql)
			time = data[2].split(':')
			hour = time[0]
			min = time[1].replace('00','0')
			ans += u'活动%d,%s,距离活动开始还有%s小时%s分.'%(id,data[1],hour,min)
		return ans
			
	def subscribe_act_str(self,str):
		ans = ''
		idstr = re.findall(u'预约活动(.)',str)
		if len(idstr) > 0:
			for index in range(len(self.trans_word)):
				if idstr[0] == self.trans_word[index]:
					idstr= index+1
					break;
			id = idstr
			sql = "SELECT * FROM t_activities WHERE id = %d"%(id)
			data = self.select_db_data(sql)
			atime = data[2].split(':')
			hour = atime[0]
			min = atime[1].replace('00','0')
			localtime = time.localtime(time.time())
			hour_now = localtime.tm_hour
			min_now = localtime.tm_min
			sec_now = localtime.tm_sec
			dis = (int(hour)-hour_now)*60+int(min)-min_now
			#print(dis)
			hourdis = int(dis/60)
			mindis = dis-hourdis*60
			if hourdis <= 0:
				ans += u'已帮您预约活动%d,%s,距离活动开始还有%s分钟.'%(id,data[1],min)
			else:
				ans += u'已帮您预约活动%d,%s,距离活动开始还有%s小时%s分钟.'%(id,data[1],hourdis,mindis)
			#todo:把info传出去
			info = u'少侠，活动%s马上就要开始了，赶快去参加吧！'%data[1]
			seconds = (int(hour)-hour_now)*3600+(int(min)-min_now)*60-sec_now
			return (3,ans,seconds,info)
		return (0,'')
	
	def start_suggestion(self,str):
		ans = (0,'')
		if (re.search(u'全部',str) or re.search(u'所有',str)) and re.search(u'活动',str):
			sql = "SELECT * FROM t_activities"
			print(sql)
			data = self.select_db_data_all(sql)
			ans = self.set_act(data)
			ans = (1,ans)
		elif re.search(u'活动',str) and re.search(u'时间',str):
			ans = self.get_actinfo_str(str)
			ans = (1,ans)
		elif re.search(u'预约活动',str):
			ans = self.subscribe_act_str(str)
		return ans	