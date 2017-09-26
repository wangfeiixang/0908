
$(function(){

    var data_money = {
        sum:$(".withdraw-span2").html(), //提现金额最大值
        arrTrue:[false,false],
        data:null,
        valueAfter:null,
        value:null,
        valueBefore:null,
        strNumber:/^\d+$/,
        wipeOff:function(){
            return  parseInt(this.sum.split('¥')[1]);
        }
    }

    //提现额度1
    $(".place").click(function(){
        $(this).hide();
    })

    //输入提交金额
    $("#max_limit").keyup(function(e){
        var current_limit = e.target.value;
        // var num = current_limit%100=0;
        // console.log( current_limit%100 )
        if ( current_limit.indexOf('.') == -1 ) {//不能出现小数点
        //    console.log('success整数')
            data_money.arrTrue[1] = true ;
            $('.message-box').hide();
        } else {
            // console.log('error小数')
            $('.message-box').show().find('span').html('提现金额必须为整数');
            delay(1500)
            data_money.arrTrue[1] = false;
        }

        if (  current_limit<100 && current_limit.length==1 ) {//&& current_limit.length==1
            // console.log('错误')
            $('.message-box').show().find('span').html('提现金额必须大于100,且是100的整数倍');
            delay(1000)
            
        } else if(current_limit.length>2){
            
            if ( current_limit>data_money.wipeOff() || ( current_limit%100!=0 )  ) {
                // console.log('错误')
                var html = ''
                if ( current_limit>data_money.wipeOff() ) {
                    html = '请重新输入提现金额,提现金额必须小于提现额度'
                } else {
                    html = '请重新输入提现金额,提现金额必须是100的整数倍'
                }
                $('.message-box').show().find('span').html(html);
                delay(1500)
                
                data_money.arrTrue[0] = false;
            } else {
                // console.log('成功')
                data_money.arrTrue[0] = true;
               // $('.message-box').hide();
            }
        }

        // console.log( data_money.arrTrue[0],data_money.arrTrue[1] )

        if ( data_money.arrTrue[0] && data_money.arrTrue[1] ) {
            // console.log('提交按钮变换颜色')
            $(".submit_apply").css('background','#CA88ED')
        }else{
            $(".submit_apply").css('background','#F2F2F2')
        }


    })

    //提交申请,出现弹出框

    $(".submit_apply").click(function(){
        if (  $("#max_limit").val()=="" ) {
            // console.log('内容为空不提交');
            return;
        } 

        //判断结果为true，执行命令
        if ( data_money.arrTrue[0] && data_money.arrTrue[1] ) {
            // console.log('success','11')
            // $('.mask').show();
            data_money.sum ='';
            data_money.valueBefore = $('#max_limit').val()/5;
            data_money.value = $('#max_limit').val();
            data_money.valueAfter = $('#max_limit').val()*4/5;
            // console.log( data_money.sum,data_money.valueBefore,data_money.valueAfter )
            var deff = $.ajax({
                type: "get",//post
                url : "../data/user/用户提现应答.json",//../user/userGetCash.jsp//../data/user/用户提现应答.json
                /* type: "post",
                url : "../user/userGetCash.jsp", */
                data: {
                    "action": "userGetCash",
                    "getCashNum": data_money.value
                },
                contentType:"application/x-www-form-urlencoded;charset=utf-8",
                dataType: "json"
            });
        
            //成功事件
            deff.done(function(res){
                data_money.data = res;
                console.log( 'success',data_money.valueBefore,data_money.valueAfter )
                if ( data_money.data.result =='OK' ) {
                    // console.log('OK')
                    $('.mask').show();
                    $(".person").html(data_money.valueBefore);
                    $(".after-tax").html(data_money.valueAfter);
                } else if ( data_money.data.result =='ERROR' ) {
                    $('.mask').hide();
                    $('.message-box').show().find("span").html(data_money.data.resultMsg);
                    delay(2000);
                    $(".submit_apply").css('background','#F2F2F2');
                    $('#max_limit').val('');
                    // console.log('error')
                }
            })
        
            //失败事件
            deff.fail(function(res){
                console.log('error',res)
            })
           
           
           
           
        }
    })

     //延迟一秒消息框消失
     function delay(time){
        setTimeout(function(){
            $('.message-box').hide();
        },time)
    }

    //确认提交

    $("#sure_submit").click(function(){
        $('.mask').hide();
        $("#max_limit").val('');
        $(".submit_apply").css('background','#F2F2F2')
       // $(".place").show()
       setTimeout(function(){
            window.location.href = '../user/userInfo.action'
       },1000)
       
        //跳转地址
    })

    //不同手机屏幕显示不同
    diviceWidth()
    
    function diviceWidth(){

        var diviceWidth = document.documentElement.clientWidth;
        if ( diviceWidth>370 ) {
            $('.pop').css({'height':'410px'})
            // console.log(111)
        }

        if ( diviceWidth>400 ) {
            $('.pop').css({'height':'465px'})
            // console.log(111)
        } 

        if ( diviceWidth>410 ) {
            $('.pop').css({'height':'480px'})
            // console.log(111)
        }

        if ( diviceWidth>434 ) {
            $('.pop').css({'height':'490px'})
            // console.log(111)
        }

        if ( diviceWidth>450 ) {
            $('.pop').css({'height':'502px'})
            // console.log(111)
        }

        if ( diviceWidth>460 ) {
            $('.pop').css({'height':'514px'})
            // console.log(111)
        }

        if ( diviceWidth>470 ) {
            $('.pop').css({'height':'530px'})
            // console.log(111)
        }

        if ( diviceWidth>475 ) {
            $('.pop').css({'height':'535px'})
            // console.log(111)
        }

        if ( diviceWidth>485 ) {
            $('.pop').css({'height':'555px'})
            // console.log(111)
        }
    }
    
            


   
})