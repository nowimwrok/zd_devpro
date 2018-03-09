<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>争议信息管理</title>
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
		<li><a href="${ctx}/wlpt/user/userDispute/">争议信息列表</a></li>
		<li class="active"><a
			href="${ctx}/wlpt/user/userDispute/form?id=${userDispute.id}">争议信息<shiro:hasPermission
					name="wlpt:user:userDispute:edit">${not empty userDispute.id?'修改':'添加'}</shiro:hasPermission>
				<shiro:lacksPermission name="wlpt:user:userDispute:edit">查看</shiro:lacksPermission></a></li>
	</ul>
	<br />
	<form:form id="inputForm" modelAttribute="userDispute"
		action="${ctx}/wlpt/user/userDispute/addDispute" method="post"
		class="form-horizontal">
		<form:hidden path="id" />
		<sys:message content="${message}" />

		<div class="control-group">
			<label class="control-label">争议运单id：</label>
			<div class="controls">
				<form:input path="orderinfo.id" htmlEscape="false" maxlength="32"
					class="input-xlarge " />
			</div>
		</div>


		<div class="control-group">
			<label class="control-label">货物名称：</label>
			<div class="controls">
				<form:input path="goodsname" htmlEscape="false" maxlength="32"
					class="input-xlarge " />
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">提货吨数：</label>
			<div class="controls">
				<form:input path="takeloadweight" htmlEscape="false"
					class="input-xlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">货卸吨数：</label>
			<div class="controls">
				<form:input path="unloadweight" htmlEscape="false"
					class="input-xlarge " />
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">争议说明：</label>
			<div class="controls">
				<form:textarea path="disputeinfo" htmlEscape="false" rows="4"
					maxlength="512" class="input-xxlarge " />
			</div>
		</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">处理后运费：</label>
			<div class="controls">
				<form:input path="disputemoney" htmlEscape="false"
					class="input-xlarge " readonly="true"/>
			</div>
		</div> --%>



		<div class="form-actions">
			<shiro:hasPermission name="wlpt:user:userDispute:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit"
					value="保 存" />&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>
	</form:form>
</body>
</html>