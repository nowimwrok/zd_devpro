<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    
    <title>实名认证示例说明</title>
    
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
	<link href="static/css/weixin/certificate.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
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
    <div id="title"><img class="backhost" src="static/images/weixin/back_history.png"/><span class="title">实名认证</span></div>
    <div class="auth authMargin" id="forpersonal" style="display: none" onclick="personalAuth()"><img class="imgTypeIcon" src="static/images/weixin/personal_certificate.png" /><strong class="authType">个人认证</strong><img class="moreDetail" src="static/images/weixin/more.png"/></div>
    
    <div class="auth authMargin" id="forenterprise" style="display: none" onclick="enterpriseAuth()"><img class="imgTypeIcon" src="static/images/weixin/enterprise_certificate.png" /><strong class="authType">企业认证</strong><img class="moreDetail" src="static/images/weixin/more.png" /></div>
    
    <div class="explainMargin bor_bot">
        <strong>重要说明</strong>
        <p>1、您的资料可能会被提交到国家公安机关及其下属单位进行证件真实性核实，我们不会将您的证件资料用作商业用途或非法提供给他人，但是如果出现法律纠纷它可能作为相关证据使用。</p>
        <p>2、身份认证一旦通过，不能取消、删除、修改，请保管好您的密码，避免信息被违法分子所用。</p>
        <p class="mar">3、企业身份认证一旦通过将与您对应的唯一帐户进行绑定，企业身份具有唯一性。</p>
    </div>
    <div id="personalSimple" style="display: none">
	    <div class="explainMargin">
	    	<div class="simpleLeft">
	        	<strong>个人认证示例</strong>
	        	<p>1、身份证正面在前，人在后，证件不遮挡面部，保证证件清晰不模糊。</p>
	            <p>2、需要完整的身份证正面，保证身份证边缘处于图片内部，姓名，证件号码，照片清晰。</p>
	        </div>
	    </div>
	    <div class="explainMargin simpleRight bor_bot">
	        <img class="imgSimple" src="static/images/weixin/per_pic.jpg" />
	        <p class="simpleDesc mar">本人手持身份证正面头部照</p>
	    </div>
    </div>
    <div id="enterpriseSimple" style="display: none">
	    <div class="explainMargin">
	    	<strong>企业认证示例</strong>
			<p>需要企业营业执照最新版本，注意以下几点：</p>
			<p>1、最好上传企业营业执照的彩色电子版。</p>
			<p>2、营业执照复印件电子版需要加盖红色鲜章，并标注作资质认证用途。</p>
			<p>3、保证营业执照是最新版本，在工商局能够查询到，并且和执照上显示的信息一致。</p>
			<p>4、拍照时营业执照纸张边界应处于照片内，右上角“编号”需显示出来。</p>
			<p>5、电子版需要保证营业执照上的所有文字、二维码和登记机关签章都清晰可辨。</p>
	    </div>
	    <div class="explainMargin simpleRight bor_bot">
	        <img src="http://static.95155.com/member/images/ent_pic2.png">
	        <p>营业执照彩色电子版</p>
	        <p class="simpleDesc mar">需在营业期限内</p>
	    </div>
    </div>
    <div class="explainMargin">
    	<strong>后续</strong>
		<p>1、我们有专门的工作人员为您提交的资料进行核对认证工作，不出意外的话，您可以在3个工作日内收到审核结果的短信提示。</p>
		<p>2、如果您没有通过资质认证，工作人员会通过客服热线与您联系，说明不通过原因。</p>
	</div>
    <script type="text/javascript">
    	var type = '<%=request.getParameter("type")%>';
    	(function(){
    		if(type == "4a35c2f270cb4e4b909891be77d66403" || type == "c15936986fe34dc18d64ff4aef92e201"){	//个人货主、个人车主
    			$("#forpersonal").css('display', 'block');
    			$("#personalSimple").css('display', 'block');
    		} else if(type == "4e42ec1f537f4644a3bfc820eddeb5f5"){	//物流企业
    			$("#forenterprise").css('display', 'block');
    			$("#enterpriseSimple").css('display', 'block');
    		} else {	//未完善资料角色
    			$("#personalSimple").css('display', 'block');
    			$("#enterpriseSimple").css('display', 'block');
    			$("#forpersonal,#forenterprise").removeAttr("onclick");
    		}
    	})();
    	
    	/*返回上一页*/
    	$(".backhost").click(function() {
  			window.history.go(-1);
  		});
    	
   	 	function personalAuth() {
   	 		var userID = '<%=request.getParameter("userID")%>';
	    	window.location.href="weixin/personalAuth?userID=" + userID;
   	 	}
   	 	
	   	function enterpriseAuth() {
	   		var companyID = '<%=request.getParameter("companyID")%>';
	   		window.location.href="weixin/enterpriseAuth?companyID=" + companyID;
	   	}
    </script>
  </body>
</html>
