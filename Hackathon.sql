/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 80015
 Source Host           : localhost:3306
 Source Schema         : hackathon

 Target Server Type    : MySQL
 Target Server Version : 80015
 File Encoding         : 65001

 Date: 11/04/2019 21:16:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_achievements
-- ----------------------------
DROP TABLE IF EXISTS `t_achievements`;
CREATE TABLE `t_achievements`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `progress` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '完成进度 百分数',
  `des` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_achievements
-- ----------------------------
INSERT INTO `t_achievements` VALUES (1, '高处不胜寒', 0, '连续赢得10场pk');
INSERT INTO `t_achievements` VALUES (2, '冒险家', 80, '通关10次副本');
INSERT INTO `t_achievements` VALUES (3, '视死如归', 99, '死亡100次');

-- ----------------------------
-- Table structure for t_activities
-- ----------------------------
DROP TABLE IF EXISTS `t_activities`;
CREATE TABLE `t_activities`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'name',
  `time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'time',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_activities
-- ----------------------------
INSERT INTO `t_activities` VALUES (1, '剑气碧烟横', '9:00');
INSERT INTO `t_activities` VALUES (2, '商略平生义', '10:00');
INSERT INTO `t_activities` VALUES (3, '挥洒缚豪英', '11:00');
INSERT INTO `t_activities` VALUES (4, '红颜弹指老', '12:00');
INSERT INTO `t_activities` VALUES (5, '教单于折箭', '13:00');

-- ----------------------------
-- Table structure for t_bag
-- ----------------------------
DROP TABLE IF EXISTS `t_bag`;
CREATE TABLE `t_bag`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '物品序号',
  `itemid` int(11) UNSIGNED NULL DEFAULT 1 COMMENT '物品id',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `type` tinyint(4) NULL DEFAULT 1 COMMENT '1-道具 2-装备',
  `number` int(11) UNSIGNED NULL DEFAULT 1 COMMENT '物品数量',
  `belong` int(11) UNSIGNED NULL DEFAULT 1 COMMENT '角色id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_bag
-- ----------------------------
INSERT INTO `t_bag` VALUES (1, 1, '青铜矿', 1, 40, 1);
INSERT INTO `t_bag` VALUES (2, 3, '粗棉布', 1, 18, 1);

-- ----------------------------
-- Table structure for t_equipment
-- ----------------------------
DROP TABLE IF EXISTS `t_equipment`;
CREATE TABLE `t_equipment`  (
  `id` int(11) NOT NULL COMMENT '装备ID，非自增',
  `name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '装备名',
  `class` tinyint(4) NULL DEFAULT NULL COMMENT '装备分类1武器，2防具',
  `attribute` tinyint(4) NULL DEFAULT NULL COMMENT '装备属性冰火毒123',
  `defence_base` int(11) NULL DEFAULT NULL COMMENT '基础防御',
  `attack_base` int(11) NULL DEFAULT NULL COMMENT '基础攻击',
  `defence_growth` int(11) NULL DEFAULT NULL COMMENT '防御成长',
  `attack_growth` int(11) NULL DEFAULT NULL COMMENT '攻击成长',
  `type` tinyint(4) NULL DEFAULT NULL COMMENT '装备类型1内功2外功',
  `require_level` tinyint(4) NULL DEFAULT NULL COMMENT '需要等级',
  `description` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '装备描述',
  `vip_level` tinyint(4) NULL DEFAULT NULL COMMENT '需求的vip等级',
  `pk_description_self` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'PK时对自己描述性的话',
  `pk_description_opp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'PK时作为对手描述性的话',
  `cost` int(11) NULL DEFAULT 0 COMMENT '售价',
  `get_way` tinyint(4) NULL DEFAULT NULL COMMENT '获取途径（对应副本ID）',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_equipment
-- ----------------------------
INSERT INTO `t_equipment` VALUES (1, '小冰刀', 1, 1, 10, 100, 1, 10, 2, 0, '冰属性的新手外功武器', 0, NULL, NULL, 500, 1);
INSERT INTO `t_equipment` VALUES (2, '大冰刀', 1, 1, 10, 100, 1, 10, 2, 10, '冰属性的10级外功武器', 0, '', '', 4000, 2);
INSERT INTO `t_equipment` VALUES (3, '烧火小破棍', 1, 2, 10, 100, 1, 1, 2, 0, '火属性的新手外功武器', 0, NULL, NULL, 500, 1);
INSERT INTO `t_equipment` VALUES (4, '烧火大长棍', 1, 2, 1, 100, 1, 10, 2, 10, '火属性的10级外功武器', 0, NULL, NULL, 4000, 2);
INSERT INTO `t_equipment` VALUES (5, '小药袋子', 1, 3, 10, 100, 1, 1, 2, 0, '毒属性的新手外功武器', 0, NULL, NULL, 500, 1);
INSERT INTO `t_equipment` VALUES (6, '大药袋子', 1, 3, 1, 100, 1, 10, 2, 10, '毒属性的10级外功武器', 0, NULL, NULL, 4000, 2);
INSERT INTO `t_equipment` VALUES (7, '小冰流碴子', 1, 1, NULL, NULL, NULL, NULL, 1, 0, '冰属性的新手内功武器', 0, NULL, NULL, 500, 1);
INSERT INTO `t_equipment` VALUES (8, '大冰流碴子', 1, 1, NULL, NULL, NULL, NULL, 1, 10, '冰属性的10级内功武器', 0, NULL, NULL, 4000, 2);
INSERT INTO `t_equipment` VALUES (9, '酒精瓶', 1, 2, NULL, NULL, NULL, NULL, 1, 0, '火属性的新手内功武器', 0, NULL, NULL, 500, 1);
INSERT INTO `t_equipment` VALUES (10, '汽油瓶', 1, 2, NULL, NULL, NULL, NULL, 1, 10, '火属性的10级内功武器', 0, NULL, NULL, 4000, 2);
INSERT INTO `t_equipment` VALUES (11, '小皮鞭', 1, 3, NULL, NULL, NULL, NULL, 1, 0, '毒属性的新手内功武器', 0, NULL, NULL, 500, 1);
INSERT INTO `t_equipment` VALUES (12, '大皮鞭', 1, 3, NULL, NULL, NULL, NULL, 1, 10, '毒属性的10级内功武器', 0, NULL, NULL, 4000, 2);
INSERT INTO `t_equipment` VALUES (13, '王八壳', 2, 1, 1, 1, 1, 1, 0, 0, '冰属性的新手防御装备', 0, NULL, NULL, 600, 3);
INSERT INTO `t_equipment` VALUES (14, '千年王八壳', 2, 1, 1, 1, 1, 1, 0, 10, '冰属性的10级防御装备', 0, NULL, NULL, 5000, 4);
INSERT INTO `t_equipment` VALUES (15, '平底锅', 2, 2, NULL, NULL, NULL, NULL, 0, 0, '火属性的新手防御装备', 0, NULL, NULL, 600, 3);
INSERT INTO `t_equipment` VALUES (16, '不锈钢平底锅', 2, 2, NULL, NULL, NULL, NULL, 0, 10, '火属性的10级防御装备', 0, NULL, NULL, 5000, 4);
INSERT INTO `t_equipment` VALUES (17, '防毒口罩', 2, 3, NULL, NULL, NULL, NULL, 0, 0, '毒属性的新手防御装备', 0, NULL, NULL, 600, 3);
INSERT INTO `t_equipment` VALUES (18, '防毒面具', 2, 3, NULL, NULL, NULL, NULL, 0, 10, '毒属性的10级防御装备', 0, NULL, NULL, 5000, 4);
INSERT INTO `t_equipment` VALUES (19, '闪亮的冰刀', 1, 1, 10, 100, 1, 10, 2, 20, '冰属性的20级外功武器', 0, NULL, NULL, 8000, 5);
INSERT INTO `t_equipment` VALUES (20, '漆黑的烧火棍', 1, 2, NULL, NULL, NULL, NULL, 2, 20, '火属性的20级外功武器', 0, NULL, NULL, 8000, 5);
INSERT INTO `t_equipment` VALUES (21, '结实的药袋子', 1, 3, NULL, NULL, NULL, NULL, 2, 20, '毒属性的20级外功武器', 0, NULL, NULL, 8000, 5);
INSERT INTO `t_equipment` VALUES (22, '锃亮的冰流碴子', 1, 1, NULL, NULL, NULL, NULL, 1, 20, '冰属性的20级内功武器', 0, NULL, NULL, 8000, 5);
INSERT INTO `t_equipment` VALUES (23, '丰满的汽油瓶', 1, 2, NULL, NULL, NULL, NULL, 1, 20, '火属性的20级内功武器', 0, NULL, NULL, 8000, 5);
INSERT INTO `t_equipment` VALUES (24, '鳄鱼皮鞭', 1, 3, NULL, NULL, NULL, NULL, 1, 20, '毒属性的20级内功武器', 0, NULL, NULL, 8000, 5);
INSERT INTO `t_equipment` VALUES (25, '碧绿的王八壳', 2, 1, NULL, NULL, NULL, NULL, 0, 20, '冰属性的20级防御装备', 0, NULL, NULL, 10000, 6);
INSERT INTO `t_equipment` VALUES (26, '铝合金平底锅', 2, 2, NULL, NULL, NULL, NULL, 0, 20, '火属性的20级防御装备', 0, NULL, NULL, 10000, 6);
INSERT INTO `t_equipment` VALUES (27, '活性炭防毒面具', 2, 3, NULL, NULL, NULL, NULL, 0, 20, '毒属性的20级防御装备', 0, NULL, NULL, 10000, 6);

-- ----------------------------
-- Table structure for t_item
-- ----------------------------
DROP TABLE IF EXISTS `t_item`;
CREATE TABLE `t_item`  (
  `id` int(11) NOT NULL COMMENT '道具ID，主键非自增\r\n',
  `name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '道具名称',
  `说明` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '攻击',
  `stage` int(10) NULL DEFAULT NULL COMMENT '掉落场景 0则不在副本获取',
  `cost` int(30) NULL DEFAULT 0 COMMENT '商店售价 0则不在商店出售',
  `sect` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '门派专属 没有为0',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_item
