<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Ratchet">
    <title>我的</title>
    <link rel="stylesheet" type="text/css" href="../css/base.css">
    <link rel="stylesheet" type="text/css" href="../css/member.css">
    <link rel="stylesheet" type="text/css" href="../css/header.css">
    <link rel="stylesheet" type="text/css" href="../css/mine.css">
    <link rel="stylesheet" type="text/css" href="../css/changeFooter.css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/base.js"></script>
    <style>
        /*.mine dt {
            margin-bottom: 0.12rem !important;
        }
        */
        .mine div a {
            border-bottom: none !important;
        }

        .margin-top {
            margin-top: 28% !important;
        }

        section .member-men {
            margin-top: .11rem;
        }

        section .member-phone {
            margin-top: .10rem;
        }

        .mb {
            margin-top: 0.04rem;
        }

        .mine .my-expand {
            margin-top: 0.16rem;
        }
        .mine .my-card {
            margin-top: -0.02rem;
        }
        .mine .my-share {
            margin-top: 0.18rem;
        }

        .member-men {
            position: relative;
        }

        .memberRed {
            width: .22rem;
            height: .18rem;
            display: none;
            position: absolute;
            top: 0rem;
            right: .68rem;
        }
        .flexBox{
            display: flex;
            margin:0 auto;
            text-align: center;

        }
        .borderBottom{
            border-bottom: 1px solid #E4E4E4;

        }
        .borderRight{
            border-right: 1px solid #E4E4E4;
        }
        .flexBox  div{
            flex:1;

        }

    </style>

</head>

<body>
<div class="member-bg">

</div>
<header class="no-bgcolor">
    <a class="back" href="#" onClick="javascript:window.JSBridge.finish()"></a>
    <div class="logo">我的</div>
    <a class="dlll" href="http://f.appstore.zshiliu.com/zslapp/appstore-release-v1.0_31001.apk">客户端下载</a>
</header>
<div class="help"></div>
<section style="margin-top: 25px">
    <div style="position: relative;">
        <div class="member-img">
            <img src="../img/member/Group5.png" alt="">
        </div>
        <div class="member-men">${nickName}</div>
        <div class="member-men">${phone}<img class="memberRed" src="../img/min/Bitmap.png"></div>
    </div>
</section>
<div class="mine">
    <div class="flexBox borderBottom">
        <div class="borderRight">
            <a href="../team/team.html" >
                <dl>
                    <dt class="group"></dt>
                    <p>我的团队</p>
                </dl>
            </a>
        </div>
        <div class="borderRight">
            <a href="../user/myData.action" >
                <dl>
                    <dt class="data"></dt>
                    <p>我的资料</p>
                </dl>
            </a>
        </div>
        <div>
            <a href="../user/myBankCard.action">
                <dl>
                    <dt class="card"></dt>
                    <p class="my-card">我的银行卡</p>
                </dl>
            </a>
        </div>
    </div>
    <div class="flexBox">
        <div class="borderRight">
            <a href="../extend/extend.html">
                <dl>
                    <dt class="expand"></dt>
                    <p class="my-expand">我的推广</p>
                </dl>
            </a>
        </div>
        <div class="borderRight">
            <a href="../user/QRcode.action">
                <dl>
                    <dt class="code"></dt>
                    <p>我的二维码</p>
                </dl>
            </a>
        </div>
        <div>
            <a id="myShare" href="#" onClick="javascript:window.JSBridge.share('${shareContent}')" data-message="${shareContent}">
                <dl>
                    <dt class="share"></dt>
                    <p class="my-share">我的分享</p>
                </dl>
            </a>
        </div>
    </div>
</div>

<footer class="nav">
    <a href="../user/member.action">
				<span>
          <i></i>
          <span>会员中心</span>
				</span>
    </a>
    <a href="../user/userInfo.action">
				<span>
            <i></i>
            <span>收益</span>
				</span>
    </a>
    <a checked="checked">
				<span>
            <i></i>
            <span id="clickMine" class="margin-left">我的</span>
				</span>
    </a>
</footer>
</body>

</html>
<script>
</script>