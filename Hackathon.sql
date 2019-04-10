/*
Navicat MySQL Data Transfer

Source Server         : Root
Source Server Version : 80015
Source Host           : localhost:3306
Source Database       : hackathon

Target Server Type    : MYSQL
Target Server Version : 80015
File Encoding         : 65001

Date: 2019-04-09 18:17:05
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for t_achievements
-- ----------------------------
DROP TABLE IF EXISTS `t_achievements`;
CREATE TABLE `t_achievements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(40) DEFAULT NULL,
  `progress` int(10) unsigned DEFAULT '0' COMMENT '完成进度 百分数',
  `des` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_achievements
-- ----------------------------
INSERT INTO `t_achievements` VALUES ('1', '高处不胜寒', '0', '连续赢得10场pk');
INSERT INTO `t_achievements` VALUES ('2', '冒险家', '80', '通关10次副本');
INSERT INTO `t_achievements` VALUES ('3', '视死如归', '99', '死亡100次');

-- ----------------------------
-- Table structure for t_bag
-- ----------------------------
DROP TABLE IF EXISTS `t_bag`;
CREATE TABLE `t_bag` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '物品序号',
  `itemid` int(11) unsigned DEFAULT '1' COMMENT '物品id',
  `name` varchar(255) DEFAULT NULL,
  `type` tinyint(4) DEFAULT '1' COMMENT '1-道具 2-装备',
  `number` int(11) unsigned DEFAULT '1' COMMENT '物品数量',
  `belong` int(11) unsigned DEFAULT '1' COMMENT '角色id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_bag
-- ----------------------------
INSERT INTO `t_bag` VALUES ('1', '1', '青铜矿', '1', '40', '1');
INSERT INTO `t_bag` VALUES ('2', '3', '粗棉布', '1', '18', '1');

-- ----------------------------
-- Table structure for t_equipment
-- ----------------------------
DROP TABLE IF EXISTS `t_equipment`;
CREATE TABLE `t_equipment` (
  `id` int(11) NOT NULL COMMENT '装备ID，非自增',
  `name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '装备名',
  `class` tinyint(4) DEFAULT NULL COMMENT '装备分类1武器，2防具',
  `attribute` tinyint(4) DEFAULT NULL COMMENT '装备属性冰火毒123',
  `defence_base` int(11) DEFAULT NULL COMMENT '基础防御',
  `attack_base` int(11) DEFAULT NULL COMMENT '基础攻击',
  `defence_growth` int(11) DEFAULT NULL COMMENT '防御成长',
  `attack_growth` int(11) DEFAULT NULL COMMENT '攻击成长',
  `type` tinyint(4) DEFAULT NULL COMMENT '装备类型1内功2外功',
  `require_level` tinyint(4) DEFAULT NULL COMMENT '需要等级',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '装备描述',
  `vip_level` tinyint(4) DEFAULT NULL COMMENT '需求的vip等级',
  `pk_description_self` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'PK时对自己描述性的话',
  `pk_description_opp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'PK时作为对手描述性的话',
  `cost` int(11) DEFAULT '0' COMMENT '售价',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_equipment
-- ----------------------------
INSERT INTO `t_equipment` VALUES ('1', '小冰刀', '1', '1', '10', '100', '1', '10', '2', '0', '冰属性的内功小刀', '0', null, null, '500');
INSERT INTO `t_equipment` VALUES ('2', '大冰刀', '1', '1', '10', '100', '1', '10', '2', '10', '冰属性的外功大刀', '0', '', '', '4000');
INSERT INTO `t_equipment` VALUES ('3', '王八壳', '2', '1', '1', '1', '1', '1', '2', '0', null, '0', null, null, '600');
INSERT INTO `t_equipment` VALUES ('4', '千年王八壳', '2', '1', '1', '1', '1', '1', '2', '10', null, '0', null, null, '5000');

-- ----------------------------
-- Table structure for t_item
-- ----------------------------
DROP TABLE IF EXISTS `t_item`;
CREATE TABLE `t_item` (
  `id` int(11) NOT NULL COMMENT '道具ID，主键非自增\r\n',
  `name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '道具名称',
  `说明` varchar(255) DEFAULT NULL COMMENT '攻击',
  `stage` int(10) DEFAULT NULL COMMENT '掉落场景 0则不在副本获取',
  `cost` int(30) DEFAULT '0' COMMENT '商店售价 0则不在商店出售',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_item
-- ----------------------------
INSERT INTO `t_item` VALUES ('1', '青铜矿', '30级以下武器升级道具', '1', '200');
INSERT INTO `t_item` VALUES ('2', '玄铁矿', '60级以下武器升级道具', '2', '800');
INSERT INTO `t_item` VALUES ('3', '粗棉布', '30级以下防具升级道具', '1', '180');
INSERT INTO `t_item` VALUES ('4', '毛皮', '60级以下防具升级道具', '2', '820');
INSERT INTO `t_item` VALUES ('5', '紫金矿', 'vip武器升级道具', '0', '1500');
INSERT INTO `t_item` VALUES ('6', '天蚕丝', 'vip防具升级道具', '0', '1500');
INSERT INTO `t_item` VALUES ('7', '止血草', '加血10%', '1', '300');

-- ----------------------------
-- Table structure for t_pet
-- ----------------------------
DROP TABLE IF EXISTS `t_pet`;
CREATE TABLE `t_pet` (
  `id` int(11) NOT NULL COMMENT '主键ID，自增',
  `playerId` int(11) NOT NULL COMMENT '玩家ID',
  `attack_growth` int(11) DEFAULT NULL COMMENT '宠物攻击',
  `defence_growth` int(11) DEFAULT NULL COMMENT '宠物防御成长值',
  `hp` int(11) DEFAULT NULL COMMENT '宠物生命成长值',
  `level` tinyint(4) DEFAULT NULL COMMENT '宠物等级',
  `player_attack_growth` int(11) DEFAULT NULL COMMENT '给玩家的攻击增益成长值',
  `player_defence_growth` int(11) DEFAULT NULL COMMENT '给玩家的防御增益成长值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_pet
-- ----------------------------

-- ----------------------------
-- Table structure for t_player
-- ----------------------------
DROP TABLE IF EXISTS `t_player`;
CREATE TABLE `t_player` (
  `id` int(11) NOT NULL COMMENT '主键ID，自增',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名',
  `gender` tinyint(4) DEFAULT '0' COMMENT '性别',
  `sect` tinyint(4) DEFAULT NULL COMMENT '门派',
  `level` tinyint(4) DEFAULT NULL COMMENT '等级',
  `attack` int(10) DEFAULT NULL COMMENT '攻击力',
  `defence` int(10) DEFAULT NULL COMMENT '防御力',
  `hp` int(10) DEFAULT NULL COMMENT '生命',
  `money` int(10) DEFAULT NULL COMMENT '金钱',
  `vip` int(10) DEFAULT NULL COMMENT 'vip等级',
  `weapon_id` int(10) DEFAULT NULL COMMENT '武器ID',
  `weapon_level` tinyint(4) DEFAULT NULL COMMENT '武器强化等级',
  `armor_id` int(10) DEFAULT NULL COMMENT '防具ID',
  `armor_level` tinyint(4) DEFAULT NULL COMMENT '防具强化等级',
  `skill_level` tinyint(4) DEFAULT '1' COMMENT '技能1等级',
  `item` tinyint(4) unsigned DEFAULT '0' COMMENT '背包物品存在',
  `force` int(11) DEFAULT '0' COMMENT '玩家战力',
  `achievement` int(10) DEFAULT '0' COMMENT '当前目标成就',
  UNIQUE KEY `id` (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_player
-- ----------------------------
INSERT INTO `t_player` VALUES ('1', '吴鸭子', '1', '1', '18', '1100', '500', '500', '10000', '0', '2', '11', '3', '5', '10', '0', '0', '1');
INSERT INTO `t_player` VALUES ('2', '梁朝伟', '1', '2', '25', '3200', '2400', '2800', '100000', '1', '2', '12', '1', '4', '23', '0', '0', '2');

-- ----------------------------
-- Table structure for t_sects
-- ----------------------------
DROP TABLE IF EXISTS `t_sects`;
CREATE TABLE `t_sects` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT '门派ID，主键，自增',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '门派名',
  `type` int(8) unsigned NOT NULL COMMENT '攻击类型，1外功，2内功',
  `attribute` int(8) unsigned DEFAULT NULL COMMENT '门派属性，1冰，2火，3毒',
  `attack_growth` int(8) DEFAULT NULL COMMENT '攻击成长',
  `defence_growth` int(8) DEFAULT NULL COMMENT '防御成长',
  `hp_growth` int(8) DEFAULT NULL COMMENT 'hp成长',
  `pk_self` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'pk时自己的描述',
  `pk_opp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT 'pk时对手的描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_sects
-- ----------------------------
INSERT INTO `t_sects` VALUES ('1', '小腰派', '1', '1', '11', '5', '5', null, null);
INSERT INTO `t_sects` VALUES ('2', '生锈派', '1', '3', '8', '6', '7', null, null);
INSERT INTO `t_sects` VALUES ('3', '舔山派', '2', '1', '7', '7', '7', null, null);
INSERT INTO `t_sects` VALUES ('4', '钙帮', '2', '3', '10', '6', '5', null, null);
INSERT INTO `t_sects` VALUES ('5', '烧林寺', '2', '2', '5', '8', '8', null, null);
INSERT INTO `t_sects` VALUES ('6', '地龙寺', '1', '2', '9', '6', '6', null, null);

-- ----------------------------
-- Table structure for t_shop
-- ----------------------------
DROP TABLE IF EXISTS `t_shop`;
CREATE TABLE `t_shop` (
  `id` int(11) NOT NULL COMMENT '自增id',
  `item_id` int(11) NOT NULL COMMENT '对应item表id',
  `price` int(11) DEFAULT NULL COMMENT '价格',
  `require_vip_level` tinyint(4) DEFAULT NULL COMMENT '需要VIP等级',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_shop
-- ----------------------------

-- ----------------------------
-- Table structure for t_stage
-- ----------------------------
DROP TABLE IF EXISTS `t_stage`;
CREATE TABLE `t_stage` (
  `id` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `require_level` tinyint(4) DEFAULT NULL COMMENT '需求等级',
  `drop_list` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL COMMENT '通关掉落列表',
  `recommend_force` int(11) DEFAULT NULL COMMENT '推荐战力',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of t_stage
-- ----------------------------