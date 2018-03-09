<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>油气兑换余额审核管理</title>
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
		<li class="active"><a href="${ctx}/wlpt/exchange/userPetrolExchange/">油气兑换余额审核列表</a></li>
		
	</ul>
	<form:form id="searchForm" modelAttribute="userPetrolExchange" action="${ctx}/wlpt/exchange/userPetrolExchange/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			
			<li><label>兑换号：</label>
				<form:input path="exchangeNo" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>兑换明细条数：</label>
				<form:input path="exchangeCount" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>总金额：</label>
				<form:input path="totalcost" htmlEscape="false" class="input-medium"/>
			</li>
			
			<li><label>状态：</label>
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
				<th>兑换号</th>
				<th>手机号</th>
				<th>登陆名</th>
				<th>兑换明细条数</th>
				<th>总金额</th>
				<th>状态</th>
				<th>开票状态</th>
				<th>审核人</th>
				<th>审核时间</th>
				<th>备注</th>
				<shiro:hasPermission name="wlpt:exchange:userPetrolExchange:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="userPetrolExchange">
			<tr>
				<td><a href="${ctx}/wlpt/exchange/userPetrolExchange/form?id=${userPetrolExchange.id}">
					${userPetrolExchange.exchangeNo}
				</a></td>
				<td>
					${userPetrolExchange.user.phone}
				</td>
				<td>
					${userPetrolExchange.user.loginName}
				</td>
				<td>
					${userPetrolExchange.exchangeCount}
				</td>
				<td>
					${userPetrolExchange.totalcost}
				</td>
				
				<td>
					${fns:getDictLabel(userPetrolExchange.status, 'exchange_status', '')}
				</td>
				<td>
					${fns:getDictLabel(userPetrolExchange.invoiceStatus, 'invoice_status', '')}
				</td>
				<td>
					${userPetrolExchange.dealUser.loginName}
				</td>
				<td>
					<fmt:formatDate value="${userPetrolExchange.dealTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${userPetrolExchange.remarks}
				</td>
				<shiro:hasPermission name="wlpt:exchange:userPetrolExchange:edit"><td>
    				<a href="${ctx}/wlpt/exchange/userPetrolExchange/form?id=${userPetrolExchange.id}">审核</a>
    				<c:if test="${userPetrolExchange.invoiceStatus eq 1 }">
    				<a href="${ctx}/wlpt/exchange/userPetrolExchange/editInvoiceStatus?id=${userPetrolExchange.id}&invoiceStatus=2" onclick="return confirmx('确认已收到发票吗？', this.href)">已收发票</a>
					</c:if>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>