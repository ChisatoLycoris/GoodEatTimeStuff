感謝大家協助完成資料庫建立的sql指令~
這邊已經彙整成goodEatTimeDatabase.sql檔案

~~使用方法如下~~
第一次使用時先建立一個goodeattime的schema
(如果已經有了的話建議刪掉重建，或是至少把table刪光)
有了goodeattime的schema後
游標不選取文字的情況下按閃電按鈕(儲存按鍵的右邊那個最左邊的閃電)
即可完成資料庫建立

後續若因測試程式把資料庫的資料弄得很亂
或是不小心把資料庫表格或欄位刪光時，一樣只要
游標不選取文字的情況下按閃電按鈕(儲存按鍵的右邊那個最左邊的閃電)
即可恢復資料庫預設的初始狀態

~~需要請大家協助幫忙的事項~~
針對大家的sql檔案，我有寫上我的註解
彙整的sql檔案皆是按照註解內容去稍做修改的
請大家協助確認自己負責表格
我這邊修改的內容是否有問題
也請確認建立完成的資料庫，自己負責的表格是否正確無誤

如果有任何問題再麻煩盡快告知或是詢問，感謝大家


以下這個議題，後續再幫忙稍微留意一下
============================================================
mySQL  boolean vs tinyint
mySQL中新增欄位設定為boolean 型別時
系統好像會強制轉換成tinyint 型別
若用sql指令存入true會轉換為1，false則會轉換成0

stackoverflow上說這2種型別是相同的...?
https://stackoverflow.com/questions/3751853/boolean-vs-tinyint1-for-boolean-values-in-mysql

mySQL官網上的資料型別，並沒有boolean 型別...
https://dev.mysql.com/doc/refman/8.0/en/data-types.html

問題點:
sql指令輸入0或1以外的數字(-128~127)仍可以正常存入mySQl中

後續可能要注意的地方:
VO對應屬性設定為boolean，true & false是否能正常存入資料庫
從資料庫取出資料時，資料庫儲存的1&0是否能正確且自動轉換成java boolean型別

個人認為以上應該是都會正常運作，所以老師才沒有特別說
再請各位同學有寫道boolean型別的dao時，幫忙協助留意一下