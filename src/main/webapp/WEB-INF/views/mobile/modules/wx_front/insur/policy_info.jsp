﻿<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>订单详情</title>
	<meta charset="utf-8">
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
    <script src="${ctxStatic}/ionic/js/ionic.bundle.min.js"></script>
	<style type="text/css">
		body{
			background-color: #dddddd;
			
		}
	</style>
</head>
<body ng-app="policyform" ng-controller="policyformCtrl">
<!-- 	<div class="bar bar-header bar-dark">
	<a class="button button-clear icon ion-android-arrow-back" href="javascript:"></a>
	<h1 class="title">订单详细</h1>
</div> -->
	<form id="policyform" modelAttribute="userinsurance" action="${wx }/weixin/insur/save" method="post" >	
	<ion-content>
	
	<div class="content">
		<c:if test="${not empty model.insuranceNO}">
		<div class="list">
			<div class="item" style="font-size:12px;">
				<span>你的保单号:&nbsp;&nbsp;${model.insuranceNO}</span><span class="assertive pull-right"> 投保成功</span>
			</div>
		</div>
		</c:if>
		<div class="list">
 			<c:if test="${not empty model.orderno}">
 			<div class="item">
				<span>订单编号:</span><span class="assertive">${model.orderno}</span>
			</div>
			</c:if>
			<div class="item">
				投保信息
			</div>
			<label class="item item-input">
				<span class="input-label">投保人</span>
				<span class="">${model.applicant}</span>
			</label>
			
			<!-- 商业险 -->
            <c:if test="${model.insurlist.insuranceway eq 1 }">
            <label class="item item-input">
				<span class="input-label">证件号</span>
				<span class="">${model.cardNo}</span>
			</label>
            </c:if>
            
            <!-- 货物险 -->
            <c:if test="${model.insurlist.insuranceway eq 0 }">
			<label class="item item-input">
				<span class="input-label">被保货物</span>
				<span class="">${model.goodsname}</span>
			</label>
			<label class="item item-input">
				<span class="input-label">货物类型</span>
				<span class="">${model.goodstype}</span>
			</label>
			<label class="item item-input">
				<span class="input-label">货物价值（元）</span>
				<span class="">${model.worth}</span>
			</label>
			</c:if>
			<label class="item item-input">
			    <span class="input-label">
			      地址
			    </span>
			    <span class="">${model.applicantAddress.info }</span>
			</label>
			<label class="item item-input">
				<span class="input-label col col-20"></span>
				<span class="">${model.applicantAddress.address}</span>
			</label>
			<label class="item item-input">
				<span class="input-label">联系电话</span>
				<span class="">${model.applicantAddress.linkmobile}</span>
			</label>
		</div>

		<div class="list">
			<label class="item">
				<span>运输信息</span>
			</label>
			<label class="item item-input">
				<span class="input-label">车牌号码</span>
				<span class="">${model.carnumber}</span>
			</label>
			<label class="item item-input">
				<span class="input-label">机动车类型</span>
				<span class="">${model.cartype}</span>
			</label>
			<label class="item item-input">
				<span class="input-label">厂牌型号</span>
				<span class="">${model.carmodel}</span>
			</label>
			<label class="item item-input">
				<span class="input-label">总质量</span>
				<span class="">${model.totalweight}</span>
			</label>
			<lable class="item item-input">
				<span class="input-label">核定载质量</span>
				<span class="">${model.carweight}</span>
			</lable>
			
			<c:if test="${model.insurlist.insuranceway eq 1 }">
			<lable class="item item-input">
				<span class="input-label">核定载客(人)</span>
				<span class="">${model.passengersnum}</span>
			</lable>
			<lable class="item item-input">
				<span class="input-label">使用性质</span>
				<span class="">${model.usecharacter}</span>
			</lable>
			<lable class="item item-input">
				<span class="input-label">识别代码</span>
				<span class="">${model.vin}</span>
			</lable>
			<lable class="item item-input">
				<span class="input-label">发动机号码</span>
				<span class="">${model.engineNo}</span>
			</lable>
			<lable class="item item-input">
				<span class="input-label">登记日期</span>
				<span class=""><fmt:formatDate value="${insurance.sendtime}" pattern="yyyy-MM-dd HH:mm:ss"/></span>
			</lable>
            </c:if>
						
		</div>
		
		<!-- 货物险 -->
        <c:if test="${model.insurlist.insuranceway eq 0 }">
		<div class="list">
			<div class="item item-driver">
				线路信息
			</div>
				<label class="item item-input">
				    <div class="input-label col col-15">
				      始发地
				    </div>
				    <span class="">${model.shipAddress.info}</span>
				</label>
				<label class="item item-input">
					<span class="input-label col col-20"></span>
					<span class="">${model.shipAddress.address}</span>
				</label>
				
				<label class="item item-input">
				    <div class="input-label col col-15">
				      目的地
				    </div>
				    <span class="">${model.consignAddress.info}</span>
				</label>

			<div class="item item-input">
				<span class="input-label col col-20"></span>
				<span class="">${model.consignAddress.address}</span>
			</div>						
		</div>	
		</c:if>
		
		<div class="list">
			<div class="item item-driver">
				承保信息
			</div>
			<label class="item item-input">
				<span class="input-label">承保险种</span>
				<span class="">${model.insurancetype}</span>
			</label>
			<!-- 货物险 -->
            <c:if test="${model.insurlist.insuranceway eq 0 }">
			
			<label class="item item-input">
				<span class="input-label">理赔金额</span>
				<span class="">${model.insuranceamount}</span>
			</label>
			</c:if>		
			<lable class="item item-input">
				<span class="input-label">保险费合金（元）</span>
				<span class="">${model.insurancefeel}</span>
			</lable>
			<!-- 商业险 -->
            <c:if test="${model.insurlist.insuranceway eq 1 }">
			<c:if test="${not empty model.subtype }">	
				<lable class="item">
					<span class="input-label">本次购选保险</span>
						<c:forEach items="${fn:split(model.subtype,'|')}" var="val" varStatus="i" >
							<span style="margin-left: 10px;">${val}</span>
						</c:forEach>
				</lable>
			</c:if>	
			</c:if>	
		</div>			
	</div>
	</ion-content>
	<c:if test="${empty model.insuranceNO}">
	<!-- <ion-footer-bar align-title="center" class="bar-calm">
		<span></span>
		<button class="  button button-calm button-full">下一步</button>
	</ion-footer-bar> -->
	</c:if>
	</form>
</body>
<script type="text/javascript">
 angular.module("policyform",['ionic'])
 .controller('policyformCtrl',['$scope','$timeout','$http',function($scope,$timeout,$http){

 }])
 
</script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/config.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/global.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/errorpage.js"></script>
<script type="text/javascript">

//======================================================地址控件==============================================
	
</script>
</html>