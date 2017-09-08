<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<title>资源管理</title>
	<link href="${contextPath?if_exists}/css/manage.css" rel="stylesheet" type="text/css" />
	<script src="${contextPath?if_exists}/js/string.js" type="text/javascript" ></script>
	<script src="${contextPath?if_exists}/js/jquery.js" type="text/javascript" ></script>
    <script src="${contextPath?if_exists}/js/MyDate/WdatePicker.js" type="text/javascript"></script>
	<script type="text/javascript">
    
      function checkCondition(){
      	var cId = document.getElementById("cId").value.trim();
      	var cName = document.getElementById("cName").value.trim();
      	document.getElementById("cId").value = cId;
      	document.getElementById("cName").value = cName;
      	if(cId != ""){
      		if(isNaN(cId)){
      			alert("请输入整数！");
      			document.getElementById("cId").focus();
      			return false;
      		}
      	}
      	if(cId != "" && cName != ""){
      		alert("请选填其中一个条件！");
      		document.getElementById("cId").focus();
      		return false;
      	}
      	
      	$("#queryPageSize").val($("#pageSizeCTop").val());
      	document.conForm.submit();
      }
      
      function updateRes(respk){
				$("#UresPk").val(respk);
				$('#pageForm').attr('action', '${resContext?if_exists}/resource/editRes.action').submit();
			}
			
		
      </script>
