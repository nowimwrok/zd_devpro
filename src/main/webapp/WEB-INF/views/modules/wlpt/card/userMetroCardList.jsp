<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>用户一卡通管理</title>
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
		<li class="active"><a href="${ctx}/wlpt/card/userMetroCard/">用户一卡通列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="userMetroCard"
		action="${ctx}/wlpt/card/userMetroCard/" method="post"
		class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<ul class="ul-form">
			<li style="margin-left: -25px;"><label>搜索关键字：</label> <form:input
					path="searchinfo" htmlEscape="false" maxlength="32"
					placeholder="用户名/手机号" class="input-medium" /></li>
			<li><label>申请时间(开始)：</label> <input name="beginCreateDate"
				type="text" readonly="readonly" maxlength="20"
				class="input-medium Wdate"
				value="<fmt:formatDate value="${userMetroCard.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" />
				(结束)：<input name="endCreateDate" type="text" readonly="readonly"
				maxlength="20" class="input-medium Wdate"
				value="<fmt:formatDate value="${userMetroCard.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" />
			</li>

			<li><label>状态:</label> <form:select path="status"
					class="input-medium">
					<form:option value="" label="" />
					<form:option value="" label="" />
					<form:options items="${fns:getDictList('metro_status')}"
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
				<th>用户名</th>
				<th>角色</th>
				<th>手机号码</th>
				<th>收货人</th>
				<th>收货人手机</th>
				<th>绑定卡号</th>
				<th>状态</th>
				<th>审核人</th>
				<th>申请时间</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="wlpt:card:userMetroCard:edit">
					<th>操作</th>
				</shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="userMetroCard">
				<tr>
					<td><a
						href="${ctx}/wlpt/card/userMetroCard/form?id=${userMetroCard.id}">
							${userMetroCard.user.loginName} </a></td>
					<td>${userMetroCard.user.role.name}</td>
					<td>${userMetroCard.user.phone}</td>
					<td>${userMetroCard.address.linkman}</td>
					<td>${userMetroCard.address.linkmobile}</td>
					<td>${userMetroCard.cardid}</td>

					<td>${fns:getDictLabel(userMetroCard.status, 'metro_status', '')}
					</td>
					<td><c:if
							test="${userMetroCard.createDate!=userMetroCard.updateDate}">${userMetroCard.updateBy.loginName}</c:if>
					</td>
					<td><fmt:formatDate value="${userMetroCard.createDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td><fmt:formatDate value="${userMetroCard.updateDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>${userMetroCard.remarks}</td>
					<shiro:hasPermission name="wlpt:card:userMetroCard:edit">
						<td><a
							href="${ctx}/wlpt/card/userMetroCard/form?id=${userMetroCard.id}">操作</a>
							<c:if test="${userMetroCard.status=='3'}">
								<a
									href="${ctx}/wlpt/card/userMetroCard/toedit?id=${userMetroCard.id}">更换卡号</a>
							</c:if></td>
					</shiro:hasPermission>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>