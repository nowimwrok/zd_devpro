﻿<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>支付成功</title>
	<meta charset="utf-8">
	<meta name="viewport"
          content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/ionic.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/ionicons.min.css">
    
    <style type="text/css">
    body{
    	background-color: #dddddd;
    	
    }
    </style>
</head>
<body>
	<div class="bar bar-header bar-light">
		<p class="title">支付成功&nbsp;<span class="text-muted" style="font-size:5px;">处理中...<span></p>
	</div>

	<!-- 不要去掉-->

	<br/>
	<br/>
	<form action="insurance_form_submit" method="post" accept-charset="utf-8">
			<div  class="list">				
				<div class="item item-input">
				  	<span class="input-label col col-80">支付状态:</span>
					
				  	<div class="text-info" style="font-weight:600">已支付</div>
					<!-- <input type="text" value="40" style="color:red;" disabled="disabled"> --> 
				</div>

				<div class="item item-input">
				  	<span class="input-label col col-60">创建时间:</span>
				  	<span class="col col-10"></span>
				  	 <input class="col col-30" type="text" value="2017-01-09" disabled="disabled" style="background-color:white"> 					
				</div>

				<div class="item" style="height:60px;text-align:center;font-size:10px;">
					<span class="text-info" >温馨提示:您的保单生成将在三个工作日完成</span>				
				</div>
			</div>
			<div>
				<button type="button" class=" button  button-block button-calm" style="">查看保单</button>	
			<div>

<!--  	<div class="bar bar-footer">
 	<h1 class="title">
 		</h1>
 	</div>  --> 
	</form>
</body>
</html>