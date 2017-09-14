/* var data = {
    "operationLevel": "一级",
    "getCash":"-99",
    "bankCardBingdingStatus":"Y",
    "nDay":"3天",
    "signature":"Y"
  }


localStorage.message = JSON.stringify(data) */

var communityOne = {
    data:null,
    init:function(){
        this.render();
        this._submit();
        this._data();
    },
    dataObj:function(){//取出存储信息
       return JSON.parse( localStorage.getItem('message') )
    },
    render:function(){//重新获取提现金额
        this.data = this.dataObj();
        // console.log(this.data)
        $('.content-one span').html(this.data.getCash);
        $('.subsidy p b').html(this.data.cycleIncome);
        $('.subsidy-message').html(this.data.getCash)
        //  alert( this.data.getCash )
        console.log( this.data,$('.subsidy-message') )
    },
    _data:function(){
        this.data = this.dataObj();
       // console.log(this.data.nDay)
        $('.subsidy .allowance').html(this.data.nDay)
    },
    _submit:function(){//申请提现余额
        
        var that =this;
        $('.color').on('tap',function(){
           // alert('tap事件')
            var data = that.dataObj();
           // 获取提现金额必须大于0
           if ( data.getCash<0 ) {
              $('.confirm-message').show().find('.getMessage').html('服务器出错了，请稍等...');
              $('.mask').show();
              that.cash();
              return;
           } 
            console.log('提交',data)
            //判断是否绑定合同
            if ( data.signature=='Y' ) {
                $('.confirm-contract').hide();
                console.log('已经签订合同')
                 //进行判断是否绑定银行卡
                    if ( data.bankCardBingdingStatus=='Y' ) {
                        console.log('绑定银行卡')
                        $('.confirm-bank').hide();
                        that._ajax();
                    } else if( data.bankCardBingdingStatus=='N' ){
                        console.log('没有绑定银行卡')
                        $('.confirm-bank').show();
                        $('.mask').show();
                        that.cash();
                    }

            } else if( data.signature=='N' ){
                $('.confirm-contract').show();
                $('.mask').show();
                console.log('没有签订合同')
                that.cash();
            }
           // console.log('提交')
        })
    },
    cash:function(){//确认按钮后，关闭弹窗
        $('.affirm').on('tap',function(){
            // console.log(111,'确认')
            $('.mask').hide();
            $('.confirm').hide();
            // localStorage.removeItem('message');
            
        })
    },
    _ajax:function(){

        var that =this;
        var deff = $.ajax({
            type: "post",//post
            url : "../data/community/002-提现申请应答.json",//../operation/userOperation.jsp//../data/community/002-提现申请应答.json
            data: {"action":"getCash"},
            contentType:"application/x-www-form-urlencoded;charset=utf-8",
            dataType: "json"
        });
    
        //成功事件
        deff.done(function(res){
           // console.log( 'success',res )
            if ( res.result =='OK' ) {
                var successData = '提现成功'
                console.log('可以提现')
                $('.confirm-message').show().find('.getMessage').html(successData);
                $('.mask').show();
                $('.content-one span').html('0')
            } else if ( res.result =='ERROR' ) {
                var errorsData = '提现失败，请重新提现';
                $('.confirm-message').show().find('.getMessage').html(errorsData);
                $('.mask').show();
                console.log('不可以提现,出现弹窗')
            }
            that.cash();
            //window.location.href = '../community/communityOne.html'
        })
    
        //失败事件
        deff.fail(function(res){
            console.log('error',res)
        })
    }

}

communityOne.init();

