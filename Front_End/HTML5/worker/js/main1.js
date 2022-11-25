var first = document.querySelector('#number1');
var second = document.querySelector('#number2');

var result = document.querySelector('.result');

if (window.Worker) {
  console.log("有支援 Worker");
  
  // 建立了一個 Worker 於背景執行
  const myWorker = new Worker("./worker_js/worker1.js");
  
  // 註冊事件的另外一種寫法
  first.onchange = function() {
    console.log('Main: 傳送訊息給 worker(背景執行緒)');
    myWorker.postMessage([first.value, second.value]);
  };

  /*
  first.addEventListener("change", function(){
    console.log('Main: 傳送訊息給 worker(背景執行緒)');
    myWorker.postMessage([first.value, second.value]);
  });
  */
  
  second.onchange = function() {
    console.log('Main: 傳送訊息給 worker(背景執行緒)');
    myWorker.postMessage([first.value, second.value]);
  };
  
  // 監聽從 Worker(背景執行緒) 那邊有沒有傳資料過來，會存在 e.data 裡
  // 註冊事件的另外一種寫法
  myWorker.onmessage = function(e) {
    result.textContent = e.data;
    console.log('Main: 從 Worker(背景執行緒) 接收到資料');
  };

  /*
  myWorker.addEventListener("message", function(){
    result.textContent = e.data;
    console.log('Main: 從 Worker(背景執行緒) 接收到資料');
  });
  */

} else {
  console.log('不支援 Worker');
}