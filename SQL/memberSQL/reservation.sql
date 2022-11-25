/*家銘註解
沒啥需要修改的，太強了~
*/
CREATE TABLE `reservation` (
  `reserveNo` INT NOT NULL AUTO_INCREMENT COMMENT '訂位編號',
  `memberNo` INT NOT NULL COMMENT '會員編號',
  `reserveStatus` VARCHAR(20) NOT NULL COMMENT '訂位狀態',
  `restaurantNo` INT NOT NULL COMMENT '餐廳編號',
  `reserveNum` INT NOT NULL COMMENT '訂位人數',
  `reserveDate` DATE NOT NULL COMMENT '訂位日期',
  `reserveTime` VARCHAR(20) NOT NULL COMMENT '訂位時段',
  `remark` VARCHAR(200) NULL COMMENT '備註',
  `commentRating` INT NULL COMMENT '評論星等',
  `commentContent` VARCHAR(200) NULL COMMENT '評論內容',
  `commentPic` LONGBLOB NULL COMMENT '評論附圖',
  `restaurantCommentTime` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `restaurantRe` VARCHAR(500) NULL COMMENT '餐廳回覆評論',
  `restaurantReTime` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT '餐廳回覆時間',
  PRIMARY KEY (`reserveNo`))
COMMENT = '訂位明細';

insert into reservation (memberNo, restaurantNo, reserveNum, reserveDate, reserveTime, remark, reserveStatus, commentRating, commentContent, commentPic, restaurantCommentTime, restaurantRe, restaurantReTime)
values(5, 1, 3, '2022-11-18', '12:00', null, '報到成功', 4, '服務態度可', null, now(), null, null),
(3, 2, 3, '2022-11-24', '13:00', null, '訂位成功', null, null, null, null, null, null),
(2, 4, 2, '2022-11-17', '19:00', null, '報到成功', 5, '餐點很好吃', null, '2022-11-18 10:33:21', null, null),
(1, 3, 3, '2022-11-25', '18:00', '需要兒童座椅', '訂位成功', null, null, null, null, null, null),
(4, 5, 4, '2022-11-24', '12:00', null, '訂位成功', null, null, null, null, null, null)