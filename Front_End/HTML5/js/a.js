// load  頁面上所有元件出現後觸發
window.addEventListener("load", function(){
    console.log("ttt")
});
// DOMContentLoaded  標籤渲染完後觸發(會比load事件先觸發)，不管圖片影片等內容
document.addEventListener("DOMContentLoaded", function(){
    console.log("aaa");
    
    var my_a = document.getElementsByTagName("h1");
    console.log(my_a);
    my_a[0].addEventListener("click", function(){
        alert("tttt");
    });
});