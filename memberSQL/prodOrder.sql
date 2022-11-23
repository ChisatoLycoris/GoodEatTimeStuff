use goodeattime;

-- 訂單編號由10001起始，每次跳1號。
alter table prodOrder auto_increment = 10001;
set auto_increment_increment=1;
/*家銘註解
auto_increment的欄位在insert時，一般不會設定values
會交由系統自動生成
但要設定從10001號開始應該也是可以，不確定會不會遇到什麼問題
orderStatus增加預設值 default('訂單成立')
運費設定not null，沒有運費就0，方便後續程式計算(避免NullPointerException)
紅利點數設定not null，沒有紅利點數就0，方便後續程式計算(避免NullPointerException)
假資料中的時間123456為非法值，刪除或改為12:34:56
*/
create table prodOrder (
	prodOrderNo					integer	auto_increment not null comment '商城訂單編號' primary key , 
    memberNo					integer	not null comment '會員編號' ,
	restaurantNo				integer not null comment '餐廳編號' ,
	couponNo					integer	comment '優惠券編號' , 
	orderStatus					varchar(20) not null comment '訂單狀態' ,
	prodOrderDate				timestamp not null default(now()) comment '訂單時間' ,
	prodOrderReveiveTime		datetime comment '收貨時間' ,
	prodOderDeliverTime			datetime comment '出貨時間' ,
	deliverFee					integer comment '運費' ,
	amountBeforeCoupon			integer	not null comment '訂單原始金額' ,
	amountAfterCoupon 			integer	not null comment '訂單折扣後金額' ,
	prodOrderPoint				integer comment '紅利點數' ,
	prodOrderReceiverName		varchar(20)	not null comment '收貨人姓名' ,
	prodOrderReceiverTel		varchar(20) not null comment '收貨人電話' ,
	prodOrderReceiverMail		varchar(100) not null comment '收貨人MAIL' ,
	prodOrderReceiverAddress	varchar(100) not null comment '收貨地址' ,
	invoiceNumber				varchar(20) not null comment '發票號碼' ,
	taxIDNumber					varchar(20) comment '統一編號' 
);

-- 訂單狀態：訂單成立已寄出已到貨已取貨。
insert into prodOrder (memberNo, restaurantNo, couponNo, orderStatus, prodOrderDate, prodOrderReveiveTime, prodOderDeliverTime, deliverFee, amountBeforeCoupon, amountAfterCoupon, prodOrderPoint, prodOrderReceiverName, prodOrderReceiverTel, prodOrderReceiverMail, prodOrderReceiverAddress, invoiceNumber, taxIDNumber)
values (101, 1001, 17000, '訂單成立' , now(), '2022-11-22 123456', '2022-11-22 123456', 50, 1000, 900, 100, '游育碩', '0912-345678', 'tibame1@gmail.com', '台北市中正區濟南路一段321號', 'AB-12345678', 80518858 ),
	(102, 1002, null, '已寄出' , now(), '2022-11-22 123456', '2022-11-23 123456', null, 1500, 1400, null, '張家銘', '0934-345678', 'tibame2@gmail.com', '台北市文山區指南路二段64號', 'AB-23456789', null ),
	(103, 1003, 17001, '已到貨' , now(), now(), '2022-11-25 123456', 100, 500, 450, null, '余可凡', '0956-345678', 'tibame3@gmail.com', '台北市羅斯福路四段一號', 'AB-34567890', null ),
	(104, 1004, null, '已取貨' , now(), '2022-11-24 123456', '2022-11-24 123456', null, 2000, 2000, null, '陳宜瀅', '0978-345678', 'tibame4@gmail.com', '台北市大安區忠孝東路三段1號', 'AB-45678901', null ),
	(105, 1005, 17002, '訂單成立' , now(), now(), now(), null, 1500, 1350, 50, '楊婕妤', '0990-345678', 'tibame5@gmail.com', '台北市大安區基隆路4段43號', 'AB-56789012', null );
