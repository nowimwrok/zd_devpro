<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>一卡通挂失信息管理</title>
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
		<li class="active"><a href="${ctx}/wlpt/card/userMetroCardLoss/">一卡通挂失信息列表</a></li>
		<%-- <shiro:hasPermission name="wlpt:card:userMetroCardLoss:edit"><li><a href="${ctx}/wlpt/card/userMetroCardLoss/form">一卡通挂失信息添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="userMetroCardLoss"
		action="${ctx}/wlpt/card/userMetroCardLoss/" method="post"
		class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<ul class="ul-form">
			<li style="margin-left: -25px;"><label>搜索关键字：</label> <form:input
					path="searchinfo" htmlEscape="false" maxlength="32"
					placeholder="用户名/手机号/卡号" class="input-medium" /></li>
			<li><label>申请时间(开始)：</label> <input name="beginCreateDate"
				type="text" readonly="readonly" maxlength="20"
				class="input-medium Wdate"
				value="<fmt:formatDate value="${userMetroCardLoss.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" />
				(结束)：<input name="endCreateDate" type="text" readonly="readonly"
				maxlength="20" class="input-medium Wdate"
				value="<fmt:formatDate value="${userMetroCardLoss.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" />
			</li>

			<li><label>状态:</label> <form:select path="status"
					class="input-medium">
					<form:option value="" label="" />
					<form:option value="" label="" />
					<form:options items="${fns:getDictList('metroloss_status')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select></li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary"
				type="submit" value="查询" /></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}" />
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>卡号</th>
				<th>用户名</th>
				<th>角色</th>
				<th>手机号码</th>
				<th>状态</th>
				<th>申请时间</th>
				<th>处理人</th>
				<th>更新时间</th>
				<th>一卡通工号</th>
				<th>一卡通电话</th>
				<shiro:hasPermission name="wlpt:card:userMetroCardLoss:edit">
					<th>操作</th>
				</shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="userMetroCardLoss">
				<tr>
					<td><a
						href="${ctx}/wlpt/card/userMetroCardLoss/form?id=${userMetroCardLoss.id}">
							${userMetroCardLoss.cardid} </a></td>
					<td>${userMetroCardLoss.user.loginName}</td>
					<td>${userMetroCardLoss.user.role.name}</td>
					<td>${userMetroCardLoss.user.phone}</td>
					<td>${fns:getDictLabel(userMetroCardLoss.status, 'metroloss_status', '')}
					</td>
					<td><fmt:formatDate value="${userMetroCardLoss.createDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td><c:if
							test="${userMetroCardLoss.createDate!=userMetroCardLoss.updateDate}">${userMetroCardLoss.updateBy.loginName}</c:if></td>
					<td><fmt:formatDate value="${userMetroCardLoss.updateDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>${userMetroCardLoss.useraccount}</td>
					<td>${userMetroCardLoss.mobile}</td>
					<shiro:hasPermission name="wlpt:card:userMetroCardLoss:edit">
						<td><a
							href="${ctx}/wlpt/card/userMetroCardLoss/form?id=${userMetroCardLoss.id}">修改</a>
							<%-- <a
							href="${ctx}/wlpt/card/userMetroCardLoss/delete?id=${userMetroCardLoss.id}"
							onclick="return confirmx('确认要删除该一卡通挂失信息吗？', this.href)">删除</a> --%></td>
					</shiro:hasPermission>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>