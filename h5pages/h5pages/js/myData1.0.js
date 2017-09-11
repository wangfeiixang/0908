
$(function(){

    var data = {
      strCryptonym:/^[\u4e00-\u9fa5\d\a-zA-Z]{1,20}$/,
      strReadyNam:/^[\u4e00-\u9fa5]{2,10}$/,
      strIdcard:/^[\d\A-Za-z]{18}$/,
      phoneSwitch:false,
      tip:null,
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

    //真实姓名验证
    $('#readyName').blur(function(){
        var strName = $(this).val()
        if ( data.strReadyNam.test(strName) ) {
            //data.test('姓名输入正确')
            data.arrData[1] = true;
            judgeColor()
        } else {
            judgeCloseColor()
            data.test('请重新输入姓名')
            data.arrData[1] = false;
            $(this).val('')
            delay()
        }
    })

    //身份证号验证

    $('#idCard').blur(function(){
        var strName = $(this).val()
        // var c = '210300198511112149';
        var res= IdentityCodeValid(strName);
        // console.log( res )
        if ( res ) {
           // data.test('身份证号输入正确')
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


    //身份证的正则验证
    function IdentityCodeValid(code) { 
        var city={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外 "};
        // var data.tip = "";
        var pass= true;
        
        if(!code || !/^\d{6}(18|19|20)?\d{2}(0[1-9]|1[12])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i.test(code)){
            data.tip = "身份证号格式错误";
            pass = false;
        }
        
       else if(!city[code.substr(0,2)]){
            data.tip = "身份证号地址编码错误";
            pass = false;
        }
        else{
            //18位身份证需要验证最后一位校验位
            if(code.length == 18){
                code = code.split('');
                //∑(ai×Wi)(mod 11)
                //加权因子
                var factor = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];
                //校验位
                var parity = [ 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 ];
                var sum = 0;
                var ai = 0;
                var wi = 0;
                for (var i = 0; i < 17; i++)
                {
                    ai = code[i];
                    wi = factor[i];
                    sum += ai * wi;
                }
                var last = parity[sum % 11];
                if(parity[sum % 11] != code[17]){
                    data.tip = "身份证号校验错误";
                    pass =false;
                }
            }
        }
        if(!pass){
           // console.log(data.tip);
        //    return data.tip
        } 
        return pass;
    }
    
    

    
})