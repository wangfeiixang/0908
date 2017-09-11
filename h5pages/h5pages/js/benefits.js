
$(function(){



    var data_money = {
        sum:$(".withdraw-span2").html(), //提现金额最大值
        arrTrue:[false,false],
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
        if ( current_limit.indexOf('.')<0 ) {//不能出现小数点
        //    console.log('success整数')
            data_money.arrTrue[1] = true ;
            $('.confirm-box').hide();
            
           
        } else {
            // console.log('error小数')
            $('.confirm-box').html('提现金额必须为整数').show();
            delay()
            data_money.arrTrue[1] = false;
        }

        if ( current_limit>data_money.wipeOff() ||  current_limit<=0 ) {
            // console.log('错误')
            $('.confirm-box').html('请重新输入提现金额').show();
            delay()
            data_money.arrTrue[0] = false;
        } else {
            // console.log('成功')
            data_money.arrTrue[0] = true;
           // $('.confirm-box').hide();
        }

        if ( data_money.arrTrue[0] && data_money.arrTrue[1] ) {
            console.log('提交按钮变换颜色')
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
            $('.mask').show();
            data_money.sum ='';
           // console.log( data_money.sum )
        }
    })

     //延迟一秒消息框消失

     function delay(){
        setTimeout(function(){
            $('.confirm-box').hide();
        },1000)
    }

    //确认提交

    $("#sure_submit").click(function(){
        $('.mask').hide();
        $("#max_limit").val('')
       // $(".place").show()
       setTimeout(function(){
            window.location.href = '../user/userInfo.action'
       },1000)
       
        //跳转地址
    })



   
})