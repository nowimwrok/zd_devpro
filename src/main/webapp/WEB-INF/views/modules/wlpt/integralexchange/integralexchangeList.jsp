<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>积分规则管理</title>
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
		<li class="active"><a href="${ctx}/wlpt/integralexchange/list">积分规则列表</a></li>
		<li><a href="${ctx}/wlpt/integralexchange/form">积分规则添加</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="integralexchange" action="${ctx}/wlpt/integralexchange/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<!-- <ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul> -->
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
			    <th>兑换类型</th>
			    <th>兑换比例</th>
				<th>更新时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="integralexchange">
			<tr>
				<td>${integralexchange.exchangetype}</td>
				<td>${integralexchange.exchangerate}</td>
				<td><a href="${ctx}/wlpt/integralexchange/form?id=${integralexchange.id}">
					<fmt:formatDate value="${integralexchange.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
    				<a href="${ctx}/wlpt/integralexchange/form?id=${integralexchange.id}">修改</a>
					<a href="${ctx}/wlpt/integralexchange/delete?id=${integralexchange.id}" onclick="return confirmx('确认要删除该积分规则吗？', this.href)">删除</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>