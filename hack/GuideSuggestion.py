#!/usr/bin/python
# -*- coding: UTF-8 -*-
import re


class GuideSuggestion:
    def __init__(self, conn):
        self.conn = conn

    def select_db_data(self, sql):
        db = self.conn.db
        cursor = self.conn.db.cursor()
        try:
            cursor.execute(sql)
            data = cursor.fetchone()
            return data
        except:
            print('Error: unable to fecth data!!!' + sql)

    def get_PlayerProperties(self, table, index, value):
        sql = "SELECT * FROM %s WHERE %s = %s" % (table, index, value)
        # print(sql)
        return self.select_db_data(sql)

    def start_suggestion(self, selfName, str):
        if re.search(u'改名', str):
            # print(selfName)
            selfData = self.get_PlayerProperties('t_player', 'name', selfName)
            level = selfData[4]
            if selfData is not None:
                selfId = selfData[0]
                return self.get_change_name_suggest(selfId);
        elif re.search(u'世界', str):
            print(selfName)
            selfData = self.get_PlayerProperties('t_player', 'name', selfName)
            level = selfData[4]
            if selfData is not None:
                return self.get_world_suggest(level);
        elif re.search(u'操作', str):
            return self.get_joystick_suggest();
        return '';

    def get_change_name_suggest(self, id):
        sql = "SELECT * FROM t_bag WHERE belong = %s and itemid = 10" % id
        data = self.select_db_data(sql)
        res = u'少侠需要改名的话，可以在主界面单击头像，在弹出的界面单击改名按钮，消耗改名卡道具完成改名。'
        res0 = ''
        if data is None:
            res0 = u'少侠身上没有改名卡道具，是否现在立即购买。'
        else:
            # print(data)
            number = data[4]
            res0 = u'少侠身上有%s张改名卡道具，是否立即打开改名界面。' % number
        return res + res0

    def get_world_suggest(self, level):
        res = u'少侠所处的武侠世界是小腰派，生锈派，舔山派，丐帮，烧林寺，地龙寺六大门派纷争的世界。';
        res0 = u'少侠现在等级为%s级，' % level
        res1 = ''
        if  level > 45 :
            res1 = u'实在是威震武林。'
        elif level < 10 :
            res1 = u'尚需历练才是。'
        else:
            res1 = u'可以执剑行走江湖。'
        return res + res0 + res1

    def get_joystick_suggest(self):
        return u'现在闪烁着的是移动摇杆，少侠可以用手指控制角色前后左右移动。' \
               u'现在闪烁的是角色的普通攻击按钮，少侠可在技能之间衔接普通攻击。' \
               u'现在闪烁的是角色的绝技大招按钮，少侠可用它绝地反击扭转败局或者一招制胜压制对手。' \
               u'现在闪烁的是角色的技能按钮，少侠可施展多种技能，或攻或守，任您选择。'

if __name__ == '__main__':
    obj = GameAssistant()
    ques = sys.argv[1]
    if ques == None:
        ques = u'你好，我是吴鸭子'
    # print(ques)
    str = obj.question_begin(ques)
    print(str)



