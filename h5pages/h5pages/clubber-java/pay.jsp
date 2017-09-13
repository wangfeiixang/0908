<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@page import="com.alipay.api.AlipayClient"%>
<%@page import="com.alipay.api.DefaultAlipayClient"%>
<%@page import="com.alipay.api.AlipayApiException"%>
<%@page import="com.alipay.api.request.AlipayTradeWapPayRequest"%>
<%@page import="com.alipay.api.domain.AlipayTradeWapPayModel" %>
<%@ page import="com.lzkj.zsl.clubber.pay.alipay.AlipayConfig" %>
<%@ page import="org.apache.struts2.ServletActionContext" %>
<%@ page import="com.opensymphony.xwork2.ActionContext" %>
<%@ page import="com.lzkj.zsl.clubber.vo.ProductInfoVO" %>
<%@ page import="com.lzkj.zsl.clubber.dao.UserDao" %>
<%@ page import="com.lzkj.zsl.clubber.vo.UserInfoVO" %>
<%@ page import="com.lzkj.zsl.clubber.util.DateUtil" %>
<%@ page import="com.lzkj.zsl.clubber.util.security.Base64Coder" %>
<%@ page import="org.apache.log4j.Logger" %>
<%@ page import="com.lzkj.zsl.clubber.action.weixinPay.WeixinUtils" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.lzkj.zsl.clubber.action.weixinPay.XmlsUtils" %>
<%@ page import="com.lzkj.zsl.clubber.util.MathUtil" %>
<%@ page import="com.lzkj.zsl.clubber.dao.InitData" %>
<%
    /* *
     * 功能：支付宝手机网站支付接口(alipay.trade.wap.pay)接口调试入口页面
     * 版本：2.0
     * 修改日期：2016-11-01
     * 说明：
     * 以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
     请确保项目文件有可写权限，不然打印不了日志。
     */
