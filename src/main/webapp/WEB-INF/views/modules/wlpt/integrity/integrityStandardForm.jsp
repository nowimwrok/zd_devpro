<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>诚信标准管理</title>
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
		<li><a href="${ctx}/wlpt/integrity/integrityStandard/">诚信标准列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/integrity/integrityStandard/form?id=${integrityStandard.id}">诚信标准<shiro:hasPermission name="wlpt:integrity:integrityStandard:edit">${not empty integrityStandard.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:integrity:integrityStandard:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="integrityStandard" action="${ctx}/wlpt/integrity/integrityStandard/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">会员类型：</label>
			<div class="controls">
				<form:select path="membertype" class="input-xlarge ">
					<form:options items="${fns:getDictList('userRole')}" itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
				
				
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">类型名称：</label>
			<div class="controls">
				<form:select path="typename" class="input-xlarge ">
					<form:options items="${fns:getDictList('userRole')}" itemLabel="label" itemValue="label" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">优先级：</label>
			<div class="controls">
				<form:input path="priority" htmlEscape="false" maxlength="2" class="input-xlarge "/>
				
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否排斥：</label>
			<div class="controls">
				<form:input path="exclude" htmlEscape="false" maxlength="2" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">标准值：</label>
			<div class="controls">
				<form:input path="standardvalue" htmlEscape="false" maxlength="16" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:integrity:integrityStandard:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>