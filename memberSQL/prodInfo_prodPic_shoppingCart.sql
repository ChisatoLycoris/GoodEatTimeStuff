use goodeattime;

set AUTOCOMMIT = 0;

/*整合時須注意沒有被參照的表格先刪，有被參照的表格先建*/
drop table if exists prodPic;
drop table if exists shoppingCart;
drop table if exists prodCategory;
drop table if exists prodInfo;

create table prodPic (
	prodPicNo     integer auto_increment not null comment '商品圖片編號 PK' primary key,
    prodNo        integer not null comment '商品編號 FK',
    prodPic       longblob comment '商品圖片',
    prodPicRemark varchar(200)
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
/*==========================================================================*/

create table shoppingCart (
	memberNo     integer not null comment '商品圖片編號 PK FK',
    prodNo       integer not null comment '商品圖片編號 PK FK',
    prodQty      integer default(1) comment '商品數量' check(prodQty > 0),
    primary key (memberNo, prodNo)
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

/*==========================================================================*/

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

/*==========================================================================*/

create table prodInfo (
	prodNo             integer auto_increment not null comment '商品編號 PK' primary key,
    restaruantNo       integer not null comment '餐廳編號 FK',
    prodCategoryNo     integer comment '商品類別編號 FK',
    prodName           varchar(50) not null comment '商品名稱',
    prodPrice          integer not null comment '商品價格' check(prodPrice > 0),
    prodStock          integer not null default(0) comment '商品庫存' check(prodStock > -1),
    prodDescription    varchar(200) comment '商品說明, 廣告文案',
    prodContent        varchar(200) comment '商品詳細, 商品規格',
    prodCommentQty     integer not null default(0) comment '評論數量' check(prodCommentQty > -1),
    totalCommentRating integer not null default(0) comment '總評論星等' check(totalCommentRating > -1)
) Engine = InnoDB;

insert into prodInfo(restaruantNo, prodCategoryNo, prodName, prodPrice, prodStock, prodDescription, prodContent)
values(1, 1, '日式親子丼調理包', 199, 50, '母雞帶小雞 迸出新滋味', '雞肉、雞蛋、洋蔥、醬油調味'),
(1, 3, 'Uncle Roger特製炒飯', 80, 10, 'HaiYa~', '隔夜飯、雞蛋、蔥、胡蘿蔔再加上滿滿的MSG'),
(2, 3, '六位一體魔幻麻婆豆腐', 120, 5, '辣香色燙酥麻 六位一體', '大麻'),
(2, 6, '李嚴特製炸鳳尾蝦', 300, 99, '將核果搗碎後裹在蝦肉上，油炸成為金黃色', '那...那個醬汁呢?'),
(3, 5, '黃金開口笑', 30, 99, 'ㄤㄤㄤㄤㄤㄤㄤ', '笑到你心裡發麻');
commit;
