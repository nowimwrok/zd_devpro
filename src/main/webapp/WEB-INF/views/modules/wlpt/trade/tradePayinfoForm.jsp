<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>支付信息管理</title>
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
		<li><a href="${ctx}/wlpt/trade/tradePayinfo/">支付信息列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/trade/tradePayinfo/form?id=${tradePayinfo.id}">支付信息<shiro:hasPermission name="wlpt:trade:tradePayinfo:edit">${not empty tradePayinfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:trade:tradePayinfo:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="tradePayinfo" action="${ctx}/wlpt/trade/tradePayinfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">运单ID：</label>
			<div class="controls">
				<form:input path="orderinfo.id" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">支付状态：</label>
			<div class="controls">
				<form:select path="paystatus" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('order_paystatus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">总运费：</label>
			<div class="controls">
				<form:input path="totalcost" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">线上支付金额：</label>
			<div class="controls">
				<form:input path="onlineamount" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">线下支付金额：</label>
			<div class="controls">
				<form:input path="lineamount" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">线上支付比例：</label>
			<div class="controls">
				<form:input path="onlineratio" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">预支付比例：</label>
			<div class="controls">
				<form:input path="preraio" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">线上预支付金额：</label>
			<div class="controls">
				<form:input path="preamount" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">线上支付余款：</label>
			<div class="controls">
				<form:input path="onlinebalance" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">争议金额：</label>
			<div class="controls">
				<form:input path="disputeamount" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">实际支付金额：</label>
			<div class="controls">
				<form:input path="actualamount" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:trade:tradePayinfo:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>