
$(function(){
    var data = {
        strCryptonym:/^[\u4e00-\u9fa5\d\a-zA-Z]{6,20}$/,
        strReadyNam:/^[\u4e00-\u9fa5]{2,10}$/,
        strBankcard:/^\d{16,19}$/,
        strWebsite:/^[\u4e00-\u9fa5]{2,20}$/,
        arrBank:[false,false,false],
        strBank:null,
        hiden:function(){
            $('.message-box').hide();
          },
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
        //console.log( data.strBank )
        $(".bank").val( data.strBank )
        mySwitch()
       
    })


    $('#banckList_shade').on('tap',function(){
        // console.log('1111')
         mySwitch()
    })
    
    
    //开户姓名

    $('.readyName').blur(function(){
        var strName = $(this).val()
        if ( data.strReadyNam.test(strName) ) {
            //data.test('姓名输入正确')
            data.hiden()
            data.arrBank[0]=true;
        } else {
            data.test('请重新输入开户姓名')
            data.arrBank[0]=false;
            delay()
        }
    })
    
    //开户银行卡号

    $('.bankCard').blur(function(){
       // console.log(111)
        var strName = $(this).val()
        if ( data.strBankcard.test(strName) ) {
            //data.test('银行卡号输入正确')
            data.hiden()
            data.arrBank[1]=true;
        } else {
            data.test('请重新输入银行卡号')
            data.arrBank[1]=false;
            delay()
        }
    })

    //银行卡号

    $(".bank-code").on('tap',function(){//显示选择银行
        mySwitch()
        // console.log('选择银行111')
        data.hiden()
    })

     //开户网点
     $('#openCardOfBank').blur(function(){
        var strName = $(this).val()
        if ( data.strWebsite.test(strName) ) {
            //data.test('姓名输入正确')
            data.hiden()
            data.arrBank[2]=true;
        } else {
            data.test('请重新输入开户网点')
            data.arrBank[2]=false;
            delay()
        }
    })

    
    function mySwitch(){
        document.getElementById('banckList').style.display = document.getElementById('banckList').style.display=='none'?'block':'none';
        document.getElementById('banckList_shade').style.display = document.getElementById('banckList_shade').style.display=='none'?'block':'none';
    }


    $("#submitData").on('tap',function(){
         submitData()
    })


     //延迟一秒消息框消失

     function delay(){
        setTimeout(function(){
            $('.message-box').hide();
        },1000)
    }
    
    
    function submitData(){
        var bankId=$("#bankId").val();
        var trueName=$("#trueName").val();
        var cardNo=$("#cardNo").val();
        var openCardOfBank=$("#openCardOfBank").val();
        // console.log( data.arrBank  )

        if ( !( data.arrBank[0] && data.arrBank[1] && data.arrBank[2] ) ) {
            console.log('error')
            return ;
        } 
       // console.log('success',bankId)

        //如果用户没有选中银行，不让提交
        if ( bankId=="" ) {
            console.log('nothing')
            data.test('请选择开户银行')
            return;
        }
        data.hiden();

        //级联联动
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