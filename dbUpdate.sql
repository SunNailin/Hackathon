/*
 * 删除无用活动
 */
DELETE FROM `t_activities` WHERE `id` = 4;
DELETE FROM `t_activities` WHERE `id` = 5;
/*
 * 更改活动时间
 */
UPDATE `t_activities` SET `time` = '11:30' WHERE `id` = 1;
UPDATE `t_activities` SET `time` = '11:45' WHERE `id` = 2;
UPDATE `t_activities` SET `time` = '12:00' WHERE `id` = 3;