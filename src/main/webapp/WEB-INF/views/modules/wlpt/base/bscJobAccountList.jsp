<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>轮询任务数据管理管理</title>
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
		<li class="active"><a href="${ctx}/wlpt/base/bscJobAccount/">轮询任务数据管理列表</a></li>
		<shiro:hasPermission name="wlpt:base:bscJobAccount:edit"><li><a href="${ctx}/wlpt/base/bscJobAccount/form">轮询任务数据管理添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bscJobAccount" action="${ctx}/wlpt/base/bscJobAccount/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>类型：</label>
				<form:input path="type" htmlEscape="false" maxlength="2" class="input-medium"/>
			</li>
			<li><label>目标数据：</label>
				<form:input path="targetid" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>返回的业务结算单号：</label>
				<form:input path="tradesettlementid" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>状态：</label>
				<form:input path="status" htmlEscape="false" maxlength="2" class="input-medium"/>
			</li>
			<li><label>所属用户id：</label>
				<form:input path="userid" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>类型</th>
				<th>目标数据</th>
				<th>业务结算单号</th>
				<th>状态</th>
				<th>所属用户</th>
				<th>创建时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="wlpt:base:bscJobAccount:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bscJobAccount">
			<tr>
				<td><a href="${ctx}/wlpt/base/bscJobAccount/form?id=${bscJobAccount.id}">
					${bscJobAccount.type}
				</a></td>
				<td>
					${bscJobAccount.targetid}
				</td>
				<td>
					${bscJobAccount.tradesettlementid}
				</td>
				<td>
					${bscJobAccount.status}
				</td>
				<td>
					${bscJobAccount.userid}
				</td>
				<td>
					<fmt:formatDate value="${bscJobAccount.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${bscJobAccount.remarks}
				</td>
				<shiro:hasPermission name="wlpt:base:bscJobAccount:edit"><td>
    				<a href="${ctx}/wlpt/base/bscJobAccount/form?id=${bscJobAccount.id}">修改</a>
					<a href="${ctx}/wlpt/base/bscJobAccount/delete?id=${bscJobAccount.id}" onclick="return confirmx('确认要删除该轮询任务数据管理吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>