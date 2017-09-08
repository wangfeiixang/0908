
$(function(){
    
    //定义变量
    var register = {
        strUser:/^\d{11}$/,
        arrRegister:[false,false,true],
        // strPassword:/^[0-9a-zA-z]{3,20}$/,
        strPassword:/^(?!\D+$)(?![^a-zA-Z]+$)\S{3,20}$/,
        achePassword:null,
        num:60
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
           delay()
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
            delay()
            register.arrRegister[1] = false;
        }

    }

   /*  //获取焦点事件

    $("#user").focus(function(){
        $('.message-box').hide();
        //$(this).val('')
    })

    $("#password").focus(function(){
        $('.message-box').hide();
        //$(this).val('')
    }) */

    //延迟一秒消息框消失
    function delay(){
        setTimeout(function(){
            $('.message-box').hide();
        },1000)
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
 
    //点击登录按钮
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
                delay()
            };
            
            if (  register.arrRegister[0] ) {
                if ( password==""  ) {
                    $('.message-box').show().find('span').html('请输入密码');
                    // console.log('111')
                    delay()
                }else{
                    $('.message-box').show().find('span').html('请重新输入密码,密码是3位到20位字母和数字组合');
                    // console.log('111')
                    delay()
                } 
                 
             }  

            if (  register.arrRegister[1] ) {
                $('.message-box').show().find('span').html('请输入手机号');
                delay()
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