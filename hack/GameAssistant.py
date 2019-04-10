#!/usr/bin/python
# -*- coding: UTF-8 -*-
import re
from .mysqlConnect import MysqlConnect 
from .MoneySuggestion import MoneySuggestion

class GameAssistant:
	def __init__(self):
		self.name = ''
		self.pkname = ''
		self.get_config()
		self.conn = MysqlConnect.get_instance('db')
		self.moneySuggest = MoneySuggestion(self.conn)
		
	def set_config(self):
		f = open('save.txt','w')
		str = self.name+'\n'+self.pkname
		#print(str)
		f.write(str)
		f.close()
	
	def get_config(self):
		f = open('save.txt','r')
		name = f.readline().replace('\n','')
		pkname = f.readline().replace('\n','')
		f.close()
		name.strip()
		pkname.strip()
		self.name = name
		self.pkname = pkname
		#print(self.name)
		#print(self.pkname)
		
	def check_name_in_db(self,name):
		db = self.conn.db
		cursor = self.conn.db.cursor()
		sql = "SELECT * FROM t_player WHERE name = %s"%(name)
		#print(sql)
		try:
			cursor.execute(sql)
			data = cursor.fetchone()
			if data:
				return 1
		except:
			print('Error: unable to fecth data!!!')
		return 0;
	
	def get_name(self,str):
		name0 = re.findall(r'我是(.+)',str)
		name = name0[0].strip()
		name = '"'+name+'"'
		#print(name)
		str = '';
		if len(name) > 0:
			if name == self.name:
				return u'欢迎回来,%s少侠,有什么问题可以帮助你呢.'%name
			elif self.check_name_in_db(name) > 0:
				self.name = name
				self.set_config()
				return u'%s少侠你好,有什么问题可以帮助你呢.'%name
		return u'对不起,查询不到%s的信息,请少侠检查您的姓名'%name
	
	def	get_pk_name(self,str):
		name0 = re.findall(r'对手是(.+)',str)
		name = name0[0].strip()
		name = '"'+name+'"'
		str = '';
		if len(name) > 0:
			if name == self.name:
				return u'自己跟自己打？左右互搏啊！少侠好身手，我帮不了你了。'
			elif self.check_name_in_db(name) > 0:
				self.pkname = name
				self.set_config()
				return u'好的.少侠的对手是%s,我可以提供pk的相关建议哈.'%name
		return u'对不起,查询不到%s的信息,请少侠检查对手的姓名'%name
	
	def do_answer(self,str):
		ans = '';
		ans = ans + self.moneySuggest.start_suggestion(self.name,str)
		if len(ans) > 0:
			return ans
		return ans
		
	
	def question_begin(self,str):
		ans = ''
		if re.search(u'我是',str):
			return self.get_name(str)
		elif re.search(u'对手是',str):
			return self.get_pk_name(str)
		else:
			return self.do_answer(str)

if __name__ == '__main__':
	game = GameAssistant()
	game.question_begin(u'你好，我是王大锤')