</head>
<body class="bodyM">
<div class="rightAll">
<input type="hidden" id="message" value="${message?if_exists}" />
	<div class="rightM_01">
 		<div class="titleM_h">位置：资源管理 &gt;<strong>资源列表</strong></div>
	 	<div class="searchM_bg">
  		<form id="conForm" name="conForm" action="${resContext?if_exists}/resource/showResList.action"  method="post" >
  			<input type="hidden" id="residStr" name="residStr" />
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td height="30" nowrap="nowrap">【快捷搜索】</td>
						<td align="right" nowrap="nowrap">
							<#list  strlist?if_exists as str > 
           						<#if str?if_exists== '1' > 
           					 		<a href="${resContext?if_exists}/resource/addRes.action">新增资源</a>
           						</#if>
           					</#list>
							<!--<a href="${resContext?if_exists}/resource/versionManage.action">产品类管理</a>-->
						</td>
						<td align="right" nowrap="nowrap"><a href="#" onclick="batchFlush();">批量刷新</a></td>
						<td height="30" nowrap="nowrap"></td>
					</tr>
					<tr>
						<input type='hidden' id='queryPageSize' name="pageSize" value="${pager.pageSize?if_exists}"/>
						<td nowrap="nowrap" align="right">产品ID：<input id="cId" name="cId" type="text" size="8"  value="${cId?if_exists}" style="width:60px" /></td>
						<td nowrap="nowrap" align="right">资源中文名：<input id="cName" name="cName" type="text" size="8"  value="${cName?if_exists}" style="width:60px" /></td>
						<td nowrap="nowrap" align="right">资源英文名：<input id="eName" name="eName" type="text" size="8"  value="${resEname?if_exists}" style="width:60px" /></td>
						
						<td nowrap="nowrap" align="right">一级分类：
							<select id="resType" name="resType" onchange='init();'>
								<option value="">所有</option>
								<#list typeList?if_exists as item>
									<option value="${item.kdDetail?if_exists}" <#if resType?if_exists == item.kdDetail?if_exists>selected</#if>>${item.kdName?if_exists}</option>
								</#list>
							</select>
						</td>
						<td nowrap="nowrap" align="left">二级分类：
							<select id="secondType" name="secondType">
								<!--<option value="">所有</option>
								<#list secondTypeList?if_exists as item>
									<option value="${item.kdDetail?if_exists}" <#if secondType?if_exists == item.kdDetail?if_exists>selected</#if>>${item.kdName?if_exists}</option>
								</#list>-->
							</select>
						</td>
						<td nowrap="nowrap" align="right">
							资源商务合作：
							<select id="resBusinessType" name="resBusinessType">  
							<option value="" selected >全部</option>
							<option value="0" <#if resBusinessType?if_exists == "0" >selected</#if> >非商务合作</option>
							<option value="1" <#if resBusinessType?if_exists == "1" >selected</#if> >商务合作</option>
							</select>
						</td>		
					</tr>		
					<tr>
						<td align="left" nowrap="nowrap" id="td_resCooperateType" colspan='2'>
							合作模式：
								<input id="A" type="checkbox" name="resCooperateType" value="A" >激活
								<input id="R" type="checkbox" name="resCooperateType" value="R" >注册
								<input id="S" type="checkbox" name="resCooperateType" value="S" >分成
								<input id="C" type="checkbox" name="resCooperateType" value="C" >收录 
								
								<input id="F" type="checkbox" name="resCooperateType" value="F" >搜索
								<input id="D" type="checkbox" name="resCooperateType" value="D" >下载
								<input id="P" type="checkbox" name="resCooperateType" value="P" >广告 
								
						&nbsp;</td>
						<td align="right" nowrap="nowrap">合作公司:<input id="resBusinessCom" name="resBusinessCom" type="text" size="8"  value="${resBusinessCom?if_exists}" style="width:60px" /></td>
						<td align="right" nowrap="nowrap">搜索关键词：
							<input id="resKeywords" name="resKeywords" type="text" size="8"  value="${resKeywords?if_exists}" style="width:60px" />
						</td>
						<td align="right" nowrap="nowrap">
							是否推荐：
							<select id="resRecommend" name="resRecommend">  
								<option value="" selected >全部</option>
								<option value="Y" <#if resRecommend?if_exists == "Y" >selected</#if> >推荐</option>
								<option value="N" <#if resRecommend?if_exists == "N" >selected</#if> >非推荐</option>
							</select>
						</td>
						<td align="right" nowrap="nowrap">产品评星：
							<select id="resFakescore" name="resFakescore">
								<option value="">所有</option>
								<option value="10" <#if resFakescore?if_exists == "10" >selected</#if>>5</option>
								<option value="9" <#if resFakescore?if_exists == "9" >selected</#if>>4.5</option>
								<option value="8" <#if resFakescore?if_exists == "8" >selected</#if>>4</option>
								<option value="7" <#if resFakescore?if_exists == "7" >selected</#if>>3.5</option>
								<option value="6" <#if resFakescore?if_exists == "6" >selected</#if>>3</option>
								<option value="5" <#if resFakescore?if_exists == "5" >selected</#if>>2.5</option>
								<option value="4" <#if resFakescore?if_exists == "4" >selected</#if>>2</option>
								<option value="3" <#if resFakescore?if_exists == "3" >selected</#if>>1.5</option>
								<option value="2" <#if resFakescore?if_exists == "2" >selected</#if>>1</option>
							</select>
						</td>
						<td align="right" nowrap="nowrap">&nbsp;</td>
					</tr>
					<tr>
						<td align="right" nowrap="nowrap">
							合作描述：<input id="resBusinessDesc" name="resBusinessDesc" type="text" size="8"  value="${resBusinessDesc?if_exists}" style="width:60px" />
						</td>
						<td align="right" nowrap="nowrap">Pad系统版本：
							<select id="resPadSysVersion" name="resPadSysVersion">
								<option value="">所有</option>
								
							</select>
						</td>
						<td align="right" nowrap="nowrap">产品包名：<input id="resPackage" name="resPackage" type="text" size="8"  value="${resPackage?if_exists}" style="width:60px" /></td>
						<td align="right" nowrap="nowrap">收费类型：
							<select id="resFeeType" name="resFeeType">  
								<option value="" selected >全部</option>
								<option value="F" <#if resFeeType?if_exists == "F" >selected</#if> >免费</option>
								<option value="D" <#if resFeeType?if_exists == "D" >selected</#if> >下载付费</option>
								<option value="T" <#if resFeeType?if_exists == "T" >selected</#if> >应用内收费</option>
							</select>
						</td>
						<td align="right" nowrap="nowrap">产品语种：
							<select id="resLanguage" name="resLanguage">
								<option value="">全部</option>
								<option value="chinese" <#if resLanguage?if_exists == "chinese" >selected</#if>>中文</option>
								<option value="english" <#if resLanguage?if_exists == "english" >selected</#if>>英文</option>
							</select>
						</td>
						<td align="right" nowrap="nowrap">操作系统：
							<select id="resSystem" name="resSystem">
								<option value="">全部</option>
								<option value="android" <#if resSystem?if_exists == "android" >selected</#if>>android</option>
								<option value="symbian" <#if resSystem?if_exists == "symbian" >selected</#if>>symbian</option>
								<option value="iphone" <#if resSystem?if_exists == "iphone" >selected</#if>>iphone</option>
								<option value="java" <#if resSystem?if_exists == "java" >selected</#if>>java</option>
							</select>
						</td>
						<td align="right" nowrap="nowrap">&nbsp;</td>
					</tr>
					<tr>
						<td align="right" nowrap="nowrap">安装权限：<input id="resAuthorise" name="resAuthorise" type="text" size="8"  value="${resAuthorise?if_exists}" style="width:60px" /></td>
						<td align="right" nowrap="nowrap">
						更新时间
							<input class="Wdate f-text" type='text' name='resCreatime' onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false,readOnly:true,isShowClear:true})" value="${resCreatime?if_exists}"/>
						</td>
						<td align="right" nowrap="nowrap">
						到
							<input class="Wdate f-text" type='text' name='lastCreatime' onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false,readOnly:true,isShowClear:true})" value="${lastCreatime?if_exists}"/>
						&nbsp;
						</td>
						<td align="right" nowrap="nowrap">出品方：<input id="resMaker" name="resMaker" type="text" size="8"  value="${resMaker?if_exists}" style="width:60px" />&nbsp;</td>
						<td align="right" nowrap="nowrap">运营评论：
							<select id="comment" name="comment">
								<option value="">全部</option>
								<option value="Y" <#if comment?if_exists == "Y" >selected</#if>>是</option>
								<option value="N" <#if comment?if_exists == "N" >selected</#if>>否</option>
							</select>
						&nbsp;</td>
						<td align="right" nowrap="nowrap">上线状态：
							<select id="resOnline" name="resOnline">
								<option value="">全部</option>
								<option value="Y" <#if resOnline?if_exists == "Y" >selected</#if>>上线</option>
								<option value="N" <#if resOnline?if_exists == "N" >selected</#if>>下线</option>
								<option value="U" <#if resOnline?if_exists == "U" >selected</#if>>预上线</option>
							</select>
						&nbsp;</td>
					</tr>
					<tr>
								<td nowrap="nowrap" align="left">爬虫来源：
							<select id="grabId" name="grabId">
								<option value="">所有</option>
								<#list grabIdList?if_exists as item>
									<option value="${item.kdDetail?if_exists}" <#if grabId?if_exists == item.kdDetail?if_exists>selected</#if>>${item.kdName?if_exists}</option>
								</#list>
							</select>
						</td>
						
				
						<td align="left" nowrap="nowrap" colspan='6'>手机系统版本：
							<#list sysVersions?if_exists  as item >
								<input class="versionPH" type="checkbox" name="resSysVersion" value="${item.kdDetail?if_exists}"/>${item.kdName?if_exists}
							</#list>
						</td>
						

			
	
						
			
						
					</tr>
					<tr>
								<td nowrap="nowrap" align="left" >产品来源：
							<select id="busId" name="busId">
								<option value="">所有</option>
								<#list busIdList?if_exists as item>
									<option value="${item.kdPk?if_exists?c}" <#if busId?if_exists?string == item.kdPk.toString()?replace(",","")>selected</#if>>${item.kdName?if_exists}</option>
								</#list>
							</select>
						</td>
		
						
					</tr>
					<tr>
						<td align="left" nowrap="nowrap" colspan='6'>
							<input type="button" name="button2" value="查 询" onclick="checkCondition();"/>
							<input type="button" name="button2" value="批量上线" onclick="allOnline('1');"/>
							<input type="button" name="button2" value="批量下线" onclick="allOnline('0');"/>
						</td>
					</tr>
				</table>
			</form>
			<a href="javascript:exportExcel();" onclick="exportExcel();" target="_blank" >导出excel</a>
			<div id="download"></div>
	<input type ="hidden" id="xlsPath" />
    </div>
		 <div class="searchM_body2">	 
	      	<div align="right" style="border-bottom:1px solid #CCCCCC;"> 
		      				<#assign newmodel="../common/pager.ftl"> <#include newmodel/>
		    				每页显示条数:
			          				<select id="pageSizeCTop" name="pageSizeCTop" onchange="javascript:pageChangeTop()">
										<option value="20" <#if pager.pageSize?if_exists == 20 >selected</#if> >20</option>
										<option value="40" <#if pager.pageSize?if_exists == 40 >selected</#if> >40</option>
										<option value="60" <#if pager.pageSize?if_exists == 60 >selected</#if> >60</option>
										<option value="100" <#if pager.pageSize?if_exists == 100 >selected</#if> >100</option>
										<option value="200" <#if pager.pageSize?if_exists == 200 >selected</#if> >200</option>
										<option value="1000" <#if pager.pageSize?if_exists == 1000 >selected</#if> >1000</option>
									</select>
						</div>
							<!--分页结束 -->
	      <div class="right_p">
              <table width="100%" border="0" cellpadding="0" cellspacing="0" class="table_div2">
              <thead>
                <tr>
                	<input type="hidden" id="list" name="list" value="${secondTypeList?if_exists}"/>
                	<th align="center"><input type="checkbox" onclick="selectAll(this);">全选</th>
                  <th align="center">产品ID</th>
                  <th align="center">图片</th>
                  <th align="center">中文名称</th>
									<th align="center">是否收费</th>
                 
                  <!--<th align="center">使用状态</th>-->
                 
                  <!--<th align="center">语种</th>-->
                  <th align="center">一级分类</th>
                  <th align="center">二级分类</th>
									<th align="center">版本</th>
                  <th align="center">合作</th>
                  <th align="center">产品来源</th>
                  
                  <th align="center">状态</th>
                  <th align="center">推荐</th>
                  <th align="center">操作</th>
                  <th align="center">更新日期</th>
									<th align="center">大小</th>
									<th align="center">来源</th>
								
                  <th align="center">资源维护</th>
                </tr>
                </thead>
                <tbody id="resTbody">
              <#list resList?if_exists  as item> 
                <tr>
                  <td align="center"><input name="resIds" type="checkbox" value="${item.resPk?if_exists?c}"></td>
                  <td align="left">${item.resPk?if_exists?c}&nbsp;</td>
                  <td align="center"><img src='${ httpPath }${ item.resIcon?if_exists}'   onerror="nofind('${ item.resIcon?if_exists}');" width='70' height='70'/></td>
                  <td align="left">
                  	<#list  strlist?if_exists as str > 
           				<#if str?if_exists== '2' > 
           					<a href="javascript:updateRes(${item.resPk?if_exists?c});" onclick="updateRes(${item.resPk?if_exists?c})">${item.resName?if_exists}</a>
           				</#if>
           			</#list>
           			&nbsp;
                  </td>
									<td>
										<#if item.resFeetype?if_exists == "F">免费</#if>  
								    <#if item.resFeetype?if_exists == "D">下载付费</#if>
										<#if item.resFeetype?if_exists == "T">应用内付费</#if>
									</td>
									 <!--
                  <td align="center">
                  	<#if item.resLanguage?if_exists == "chinese">中文</#if>
									 	<#if item.resLanguage?if_exists == "english">英文</#if>
									</td>
									-->
                  <td align="center">
                  	<#if item.resType?if_exists == "game">游戏</#if>  
								    <#if item.resType?if_exists == "soft">软件</#if>
								    <#if item.resType?if_exists == "theme">主题</#if>
								    <#if item.resType?if_exists == "music">音乐</#if>
								    <#if item.resType?if_exists == "picture">图片</#if>
				  				</td>
				  				<td align="center" nowrap="nowrap">${item.resSecondType?if_exists}&nbsp;</td>
					<td align="center">
				      ${item.resReleaseVersion?if_exists}&nbsp;
				  </td>
				  
				  <td  align="center">
				      <#if item.resBusinessType?if_exists == 0>否</#if>  
					  <#if item.resBusinessType?if_exists == 1>是</#if>
				  </td>
				  <td align="center">
				  				<#list busIdList?if_exists as item1>
									 <#if item.resBusinessId?if_exists?c == item1.kdPk?c>${item1.kdName?if_exists}</#if>
								</#list>
						
				      ${item.resBusinessDesc?if_exists}&nbsp;
				  </td>
                  <td align="center">	<#if item.resOnline?if_exists == "Y">上线</#if>
		    						<#if item.resOnline?if_exists == "N"><font color="red">下线</font></#if>
		    						<#if item.resOnline?if_exists == "U"><font color="blue">预上线</font></#if>
		    	   </td>
				   <td align="center">
				  		<#if item.resRecommend?if_exists == "Y">是</#if>
				  		<#if item.resRecommend?if_exists == "N">否</#if>
						&nbsp;
				   </td>
		    	   <td align="center">
		    	   		<#if item.resOnline?if_exists == "N"><a href="javascript:changeOnline('${item.resPk?if_exists?c}','Y','${item.resPackage?if_exists}','${item.resKaipk?if_exists}')" onclick="changeOnline('${item.resPk?if_exists?c}','Y','${item.resPackage?if_exists}','${item.resKaipk?if_exists}')">上线</a></#if>
		    	   		<#if item.resOnline?if_exists == "Y"><a href="javascript:changeOnline('${item.resPk?if_exists?c}','N','${item.resPackage?if_exists}','${item.resKaipk?if_exists}')" onclick="changeOnline('${item.resPk?if_exists?c}','N','${item.resPackage?if_exists}','${item.resKaipk?if_exists}')">下线</a></#if>
		    	   		<#if item.resOnline?if_exists == "U"><a href="javascript:changeOnline('${item.resPk?if_exists?c}','Y','${item.resPackage?if_exists}','${item.resKaipk?if_exists}')" onclick="changeOnline('${item.resPk?if_exists?c}','Y','${item.resPackage?if_exists}','${item.resKaipk?if_exists}')">上线</a></#if>
		    	   </td>

		    	   <td align="center">
		    	   		<#if item.resReleasetime??>${item.resReleasetime?if_exists?string("yyyy-MM-dd HH:mm:ss")}</#if>&nbsp;
				  	</td>
						  <td align="center">
		    	   	${item.resFilesize?if_exists}&nbsp;
				  	</td>
						<td>
							 	  	<select disabled="true">
								<option value="">所有</option>
								<#list grabIdList?if_exists as gr>
									<option value="${gr.kdDetail?if_exists}" <#if item.grabId.toString()?if_exists == gr.kdDetail?if_exists>selected</#if>>${gr.kdName?if_exists}</option>
								</#list>
							</select>
							
						</td>
			
		    	   <td align="center">
		    	   <!--<a href="${resContext?if_exists}/resource/editRes.action?resPk=${item.resPk?if_exists?c}&cId=${cId?if_exists}&cName=${cName?if_exists}&cType=${cType?if_exists}&pageNo=${pager.pageNo?if_exists}">修改</a>|-->
		    	   
           			<#list  strlist?if_exists as str > 
           				<#if str?if_exists== '3' > 
           					 <a href="#" onclick="deleteRes(${item.resPk?if_exists?c})">删除</a>|
           				</#if>
           			</#list>
		    	   
		    	   <a href="${resContext?if_exists}/resource/piclist.action?resPk=${item.resPk?if_exists?c}" target='_blank'>设置截图</a>|
		    	   <a href="${resContext?if_exists}/comment/detail.action?resPk=${item.resPk?if_exists?c}" target='_blank'>设置评论</a>
		    	   <a href="${resContext?if_exists}/struct/underStruct.action?resPk=${item.resPk?if_exists?c}" target='_blank'>所属目录</a>
		    	   </td>
                 </tr>
			 </#list>

				
                </tbody>
            <tr>
             
		      <td align="right" colspan ="18" >
		            <!--分页开始 -->
		      			<form id="pageForm" name="pageForm" action=""  method="post">
		      				<input type="hidden" id="allOnlineType" name="allOnlineType"/>
		      				<input type="hidden" id="allOnlineId" name="allOnlineId"/>
		      				<input type="hidden" id="wwwonline" name="wwwonline"/>
		      				<input type="hidden" id="wwwkaiqi" name="wwwkaiqi"/>		
		      			
		      				<input type="hidden" id="ontype" name="ontype" value=""/>
		      				<input type="hidden" id="UresPk" name="UresPk" value=""/>
		      				<input type="hidden" id="UcId" name="cId" value="${cId?if_exists}"/>
		      				<input type="hidden" id="UcType" name="cType" value="${cType?if_exists}"/>
		      				<input type="hidden" id="UresBusinessType" name="resBusinessType" value="${resBusinessType?if_exists}"/>
		      				<input type="hidden" id="UresRecommend" name="resRecommend" value="${resRecommend?if_exists}"/>
		      				<input type="hidden" id="UsecondType" name="secondType" value="${secondType?if_exists}"/>
		      				<input type="hidden" id="UresFeeType" name="resFeeType" value="${resFeeType?if_exists}"/>
		      				<input type="hidden" id="UresOnline" name="resOnline" value="${resOnline?if_exists}"/>
		      				<#list  resCooperateType?if_exists as str >
		      					<input class="resCooperateType" type="hidden" id="UresCooperateType" name="resCooperateType" value="${str?if_exists}"/>
		      				</#list>
		      				<input type="hidden" id="UcName" name="cName" value="${cName?if_exists}"/>
		      				<input type="hidden" id="UresBusinessCom" name="resBusinessCom" value="${resBusinessCom?if_exists}"/>
		      				
		      				<input type="hidden" id="comment" name="comment" value="${comment?if_exists}"/>
		      				
		      				<input type="hidden" id="UresEname" name="resEname" value="${resEname?if_exists}"/>
		      				<input type="hidden" id="UresType" name="resType" value="${resType?if_exists}"/>
		      				<input type="hidden" id="UresMaker" name="resMaker" value="${resMaker?if_exists}"/>
		      				<input type="hidden" id="UresKeywords" name="resKeywords" value="${resKeywords?if_exists}"/>
		      				<input type="hidden" id="UresBusinessDesc" name="resBusinessDesc" value="${resBusinessDesc?if_exists}"/>
		      				
		      				<#list  resSysVersion?if_exists as str >
		      					<input class="resSysVersion" type="hidden" id="UresSysVersion" name="resSysVersion" value="${str?if_exists}"/>
		      				</#list>
		      				
		      				<input type="hidden" id="UresPackage" name="resPackage" value="${resPackage?if_exists}"/>
		      				<input type="hidden" id="UresFakescore" name="resFakescore" value="${resFakescore?if_exists}"/>
		      				<input type="hidden" id="UresLanguage" name="resLanguage" value="${resLanguage?if_exists}"/>
		      				<input type="hidden" id="UresSystem" name="resSystem" value="${resSystem?if_exists}"/>
		      				<input type="hidden" id="UresAuthorise" name="resAuthorise" value="${resAuthorise?if_exists}"/>
		      				
		      				<input type="hidden" id="resCreatime" name="resCreatime" value="${resCreatime?if_exists}"/>
		      				<input type="hidden" id="lastCreatime" name="lastCreatime" value="${lastCreatime?if_exists}"/>
		      				
							<input type="hidden" id="pageNo" name="pageNo" value="${pager.pageNo?if_exists}"/>
							<input type="hidden" id="pageSize" name="pageSize" value="${pager.pageSize?if_exists}"/>
							<input type="hidden" id="resPk" name="resPk" value=""/>
							
							<input type="hidden" id="grabIdH" name="grabId" value="${grabId?if_exists}"/>
							<input type="hidden" id="busIdH" name="busId" value="${busId?if_exists}"/>
							
							
		      				<#assign newmodel="../common/pager.ftl"> <#include newmodel/>
		    				每页显示条数:
			          				<select id="pageSizeC" name="pageSizeC" onchange="javascript:pageChange()">  
										<option value="20" <#if pager.pageSize?if_exists == 20 >selected</#if> >20</option>
										<option value="40" <#if pager.pageSize?if_exists == 40 >selected</#if> >40</option>
										<option value="60" <#if pager.pageSize?if_exists == 60 >selected</#if> >60</option>
										<option value="100" <#if pager.pageSize?if_exists == 100 >selected</#if> >100</option>
										<option value="200" <#if pager.pageSize?if_exists == 200 >selected</#if> >200</option>
										<option value="1000" <#if pager.pageSize?if_exists == 1000 >selected</#if> >1000</option>
									</select>
			                <a href="javascript:pageChange('${pager.pageSize?if_exists}')" onclick="pageChange('${pager.pageCount?if_exists-1}')"></a> 
						</form>
							<!--分页结束 -->
		      </td>
		   </tr>

              </table>
	        <div class="p_list" style="padding-top:0"></div>
            <div style="clear:both"></div>

          </div>
	    </div>
		 <p>&nbsp; </p>
	  </div>
