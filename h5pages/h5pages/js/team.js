

$(function(){

    var team = {
        data:null,
        memberType:null,
        init:function(){
           // console.log(11)
            this.acceptData('../data/team/我的团队应答.json','all',false);
            this.render();
            this.renderContent();
            this.tab();
        },
        acceptData:function(url,type,boolean){
            //console.log( type,boolean )
            //所有数据
          var that = this; 
          var deff = $.ajax({
                type: "get",//post
                url : url,//"../data/team/我的团队应答.json"
                data: {"action": "ownGroup","type":type},
                contentType:"application/x-www-form-urlencoded;charset=utf-8",
                dataType: "json",
                async: boolean
            })

            //成功事件
            deff.done(function(res){
                that.data = res;
                if ( boolean==true ) {
                    that.renderContent();
                } 
              //  console.log( 'success',that.data )

            })

            //失败事件
            deff.fail(function(res){
                console.log('error',res)
            })
        },
        render:function(){//标题栏
            // console.log(this.data.userList)
            var html = "";
            html =  '<li class="active">'
                       +' <p>'+this.data.totalNum+'</p>'
                       +' <p class="member">会员</p>'
                    +'</li>'
                    +'<li>'
                        +'<p>'+this.data.redNum+'</p>'
                        +'<p class="member">红钻</p>'
                    +'</li>'
                   +'<li>'
                        +'<p>'+this.data.prupleNum+'</p>'
                        +'<p class="member">紫钻</p>'
                    +'</li>'
                   +'<li>'
                        +'<p class="fontSize member">本月</p>'
                        +'<p class="fontSize ">业绩</p>'
                    +'</li>';
            // console.log(html)
            $(".content ul").html(html)
           
        },
        renderContent:function(){//正式会员内容
            console.log( 'renderContent',this.data.userList.length )
            var str = "";
            var label = '';
            if ( this.data.userList.length==0 ) {
                $('.confirm').show()
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

                str += '<li>'
                        + '<p class="left">'
                            +'<span class="teamUser">'
                                +'<span> '+ele.nickName+label+'</span>'
                                +'<span class="font11">'+ele.phoneNum+'</span>'
                            +'</span>'
                        +'</p>'
                        +'<p class="right">'
                            +'<span class="teamPeople">'
                                + '<span>直推<b>'+ele.childNum+'</b>人</span>'
                                +'<span class="font11">'+ele.regDate+'</span>'
                            +'</span>'
                        +'</p>'
                    +'</li>';
            });

            // console.log(str)
            $('.message ul').html(str)
        },
        tab:function(){//选项卡
            var that = this;
            $(".content ul").on('tap',"li",function(){
                var member = $(this).find('p.member').html()
                // console.log( member )
                $(this).addClass('active').siblings('li').removeClass("active");
                switch( member ){
                    case '会员':that.acceptData('../data/team/我的团队应答.json','all',true);break;
                    case '红钻':that.acceptData('../data/team/我的团队应答1.json','red',true);break;
                    case '紫钻':that.acceptData('../data/team/我的团队应答2.json','prople',true);break;
                    case '本月':that.acceptData('../data/team/我的团队应答.json','month',true);break;
                }
                // that.acceptData('all',false);
            })
        }
    }

    team.init();

})