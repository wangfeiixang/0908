<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Ratchet">
    <title>我的资料</title>
    <link rel="stylesheet" type="text/css" href="../css/base.css">
    <link rel="stylesheet" type="text/css" href="../css/member.css">
    <link rel="stylesheet" type="text/css" href="../css/header.css">
    <link rel="stylesheet" type="text/css" href="../css/login.css">
    <link rel="stylesheet" type="text/css" href="../css/myData.css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/base.js"></script>
    <script src="../js/myData.js"></script>
    <style>
        html,body,.help2{
            background: #f9f9f9;
        }

        form{
            background: #fff;
        }

        .bg-color{
            overflow: hidden;
            background: #f9f9f9;
        }

        .delete-border{
            border:none;
        }

        .confirm-box{
            position: absolute;
            cursor: pointer;
            left: 90px;
            top: 489px;
            width: 180px;
            height: 50px;
            opacity: 0.5;
            background: #000000;
            border-radius: 8px;
            color:#fff;
            display: none;
            line-height: 50px;
            text-align: center;
            font-family: HelveticaNeue,Helvetica,Arial,sans-serif;
            font-size: 12px;
        }

        #idCard,#cryptonym,#readyName{
            width:80%;
        }




    </style>
</head>
<body>
  <header>
      <a class="back" href="#" onClick="javascript :history.back(-1);"></a>
      <div class="logo">我的资料</div>
    </header>
    <div class="help"></div>
    <div class="help2"></div>

    <form method="post" action="../user/userEditInfo.action">
    <div class="input">
      <span class="sign-code">会员账号</span>
      <input type="text" name="phone"  readonly="readonly" placeholder="${phone ? default("请输入账号")}">
    </div>


    <div class="input">
      <span class="sign-code">我的昵称</span>
      <input type="text" name="nickName" id="cryptonym"  placeholder="${nickName ? default("请输入昵称")}">
    </div>
    <div class="input">
      <span class="sign-code">真实姓名</span>
      <input type="text" name="trueName"  id="readyName" placeholder="${trueName ? default("请输入姓名")}">
    </div>
    <div class="input delete-border">
      <span class="sign-code">身份证号</span>
      <input type="text" name="identity"  id="idCard" placeholder="${identity ? default("请输入身份账号")}">
    </div>

        <div class="bg-color">
            <div class="login color-f2-a"><input id="myDatasubmit" type="submit" style="background-color:rgba(0, 0, 0, 0);color:#fff;" value="提交"></input></div>
        </div>

        <div class="confirm-box"></div>
    </form>
</body>
</html>