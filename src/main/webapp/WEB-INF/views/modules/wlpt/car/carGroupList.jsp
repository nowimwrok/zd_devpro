<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>车队管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(document).ready(
			function() {
				$("#btnExport").click(
						function() {
							top.$.jBox.confirm("确认要导出车队数据吗？", "系统提示", function(
									v, h, f) {
								if (v == "ok") {
									$("#searchForm").attr("action",
											"${ctx}/wlpt/car/group/export");
									$("#searchForm").submit();
								}
							}, {
								buttonsFocus : 1
							});
							top.$('.jbox-body .jbox-icon').css('top', '55px');
						});
				$("#btnSubmit").click(
						function() {
							$("#searchForm").attr("action",
									"${ctx}/wlpt/car/group/list");
							$("#searchForm").submit();
						});
			});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").attr("action", "${ctx}/wlpt/car/group/list");
		$("#searchForm").submit();
		return false;
	}
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/wlpt/car/group/">车队列表</a></li>
		<li><a href="${ctx}/wlpt/car/group/detail">车辆详情</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="carGroup"
		action="${ctx}/wlpt/car/group/list" method="post"
		class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<ul class="ul-form">
			<li><label>用户Id：</label> <sys:treeselect id="user"
					name="car.user.id" value="${car.user.id}" labelName="user.name"
					labelValue="${car.user.name}" title="用户"
					url="/sys/office/treeData?type=3" cssClass="input-small"
					allowClear="true" notAllowSelectParent="true" /></li>
			<li><label>车主姓名：</label> <form:input path="car.ownername"
					htmlEscape="false" maxlength="20" class="input-medium" /></li>
			<li><label>登录名：</label> <form:input path="car.user.loginName"
					htmlEscape="false" maxlength="20" class="input-medium" /></li>
			<li><label>车主手机：</label> <form:input path="car.ownermobile"
					htmlEscape="false" maxlength="20" class="input-medium" /></li>
			<li><label>车主身份证：</label> <form:input path="car.owneridcardnum"
					htmlEscape="false" maxlength="30" class="input-medium" /></li>
			<li class="btns" style="float: right;"><input id="btnSubmit"
				class="btn btn-primary" type="button" value="查询" /><a
				class="btn btn-primary" href="${ctx}/wlpt/car/group/">重置</a> <input
				id="btnExport" class="btn btn-primary" type="button" value="导出" /></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}" />
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>序号</th>
				<th>登录名</th>
				<th>用户名</th>
				<th>车主</th>
				<th>手机号码</th>
				<th>角色名称</th>
				<th>公司名称</th>
				<th>车辆数量</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="group" varStatus="status_">
				<tr>
					<td>${status_.index+1 }</td>
					<td><a
						href="${ctx}/wlpt/car/group/detail?id=${group.car.user.id}">${group.car.user.loginName}</a>
					</td>
					<td>${group.car.user.name}</td>
					<td>${group.car.ownername}</td>
					<td>${group.car.ownermobile}</td>
					<td>${group.car.user.role.name}</td>
					<td>${group.car.user.company.name}</td>
					<td>${group.groupsize}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>