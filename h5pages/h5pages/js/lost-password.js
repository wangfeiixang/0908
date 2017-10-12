
$(function(){
    var register = {
        strUser:/^\d{11}$/,
        arrRegister:[false,false,false],
        strPassword:/^(?!\D+$)(?![^a-zA-Z]+$)\S{3,20}$/,
        strVerifyCode:/^\d{6}$/,
        achePassword:null,
        href:window.location.href,
        num:60
    }

    //用户名验证
    $("#phone").blur(function(){
        var user = $("#phone").val();
        if ( register.strUser.test(user) ) {
            $('.message-box').hide();
           register.arrRegister[0] = true;
        } else {
           // console.log(false)
           $('.message-box').show().find('span').html('请重新输入手机号');
           delay()
            register.arrRegister[0] = false;
        }
    })

    //密码验证
    
    $("#password").blur(function(){
        blurPassword(this)
        // console.log(888)
    })

    

     //延迟一秒消息框消失
     function delay(){
        setTimeout(function(){
            $('.message-box').hide();
        },2000)
    }


    function blurPassword(that){
        var password = $(that).val();  
        register.achePassword = password;
        if ( register.strPassword.test(password) ) {
            $('.message-box').hide();
            register.arrRegister[1] = true;
        } else {
            $('.message-box').show().find('span').html('请重新输入密码,密码是3位到20位字母和数字组合');
            delay()
            register.arrRegister[1] = false;
        }

    }

    //验证码验证
    $("#verifyCode").blur(function(){
        var value = $(this).val();
        // console.log('验证码验证')
        if ( register.strVerifyCode.test(value) ) {
            register.arrRegister[2] = true;
            // console.log('验证码验证','success')
        } else {
            register.arrRegister[2] = false;
            // console.log('验证码验证','error')
            $('.message-box').show().find('span').html('请输入验证码');
            delay()
        }

    })


    //点击提交按钮
    $("#register").on('click',function(){  
        // console.log(register.href)     
        //  console.log( register.arrRegister[0], register.arrRegister[1], register.arrRegister[2] )
         if ( register.arrRegister[0] && register.arrRegister[1] && register.arrRegister[2] ) {
            console.log('验证成功，发送信息');
            var phone = $('#phone').val();
            var password = $('#password').val();
            var verifyCode = $('#verifyCode').val();
            var deff = $.ajax({
                /* type: "post",//post
                url : "user/userFindPwd.jsp",//user/userFindPwd.jsp//data/user/找回密码应答.json */
                type: "get",
                url : "data/user/找回密码应答.json",
                data: {
                    "phone": phone,
                    "passwd": password,
                    "type": "FIND",
                    "verifyCode": verifyCode
                  },
                contentType:"application/x-www-form-urlencoded;charset=utf-8",
                dataType: "json"
            });
        
            //成功事件
            deff.done(function(res){
                var resultMsg = res.resultMsg;
               console.log( 'success',res,res.resultMsg )
                if ( res.result =='OK' ) {
                    console.log('OK')
                    // window.location.href = './login.html';
                } else if ( res.result =='ERROR' ) {
                    $('.message-box').show().find('span').html(resultMsg);
                    delay()
                    console.log('error')
                }
            })
        
            //失败事件
            deff.fail(function(res){
                console.log('error',res)
            })
            
         } else {
            var value = $("#password").val();
            var phone = $("#phone").val();
             if ( phone=="" && value=="" ) {
                $('.message-box').show().find('span').html('请输入手机号和密码');
                delay()
             } 
            //  console.log('error')
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
            var value = e.target.value;
            var phone = $("#phone").val();
            // console.log('密码的键盘事件',phone,value)
            if ( register.strPassword.test(value) ) {
                register.arrRegister[1] = true;
                //   console.log(true)          
            } else {
                register.arrRegister[1] = false;
            }
            eventKeyup()
      })


      $("#verifyCode").keyup(function(e){
            var value = e.target.value;
            // var phone = $("#phone").val();
            // console.log('密码的键盘事件',phone,value)
            if ( value=="" ) {
                register.arrRegister[2] = false;
                //   console.log(true)          
            } else if( register.strVerifyCode.test(value) ){
                register.arrRegister[2] = true;
            }
            eventKeyup()
      })


    function eventKeyup(){
        if (  register.arrRegister[0] &&  register.arrRegister[1] && register.arrRegister[2] ) {
            loginButton()
        } else{
            loginClose()
        }
    }


    $("#phone").keyup(function(e){
        var value = e.target.value;
        var phone = $("#password").val();
        // console.log('密码的键盘事件',phone,value)
        if ( register.strUser.test(value) ) {
            register.arrRegister[0] = true;
            //  console.log(true)          
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
    
    
    
})