</div>
</body>
</html>

<script type="text/javascript">
	
			function allOnline(type){
			  var resIds=	 document.getElementsByName('resIds');
	
				var flag=false;
				 for(var i=0; i<resIds.length; i++) 
		    { 
		        if((resIds[i].type=="checkbox") ) 
		        { 
		              if(resIds[i].checked == true){
		                  flag=true;
		              } 
		        } 
		    } 
				if (flag == false) {
					alert("请选择要上下线的资源");
					return;
				}
					var resStr="";	
					 for (i = 0; i < resIds.length; i++)
					 {
					 	  if (resIds[i].checked == true) {
								resStr+=resIds[i].value+",";
					
						  }
					 }
					resStr=resStr.substring(0,resStr.length-1);
					$('#allOnlineId').val(resStr);
					$('#allOnlineType').val(type);
					
					var url="${resContext?if_exists}/resource/allOnline.action";
					$('#pageForm').attr('action', url).submit();
	
			}
		    
      function deleteRes(resPk) {
      	if(confirm("确定要删除此资源吗，如删除与此资源关联的所有数据将被删除？")) {
      	//	window.location.href='${resContext?if_exists}/resource/deleteResource.action?resPk=' + resPk;
					
						var url="${resContext?if_exists}/resource/deleteResource.action";
						$('#resPk').val(resPk);
						$('#pageForm').attr('action', url).submit();
      	}
      }
		
			
			function selectAll(obj) {
				var checkedStr = $(obj).attr("checked");
				$("#resTbody tr").each(function(index){
					if($(this).find("input:eq(0)").attr("type") == "checkbox") {
						$(this).find("input:eq(0)").attr("checked", checkedStr);
					}
	    	});
			}
			
			
			function batchFlush() {
				var residStr = "";
				$("#resTbody tr").each(function(index){
					if($(this).find("input:eq(0)").attr("type") == "checkbox" && $(this).find("input:eq(0)").attr("checked")) {
						residStr += $(this).find("input:eq(0)").val() + ";";
					}
	    	});
	    	if(residStr != "") {
	    		residStr = residStr.substring(0, residStr.length - 1);
	    		$("#residStr").val(residStr);
		    	$("#conForm").attr("action", "${resContext?if_exists}/resource/batchFlush.action");
		    	$("#conForm").submit();
	    	}
			}
			function  strBr(str){
				var strBr="";
				if (str.length > 11) {
					var strBegin = str.substring(0, 11);
					var strEnd = str.substring(11, str.length);
					//strEnd=strBr2(strEnd);
					strBr = strBegin + "<br/>" + strEnd;
				}else{
					strBr=str;
				}
				return strBr;
			}
			function  strBr2(str){
				var strBr="";
				if (str.length > 9) {
					var strBegin = str.substring(0, 9);
					var strEnd = str.substring(9, str.length);
					strBr = strBegin + "<br/>" + strEnd;
				}else{
					strBr=str;
				}
				return strBr;
			}
			
			function changeColor(obj, flag) {
				if(flag == 1) {
					$(obj).attr("bgcolor", "#CEE7FF");
				} else {
					$(obj).attr("bgcolor", "#FFFFFF");
				}
			}
			
	
		function init(){
			var filrstTypevl=$("#resType").val();
			
			//级联联动
			$.ajax({
						type: "POST",
						url : "${contextPath?if_exists}/resource/cascade.action",
						data: {firstType:filrstTypevl},
						contentType:"application/x-www-form-urlencoded;charset=utf-8",
						dataType: "json",  
						success: function(resp) {
							$("#secondType option").remove();
		 					$("#secondType").append("<option value=''>全部</option>");
		 					$.each(resp,function(i){
		 						$("#secondType").append("<option value="+resp[i].kdDetail+">"+resp[i].kdDesc+"</option>");
		 					});
						}
					});
		}
		
			function pageChange(pageNo){
						$("#pageNo").val(pageNo);
						$("#pageSize").val($("#pageSizeC").val());
						var url="${contextPath?if_exists}/resource/showResList.action";
						$('#pageForm').attr('action', url).submit();
							
					}
			function pageChangeTop(pageNo){
						$("#pageNo").val(pageNo);
						$("#pageSize").val($("#pageSizeCTop").val());
						var url="${contextPath?if_exists}/resource/showResList.action";
						$('#pageForm').attr('action', url).submit();
					}
			

       	//导出excel
       	function exportExcel(){
       		var url="${contextPath?if_exists}/resource/exortExl.action";
			$('#pageForm').attr('action', url).submit();
       	}
       	
       	//上线与下线切换
       	function changeOnline(respk,ontype,wwwonline,wwwkaiqi){
				$("#UresPk").val(respk);
				$("#ontype").val(ontype);
				$("#wwwonline").val(wwwonline);
				$("#wwwkaiqi").val(wwwkaiqi);
				$('#pageForm').attr('action', '${resContext?if_exists}/resource/updateOnline.action').submit();
			}

	$(document).ready(function () {
		    init();
		    <!--合作模式初始化-->
		    $(".resCooperateType").each(function(i){
		    	$("#"+$(this).val()).attr("checked", "checked");
		    });
		    <!--手机版本-->
		    $(".resSysVersion").each(function(i){
		    	var version = $(this).val();
		    	$(".versionPH").each(function(index){
		    		if(version==$(this).val()){
		    			$(this).attr("checked", "checked");
		    		}
		    	});
		    });
		});
			//回车监听事件	 
		 $(function(){
		document.onkeydown = function(e){ 
    var ev = document.all ? window.event : e;
    if(ev.keyCode==13) {

           checkCondition() ; 

     }
}
});  
</script>
