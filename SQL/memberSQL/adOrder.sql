/*=============================================================================
   建立廣告訂單前須先有 (1)餐廳table (2)系統管理員table ，以作為外來鍵關聯依據
  =============================================================================*/

/* =================== 布林值設定0代表未審核、1代表審核通過 ===================*/
/* =================== set autocommit = 0; ====================================*/
/*家銘註解
adminNo 系統管理員編號可以為null, 管理員尚未審核時為null
verified 審核狀態改為可以為null, null:未審核, 0:審核不通過, 1:審核通過
verificationDetail 審核資訊改為可以為null, 管理員尚未審核時為null
insert假資料no.2&3，開始時間晚於結束時間不合理，調整結束時間
adEndTime追加check(adEndTime > adStartTime)
foreign key on update 統一改為restrict(default)
*/
create table adOrder(
adOrderNo int auto_increment not null comment '廣告訂位編號',
restaurantNo int not null comment '餐廳編號',
adminNo int not null comment '系統管理員編號',
adOrderTime timestamp default current_timestamp not null comment '申請日期',
adStartTime date not null comment '開始時間',
adEndTime date not null comment '結束時間',
verified boolean not null comment '審核狀態',
verificationDetail varchar(200) not null comment '審核資訊',
adOrderPrice int not null comment '總金額',
slideshowPic BLOB comment '跑馬燈圖片',                 /* 是否改成longblob */ 
constraint adOrderNo_PK primary key (adOrderNo),
constraint FK_adOrder_restaurantNo foreign key (restaurantNo) references restaurant (restaurantNo) on update cascade,
constraint FK_adOrder_adminNo foreign key (adminNo) references administrator (adminNo) on update cascade
)comment '廣告訂單';

select * from adOrder;

insert into adOrder(restaurantNo, adminNo, adOrderTime, adStartTime, adEndTime, verified, verificationDetail, adOrderPrice, slideshowPic)
values
	(1, 1, now(), '2022-12-01', '2022-12-31', 0, '審核資訊xxx', 1000, null),
    (2, 2, now(), '2023-01-01', '2022-12-31', 0, '審核資訊yyy', 2000, null),
    (3, 3, now(), '2023-02-01', '2022-12-31', 0, '審核資訊zzz', 3000, null);
    
/* =============================== commit; ====================================*/    
