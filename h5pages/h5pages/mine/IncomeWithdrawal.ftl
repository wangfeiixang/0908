<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Ratchet">
    <title>收益提现</title>
    <link rel="stylesheet" type="text/css" href="../css/base.css">
    <link rel="stylesheet" type="text/css" href="../css/member.css">
    <link rel="stylesheet" type="text/css" href="../css/header.css">
    <link rel="stylesheet" type="text/css" href="../css/IncomeWithdrawal.css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/base.js"></script>
    <script src="../js/benefits.js"></script>
    <style>
        .mask{
            display: none;
        }

        .confirm-box{
            position: absolute;
            cursor: pointer;
            left: 0;
            top: 300px;
            right:0;
            bottom: 0;
            margin: auto;
            width: 180px;
            height: 50px;
            opacity: 0.6;
            background: #000000;
            border-radius: 8px;
            color:#fff;
            display: none;
            line-height: 50px;
            text-align: center;
            font-family: HelveticaNeue,Helvetica,Arial,sans-serif;
            font-size: 12px;
        }

        .sum input{
            width:82% !important;
        }

    </style>
</head>
<body>
 <header>
      <a class="back"  href="#" onClick="javascript :history.back(-1);"></a>
      <div class="logo">收益提现</div>
    </header>
    <div class="help"></div>

    <div class="earning-wp">
        <span>
          <p class="num">${cashIncome.monthIncome}</p>
          <p class="intro">本月新增收益</p>
        </span>
      <span>
          <p class="num">${cashIncome.total}</p>
          <p class="intro">累计收益</p>
        </span>
      <span>
          <p class="num">${cashIncome.freeze}</p>
          <p class="intro">冻结收益</p>
        </span>
    </div>

    <div class="withdraw">
      <span class="withdraw-span1">当前可提现额度</span>
      <span  class="withdraw-span2">¥${cashIncome.current}</span>
    </div>

 <div class="sum">
     <span>￥</span><input name="cashNum" type="number"  id="max_limit">
     <span class="place">输入要提现的额度</span>
 </div>

 <div class="login color-f2-a submit_apply">提交提现申请</div>

 <div class="mask">
     <div class="shade"></div>
     <div class="pop" >
          <span>您的提现申请已经提交，官方工作人员会在三个工作日内审核并批准您的申请，将款项打入您的银行账户中，请密切关注，及时查收。
          </span>
         <div id="sure_submit">确定</div>
     </div>
 </div>
 <div class="confirm-box"></div>

</body>
</html>