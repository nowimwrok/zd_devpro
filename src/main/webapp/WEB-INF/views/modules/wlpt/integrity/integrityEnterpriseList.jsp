<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>诚信信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnReset").click(function(){
				$("#name").val('');
				$("#link").val(''); 
				$("#e_name").val('');
				location.href="${ctx}/wlpt/integrity/integrityEnterprise/list?tabPageId=jerichotabiframe_67";
			});
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
		<li class="active"><a href="${ctx}/wlpt/integrity/integrityEnterprise/">诚信信息列表</a></li>
		<shiro:hasPermission name="wlpt:integrity:integrityEnterprise:edit"><li><a href="${ctx}/wlpt/integrity/integrityEnterprise/form">诚信信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="integrityEnterprise" action="${ctx}/wlpt/integrity/integrityEnterprise/list?tabPageId=jerichotabiframe_67" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>企业法人的姓名：</label>
				<form:input path="name" id="name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>公司联系方式：</label>
				<form:input path="linkphone" id="link" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>公司名称：</label>
				<form:input path="companyname" id="e_name" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li class="btns" style="float:right;"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/><input type="button" value="重置" id="btnReset" class="btn btn-primary"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>企业法人的姓名</th>
				<th>公司联系方式</th>
				<th>公司名称</th>
				<th>更新时间</th>
				<th>备注</th>
				<shiro:hasPermission name="wlpt:integrity:integrityEnterprise:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="integrityEnterprise">
			<tr>
				<td><a href="${ctx}/wlpt/integrity/integrityEnterprise/form?id=${integrityEnterprise.id}">
					${integrityEnterprise.name}
				</a></td>
				<td>
					${integrityEnterprise.linkphone}
				</td>
				<td>
					${integrityEnterprise.companyname}
				</td>
				<td>
					<fmt:formatDate value="${integrityEnterprise.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${integrityEnterprise.remarks}
				</td>
				<shiro:hasPermission name="wlpt:integrity:integrityEnterprise:edit"><td>
    				<a href="${ctx}/wlpt/integrity/integrityEnterprise/form?id=${integrityEnterprise.id}">修改</a>
					<a href="${ctx}/wlpt/integrity/integrityEnterprise/delete?id=${integrityEnterprise.id}" onclick="return confirmx('确认要删除该诚信信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>