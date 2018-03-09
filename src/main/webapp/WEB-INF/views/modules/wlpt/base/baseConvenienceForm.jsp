<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>便民服务管理</title>
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
		<li><a href="${ctx}/wlpt/base/baseConvenience/">便民服务列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/base/baseConvenience/form?id=${baseConvenience.id}">便民服务<shiro:hasPermission name="wlpt:base:baseConvenience:edit">${not empty baseConvenience.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:base:baseConvenience:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="baseConvenience" action="${ctx}/wlpt/base/baseConvenience/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">所属类别：</label>
			<div class="controls">
				<select name="categoryId" id="categoryId"  data-placeholder="请选择类别" style="vertical-align:top;width: 180px;">
						<c:forEach items="${baseCategories}" var="category">
							<option value="${category.id}" <c:if test="${category.id == baseConvenience.categoryId}">selected</c:if>>${category.name}</option>
						</c:forEach>
				</select>
			</div>
		</div>		
		<div class="control-group">
			<label class="control-label">服务标题：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="768" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">服务链接：</label>
			<div class="controls">
				<form:input path="link" htmlEscape="false" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">服务描述：</label>
			<div class="controls">
				<form:input path="description" htmlEscape="false" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">图标：</label>
			<div class="controls">
				<form:hidden id="picture" path="picture" htmlEscape="false" maxlength="3072" class="input-xlarge"/>
				<sys:ckfinder input="picture" type="files" uploadPath="/convenience" selectMultiple="true"/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:base:baseConvenience:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>