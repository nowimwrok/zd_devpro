<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>意见反馈管理</title>
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
		<li><a href="${ctx}/wlpt/base/baseFeedback/">意见反馈列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/base/baseFeedback/form?id=${baseFeedback.feedbackId}">意见反馈<shiro:hasPermission name="wlpt:base:baseFeedback:edit">${not empty baseFeedback.feedbackId?'应答':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:base:baseFeedback:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="baseFeedback" action="${ctx}/wlpt/base/baseFeedback/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">反馈内容：</label>
			<div class="controls">
				<form:textarea path="content" htmlEscape="false" rows="4" maxlength="255"  class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">反馈用户手机：</label>
			<div class="controls">
				<form:input path="phone" htmlEscape="false" maxlength="11"  class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">反馈时间：</label>
			<div class="controls">
				<input name="createtime" type="text"  maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${baseFeedback.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">应答内容：</label>
			<div class="controls">
				<form:textarea path="responsecontent" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">反馈系统：</label>
			<div class="controls">
				<select name="scantype" id="scantype" data-placeholder="请选择类别" style="vertical-align:top;width: 180px;">
					<option value="1" <c:if test="${baseFeedback.scantype == '1'}">selected</c:if>>物流平台</option>
					<option value="2" <c:if test="${baseFeedback.scantype == '2'}">selected</c:if>>Android</option>
					<option value="3" <c:if test="${baseFeedback.scantype == '3'}">selected</c:if>>WebChat</option>
					<option value="4" <c:if test="${baseFeedback.scantype == '4'}">selected</c:if>>IOS</option>
				</select>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:base:baseFeedback:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>