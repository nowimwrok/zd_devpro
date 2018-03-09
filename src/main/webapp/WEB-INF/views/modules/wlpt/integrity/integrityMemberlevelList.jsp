<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>诚信会员等级管理</title>
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
		<li class="active"><a href="${ctx}/wlpt/integrity/integrityMemberlevel/">诚信会员等级列表</a></li>
		<shiro:hasPermission name="wlpt:integrity:integrityMemberlevel:edit"><li><a href="${ctx}/wlpt/integrity/integrityMemberlevel/form">诚信会员等级添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="integrityMemberlevel" action="${ctx}/wlpt/integrity/integrityMemberlevel/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>会员类型</th>
				<th>会员等级</th>
				<th>等级标准</th>
				<th>标准值</th>
				<th>描述</th>
				<th>更新时间</th>
				<shiro:hasPermission name="wlpt:integrity:integrityMemberlevel:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="integrityMemberlevel">
			<tr>
				<td>
					${fns:getDictLabel(integrityMemberlevel.membertype, 'userRole', '')}
				</td>
				<td>
					${integrityMemberlevel.memberlevel}
				</td>
				<td>
					${fns:getDictLabel(integrityMemberlevel.integritycode, 'integrity_standard', '')}
				</td>
				<td>
					${integrityMemberlevel.standardvalue}
				</td>
				<td>
					${integrityMemberlevel.standarddescribe}
				</td>
				<td>
					<fmt:formatDate value="${integrityMemberlevel.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="wlpt:integrity:integrityMemberlevel:edit">
					<td>
    					<a href="${ctx}/wlpt/integrity/integrityMemberlevel/form?id=${integrityMemberlevel.id}">修改</a>
						<a href="${ctx}/wlpt/integrity/integrityMemberlevel/delete?id=${integrityMemberlevel.id}" onclick="return confirmx('确认要删除该诚信会员等级吗？', this.href)">删除</a>
					</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>