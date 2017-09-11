<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Ratchet">
    <title>我的银行卡</title>
    <link rel="stylesheet" type="text/css" href="../css/base.css">
    <link rel="stylesheet" type="text/css" href="../css/member.css">
    <link rel="stylesheet" type="text/css" href="../css/header.css">
    <link rel="stylesheet" type="text/css" href="../css/login.css">
    <link rel="stylesheet" type="text/css" href="../css/myBanck.css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/base.js"></script>
    
</head>
<body>
  <header>
      <a class="back"  href="#" onClick="javascript :history.back(-1);"></a>
      <div class="logo">我的银行卡</div>
    </header>
    <div class="help"></div>
    <div class="mycard">
      <p>${bankName}</p>
      <p>${cardNo}</p>
    </div>
    <div class="show-bg"></div>
    <div class="login color-f2-a"><a href="../user/changeCard.action">更换银行卡</a></div>

</body>
</html>