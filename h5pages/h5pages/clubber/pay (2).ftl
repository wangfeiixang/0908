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
    <#--<script src="../js/zepto.min.js"></script>-->
    <#--<script src="../js/touch.js"></script>-->
    <script src="../js/zepto.js"></script>
    <script src="../js/touch.js"></script>
    <script src="../js/base.js"></script>
    <script src="../js/base64.js"></script>

    <style>
        .message-box{
            z-index: 999;
            position: absolute;
            border-radius: 5px;
            left:0;
            right:0;
            top:3rem;
            bottom:0;
            margin: auto;
            width:1.5rem;
            height:.5rem;
            font-size: .12rem;
            text-align: center;
            background: #999;
            color:#fff;
            display: none;
        }

        .message-box span{
            width:1.5rem;
            height:.5rem;
            display: flex;
            justify-content: center;
            align-items: center;
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

        .loading{
            width:150px;
            height:100px;
            z-index: 999;
            position:absolute;
            text-align: center;
            left:0;
            right:0;
            bottom:0;
            font-size: 14px;
            top:0;
            margin: auto;
            background:#9d6ec7;
            border-radius: 20px;
            display: none;
        }

        .loading img{
            width:50px;
        }

        .loading span{
            display:block;
            padding: 10px 0;
            color:#fff;
        }

        .member-men{
            position:relative;
        }

        .memberRed{
            width:.22rem;
            height: .18rem;
            display:none;
            position: absolute;
            top: .01rem;

        }
        .purpleCenter{
            margin-left:28%;
            z-index: 999;
        }

        .cyc-footer{
            width: 100%;
            overflow: hidden;
        }

        .deviceInto{
            position: absolute;
            left: 0;
            bottom:0rem;
            z-index: 999;
            font-size: .16rem;
            background: #fff;
            display: none;
        }

        .deviceInto .devicePay{
            width:100%;
            height: 1.2rem;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .devicePay p{
            text-align: center;
        }


        #copyInput{
            outline: none;
            border:none;
            background: #9666C4;
            color:#fff;
            font-size: .16rem;
            vertical-align: 0;
            display: none;
        }

    </style>
</head>
<body>
<div class="member-bg">

    </div>
    <header class="no-bgcolor">
      <a class="back"  onClick="javascript :window.history.back(); return false;"></a>
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
        <div class="member-men">${userNickName}  <img class="memberRed" src="../img/min/Bitmap.png" ></div>
      </div>
    </section>
    <div class="pay-div">
      <div class="pay-diamond redbg" id="red" data-type="DIAMOND_RED" data-price="${redPrice}">
        <img src="../img/member/btn_red_n.png" alt="">
        <i class="redbg"></i>
      </div>
      <div class="pay-diamond purple purpleCenter" id="purple"  data-type="DIAMOND_PURPLE" data-price="${purplePrice}">
        <img src="../img/member/btn_purple_n.png" alt="">
        <i class="purple"></i>
      </div>
    </div>
    <div class="choose-pay">
      选择支付方式
    </div>

<div class="pay-alipay aliPay">
    <i class="alipay"></i>
    <span>支付宝支付</span>
    <input type="hidden">
    <a checked="checked" class="chk pay_alipay"></a>
</div>
<div class="pay-alipay weChat">
    <i class="wexin"></i>
    <span>微信支付</span>
    <input type="hidden">
    <a class="chk pay_weChat"></a>
</div>
<div class="bg-f6"></div>


<footer class="pay">
    <div class="cyc-footer">
        <div class="cyc-pay-w" >
            <div class="cyc-pay1">还需支付金额：<span>0元</span></div>
        </div>
        <!-- <form action="../user/aliPayPay.action" method="post"> -->
        <!--<div class="cyc-btn" onclick="submitData()">-->
        <!--去支付-->
        <!--</div>-->
        <input type="hidden" name="productCode" id="pay_type" value="DIAMOND_RED"></input>
        <input type="hidden" name="payType" id="payType" value="aliPay"></input>
        <!--<input type="hidden" name="payType" id="payType" value="aliPay"></input>-->
        <input type="submit" id="paySubmit"  value="去支付"></input>
        <!-- </form> -->
    </div>
    <div class="deviceInto">
        <div class="devicePay">
            <p>1. 请复制应用商店下载地址: f.appstore.zshiliu.com/zslapp/release.apk
            </p>
            <p>2. 将复制的地址粘贴到浏览器地址栏，开始下载应用商店并安装<button id="copyInput">下载按钮</button></p>
        </div>

    </div>
</footer>
<div class="message-box">
    <span></span>
</div>
<div class="loading">
    <span></span>
    <img src="../img/member/loading.gif" alt="" srcset="">
</div>
<div class="form"></div>

</body>
</html>
<script src="../js/payBitmap.js"></script>