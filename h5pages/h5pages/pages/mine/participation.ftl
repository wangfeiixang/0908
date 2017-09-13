<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Ratchet">
    <title>分红点明细</title>
    <link rel="stylesheet" type="text/css" href="../css/base.css">
    <link rel="stylesheet" type="text/css" href="../css/member.css">
    <link rel="stylesheet" type="text/css" href="../css/header.css">
    <link rel="stylesheet" type="text/css" href="../css/participation.css">
    <script src="../js/jquery.min.js"></script>
    <script src="../js/base.js"></script>
    
</head>
<body>
   <header>
      <a class="back" onClick="javascript :window.history.back(); return false;"></a>
      <div class="logo">分红点明细</div>
    </header>
    <div class="help"></div>

    <div class="earning-wp">
        <span>
          <p class="num">${scoreIncome.current}</p>
          <p class="intro">分红点</p>
        </span>
      <span>
          <p class="num">预计 ${scoreMoney}</p>
          <p class="intro">分红价值</p>
        </span>
      <span>
          <p class="num">${scoreIncome.total}</p>
          <p class="intro">累计分红点</p>
        </span>
    </div>

    <div class="participation">
      <p>本次分红</p>
      <span>
          <p class="num p-text1">${scoreIncome.current}</p>
          <p class="intro p-text2">分红点</p>
      </span>
      <i class="line"></i>
      <span>
          <p class="num p-text1">${diff_Day}天后</p>
          <p class="intro p-text2">分红时间</p>
      </span>
    </div>

</body>
</html>