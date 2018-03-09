<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>常用联系人管理</title>
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
		<li class="active"><a href="${ctx}/wlpt/contacts/userCommonContacts/">常用联系人列表</a></li>
		<shiro:hasPermission name="wlpt:contacts:userCommonContacts:edit"><li><a href="${ctx}/wlpt/contacts/userCommonContacts/form">常用联系人添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="userCommonContacts" action="${ctx}/wlpt/contacts/userCommonContacts/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>所属用户id：</label>
				<sys:treeselect id="user" name="user.id" value="${userCommonContacts.user.id}" labelName="user.name" labelValue="${userCommonContacts.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>目标id：</label>
				<sys:treeselect id="targetId" name="targetId" value="${userCommonContacts.targetId}" labelName="" labelValue="${userCommonContacts.}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>目标类型：</label>
				<form:input path="targetType" htmlEscape="false" maxlength="2" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>所属用户id</th>
				<th>目标id</th>
				<th>目标类型</th>
				<th>更新时间</th>
				<th>保险公司介绍</th>
				<shiro:hasPermission name="wlpt:contacts:userCommonContacts:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="userCommonContacts">
			<tr>
				<td><a href="${ctx}/wlpt/contacts/userCommonContacts/form?id=${userCommonContacts.id}">
					${userCommonContacts.user.name}
				</a></td>
				<td>
					${userCommonContacts.}
				</td>
				<td>
					${userCommonContacts.targetType}
				</td>
				<td>
					<fmt:formatDate value="${userCommonContacts.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${userCommonContacts.remarks}
				</td>
				<shiro:hasPermission name="wlpt:contacts:userCommonContacts:edit"><td>
    				<a href="${ctx}/wlpt/contacts/userCommonContacts/form?id=${userCommonContacts.id}">修改</a>
					<a href="${ctx}/wlpt/contacts/userCommonContacts/delete?id=${userCommonContacts.id}" onclick="return confirmx('确认要删除该常用联系人吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>