<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>车辆管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(document).ready(
			function() {
				//$("#name").focus();
				$("#inputForm")
						.validate(
								{
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
<style type="text/css">
ol, ol li {
	float: left;
}
</style>
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript"
	src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/wlpt/car/list">车辆列表</a></li>
	</ul>
	<br />
	<form:form id="inputForm" modelAttribute="car"
		action="${ctx}/wlpt/car/save" method="post" class="form-horizontal">
		<form:hidden path="id" />
		<sys:message content="${message}" />
		<div class="control-group">
			<label class="control-label">用户名：</label>
			<div class="controls">
				<form:input path="user.loginName" value="${car.user.loginName}"
					htmlEscape="false" maxlength="20" class="input-xlarge "
					readonly="true" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车牌号：</label>
			<div class="controls">
				<form:input id="carnumber" path="carnumber" htmlEscape="false"
					maxlength="10" class="input-xlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车型：</label>
			<div class="controls">
				<form:select path="cartype" class="input-xlarge ">
					<form:option value="" label="" />
					<form:options items="${fns:getDictList('car_type')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车长：</label>
			<div class="controls">
				<form:input id="carlength" path="carlength" htmlEscape="false"
					maxlength="10" class="input-xlarge " />
				${car.lengthunit}
				<%-- <form:select path="carlength" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('car_length')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select> --%>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">载重：</label>
			<div class="controls">
				<form:input id="loadweight" path="loadweight" htmlEscape="false"
					class="input-xlarge " />
				${car.weightunit}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">主营路线：</label>
			<div class="controls">
				<form:input path="mainroad" htmlEscape="false" maxlength="20"
					class="input-xlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车主姓名：</label>
			<div class="controls">
				<form:input id="ownername" path="ownername" htmlEscape="false"
					maxlength="10" class="input-xlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车主手机：</label>
			<div class="controls">
				<form:input id="ownermobile" path="ownermobile" htmlEscape="false"
					maxlength="11" class="input-xlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车辆类型：</label>
			<div class="controls">
				<form:select path="issocialcar" class="input-xlarge ">
					<form:options items="${fns:getDictList('issocialcar')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">定位手机：</label>
			<div class="controls">
				<form:input id="locationmobile" path="locationmobile"
					htmlEscape="false" maxlength="11" class="input-xlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">行驶证照片：</label>
			<div class="controls">
				<form:hidden id="travellicimg" path="travellicimg"
					htmlEscape="false" maxlength="500" class="input-xlarge" />
				<sys:ckfinder input="travellicimg" type="images" uploadPath="/car"
					selectMultiple="true" maxnumber="2" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车辆外观照片：</label>
			<div class="controls">
				<form:hidden id="carsurfaceimg" path="carsurfaceimg"
					htmlEscape="false" maxlength="500" class="input-xlarge" />
				<sys:ckfinder input="carsurfaceimg" type="images" uploadPath="/car"
					selectMultiple="true" maxnumber="2" />
			</div>
		</div>
		<%-- 		<div class="control-group">
			<label class="control-label">认证状态：</label>
			<div class="controls">
			    <form:select path="status" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('authenStatus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div> --%>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:car:edit">
				<input id="btnSubmit" class="btn btn-primary" type="button"
					onclick="savecar()" value="保 存" />&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>
	</form:form>
	<script type="text/javascript">
		function savecar() {
			var isnul = true;
			isnul = isnul && $("#carnumber").valid({
				methods : "required"
			});
			isnul = isnul && $("#cartype").valid({
				methods : "required"
			});
			isnul = isnul && $("#carlength").valid({
				methods : "required|isdecimal"
			});
			isnul = isnul && $("#loadweight").valid({
				methods : "required|isdecimal"
			});

			if ($("#ownername").val() != "" && $("#ownername").val() != null) {
				isnul = isnul && $("#ownername").valid({
					methods : "isName"
				});
			}
			if ($("#ownermobile").val() != ""
					&& $("#ownermobile").val() != null) {
				isnul = isnul && $("#ownermobile").valid({
					methods : "isPhone"
				});
			}
			if ($("#locationmobile").val() != ""
					&& $("#locationmobile").val() != null) {
				isnul = isnul && $("#locationmobile").valid({
					methods : "isPhone"
				});
			}
			if (!isnul) {
				return false;
			}
			$("#inputForm").submit();
		}
	</script>
</body>
</html>