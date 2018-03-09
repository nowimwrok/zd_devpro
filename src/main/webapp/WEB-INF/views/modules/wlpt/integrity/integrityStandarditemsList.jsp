<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>诚信标准评分项管理</title>
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
		<li class="active"><a href="${ctx}/wlpt/integrity/integrityStandarditems/">诚信标准评分项列表</a></li>
		<shiro:hasPermission name="wlpt:integrity:integrityStandarditems:edit"><li><a href="${ctx}/wlpt/integrity/integrityStandarditems/form">诚信标准评分项添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="integrityStandarditems" action="${ctx}/wlpt/integrity/integrityStandarditems/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>评分项：</label>
				<form:input path="scoreitem" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			
			<li><label>评分标准：</label>
				<form:select path="integritycode" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('integrity_standard')}" itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</li>
			<li><label>是否必填：</label>
				<form:select path="isrequired" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('yesorno')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>标准类型</th>
				<th>评分项</th>
				<th>评分标准</th>
				<th>评分方式</th>
				<th>评分值</th>
				<th>所得积分</th>
				<th>是否必填</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="wlpt:integrity:integrityStandarditems:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="integrityStandarditems">
			<tr>
				<td><a href="${ctx}/wlpt/integrity/integrityStandarditems/form?id=${integrityStandarditems.id}">
					${integrityStandarditems.standard.typename}
				</a></td>
				<td>
					${integrityStandarditems.scoreitem}
				</td>
				<td>
					${fns:getDictLabel(integrityStandarditems.integritycode, 'integrity_standard', '')}
				</td>
				<td>
					${fns:getDictLabel(integrityStandarditems.scoreway, 'integrity_scoreway', '')}
				</td>
				<td>
					${integrityStandarditems.scorevalue}
				</td>
				<td>
					${integrityStandarditems.integral}
				</td>
				<td>
					${fns:getDictLabel(integrityStandarditems.isrequired, 'yesorno', '')}
				</td>
				<td>
					<fmt:formatDate value="${integrityStandarditems.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${integrityStandarditems.remarks}
				</td>
				<shiro:hasPermission name="wlpt:integrity:integrityStandarditems:edit"><td>
    				<a href="${ctx}/wlpt/integrity/integrityStandarditems/form?id=${integrityStandarditems.id}">修改</a>
					<a href="${ctx}/wlpt/integrity/integrityStandarditems/delete?id=${integrityStandarditems.id}" onclick="return confirmx('确认要删除该诚信标准评分项吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>