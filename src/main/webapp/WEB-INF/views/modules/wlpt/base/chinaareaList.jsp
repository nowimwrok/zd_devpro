<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>中国地址管理</title>
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
		<li class="active"><a href="${ctx}/wlpt/base/chinaarea/">中国地址列表</a></li>
		<shiro:hasPermission name="wlpt:base:chinaarea:edit"><li><a href="${ctx}/wlpt/base/chinaarea/form">中国地址添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="chinaarea" action="${ctx}/wlpt/base/chinaarea/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>name：</label>
				<form:input path="name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>name</th>
				<shiro:hasPermission name="wlpt:base:chinaarea:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="chinaarea">
			<tr>
				<td><a href="${ctx}/wlpt/base/chinaarea/form?id=${chinaarea.id}">
					${chinaarea.name}
				</a></td>
				<shiro:hasPermission name="wlpt:base:chinaarea:edit"><td>
    				<a href="${ctx}/wlpt/base/chinaarea/form?id=${chinaarea.id}">修改</a>
					<a href="${ctx}/wlpt/base/chinaarea/delete?id=${chinaarea.id}" onclick="return confirmx('确认要删除该中国地址吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>