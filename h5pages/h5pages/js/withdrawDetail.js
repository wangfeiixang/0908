

$(function(){

    var detail = {
        page:1,
        size:11,
        init:function(){
            var that = this;
            var deff = $.ajax({
                type: "get",//post
                url : "../data/withdrawDetail/提现明细应答.json",//"../data/withdrawDetail/提现明细请求.json"//user/userGetCashDatail.jsp
                data: {"action": "userGetCashDatail","page":that.page},
                contentType:"application/x-www-form-urlencoded;charset=utf-8",
                dataType: "json",
                // async: false
            })

            //成功事件
            deff.done(function(res){
            //    console.log( 'success',res )
               that.render(res);
            })

            //失败事件
            deff.fail(function(res){
                console.log('error',res)
            })
        },
        render:function(res){
            // console.log(res,res.detail)
            var html = '';
            res.detail.forEach(function(ele,i) {
                // console.log(ele.cashNum,i)
                html += '<li class="Income">'
                           +'<div class="left">'
                               +'<span class="money">提现金额<span class="color">'+ele.cashNum+'元</span> </span>'
                               +'<span class="time">2017-06-21</span>'
                           +'</div>'
                           +'<div class="right">'
                               +'<span class="right-money">实际到账<span class="color red">'+ele.cashNum*0.8+'元</span> </span>'
                               +'<span class="right-money right-top">系统暂扣个税<span class="color green">'+ele.cashNum*0.2+'元</span> </span>'
                           +'</div>'
                       +'</li>';
            });

            $('.Income-ul').html(html);
           
        },
        loading:function(){

            var that = this;

            /* $(document).endlessScroll({
                bottomPixels: 55,
                fireDelay: false,
                fireOnce: false,
                // data:'loading...',
        
                callback: function(p){
                    that.page = p;
                    console.log( that.page )
        
                	var last_img = $("ul#list li:last");
        
                    last_img.after(last_img.prev().prev().prev().prev().prev().prev().clone());
        
                }
        
            }); */

        }
    }

    detail.init();
    detail.loading();

    
    
})