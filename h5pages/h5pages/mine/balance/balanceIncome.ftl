<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Ratchet">
    <title>余额明细</title>
    <link rel="stylesheet" type="text/css" href="../css/base.css">
    <link rel="stylesheet" type="text/css" href="../css/member.css">
    <link rel="stylesheet" type="text/css" href="../css/header.css">
    <link rel="stylesheet" type="text/css" href="../css/balance.css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/base.js"></script>

    <style>
        .span_1{
            color:#FF5A6E !important;
        }

    </style>
</head>
<body>
   <header>
      <a class="back"  onClick="javascript :window.history.back(); return false;"></a>
      <div class="logo">余额明细</div>
    </header>
    <div class="help"></div>

    <#--<div class="tab">-->
      <#--<router-link to="/Income" tag="span" class="span router-link-active" :class="">收入</router-link>-->
      <#--<router-link to="/Expend" tag="span" class="span" :class="">支出</router-link>-->
    <#--</div>-->

    <ul class="Income-ul">

<#list  recordList?if_exists  as recordVo>
      <li class="Income">
        <span class="Income-span1">${recordVo.recordDesc}</span>
        <span class="Income-span2">
              <span class="span1">${recordVo.recordNum}</span>
              <#--<span class="span1 span_1">+${incomeDetailVo.incomeNum}</span>-->
              <span class="span2">${recordVo.recordDate}</span>
            </span>
      </li>
    </#list>
      <#--<li class="Income">-->
        <#--<span class="Income-span1">获得来自***的 返利收益</span>-->
        <#--<span class="Income-span2">-->
              <#--<span class="span1">+20.00</span>-->
              <#--<span class="span2">2017-06-21</span>-->
            <#--</span>-->
      <#--</li>-->
      <#--<li class="Income">-->
        <#--<span class="Income-span1">获得来自***的 返利收益</span>-->
        <#--<span class="Income-span2">-->
              <#--<span class="span1">+20.00</span>-->
              <#--<span class="span2">2017-06-21</span>-->
            <#--</span>-->
      <#--</li>-->
      <#--<li class="Income">-->
        <#--<span class="Income-span1">获得来自***的 返利收益</span>-->
        <#--<span class="Income-span2">-->
              <#--<span class="span1">+20.00</span>-->
              <#--<span class="span2">2017-06-21</span>-->
            <#--</span>-->
      <#--</li>-->
    </ul>
  </body>
</html>