var countdown_task = function(i) {
    setInterval(function(){
        i--;
        self.postMessage(i);
    },1000);
}

self.onmessage = function(e) {
    countdown_task(e.data);
}