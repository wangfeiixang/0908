
var member = {
    type:$('.memberType').html(),
    init:function(){
        this.skip();
        this.imgShow();
    },
    judge:function(){
       if ( this.type=='紫钻会员' ) {
            // console.log('111')
            $('.message-box').show().find('span').html('您已经是最高级会员，无需升级');
            this.hiden()
            return;
       } else {
            // console.log('222')
            window.location.href = '../user/upgradeClubber.action'
       }
    },
    skip:function(){
        var that = this;
        $('.click-tap').on('click',function(){
            // console.log('跳转事件')
            that.judge();
        })
    },
    hiden:function(){
        setTimeout(function(){
            $('.message-box').hide()
        },1000)
    },
    imgShow:function(){
       switch(  this.type ){
            case '红钻会员': $('.memberRed').attr('src','../img/min/Bitmap.png').show();break;
            case '紫钻会员':  $('.memberRed').attr('src','../img/min/BitPurple.png').show();break;
            default : $('.memberRed').hide();break;

       }
    }

}


//console.log( member.type )

member.init()