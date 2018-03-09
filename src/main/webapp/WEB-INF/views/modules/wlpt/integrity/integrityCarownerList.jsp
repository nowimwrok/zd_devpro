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
				$("#pass").val('');
				location.href="${ctx}/wlpt/integrity/integrityCarowner/list?tabPageId=jerichotabiframe_65";
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
		<li class="active"><a href="${ctx}/wlpt/integrity/integrityCarowner/">诚信信息列表</a></li>
		<shiro:hasPermission name="wlpt:integrity:integrityCarowner:edit"><li><a href="${ctx}/wlpt/integrity/integrityCarowner/form">诚信信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="integrityCarowner" action="${ctx}/wlpt/integrity/integrityCarowner/list?tabPageId=jerichotabiframe_65" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>车主姓名：</label>
				<form:input path="name" id="name" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>联系方式：</label>
				<form:input path="linkphone" id="link" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>车牌号：</label>
				<form:input path="carnumber" id="pass" htmlEscape="false" maxlength="10" class="input-medium"/>
			</li>
			<li class="btns" style="float:right;"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/><input type="button" value="重置" id="btnReset" class="btn btn-primary"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>车主姓名</th>
				<th>联系方式</th>
				<th>车牌号</th>
				<th>更新时间</th>
				<th>创建时间</th>
				<th>更新时间</th>
				<th>备注</th>
				<shiro:hasPermission name="wlpt:integrity:integrityCarowner:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="integrityCarowner">
			<tr>
				<td><a href="${ctx}/wlpt/integrity/integrityCarowner/form?id=${integrityCarowner.id}">
					${integrityCarowner.name}
				</a></td>
				<td>
					${integrityCarowner.linkphone}
				</td>
				<td>
					${integrityCarowner.carnumber}
				</td>
				<td>
					<fmt:formatDate value="${integrityCarowner.updatetime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${integrityCarowner.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${integrityCarowner.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${integrityCarowner.remarks}
				</td>
				<shiro:hasPermission name="wlpt:integrity:integrityCarowner:edit"><td>
    				<a href="${ctx}/wlpt/integrity/integrityCarowner/form?id=${integrityCarowner.id}">修改</a>
					<a href="${ctx}/wlpt/integrity/integrityCarowner/delete?id=${integrityCarowner.id}" onclick="return confirmx('确认要删除该诚信信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>