<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>认证信息管理</title>
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
			<label class="control-label">认证ID：</label>
			<div class="controls">
				<form:input path="id" htmlEscape="false" maxlength="50"
					class="input-xlarge required" />
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">认证类型:0:个人信息1:企业信息2:车辆信息3:司机信息：</label>
			<div class="controls">
				<form:input path="certifytype" htmlEscape="false" maxlength="11"
					class="input-xlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">认证目标的Id：</label>
			<div class="controls">
				<form:input path="targetid" htmlEscape="false" maxlength="50"
					class="input-xlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">认证操作者Id：</label>
			<div class="controls">
				<form:input path="certifyuser.id" htmlEscape="false" maxlength="50"
					class="input-xlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">认证状态1:认证通过0:等待认证2认证不通过：</label>
			<div class="controls">
				<form:input path="certifystatus" htmlEscape="false" maxlength="11"
					class="input-xlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">认证内容：</label>
			<div class="controls">
				<form:textarea path="certifycomment" htmlEscape="false" rows="4"
					maxlength="500" class="input-xxlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">认证附件：</label>
			<div class="controls">
				<form:hidden id="certifyfile" path="certifyfile" htmlEscape="false"
					maxlength="100" class="input-xlarge" />
				<sys:ckfinder input="certifyfile" type="files"
					uploadPath="/wlpt/user/userQualitycertify" selectMultiple="true" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">认证时间：</label>
			<div class="controls">
				<input name="certifytime" type="text" readonly="readonly"
					maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${userQualitycertify.certifytime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">申请操作者Id：</label>
			<div class="controls">
				<form:input path="requestuser.id" htmlEscape="false" maxlength="50"
					class="input-xlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">申请认证时间：</label>
			<div class="controls">
				<input name="requesttime" type="text" readonly="readonly"
					maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${userQualitycertify.requesttime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" />
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