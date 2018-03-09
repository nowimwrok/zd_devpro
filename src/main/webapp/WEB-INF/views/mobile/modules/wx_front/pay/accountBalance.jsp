<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>${fns:getConst('SYSTEMTITLE')}--余额</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">

<script type="text/javascript" src="${ctxStatic}/weixin/js/weixin/errorpage.js"></script>
	<script>
		var _hmt = _hmt || [];
		(function() {
			var hm = document.createElement("script");
			hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
			var s = document.getElementsByTagName("script")[0];
			s.parentNode.insertBefore(hm, s);
		})();
	</script>

	<link href="${ctxStatic}/weixin/css/global.css" rel="stylesheet"
	type="text/css">
<style type="text/css">

/* 数据中部信息 */
.data_box {
	width: 100%;
	margin: 0 auto;
}
.data_top{
	width:100%;
	height:230px;
	background-color:rgba(32, 162, 226, 0.87);
}
.divwidth{
	width:100%;
}
.toptop{
	height: 23%;
}
.topbtm{
	height: 27%;
}
.divleft{
float: left;
}
.topfont{
	font-size:23px;
	padding-left:7%;
	line-height: 250%;
	height:80%;
	color: rgba(248, 248, 255, 0.88);
}
.btmfont{
	font-size:50px;
	padding-left:10%;
	color: white;
}
.divauto{
	background-color:white;
	height:100px;
}
.divatuodiv{
	height: 50%;
}
.antofont{
color: gray;
font-size:20px;
padding-left:7%;
 height:80%;
 line-height:200%;
}
.autuoborder{
	border-bottom: 1px solid #EBEBEB;
}
.bodycolor{
	background-color: #EBEBEB;
}
</style>
</head>

<body class="bodycolor">
	<div class="data_box ">
	<div class="data_top">
		<div class="divwidth toptop divleft"><span class="topfont">账号余额(元)</span></div>
		<div class="divwidth topbtm divleft"><span class="btmfont">${user.userPurse.availablebalance!=null?user.userPurse.availablebalance:'0.00' }</span></div>
		<c:if test="${user.memberId!=null&&user.memberId!=''}">
		<div class="divwidth toptop divleft"><span class="topfont">电子钱包(元)</span></div>
		<div class="divwidth topbtm divleft"><span class="btmfont" id="available"></span></div>
		</c:if>
	</div>
	<div class="divwidth divleft divauto">
	<div class="divwidth divleft divatuodiv autuoborder" onclick="gopay()"><span class="antofont">充值</span></div>
	<div class="divwidth divleft divatuodiv" onclick="gocash()"><span class="antofont">提现</span></div>
	</div>
	</div>
</body>
<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery-1.7.2.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
var memberId="${user.memberId}";
if(memberId!=null&&memberId!=""){
    $.ajax({
            url: "${wlpt}/wlpt/consume/virtAcctList",
            dataType: 'json',
            data:{"memberId":memberId,"status":'1'},
            type: "post",
            success: function (data) {
               if(data.status==200){
            	   var slaveAccounts=data.body.records[0].slaveAccounts;
            	   for(i=0;i<slaveAccounts.length;i++){
            		   if(slaveAccounts[i].accountType==4){
            			   
            			   $("#available").html(slaveAccounts[i].availableBalance);
            		   }
            	   }
            	   
               }
            }
    });
}
window.gocash=function(){
	 window.location.href = "${wx}/weixin/user/toAccountCash";
};
window.gopay=function(){
	 window.location.href = "${wx}/weixin/user/toAccountPay";
};
</script>

</html>
