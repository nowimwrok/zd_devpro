<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>消息日志管理</title>
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
		<li class="active"><a href="${ctx}/sms/sendlog/list">消息日志列表</a></li>
		<%-- <shiro:hasPermission name="sms:smssendlog:edit"><li><a href="${ctx}/sms/sendlog/form">消息日志添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="sendLog" action="${ctx}/sms/sendlog/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		
		<ul class="ul-form">
			<li><label>手机号码：</label>
				<form:input path="mobiles" htmlEscape="false" maxlength="256" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<!-- <th>模块</th> -->
				<th>功能</th>
				<th>手机号码</th>
				<th>短信内容</th>
				<th>发送时间</th>
				<shiro:hasPermission name="sms:smssendlog:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="sendLog">
			<tr>
				<%-- <td>
						${sendLog.module}
				</td> --%>
				<td>
						${sendLog.function}
				</td>
				<td><a href="${ctx}/sms/sendlog/form?id=${sendLog.id}">
					${sendLog.mobiles}
				</a></td>
				<td>
						${sendLog.smsContent}
				</td>
				<td>
						${sendLog.sendTime}
				</td>


				<shiro:hasPermission name="sms:smssendlog:edit"><td>
    				<a href="${ctx}/sms/sendlog/form?id=${sendLog.id}">修改</a>
					<a href="${ctx}/sms/sendlog/delete?id=${sendLog.id}" onclick="return confirmx('确认要删除该消息日志吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>