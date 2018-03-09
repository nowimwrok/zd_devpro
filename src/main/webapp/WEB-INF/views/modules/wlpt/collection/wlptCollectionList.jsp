<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>我的关注管理</title>
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
		<li class="active"><a href="${ctx}/wlpt/collection/wlptCollection/">我的关注列表</a></li>
		<shiro:hasPermission name="wlpt:collection:wlptCollection:edit"><li><a href="${ctx}/wlpt/collection/wlptCollection/form">我的关注添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="wlptCollection" action="${ctx}/wlpt/collection/wlptCollection/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>用户Id：</label>
				<form:input path="user.id" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>关注目标类型:0：车源，1：货源，2：招标：</label>
				<form:input path="targettype" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>始发省：</label>
				<form:input path="fromprovince" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>始发市：</label>
				<form:input path="fromcity" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>目的省：</label>
				<form:input path="toprovince" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>目的市：</label>
				<form:input path="tocity" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>create_by：</label>
				<form:input path="createBy.id" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>用户Id</th>
				<th>关注目标类型:0：车源，1：货源，2：招标</th>
				<th>始发省</th>
				<th>始发市</th>
				<th>目的省</th>
				<th>目的市</th>
				<th>create_by</th>
				<th>update_date</th>
				<th>remarks</th>
				<shiro:hasPermission name="wlpt:collection:wlptCollection:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="wlptCollection">
			<tr>
				<td><a href="${ctx}/wlpt/collection/wlptCollection/form?id=${wlptCollection.id}">
					${wlptCollection.user.id}
				</a></td>
				<td>
					${wlptCollection.targettype}
				</td>
				<td>
					${wlptCollection.fromprovince}
				</td>
				<td>
					${wlptCollection.fromcity}
				</td>
				<td>
					${wlptCollection.toprovince}
				</td>
				<td>
					${wlptCollection.tocity}
				</td>
				<td>
					${wlptCollection.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${wlptCollection.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${wlptCollection.remarks}
				</td>
				<shiro:hasPermission name="wlpt:collection:wlptCollection:edit"><td>
    				<a href="${ctx}/wlpt/collection/wlptCollection/form?id=${wlptCollection.id}">修改</a>
					<a href="${ctx}/wlpt/collection/wlptCollection/delete?id=${wlptCollection.id}" onclick="return confirmx('确认要删除该我的关注吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>