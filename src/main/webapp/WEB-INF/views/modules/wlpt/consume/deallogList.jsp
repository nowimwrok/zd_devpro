<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>处理日志管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnReset").click(function(){
				$("#add_id").val('');
				$("#add_m").val('');
				 $(".select2-choice").html(""); 
				$("#c_start").val('');
				$("#c_end").val('');
				$("#j_status").val('');
				location.href="${ctx}/wlpt/consume/deallog/";
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
		<li class="active"><a href="${ctx}/wlpt/consume/deallog/">处理日志列表</a></li>
		<%--<shiro:hasPermission name="wlpt:consume:deallog:edit"><li><a href="${ctx}/wlpt/consume/deallog/form">处理日志添加</a></li></shiro:hasPermission>--%>
	</ul>
	<form:form id="searchForm" modelAttribute="deallog" action="${ctx}/wlpt/consume/deallog/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>关键字：</label> <form:input path="searchinfo"
                                            htmlEscape="false" maxlength="50" class="input-medium"
                                            placeholder="用户名/交易编号"/></li>
			<li><label>处理时间(开始)：</label>
				<input name="beginCreateDate" id="c_start" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${deallog.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/> -(结束)： 
				<input name="endCreateDate" type="text" id="c_end" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${deallog.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</li>
			<li><label>后台充值：</label>
				<form:select path="dealtype" id="add_m" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('consumeaudit_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>交易记录：</label>
				<form:select path="consumeaudit.auditstatus" id="add_id" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('consumeaudit_status')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns" style="float:right;"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/><input type="button" id="btnReset" value="重置" class="btn btn-primary"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>处理用户</th>
				<th>处理时间</th>
				<th>充值类型</th>
				<th>处理状态</th>
				<th>交易编号</th>
				<th>交易金额</th>
				<th>备注</th>
				<shiro:hasPermission name="wlpt:consume:deallog:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="deallog">
			<tr>
				<td><a href="${ctx}/wlpt/consume/deallog/form?id=${deallog.id}">
					${deallog.createBy.loginName}
				</a></td>
				<td>
					<fmt:formatDate value="${deallog.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${fns:getDictLabel(deallog.dealtype, 'consumeaudit_type', '')}
				</td>
				<td>
					${fns:getDictLabel(deallog.consumeaudit.auditstatus, 'consumeaudit_status', '')}
				</td>
				<td>
					${deallog.consumeaudit.consume.consumecode}
				</td>
				<td>
					${deallog.consumeaudit.consume.consumemony}
				</td>
				<td>
					${deallog.remarks}
				</td>
				<shiro:hasPermission name="wlpt:consume:deallog:edit"><td>
    				<a href="${ctx}/wlpt/consume/deallog/form?id=${deallog.id}">修改</a>
					<a href="${ctx}/wlpt/consume/deallog/delete?id=${deallog.id}" onclick="return confirmx('确认要删除该处理日志吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>