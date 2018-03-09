<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>支付信息管理</title>
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
		<li class="active"><a href="${ctx}/wlpt/trade/tradePayinfo/">支付信息列表</a></li>
		<shiro:hasPermission name="wlpt:trade:tradePayinfo:edit"><li><a href="${ctx}/wlpt/trade/tradePayinfo/form">支付信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="tradePayinfo" action="${ctx}/wlpt/trade/tradePayinfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>运单ID：</label>
				<form:input path="orderinfo.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>支付状态：</label>
				<form:select path="paystatus" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('order_paystatus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>总运费：</label>
				<form:input path="totalcost" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>线上支付金额：</label>
				<form:input path="onlineamount" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>线下支付金额：</label>
				<form:input path="lineamount" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>线上支付比例：</label>
				<form:input path="onlineratio" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>预支付比例：</label>
				<form:input path="preraio" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>线上预支付金额：</label>
				<form:input path="preamount" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>线上支付余款：</label>
				<form:input path="onlinebalance" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>争议金额：</label>
				<form:input path="disputeamount" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>实际支付金额：</label>
				<form:input path="actualamount" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>删除标识：</label>
				<form:radiobuttons path="delFlag" items="${fns:getDictList('del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>运单ID</th>
				<th>支付状态</th>
				<th>总运费</th>
				<th>线上支付金额</th>
				<th>线下支付金额</th>
				<th>线上支付比例</th>
				<th>预支付比例</th>
				<th>线上预支付金额</th>
				<th>线上支付余款</th>
				<th>争议金额</th>
				<th>实际支付金额</th>
				<th>创建时间</th>
				<th>更新者</th>
				<th>修改时间</th>
				<th>更新人</th>
				<shiro:hasPermission name="wlpt:trade:tradePayinfo:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="tradePayinfo">
			<tr>
				<td><a href="${ctx}/wlpt/trade/tradePayinfo/form?id=${tradePayinfo.id}">
					${tradePayinfo.orderinfo.id}
				</a></td>
				<td>
					${fns:getDictLabel(tradePayinfo.paystatus, 'order_paystatus', '')}
				</td>
				<td>
					${tradePayinfo.totalcost}
				</td>
				<td>
					${tradePayinfo.onlineamount}
				</td>
				<td>
					${tradePayinfo.lineamount}
				</td>
				<td>
					${tradePayinfo.onlineratio}
				</td>
				<td>
					${tradePayinfo.preraio}
				</td>
				<td>
					${tradePayinfo.preamount}
				</td>
				<td>
					${tradePayinfo.onlinebalance}
				</td>
				<td>
					${tradePayinfo.disputeamount}
				</td>
				<td>
					${tradePayinfo.actualamount}
				</td>
				<td>
					<fmt:formatDate value="${tradePayinfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${tradePayinfo.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${tradePayinfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${tradePayinfo.updateBy.id}
				</td>
				<shiro:hasPermission name="wlpt:trade:tradePayinfo:edit"><td>
    				<a href="${ctx}/wlpt/trade/tradePayinfo/form?id=${tradePayinfo.id}">修改</a>
					<a href="${ctx}/wlpt/trade/tradePayinfo/delete?id=${tradePayinfo.id}" onclick="return confirmx('确认要删除该支付信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>