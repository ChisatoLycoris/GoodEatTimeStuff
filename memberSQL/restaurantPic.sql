/*家銘註解
auto_increment的欄位在insert時，一般不會設定values
會交由系統自動生成
但要設定從1001/2001號開始應該也是可以，不確定會不會遇到什麼問題
稍微修改假資料內容
*/
create table restaurantPic(
restaurantPicNo int unsigned auto_increment not null comment '餐廳圖片編號',
restaurantNo int unsigned not null comment '餐廳編號',
restaurantPic longblob comment '餐廳圖片',
restaurantPicRemark varchar(50) comment '餐廳圖片說明',
constraint restaurantPicNo_PK primary key(restaurantPicNo),
foreign key(restaurantNo) references restaurant(restaurantNo));

insert into restaurantPic
value(2001,1001,null,null);

insert into restaurantPic
value(null,1002,null,null);