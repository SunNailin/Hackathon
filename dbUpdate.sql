/*
 * 删除无用活动
 */
DELETE FROM `hackathon`.`t_activities` WHERE `id` = 4;
DELETE FROM `hackathon`.`t_activities` WHERE `id` = 5;
/*
 * 更改活动时间
 */
UPDATE `hackathon`.`t_activities` SET `time` = '11:30' WHERE `id` = 1;
UPDATE `hackathon`.`t_activities` SET `time` = '11:45' WHERE `id` = 2;
UPDATE `hackathon`.`t_activities` SET `time` = '12:00' WHERE `id` = 3;