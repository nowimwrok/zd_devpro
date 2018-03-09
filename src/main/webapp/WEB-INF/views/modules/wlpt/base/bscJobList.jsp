<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>任务管理</title>
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
		<li class="active"><a href="${ctx}/wlpt/bscJob/">任务列表</a></li>
		<shiro:hasPermission name="wlpt:bscJob:edit"><li><a href="${ctx}/wlpt/bscJob/form">任务添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bscJob" action="${ctx}/wlpt/bscJob/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>任务说明：</label>
				<form:input path="jobdescription" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>是否启用：</label>
				<form:input path="isenable" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>任务执行代码</th>
				<th>任务类型</th>
				<th>任务类</th>
				<th>执行方式</th>
				<th>每月的哪天</th>
				<th>周几</th>
				<th>小时</th>
				<th>分钟</th>
				<th>间隔小时</th>
				<th>间隔分钟</th>
				<th>任务间隔单位</th>
				<th>规则表达式</th>
				<th>任务说明</th>
				<th>是否启用</th>
				<th>是否做日志记录</th>
				<shiro:hasPermission name="wlpt:bscJob:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bscJob">
			<tr>
				<td>
					${bscJob.jobcode}
				</td>
				<td>
					${fns:getDictLabel(bscJob.jobtype, 'jobtype', '')}
				</td>
				<td>
					${bscJob.jobclass}
				</td>
				<td>
					${fns:getDictLabel(bscJob.execycle, 'execycle', '')}
				</td>
				<td>
					${bscJob.dayOfMonth}
				</td>
				<td>
					${bscJob.dayOfWeek}
				</td>
				<td>
					${bscJob.hour}
				</td>
				<td>
					${bscJob.minute}
				</td>
				<td>
					${bscJob.intervalhour}
				</td>
				<td>
					${bscJob.intervalminute}
				</td>
				<td>
					${fns:getDictLabel(bscJob.jobIntervalUnit, 'jobIntervalUnit', '')}
				</td>
				<td>
					${bscJob.cronexpression}
				</td>
				<td>
					${bscJob.jobdescription}
				</td>
				<td>
					${fns:getDictLabel(bscJob.isenable, 'yes_no', '')}
				</td>
				<td>
					${fns:getDictLabel(bscJob.islog, 'yes_no', '')}
				</td>
				<shiro:hasPermission name="wlpt:bscJob:edit"><td>
    				<a href="${ctx}/wlpt/bscJob/form?id=${bscJob.id}">修改</a>
    				<a href="${ctx}/wlpt/bscJob/delete?id=${bscJob.id}" onclick="return confirmx('确认要删除该任务吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>