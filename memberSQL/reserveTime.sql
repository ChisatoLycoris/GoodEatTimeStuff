/*家銘註解
目前唯一沒有需要修改的sql指令，讚~
*/

CREATE TABLE `reserveTime` (
  `reserveTimeNo` INT NOT NULL AUTO_INCREMENT COMMENT '訂位時段編號',
  `restaurantNo` INT NOT NULL COMMENT '餐廳編號 ',
  `reserveTime` VARCHAR(50) NOT NULL COMMENT '訂位時段',
  `allowReserveNum` INT NOT NULL COMMENT '容許訂位人數',
  PRIMARY KEY (`reserveTimeNo`))
COMMENT = '餐廳訂位時段';

insert into reserveTime (restaurantNo, reserveTime, allowReserveNum)
values(5, '12:00', 20), (5, '13:00', 20), (5, '18:00', 25), (5, '19:00', 25),
(3, '12:00', 15), (3, '13:00', 15), (3, '18:00', 15), (3, '19:00', 15),
(2, '12:00', 20), (2, '13:00', 20), (2, '18:00', 20), (2, '19:00', 20),
(1, '12:00', 15), (1, '13:00', 15), (1, '18:00', 20), (1, '19:00', 20),
(4, '12:00', 10), (4, '13:00', 10), (4, '18:00', 15), (4, '19:00', 15)