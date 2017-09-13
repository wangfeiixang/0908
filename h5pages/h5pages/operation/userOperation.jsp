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
<%
    /* *
     * 功能：运营中心接口 。 对应于 运营中心首页，运营中心提现
     * 说明：
     */
%>
<%
    Logger logger = Logger.getRootLogger() ;
    try {
        String context = ServletActionContext.getRequest().getContextPath();

        String phone =""+ ActionContext.getContext().getSession().get("phone") ;
        String passwd = ""+ ActionContext.getContext().getSession().get("passwd") ;
        String scorePrice = (String) request.getAttribute("F_SCORE_PRICE");
        UserInfoVO userInfoVO = UserDao.queryUserInfoByPhone(phone, passwd,scorePrice);
        String userId = "" ;
        if(userInfoVO == null || userInfoVO.getUserId() == null ) {
            response.sendRedirect("../login.html");
            return;
        } else {
            userId = userInfoVO.getUserId() ;
        }
        HashMap<String,String> returnMap = new HashMap<String, String>() ;
        ServletActionContext.getRequest().getParameter("action");
        InputStream inputStream = request.getInputStream() ;
        byte[] reqBytes = IOUtils.toByteArray(inputStream) ;
        if(inputStream != null ) {
            try {
                inputStream.close();
            } catch (Exception e) {
                logger.error("",e);
            }
        }
//        inputStream.close();
        String action = request.getParameter("action") ;
        System.out.println("actiona="+action);
        String reqStr = new String(reqBytes) ;
//        JSONObject jsonObject = JSONObject.fromObject(reqStr) ;
//        String action = jsonObject.getString("action") ;
        if(action.equalsIgnoreCase("communityFrontPage")) {
            returnMap = OperationDao.frontPage(userId) ;
            returnMap.remove("oauid") ;
        } else if (action.equalsIgnoreCase("getCash")) {
            returnMap = OperationDao.getCash(userId) ;
        }
        String jsonStr = JSONObject.fromObject(returnMap).toString() ;
        logger.info("jsonStr="+jsonStr);
        ServletActionContext.getResponse().setContentType("text/html;charset=UTF-8");
//                    ServletActionContext.getResponse().getWriter().write(form);
        ServletActionContext.getResponse().getWriter().write(jsonStr);
        ServletActionContext.getResponse().flushBuffer();
        ActionContext.getContext().put("resContext", context);
    } catch (Exception e) {
        // TODO Auto-generated catch block
        logger.error("userOperation.jsp ",e);
    }
%>
