<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Ratchet">
    <title>会员</title>
    <link rel="stylesheet" type="text/css" href="../css/base.css">
    <link rel="stylesheet" type="text/css" href="../css/member.css">
    <link rel="stylesheet" type="text/css" href="../css/header.css">
    <link rel="stylesheet" type="text/css" href="../css/payred.css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/base.js"></script>
    <script src="../js/payBitmap.js"></script>
    <style>
        .message-box{
            z-index: 999;
            position: absolute;
            border-radius: 5px;
            left:0;
            right:0;
            top:280px;
            bottom:0;
            margin: auto;
            width:150px;
            height:50px;
            font-size: 12px;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            background: #999;
            color:#fff;
            padding: 0 3px;
        }

        .pay_red{
            background: url(../img/member/card_redbg_s.png) no-repeat;
            background-size: 100%;
        }
        .pay_purple{
            background: url(../img/member/card_purplebg_s.png) no-repeat;
            background-size: 100%;
        }
        #paySubmit{
            height: 0.525rem;
            float: right;
            background:#a09b9b;
            color:#fff;
        }

        .payColor{
            background: #9666C4 !important;
        }

    </style>
</head>
<body>
<div class="member-bg">

    </div>
    <header class="no-bgcolor">
      <a class="back"  href="#" onClick="javascript :history.back(-1);"></a>
      <div class="logo">会员</div>
    </header>
    <div class="help"></div>
    <section style="margin-top: 25px">
        <#--用户当前的会员类型-->
            <div class="message" style="display:none"  data-type="${userClubberType}"></div>
      <div style="position: relative;">
        <div class="member-img">
          <img src="../img/member/Group5.png" alt="">
        </div>
        <div class="member-men">${userNickName}</div>
      </div>
    </section>
    <div class="pay-div">
      <div class="pay-diamond redbg" id="red" data-type="DIAMOND_RED" data-price="${redPrice}">
        <img src="../img/member/btn_red_n.png" alt="">
        <i class="redbg"></i>
      </div>
      <div class="pay-diamond purple" id="purple"  data-type="DIAMOND_PURPLE" data-price="${purplePrice}">
        <img src="../img/member/btn_purple_n.png" alt="">
        <i class="purple"></i>
      </div>
    </div>
    <div class="choose-pay">
      选择支付方式
    </div>

    <div class="pay-alipay">
        <i class="alipay"></i>
        <span>支付宝支付</span>
        <input type="hidden">
        <a checked="checked" class="chk pay_alipay"></a>
    </div>
    <#--<div class="pay-alipay">-->
        <#--<i class="wexin"></i>-->
        <#--<span>微信支付</span>-->
        <#--<input type="hidden">-->
        <#--<a class="chk pay_weChat"></a>-->
    <#--</div>-->
    <div class="bg-f6"></div>


<footer class="pay">
    <div class="cyc-footer">
        <div class="cyc-pay-w" >
            <div class="cyc-pay1">还需支付金额：<span>0元</span></div>
        </div>
        <form action="../user/aliPayPay.action" method="post">
            <#--<div class="cyc-btn" onclick="submitData()">-->
                <#--去支付-->
            <#--</div>-->
            <input type="hidden" name="productCode" id="pay_type" value="DIAMOND_RED"></input>
                <input type="hidden" name="payType" value="aliPay"></input>
            <#--<input type="hidden" name="payType" id="payType" value="aliPay"></input>-->
            <input type="submit" id="paySubmit"  value="去支付"></input>
            <#--<input type="submit" style="background-color:rgba(0, 0, 0, 0);color:#fff;" value="去支付"></input>-->
        </form>
    </div>
</footer>
<div class="message-box"></div>

<script language="javascript">

    function submitData(){
        var productCode=$("#productCode").val();
        var payType=$("#payType").val();


        //级联联动
        $.ajax({
            type: "POST",
            url : "../user/aliPayPay.action",
            data: {productCode:productCode,payType:payType},
            contentType:"application/x-www-form-urlencoded;charset=utf-8",
            dataType: "json",
            success: function(data) {
                console.log(111) ;
                console.log(data) ;
                //window.location.href = '../user/myBankCard.action';
            }
        });
    }

</script>

</body>
</html>