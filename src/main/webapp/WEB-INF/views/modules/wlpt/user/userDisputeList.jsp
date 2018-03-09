<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>争议信息管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(document).ready(function() {

	});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
	}
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/wlpt/user/userDispute/">争议信息列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="userDispute"
		action="${ctx}/wlpt/user/userDispute/" method="post"
		class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<ul class="ul-form">
			<li style="margin-left: -25px;"><label>争议订单号：</label> <form:input
					path="orderno" htmlEscape="false" maxlength="32"
					class="input-medium" /></li>
			<li><label>发起时间(开始)：</label> <input name="begincreateDate"
				type="text" readonly="readonly" maxlength="20"
				class="input-medium Wdate"
				value="<fmt:formatDate value="${userDispute.begincreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" />
				-(结束)：<input name="endcreateDate" type="text" readonly="readonly"
				maxlength="20" class="input-medium Wdate"
				value="<fmt:formatDate value="${userDispute.endcreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" />
			</li>


			<li><label>处理状态:</label> <form:select path="status"
					class="input-medium">
					<form:option value="" label="" />
					<form:options items="${fns:getDictList('dispute_status')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select></li>
			<li class="btns" style="float: right;"><input id="btnSubmit"
				class="btn btn-primary" type="submit" value="查询" /><input
				id="btnReset" class="btn btn-primary" type="reset" value="重置" /></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}" />
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>争议订单号</th>
				<th>运单状态</th>
				<th>运单运费</th>
				<th>支付类型</th>
				<th>发起人</th>
				<th>争议说明</th>
				<th>发起时间</th>
				<th>运单生成时间</th>
				<th>处理人</th>
				<th>争议前实际支付金额</th>
				<th>争议后实际支付金额</th>
				<th>争议金额</th>
				<th>争议类型</th>
				<th>处理状态</th>
				<th>司机同意</th>
				<th>是否驳回</th>
				<th>更新时间</th>
				<shiro:hasPermission name="wlpt:user:userDispute:edit">
					<th>操作</th>
				</shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="userDispute">
				<tr>
					<td><a
						href="${ctx}/wlpt/user/userDispute/form?id=${userDispute.id}">
							${userDispute.orderno} </a></td>
					<td>${fns:getDictLabel(userDispute.orderinfo.orderstatus, 'order_status', '')}</td>
					<td>${userDispute.orderinfo.totalcost}</td>
					<td>${fns:getDictLabel(userDispute.orderinfo.payway, 'order_payway', '')}</td>
					<td>${userDispute.dealuser.loginName}</td>
					<td>${userDispute.disputeinfo}</td>

					<td><fmt:formatDate value="${userDispute.createDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td><fmt:formatDate
							value="${userDispute.orderinfo.createDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>${userDispute.dealname}</td>

					<td>${userDispute.disputemoneybefore}</td>					
					<td>${userDispute.disputemoneydiff}</td>
					<td>${userDispute.disputemoney}</td>
					<td>${fns:getDictLabel(userDispute.disputetype, 'disputetype', '')}
					<td>${fns:getDictLabel(userDispute.status, 'dispute_status', '')}
					</td>
					<td><c:if
							test="${userDispute.disputeeverconfirmed=='0'&&userDispute.isreject=='0'}">待司机同意</c:if>
						<c:if test="${userDispute.disputeeverconfirmed=='1'}">同意</c:if> <c:if
							test="${userDispute.disputeeverconfirmed=='0'&&userDispute.isreject==''}">司机不同意</c:if>
					</td>
					<td><c:if test="${userDispute.isreject=='0'}">否</c:if> <c:if
							test="${userDispute.isreject=='1'}">驳回争议</c:if></td>
					<td><fmt:formatDate value="${userDispute.updateDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>

					<shiro:hasPermission name="wlpt:user:userDispute:edit">
						<td><a
							href="${ctx}/wlpt/user/userDispute/form?id=${userDispute.id}">处理</a>
							<%-- <a
							href="${ctx}/wlpt/user/userDispute/delete?id=${userDispute.id}"
							onclick="return confirmx('确认要删除该争议信息吗？', this.href)">删除</a> --%></td>
					</shiro:hasPermission>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>