// 寫法 1
var i = 0;
function timesCount() {
  i++;
  self.postMessage(i);

  setTimeout(function(){
    timesCount();
  }, 1000);
}
timesCount();



// 寫法 2
/*
var i = 0;
function timesCount() {
  i++;
  self.postMessage(i);
}
timesCount();
setInterval(function(){
  timesCount();
}, 1000);
*/