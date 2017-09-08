<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Ratchet">
    <title>我的二维码</title>
    <link rel="stylesheet" type="text/css" href="../css/base.css">
    <link rel="stylesheet" type="text/css" href="../css/member.css">
    <link rel="stylesheet" type="text/css" href="../css/header.css">
    <link rel="stylesheet" type="text/css" href="../css/QRcode.css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/base.js"></script>
    

</head>
<body>
   <div class="member-bg">

    </div>
    <header>
      <a class="back" onClick="javascript :window.history.back(); return false;"></a>
      <div class="logo">我的二维码</div>
    </header>
    <div class="help"></div>
    <section style="margin-top: 25px">
      <div style="position: relative;">
        <div class="member-img">
          <img src="../img/member/Group5.png" alt="">
        </div>
        <div class="member-men">我是${nickName}，这是我的二维码</div>
      </div>
    </section>
    <div class="mine">
      <img class="code" src="../QRCode/user.QRCode" alt="">
      <p></p>
    </div>

</body>
</html>