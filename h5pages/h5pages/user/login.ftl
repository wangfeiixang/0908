<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Ratchet">
    <title>登录</title>
    <link rel="stylesheet" type="text/css" href="../css/base.css">
    <link rel="stylesheet" type="text/css" href="../css/login.css">
    <link rel="stylesheet" type="text/css" href="../css/header.css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/base.js"></script>
    <script src="../js/login.js"></script>
    <style>
        .show{
            display: none;
        }
        .hidden,.show{
            width:90%;
        }

        input{
            font-size: 0.16rem !important;
            width: 80%;
        }

        .input i.eye-s{
            background: url(../img/login/btn_eye_s.png)  no-repeat;
            background-size: 100%;
            display: none;
        }

        .confirm-box{
            position: absolute;
            cursor: pointer;
            left: 0;
            right:0;
            bottom:0;
            top: 300px;
            margin: auto;
            width: 180px;
            height: 50px;
            opacity: 0.5;
            background: #000000;
            border-radius: 8px;
            color:#fff;
            display: flex;
            justify-content: center;
            align-items: center;
            text-align: center;
            font-family: HelveticaNeue,Helvetica,Arial,sans-serif;
            font-size: 12px;
        }

        i.err{
            display: inline-block;
            background: url(../img/login/CombinedShape.png)  no-repeat center center;
            width: 14px;
            height: 8px;
            position: absolute;
            right: 15px;
            top: 50%;
            margin-top: -4px;
        }

    </style>

</head>
<body>
<header class="">
    <a class="back" href=""></a>
    <div class="logo">登录</div>
</header>

<div class="help"></div>
<form action="../user/userLogin.action"  method="post" >
    <input type="hidden" name="type" value="${type}">
    <input type="hidden" name="refereeInfo" value="${userInfo}">
    <section>
        <div class="input">
            <input type="text" name="phone" id="user" placeholder="输入手机号">
            <i class="err"></i>
        </div>
        <div class="input">
            <input type="password" name="passwd" id="password" class="hidden" placeholder="输入密码">
            <input type="text" name="passwd" class="show" id="two_password" placeholder="输入密码">
            <i class="password eye-n"></i>
            <i class="password eye-s"></i>
        </div>
        <div class="p-wp">
            <p class="log-p">忘记密码</p>
        </div>
        <div class="login color-f2-a"><input id="login"  type="submit" style="background-color:rgba(0, 0, 0, 0);color:#fff;" value="提交"></input></div>
        <div class="sign-no"> <span> <a href="../sign_in.html">没有账号？立即注册</a></span></div>
    </section>
</form>
<div class="confirm-box"></div>


</body>
</html>