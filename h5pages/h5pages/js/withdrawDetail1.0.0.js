

$(function(){

    var detail = {
        page:0,
        totalPage:null
    }

     // dropload
     $('.content').dropload({
        scrollArea : window,
        domDown : {
            domClass   : 'dropload-down',
            domRefresh : '<div class="dropload-refresh">↑上拉加载更多</div>',
            domLoad    : '<div class="dropload-load"><span class="loading"></span>加载中...</div>',
            domNoData  : '<div class="dropload-noData">暂无数据,请稍后刷新</div>'
        },
        autoLoad:true,
        loadDownFn : function(me){
            console.log('执行')
            detail.page++;
            // 拼接HTML
            var result = '';
            $.ajax({
                type: "post",//post
                url : "user/userGetCashDatail.jsp",//"../data/withdrawDetail/提现明细请求.json"//user/userGetCashDatail.jsp
                data: {"action": "userGetCashDatail","page":detail.page},
                contentType:"application/x-www-form-urlencoded;charset=utf-8",
                dataType: "json",
                success: function(data){
                    detail.totalPage = data.totalPage;
                    var ele = data.detail;
                    // console.log( data.detail.length,detail.totalPage )
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
                        //如果数据总页数大于page的页数
                        if (  detail.page >= detail.totalPage ) {
                            detail.page = detail.totalPage
                            $('.dropload-down').find('div').removeClass('dropload-load').addClass('dropload-noData').html('没有数据了')
                            // console.log('没有数据')
                            return;
                        } 
                        me.resetload();
                    },1000)
                   
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