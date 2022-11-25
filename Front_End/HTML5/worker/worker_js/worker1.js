self.onmessage = function(e) {
    console.log('Worker: 從「主執行緒」接收資料');
    var result = e.data[0] * e.data[1];
    // 確認是否是數值is Not a Number內建函式
    if (isNaN(result)) {
      console.log('Worker: 數值錯誤');
      self.postMessage('請輸入兩個數值');
    } else {
      let workerResult = '相乘結果：' + result;
      console.log('Worker: 將資料回傳給「主執行緒」');
      self.postMessage(workerResult);
    
      // 錯誤寫法: worker取用不到document
      // document.querySelector('.result').innerHTML = workerResult;
    }
  };
