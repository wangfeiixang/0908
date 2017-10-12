
$(function(){

    var data = {
      strCryptonym:/^[\u4e00-\u9fa5\d\a-zA-Z]{1,20}$/,
      strReadyNam:/^[\u4e00-\u9fa5]{2,10}$/,
      strIdcard:/(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/,
      phoneSwitch:false,
      tip:'身份证号码输入有误',
      arrData:[false,false,false,false],
      hiden:function(){
        $('.message-box').hide();
      },
      test:function(success,failed){
         if (success) {
            $('.message-box').show().find('span').html(success);
         } else if(failed){
            $('.message-box').show().find('span').html(failed);
         }
      },
      send:function(boolean,data,type){
            
            // console.log( 111,type,this.arrData[3] )
            var that = this; 
            var deff = $.ajax({
                type: "get",//post
                url : "../data/profile/检查资料是否有效应答.json",//"../data/profile/检查资料是否有效应答.json",//user/checkData.jsp
                data: {"action": "checkData","type":"IDENTITY",data:data},
                contentType:"application/x-www-form-urlencoded;charset=utf-8",
                dataType: "json",
                async: boolean
            })

            //成功事件
            deff.done(function(res){
                console.log( 'success',res.result )
                if ( res.result=="OK" ) {
                    console.log('ok')
                    if ( type =='1' ) {
                        that.arrData[3] = true;
                    } 
                } else if( res.result=="ERROR" ){
                    console.log('error');
                    if ( type =='1' ) {
                        that.arrData[3] = false;
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
            delay(1000)
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
            //  delay(1000)
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
            delay(1000)
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
            // delay(1000)
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
            delay(1000)
        }
    })


    function idCard(_this){
        var strName = $(_this).val();
        // console.log( strName.length )
        if ( data.strIdcard.test( strName ) ) {
            data.arrData[2] = true;
            console.log( data.arrData[2],strName )
            data.send(true,strName,1)
            judgeColor()
        } else{
            if( strName.length==18 ){
                data.test(data.tip)
                delay(1000)
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
     function delay(time){
        setTimeout(function(){
            $('.message-box').hide();
        },time)
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
        var idNumber = $('#idCard').attr('placeholder');
        // console.log( '信息',idNumber )
        var strName = $("#idCard").val();
        data.send(false,strName,1)
        // return false;
        if ( data.arrData[3] ) {//OK
            data.arrData[2] = true;
        } else {//ERROR
            data.arrData[2] = false;
            // console.log( data.arrData[3],data.arrData[2] )
            if ( !data.arrData[2] ) {
                $('.message-box').show().find('span').html('请重新输入身份号');
                delay(1000)
            }
            return false;
        }

       /*  if ( data.strIdcard.test( idNumber ) ) {
            data.arrData[2] = true;
        } else{
            data.arrData[2] = false;
        } */

        console.log( data.arrData[2] )

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