-- ----------------------------
INSERT INTO `t_item` VALUES (1, '青铜矿', '30级以下武器升级道具', 1, 200, 0);
INSERT INTO `t_item` VALUES (2, '玄铁矿', '60级以下武器升级道具', 2, 800, 0);
INSERT INTO `t_item` VALUES (3, '粗棉布', '30级以下防具升级道具', 1, 180, 0);
INSERT INTO `t_item` VALUES (4, '毛皮', '60级以下防具升级道具', 2, 820, 0);
INSERT INTO `t_item` VALUES (5, '紫金矿', 'vip武器升级道具', 0, 1500, 0);
INSERT INTO `t_item` VALUES (6, '天蚕丝', 'vip防具升级道具', 0, 1500, 0);
INSERT INTO `t_item` VALUES (7, '康贝特', '加血10%', 1, 300, 0);
INSERT INTO `t_item` VALUES (8, '逍遥御风', '逍遥派专属套装 骗土豪专用', 0, 18888, 1);
INSERT INTO `t_item` VALUES (9, '星星点灯', '星宿派专属套装 骗土豪专用', 0, 18888, 2);
INSERT INTO `t_item` VALUES (10, '天山套装', '天山派专属套装 骗土豪专用', 0, 18888, 3);
INSERT INTO `t_item` VALUES (11, '丐帮套装', '丐帮专属套装 骗土豪专用', 0, 18888, 4);
INSERT INTO `t_item` VALUES (12, '少林套装', '少林专属套装 骗土豪专用', 0, 18888, 5);
INSERT INTO `t_item` VALUES (13, '无裆套装', '无裆派专属套装 骗土豪专用', 0, 18888, 6);

