<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>运单管理</title>
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
		<li><a href="${ctx}/wlpt/trade/orderinfo/">运单列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/trade/orderinfo/form?id=${orderinfo.id}">运单<shiro:hasPermission name="wlpt:trade:orderinfo:edit">${not empty orderinfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="wlpt:trade:orderinfo:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="orderinfo" action="${ctx}/wlpt/trade/orderinfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">报价ID,外键：</label>
			<div class="controls">
				<form:input path="quoteinfo.id" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">车队：</label>
			<div class="controls">
				<sys:treeselect id="buyer" name="buyer.id" value="${orderinfo.buyer.id}" labelName="" labelValue="${orderinfo.buyer.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">货主：</label>
			<div class="controls">
				<sys:treeselect id="seller" name="seller.id" value="${orderinfo.seller.id}" labelName="" labelValue="${orderinfo.seller.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">运单号：</label>
			<div class="controls">
				<form:input path="orderno" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">运单状态：</label>
			<div class="controls">
				<form:select path="orderstatus" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('order_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否评价：</label>
			<div class="controls">
				<form:select path="iscomment" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('iscomment')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
			<label class="control-label">是否线上支付:0线下,1线上支付：</label>
			<div class="controls">
				<form:select path="isonlinepay" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('order_isonlinepay')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否预支付:0不预支付,1预支付：</label>
			<div class="controls">
				<form:select path="isprepay" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('order_isprepay')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">－1:免运费0:未支付1：暂扣费2:已支付到司机3:已返款：</label>
			<div class="controls">
				<form:select path="paystatus" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('order_paystatus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">支付方式:0余额支付，1.结算卡,2授信支付，2免运费：</label>
			<div class="controls">
				<form:select path="payway" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('order_payway')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否打印回执单：</label>
			<div class="controls">
				<form:radiobuttons path="isprint" items="${fns:getDictList('order_isprint')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否发起争议：0，1：</label>
			<div class="controls">
				<form:radiobuttons path="isdispute" items="${fns:getDictList('order_isdispute')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否开启定位：</label>
			<div class="controls">
				<form:radiobuttons path="islocated" items="${fns:getDictList('order_location')}" itemLabel="label" itemValue="value" htmlEscape="false" class=""/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">支付流水ID&mdash;&mdash;外键：</label>
			<div class="controls">
				<form:input path="payinfo.id" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="wlpt:trade:orderinfo:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>