﻿<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>policyform</title>
	<meta charset="utf-8">
	<meta name="viewport"
          content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <link rel="stylesheet" type="text/css" href="css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="css/ionic.min.css">
    <link rel="stylesheet" type="text/css" href="css/ionicons.min.css">
    <script src="http://www.runoob.com/static/ionic/js/ionic.bundle.min.js"></script>
    <style type="text/css">
		body{
			background-color: #dddddd;
			overflow-y:scroll; 
		}
    </style>
</head>
<body>
<!-- 	<div class="bar bar-header bar-dark">
<h1 class="title">保险详情</h1>
</div>  -->
	<div class="content has-header">
		<div class="" style="height:540px;">
		<div class="list">
			<div class="item item-driver">
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
			<div class="item item-driver">
				运输信息
			</div>
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
			<label class="item item-input">
				<span class="input-label">总质量</span>
				<input type="text" placeholder="运输车辆的核定载量">
			</label>
			<lable class="item item-input">
				<span class="input-label">核定载质量</span>
				<input type="text" placeholder="运输车辆的核定载质量">
			</lable>			
		</div>

		<div class="list">
			<div class="item item-driver">
				线路信息
			</div>
				<label class="item item-input">
				    <div class="input-label col col-15">
				      始发地
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

			<div class="item item-input">
				<span class="input-label col col-20"></span>
				<input type="text" placeholder="详细地址">
			</div>
			<label class="item item-input">
				<div class="input-label col col-15">
					目的地
				</div>
				<select>
				   	<option>广东省</option>
				    <option >广西省</option>
				    <option>河北省</option>
				</select>
				<select>
					<option>广州市</option>
				    <option selected="">桂林市</option>
				    <option>邯郸市</option>
				    </select>
				<select>
				    <option>天河区</option>
				    <option>白云区</option>
				    <option selected="">番禺区</option>
				</select>
			</label>

			<div class="item item-input">
				<span class="input-label col col-20"></span>
				<input type="text" placeholder="详细地址">
			</div>						
		</div>

		<div class="list">
			<div class="item item-driver">
				承保信息
			</div>
			<label class="item item-input">
				<span class="input-label">承保险种</span>
				<input type="text" placeholder="国内公路货物运输保险" disabled="true" style="background-color:white">
			</label>
			<label class="item item-input">
				<span class="input-label">保险金额</span>
				<input type="text" placeholder="最高16万" disabled="true" style="background-color:white">
			</label>
			<lable class="item item-input">
				<span class="input-label">保险费合金（元）</span>
				<input type="text" placeholder="60" disabled="true" style="background-color:white">
			</lable>			
		</div>
	</div>
	</div>

 	<div class="bar bar-footer bar-calm">
 		<h1 class="title">
			<button type="button" class="itme item-button-center button button-calm">下一步</button>
		</h1>
	</div>	
</body>
</html>