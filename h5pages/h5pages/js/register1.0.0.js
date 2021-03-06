
$(function(){
    
    //定义变量
    var register = {
        strUser:/^\d{11}$/,
        arrRegister:[false,false,true],
        // strPassword:/^[0-9a-zA-z]{3,20}$/,
        strPassword:/^(?!\D+$)(?![^a-zA-Z]+$)\S{3,20}$/,
        achePassword:null,
        num:60,
        send:function(val){
            console.log(111)
            var that = this; 
            var deff = $.ajax({
                  type: "get",//post
                  url : "../data/profile/检查资料是否有效应答.json",//"../data/team/我的团队应答.json"//user/checkData.jsp
                  data: {"action": "checkData","type":"PHONE",data:val},
                  contentType:"application/x-www-form-urlencoded;charset=utf-8",
                  dataType: "json",
              })
  
              //成功事件
              deff.done(function(res){
                 console.log( 'success',res.result )
                 if ( res.result=="OK" ) {
                    console.log('ok')
                 } else if( res.result=="ERROR" ){
                     console.log('error')
                     $('.message-box').show().find('span').html(res.resultMsg);
                     delay(5000)
                 }
              })
  
              //失败事件
              deff.fail(function(res){
                  console.log('error',res)
              })
        }
    }

    //用户名验证
    $("#user").blur(function(){
        var user = $("#user").val();
        if ( register.strUser.test(user) ) {
            $('.message-box').hide();
           register.arrRegister[0] = true;
        } else {
           // console.log(false)
           $('.message-box').show().find('span').html('请重新输入手机号');
           delay(1000)
            register.arrRegister[0] = false;
        }
    })

     //出现X标识，键盘事件
     $("#user").keydown(function(e){
        var value = e.target.value;
        if ( value ) {
            $('.err').show();
        } 
    })

    //密码验证
    
    $("#password").blur(function(){
        blurPassword(this)
        // console.log(888)
    })

    function blurPassword(that){
        var password = $(that).val();  
        register.achePassword = password;
        if ( register.strPassword.test(password) ) {
            $('.message-box').hide();
            register.arrRegister[1] = true;
        } else {
            $('.message-box').show().find('span').html('请重新输入密码,密码是3位到20位字母和数字组合');
            delay(1000)
            register.arrRegister[1] = false;
        }

    }

    //延迟一秒消息框消失
    function delay(time){
        setTimeout(function(){
            $('.message-box').hide();
        },time)
    }



    //点击用户协议,切换背景图
    $(".read-s").on('tap',function(){
        $(this).hide();
        $(".read-n").show();
        register.arrRegister[2] = false;
    })
    

    $(".read-n").on('click',function(){
        $(this).hide();
        $(".read-s").show();
        register.arrRegister[2] = true;
    })

     //点击×清楚号码

     $('.err').on('tap',function(){
        $("#user").val('');
        register.arrRegister[0] = false;
        $(this).hide();
     })
 
    //点击注册按钮
    $("#register").on('click',function(){       
       // console.log(11111)
        if ( register.arrRegister[0] && register.arrRegister[1] && register.arrRegister[2] ) {
            console.log('success')
            // return false;
        } else {
            var value = $("#password").val();
            var phone = $("#user").val();
            if ( phone=="" && value=="" ) {
                $('.message-box').show().find('span').html('请输入手机号和密码');
                delay(1000)
            };
            
            if (  register.arrRegister[0]  && register.arrRegister[2] ) {
                if ( password==""  ) {
                    $('.message-box').show().find('span').html('请输入密码');
                    // console.log('111')
                    delay(1000)
                }else{
                    $('.message-box').show().find('span').html('请重新输入密码,密码是3位到20位字母和数字组合');
                    // console.log('111')
                    delay(1000)
                } 
                 
             }  

            if (  register.arrRegister[1] && register.arrRegister[2] ) {
                $('.message-box').show().find('span').html('请输入手机号');
                delay(1000)
            }

            console.log( register.arrRegister[1],register.arrRegister[2] )
            
            if (  !register.arrRegister[2] ) {
                $('.message-box').show().find('span').html('请点击用户协议');
                delay(1000)
            }

            return false;
        }
    }) 

    //获取验证码，倒计时
    
    $(".register-code").on('tap',function(){
        if (  register.arrRegister[0] ) {
            console.log('开始倒计时')
            countTime()
        } else {
            console.log('未开启倒计时')
            return
        }
       

        
    })

    function countTime(){
        var timer = setInterval(function(){
            register.num --;
            if (  register.num<0 ) {
                clearInterval(timer);
                $('#btn-again').hide();
                $('#btn-again').attr('abled','abled')
                register.num = 60;
               // console.log('success',register.num)
            } else {
                $('#btn-again').html('再次获取（'+register.num+'s）').show();
                $('#btn-again').attr('disabled','disabled')
            }

        },1000)
    }


    
        //键盘按下事件
        $("#password").keyup(function(e){
            console.log(111123)
            var value = e.target.value;
            var phone = $("#user").val();
            console.log('密码的键盘事件',phone,value)
            if ( register.strPassword.test(value) ) {
                register.arrRegister[1] = true;
                  console.log(true)          
            } else {
                register.arrRegister[1] = false;
            }
            eventKeyup()
        })


        function eventKeyup(){
            if (  register.arrRegister[0] &&  register.arrRegister[1] ) {
                loginButton()
            } else{
                loginClose()
            }
        }


        $("#user").keyup(function(e){
            var value = e.target.value;
            var phone = $("#password").val();
            // console.log('密码的键盘事件',phone,value)
            if ( register.strUser.test(value) ) {
                register.arrRegister[0] = true;
                 console.log( true,value ) 
                 //键盘事件验证用户手机号  
                 register.send()       
            } else {
                register.arrRegister[0] = false;
            }

            eventKeyup()
            
        })

        function loginButton(){
            $("#register").addClass('color-f2-a').removeClass('color-bk-a')
         }
  
         function loginClose(){
            $("#register").addClass('color-bk-a').removeClass('color-f2-a')
        }

        function getUserDate(){
            var date = new Date().getTime();
            var date1 = date+30*60*1000;
            var hours = new Date(date1).getHours();
            var minutes = new Date(date1).getMinutes();
            var seconds = new Date(date1).getSeconds();
            if ( hours<10 ) {
                hours = '0'+hours
            }
            
            if ( minutes<10 ) {
                minutes = '0'+minutes
            }
    
            if ( seconds<10 ) {
                seconds = '0'+seconds
            }
    
            var fullTime = hours+":"+minutes
    
            // minutes = new Date( minutes+ ) 
    
            $(".dataTime span").html(fullTime);
    
           // console.log( hours,minutes,seconds,fullTime )
          }
         
          getUserDate()
    
    
    
})