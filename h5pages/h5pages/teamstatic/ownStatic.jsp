<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="org.apache.struts2.ServletActionContext" %>
<%@ page import="com.opensymphony.xwork2.ActionContext" %>
<%@ page import="org.apache.log4j.Logger" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="org.apache.commons.io.IOUtils" %>
<%@ page import="net.sf.json.JSONObject" %>
<%@ page import="com.lzkj.zsl.clubber.dao.OperationDao" %>
<%@ page import="com.lzkj.zsl.clubber.vo.UserInfoVO" %>
<%@ page import="com.lzkj.zsl.clubber.dao.UserDao" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.io.IOException" %>
<%@ page import="com.lzkj.zsl.clubber.action.ownstatic.OwnExtensionAction" %>
<%@ page import="com.lzkj.zsl.clubber.action.ownstatic.OwnGroupAction" %>
<%--
  我的团队，我的推广 入库JSP 。通过请求的action进行内部的功能分支调用。
  Created by IntelliJ IDEA.
  User: mian.zhang
  Date: 2017/9/10
  Time: 10:25
  To change this template use File | Settings | File Templates.
--%>

<%
    String context = ServletActionContext.getRequest().getContextPath();

    Logger logger = Logger.getRootLogger() ;
//    InputStream inputStream = request.getInputStream() ;
//    byte[] reqBytes = IOUtils.toByteArray(inputStream) ;
//    if(inputStream != null ) {
//        try {
//            inputStream.close();
//        } catch (Exception e) {
//            logger.error("ownStatic.jsp ",e);
//        }
//    }
//    String reqString = new String(reqBytes,"UTF-8") ;
//    logger.info("ownStatic.jsp  reqString="+reqString);
//    JSONObject jsonObject = JSONObject.fromObject(reqString) ;
//    String action = jsonObject.getString("action") ;

   String phone =""+ ActionContext.getContext().getSession().get("phone") ;
   String passwd = ""+ ActionContext.getContext().getSession().get("passwd") ;
   String userId = ""+ ActionContext.getContext().getSession().get("userId") ;
//   String scorePrice = (String) request.getAttribute("F_SCORE_PRICE");

   String action = request.getParameter("action") ;
   String type = request.getParameter("type") ;

    String respString = "" ;
    if(action != null ) {
        if(action.equalsIgnoreCase("ownExtension")) {
               respString = OwnExtensionAction.queryUserExtension(phone,passwd,userId,type) ;
        } else if (action.equalsIgnoreCase("ownGroup")) {
           respString = OwnGroupAction.queryUserGroupVO(phone,passwd,userId,type) ;
        }
    }
    logger.info("respString " + respString);
    try {
        ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
        ServletActionContext.getResponse().getWriter().write(respString);
        ServletActionContext.getResponse().flushBuffer();
        ActionContext.getContext().put("resContext", context);
    } catch (Exception e) {
        logger.error("ownStatic.jsp ",e);
    }
%>
