use goodeattime;

/*家銘註解
沒有需要修正的地方~
強烈感受到評論寫的很用心，笑死哈哈哈
*/
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
    primary key (prodOrderNo , prodNo)
);

insert into prodOrderDetail (prodOrderNo, prodNo, prodQty, prodPrice, prodCommentRating, prodCommentContent, prodCommentPic, prodCommentTime, restaurantReply, restaurantReplyTime)
values (10001, 1, 1, 199, null, null, null, null, null, null ),
	(10002, 2, 2, 80, 3, null, null, '2022-11-22 19:00:00', null, null ),
    (10003, 3, 1, 120, null, '我比較愛吃大魔術熊貓麻婆豆腐。', null, '2022-11-22 19:10:00', null, null ),
    (10004, 4, 7, 300, 1, '李嚴的食品..，有毒...。', null, '2022-11-22 19:20:00', '謝謝您的支持，我們的商品安全無毒是居家旅行的必備食品，請安心食用。', '2022-11-23 12:00:00' ),
    (10005, 5, 9, 30, 5, '價格實惠又好吃，買了真的會開口笑 :)', null, '2022-11-22 19:50:00', '謝謝您的支持，我們致力於提供您更好的消費體驗。', '2022-11-23 12:05:00' );
