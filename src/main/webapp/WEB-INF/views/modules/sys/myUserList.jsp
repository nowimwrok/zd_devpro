<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>子账户管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	function page(n, s) {
		if (n)
			$("#pageNo").val(n);
		if (s)
			$("#pageSize").val(s);
		$("#searchForm").attr("action", "${ctx}/sys/user/myUserlist");
		$("#searchForm").submit();
		return false;
	}
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/user/myUserlist">子账户列表</a></li>
		<shiro:hasPermission name="sys:user:edit">
			<li><a href="${ctx}/sys/user/myUserform">子账户添加</a></li>
		</shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="user"
		action="${ctx}/sys/user/myUserlist" method="post"
		class="breadcrumb form-search ">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}"
			callback="page();" />
		<ul class="ul-form">

			<li><label>登录名：</label>
			<form:input path="loginName" htmlEscape="false" maxlength="50"
					class="input-medium" /></li>
			<li><label>姓&nbsp;&nbsp;&nbsp;名：</label>
			<form:input path="name" htmlEscape="false" maxlength="50"
					class="input-medium" /></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary"
				type="submit" value="查询" onclick="return page();" /></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}" />
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>归属公司</th>
				<th>归属部门</th>
				<th class="sort-column login_name">登录名</th>
				<th class="sort-column name">姓名</th>
				<th>手机</th>
				<th>电话</th>
				<%--<th>角色</th> --%>
				<shiro:hasPermission name="sys:user:edit">
					<th>操作</th>
				</shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="user">
				<tr>
					<td>${user.company.name}</td>
					<td>${user.office.name}</td>
					<td>${user.loginName}<%-- <a href="${ctx}/sys/user/form?id=${user.id}"></a> --%></td>
					<td>${user.name}</td>
					<td>${user.phone}</td>
					<td>${user.mobile}</td>
					<%--
				<td>${user.roleNames}</td> --%>
					<shiro:hasPermission name="sys:user:edit">
						<td>
							<%-- <a href="${ctx}/sys/user/form?id=${user.id}">修改</a> --%> <a
							href="${ctx}/sys/user/deleteMyuser?id=${user.id}"
							onclick="return confirmx('确认要删除该用户吗？', this.href)">删除</a>
						</td>
					</shiro:hasPermission>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>