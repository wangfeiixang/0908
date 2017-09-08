function finish(){
    window.JSBridge.finish();
}

function share(content){
    window.JSBridge.share(content);
}

function pay(){
    window.JSBridge.wxPay('{"partnerid":"1488326982","noncestr":"3E070CF9154D8DA207AFD71419FEC758","timestamp":1504152465,"prepayid":"null","sign":"EBCFC37784B93EAD105B9CD5FDA7CB51"}');
}

function wxPayResult(code){
    alert("code:"+code);
}