%>
<%
    Logger logger = Logger.getRootLogger() ;
    try {
        String context = ServletActionContext.getRequest().getContextPath();

        String queryString = request.getParameter("data") ;
        String sessionId = request.getSession().getId();
        String productCode = request.getParameter("productCode");
        String payType = request.getParameter("payType");

        System.out.println("payType="+payType);


        String phone = "" + request.getSession().getAttribute("phone");
        String passwd = "" + request.getSession().getAttribute("passwd");
        String scorePrice = (String) request.getAttribute("F_SCORE_PRICE");
        UserInfoVO userInfoVO = UserDao.queryUserInfoByPhone(phone, passwd,scorePrice);
        String userNickName = userInfoVO.getUserNickName() ;

//            ActionContext.getContext().put("userNickName", userNickName);
        String userClubberType = userInfoVO.getClubberType() ;
        System.out.println("jsp   userClubberType="+userClubberType);
        ProductInfoVO productInfoVO_red = UserDao.queryClubberInfoById("DIAMOND_RED") ;
        ProductInfoVO productInfoVO_purple = UserDao.queryClubberInfoById("DIAMOND_PURPLE") ;

        ActionContext.getContext().put("redPrice", productInfoVO_red.getProductPrice());
        ActionContext.getContext().put("purplePrice", productInfoVO_purple.getProductPrice());

        ActionContext.getContext().put("userNickName", phone);



        ProductInfoVO productInfoVO = UserDao.queryClubberInfoById(productCode) ;
        // 商户订单号，商户网站订单系统中唯一订单号，必填
        String out_trade_no = DateUtil.dateFormat("yyyyMMddHHmmss") + "_" + phone ;
        // 订单名称，必填
        String subject = "购买";
        String orderType = "BUY" ;
        float payMoney = 0L ;

        if(userClubberType  != null && userClubberType.equalsIgnoreCase(InitData.F_S_CLUBBERTYPE_DIAMOND_RED)) {
            subject = "升级" ;
            orderType = "UPGRADE" ;
            float redPrice = MathUtil.formatToFloat(productInfoVO_red.getProductPrice()) ;
            float purplePrice = MathUtil.formatToFloat(productInfoVO_purple.getProductPrice()) ;
            payMoney = purplePrice - redPrice ;
        } else {
            payMoney = MathUtil.formatToFloat(productInfoVO.getProductPrice()) ;
        }
        payMoney = MathUtil.formatToFloat(""+payMoney) ;
        subject = subject+productInfoVO.getProductName();
        System.out.println(subject);
        // 付款金额，必填
        String total_amount= productInfoVO.getProductPrice() ;
        // 商品描述，可空
        String body = "连舟科技";



        UserDao.addBuyClubberOrder(out_trade_no,productInfoVO.getProductId(),userInfoVO.getUserId(),payType,""+payMoney,orderType) ;




        if(payType != null ) {
            if(payType.equalsIgnoreCase("wxPay")) {
//                float total_amountFloat = MathUtil.formatToFloat(total_amount)*100 ;
                float total_amountFloat = payMoney *100 ;
                total_amount = "" + total_amountFloat ;
                if(total_amount.indexOf(".")>0) {
                    total_amount = total_amount.substring(0,total_amount.indexOf(".")) ;
                }
                String firstReq = WeixinUtils.packParamXml(subject,out_trade_no,total_amount) ;
                String firstResp =  WeixinUtils.postWXPayData(firstReq) ;
                Map<String, String> resultMap = XmlsUtils.toMap(firstResp.getBytes("UTF-8"), "UTF-8");
                String prepayid = resultMap.get("prepay_id") ;
                String partnerid = resultMap.get("mch_id") ;
                String sign = resultMap.get("sign") ;
                String noncestr = resultMap.get("nonce_str") ;
                String timesTamp = ""+WeixinUtils.genTimeStamp() ;
                String sencondSign = WeixinUtils.secondSign(firstResp,timesTamp) ;

                String form = "{\n" +
                        "  \"partnerid\": \""+partnerid+"\",\n" +
                        "  \"noncestr\": \""+noncestr+"\",\n" +
                        "  \"timestamp\": "+timesTamp+",\n" +
                        "  \"prepayid\": \""+prepayid+"\",\n" +
                        "  \"sign\": \""+sencondSign+"\"\n" +
                        "}";
                ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
                ServletActionContext.getResponse().getWriter().write(form);
                ServletActionContext.getResponse().flushBuffer();
            } else if(payType.equalsIgnoreCase("aliPay")) {
                // 超时时间 可空
//            String timeout_express="2m";
                // 销售产品码 必填
                String product_code="QUICK_WAP_PAY";
                /**********************/
                // SDK 公共请求类，包含公共请求参数，以及封装了签名与验签，开发者无需关注签名与验签
                //调用RSA签名方式
                AlipayClient client = new DefaultAlipayClient(AlipayConfig.URL, AlipayConfig.APPID, AlipayConfig.RSA_PRIVATE_KEY, AlipayConfig.FORMAT, AlipayConfig.CHARSET, AlipayConfig.ALIPAY_PUBLIC_KEY,AlipayConfig.SIGNTYPE);
                AlipayTradeWapPayRequest alipay_request=new AlipayTradeWapPayRequest();

                // 封装请求支付信息
                AlipayTradeWapPayModel model=new AlipayTradeWapPayModel();
                model.setOutTradeNo(out_trade_no);
                model.setSubject(subject);
//                model.setTotalAmount(total_amount);
                model.setTotalAmount(""+payMoney);
                model.setBody(body);
//            model.setTimeoutExpress(timeout_express);
                model.setProductCode(product_code);
                alipay_request.setBizModel(model);
                // 设置异步通知地址
                alipay_request.setNotifyUrl(AlipayConfig.notify_url);
                // 设置同步地址
                alipay_request.setReturnUrl(AlipayConfig.return_url);

                // form表单生产
                String form = "";
                try {
                    // 调用SDK生成表单
                    form = client.pageExecute(alipay_request).getBody();
                    form = Base64Coder.encode(form.getBytes());
                    String data = "{\"data\":\""+form+"\"}" ;
                    ServletActionContext.getResponse().setContentType("text/html;charset=" + AlipayConfig.CHARSET);
//                    ServletActionContext.getResponse().getWriter().write(form);
                    ServletActionContext.getResponse().getWriter().write(data);
                    ServletActionContext.getResponse().flushBuffer();
//                response.setContentType("text/html;charset=" + AlipayConfig.CHARSET);
//                response.getWriter().write(form);//直接将完整的表单html输出到页面
//                response.getWriter().flush();
//                response.getWriter().close();
                } catch (AlipayApiException e) {
                    logger.error("pay.jsp Error ",e);
                }
            }
        }


        ActionContext.getContext().put("resContext", context);
    } catch (Exception e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }
