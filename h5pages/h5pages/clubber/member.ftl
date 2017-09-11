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
    <link rel="stylesheet" type="text/css" href="../css/changeFooter.css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/base.js"></script>
    <style>
        .member-li i{
            margin-right: 0.07rem;
            vertical-align: -0.05rem;
        }
        .click-skip{
            display: block;
        }
        .click-skip .i-position{
            position: absolute;
            right:0px;
            top:38%;
        }
        .userName{
            display: inline-block;
            position: absolute;
            right:0px;
            top:0;
        }



    </style>
</head>
<body>
  <div class="member-bg">

    </div>
    <header class="no-bgcolor">
      <a class="back" href=""></a>
      <div class="logo">会员</div><a class="dlll" href="http://f.appstore.zshiliu.com/zslapp/appstore-release-v1.0_31001.apk">客户端下载</a>
    </header>
    <div class="help"></div>
    <section style="margin-top: 25px">
      <div style="position: relative;">
        <div class="member-img">
          <img src="../img/member/Group5.png" alt="">
        </div>
        <div class="member-men">${nickName}</div>
      </div>
      <div class="member-div">
        <ul class="member-ul">
          <li class="member-li">
              <a style="color:#333" href="../user/upgradeClubber.action" class="click-skip">
                  <i class="ic_vipup"></i>
                  <span>升级会员</span>
                  <span class="userName">
                      <span >${clubberType}</span>
                      <i class="i-arrow-r i-absolute"></i>
                  </span>
              </a>
            <#--<i class="ic_vipup"></i>-->
            <#--&lt;#&ndash;<span><a style="color:#333" href="../user/upgradeClubber.action">升级会员</a></span>&ndash;&gt;-->
              <#--<span><a style="color:#333" href="../clubber/pay.jsp">升级会员</a></span>-->
            <#--<span class="right-span">-->
              <#--<span>${clubberType}</span>-->
              <#--<i class="i-arrow-r"></i>-->
            <#--</span>-->
          </li>
          <li class="member-li">
              <a href="../memberIssue/buy.html" class="click-skip">
                  <i class="ic_qa"></i>
                  <span> 常见问题</span>
                  <i class="i-arrow-r i-position"></i>
              </a>
            <#--<i class="ic_qa"></i>-->
            <#--<span><a href="../memberIssue/buy.html">常见问题</a></span>-->
            <#--<span  class="right-span">-->
               <#--<span></span>-->
                <#--<i class="i-arrow-r"></i>-->
            <#--</span>-->

          </li>

            <#--删除部分-->
          <#--<li class="member-li">-->
            <#--<i class="ic_tel"></i>-->
            <#--<span>联系我们</span>-->
            <#--<span  class="right-span">-->
              <#--<span>400 400 4000</span>-->
              <#--<i class="i-arrow-r"></i>-->
            <#--</span>-->
          <#--</li>-->
        </ul>
      </div>


    </section>
    <footer class="nav">
      <a checked='checked'>
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
      <a href="../user/mine.action">
         <span>
            <i></i>
             <span class="margin-left">我的</span>
         </span>
      </a>
    </footer>
</body>
</html>