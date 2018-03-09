<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>司机信息管理</title>
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
		<li><a href="${ctx}/wlpt/car/driver/">司机信息列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/car/driver/form?id=${driver.id}">司机信息<shiro:hasPermission name="wlpt:car:driver:edit">${not empty driver.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:car:driver:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="driver" action="${ctx}/wlpt/car/driver/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">物流企业Id：</label>
			<div class="controls">
				<sys:treeselect id="user" name="user.id" value="${driver.user.id}" labelName="user.name" labelValue="${driver.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">司机名：</label>
			<div class="controls">
				<form:input path="drivername" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手机号码：</label>
			<div class="controls">
				<form:input path="drivermobile" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">身份证号：</label>
			<div class="controls">
				<form:input path="idcardnum" htmlEscape="false" maxlength="30" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">认证状态：</label>
			<div class="controls">
				<form:input path="status" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否默认：</label>
			<div class="controls">
				<form:input path="isdefault" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">司机头像：</label>
			<div class="controls">
				<form:hidden id="driverheadimg" path="driverheadimg" htmlEscape="false" maxlength="50" class="input-xlarge"/>
				<sys:ckfinder input="driverheadimg" type="files" uploadPath="/wlpt/car/driver" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">驾驶证：</label>
			<div class="controls">
				<form:hidden id="driverlicimg" path="driverlicimg" htmlEscape="false" maxlength="200" class="input-xlarge"/>
				<sys:ckfinder input="driverlicimg" type="files" uploadPath="/wlpt/car/driver" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">身份证图片：</label>
			<div class="controls">
				<form:hidden id="idcardimg" path="idcardimg" htmlEscape="false" maxlength="200" class="input-xlarge"/>
				<sys:ckfinder input="idcardimg" type="files" uploadPath="/wlpt/car/driver" selectMultiple="true"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:car:driver:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>