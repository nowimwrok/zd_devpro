﻿<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<<!DOCTYPE html>
<html>
<head>
	<title>policyinfo</title>
	<meta charset="utf-8">
	<meta name="viewport"
          content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/ionic.min.css">
    <link rel="stylesheet" type="text/css" href="css/ionicons.min.css">

	<style type="text/css">
		body{
			background-color: #dddddd;
			overflow-y: scroll;
		}
	</style>
</head>
<body>
<!-- 	<div class="bar bar-header bar-dark">
	<a class="button button-clear icon ion-android-arrow-back" href="javascript:"></a>
	<h1 class="title">订单详细</h1>
</div> -->

	<div class="content has-header" style="height:568px;">
		<div class="list">
			<div class="item" style="font-size:12px;">
				<span>订单编号:&nbsp;&nbsp;64498498462656546464554</span><span class="assertive pull-right"> 投保成功</span>
			</div>
		</div>
		<div class="list">

			<div class="item">
				<span>你的保单号:</span><span class="assertive">5497889784654564654</span>
			</div>

			<div class="item">
				投保信息
			</div>
			<label class="item item-input">
				<span class="input-label">投保人</span>
				<input type="text" placeholder="投保人姓名">
			</label>
			<label class="item item-input">
				<span class="input-label">被保货物</span>
				<input type="text" placeholder="被保险货物的名称">
			</label>
			<label class="item item-input">
				<span class="input-label">货物类型</span>
				<input type="text" placeholder="被保险的货物类型">
			</label>
			<label class="item item-input">
				<span class="input-label">货物价值（元）</span>
				<input type="text" placeholder="被保险的货物价值">
			</label>

				<label class="item item-input">
				    <div class="input-label col col-15">
				      地址
				    </div>
				    <select>
				      <option>广东省</option>
				      <option >广西省</option>
				      <option>河北省</option>
				    </select>
				    <select>
				      <option>广州市</option>
				      <option>桂林市</option>
				      <option>邯郸市</option>
				    </select>
				    <select>
				      <option>天河区</option>
				      <option>天河区</option>
				      <option>天河区</option>
				    </select>
				</label>
			<label class="item item-input">
				<span class="input-label col col-20"></span>
				<input type="text" placeholder="详细地址">
			</label>
			<label class="item item-input">
				<span class="input-label">联系电话</span>
				<input type="text" placeholder="投保人电话">
			</label>
		</div>

		<div class="list">
			<label class="item">
				<span>运输信息</span>
			</label>
			<label class="item item-input">
				<span class="input-label">车牌号码</span>
				<input type="text" placeholder="运输车的车牌号码">
			</label>
			<label class="item item-input">
				<span class="input-label">机动车类型</span>
				<input type="text" placeholder="运输车的机动车类型">
			</label>
			<label class="item item-input">
				<span class="input-label">厂牌型号</span>
				<input type="text" placeholder="运输车辆的厂牌类型">
			</label>
		</div>
	</div>
</body>
</html>