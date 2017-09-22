
$(function(){
        //定义变量
        var login = {
            strUser:/^\d{11}$/,
            arrLogin:[false,false],
            // strPassword:/^[a-zA-z0-9]{3,20}$/,
            strPassword:/^(?!\D+$)(?![^a-zA-Z]+$)\S{3,20}$/,
            hours:null,
            minutes:null,
            seconds:null,
            href:window.location.href,
            achePassword:null
        }
    
        //用户名验证
        $("#user").blur(function(){
            getUser()
        })

        function getUser(){
            var user = $("#user").val();
            if ( login.strUser.test(user) ) {
               // console.log(true)
                 $('.message-box').hide();
               login.arrLogin[0] = true;
            //    loginButton()
            } else {
               // console.log(false)
                $('.message-box').show().find('span').html('请重新输入手机号');
                delay()
                login.arrLogin[0] = false;
            }
        }

        //出现X标识，键盘事件
        $("#user").keydown(function(e){
            var value = e.target.value;
            if ( value ) {
                $('.errx').show();
            } 
        })

    
        //失去焦点事件密码验证
        $("#password").blur(function(){
            blurPassword(this)
            // loginButton()
            // console.log(888)
        })


        //键盘按下事件
        $("#password").keyup(function(e){
            var value = e.target.value;
            var phone = $("#user").val();
            // console.log('密码的键盘事件',phone,value)
            if ( login.strPassword.test(value) ) {
                login.arrLogin[1] = true;
                //  console.log(true)          
            } else {
                login.arrLogin[1] = false;
            }
            eventKeyup()
        })

        $("#two_password").keyup(function(e){
            var value = e.target.value;
            var phone = $("#user").val();
            // console.log('密码的键盘事件',phone,value)
            if ( login.strPassword.test(value) ) {
                login.arrLogin[1] = true;
                //  console.log(true)          
            } else {
                login.arrLogin[1] = false;
            }
            eventKeyup()
        })

        function eventKeyup(){
            if ( login.arrLogin[0] && login.arrLogin[1] ) {
                loginButton()
            } else{
                loginClose()
            }
        }


        $("#user").keyup(function(e){
            var value = e.target.value;
            var phone = $("#password").val();
            // console.log('密码的键盘事件',phone,value)
            if ( login.strUser.test(value) ) {
                login.arrLogin[0] = true;
                //  console.log(true)          
            } else {
                login.arrLogin[0] = false;
            }

            eventKeyup()
            
        })


        
        
        function blurPassword(that){
          //  console.log(that)
            var password = $(that).val(); 
            login.achePassword = password;
            
            if ( login.strPassword.test(password) ) {
                $('.message-box').hide();
                login.arrLogin[1] = true;
                // console.log(true)          
            } else {
                // console.log(false)
                $('.message-box').show().find('span').html('请重新输入密码,密码是3位到20位字母和数字组合');
                delay()
                login.arrLogin[1] = false;
            }
    
        }

        //延迟一秒消息框消失
        function delay(){
            setTimeout(function(){
                $('.message-box').hide();
            },1000)
        }
    
        //可看见验证
        $("#two_password").blur(function(){
            blurPassword(this)
        })
        
        //显示密码
        $(".eye-n").on('tap',function(){
            $(".show").show().val(login.achePassword);
            $(".hidden").hide();
            $(this).hide();
            $("i.eye-s").show();
            var password = $("#password").val();
            $("#two_password").val(password)
            $("#password").attr('name','pass')
            // console.log( '显示密码' ) 
        })
    
        //隐藏密码 ,
        $(".eye-s").on('tap',function(){
            $(".show").hide();
            $(".hidden").show().val(login.achePassword);
            $(this).hide();
            $("i.eye-n").show();
            var password = $("#two_password").val();
            $("#password").val(password)
            $("#password").attr('name','passwd')
            // console.log( '隐藏密码' ) 
        })
    
        //点击登录按钮
        $("#login").on('click',function(){       
            //console.log( login.arrLogin )
                if ( login.arrLogin[0] && login.arrLogin[1] ) {//都验证成功，才能提交登录
                    //  judgeSkip()
                    /*return false; */
                    //console.log('登录成功')
                } else {
                    var value = $("#password").val();
                    var phone = $("#user").val();
                    if ( phone=="" && value=="" ) {
                        $('.message-box').show().find('span').html('请输入手机号和密码');
                        delay()
                    } 

                    if ( login.arrLogin[0] ) {
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

                    if ( login.arrLogin[1] ) {
                        $('.message-box').show().find('span').html('请输入手机号');
                        delay()
                    } 

                   // console.log('登陆失败')
                    return false;
                }
           
        }) 

        
        //忘记密码，跳转lost-password.html
        $(".log-p").on('tap', function(){
            
            if (  login.href.indexOf('user')>-1 ) {
                window.location.href = '../lost-password.html'
            } else {
                window.location.href = './lost-password.html'
            }
            //window.location.href = "./lost-password.html"
        } )
    
        //点击×清除号码
        $('.errx').on('tap',function(){
            $("#user").val('');
            login.arrLogin[0] = false;
            $(this).hide();
        })
       
        //跳转注册页面
        $('.sign-no span').on('tap',function(){
            window.location.href = "./sign_in.html"
        })


       //根据返回的数据进行判断
       function judgeSkip(){
           var judgeMessage = $('.messageError').val();
           if ( judgeMessage=="用户名或密码错误!" ) {
                console.log('重新输入信息')
                $('.message-box').show().find('span').html('用户名或密码错误!,请重新输入');
                // alert(judgeMessage)
                $("#user").val('');
                $("#password").val('');
                $("#two_password").val('');
                login.arrLogin[0]=false;
                login.arrLogin[1]=false;
                delay();
               
           } else {
                console.log('成功跳转')
           }
       }


       setTimeout(function(){
            judgeSkip()
       },0)
      

       function loginButton(){
          $("#login").addClass('color-f2-a').removeClass('color-bk-a')
       }

       function loginClose(){
          $("#login").addClass('color-bk-a').removeClass('color-f2-a')
      }

      //关闭跳转注册页面入口
      function closeRegistor(){
            var u = navigator.userAgent;
            if ( u.indexOf('Package/com.zshiliu.appstore') > -1 ) {//在紫石榴app中 //Package/com.zshiliu.appstore
                $(".sign-no").hide()
            }else{
                $(".sign-no").show()
            }
      }
      closeRegistor();

      //当前时间

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

       //跳转忘记密码页面


      
      
        
    })