-- ----------------------------
-- Table structure for t_pet
-- ----------------------------
DROP TABLE IF EXISTS `t_pet`;
CREATE TABLE `t_pet`  (
  `id` int(11) NOT NULL COMMENT '主键ID，自增',
  `playerId` int(11) NOT NULL COMMENT '玩家ID',
  `attack_growth` int(11) NULL DEFAULT NULL COMMENT '宠物攻击',
  `defence_growth` int(11) NULL DEFAULT NULL COMMENT '宠物防御成长值',
  `hp` int(11) NULL DEFAULT NULL COMMENT '宠物生命成长值',
  `level` tinyint(4) NULL DEFAULT NULL COMMENT '宠物等级',
  `player_attack_growth` int(11) NULL DEFAULT NULL COMMENT '给玩家的攻击增益成长值',
  `player_defence_growth` int(11) NULL DEFAULT NULL COMMENT '给玩家的防御增益成长值',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for t_player
-- ----------------------------
DROP TABLE IF EXISTS `t_player`;
CREATE TABLE `t_player`  (
  `id` int(11) NOT NULL COMMENT '主键ID，自增',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '角色名',
  `gender` tinyint(4) NULL DEFAULT 0 COMMENT '性别',
  `sect` tinyint(4) NULL DEFAULT NULL COMMENT '门派',
  `level` tinyint(4) NULL DEFAULT NULL COMMENT '等级',
  `attack` int(10) NULL DEFAULT NULL COMMENT '攻击力',
  `defence` int(10) NULL DEFAULT NULL COMMENT '防御力',
  `hp` int(10) NULL DEFAULT NULL COMMENT '生命',
  `money` int(10) NULL DEFAULT NULL COMMENT '金钱',
  `vip` int(10) NULL DEFAULT NULL COMMENT 'vip等级',
  `weapon_id` int(10) NULL DEFAULT NULL COMMENT '武器ID',
  `weapon_level` tinyint(4) NULL DEFAULT NULL COMMENT '武器强化等级',
  `armor_id` int(10) NULL DEFAULT NULL COMMENT '防具ID',
  `armor_level` tinyint(4) NULL DEFAULT NULL COMMENT '防具强化等级',
  `skill_level` tinyint(4) NULL DEFAULT 1 COMMENT '技能1等级',
  `item` tinyint(4) UNSIGNED NULL DEFAULT 0 COMMENT '背包物品存在',
  `force` int(11) NULL DEFAULT 0 COMMENT '玩家战力',
  `achievement` int(10) NULL DEFAULT 0 COMMENT '当前目标成就',
  UNIQUE INDEX `id`(`id`) USING BTREE,
  UNIQUE INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_player
-- ----------------------------
INSERT INTO `t_player` VALUES (1, '无崖子', 1, 1, 9, 1100, 500, 500, 10000, 0, 1, 6, 13, 5, 5, 0, 0, 1);
INSERT INTO `t_player` VALUES (2, '丁春秋', 1, 2, 30, 3200, 2400, 2800, 10, 1, 1, 8, 4, 16, 23, 0, 0, 2);
INSERT INTO `t_player` VALUES (3, '天山童姥', 0, 3, 30, 9999, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0);
INSERT INTO `t_player` VALUES (4, '乔峰', 1, 4, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0);
INSERT INTO `t_player` VALUES (5, '玄慈', 1, 5, 11, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0);
INSERT INTO `t_player` VALUES (6, '本尘', 1, 6, 9, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 0, 0, 0);
INSERT INTO `t_player` VALUES (7, '王大锤', 1, 4, 55, 123232, 32312, 32234, 60, 1, 6, 50, 15, 10, 53, 0, 0, 3);

-- ----------------------------
-- Table structure for t_sects
-- ----------------------------
DROP TABLE IF EXISTS `t_sects`;
CREATE TABLE `t_sects`  (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT COMMENT '门派ID，主键，自增',
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '门派名',
  `type` int(8) UNSIGNED NOT NULL COMMENT '攻击类型，1外功，2内功',
  `attribute` int(8) UNSIGNED NULL DEFAULT NULL COMMENT '门派属性，1冰，2火，3毒',
  `attack_growth` int(8) NULL DEFAULT NULL COMMENT '攻击成长',
  `defence_growth` int(8) NULL DEFAULT NULL COMMENT '防御成长',
  `hp_growth` int(8) NULL DEFAULT NULL COMMENT 'hp成长',
  `pk_self` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'pk时自己的描述',
  `pk_opp` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'pk时对手的描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_sects
-- ----------------------------
INSERT INTO `t_sects` VALUES (1, '小腰派', 1, 1, 11, 5, 5, '我方是冰属性内功门派，以攻击见长，', '对方是小腰派，冰属性内功门派，攻击极高。');
INSERT INTO `t_sects` VALUES (2, '生锈派', 1, 3, 5, 8, 8, '我方是毒属性内功门派，以防御见长，', '对方是生锈派，毒属性内功门派，攻击力一般，但防御和血量都很高。');
INSERT INTO `t_sects` VALUES (3, '舔山派', 2, 1, 7, 7, 7, '我方是冰属性外功门派，各项均衡，', '对方是舔山派，冰属性外功门派，攻守均衡。');
INSERT INTO `t_sects` VALUES (4, '钙帮', 2, 3, 10, 6, 5, '我方是毒属性外功门派，以攻击见长，', '对方是钙帮，毒属性外功门派，攻击力很高。');
INSERT INTO `t_sects` VALUES (5, '烧林寺', 2, 2, 4, 8, 9, '我方是火属性外功门派，血厚防高，', '对方是烧林寺，火属性外功门派，血厚防高攻击力较低。');
INSERT INTO `t_sects` VALUES (6, '地龙寺', 1, 2, 8, 7, 6, '我方是火属性内功门派，攻守较为均衡，', '对方是地龙寺，火属性内功门派，攻守均衡。');

-- ----------------------------
-- Table structure for t_shop
-- ----------------------------
DROP TABLE IF EXISTS `t_shop`;
CREATE TABLE `t_shop`  (
  `id` int(11) NOT NULL COMMENT '自增id',
  `item_id` int(11) NOT NULL COMMENT '对应item表id',
  `price` int(11) NULL DEFAULT NULL COMMENT '价格',
  `require_vip_level` tinyint(4) NULL DEFAULT NULL COMMENT '需要VIP等级',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Table structure for t_stage
-- ----------------------------
DROP TABLE IF EXISTS `t_stage`;
CREATE TABLE `t_stage`  (
  `id` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `require_level` tinyint(4) NULL DEFAULT NULL COMMENT '需求等级',
  `drop_list` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '通关掉落列表',
  `recommend_force` int(11) NULL DEFAULT NULL COMMENT '推荐战力',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of t_stage
-- ----------------------------
INSERT INTO `t_stage` VALUES (1, '燕子坞', 0, NULL, 10);
INSERT INTO `t_stage` VALUES (2, '缥缈峰', 10, NULL, 10);
INSERT INTO `t_stage` VALUES (3, '四绝庄', 20, NULL, 10);
INSERT INTO `t_stage` VALUES (4, '少室山', 30, NULL, 10);
INSERT INTO `t_stage` VALUES (5, '中关村', 40, NULL, NULL);
INSERT INTO `t_stage` VALUES (6, '紫光阁', 50, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
