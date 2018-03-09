<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>政策公告管理</title>
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
		<li><a href="${ctx}/wlpt/base/basePolicy/">政策公告列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/base/basePolicy/form?id=${basePolicy.id}">政策公告<shiro:hasPermission name="wlpt:base:basePolicy:edit">${not empty basePolicy.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:base:basePolicy:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="basePolicy" action="${ctx}/wlpt/base/basePolicy/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">政策标题：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="512" class="input-xlarge required" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">政策分类：</label>
			<div class="controls">
				<!-- <form:input path="categoryId" htmlEscape="false" maxlength="20" class="input-xlarge  digits" /> -->
				<select name="categoryId" id="categoryId" value="${basePolicy.categoryId}" data-placeholder="请选择类别" style="vertical-align:top;width: 180px;">
					<c:forEach items="${baseCategories}" var="category">
						<option value="${category.id}" <c:if test="${category.id == basePolicy.categoryId}">selected</c:if>>${category.name}</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">政策内容：</label>
			<div class="controls">
				<form:textarea path="content" htmlEscape="false" rows="4" class="input-xxlarge "/>
				<sys:ckeditor replace="content" uploadPath="/policy"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">来源：</label>
			<div class="controls">
				<form:input path="source" htmlEscape="false" maxlength="512" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">来源链接：</label>
			<div class="controls">
				<form:input path="sourceLink" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<!--
		<div class="control-group">
			<label class="control-label">图片：</label>
			<div class="controls">
				<form:input path="picture" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">点击量：</label>
			<div class="controls">
				<form:input path="hot" htmlEscape="false" maxlength="20" class="input-xlarge  digits"/>
			</div>
		</div> 
		<div class="control-group">
			<label class="control-label">发布时间：</label>
			<div class="controls">
				<input name="releaseTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${basePolicy.releaseTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		 -->
		<div class="control-group">
			<label class="control-label">关键字：</label>
			<div class="controls">
				<form:input path="keyword" htmlEscape="false" maxlength="512" class="input-xlarge "/>
				<span>(英文的逗号隔开每个关键字)</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">内容摘要：</label>
			<div class="controls">
				<form:textarea path="summary" htmlEscape="false" rows="4" maxlength="200" class="input-xxlarge "/>
			</div>
		</div>
		<!--  
		<div class="control-group">
			<label class="control-label">政策附件：</label>
			<div class="controls">
				<form:input path="attachment" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		-->
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:base:basePolicy:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>