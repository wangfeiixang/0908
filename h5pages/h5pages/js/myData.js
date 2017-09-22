
$(function(){

    var data = {
      strCryptonym:/^[\u4e00-\u9fa5\d\a-zA-Z]{1,20}$/,
      strReadyNam:/^[\u4e00-\u9fa5]{2,10}$/,
      strIdcard:/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/,
      phoneSwitch:false,
      tip:'身份证号码输入有误',
      arrData:[false,false,false],
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

    //名称验证
    $('#cryptonym').blur(function(){
        var strName = $(this).val()
        if ( data.strCryptonym.test(strName) ) {
           // data.test('昵称输入正确')
            data.arrData[0] = true;
            data.phoneSwitch = true;
            judgeColor()

        } else {
            judgeCloseColor()
            data.test('请最少输入1位以上昵称')
            data.arrData[0] = false;
            data.phoneSwitch = false;
            delay()
        }
        // console.log( '验证用户名', data.arrData[0] )
    })


    function cryptonym(_this){
        var strName = $(_this).val();
        if ( data.strCryptonym.test(strName) ) {
            // data.test('昵称输入正确')
             data.arrData[0] = true;
             data.phoneSwitch = true;
             judgeColor()
 
         } else {
             judgeCloseColor()
            //  data.test('请最少输入1位以上昵称')
             data.arrData[0] = false;
             data.phoneSwitch = false;
            //  delay()
         }
        
    }

    //真实姓名验证
    $('#readyName').blur(function(){
        // readName(this)
        var strName = $(this).val()
        if ( data.strReadyNam.test(strName) ) {
            //data.test('姓名输入正确')
            data.arrData[1] = true;
                // judgeColor()
        } else {
            // judgeCloseColor()
            data.test('请重新输入姓名')
            data.arrData[1] = false;
            $(this).val('')
            delay()
        }
    })



    function readName(_this){
        var strName = $(_this).val()
        // console.log( strName.length )
        if ( data.strReadyNam.test(strName) ) {
            data.arrData[1] = true;
            judgeColor()
        } else {
            judgeCloseColor()
            // data.test('请重新输入姓名')
            // delay()
            data.arrData[1] = false;
        }
        
    }

    //身份证号验证
    $('#idCard').blur(function(){
        var strName = $(this).val()
        if ( data.strIdcard.test( strName ) ) {
            data.arrData[2] = true;
            judgeColor()
        } else {
            judgeCloseColor()
            data.test(data.tip)
            data.arrData[2] = false;
            $(this).val('')
            delay()
        }
    })


    function idCard(_this){
        var strName = $(_this).val();
        // console.log( strName.length )
        if ( data.strIdcard.test( strName ) ) {
            data.arrData[2] = true;
            judgeColor()
        } else{
            if( strName.length==18 ){
                data.test(data.tip)
                delay()
            }
            judgeCloseColor()
            data.arrData[2] = false;
        }
        
    }

    //键盘事件验证
    $("#readyName").keyup(function(e){
        // console.log('键盘事件')
        readName(this)
    })

    $("#idCard").keyup(function(e){
        // console.log('键盘事件')
        idCard(this)
    })

    $("#cryptonym").keyup(function(e){
        // console.log('键盘事件')
        cryptonym(this)
    })

     //延迟一秒消息框消失
     function delay(){
        setTimeout(function(){
            $('.message-box').hide();
        },1000)
    }

    //昵称如果有，就可以直接跳转
    function judgeTrue(){
        var phoneMessage = $('.phoneMessage').html();
        if ( !data.phoneSwitch ) {
            $('#cryptonym').val(phoneMessage)
        } 
        data.arrData[0] = true;
        judgeColor()
        // console.log( phoneMessage,data.arrData[0] )
    }

    //提交
    $("#myDatasubmit").click(function(){
        judgeTrue()
        if ( data.arrData[0] || data.arrData[1] || data.arrData[2] ) {
            console.log('success')
            // return false;
        } else {
            //console.log('error')
            return false;
        }
    })

    function judgeColor(){
        if ( data.arrData[0] || data.arrData[1] || data.arrData[2] ) {
            // return false;
            $("#myDatasubmit").addClass('color-bk-a').removeClass('color-f2-a')
        } 
    }

    function judgeCloseColor(){
        $("#myDatasubmit").addClass('color-f2-a').removeClass('color-bk-a');
    }

    //获取焦点事件

    function deleteFont(obj){
        $(obj).focus(function(){
            // console.log( '焦点事件',this,$(this).attr('placeholder') )
            $(obj).attr('placeholder','') 
        })
    }
    deleteFont('#cryptonym');
    deleteFont('#readyName');
    deleteFont('#idCard');
    
    
})