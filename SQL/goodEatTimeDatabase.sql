/*=======================================
index

drop table: line 32

create table & insert fake date
prodCategory: line 53
memberLevel: line 71
restaurant: line 87
administrator: line 114
prodInfo: line 135
member: line 160
coupon: line 190
reserveTime: line 228
restaurantPic: line 250
adOrder: line 270
prodPic: line 300
shoppingCart: line 321
prodOrder: line 342
likedRestauranr: line 378
memberCoupon: line 409
reservation: line 426
prodOrderDetail: line 459

=======================================*/

use goodeattime;

set AUTOCOMMIT = 0;

/*沒有被參照的表格先刪*/
drop table if exists prodOrderDetail;
drop table if exists prodPic;
drop table if exists shoppingCart;
drop table if exists prodOrder;
drop table if exists likedRestaurant;
drop table if exists memberCoupon;
drop table if exists reservation;
drop table if exists prodInfo;
drop table if exists member;
drop table if exists coupon;
drop table if exists reserveTime;
drop table if exists restaurantPic;
drop table if exists adOrder;
drop table if exists prodCategory;
drop table if exists memberLevel;
drop table if exists restaurant;
drop table if exists administrator;



/*有被參照的表格先建*/
--  prodCategory
/*==========================================================================================*/
create table prodCategory (
	prodCategoryNo     integer auto_increment not null comment '商品類別編號 PK' primary key,
    prodCategory       varchar(20) not null comment '商品類別名稱'
) Engine = InnoDB;

insert into prodCategory(prodCategory)
values('日式料理'),
('義式料理'),
('中式料理'),
('零食餅乾'),
('甜點'),
('炸物'),
('調味料');
commit;


--  memberLevel
/*==========================================================================================*/
CREATE TABLE `goodEatTime`.`memberLevel` (
  memberLevel INT NOT NULL AUTO_INCREMENT,
  memberLevelName VARCHAR(45) NULL,
  accumulatedAmount INT NULL, 
  bonuPoints INT NULL, 
  bonusCoupon INT NULL,
  PRIMARY KEY (`memberLevel`));
  
INSERT INTO `goodEatTime`.`memberLevel` (`memberLevelName`, `accumulatedAmount`, `bonuPoints`, `bonusCoupon`) VALUES ('市井小民', '0', '0', '1');
INSERT INTO `goodEatTime`.`memberLevel` (`memberLevelName`, `accumulatedAmount`, `bonuPoints`, `bonusCoupon`) VALUES ('天涯旅人', '2000', '20', '3');
INSERT INTO `goodEatTime`.`memberLevel` (`memberLevelName`, `accumulatedAmount`, `bonuPoints`, `bonusCoupon`) VALUES ('文人雅士', '3000', '50', '3');
INSERT INTO `goodEatTime`.`memberLevel` (`memberLevelName`, `accumulatedAmount`, `bonuPoints`, `bonusCoupon`) VALUES ('朝廷重臣', '5000', '100', '5');
commit;

--  restaurant
/*==========================================================================================*/
create table restaurant(
restaurantNo int unsigned auto_increment not null comment '餐廳編號',
restaurantTel varchar(20) not null comment '電話',
restaurantName varchar(50) not null comment '餐廳名稱',
restaurantTaxIDNo varchar(20) comment '統一編號',
restaurantAccountInfo varchar(50) comment '帳戶資訊',
restaurantBusinessHour varchar(200) not null comment '營業時間',
restaurantAddr varchar(50) not null comment '地址',
restaurantStatus bit(1) comment '餐廳狀態',
restaurantAccount varchar(20) not null comment '餐廳帳號',
restaurantPassword varchar(50) not null comment '餐廳密碼',
restaurantCommentQuantity int not null default(0) comment '總評論數量',
totalCommentRating int not null default(0) comment '總評論星等',
constraint restaurantNo_PK primary key(restaurantNo));


