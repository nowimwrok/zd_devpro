<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>活动信息管理</title>
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
		<li><a href="${ctx}/wlpt/activity/activityWxinfo/">活动信息列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/activity/activityWxinfo/form?id=${activityWxinfo.id}">活动信息<shiro:hasPermission name="wlpt:activity:activityWxinfo:edit">${not empty activityWxinfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:activity:activityWxinfo:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="activityWxinfo" action="${ctx}/wlpt/activity/activityWxinfo/save" method="post" class="form-horizontal">
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">活动名称：</label>
			<div class="controls">
				<form:hidden path="id" htmlEscape="false" maxlength="32" class="input-xlarge required"/>
				<form:input path="activityName" htmlEscape="false" maxlength="32" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">活动说明：</label>
			<div class="controls">
				<form:input path="activityContent" htmlEscape="false" maxlength="250" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">开始时间：</label>
			<div class="controls">
				<input name="starttime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${activityWxinfo.starttime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">结束时间：</label>
			<div class="controls">
				<input name="endtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${activityWxinfo.endtime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否开启：</label>
			<div class="controls">
				<form:select path="iseffective" class="input-xlarge ">
					<form:option value="0" label="新建"/>
					<form:options items="${fns:getDictList('iseffective')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
				
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">活动类型：</label>
			<div class="controls">
				<form:select path="type" class="input-xlarge ">
					<form:option value="0" label="大转盘"/>
					<form:options items="${fns:getDictList('activity_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>

			</div>
		</div>
		<div class="control-group">
			<label class="control-label">活动对象：</label>
			<div class="controls">
				<form:select path="roletype" class="input-xlarge ">
					<form:option value="user" label="所有"/>
					<form:options items="${fns:getDictList('activity_roletype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<%--<div class="control-group">
			<label class="control-label">作用对象:</label>
			<div class="controls">
				<form:radiobuttons path="roletype" items="${allRoles}" itemLabel="name" itemValue="roleType" htmlEscape="false" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>--%>
		<%-- <div class="control-group">
			<label class="control-label">roletype：</label>
			<div class="controls">
				<form:input path="roletype" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div> --%>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:activity:activityWxinfo:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>