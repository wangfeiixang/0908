

$(function(){

    var extend = {
        data:null,
        num:0,
        strPhone:/^\d{11}$/,
        memberType:null,
        init:function(){
           // console.log(11)
            this.acceptData('../teamstatic/ownStatic.jsp','NOMAL',false);
            this.render();
            this.renderContent();
            this.tab();
            this.search();
            this.swiper();
        },
        acceptData:function(url,type,boolean){
            //console.log( type,boolean )
            //所有数据
          var that = this; 
          var deff = $.ajax({
                type: "post",//post
                url : url,//"../data/team/我的推广应答.json"//teamstatic/ownStatic.jsp
                data: {"action": "ownExtension","type":type},
                contentType:"application/x-www-form-urlencoded;charset=utf-8",
                dataType: "json",
                async: boolean
            })

            //成功事件
            deff.done(function(res){
                that.data = res;
                if ( boolean==true ) {
                    that.renderContent();
                    that.render();
                } 
              //  console.log( 'success',that.data )

            })

            //失败事件
            deff.fail(function(res){
                console.log('error',res)
            })
        },
        render:function(){//标题栏
            // console.log(this.data)
            var html = "";
            html =  '<li class="active">'
                        +'<p>'+this.data.nomalNum+'</p>'
                        +'<p class="member">普通会员</p>'
                    +'</li>'
                   +'<li>'
                        +'<p>'+this.data.professionalNum+'</p>'
                        +'<p class="member">直推推广专员</p>'
                   +'</li>'
                    +'<li>'
                        +'<p>'+this.data.diamandNum+'</p>'
                        +'<p class="member">直推钻石专员</p>'
                    +'</li>';
            // console.log(html)
            $(".content ul").html(html);
            $( $(".content ul li")[this.num] ).addClass('active').siblings('li').removeClass('active');
        },
        renderContent:function(){//正式会员内容
            $('.message').show();
            // console.log( 'renderContent',this.data.userList.length )
            var str = "";
            var label = '';
            if ( this.data.userList.length==0 ) {
                $('.confirm').show().find('span').html('找不到任何结果')
                // console.log('没有数据')
            } else{
                $('.confirm').hide()
            }

            this.data.userList.forEach(function(ele,i) {
                //  console.log(ele)
                switch( ele.clubberType ){
                    case 'NORMAL': label = '<i></i>';break;
                    case 'PROFESSIONAL': label = '<i class="memberCommissioner"></i>';break;
                    case 'DIAMOND_RED': label = '<i class="memberRed"></i>';break;
                    case 'DIAMOND_PURPLE': label = '<i class="memberPurple"></i>';break;
                    default :label ='';break;
                }

                str += '<div class="messageList">'
                           +' <div class="message-header">'
                               +' <p>'+ele.nickName+label+' </p>'
                               +' <span>'
                                   +' <span class="font11 left">'+ele.phoneNum+'</span>'
                                   + '<span class="font11 right">'+ele.regDate+'</span>'
                               + '</span>'
                            +'</div>'
                            +'<div class="member">'
                                +'<p >'
                                   +' <span>'+ele.totalNum+'</span>'
                                    +'<span>会员总数</span>'
                                +'</p>'
                                +'<p >'
                                    +'<span>'+ele.professionalNum+'</span>'
                                   +'<span>推广专员</span>'
                                +'</p>'
                                +'<p >'
                                    +'<span>'+ele.redNum+'</span>'
                                    +'<span>红钻会员</span>'
                                +'</p>'
                               +'<p >'
                                   +'<span>'+ele.propulNum+'</span>'
                                    +'<span>紫钻会员</span>'
                                +'</p>'
                            +'</div>'
                        +'</div>';
            });

            // console.log(str)
            $('.message').html(str)
        },
        tab:function(){//选项卡
            var that = this;
            $(".content ul").on('tap',"li",function(){
                // console.log('tap',this)
                that.commonFunction(this);
                // that.acceptData('all',false);
            })
        },
        search:function(){//手机号搜索
            var that = this;
            $("#find").on('tap',function(){
                var value = $('#search').val()
                // console.log( '搜索',value )
                if ( that.strPhone.test(value) ) {
                    // console.log( '搜索成功' )
                    that.acceptData('../teamstatic/ownStatic.jsp','SERACH:'+value,true);
                    $('.confirm').hide();
                    $('.message').show();
                } else {
                    console.log( '搜索失败' )
                    $('.confirm').show().find('span').html('请输入正确的手机号');
                    $('.message').hide();
                }
            })
        },
        commonFunction:function(_this){
            var that = this;
            var member = $(_this).find('p.member').html()
            that.num = $(this).index();
            // console.log( member )
            $(_this).addClass('active').siblings('li').removeClass("active");
            switch( member ){
                case '普通会员':that.acceptData('../teamstatic/ownStatic.jsp','NOMAL',true);break;
                case '直推推广专员':that.acceptData('../teamstatic/ownStatic.jsp','PROFESSIONAL',true);break;
                case '直推钻石专员':that.acceptData('../teamstatic/ownStatic.jsp','DIAMOND',true);break;
            }
            
        },
        swiper:function(){
            var that = this;
            $(".content ul").on('swipeleft','li',function(){
                //alert( $(this).index() )
                that.num = $(this).index();
                // console.log(this)
                that.commonFunction(this);
            })
        }
    }

    extend.init();

    // console.log(11)

})