insert into restaurant(restaurantTel, restaurantName, restaurantTaxIDNo, restaurantAccountInfo, restaurantBusinessHour, restaurantAddr, restaurantAccount, restaurantPassword)
values('0229540410','薄多義','53914855',null,'11:00-20:30','台北市中正區忠孝東路一段150號','restaurant1001','1001restaurant'),
('0225963255','欣葉台菜','12107610',null,'11:00-21:00','台北市中正區林森南路1號','restaurant1002','1002restaurant'),
('0229341343','星巴克 (時代寓所門市)','53234955',null,'11:00-20:30','台北市中正區林森南路7-1號','restaurant1003','1003restaurant'),
('0221243563','麥當勞-林森二餐廳','34256575',null,'11:00-20:30','台北市中正區林森南路1號','restaurant1004','1004restaurant'),
('0221345678','摩斯漢堡 善導寺店','12124455',null,'11:00-20:30','台北市中正區忠孝東路一段178號','restaurant1005','1005restaurant');
commit;


--  administrator
/*==========================================================================================*/
create table `administrator`(
`adminNo` int auto_increment not null comment '系統管理員編號',
`adminAccount` varchar(20) not null comment '帳號',
`adminPassword` varchar (50) not null comment '密碼',
`adminName` varchar (50) not null comment '姓名',
`modifyAdminData` bit(1) not null comment '新增修改系統管理員帳號',
`modifyMemberData` bit(1) not null comment '查詢修改會員資料',
`verifyRestaurant` bit(1) not null comment '審核餐廳',
`verifyAdCoupon` bit(1) not null comment '審核廣告與折價券',
constraint adminNo_PK primary key (adminNo)) comment '系統管理員';
  
insert into administrator(adminAccount, adminPassword, adminName, modifyAdminData, modifyMemberData, verifyRestaurant, verifyAdCoupon)
values
	("res_A_11", "res1_P@ssOrd", "小吳", 1,1,1,1),
	("res_A_12", "res2_P@ssOrd", "中吳", 0,1,0,1),
    ("res_A_13", "res3_P@ssOrd", "大吳", 0,1,1,1);
commit;


--  prodInfo
/*==========================================================================================*/
create table prodInfo (
	prodNo             integer auto_increment not null comment '商品編號 PK' primary key,
    restaurantNo       integer unsigned not null comment '餐廳編號 FK',
    prodCategoryNo     integer not null comment '商品類別編號 FK',
    prodName           varchar(50) not null comment '商品名稱',
    prodPrice          integer not null comment '商品價格' check(prodPrice > 0),
    prodStock          integer not null default(0) comment '商品庫存' check(prodStock > -1),
    prodDescription    varchar(200) comment '商品說明, 廣告文案',
    prodContent        varchar(200) comment '商品詳細, 商品規格',
    prodCommentQty     integer not null default(0) comment '評論數量' check(prodCommentQty > -1),
    totalCommentRating integer not null default(0) comment '總評論星等' check(totalCommentRating > -1),
    constraint FK_prodInfo_restaurantNo foreign key(restaurantNo) references restaurant(restaurantNo), 
    constraint FK_prodInfo_prodCategoryNo foreign key(prodCategoryNo) references prodCategory(prodCategoryNo)
) Engine = InnoDB;

insert into prodInfo(restaurantNo, prodCategoryNo, prodName, prodPrice, prodStock, prodDescription, prodContent)
values(1, 1, '日式親子丼調理包', 199, 50, '母雞帶小雞 迸出新滋味', '雞肉、雞蛋、洋蔥、醬油調味'),
(1, 3, 'Uncle Roger特製炒飯', 80, 10, 'HaiYa~', '隔夜飯、雞蛋、蔥、胡蘿蔔再加上滿滿的MSG'),
(2, 3, '六位一體魔幻麻婆豆腐', 120, 5, '辣香色燙酥麻 六位一體', '大麻'),
(2, 6, '李嚴特製炸鳳尾蝦', 300, 99, '將核果搗碎後裹在蝦肉上，油炸成為金黃色', '那...那個醬汁呢?'),
(3, 5, '黃金開口笑', 30, 99, 'ㄤㄤㄤㄤㄤㄤㄤ', '笑到你心裡發麻');
commit;

