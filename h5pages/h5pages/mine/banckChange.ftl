<!DOCTYPE html>
<html lang="en" xmlns="http://www.w3.org/1999/html">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Ratchet">
    <title>绑定银行卡</title>
    <link rel="stylesheet" type="text/css" href="../css/base.css">
    <link rel="stylesheet" type="text/css" href="../css/header.css">
    <link rel="stylesheet" type="text/css" href="../css/login.css">
    <link rel="stylesheet" type="text/css" href="../css/banckChange.css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/base.js"></script>
    <script src="../js/banckChange.js"></script>
    <style>

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

        .bankCard,.readyName,#bankId{
            width:80% !important;
        }


    </style>
</head>
<body>
 <header>
      <a class="back"  href="#" onClick="javascript :history.back(-1);"></a>
      <div class="logo">绑定银行卡</div>
    </header>
    <div class="help"></div>
    <div class="help2"></div>
    
    <div class="bankMessage" style="display:none;">${userBankNo}</div> 

 <#--<form action="../user/saveBankCard.action" method="post">-->
    <div class="input">
      <span class="sign-code">开户银行</span>
      <input class="input-text bank" type="text" name="bankId" id="bankId"   placeholder="${userBankName ? default("请输入开户银行")}">
      <span class="i-arrow-r"></span>
    </div>
    <div class="input">
      <span class="sign-code">开户行姓名</span>
      <input type="text" name="trueName" id="trueName"  class="readyName" placeholder="${trueName}">
    </div>
    <div class="input">
      <span class="sign-code">银行卡号</span>
      <input type="text" name="cardNo" id="cardNo" class="bankCard" placeholder="${userBankNo}">
    </div>
    <div class="input">
      <span class="sign-code">开户网点</span>
      <input type="text" name="openCardOfBank" id="openCardOfBank" placeholder="${userBankOpenCartOfBank}">
    </div>
    <div class="login color-f2-a" id="submitData">确定</div>
    <#--<div class="login color-f2-a" onclick="submitData()">确定</div>-->
        <#--<div class="login color-f2-a""><input type="submit" style="background-color:rgba(0, 0, 0, 0);color:#fff;" value="确定"></input></div>-->

    <#--</form>-->

    <div class="shade"   id="banckList_shade" style="display:none;" "></div>
    <div class="banck-wp" id="banckList" style="display:none;" >
    <#--<div class="banck-wp" id="banckList" style="display:none;" onclick="mySwitch()">-->
      <#--<div class="banck-top">-->
        <#--<span class="choose">选择您的银行</span>-->
        <#--<span class="true">确认</span>-->
      <#--</div>-->

      <div class="banck">
        <div class="banck-li-wp">
          <ul>
         <#list  bankInfoList?if_exists  as bankInfoVo>
            <li class="banck-li" value="${bankInfoVo.bankId}">${bankInfoVo.bankName}</li>
            <#--<li class="banck-li" >工商银行</li>-->
          </#list>
          </ul>
        </div>
      </div>
    </div>
 <div class="confirm-box"></div>
 <script language="javascript">
     /*function mySwitch(){
         document.getElementById('banckList').style.display = document.getElementById('banckList').style.display=='none'?'block':'none';
         document.getElementById('banckList_shade').style.display = document.getElementById('banckList_shade').style.display=='none'?'block':'none';
     }

     function submitData(){
         var bankId=$("#bankId").val();
         var trueName=$("#trueName").val();
         var cardNo=$("#cardNo").val();
         var openCardOfBank=$("#openCardOfBank").val();

         //级联联动
         $.ajax({
             type: "POST",
             url : "../user/saveBankCard.action",
             data: {bankId:bankId,trueName:trueName,cardNo:cardNo,openCardOfBank:openCardOfBank},
//             contentType:"application/x-www-form-urlencoded;charset=utf-8",
            // dataType: "json",
             success: function(resp) {
                 console.log(resp)
                // window.location.href = '../user/myBankCard.action';
             }
         });
     }*/

 </script>
</body>
</html>