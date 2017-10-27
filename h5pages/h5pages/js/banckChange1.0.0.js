
$(function(){
    var data = {
        strCryptonym:/^[\u4e00-\u9fa5\d\a-zA-Z]{6,20}$/,
        strReadyNam:/^[\u4e00-\u9fa5]{2,10}$/,
        strBankcard:/^\d{16,19}$/,
        strWebsite:/^[\u4e00-\u9fa5]{2,20}$/,
        arrBank:[false,false,false,false],
        strBank:null,
        test:function(success,failed){
           if (success) {
              $('.message-box').show().find('span').html(success);
           } else if(failed){
              $('.message-box').show().find('span').html(failed);
           }
        }  
      }
    
    //选择银行
    $('.banck-li-wp').on('tap','li',function(){
        // $(".bank").val(  $(this).html() )
        $(this).addClass('active').siblings('li').removeClass('active')
        data.strBank = $(this).html()
        // console.log( data.strBank )
    })

    //提交选中的银行，放到input框中 //提交按钮，数据交互
    $('.true').on('tap',function(){
       
        $(".bank").val( data.strBank )
        var bankValue = $(".bank").val()
         if ( bankValue!='' ) {
            data.arrBank[3]=true;
            judgeColor()
         } else {
            data.arrBank[3]=false;
            judgeCloseColor()
         }
        // var bankId=$("#bankId").val();
        mySwitch()
       
    })


    $('#banckList_shade').on('tap',function(){
        // console.log('1111')
         mySwitch()
    })
    
    
    //开户姓名
    $('.readyName').blur(function(){
        openBank(this)
    })

    function openBank(that){
        var strName = $(that).val()
        if ( data.strReadyNam.test(strName) ) {
            data.arrBank[0]=true;
            judgeColor()
        } else {
            data.test('请重新输入开户姓名')
            data.arrBank[0]=false;
            judgeCloseColor()
            delay(1000)
        }
    }
    
    //开户银行卡号
    $('.bankCard').blur(function(){
       // console.log(111)
       openBankcard(this,0)
    })

    function openBankcard(that,num){
        var strName = $(that).val()
        if ( data.strBankcard.test(strName) ) {
            data.arrBank[1]=true;
            judgeColor()
        } else {
            if (  num==1 && strName.length>15 ) {
                keyupCard()
            } 

            if ( num==0 ) {
                keyupCard()
            } 
           
        }
    }

    function keyupCard(){
        data.test('请重新输入银行卡号')
        data.arrBank[1]=false;
        judgeCloseColor()
        delay(1000)
    }

    //选择开户银行
    $(".bank-code").on('tap',function(){//显示选择银行
        mySwitch()
        // console.log('选择银行111')
        delay(1000)
    })

     //开户网点
    $('#openCardOfBank').blur(function(){
        openWebsite(this)
    })

    function openWebsite(that){
        var strName = $(that).val()
        if ( data.strWebsite.test(strName) ) {
            delay(1000)
            data.arrBank[2]=true;
            judgeColor()
        } else {
            data.test('请重新输入开户网点')
            data.arrBank[2]=false;
            judgeCloseColor()
            delay(1000)
        }
    }

    //键盘事件验证
    //开户行姓名
    $(".readyName").keyup(function(){
        // console.log('键盘事件')
        openBank(this)
    })

    //银行卡号
    $('.bankCard').keyup(function(){
        // console.log(111)
        openBankcard(this,1)
    })

    //开户网点

    $('#openCardOfBank').keyup(function(){
        openWebsite(this)
    })

    
    function mySwitch(){
        document.getElementById('banckList').style.display = document.getElementById('banckList').style.display=='none'?'block':'none';
        document.getElementById('banckList_shade').style.display = document.getElementById('banckList_shade').style.display=='none'?'block':'none';
    }


    $("#submitData").on('click',function(){
         submitData()
    })


     //延迟消息框消失

     function delay(time){
        setTimeout(function(){
            $('.message-box').hide();
        },time)
    }
    
    
    function submitData(){
        var bankId=$("#bankId").val();
        var trueName=$("#trueName").val();
        var cardNo=$("#cardNo").val();
        var openCardOfBank=$("#openCardOfBank").val();
        var bankIdvalue = $("#bankId").attr('placeholder');
        var trueNamevalue = $("#trueName").attr('placeholder');
        var cardNovalue = $("#cardNo").attr('placeholder');
        var openCardOfBankvalue = $("#openCardOfBank").attr('placeholder');

        if ( trueNamevalue =='请输入姓名' && cardNovalue=='请输入卡号' && openCardOfBankvalue=='请输入开户网点' ) {
            console.log('这是第一次填写信息')
            if (  data.arrBank[0] && data.arrBank[1] && data.arrBank[2] && data.arrBank[3]  ) {
                console.log('success这是第一次提交')
                 //级联联动
                sendData(bankId,trueName,cardNo,openCardOfBank)
            }

            return false;

        } 

        if ( bankId =='' ) {
            bankId = bankIdvalue
        } else {
            bankId = bankId
        }

        if ( trueName =='' ) {
            trueName = trueNamevalue
        } else {
            trueName = trueName
        }

        if ( cardNo =='' ) {
            cardNo = cardNovalue
        } else {
            cardNo = cardNo
        }

        if ( openCardOfBank =='' ) {
            openCardOfBank = openCardOfBankvalue
        } else {
            openCardOfBank = openCardOfBank
        }

        // console.log( bankId,trueName,cardNo,openCardOfBank )
        console.log('success这不是第一次提交')
        if (  data.arrBank[0] || data.arrBank[1] || data.arrBank[2] || data.arrBank[3]  ) {
            console.log('success修改任意一项就可以提交')
             //级联联动
             sendData(bankId,trueName,cardNo,openCardOfBank)
        }

    }

    function sendData(bankId,trueName,cardNo,openCardOfBank){

        $.ajax({
            type: "POST",
            url : "../user/saveBankCard.action",
            data: {bankId:bankId,trueName:trueName,cardNo:cardNo,openCardOfBank:openCardOfBank},
            contentType:"application/x-www-form-urlencoded;charset=utf-8",
            dataType: "json",
            success: function(data) {
                console.log(data)
                // window.location.href = '../user/myBankCard.action';
            },
            error:function(err){
                console.log(err,'错误')
            }
        });

        setTimeout(function(){
            window.location.href = '../user/myBankCard.action';
        },1000)

    }



    //控制按钮颜色的转换
    function judgeColor(){
        if ( data.arrBank[0] || data.arrBank[1] || data.arrBank[2] || data.arrBank[3] ) {
            // return false;
            $("#submitData").addClass('color-bk-a').removeClass('color-f2-a')
        } 
    }

    function judgeCloseColor(){
        $("#submitData").addClass('color-f2-a').removeClass('color-bk-a');
    }


    //变更还是绑定银行卡
    function bankChange(){

        var message = $(".bankMessage").html();
        if ( message=='请输入卡号' ) {
            // console.log(11233)
            $(".logo").html('绑定银行卡')
            
        } else{
            $(".logo").html('变更银行卡')
        }
    }

    bankChange()

    
})