--  member
/*==========================================================================================*/
CREATE TABLE `goodEatTime`.`member` (
  memberNo INT NOT NULL AUTO_INCREMENT,
  memberLevel  INT NOT NULL default(1),
  name VARCHAR(20) NOT NULL,
  birthday DATE NULL,
  mail VARCHAR(100) NOT NULL,
  memberPassword VARCHAR(50) NOT NULL,
  verificationAccount bit(1) NOT NULL default(0) comment'信箱是否以驗證, 0:尚未驗證, 1:已驗證',
  tel VARCHAR(20) NULL,
  point INT NULL,
  memberPic BLOB NULL,
  PRIMARY KEY (`memberNo`));
 
ALTER TABLE `goodEatTime`.`member` 
ADD CONSTRAINT FK_member_memberLevel
  FOREIGN KEY (`memberLevel`)
  REFERENCES `goodEatTime`.`memberLevel` (`memberLevel`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;
 
INSERT INTO `goodEatTime`.`member` (`memberLevel`, `name`, `birthday`, `mail`, `memberPassword`, `verificationAccount`, `tel`, `point`) VALUES ('1', 'Peter', '1988-02-01', 'peter1988@yahoo.com.tw', 'Peter1988', 1, '093231520', '20');
INSERT INTO `goodEatTime`.`member` (`memberLevel`, `name`, `birthday`, `mail`, `memberPassword`, `verificationAccount`, `tel`, `point`) VALUES ('3', 'Chris', '2000-03-05', 'chris2000@gmail.com', 'Chris2000', 1, '0973825638', '50');
INSERT INTO `goodEatTime`.`member` (`memberLevel`, `name`, `birthday`, `mail`, `memberPassword`, `verificationAccount`, `tel`, `point`) VALUES ('2', 'James', '1999-05-06', 'james0101@gmail.com', 'James1999', 1, '0973526145', '60');
INSERT INTO `goodEatTime`.`member` (`memberLevel`, `name`, `birthday`, `mail`, `memberPassword`, `verificationAccount`, `tel`, `point`) VALUES ('4', 'Sam', '2003-12-01', 'sammy88@yahoo.com.tw', 'Sam2003', 0, '0976548765', '10');
INSERT INTO `goodEatTime`.`member` (`memberLevel`, `name`, `birthday`, `mail`, `memberPassword`, `verificationAccount`, `tel`, `point`) VALUES ('3', 'David', '1980-01-01', 'ddavid1980@gmail.com', 'David1980', 0, '0983625174', '30');

commit;

--  coupon
/*==========================================================================================*/
create table coupon(
couponNo int not null auto_increment primary key comment'優惠券編號',
restaurantNo integer unsigned not null comment'餐廳編號',
adminNo integer not null comment'系統管理員編號',
couponApplyDate timestamp default current_timestamp comment'申請日期',
couponName varchar(50) not null comment'優惠券名稱',
couponStartTime date not null comment'開始時間',
couponEndTime date not null comment'結束時間',
verified bit(1) comment'審核狀態',
couponContent varchar(200) not null comment'優惠券內容',
usageLimitation int comment'訂單金額滿多少可以使用',
amountOrFold double comment'金額 - 折數',
couponType bit(1) comment'種類, 0:折價, 1:打折',
maxIssueQty int not null comment'發行張數上限',
issuedQty int not null default(0) comment'已發行張數',
verificationDetail varchar(200) comment'審核資訊',
constraint FK_coupon_restaurantNo foreign key(restaurantNo) references restaurant(restaurantNo),
constraint FK_coupon_adminNo foreign key(adminNo) references administrator(adminNo)
);

insert into Coupon(restaurantNo, adminNo, couponName, 
				   couponStartTime, couponEndTime, verified, couponContent, 
                   usageLimitation, amountOrFold, couponType, maxIssueQty, verificationDetail)
values(1,1,'優惠券1','2022-11-22','2023-11-30',1,'優惠券1內容',1000,88,0,200,'優惠券審核狀態'),
	  (1,1,'優惠券2','2022-11-22','2023-11-30',1,'優惠券2內容',1000,0.8,1,10000,'優惠券審核狀態'),
      (2,1,'優惠券3','2022-11-22','2023-11-30',1,'優惠券3內容',200,20,0,500,'優惠券審核狀態'),
      (2,1,'優惠券4','2022-11-22','2023-11-30',1,'優惠券4內容',500,0.8,1,350,'優惠券審核狀態'),
      (4,1,'優惠券5','2022-11-22','2023-11-30',1,'優惠券5內容',1000,0.8,1,10,'優惠券審核狀態'),
      (2,1,'優惠券6','2022-11-22','2023-11-30',1,'優惠券6內容',200,0.8,1,200,'優惠券審核狀態'),
      (1,1,'優惠券7','2022-11-22','2023-11-30',1,'優惠券7內容',1000,150,0,150,'優惠券審核狀態'),
      (3,1,'優惠券8','2022-11-22','2023-11-30',0,'優惠券8內容',500,0.8,1,1000, null),
      (4,1,'優惠券9','2022-11-22','2023-11-30',0,'優惠券9內容',1000,0.8,1,100, null),
      (5,1,'優惠券10','2022-11-22','2023-11-30',0,'優惠券10內容',1000,0.8,1,888,'優惠券審核狀態');

commit;

--  reserveTime
/*==========================================================================================*/

CREATE TABLE `reserveTime` (
  `reserveTimeNo` INT NOT NULL AUTO_INCREMENT COMMENT '訂位時段編號',
  `restaurantNo` INT unsigned NOT NULL COMMENT '餐廳編號 ',
  `reserveTime` VARCHAR(50) NOT NULL COMMENT '訂位時段',
  `allowReserveNum` INT NOT NULL COMMENT '容許訂位人數',
  PRIMARY KEY (`reserveTimeNo`),
  constraint FK_reserveTime_restaurantNo foreign key(restaurantNo) references restaurant(restaurantNo)
  )
COMMENT = '餐廳訂位時段';

insert into reserveTime (restaurantNo, reserveTime, allowReserveNum)
values(5, '12:00', 20), (5, '13:00', 20), (5, '18:00', 25), (5, '19:00', 25),
(3, '12:00', 15), (3, '13:00', 15), (3, '18:00', 15), (3, '19:00', 15),
(2, '12:00', 20), (2, '13:00', 20), (2, '18:00', 20), (2, '19:00', 20),
(1, '12:00', 15), (1, '13:00', 15), (1, '18:00', 20), (1, '19:00', 20),
(4, '12:00', 10), (4, '13:00', 10), (4, '18:00', 15), (4, '19:00', 15);

commit;

--  restaurantPic
/*==========================================================================================*/
create table restaurantPic(
restaurantPicNo int unsigned auto_increment not null comment '餐廳圖片編號',
restaurantNo int unsigned not null comment '餐廳編號',
restaurantPic longblob comment '餐廳圖片',
restaurantPicRemark varchar(50) comment '餐廳圖片說明',
constraint restaurantPicNo_PK primary key(restaurantPicNo),
constraint FK_restaurantPic_restaurantNo foreign key(restaurantNo) references restaurant(restaurantNo)
);

insert into restaurantPic(restaurantNo, restaurantPic, restaurantPicRemark)
values(1, null, '圖片備註1'),
(2, null, '圖片備註2-1'),
(2, null, '圖片備註2-2'),
(3, null, '圖片備註3-1'),
(3, null, '圖片備註3-2');

commit;

--  adOrder
/*==========================================================================================*/

create table adOrder(
adOrderNo int auto_increment not null comment '廣告訂位編號',
restaurantNo int unsigned not null comment '餐廳編號',
adminNo int comment '系統管理員編號',
adOrderTime timestamp default current_timestamp not null comment '申請日期',
adStartTime date not null comment '開始時間',
adEndTime date not null comment '結束時間',
verified bit(1) comment '審核狀態',
verificationDetail varchar(200) comment '審核資訊',
adOrderPrice int not null comment '總金額',
slideshowPic LONGBLOB comment '跑馬燈圖片',                 /* 是否改成longblob */ 
constraint adOrderNo_PK primary key (adOrderNo),
constraint FK_adOrder_restaurantNo foreign key (restaurantNo) references restaurant (restaurantNo),
constraint FK_adOrder_adminNo foreign key (adminNo) references administrator (adminNo)
)comment '廣告訂單';


insert into adOrder(restaurantNo, adminNo, adOrderTime, adStartTime, adEndTime, verified, verificationDetail, adOrderPrice, slideshowPic)
values
	(1, 1, now(), '2022-12-01', '2022-12-31', 1, '審核資訊xxx', 1000, null),
    (2, 2, now(), '2023-01-01', '2023-12-31', 1, '審核資訊yyy', 2000, null),
    (3, 3, now(), '2023-02-01', '2023-12-31', 1, '審核資訊zzz', 3000, null),
    (4, 2, now(), '2023-01-01', '2023-06-30', 0, '審核資訊yyy', 2000, null),
    (4, null, now(), '2023-01-01', '2023-06-30', null, null, 2000, null);
    
commit;

--  prodPic
/*==========================================================================================*/
create table prodPic (
	prodPicNo     integer auto_increment not null comment '商品圖片編號 PK' primary key,
    prodNo        integer not null comment '商品編號 FK',
    prodPic       longblob comment '商品圖片',
    prodPicRemark varchar(200),
    constraint FK_prodPic_prodNo foreign key(prodNo) references prodInfo(prodNo)
) Engine = InnoDB;

insert into prodPic(prodNo, prodPic, prodPicRemark)
values(1, null, '商品編號1號的測試圖片1'),
(1, null, '商品編號1號的測試圖片2'),
(2, null, '商品編號2號的測試圖片1'),
(2, null, '商品編號2號的測試圖片2'),
(3, null, '商品編號3號的測試圖片1'),
(3, null, '商品編號3號的測試圖片2'),
(3, null, '商品編號3號的測試圖片3');
commit;


--  shoppingCart
/*==========================================================================================*/
create table shoppingCart (
	memberNo     integer not null comment '商品圖片編號 PK FK',
    prodNo       integer not null comment '商品圖片編號 PK FK',
    prodQty      integer default(1) comment '商品數量' check(prodQty > 0),
    primary key (memberNo, prodNo),
    constraint FK_shoppingCart_memberNo foreign key(memberNo) references member(memberNo),
    constraint FK_shoppingCart_prodNo foreign key(prodNo) references prodInfo(prodNo)
) Engine = InnoDB;

insert into shoppingCart(memberNo, prodNo, prodQty)
values(1, 2, 2),
(1, 3, 2),
(1, 1, 5),
(2, 2, 4),
(2, 3, 6),
(3, 4, 2),
(3, 5, 3);
commit;

--  prodOrder
/*==========================================================================================*/
create table prodOrder (
	prodOrderNo					integer	auto_increment not null comment '商城訂單編號' primary key , 
    memberNo					integer	not null comment '會員編號' ,
	restaurantNo				integer unsigned not null comment '餐廳編號' ,
	couponNo					integer	comment '優惠券編號' , 
	orderStatus					varchar(20) default('訂單成立') null comment '訂單狀態' ,
	prodOrderDate				timestamp not null default(now()) comment '訂單時間' ,
	prodOrderReveiveTime		datetime comment '收貨時間' ,
	prodOderDeliverTime			datetime comment '出貨時間' ,
	deliverFee					integer not null comment '運費' ,
	amountBeforeCoupon			integer	not null comment '訂單原始金額' ,
	amountAfterCoupon 			integer	not null comment '訂單折扣後金額' ,
	prodOrderPoint				integer not null comment '紅利點數' ,
	prodOrderReceiverName		varchar(20)	not null comment '收貨人姓名' ,
	prodOrderReceiverTel		varchar(20) not null comment '收貨人電話' ,
	prodOrderReceiverMail		varchar(100) not null comment '收貨人MAIL' ,
	prodOrderReceiverAddress	varchar(100) not null comment '收貨地址' ,
	invoiceNumber				varchar(20) not null comment '發票號碼' ,
	taxIDNumber					varchar(20) comment '統一編號' ,
    constraint FK_prodOrder_memberNo foreign key(memberNo) references member(memberNo),
    constraint FK_prodOrder_restaurantNo foreign key(restaurantNo) references restaurant(restaurantNo),
    constraint FK_prodOrder_couponNo foreign key(couponNo) references coupon(couponNo)
);

-- 訂單狀態：訂單成立已寄出已到貨已取貨。
insert into prodOrder (memberNo, restaurantNo, couponNo, orderStatus, prodOrderDate, prodOrderReveiveTime, prodOderDeliverTime, deliverFee, amountBeforeCoupon, amountAfterCoupon, prodOrderPoint, prodOrderReceiverName, prodOrderReceiverTel, prodOrderReceiverMail, prodOrderReceiverAddress, invoiceNumber, taxIDNumber)
values (1, 5, 1, '訂單成立' , now(), '2022-11-22', '2022-11-22 12:34:56', 50, 1000, 900, 100, '游育碩', '0912-345678', 'tibame1@gmail.com', '台北市中正區濟南路一段321號', 'AB-12345678', 80518858 ),
	(2, 4, null, '已寄出' , now(), '2022-11-22', '2022-11-23', 0, 1500, 1400, 0, '張家銘', '0934-345678', 'tibame2@gmail.com', '台北市文山區指南路二段64號', 'AB-23456789', null ),
	(3, 3, 2, '已到貨' , now(), now(), '2022-11-25', 100, 500, 450, 0, '余可凡', '0956-345678', 'tibame3@gmail.com', '台北市羅斯福路四段一號', 'AB-34567890', null ),
	(4, 2, null, '已取貨' , now(), '2022-11-24', '2022-11-24', 0, 2000, 2000, 0, '陳宜瀅', '0978-345678', 'tibame4@gmail.com', '台北市大安區忠孝東路三段1號', 'AB-45678901', null ),
	(5, 1, 3, '訂單成立' , now(), now(), now(), 50, 1500, 1350, 50, '楊婕妤', '0990-345678', 'tibame5@gmail.com', '台北市大安區基隆路4段43號', 'AB-56789012', null );

commit;

--  likedRestaurant
/*==========================================================================================*/

CREATE TABLE `goodEatTime`.`likedRestaurant` (
  memberNo INT NOT NULL,
  restaurantNo INT unsigned NOT NULL,
  PRIMARY KEY (`memberNo`, `restaurantNo`),
  constraint FK_likedRestaurant_restaurantNo foreign key(restaurantNo) references restaurant(restaurantNo)
  );
  
INSERT INTO `goodEatTime`.`likedRestaurant` (`memberNo`, `restaurantNo`) VALUES ('1', '1');
INSERT INTO `goodEatTime`.`likedRestaurant` (`memberNo`, `restaurantNo`) VALUES ('1', '3');
INSERT INTO `goodEatTime`.`likedRestaurant` (`memberNo`, `restaurantNo`) VALUES ('1', '5');
INSERT INTO `goodEatTime`.`likedRestaurant` (`memberNo`, `restaurantNo`) VALUES ('2', '2');
INSERT INTO `goodEatTime`.`likedRestaurant` (`memberNo`, `restaurantNo`) VALUES ('2', '4');
INSERT INTO `goodEatTime`.`likedRestaurant` (`memberNo`, `restaurantNo`) VALUES ('3', '1');
INSERT INTO `goodEatTime`.`likedRestaurant` (`memberNo`, `restaurantNo`) VALUES ('3', '2');
INSERT INTO `goodEatTime`.`likedRestaurant` (`memberNo`, `restaurantNo`) VALUES ('3', '3');
INSERT INTO `goodEatTime`.`likedRestaurant` (`memberNo`, `restaurantNo`) VALUES ('4', '4');
INSERT INTO `goodEatTime`.`likedRestaurant` (`memberNo`, `restaurantNo`) VALUES ('4', '5');
INSERT INTO `goodEatTime`.`likedRestaurant` (`memberNo`, `restaurantNo`) VALUES ('5', '5'); 

ALTER TABLE `goodEatTime`.`likedRestaurant` 
ADD CONSTRAINT FK_likedRestaurant_memberNo
  FOREIGN KEY (`memberNo`)
  REFERENCES `goodEatTime`.`member` (`memberNo`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

commit;

--  memberCoupon
/*==========================================================================================*/

create table memberCoupon(
memberNo int not null comment'會員編號',
couponNo int not null comment'優惠券編號',
usageStatus bit(1) not null default(0) comment'使用狀態',
CONSTRAINT pk_coupon PRIMARY KEY (memberNo, couponNo),
constraint FK_memberCoupon_memberNo foreign key(memberNo) references member(memberNo),
constraint FK_memberCoupon_couponNo foreign key(couponNo) references coupon(couponNo)
);

insert into memberCoupon(memberNo, couponNo, usageStatus)
values(1, 1, 1),(1, 2, 1),(1, 3, 1),(2, 4, 1),(2, 5, 1),
	  (2, 6, 1),(3, 7, 1),(5, 8, 0),(3, 9, 0),(1, 10, 0);
commit;

--  reservation
/*==========================================================================================*/

CREATE TABLE `reservation` (
  `reserveNo` INT NOT NULL AUTO_INCREMENT COMMENT '訂位編號',
  `memberNo` INT NOT NULL COMMENT '會員編號',
  `reserveStatus` VARCHAR(20) NOT NULL COMMENT '訂位狀態',
  `restaurantNo` INT unsigned NOT NULL COMMENT '餐廳編號',
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
  PRIMARY KEY (`reserveNo`),
  constraint FK_reservation_memberNo foreign key(memberNo) references member(memberNo),
  constraint FK_reservation_restaurantNo foreign key(restaurantNo) references restaurant(restaurantNo)
  )
COMMENT = '訂位明細';

insert into reservation (memberNo, restaurantNo, reserveNum, reserveDate, reserveTime, remark, reserveStatus, commentRating, commentContent, commentPic, restaurantCommentTime, restaurantRe, restaurantReTime)
values(5, 1, 3, '2022-11-18', '12:00', null, '報到成功', 4, '服務態度可', null, now(), null, null),
(3, 2, 3, '2022-11-24', '13:00', null, '訂位成功', null, null, null, null, null, null),
(2, 4, 2, '2022-11-17', '19:00', null, '報到成功', 5, '餐點很好吃', null, '2022-11-18 10:33:21', null, null),
(1, 3, 3, '2022-11-25', '18:00', '需要兒童座椅', '訂位成功', null, null, null, null, null, null),
(4, 5, 4, '2022-11-24', '12:00', null, '訂位成功', null, null, null, null, null, null);

commit;

--  prodOrderDetail
/*==========================================================================================*/

create table prodOrderDetail (
	prodOrderNo					integer not null comment '商城訂單編號 PK + FK' ,
	prodNo						integer not null comment '商品編號 PK + FK ' ,
	prodQty						integer not null comment '商品數量' ,
	prodPrice					integer not null comment '商品價格' ,
	prodCommentRating			integer comment '評論星等' ,
	prodCommentContent			varchar(500) comment '評論內容' ,
	prodCommentPic				longblob comment '評論圖片' ,
	prodCommentTime				timestamp comment '評論時間' ,
	restaurantReply				varchar(500) comment '餐廳回覆評論' ,
	restaurantReplyTime			timestamp comment '餐廳回覆時間' ,
    primary key (prodOrderNo , prodNo),
    constraint FK_prodOrderDetail_prodNo foreign key(prodNo) references prodInfo(prodNo),
    constraint FK_prodOrderDetail_prodOrderNo foreign key(prodOrderNo) references prodOrder(prodOrderNo)
);

insert into prodOrderDetail (prodOrderNo, prodNo, prodQty, prodPrice, prodCommentRating, prodCommentContent, prodCommentPic, prodCommentTime, restaurantReply, restaurantReplyTime)
values (1, 1, 1, 199, null, null, null, null, null, null ),
	(2, 2, 2, 80, 3, null, null, '2022-11-22 19:00:00', null, null ),
    (3, 3, 1, 120, null, '我比較愛吃大魔術熊貓麻婆豆腐。', null, '2022-11-22 19:10:00', null, null ),
    (4, 4, 7, 300, 1, '李嚴的食品..，有毒...。', null, '2022-11-22 19:20:00', '謝謝您的支持，我們的商品安全無毒是居家旅行的必備食品，請安心食用。', '2022-11-23 12:00:00' ),
    (5, 5, 9, 30, 5, '價格實惠又好吃，買了真的會開口笑 :)', null, '2022-11-22 19:50:00', '謝謝您的支持，我們致力於提供您更好的消費體驗。', '2022-11-23 12:05:00' );
    
commit;

