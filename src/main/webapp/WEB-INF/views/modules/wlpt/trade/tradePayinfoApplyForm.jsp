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
		<li><a href="${ctx}/wlpt/trade/tradePayinfo/orderPayApplylist">运单尾款支付审核列表</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="orderinfo" action="${ctx}/wlpt/trade/tradePayinfo/orderPayapplyinfo" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">运单号：</label>
			<div class="controls">
				${orderinfo.orderno }
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">尾款支付状态：</label>
			<div class="controls">
			${fns:getDictLabel(orderinfo.orderispay, 'order_ispay', '')}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">总运费：</label>
			<div class="controls">
				${orderinfo.totalcost}元
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">本次放款金额：</label>
			<div class="controls">
				${orderinfo.payinfo.actualamount}元
			</div>
		</div>

		<div class="form-actions">
			<shiro:hasPermission name="wlpt:trade:orderinfo:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="确定放款"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>