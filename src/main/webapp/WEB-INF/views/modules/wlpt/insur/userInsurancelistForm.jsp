<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>保险品种管理</title>
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
		<li><a href="${ctx}/wlpt/insur/userInsurancelist/">保险品种列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/insur/userInsurancelist/form?id=${userInsurancelist.id}">保险品种<shiro:hasPermission name="wlpt:insur:userInsurancelist:edit">${not empty userInsurancelist.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:insur:userInsurancelist:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="userInsurancelist" action="${ctx}/wlpt/insur/userInsurancelist/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">保险名称：</label>
			<div class="controls">
				<form:input path="insurName" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">适用人群：</label>
			<div class="controls">
				<form:input path="suitableCrowd" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">保障期限：</label>
			<div class="controls">
				<form:input path="validityTerm" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">产品特点：</label>
			<div class="controls">
				<form:input path="productFeatures" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">最高赔付金额：</label>
			<div class="controls">
				<form:input path="maxAmount" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">最低赔付金额：</label>
			<div class="controls">
				<form:input path="minAmount" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">支付方式：</label>
			<div class="controls">
				<form:input path="payType" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">卓大直购价：</label>
			<div class="controls">
				<form:input path="insurAmount" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">保障项目：</label>
			<div class="controls">
				<form:input path="insurProject" htmlEscape="false" maxlength="100" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">保障范围：</label>
			<div class="controls">
				<form:textarea path="insurRange" htmlEscape="false" rows="4" maxlength="500" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">官网电话：</label>
			<div class="controls">
				<form:input path="insurPhone" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">保险公司简称：</label>
			<div class="controls">
				<form:input path="insurCompanyname" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">理赔期限：</label>
			<div class="controls">
				<form:input path="claimPeriod" htmlEscape="false" maxlength="20" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">理赔服务：</label>
			<div class="controls">
				<form:input path="claimService" htmlEscape="false" maxlength="1000" class="input-xlarge "/>多个用“|”分隔
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">理赔需知：</label>
			<div class="controls">
				<form:input path="claimNotice" htmlEscape="false" maxlength="500" class="input-xlarge "/>多个用“|”分隔
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">保险附属类型：</label>
			<div class="controls">
				<form:input path="subtype" htmlEscape="false" maxlength="500" class="input-xlarge "/>多个用“|”分隔，必需的为第1个
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">保险条款编号：</label>
			<div class="controls">
				<form:input path="clauseCode" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">保险分类：</label>
			<div class="controls">
				<form:select path="type" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('insuranceType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">保险填写内容种类：</label>
			<div class="controls">
				<form:select path="insuranceway" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('insuranceway')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>用于选择填写页面
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否需测算：</label>
			<div class="controls">
				<form:select path="ismeasure" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('yesorno')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否启用：</label>
			<div class="controls">
			    <form:select path="isenable" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">保险logo：</label>
			<div class="controls">
			    <form:hidden id="insurLogo" path="insurLogo" htmlEscape="false" maxlength="256" class="input-xlarge required"/>
				<sys:ckfinder input="insurLogo" type="images" uploadPath="/insurancelist" selectMultiple="false" maxWidth="200" maxHeight="200"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">保险介绍图：</label>
			<div class="controls">
			    <form:hidden id="insurImg" path="insurImg" htmlEscape="false" maxlength="256" class="input-xlarge required"/>
				<sys:ckfinder input="insurImg" type="images" uploadPath="/insurancelist" selectMultiple="false" maxWidth="200" maxHeight="200"/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">保险公司简介：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="500" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:insur:userInsurancelist:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>