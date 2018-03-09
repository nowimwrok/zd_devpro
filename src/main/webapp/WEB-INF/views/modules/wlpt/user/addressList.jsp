<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>保存地址管理</title>
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
		<li class="active"><a href="${ctx}/wlpt/user/address/">保存地址列表</a></li>
		<shiro:hasPermission name="wlpt:user:address:edit"><li><a href="${ctx}/wlpt/user/address/form">保存地址添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="address" action="${ctx}/wlpt/user/address/" method="post" class="breadcrumb form-search">
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
				<th>省市区</th>
				<th>详细地址</th>
				<th>联系人</th>
				<th>手机</th>
				<th>公司</th>
				<th>电话</th>
				<th>emial</th>
				<th>更新时间</th>
				<th>备注</th>
				<shiro:hasPermission name="wlpt:user:address:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="address">
			<tr>
				<td><a href="${ctx}/wlpt/user/address/form?id=${address.id}">
					${address.province}${address.city}${address.district}
				</a></td>
				<td><a href="${ctx}/wlpt/user/address/form?id=${address.id}">
					${address.address}
				</a></td>
				<td><a href="${ctx}/wlpt/user/address/form?id=${address.id}">
					${address.linkman}
				</a></td>
				<td><a href="${ctx}/wlpt/user/address/form?id=${address.id}">
					${address.linkmobile}
				</a></td>
				<td><a href="${ctx}/wlpt/user/address/form?id=${address.id}">
					${address.linkcompany}
				</a></td>
				<td><a href="${ctx}/wlpt/user/address/form?id=${address.id}">
					${address.linktelphone}
				</a></td>
				<td><a href="${ctx}/wlpt/user/address/form?id=${address.id}">
					${address.linkemail}
				</a></td>
				<td><a href="${ctx}/wlpt/user/address/form?id=${address.id}">
					<fmt:formatDate value="${address.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${address.remarks}
				</td>
				<shiro:hasPermission name="wlpt:user:address:edit"><td>
    				<a href="${ctx}/wlpt/user/address/form?id=${address.id}">修改</a>
					<a href="${ctx}/wlpt/user/address/delete?id=${address.id}" onclick="return confirmx('确认要删除该保存地址吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>