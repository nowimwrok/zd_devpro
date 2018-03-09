<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>货运险介绍</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">

<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

body {
	margin: 0 auto;
	width: 100%;
	background-color: white;
}

.content {
	margin: 2% 3% 2% 3%;
	padding: 2%;
}

.img {
	width: 100%;
}

.pb {
	font-weight: bold;
	font-size: 1em;
	margin-top: 10px;
    margin-bottom: 3px;
}

.pDiv {
	margin: 0.5em 0;
	text-indent: 1.5em;
}

p {
	font-size:1em;
	font-family: Microsoft YaHei;
	
}

.textIndent {
	text-indent: 2em;
}

</style>
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
	<%-- <%@ include file="./pagetitle.jsp"%> --%>
	<div class="content">
		<img class="img" src="static/userimgs/20150817/1439813254997022842.jpg">  
		<div class="pb">华泰货物运输保险介绍</div>
		<hr>
		<div>
			<div class="pDiv"><p>水陆双保，保险范围广：分基本险和综合险两种。保险货物遭受损失时，保险人按承保险别的责任范围负赔偿责任。</p></div>
			<div class="pDiv"><p>基本险中保险人承保的责任范围，包括了因火灾、爆炸、雷电、冰雹等灾难所造成的损失；由于隧道、码头坍塌或运输工具发生碰撞、搁浅、触礁等所造成的损失；在装货、卸货或转载时因遭受不属于包装质量不善或装卸人员违反操作规程所造成的损失；以及按国家规定或一般惯例应分摊的共同海损的费用等。</p></div>
			<div class="pDiv"><p>综合险中保险人承保的责任范围，包括了因受震动、碰撞、挤压而造成货物损坏或包装损坏致使货物散失的损失；液体货物因受震动、碰撞或挤压致使所用容器（包括封口)损坏而渗漏的损失；液体保藏的货物因液体渗漏而造成保藏货物腐烂变质的损失；遭受盗窃或整件提货不着的损失；以及符合安全运输规定而遭受雨淋所致的损失等。</p></div>
			<div class="pDiv"><p>投保方便，保险额度高：每一危险单位最高接受200万元人民币或(33万美元)的保险金额，接受大部分常规货物投保；投保方便，在线填写发货人姓名、身份证、手机、货物价值等数样信息，即刻便能网上出单（注：易燃易爆物等要另行办理投保手续）。</p></div>
			<div class="pDiv"><p>高效赔付，专人跟进：被保险人申请赔偿，理赔系统即刻便能受理，专人跟进，我们的承诺是7*24小时全天候在线为您服务，服务范围可达全国各地市、区、县、乡镇。</p></div>
		</div>
		<div class="pb">线上优惠活动</div>
		<hr>
		<div style="margin-top: 10px">
			<p><span class="pb">活动时间：</span>8月18日-10月18日</p>
			<p style="font-weight: bold;font-size: 1em;">优惠内容：</p>
			<div class="textIndent">
				<div><p>号外！号外！！</p></div>
				<div><p>上线送豪礼，老板太任性！</p></div>
				<div><p>从即刻起，在“卓大平台”申报华泰货运保险，即可享受首单免费。</p></div>
				<div><p>注册会员更有好礼相送，验证就送钱有木有！保险办理尊享全网最低费率有木有！！</p></div>
				<div><p>万分之三，只要万分之三，秒杀同行有木有！！！</p></div>
				<div><p>没有最低，只有更低！</p></div>
				<div><p>为期两个月。</p></div>
				<div><p>仅限两个月。</p></div>
				<div><p>买买买，任性体验只为您有！！！</p></div>
			</div>
			<img style="margin:10px 0;" src="static/userimgs/20150814/1439519196475019596.png">
			<p>您只需要提供以下资料，即可办理华泰货物运输险：</p>
			<div class="textIndent">
				<p>1、身份证</p>
				<p>2、手机号码</p>
				<p>3、货物信息</p>
			</div>
			<div class="textIndent" style="margin-top: 10px;">
				<div><p>客服电话：0310-3188756</p></div>
				<div><p>企业Q Q：<a target="_blank" href="http://wpa.qq.com/msgrd?v=3&uin=4001681756&site=qq&menu=yes">4001681756</a></p></div>
				<div><p>企业邮箱：kf@yql56.com</p></div>
			</div>
		</div>
	</div>

</body>
</html>