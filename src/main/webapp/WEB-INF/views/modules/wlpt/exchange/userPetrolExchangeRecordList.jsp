<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>油气兑换余额关系记录管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/wlpt/exchange/userPetrolExchangeRecord/">油气兑换余额关系记录列表</a></li>
		<shiro:hasPermission name="wlpt:exchange:userPetrolExchangeRecord:edit"><li><a href="${ctx}/wlpt/exchange/userPetrolExchangeRecord/form">油气兑换余额关系记录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="userPetrolExchangeRecord" action="${ctx}/wlpt/exchange/userPetrolExchangeRecord/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>油气兑换关系id：</label>
				<form:input path="id" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>兑换号：</label>
				<form:input path="exchangeNo" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>明细号：</label>
				<form:input path="recorditemid" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>记录状态：</label>
				<form:input path="status" htmlEscape="false" maxlength="1" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>油气兑换关系id</th>
				<th>兑换号</th>
				<th>明细号</th>
				<th>记录状态</th>
				<shiro:hasPermission name="wlpt:exchange:userPetrolExchangeRecord:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="userPetrolExchangeRecord">
			<tr>
				<td><a href="${ctx}/wlpt/exchange/userPetrolExchangeRecord/form?id=${userPetrolExchangeRecord.id}">
					${userPetrolExchangeRecord.id}
				</a></td>
				<td>
					${userPetrolExchangeRecord.exchangeNo}
				</td>
				<td>
					${userPetrolExchangeRecord.recorditemid}
				</td>
				<td>
					${userPetrolExchangeRecord.status}
				</td>
				<shiro:hasPermission name="wlpt:exchange:userPetrolExchangeRecord:edit"><td>
    				<a href="${ctx}/wlpt/exchange/userPetrolExchangeRecord/form?id=${userPetrolExchangeRecord.id}">修改</a>
					<a href="${ctx}/wlpt/exchange/userPetrolExchangeRecord/delete?id=${userPetrolExchangeRecord.id}" onclick="return confirmx('确认要删除该油气兑换余额关系记录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>