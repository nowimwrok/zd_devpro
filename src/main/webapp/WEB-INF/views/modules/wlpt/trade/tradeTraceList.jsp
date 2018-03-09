<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>操作记录管理</title>
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
		<li class="active"><a href="${ctx}/wlpt/trade/tradeTrace/">操作记录列表</a></li>
		<shiro:hasPermission name="wlpt:trade:tradeTrace:edit"><li><a href="${ctx}/wlpt/trade/tradeTrace/form">操作记录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="tradeTrace" action="${ctx}/wlpt/trade/tradeTrace/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>订单Id：</label>
				<form:input path="orderinfo.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>标题:：</label>
				<form:input path="title" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>类型：0:运单状态，2:支付状态，3运单运输：</label>
				<form:select path="type" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('order_tracetype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>变化的状态值：</label>
				<form:select path="status" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('order_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>操作日志内容：</label>
				<form:input path="content" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>remarks：</label>
				<form:input path="remarks" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>create_date：</label>
				<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${tradeTrace.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${tradeTrace.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>create_by：</label>
				<form:input path="createBy.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>订单Id</th>
				<th>标题:</th>
				<th>类型：0:运单状态，2:支付状态，3运单运输</th>
				<th>变化的状态值</th>
				<th>操作日志内容</th>
				<th>remarks</th>
				<th>create_date</th>
				<th>create_by</th>
				<shiro:hasPermission name="wlpt:trade:tradeTrace:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="tradeTrace">
			<tr>
				<td><a href="${ctx}/wlpt/trade/tradeTrace/form?id=${tradeTrace.id}">
					${tradeTrace.orderinfo.id}
				</a></td>
				<td>
					${tradeTrace.title}
				</td>
				<td>
					${fns:getDictLabel(tradeTrace.type, 'order_tracetype', '')}
				</td>
				<td>
					${fns:getDictLabel(tradeTrace.status, 'order_status', '')}
				</td>
				<td>
					${tradeTrace.content}
				</td>
				<td>
					${tradeTrace.remarks}
				</td>
				<td>
					<fmt:formatDate value="${tradeTrace.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${tradeTrace.createBy.id}
				</td>
				<shiro:hasPermission name="wlpt:trade:tradeTrace:edit"><td>
    				<a href="${ctx}/wlpt/trade/tradeTrace/form?id=${tradeTrace.id}">修改</a>
					<a href="${ctx}/wlpt/trade/tradeTrace/delete?id=${tradeTrace.id}" onclick="return confirmx('确认要删除该操作记录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>