%>
<%--<!DOCTYPE html>--%>
<%--<html lang="en">--%>
<%--<head>--%>
    <%--<meta charset="UTF-8">--%>
    <%--<meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">--%>
    <%--<meta name="apple-mobile-web-app-capable" content="yes">--%>
    <%--<meta name="apple-mobile-web-app-status-bar-style" content="black">--%>
    <%--<meta name="apple-mobile-web-app-title" content="Ratchet">--%>
    <%--<title>会员</title>--%>
    <%--<link rel="stylesheet" type="text/css" href="../css/base.css">--%>
    <%--<link rel="stylesheet" type="text/css" href="../css/member.css">--%>
    <%--<link rel="stylesheet" type="text/css" href="../css/header.css">--%>
    <%--<link rel="stylesheet" type="text/css" href="../css/payred.css">--%>
    <%--<script src="../js/jquery.min.js"></script>--%>
    <%--<script src="../js/base.js"></script>--%>
    <%--<script src="../js/payBitmap.js"></script>--%>
    <%--<style>--%>
        <%--.message-box{--%>
            <%--position: absolute;--%>
            <%--left:0;--%>
            <%--right:0;--%>
            <%--top:200px;--%>
            <%--bottom:0;--%>
            <%--margin: auto;--%>
            <%--width:150px;--%>
            <%--height:50px;--%>
            <%--font-size: 12px;--%>
            <%--display: flex;--%>
            <%--justify-content: center;--%>
            <%--align-items: center;--%>
            <%--text-align: center;--%>
            <%--background: #999;--%>
            <%--color:#fff;--%>
        <%--}--%>
        <%--.pay_red{--%>
            <%--border: 1px solid #FF5A6E;--%>
            <%--z-index: 999;--%>
        <%--}--%>




        <%--.pay_purple{--%>
            <%--border: 1px solid #9666C4;--%>
            <%--z-index: 999;--%>
        <%--}--%>
    <%--</style>--%>
<%--</head>--%>
<%--<body>--%>
<%--<div class="member-bg">--%>

    <%--</div>--%>
    <%--<header class="no-bgcolor">--%>
      <%--<a class="back"  href="#" onClick="javascript :history.back(-1);"></a>--%>
      <%--<div class="logo">会员</div>--%>
    <%--</header>--%>
    <%--<div class="help"></div>--%>
    <%--<section style="margin-top: 25px">--%>
        <%--&lt;%&ndash;用户当前的会员类型&ndash;%&gt;--%>
        <%--&lt;%&ndash;&lt;%&ndash;%>--%>
          <%--&lt;%&ndash;out.print("<div class=\"userClubberType\" data-id=\"" +userClubberType +"\"></div>");&ndash;%&gt;--%>
        <%--&lt;%&ndash;%>&ndash;%&gt;--%>
            <%--<div class="message" style="display:none"  data-type="${userClubberType}"></div>--%>
        <%--&lt;%&ndash;<div class="userClubberType" data-type="${userClubberType}"></div>&ndash;%&gt;--%>
      <%--<div style="position: relative;">--%>
        <%--<div class="member-img">--%>
          <%--<img src="../img/member/Group5.png" alt="">--%>
        <%--</div>--%>
        <%--<div class="member-men">${userNickName}</div>--%>
      <%--</div>--%>
    <%--</section>--%>
    <%--<div class="pay-div">--%>
      <%--&lt;%&ndash;<div class="pay-diamond redbg" data-redType="DIAMOND_RED" data-price="${redPrice}">&ndash;%&gt;--%>
          <%--<div class="pay-diamond redbg" id="red" data-type="DIAMOND_RED" data-price="${redPrice}">--%>
        <%--<img src="../img/member/btn_red_n.png" alt="">--%>
        <%--<i class="redbg"></i>--%>
      <%--</div>--%>
          <%--<div class="pay-diamond purple" id="purple" data-type="DIAMOND_PURPLE" data-price="${purplePrice}">--%>
      <%--&lt;%&ndash;<div class="pay-diamond purple" data-redType="DIAMOND_PURPLE" data-price="${purplePrice}>">&ndash;%&gt;--%>
        <%--<img src="../img/member/btn_purple_n.png" alt="">--%>
        <%--<i class="purple"></i>--%>
      <%--</div>--%>
    <%--</div>--%>
    <%--<div class="choose-pay">--%>
      <%--选择支付方式--%>
    <%--</div>--%>

