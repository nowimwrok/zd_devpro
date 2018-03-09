<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>自定义区域管理</title>
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
		<li class="active"><a href="${ctx}/wlpt/railRegist/">自定义区域列表</a></li>
		<shiro:hasPermission name="customizeregist:railRegist:edit"><li><a href="${ctx}/wlpt/railRegist/form">自定义区域添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="railRegist" action="${ctx}/wlpt/railRegist/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>围栏名称：</label>
				<form:input path="railname" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>围栏名称</th>
				<th>经纬度</th>
				<th>范围</th>
				<th>事件类型</th>
				<th>类型</th>
				<shiro:hasPermission name="customizeregist:railRegist:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="railRegist">
			<tr>
				<td><a href="${ctx}/wlpt/railRegist/form?id=${railRegist.id}">
					${railRegist.railname}
				</a></td>
				<td>
					${railRegist.lonlat}
				</td>
				<td>
					${railRegist.radius}
				</td>
				<td>
					<%-- ${fns:getMsgLabel(railRegist.actionType, 'actionType', '')} --%>
					${fns:getDictLabels(railRegist.actionType, 'actionType', '')}
				</td>
				<td>
					${fns:getDictLabel(railRegist.type, 'type', '')}
				</td>
				<shiro:hasPermission name="customizeregist:railRegist:edit"><td>
					<a href="${ctx}/wlpt/railRegist/delete?id=${railRegist.id}" onclick="return confirmx('确认要删除该自定义区域吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>