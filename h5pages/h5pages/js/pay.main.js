requirejs.config({
	paths : {
		 "jquery" : "jquery.min"
		//  "payBitmap3.0.0" : "payBitmap3.0.0"

	}
})

requirejs(["jquery"],function($){

		
//  $(function(){
        var pay = {//数据开关
        paySwitch:false,
        payAlipay:true,
        payWeipay:false,
        paySuccess:false,
        memberRed:false,
        memberPurple:false,
        wxResultData:null,
        wxShowData:null,
        wexinData:null
    }

  
        //选择隐藏
       $(".message-box").hide();
       //支付宝支付
       $('.aliPay').click(function(){
               var opt =  $('.pay_weChat');
               var obj = $(this).find('.pay_alipay')
               payAlipay(obj,opt)
               pay.payAlipay = true;
               pay.payWeipay = false;
               $(".message-box").hide();
               payType()
       })
       
       //微信支付
       $('.weChat').click(function(){
               var opt =  $('.pay_alipay');
               var obj = $(this).find('.pay_weChat')
               payAlipay(obj,opt)
               pay.payAlipay = false;
               pay.payWeipay = true;
               $(".message-box").hide();
               payType()
       })
       
       //选中按钮
       function payAlipay(that,opt){
           opt.removeAttr('checked','checked')
           $(that).attr('checked','checked')
       }
       
       
       //选择需要升级什么类型的会员
       
       //点击升级红钻会员
       $("#red").click(function(){
           //console.log('红钻')
           updateMethod(this,'红钻');
           pay.paySwitch = true;
           //  console.log(  pay.memberRed  )
               if ( pay.memberRed ) {
                   memberRed(this)
                   $("#paySubmit").removeClass('payColor')
               } else {
               $("#paySubmit").removeClass('payColor')
               $('.cyc-pay1 span').html('')
               $("#purple").addClass('purple').removeClass('pay_purple').find('img').attr('src','../img/member/btn_purple_n.png');
               // console.log(  '红钻,失败'  )
               }

           // payType()
               
       })
       
       //点击升级紫钻会员
       $("#purple").click(function(){
               //console.log('紫钻')
               updateMethod(this,'紫钻','1');
               pay.paySwitch = true;
               if ( pay.memberPurple ) {
                   memberPurple(this)
               } else {
               // console.log(  '紫钻,失败'  )
                   $("#paySubmit").removeClass('payColor')
               }
       })
       
       function memberRed(that){
               $(that).addClass('pay_red').removeClass('redbg');
               $("#purple").addClass('purple').find('img').attr('src','../img/member/btn_purple_n.png')
               $(that).find('img').attr('src','../img/member/btn_red_s.png')
       }
       
       function memberPurple(that){
               $(that).addClass('pay_purple').removeClass('purple');
               $("#red").addClass('redbg').find('img').attr('src','../img/member/btn_red_n.png');
               $(that).find('img').attr('src','../img/member/btn_purple_s.png')
               $("#paySubmit").addClass('payColor')
       }
       
       
       //升级方法
       function updateMethod(that,str,strNumber){
               var currentType = $(that).attr('data-type');
               var currentPrice = $(that).attr('data-price');
               //console.log( currentType,currentPrice )
               var type =  dataType();
               var strPurple = null;
               var message = null;
               if ( type=="purple" ) {
                   strPurple = "您已经是"+str+"会员，不用再升级";
               } else if( type=="red" ){
                   if ( strNumber=='1' ) {
                       strPurple = "请确认点击升级成紫钻会员";
                   } else{
                       strPurple = "您已经是"+str+"会员，请点击升级成紫钻会员";
                   }
               }

               switch(type){
                   case 'red':message=strPurple;$('.cyc-pay1 span').html(currentPrice);pay.memberRed =false;
                   pay.memberPurple =true;
                   break;
                   case 'purple':message="您已经是紫钻会员，不用再升级";pay.memberRed =false;pay.memberPurple =false;
                   break;
                   case 'normal':message="请点击升级为"+str+"会员"; $('.cyc-pay1 span').html(currentPrice);
                   $("#paySubmit").css("background","#9666C4");pay.memberRed =true; pay.memberPurple =true;
                   break;
               }

               $(".message-box").html(message).show();
               setTimeout(function(){
                   $(".message-box").hide()
               },1000)
               $('#pay_type').val(currentType);
       }

       //确定什么方式的支付
       function payType(){
       // console.log('支付方式判定',pay.payAlipay,pay.payWeipay )
               if ( pay.payAlipay ) {
               // console.log('支付宝')
                   $('#payType').val('aliPay');
               } else if( pay.payWeipay ){
               // console.log('微信')
                   $('#payType').val('wxPay');
               }

       }
       
       
       //获取当前会员身份红钻或者紫钻,判断用户类型
       function dataType(){
           var type = $(".message").attr('data-type');
           var upgrade = null;
           switch(type){
               case 'DIAMOND_RED': upgrade='red'; break;             //红钻
               case 'DIAMOND_PURPLE': upgrade='purple'; break;       //紫钻
               default:  upgrade='normal';                           //普通类型
           }
           return upgrade;
       }
       
       //付款金额
       $("#paySubmit").click(function(){
           // console.log( pay.payAlipay,pay.payWeipay )
               if ( pay.payAlipay && pay.payWeipay ) {
                   return;
               }else {
                   if( pay.payAlipay || pay.payWeipay ){
                   // console.log('支付方式隐藏',pay.payAlipay,pay.payWeipay )
                       $(".message-box").hide();
                       alipyType();
                   }else{
                       $(".message-box").html('请选择支付方式').show();
                   }
               
               }
       })

       //判定支付成功与失败
       function alipyType(){
           var color = $("#paySubmit").css("backgroundColor");
           //不可选中颜色 rgb(160, 155, 155)
           //console.log( color )
               if ( pay.paySwitch ) {
                   if ( color=='rgb(150, 102, 196)' ) {//紫色
                   // console.log( '这是选中状态' )
                       submitData()
                   } 
               } 
       }
       
       //重置选项
       function resertAliay(){
               pay.paySwitch=false;
               pay.payAlipay = true;
               pay.payWeipay = false;
       }

       
       //ajax提交数据，与服务器进行数据交互

       function submitData(){
               var productCode=$("#pay_type").val();
               var payType=$("#payType").val();
               //console.log(productCode,payType);
               var deff = $.ajax({
                   type: "POST",
                   url : "../clubber/pay.jsp",//../data/weixin.json
                   data: {productCode:productCode,payType:payType},
                   contentType:"application/x-www-form-urlencoded;charset=utf-8",
                   dataType: "json"
               
               });

               deff.done(function(res){
                   //console.log( res.userId )
                   if ( res.prepayid ) {//微信支付
                       pay.wexinData = JSON.stringify(res);
                       console.log(res,'微信支付');
                       callApp();
                   } else {
                   //返回编码后的字符
                       var base64 = utf8to16(base64decode(data_b64))
                       $('.form').html(base64)
                       console.log(base64,'支付宝支付')
                   }
               })


               deff.fail(function(res){
                   console.log(res,'error')
               })

           }

           //h5调用APP的方法
           function callApp(){
               window.JSBridge.wxPay(pay.wexinData);
           }



//原生app调用h5方法
function wxPayResult(type){
   //alert(typeof(type),type)
   console.log( typeof(type),type )
       switch(type){
           case 0:pay.wxResultData = 'sucess'
           break;
           case -1:pay.wxResultData = 'error'
           break;
           case -2:pay.wxResultData = 'cancel'
           break;
           default: return;
       }

       dataResult()
}

function dataResult(){
   switch( pay.wxResultData ){
       case 'sucess':pay.wxShowData = '支付成功，请稍等...'; 
       resultState(pay.wxShowData);
       break;
       case 'cancel':pay.wxShowData = '支付取消，请稍等...'; 
       resultState(pay.wxShowData);
       break;
       case 'error':pay.wxShowData = '支付错误，请重新支付'; 
       resultState(pay.wxShowData,'err');
       break;
   }
}

function resultState(str,type){
   $('.loading').show().find('span').html(str);
   setTimeout(()=>{
       if ( type=='err' ) {
           $('.loading').hide();
           console.log('支付错误')
       } else {
           console.log('支付取消或者成功','返回上一页面');
            //  window.location.href = '../user/member.action';
            $('.loading').hide();
       }
   
   },3000);

}
// wxPayResult(-1);

// })


})