<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>司机信息</title>
<meta name="decorator" content="default" />
<style type="text/css">
.imgheight {
	height: 110px;
	width: 200px;
}

#idcardimgPreview li {
	float: left;
}
</style>
<script type="text/javascript">
	$(document).ready(
			function() {
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
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/wlpt/user/userQualitycertify/">认证信息列表</a></li>
		<li class="active"><a
			href="${ctx}/wlpt/user/userQualitycertify/form?id=${userQualitycertify.id}">认证信息<shiro:hasPermission
					name="wlpt:user:userQualitycertify:edit">${not empty userQualitycertify.id?'修改':'添加'}</shiro:hasPermission>
				<shiro:lacksPermission name="wlpt:user:userQualitycertify:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<br />
	<form:form id="inputForm" modelAttribute="userQualitycertify"
		action="${ctx}/wlpt/user/userQualitycertify/save" method="post"
		class="form-horizontal">
		<form:hidden path="id" />
		<sys:message content="${message}" />
		<div class="control-group">
			<label class="control-label">司机姓名：</label>
			<div class="controls">${info.drivername }</div>
		</div>
		<div class="control-group">
			<label class="control-label">身份证号码:</label>
			<div class="controls">${info.idcardnum}</div>
		</div>
		<div class="control-group">
			<label class="control-label">手机号码:</label>
			<div class="controls">${info.drivermobile}</div>
		</div>

		<div class="control-group">
			<label class="control-label">身份证：</label>
			<div class="controls">
				<input type="hidden" id="idcardimg" value="${info.idcardimg}" />
				<sys:ckfinder input="idcardimg" type="images" readonly="true"
					uploadPath="/userQualitycertify" selectMultiple="true" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">驾驶证：</label>
			<div class="controls">
				<input type="hidden" id="driverlicimg" value="${info.driverlicimg}" />
				<sys:ckfinder input="driverlicimg" type="images" readonly="true"
					uploadPath="/userQualitycertify" selectMultiple="true" />
			</div>

		</div>
		<div class="control-group">
			<label class="control-label">头像：</label>
			<div class="controls">
				<input type="hidden" id="driverheadimg"
					value="${info.driverheadimg}" />
				<sys:ckfinder input="driverheadimg" type="images" readonly="true"
					uploadPath="/userQualitycertify" selectMultiple="true" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">认证状态：</label>
			<div class="controls">
				<form:select path="certifystatus" class="input-medium">
					<form:options items="${fns:getDictList('user_authen')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">认证内容：</label>
			<div class="controls">
				<form:textarea path="certifycomment" htmlEscape="false" rows="4"
					maxlength="500" class="input-xxlarge " />
			</div>
		</div>


		<div class="form-actions">
			<shiro:hasPermission name="wlpt:user:userQualitycertify:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit"
					value="保 存" />&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>
	</form:form>
</body>
</html>