#建立使用者優惠券
/*家銘註解
memberNo在memberCoupon表格內並沒有auto_increment
memberNo在member表格內才有auto_increment
memberNo在memberCoupon表格內只能使用已經存在於member表格內的表格才有辦法新增
insert新增memberNo資料
使用狀態設定not null default(0) 預設為0:未使用
*/
create table memberCoupon(
memberNo int not null auto_increment comment'會員編號',
couponNo int not null comment'優惠券編號',
usageStatus boolean comment'使用狀態',
CONSTRAINT pk_coupon PRIMARY KEY (memberNo, couponNo)
);

#建立優惠券
/*家銘註解
max'I'ssueQty 打錯字XD
issuedQty default(0) 預設起始值為0，使用者新增時不用輸入
日期格式按照mysql建議'/'改為'-'
insert values 那邊 amountOrFold 與 couponType的值寫反
*/
create table Coupon(
couponNo int not null auto_increment primary key comment'優惠券編號',
restaurantNo int not null comment'餐廳編號',
adminNo int not null comment'系統管理員編號',
couponApplyDate timestamp default current_timestamp comment'申請日期',
couponName varchar(50) not null comment'優惠券名稱',
couponStartTime date not null comment'開始時間',
couponEndTime date not null comment'結束時間',
verified boolean comment'審核狀態',
couponContent varchar(200) not null comment'優惠券內容',
usageLimitation int comment'訂單金額滿多少可以使用',
amountOrFold double comment'金額 / 折數',
couponType boolean comment'種類:折價 / 打折',
maxlssueQty int not null comment'發行張數上限',
issuedQty int not null comment'已發行張數',
verificationDetail varchar(200) comment'審核資訊'
);

#建資料
insert into memberCoupon(couponNo,usageStatus)
values(1, 1),(2, 1),(3, 1),(4, 1),(5, 1),
	  (6, 1),(7, 1),(8, 0),(9, 0),(10, 0);
	  
insert into Coupon(restaurantNo, adminNo, couponName, 
				   couponStartTime, couponEndTime, verified, couponContent, 
                   usageLimitation, amountOrFold, couponType, maxlssueQty,issuedQty, verificationDetail)
values(1,1,'優惠券1','2022/11/22','2022/11/30',1,'優惠券1內容',1000,1,0.8,1,1,'優惠券審核狀態'),
	  (1,1,'優惠券2','2022/11/22','2022/11/30',1,'優惠券2內容',1000,1,0.8,1,1,'優惠券審核狀態'),
      (1,1,'優惠券3','2022/11/22','2022/11/30',1,'優惠券3內容',1000,1,0.8,1,1,'優惠券審核狀態'),
      (1,1,'優惠券4','2022/11/22','2022/11/30',1,'優惠券4內容',1000,1,0.8,1,1,'優惠券審核狀態'),
      (1,1,'優惠券5','2022/11/22','2022/11/30',1,'優惠券5內容',1000,1,0.8,1,1,'優惠券審核狀態'),
      (1,1,'優惠券6','2022/11/22','2022/11/30',1,'優惠券6內容',1000,1,0.8,1,1,'優惠券審核狀態'),
      (1,1,'優惠券7','2022/11/22','2022/11/30',1,'優惠券7內容',1000,1,0.8,1,1,'優惠券審核狀態'),
      (1,1,'優惠券8','2022/11/22','2022/11/30',0,'優惠券8內容',1000,1,0.8,1,1,'優惠券審核狀態'),
      (1,1,'優惠券9','2022/11/22','2022/11/30',0,'優惠券9內容',1000,1,0.8,1,1,'優惠券審核狀態'),
      (1,1,'優惠券10','2022/11/22','2022/11/30',0,'優惠券10內容',1000,1,0.8,1,1,'優惠券審核狀態')