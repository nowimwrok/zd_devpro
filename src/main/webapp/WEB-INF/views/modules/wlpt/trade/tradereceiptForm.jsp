<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>运单证明管理</title>
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
		<li><a href="${ctx}/wlpt/trade/tradeReceipt/">运单证明列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/trade/tradeReceipt/form?id=${tradeReceipt.id}">运单证明<shiro:hasPermission name="wlpt:trade:tradeReceipt:edit">${not empty tradeReceipt.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:trade:tradeReceipt:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="tradeReceipt" action="${ctx}/wlpt/trade/tradeReceipt/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">订单Id：</label>
			<div class="controls">
				<form:input path="orderinfo.id" htmlEscape="false" maxlength="32" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">回单图片名称：</label>
			<div class="controls">
				<form:hidden id="receiptimg" path="receiptimg" htmlEscape="false" maxlength="70" class="input-xlarge"/>
				<sys:ckfinder input="receiptimg" type="files" uploadPath="/wlpt/trade/tradeReceipt" selectMultiple="true"/>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">载重 吨位：</label>
			<div class="controls">
				<form:input path="oddloadweight" htmlEscape="false" maxlength="16" class="input-xlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:trade:tradeReceipt:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>