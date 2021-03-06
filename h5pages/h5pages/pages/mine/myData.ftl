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
            background: #f9f9f9;
            text-align: center;
        }

        .delete-border{
            border:none;
        }

        .message-box{
            z-index: 999;
            position: absolute;
            border-radius: 5px;
            left:0;
            right:0;
            top:2.8rem;
            bottom:0;
            margin: auto;
            width:1.5rem;
            height:.5rem;
            font-size: .11rem;
            text-align: center;
            background: #999;
            color:#fff;
            display: none;
        }

        .message-box span{
            display: block;
            width:1.5rem;
            height:100%;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: left;
        }

        #idCard,#cryptonym,#readyName{
            width:80%;
        }

        ::-webkit-input-placeholder{
            color: #666 !important;
        }

        .input-phone::-webkit-input-placeholder{
            color: #ccc !important;
        }

        .color-f2-a {
            background: #F2F2F2;
            color:black;
        }

        .color-bk-a{
            background: #CA88ED;
            color: #fff;
        }


    </style>
</head>
<body>
  <header>
      <a class="back"  onClick="javascript :window.history.back(); return false;"></a>
      <div class="logo">我的资料</div>
    </header>
    <div class="help"></div>
    <div class="help2"></div>
    <div class="phoneMessage" style="display:none;">${nickName}</div>

    <form method="post" action="../user/userEditInfo.action">
    <div class="input">
      <span class="sign-code">会员账号</span>
      <input autocomplete="off" type="text" name="phone" class="input-phone" readonly="readonly" placeholder="${phone ? default("请输入账号")}">
    </div>


    <div class="input">
      <span class="sign-code">我的昵称</span>
      <input autocomplete="off" type="text" name="nickName" id="cryptonym"  placeholder="${nickName ? default("请输入昵称")}">
    </div>
    <div class="input">
      <span class="sign-code">真实姓名</span>
      <input autocomplete="off" type="text" name="trueName"  id="readyName" placeholder="${trueName ? default("请输入姓名")}">
    </div>
    <div class="input delete-border">
      <span class="sign-code">身份证号</span>
      <input autocomplete="off" type="text" name="identity"  id="idCard" placeholder="${identity ? default("请输入身份账号")}">
    </div>

        <div class="bg-color">
            <input class="login color-f2-a" id="myDatasubmit" type="submit"  value="提交"></input>
        </div>

        <div class="message-box">
            <span></span>
        </div>
    </form>
</body>
</html>