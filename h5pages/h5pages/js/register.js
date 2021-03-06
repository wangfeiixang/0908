
$(function(){
    
    //定义变量
    var register = {
        strUser:/^\d{11}$/,
        arrRegister:[false,false,true,false,false,false],
        strPassword:/^(?!\D+$)(?![^a-zA-Z]+$)\S{3,20}$/,
        strVerifyCode:/^\d{6}$/,
        achePassword:null,
        phone:$('#user').val(),
        passwd:$('#password').val(),
        verifyCode:$('#verifyCode').val(),
        num:60,
        send:function(url,data,boolean,skip){
            
            console.log( '已经发送',data,skip )
            var that = this; 
            var deff = $.ajax({
                  type: "get",//post
                  url : url,//"../data/profile/检查资料是否有效应答.json",//user/checkData.jsp
                  data: data,
                  contentType:"application/x-www-form-urlencoded;charset=utf-8",
                  dataType: "json",
                  async: boolean
              })
  
              //成功事件
              deff.done(function(res){
                 console.log( 'success发送返回结果',res,res.result )
                 if ( res.result=="OK" ) {
                    console.log('返回结果ok')
                    if ( skip=='1' ) {
                        register.arrRegister[4] = true;
                        // console.log( '手机号正确',register.arrRegister[4] )
                    } 

                    if ( skip=='0' ) {//信息验证成功，跳转页面
                        window.location.href = 'user/myData.action';
                    } 

                 } else if( res.result=="ERROR" ){
                     console.log('返回结果error');
                     if ( skip=='1' ) {
                         register.arrRegister[4] = false;
                        //  console.log( '手机号验证重复',register.arrRegister[4] )
                     } 
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

    //验证码验证
    $("#verifyCode").blur(function(){
        var value = $(this).val();
        // console.log('验证码验证')
        if ( register.strVerifyCode.test(value) ) {
            register.arrRegister[3] = true;
            // console.log('验证码验证','success')
        } else {
            register.arrRegister[3] = false;
            // console.log('验证码验证','error')
            $('.message-box').show().find('span').html('请输入验证码');
            delay(1000)
        }

    })

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

         register.send('user/checkData.jsp',{"action": "checkData","type":"PHONE",data:register.phone},false,1)
        
        // register.arrRegister[4] = false;
       if ( !register.arrRegister[4] ) {
            register.arrRegister[0] = false;
            register.arrRegister[5] = true;
       } 
       
       console.log('注册',register.arrRegister[5])
       
        if ( register.arrRegister[0] && register.arrRegister[1] && register.arrRegister[2] && register.arrRegister[3] ) {
            // console.log('success',register.phone,register.passwd)
            register.send('user/userReg.jsp',{"phone": register.phone,"passwd": register.passwd,"type": "REG","verifyCode": register.verifyCode},true,0);//user/userReg.jsp
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
                    $('.message-box').show().find('span').html('请输入密码,密码是3位到20位字母和数字组合');
                    // console.log('111')
                    delay(1000)
                } 
                 
             }  

            if (  register.arrRegister[1] && register.arrRegister[2] ) {
                if ( register.arrRegister[5] ) {
                    $('.message-box').show().find('span').html('此手机号已注册');
                } else{
                    $('.message-box').show().find('span').html('请输入手机号');
                }
                
                delay(1000)
            }

            // console.log( register.arrRegister[1],register.arrRegister[2] )
            
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
            // console.log('开始倒计时')
            countTime()
        } else {
            // console.log('未开启倒计时')
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


    
        //键盘按下事件验证密码
        $("#password").keyup(function(e){
            // console.log(111123)
            var value = e.target.value;
            // console.log('密码的键盘事件',phone,value)
            if ( register.strPassword.test(value) ) {
                register.arrRegister[1] = true;
                register.passwd = value;
                // console.log(true+":密码事件",value,register.passwd) 
            } else {
                register.arrRegister[1] = false;
            }
            eventKeyup()
        })

        //键盘按下事件验证码
        $("#verifyCode").keyup(function(e){
            var value = e.target.value;
            register.verifyCode = value;
            if ( register.strVerifyCode.test(value)  ) {
                register.arrRegister[3] = true;
                // console.log('密码的键盘事件',register.verifyCode,value)
            } else {
                register.arrRegister[3] = false;
            }
            eventKeyup()
      })


        function eventKeyup(){
            // console.log(  register.arrRegister[0] )
            if (  register.arrRegister[0] &&  register.arrRegister[1] && register.arrRegister[3] ) {
                loginButton()
            } else{
                loginClose()
            }
        }

        //键盘事件验证用户手机号  
        $("#user").keyup(function(e){
            var value = e.target.value;
            // console.log('密码的键盘事件',value)
            if ( register.strUser.test(value) ) {
               
                register.arrRegister[0] = true;
                register.phone = value;
                // console.log(true,value,register.phone)
                //"../data/profile/检查资料是否有效应答.json",//user/checkData.jsp
                register.send('user/checkData.jsp',{"action": "checkData","type":"PHONE",data:value},true,1)       
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