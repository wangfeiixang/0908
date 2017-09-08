



$(function(){

    // console.log(1)
    //自执行数据请求
    var deff = $.ajax({
        type: "post",//post
        url : "../operation/userOperation.jsp",//operation/userOperation.jsp//../data/community/001-首页应答.json
        data: {"action":"communityFrontPage"},
        contentType:"application/x-www-form-urlencoded;charset=utf-8",
        dataType: "json",
        async: false
    });

    //成功事件
    deff.done(function(res){
        console.log( 'success',res )
        if ( res.operationLevel ) {//当前用户是一级或者二级
            var data = res;
            //console.log(data)
            //存储数据
            localStorage.message = JSON.stringify(data)
           // cookie.set('message', 'data');
            if ( res.operationLevel=='一级' ) {//当前用户是一级
                window.location.href = '../community/communityOne.html'
            } else if( res.operationLevel=='二级' ){//当前用户是二级
                window.location.href = '../community/communityTwo.html'
            }
            
        } else {//当前用户没有社区

            console.log('empty');
            return;
        }
        //window.location.href = '../community/communityOne.html'
    })

    //失败事件
    deff.fail(function(res){
        console.log('error',res)
    })

})