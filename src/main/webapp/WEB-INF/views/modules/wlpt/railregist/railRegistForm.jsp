<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>自定义区域管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript" src="http://api.map.baidu.com/api?v=1.3"></script>
<script type="text/javascript">
	$(document).ready(
			function() {
				$("#container").hide();
				//$("#name").focus();
				$("#inputForm")
						.validate(
								{
									rules : {
										railname : {
											required : true
										},
										lonlat : {
											required : true
										},
										radius : {
											required : true,
											digits : true
										},
										actionType : {
											required : true
										},
										type : {
											required : true
										}
									},
									messages : {
										railname : {
											required : "请填写围栏名称"
										},
										lonlat : {
											required : "请填写经纬度"
										},
										radius : {
											required : "请填写范围",
											digits : "范围应为整数"
										},
										actionType : {
											required : "请填写事件类型"
										}
									},
									submitHandler : function(form) {
										loading('正在提交，请稍等...');
										form.submit();
									},
									errorContainer : "#messageBox",
									errorPlacement : function(error, element) {
										$("#messageBox").text("输入有误，请先更正。");
										if (element.is(":checkbox")
												|| element.is(":radio")
												|| element.parent().is(
														".input-append")) {
											error.appendTo(element.parent()
													.parent());
										} else {
											error.insertAfter(element);
										}
									}
								});
			});
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/wlpt/railRegist/">自定义区域列表</a></li>
		<li class="active"><a
			href="${ctx}/wlpt/railRegist/form?id=${railRegist.id}">自定义区域<shiro:hasPermission
					name="customizeregist:railRegist:edit">${not empty railRegist.id?'修改':'添加'}</shiro:hasPermission>
				<shiro:lacksPermission name="customizeregist:railRegist:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<br />
	<form:form id="inputForm" modelAttribute="railRegist"
		action="${ctx}/wlpt/railRegist/save" method="post"
		class="form-horizontal">
		<form:hidden path="id" />
		<sys:message content="${message}" />
		<div class="control-group">
			<label class="control-label">围栏名称：</label>
			<div class="controls">
				<form:input path="railname" htmlEscape="false" maxlength="255"
					class="input-xlarge required" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">经纬度：</label>
			<div class="controls">
				<form:input path="lonlat" htmlEscape="false" maxlength="255"
					class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span> <span>经度,纬度英文逗号分隔</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">范围：</label>
			<div class="controls">
				<form:input path="radius" htmlEscape="false" maxlength="255"
					class="input-xlarge required" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">事件类型：</label>
			<div class="controls">
				<form:checkboxes path="actionType" items="${fns:getDictList('actionType')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">订阅类型：</label>
			<div class="controls">
				<form:select path="type" class="input-xlarge ">
					<form:option value="" label="" />
					<form:options items="${fns:getDictList('type')}" itemLabel="label"
						itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="customizeregist:railRegist:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit"
					value="保 存" />&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>
	</form:form><br/>
			<div style="width: 900px; height:70px" class="control-group">
				<label class="control-label">要查询的地址：</label>
				<input id="text_" type="text" value="宁波天一广场"/>
				<label class="control-label">查询结果(经纬度)：</label>
				<input id="result_" type="text"/> <input type="button" value="查询" onclick="searchByStationName();" />
				<div id="container"
					style="position: absolute; margin-top: 30px; width: 730px; height: 590px; top: 50; border: 1px solid gray; overflow: hidden;">
				</div>
			</div>
			<script type="text/javascript">
				var map = new BMap.Map("container");
				map.centerAndZoom("宁波", 12);
				map.enableScrollWheelZoom(); //启用滚轮放大缩小，默认禁用
				map.enableContinuousZoom(); //启用地图惯性拖拽，默认禁用

				map.addControl(new BMap.NavigationControl()); //添加默认缩放平移控件
				map.addControl(new BMap.OverviewMapControl()); //添加默认缩略地图控件
				map.addControl(new BMap.OverviewMapControl({
					isOpen : true,
					anchor : BMAP_ANCHOR_BOTTOM_RIGHT
				})); //右下角，打开

				var localSearch = new BMap.LocalSearch(map);
				localSearch.enableAutoViewport(); //允许自动调节窗体大小
				function searchByStationName() {
					map.clearOverlays();//清空原来的标注
					var keyword = document.getElementById("text_").value;
					localSearch
							.setSearchCompleteCallback(function(searchResult) {
								var poi = searchResult.getPoi(0);
								document.getElementById("result_").value = poi.point.lng
										+ "," + poi.point.lat;
								map.centerAndZoom(poi.point, 13);
								var marker = new BMap.Marker(new BMap.Point(
										poi.point.lng, poi.point.lat)); // 创建标注，为要查询的地方对应的经纬度
								map.addOverlay(marker);
								var content = document.getElementById("text_").value
										+ "<br/><br/>经度："
										+ poi.point.lng
										+ "<br/>纬度：" + poi.point.lat;
								var infoWindow = new BMap.InfoWindow(
										"<p style='font-size:14px;'>" + content
												+ "</p>");
								marker.addEventListener("click", function() {
									this.openInfoWindow(infoWindow);
								});
								// marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
							});
					localSearch.search(keyword);
				}
			</script>
</body>
</html>