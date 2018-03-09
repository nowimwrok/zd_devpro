<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>一卡通消费记录明细管理</title>
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
		<li class="active"><a href="${ctx}/wlpt/card/userMetroCardRecorditem/">一卡通消费记录明细列表</a></li>
		<shiro:hasPermission name="wlpt:card:userMetroCardRecorditem:edit"><li><a href="${ctx}/wlpt/card/userMetroCardRecorditem/form">一卡通消费记录明细添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="userMetroCardRecorditem" action="${ctx}/wlpt/card/userMetroCardRecorditem/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			
			<li><label>商品编码：</label>
				<form:input path="barcode" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>商品名称：</label>
				<form:input path="gooditemname" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				
				<th>商品编码</th>
				<th>商品名称</th>
				<th>明细总金额</th>
				<th>商品数量</th>
				<th>商品原价</th>
				<th>实付金额</th>
				<th>折扣</th>
				<th>获得积分</th>
				<th>备注</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="userMetroCardRecorditem">
			<tr>
				<td>
					${userMetroCardRecorditem.barcode}
				</td>
				<td>
					${userMetroCardRecorditem.gooditemname}
				</td>
				<td>
					${userMetroCardRecorditem.totalmoney}
				</td>
				<td>
					${userMetroCardRecorditem.number}
				</td>
				<td>
					${userMetroCardRecorditem.oldprice}
				</td>
				<td>
					${userMetroCardRecorditem.paidmoney}
				</td>
				<td>
					${userMetroCardRecorditem.discount}
				</td>
				<td>
					${userMetroCardRecorditem.point}
				</td>
				<td>
					${userMetroCardRecorditem.meno}
				</td>
				
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>