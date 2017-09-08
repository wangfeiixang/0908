<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Ratchet">
    <title>我的收益</title>
    <link rel="stylesheet" type="text/css" href="../css/base.css">
    <link rel="stylesheet" type="text/css" href="../css/member.css">
    <link rel="stylesheet" type="text/css" href="../css/header.css">
    <link rel="stylesheet" type="text/css" href="../css/earnings.css">

    <link rel="stylesheet" type="text/css" href="../css/changeFooter.css">

    <script src="../js/jquery.min.js"></script>
    <script src="../js/base.js"></script>

    <style>
        .profit-div1{
            display: flex;
            justify-content: center;
            align-items: center;
            width: 100%;
        }
        .profit-div1 .profit-span2{
            color:black;
            font-style: 900;
        }

        .profit-span4 .num{
            font-size: 18px;
        }
        .profit-div2 .profit-span4{
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }
        .profit-span4{
            color:black;
            font-size: 16px;
        }

        .span-border{
            border-right: 0.5px solid #333;
        }
        .profit-span4 p:first-child{
            margin-bottom: 10px;
        }

        .earning-wp{
            box-shadow: 0px 5px 10px #e6e6e6 !important;
        }


    </style>

</head>
<body>
  <div class="member-bg">
    </div>
    <header class="no-bgcolor">
      <a class="back"  href="#" onClick="javascript:window.JSBridge.finish()"></a>
      <div class="logo">我的收益</div><a class="dlll" href="http://f.appstore.zshiliu.com/zslapp/appstore-release-v1.0_31001.apk">客户端下载</a>
    </header>
    <div class="help"></div>
    <section style="margin-top: 25px">
      <div class="earning">
          <div class="balance">账户收益</div>
          <h1>${cashIncome.current?if_exists}</h1>
          <p class="tixian"><span><a href="../user/reqCashing.action">收益提现</a></span></p>
          <p class="mingxi"><span><a href="user/incomeDetail.action">账户明细</a></span></p>
      </div>
    </section>
    <div class="earning-wp">
        <span>
          <p class="num">${cashIncome.monthIncome?if_exists}</p>
          <p class="intro">本月新增收益</p>
        </span>
      <span>
          <p class="num">${cashIncome.total?if_exists}</p>
          <p class="intro">累计收益</p>
        </span>
      <span>
          <p class="num">${cashIncome.freeze?if_exists}</p>
          <p class="intro">冻结收益</p>
        </span>
    </div>
    <div class="h-10-colo"></div>
    <div class="profit">
      <div class="profit-div1">
          <span class="profit-span1">分红点：<span class="profit-span2">${scoreIncome.current?if_exists}</span></span>
        <#--<span class="profit-span3"><a href="../user/scoreDetail.action">查看明细</a></span>-->
      </div>
      <div class="profit-div2">
        <span class="profit-span4 span-border">
           <#--<p class="num">${scoreIncome.total?if_exists}</p>-->
          <#--<p class="intro">本月分红点</p>-->
               <p class="num">当前分红点价值</p>
           <p class="intro">${scoreIncome.total?if_exists}元</p>
        </span>
        <span class="profit-span4">
            <p class="num">下次分红结算</p>
          <p class="intro">18天后</p>
           <#--<p class="num">${scoreIncome.total?if_exists}</p>-->
          <#--<p class="intro">累计分红点</p>-->
        </span>
      </div>
    </div>
  <div class="help-h3"></div>


    <footer class="nav">
      <a href="../user/member.action">
        <span>
          <i></i>
          <span>会员中心</span>
        </span>
      </a>
      <a href="#" checked="checked">
         <span>
            <i></i>
            <span>收益</span>
         </span>
      </a>
      <a href="../user/mine.action">
         <span>
            <i></i>
            <span class="margin-left">我的</span>
         </span>
      </a>
    </footer>
</body>
</html>