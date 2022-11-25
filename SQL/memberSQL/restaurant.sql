/*家銘註解
restaurantStatus 這種欄位的備註可以再寫多一點，例如以下
comment '餐廳狀態, null: 審核中, 0: 暫停營業, 1: 正常營業'
評論數量與評論星等可以設定not null, 預設初始值為0
auto_increment的欄位在insert時，一般不會設定values
會交由系統自動生成
但要設定從1001號開始應該也是可以，不確定會不會遇到什麼問題
假資料中的電話追加區域碼(02)
*/

create table restaurant(
restaurantNo int unsigned auto_increment not null comment '餐廳編號',
restaurantTel varchar(20) not null comment '電話',
restaurantName varchar(50) not null comment '餐廳名稱',
restaurantTaxIDNo varchar(20) comment '統一編號',
restaurantAccountInfo varchar(50) comment '帳戶資訊',
restaurantBusinessHour varchar(200) not null comment '營業時間',
restaurantAddr varchar(50) not null comment '地址',
restaurantStatus boolean comment '餐廳狀態',
restaurantAccount varchar(20) not null comment '餐廳帳號',
restaurantPassword varchar(50) not null comment '餐廳密碼',
restaurantCommentQuantity int comment '總評論數量',
totalCommentRating int comment '總評論星等',
constraint restaurantNo_PK primary key(restaurantNo));


insert into restaurant
values(1001,'29540410','薄多義','53914855',null,'11:00-20:30','台北市中正區忠孝東路一段150號',null,'restaurant1001','1001restaurant',null,null);

insert into restaurant
values(null,'25963255','欣葉台菜','12107610',null,'11:00-21:00','台北市中正區林森南路1號',null,'restaurant1002','1002restaurant',null,null);