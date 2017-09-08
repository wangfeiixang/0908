<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Ratchet">
    <title>完善资料</title>
    <link rel="stylesheet" type="text/css" href="../css/base.css">
    <link rel="stylesheet" type="text/css" href="../css/member.css">
    <link rel="stylesheet" type="text/css" href="../css/header.css">
    <link rel="stylesheet" type="text/css" href="../css/login.css">
    <link rel="stylesheet" type="text/css" href="../css/intactData.css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/base.js"></script>
    

</head>
<body>
 <header>
      <a class="back"  href="#" onClick="javascript :history.back(-1);"></a>
      <div class="logo">您还需要完善以下信息</div>
    </header>
    <div class="help"></div>
    <div class="help2"></div>

    <div class="input">
      <span class="sign-code">会员账号</span>
      <input type="text" name="" readonly="readonly" placeholder="请输入账号">
    </div>
    <div class="input">
      <span class="sign-code">我的名称</span>
      <input type="text" name="" placeholder="请输入名称">
    </div>
    <div class="input">
      <span class="sign-code">真实姓名</span>
      <input type="text" name="" placeholder="请输入姓名">
    </div>
    <div class="input">
      <span class="sign-code">身份证号</span>
      <input type="text" name="" placeholder="请输入身份账号">
    </div>
    <div class="input"@click="showbanck=!showbanck">
      <span class="sign-code">开户银行</span>
      <input class="input-text" type="text" name="" placeholder="请输入开户银行">
      <span class="i-arrow-r"></span>
    </div>

    <div class="input">
      <span class="sign-code">银行卡号</span>
      <input type="text" name="" placeholder="请输入银行卡号">
    </div>
    <div class="input">
      <span class="sign-code">开户网点</span>
      <input type="text" name="" placeholder="请输入开户网点">
    </div>

    <div class="login color-f2-a">提交</div>

  <!--   <div class="shade" v-if="showbanck"></div>
    <div class="banck-wp" v-if="showbanck">
      <div class="banck-top">
        <span class="choose">选择您的银行</span>
        <span class="true" @click="showbanck=false">确认</span>
      </div>
      <div class="banck">
        <div class="banck-li-wp">
          <ul>
            <li class="banck-li" >北京银行</li>
            <li class="banck-li" >工商银行</li>
            <li class="banck-li" >南京银行</li>
            <li class="banck-li" >华夏信用银行</li>
            <li class="banck-li" >华夏信用银行</li>
            <li class="banck-li" >华夏信用银行</li>
          </ul>
        </div>
      </div>
    </div>
 -->


</body>
</html>