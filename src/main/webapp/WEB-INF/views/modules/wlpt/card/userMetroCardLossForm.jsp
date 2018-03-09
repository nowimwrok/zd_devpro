<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>一卡通挂失信息管理</title>
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
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/wlpt/card/userMetroCardLoss/">一卡通挂失信息列表</a></li>
		<li class="active"><a
			href="${ctx}/wlpt/card/userMetroCardLoss/form?id=${userMetroCardLoss.id}">一卡通挂失信息<shiro:hasPermission
					name="wlpt:card:userMetroCardLoss:edit">${not empty userMetroCardLoss.id?'修改':'添加'}</shiro:hasPermission>
				<shiro:lacksPermission name="wlpt:card:userMetroCardLoss:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<br />
	<form:form id="inputForm" modelAttribute="userMetroCardLoss"
		action="${ctx}/wlpt/card/userMetroCardLoss/save" method="post"
		class="form-horizontal">
		<form:hidden path="id" />
		<sys:message content="${message}" />
		<div class="control-group">
			<label class="control-label">申请挂失用户：</label>
			<div class="controls">${userMetroCardLoss.user.loginName}</div>
		</div>
		<div class="control-group">
			<label class="control-label">卡号：</label>
			<div class="controls">
				<form:input path="cardid" htmlEscape="false" maxlength="32"
					class="input-xlarge " readonly="true" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">状态：</label>
			<div class="controls">
				<form:select path="status" class="input-xlarge ">
					<form:option value="" label="" />
					<form:options items="${fns:getDictList('metroloss_status')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4"
					maxlength="255" class="input-xxlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">一卡通工号：</label>
			<div class="controls">
				<form:input path="useraccount" htmlEscape="false" maxlength="32"
					class="input-xlarge " readonly="true" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">一卡通姓名：</label>
			<div class="controls">
				<form:input path="truename" htmlEscape="false" maxlength="32"
					class="input-xlarge " readonly="true" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">一卡通电话：</label>
			<div class="controls">
				<form:input path="mobile" htmlEscape="false" maxlength="32"
					class="input-xlarge " readonly="true" />
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:card:userMetroCardLoss:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit"
					value="保 存" />&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>
	</form:form>
</body>
</html>