<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>企业认证信息</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="format-detection" content="telephone=no">
	
	<script type="text/javascript" src="static/js/weixin/errorpage.js"></script>
	<link href="static/css/weixin/auth_info_show.css" rel="stylesheet" type="text/css">
	  <script>
		  var _hmt = _hmt || [];
		  (function() {
			  var hm = document.createElement("script");
			  hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
			  var s = document.getElementsByTagName("script")[0];
			  s.parentNode.insertBefore(hm, s);
		  })();
	  </script>

  </head>
<body>
  	<div class="for_title"><img class="backhost" src="static/images/weixin/back_history.png"/><span class="title">企业认证信息</span></div>
    <div class="divbox">
	    <table>
	    	<tr>
	    		<td class="attr">企业名称：</td>
	    		<td class="value">${result.data.result.companyName}</td>
	    	</tr>
	    	<tr>
	    		<td class="attr">营业执照号：</td>
	    		<td class="value">${result.data.result.businessLicenceNum}</td>
	    	</tr>
	    	<tr>
	    		<td class="attr">公司联系人：</td>
	    		<td class="value">${result.data.result.companyContactPerson}</td>
	    	</tr>
	    	<tr>
	    		<td class="attr">手机号码：</td>
	    		<td class="value">${result.data.result.companyContactNumber}</td>
	    	</tr>
	    	<tr>
	    		<td class="attr">公司地址：</td>
	    		<td class="value">${result.data.result.companyAddress}</td>
	    	</tr>
	    	<tr>
	    		<td class="attr">营业执照：</td>
	    		<td class="value"></td>
	    	</tr>
	    	<tr>
	    		<td class="imgCertificate" colspan="2"><img class="imgCertificate" src="./upload/${result.data.result.businessLicencePic}"/></td>
	    	</tr>
	    </table>
    </div>
  	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
  	<script type="text/javascript">
  		$(function() {	// 返回上一页
  			$(".backhost").click(function() {
  				window.history.go(-1);
  			});
  		});
  	</script>
  </body>
</html>
