#!/usr/bin/python
# -*- coding: UTF-8 -*-
import re


class QuestSuggestion:
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
        if re.search(u'任务', str) or re.search(u'副本', str) :
            # print(selfName)
            selfData = self.get_PlayerProperties('t_player', 'name', selfName)
            selfId = selfData[0]
            selfLevel = selfData[4]
            my_SectSuggestion = self.get_quest_suggest(selfId, selfLevel)
            return my_SectSuggestion
        return '';

    def get_quest_suggest(self , playerid , level):
        sql = "SELECT * FROM t_stage where require_level < %s  order by require_level desc" % (level)
        stageData = self.select_db_data(sql)
        if stageData is not None:
            stageName = stageData[1]
            questStr = "当前最适合您的副本是%s，大侠快去闯荡一番吧" % stageName
            return questStr
        else:
            return "少侠还需多历练才是";

if __name__ == '__main__':
    obj = QuestSuggestion(conn)
    str = obj.start_suggestion(u'嗷嗷PK嗷嗷')
    print(str)



