<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>交易信息管理</title>
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
		<li><a href="${ctx}/wlpt/consume/consumerecod/list">交易信息列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/consume/consumerecod/form?id=${consumerecod.id}">交易信息<shiro:hasPermission name="wlpt:consume:consumerecod:edit">${not empty consumerecod.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:consume:consumerecod:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="consumerecod" action="${ctx}/wlpt/consume/consumerecod/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">资金流出账户ID：</label>
			<div class="controls">
				<form:input path="account.id" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">目标用户:资金流入账户：</label>
			<div class="controls">
				<form:input path="target.id" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">运单ID,如果是运单业务：</label>
			<div class="controls">
				<form:input path="orderinfo.id" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">交易编号：</label>
			<div class="controls">
				<form:input path="consumecode" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">第三方支付交易流水号：</label>
			<div class="controls">
				<form:input path="paycode" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">交易类型：0:后台充值1:支付宝充值2:微信充值3:结算支付4:结算提现5:冻结线上支付运费6:支付预支付运费7：收到预支付运费8:支付余款运费9:收到余款运费10:冻结运费返款11:运费退费12:油气返现13:余额提现14:保证金提现：</label>
			<div class="controls">
				<form:select path="consumetype" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('consumerecode_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">交易方式：</label>
			<div class="controls">
				<form:select path="consumeway" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('consumerecode_way')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">交易描述：</label>
			<div class="controls">
				<form:textarea path="consumewaydesp" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">交易状态：0:交易中1:交易成功2:交易失败：</label>
			<div class="controls">
				<form:select path="consumestatus" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('consume_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">浏览方式：0:后台导入1平台2 安卓3 微信4 苹果：</label>
			<div class="controls">
				<form:input path="scantype" htmlEscape="false" maxlength="11" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">消费金额：</label>
			<div class="controls">
				<form:input path="consumemony" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">消费前金额：</label>
			<div class="controls">
				<form:input path="beforemony" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">消费后金额：</label>
			<div class="controls">
				<form:input path="aftermony" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="64" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">sysaccount_id：</label>
			<div class="controls">
				<form:input path="sysaccount.id" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:consume:consumerecod:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>