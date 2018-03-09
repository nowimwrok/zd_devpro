<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>常用联系人管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
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
		<li><a href="${ctx}/wlpt/contacts/userCommonContacts/">常用联系人列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/contacts/userCommonContacts/form?id=${userCommonContacts.id}">常用联系人<shiro:hasPermission name="wlpt:contacts:userCommonContacts:edit">${not empty userCommonContacts.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:contacts:userCommonContacts:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="userCommonContacts" action="${ctx}/wlpt/contacts/userCommonContacts/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">所属用户id：</label>
			<div class="controls">
				<sys:treeselect id="user" name="user.id" value="${userCommonContacts.user.id}" labelName="user.name" labelValue="${userCommonContacts.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">目标id：</label>
			<div class="controls">
				<sys:treeselect id="targetId" name="targetId" value="${userCommonContacts.targetId}" labelName="" labelValue="${userCommonContacts.}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">目标类型：</label>
			<div class="controls">
				<form:input path="targetType" htmlEscape="false" maxlength="2" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">保险公司介绍：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="500" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:contacts:userCommonContacts:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>