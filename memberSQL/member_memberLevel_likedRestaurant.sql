-- member table
/*家銘註解
auto_increment的欄位在insert時，一般不會設定values
會交由系統自動生成
但要設定從101號開始應該也是可以，不確定會不會遇到什麼問題
欄位有再異動，信箱取代帳號、新增信箱確認狀態欄位
以下欄位設定不能為空值: 姓名、信箱、密碼、會員等級
會員等級預設為1(最低階)
日期格式按照mysql建議'/'改為'-'
*/
CREATE TABLE `goodEatTime`.`member` (
  memberNo INT NOT NULL AUTO_INCREMENT,
  memberLev VARCHAR(20) NULL,
  name VARCHAR(20) NULL,
  birthday DATE NULL,
  memberAccount VARCHAR(20) NULL,
  memberPassword VARCHAR(50) NULL,
  tel VARCHAR(20) NULL,
  mail VARCHAR(100) NULL,
  point INT NULL,
  memberPic BLOB NULL,
  PRIMARY KEY (`memberNo`));
 
INSERT INTO `goodEatTime`.`member` (`memberNo`, `memberLev`, `name`, `birthday`, `memberAccount`, `memberPassword`, `tel`, `mail`, `point`) VALUES ('101', '1', 'Peter', '1988/02/01', '101Peter', 'Peter1988', '093231520', 'peter1988@yahoo.com.tw', '20');
INSERT INTO `goodEatTime`.`member` (`memberNo`, `memberLev`, `name`, `birthday`, `memberAccount`, `memberPassword`, `tel`, `mail`, `point`) VALUES ('102', '3', 'Chris', '2000/03/05', '102Chris', 'Chris2000', '0973825638', 'chris2000@gmail.com', '50');
INSERT INTO `goodEatTime`.`member` (`memberNo`, `memberLev`, `name`, `birthday`, `memberAccount`, `memberPassword`, `tel`, `mail`, `point`) VALUES ('103', '2', 'James', '1999/05/06', '103James', 'James1999', '0973526145', 'james0101@gmail.com', '60');
INSERT INTO `goodEatTime`.`member` (`memberNo`, `memberLev`, `name`, `birthday`, `memberAccount`, `memberPassword`, `tel`, `mail`, `point`) VALUES ('104', '4', 'Sam', '2003/12/01', '104Sam', 'Sam2003', '0976548765', 'sammy88@yahoo.com.tw', '10');
INSERT INTO `goodEatTime`.`member` (`memberNo`, `memberLev`, `name`, `birthday`, `memberAccount`, `memberPassword`, `tel`, `mail`, `point`) VALUES ('105', '3', 'David', '1980/01/01', '105David', 'David1980', '0983625174', 'ddavid1980@gmail.com', '30');

-- memberLevel table
/*家銘註解
insert中沒有memberLevelName
ER-Model中也沒有memberLevelName
新增此欄位，更改memberLevel為int auto_increment
memberLevelName假資料設定
新增表格建議增加欄位中文名稱備註，語法如下
comment '會員等級 pk'*/
CREATE TABLE `goodEatTime`.`memberLevel` (
  memberLevel VARCHAR(20) NOT NULL,
  memberLevelName VARCHAR(45) NULL,
  accumulatedAmount INT NULL, 
  bonuPoints INT NULL, 
  bonusCoupon INT NULL,
  PRIMARY KEY (`memberLevel`));
  
INSERT INTO `goodEatTime`.`memberLevel` (`memberLevel`, `accumulatedAmount`, `bonuPoints`, `bonusCoupon`) VALUES ('1', '0', '0', '1');
INSERT INTO `goodEatTime`.`memberLevel` (`memberLevel`, `accumulatedAmount`, `bonuPoints`, `bonusCoupon`) VALUES ('2', '2000', '20', '3');
INSERT INTO `goodEatTime`.`memberLevel` (`memberLevel`, `accumulatedAmount`, `bonuPoints`, `bonusCoupon`) VALUES ('3', '3000', '50', '3');
INSERT INTO `goodEatTime`.`memberLevel` (`memberLevel`, `accumulatedAmount`, `bonuPoints`, `bonusCoupon`) VALUES ('4', '5000', '100', '5');

-- likeRestaurant table
CREATE TABLE `goodEatTime`.`likeRestaurant` (
  memberNo INT NOT NULL,
  restaurantNo INT NOT NULL,
  PRIMARY KEY (`memberNo`, `restaurantNo`));
  
INSERT INTO `goodEatTime`.`likeRestaurant` (`memberNo`, `restaurantNo`) VALUES ('101', '201');
INSERT INTO `goodEatTime`.`likeRestaurant` (`memberNo`, `restaurantNo`) VALUES ('102', '202');
INSERT INTO `goodEatTime`.`likeRestaurant` (`memberNo`, `restaurantNo`) VALUES ('103', '203');
INSERT INTO `goodEatTime`.`likeRestaurant` (`memberNo`, `restaurantNo`) VALUES ('104', '204');
INSERT INTO `goodEatTime`.`likeRestaurant` (`memberNo`, `restaurantNo`) VALUES ('105', '205'); 


-- FK 設訂 member table 的 memberLevel
/*家銘註解
假資料數量不多
加索引的效益不高
修改FK名稱統一命名慣例 如:FK_member_memberLevel
*/
ALTER TABLE `goodEatTime`.`member` 
ADD INDEX memberLevel_idx (`memberLevel` ASC) VISIBLE;
;
ALTER TABLE `goodEatTime`.`member` 
ADD CONSTRAINT memberLevel
  FOREIGN KEY (`memberLevel`)
  REFERENCES `goodEatTime`.`memberLevel` (`memberLevel`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- FK 設訂 likeRestaurant table 的 memberNo
/*家銘註解
修改FK名稱統一命名慣例
追加constraint foreign key(restaurantNo)
*/
ALTER TABLE `goodEatTime`.`likeRestaurant` 
ADD CONSTRAINT memberNo
  FOREIGN KEY (`memberNo`)
  REFERENCES `goodEatTime`.`member` (`memberNo`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;