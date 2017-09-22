

$(function(){

    var detail = {
        init:function(){
            var that = this;
            var deff = $.ajax({
                type: "get",//post
                url : "../data/team/我的推广应答.json",//"../data/team/我的推广应答.json"//teamstatic/ownStatic.jsp
                data: {"action": "ownExtension","type":'type'},
                contentType:"application/x-www-form-urlencoded;charset=utf-8",
                dataType: "json",
                async: false
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
            var html = '';
            console.log(res)
        }
    }

    detail.init();
    
})