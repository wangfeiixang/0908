

$(function(){

    var detail = {
        page:0,
        size:10,
        totalPage:null
    }

     // dropload
     $('.content').dropload({
        scrollArea : window,
        domUp : {
            domClass   : 'dropload-up',
            domRefresh : '<div class="dropload-refresh">↓下拉刷新-自定义内容</div>',
            domUpdate  : '<div class="dropload-update">↑释放更新-自定义内容</div>',
            domLoad    : '<div class="dropload-load"><span class="loading"></span>加载中-自定义内容...</div>'
        },
        domDown : {
            domClass   : 'dropload-down',
            // domRefresh : '<div class="dropload-refresh">↑上拉加载更多</div>',
            domLoad    : '<div class="dropload-load"><span class="loading"></span>加载中...</div>',
            domNoData  : '<div class="dropload-noData">暂无数据,请稍后刷新</div>'
        },
        loadUpFn : function(me){
            $.ajax({
                type: "get",//post
                url : "../data/withdrawDetail/提现明细应答.json",//"../data/withdrawDetail/提现明细请求.json"//user/userGetCashDatail.jsp
                data: {"action": "userGetCashDatail","page":detail.page},
                contentType:"application/x-www-form-urlencoded;charset=utf-8",
                dataType: "json",
                success: function(data){
                    var ele = data.detail;
                    var result = '';
                    for(var i = 0; i < ele.length; i++){
                      result += '<li class="Income">'
                                    +'<div class="left">'
                                        +'<span class="money">提现金额<span class="color">'+ele[i].cashNum+'元</span> </span>'
                                        +'<span class="time">2017-06-21</span>'
                                    +'</div>'
                                    +'<div class="right">'
                                        +'<span class="right-money">实际到账<span class="color red">'+ele[i].cashNum*0.8+'元</span> </span>'
                                        +'<span class="right-money right-top">系统暂扣个税<span class="color green">'+ele[i].cashNum*0.2+'元</span> </span>'
                                    +'</div>'
                                +'</li>';
                    }
                    // 为了测试，延迟1秒加载
                    setTimeout(function(){
                        $('.Income-ul').html(result);
                        // 每次数据加载完，必须重置
                        me.resetload();
                        // 重置页数，重新获取loadDownFn的数据
                        page = 0;
                        // 解锁loadDownFn里锁定的情况
                        me.unlock();
                        me.noData(false);
                    },1000);
                },
                error: function(xhr, type){
                    alert('Ajax error!');
                    // 即使加载出错，也得重置
                    me.resetload();
                }
            });
        },
        loadDownFn : function(me){
            detail.page++;
            // 拼接HTML
            var result = '';
            $.ajax({
                type: "get",//post
                url : "../data/withdrawDetail/提现明细应答.json",//"../data/withdrawDetail/提现明细请求.json"//user/userGetCashDatail.jsp
                data: {"action": "userGetCashDatail","page":detail.page},
                contentType:"application/x-www-form-urlencoded;charset=utf-8",
                dataType: "json",
                success: function(data){
                    detail.totalPage = data.totalPage;
                    var ele = data.detail;
                    console.log( data.detail.length,detail.totalPage )
                    if(ele.length > 0){
                        for(var i=0; i<ele.length; i++){
                            result +=   '<li class="Income">'
                                            +'<div class="left">'
                                                +'<span class="money">提现金额<span class="color">'+parseInt(ele[i].cashNum)+'元</span> </span>'
                                                +'<span class="time">'+ele[i].date+'</span>'
                                            +'</div>'
                                            +'<div class="right">'
                                                +'<span class="right-money">实际到账<span class="color red">'+parseInt(ele[i].cashNum*0.8)+'元</span> </span>'
                                                +'<span class="right-money right-top">系统暂扣个税<span class="color green">'+parseInt(ele[i].cashNum*0.2)+'元</span> </span>'
                                            +'</div>'
                                        +'</li>';
                        }
                    // 如果没有数据
                    }else{
                        // 锁定
                        me.lock();
                        // 无数据
                        me.noData();
                    }


                    setTimeout(function(){
                         // 插入数据到页面，放到最后面
                        $('.Income-ul').append(result);
                        // 每次数据插入，必须重置
                    /*  if ( data.detail.length>=10  ) {
                            me.resetload();
                            $('.dropload-down').show();
                        } else {
                            if ( data.detail.length==0 ) {
                                $('.dropload-down').show();
                                me.resetload();
                            } else {
                                $('.dropload-down').hide();
                            }
                            
                        }*/

                        //如果数据总页数大于page的页数
                        if (  detail.page >= detail.totalPage ) {
                            detail.page = detail.totalPage
                            console.log('没有数据')
                            $('.dropload-down').find('div').removeClass('dropload-load').addClass('dropload-noData').html('没有数据了').css('color','#b7b3b3')
                            return;
                        }  
                        me.resetload();
                    },500)

                   
                },
                error: function(xhr, type){
                    console.log('Ajax error!');
                    // 即使加载出错，也得重置
                    me.resetload();
                }
            });
        },
        threshold : 50
    });
    
})