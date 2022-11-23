/* =================== 布林值設定0代表未審核、1代表審核通過 ===================*/
/*家銘註解
認知上好像有落差
布林值設定0代表此系統管理員無此權限、1代表有此權限
此表格為平台方管理員的表格，並非是餐廳員工的表格
更改insert的管理員姓名及權限設定
*/
create table `administrator`(
`adminNo` int auto_increment not null comment '系統管理員編號',
`adminAccount` varchar(20) not null comment '帳號',
`adminPassword` varchar (50) not null comment '密碼',
`adminName` varchar (50) not null comment '姓名',
`modifyAdminData` boolean not null comment '新增修改系統管理員帳號',
`modifyMemberData` boolean not null comment '查詢修改會員資料',
`verifyRestaurant` boolean not null comment '審核餐廳',
`verifyAdCoupon` boolean not null comment '審核廣告與折價券',
constraint adminNo_PK primary key (adminNo)) comment '系統管理員';

select * from administrator;
  
insert into administrator(adminAccount, adminPassword, adminName, modifyAdminData, modifyMemberData, verifyRestaurant, verifyAdCoupon)
values
	("res_A_11", "res1_P@ssOrd", "餐廳A", 0,0,0,0),
	("res_A_12", "res2_P@ssOrd", "餐廳B", 0,0,0,0),
    ("res_A_13", "res3_P@ssOrd", "餐廳C", 0,0,0,0);