

var pay = {//数据开关
    paySwitch:false,
    payAlipay:true,
    payWeipay:false,
    paySuccess:false,
    memberRed:false,
    memberPurple:false,
    wxResultData:null,
    wxShowData:null,
    wexinData:null,
    color:false
}

//支付宝支付
$('.aliPay').on('tap',function(){
        var opt =  $('.pay_weChat');
        var obj = $(this).find('.pay_alipay')
        payAlipay(obj,opt)
        pay.payAlipay = true;
        pay.payWeipay = false;
        $(".message-box").hide();
        payType()
})

//微信支付
$('.weChat').on('tap',function(){
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
$("#red").on('tap',function(){
    //console.log('红钻')
    updateMethod(this,'红钻');
    pay.paySwitch = true;
    //  console.log(  pay.memberRed  )
        if ( pay.memberRed ) {
            memberRed(this)
            $("#paySubmit").removeClass('payColor')
            pay.color = true;
        } else {
        $("#paySubmit").removeClass('payColor')
        pay.color = false;
        $('.cyc-pay1 span').html('')
        $("#purple").addClass('purple').removeClass('pay_purple').find('img').attr('src','../img/member/btn_purple_n.png');
        // console.log(  '红钻,失败'  )
        }

    // payType()
        
})

//点击升级紫钻会员
$("#purple").on('tap',function(){
        //console.log('紫钻')
        updateMethod(this,'紫钻','1');
        pay.paySwitch = true;
        if ( pay.memberPurple ) {
            memberPurple(this)
            // console.log('123')
        } else {
        // console.log(  '紫钻,失败'  )
            $("#paySubmit").removeClass('payColor')
            pay.color = false;
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
        pay.color = true;
}


//升级方法
function updateMethod(that,str,strNumber){
        var currentType = $(that).attr('data-type');
        var currentPrice = $(that).attr('data-price');
        var currentRedPrice = $('#red').attr('data-price');
        //  console.log( currentType,currentPrice,currentRedPrice )
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
            case 'red':message=strPurple;$('.cyc-pay1 span').html((currentPrice-currentRedPrice));pay.memberRed =false;
            pay.memberPurple =true;
            break;
            case 'purple':message="您已经是紫钻会员，不用再升级";pay.memberRed =false;pay.memberPurple =false;
            break;
            case 'normal':message="请点击升级为"+str+"会员"; $('.cyc-pay1 span').html(currentPrice);
            $("#paySubmit").css("background","#9666C4");pay.memberRed =true; pay.memberPurple =true;
            break;
        }

        // $(".message-box").show().find('span').html(message);
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
            $('.deviceInto').hide()
            $('.cyc-footer').show()
        } else if( pay.payWeipay ){
        console.log('微信')
            deviceInto()
            $('#payType').val('wxPay');
        }

}

//获取当前会员身份红钻或者紫钻,判断用户类型
function dataType(){
   // console.log('判断会员')
    var type = $(".message").attr('data-type');
    var upgrade = null;
    switch(type){
        case 'DIAMOND_RED': upgrade='red';$('#red').hide();$("#purple").addClass('purpleCenter')
        break;             //红钻
        case 'DIAMOND_PURPLE': upgrade='purple'; $("#purple").removeClass('purpleCenter'); 
        break;       //紫钻
        default:  upgrade='normal'; $("#purple").removeClass('purpleCenter');                          //普通类型
    }
    return upgrade;
}

//付款金额
$("#paySubmit").on('tap',function(){
    //alert('触发事件')
    // console.log( pay.payAlipay,pay.payWeipay )
        if ( pay.payAlipay && pay.payWeipay ) {
            return;
        }else {
            if( pay.payAlipay || pay.payWeipay ){
                console.log('支付')
            // console.log('支付方式隐藏',pay.payAlipay,pay.payWeipay )
                $(".message-box").hide();
                alipyType();
            }else{
                $(".message-box").show().find('span').html('请选择支付方式');
            }
        
        }
})

//判定支付成功与失败
function alipyType(){
    // console.log( pay.color,'这是选中状态1111' )
    //不可选中颜色 rgb(160, 155, 155)
        if ( pay.paySwitch ) {
            if ( pay.color ) {//紫色
                console.log( '这是选中状态' )
                submitData()
            } 
        } 
}

//重置选项,暂时没用
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
            dataType: "json",
            async: false
        
        });

        deff.done(function(res){
            //console.log( res.userId )
            if ( res.prepayid ) {//微信支付
                pay.wexinData = JSON.stringify(res);
                console.log(res,'微信支付');
                callApp();
            } else {
            //返回编码后的字符
                var base64 = utf8to16(base64decode(res.data))
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
       // console.log( typeof(type),type )
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
      // console.log('dataResult')
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
        setTimeout(function(){
            if ( type=='err' ) {
                $('.loading').hide();
               // console.log('支付错误')
            } else {
                //console.log('支付取消或者成功','返回上一页面');
                 window.location.href = '../user/member.action';
                 $('.loading').hide();
            }
        },2000);

   }

   //加上会员身份图标
   function memberImg(){
       var img = dataType();
    //    console.log( img )
       if ( img=="red" ) {
           $(".memberRed").show()
       } else {
            $(".memberRed").hide()
       }
   }

   memberImg()

   //获取用户使用的设备
   function deviceInto(){
       var u = navigator.userAgent;
       console.log('根据用户设备判定');
    //    alert(u)
    if ( u.indexOf('Package/com.zshiliu.appstore') == -1 ) {//Package/com.zshiliu.appstore
        console.log('success');
        $('.deviceInto').show()
        $('.cyc-footer').hide()
        // alert('success')
    } else {
        console.log('error');
        $('.deviceInto').hide()
        $('.cyc-footer').show()
        // alert('error')
    }
    // console.log( u )
   }

   //判断是微信内还是非微信

   function deviceWeixin(){
        var u = navigator.userAgent;
        if ( u.indexOf('MicroMessenger') > -1 ) {//在微信中
            // alert('在微信中');
            $('.deviceInto').show()
            $('.aliPay').hide()
            $('.cyc-footer').hide()
        } else {//没在微信中
            // alert('没有在微信中');
            $('.deviceInto').hide()
            $('.aliPay').show()
            $('.cyc-footer').show()
        }
   }

   setTimeout(function(){
       if ( pay.payAlipay ) {
         deviceWeixin()
       } 

      /*  var u = navigator.userAgent;
       if ( u.indexOf('Android') > -1 ) {//在非微信中
           // alert('复制');
          $("#copyInput").show()
          if( u.indexOf('MicroMessenger')>-1 ){
            $("#copyInput").hide()
          }

            if( u.indexOf('Package/com.zshiliu.appstore')>-1 ){
                $("#copyInput").hide()
            }
       } */

   },0)


   $("#copyInput").on('tap',function(){
        // alert('复制');
        window.location.href="http://f.appstore.zshiliu.com/zslapp/appstore-release-v1.0_31001.apk";
   })
   
  



   

   
   


//    Mozilla/5.0 (Linux; Android 7.0; SM-G9350 Build/NRD90M; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/56.0.2924.87 Mobile Safari/537.36 Package/com.zshiliu.appstore VersionName/1.1 VersionCode/2com.zshiliu.appstore
 