function WebviewLink(action,url,pageCode,webviewTitle,webviewType,openType){
    var content="{\"action\": \""+action+"\",\"url\": \""+url+"\",\"pageCode\": \""+pageCode+"\",\"webviewTitle\": \""+webviewTitle+"\",\"webviewType\": \"" +webviewType+"\",\"openType\": \""+openType+"\"}";
    //alert(content);
    var base64 = BASE64.encoder(content);//返回编码后的字符
    url = "TCH5CallApp://p=" + base64;
   // alert(url);
   // alert(str);
    location.href  = url;
   // window.event.returnValue = false;
}