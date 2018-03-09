﻿<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<html>
<head>
	<title>${insurlist.insurCompanyname }保险详情</title>
	<meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <meta name="viewport"
          content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/ionic.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/ionicons.min.css">
    <style type="text/css">
	body{
		background:#dddddd;
	}

	.title span{
			font-weight: 700;
	}

	#form{
		background: #ffffff;
	}

	p{
		font-size: 17px;
	}
    </style>
</head>
<body>
<!-- 	<div class="bar bar-header bar-dark">
		<a class="button button-clear icon ion-android-arrow-back" href="javascript:"></a>
		<h1 class="title"><span>保单详情</span></h1>
	</div> -->
	<div class="card">
		<div class="item item-image">
			<%-- <img src="${ctxStatic }/images/weixin/shop_img/paic.png"> --%>
			<img alt="" style="height: 250px;" onerror="this.onerror=null;this.src='${ctxStatic }/images/weixin/shop_img/paic.png'"
                     src="${insurlist.insurLogo }">
		</div>

	</div>

	<div class="list" style="background: #ffffff; ">
      	<label class="item item-row">
      		<h2 style="font-weight:700;font-size:20px;">${insurlist.insurName }</h2>
      		<div>
      			<span>卓大直购价：</span>
      			<span style="color:#ff0000">¥${insurlist.insurAmount }</span>
      		</div>
      	</label>
        <label class="item item-input">
          <span class="input-label">最高保额:<span style="color: red;font-weight: bold;">${insurlist.maxAmount }</span></span>
        </label>
		<div class="row item">
			<span class="col"><i class="ion-android-checkbox-outline" style="color:green">&nbsp;</i><span style="font-size:8px;">在线直投</span></span>
			<span class="col"><i class="ion-android-checkbox-outline" style="color:green">&nbsp;</i><span style="font-size:8px;">在线支付</span></span>
			<span class="col"><i class="ion-android-checkbox-outline" style="color:green">&nbsp;</i><span style="font-size:8px;">全国通赔</span></span>
			<span class="col"><i class="ion-ios-information"></i><span style="font-size:8px;">&nbsp;不支持退换货</span></span>
		</div>
		
	</div>
	<div class="bar bar-footer bar-calm">
		<div class="bar bar-subfooter" style="background:#dddddd;">
				<span class="title" style="color:#000000;font-size:1px;">客服电话：0310-3188756</span>
		</div>

		<buton class="title" onclick="showBg1();" ><span>立即购买</span></button>
	</div>
</body>
<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery-1.7.2.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script type="text/javascript" src="/static/common/global.js"></script>
<script type="text/javascript">
    function showBg1() {
    	var status = "${user.userinfo.status}";
    	if('${insurlist.ismeasure}'=='1'){
        	$.MsgBox.Alert("温馨提示", "请拨打客服电话（0310-3188756）购买");
        	return;
        }
        if (status == '2') {
    		window.location.href="${wx}/weixin/shop/toinsur?id=${insurlist.id}";
        }else if("${user.userinfo}"==""||"${user.userinfo}"=="null"){
        	$.MsgBox.Alert("温馨提示", "您还未登录，请先登录");
        }else{
        	$.MsgBox.Alert("温馨提示", "认证用户才可购买");
        }

    }
</script>
</html>