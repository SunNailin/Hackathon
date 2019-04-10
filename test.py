#!/usr/bin/python
# -*- coding: UTF-8 -*-
from hack.MoneySuggestion import MoneySuggestion

if __name__ == '__main__':
	obj = MoneySuggestion();
	str = obj.start_suggestion(u'我需要一个购物方案啊啊啊');
	print(str);