<%--<div class="pay-alipay aliPay">--%>
    <%--<i class="alipay"></i>--%>
    <%--<span>支付宝支付</span>--%>
    <%--<input type="hidden">--%>
    <%--<a checked="checked" class="chk pay_alipay"></a>--%>
<%--</div>--%>
<%--<div class="pay-alipay weChat">--%>
    <%--<i class="wexin"></i>--%>
    <%--<span>微信支付</span>--%>
    <%--<input type="hidden">--%>
    <%--<a class="chk pay_weChat"></a>--%>
<%--</div>--%>
<%--<div class="bg-f6"></div>--%>


<%--<footer class="pay">--%>
    <%--<div class="cyc-footer">--%>
        <%--<div class="cyc-pay-w" >--%>
            <%--<div class="cyc-pay1">还需支付金额：<span>0元</span></div>--%>
        <%--</div>--%>
        <%--<!-- <form action="../user/aliPayPay.action" method="post"> -->--%>
        <%--<!--<div class="cyc-btn" onclick="submitData()">-->--%>
        <%--<!--去支付-->--%>
        <%--<!--</div>-->--%>
        <%--<input type="hidden" name="productCode" id="pay_type" value="DIAMOND_RED"></input>--%>
        <%--<input type="hidden" name="payType" id="payType" value="aliPay"></input>--%>
        <%--<!--<input type="hidden" name="payType" id="payType" value="aliPay"></input>-->--%>
        <%--<input type="submit" id="paySubmit"  value="去支付"></input>--%>
        <%--<!-- </form> -->--%>
    <%--</div>--%>
<%--</footer>--%>
<%--<div class="message-box"></div>--%>

<%--<script language="javascript">--%>

<%--//    function GetDateNow() {--%>
<%--//        var vNow = new Date();--%>
<%--//        var sNow = "";--%>
<%--//        sNow += String(vNow.getFullYear());--%>
<%--//        sNow += String(vNow.getMonth() + 1);--%>
<%--//        sNow += String(vNow.getDate());--%>
<%--//        sNow += String(vNow.getHours());--%>
<%--//        sNow += String(vNow.getMinutes());--%>
<%--//        sNow += String(vNow.getSeconds());--%>
<%--//        sNow += String(vNow.getMilliseconds());--%>
<%--////        document.getElementById("WIDout_trade_no").value =  sNow;--%>
<%--////        document.getElementById("WIDsubject").value = "手机网站支付测试商品";--%>
<%--////        document.getElementById("WIDtotal_amount").value = "0.01";--%>
<%--////        document.getElementById("WIDbody").value = "购买测试商品0.01元";--%>
<%--//    }--%>
<%--//    GetDateNow();--%>


    <%--function submitData(){--%>
        <%--var productCode=$("#productCode").val();--%>
        <%--var payType=$("#payType").val();--%>


        <%--//级联联动--%>
        <%--$.ajax({--%>
            <%--type: "POST",--%>
            <%--url : "../user/aliPayPay.action",--%>
            <%--data: {productCode:productCode,payType:payType},--%>
            <%--contentType:"application/x-www-form-urlencoded;charset=utf-8",--%>
            <%--dataType: "json",--%>
            <%--success: function(data) {--%>
                <%--console.log(111) ;--%>
                <%--console.log(data) ;--%>
                <%--//window.location.href = '../user/myBankCard.action';--%>
            <%--}--%>
        <%--});--%>
    <%--}--%>

<%--</script>--%>

<%--</body>--%>
<%--</html>--%>