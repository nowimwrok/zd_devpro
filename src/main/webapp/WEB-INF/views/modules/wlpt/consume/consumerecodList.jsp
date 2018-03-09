<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>交易信息管理</title>
<meta name="decorator" content="default" />
<style type="text/css">
th, td {
	text-align: center !important;
}
</style>
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$("#btnReset")
								.click(
										function() {
											$("#j_user").val('');
											$("#j_id").val('');
											$("#j_accou").val('');
											$(".select2-choice").html("");
											$("#j_type").val('');
											$("#j_way").val('');
											$("#j_status").val('');
											$("#j_time").val('');
											$("#j_money").val('');
											$("#c_time").val('');
											location.href = "${ctx}/wlpt/consume/consumerecod/list?tabPageId=jerichotabiframe_62";
										});
						$("#btnExport")
						.click(
								function() {
									top.$.jBox
											.confirm(
													"确认要导出流水数据吗？",
													"系统提示",
													function(v, h, f) {
														if (v == "ok") {
															$(
																	"#searchForm")
																	.attr(
																			"action",
																			"${ctx}/wlpt/consume/consumerecod/consumeRecodExport");
															$(
																	"#searchForm")
																	.submit();
														}
													},
													{
														buttonsFocus : 1
													});
									top.$('.jbox-body .jbox-icon').css(
											'top', '55px');
								});
						$("#btnSubmit")
						.click(
								function() {
									$("#searchForm")
											.attr("action",
													"${ctx}/wlpt/consume/consumerecod/list");
									$("#searchForm").submit();
								});
					});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm")
		.attr("action",
				"${ctx}/wlpt/consume/consumerecod/list");
		$("#searchForm").submit();
		return false;
	}
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active">交易信息列表</li>
	</ul>
	<form:form id="searchForm" modelAttribute="consumerecod"
		action="${ctx}/wlpt/consume/consumerecod/list?tabPageId=jerichotabiframe_62"
		method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<ul class="ul-form">
			<li><label>交易编号：</label> <form:input path="consumecode"
					id="j_accou" htmlEscape="false" maxlength="64" class="input-medium" />
			</li>
			<li><label>流出账户：</label> <form:input path="account.loginName" title="用户登录名或者手机号码"
					id="j_id" htmlEscape="false" maxlength="64" class="input-medium" /></li>
			<li><label>流入用户：</label> <form:input path="target.loginName" title="用户登录名或者手机号码"
					id="j_user" htmlEscape="false" maxlength="64" class="input-medium" />
			</li>
			<li><label>交易类型：</label> <form:select path="consumetype"
					id="j_type" class="input-medium">
					<form:option value="" label="" />
					<form:options items="${fns:getDictList('consumerecode_type')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select></li>
			<li>&nbsp;&nbsp;&nbsp;&nbsp;<label>交易方式：</label> <form:select
					path="consumeway" id="j_way" class="input-medium">
					<form:option value="" label="" />
					<form:options items="${fns:getDictList('consumerecode_way')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</li>

			<li>&nbsp;&nbsp;&nbsp;<label>交易状态：</label> <form:select
					path="consumestatus" id="j_status" class="input-medium">
					<form:option value="" label="" />
					<form:options items="${fns:getDictList('consume_status')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</li>

			<li><label>交易金额：</label> <form:input path="consumemony"
					id="j_money" htmlEscape="false" class="input-medium" /></li>
			<li><label>交易时间：</label> <input name="beginCreateDate" title="开始时间"
				id="c_time" type="text" readonly="readonly" maxlength="20"
				class="input-medium Wdate"
				value="<fmt:formatDate value="${consumerecod.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" />
				-- <input name="endCreateDate" type="text" id="j_time" title="结束时间"
				readonly="readonly" maxlength="20" class="input-medium Wdate"
				value="<fmt:formatDate value="${consumerecod.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" />
			</li>
			<li class="btns" style="float: right;"><input id="btnSubmit"
				class="btn btn-primary" type="button" value="查询" /><input
				type="button" id="btnReset" class="btn btn-primary" value="重置" />
				<input
				type="button" id="btnExport" class="btn btn-primary" value="导出" /></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}" />
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th colspan="3" class="center" style="vertical-align: middle;">用户信息</th>
				<th colspan="3" class="center" style="vertical-align: middle;">交易信息</th>
				<th colspan="3" class="center" style="vertical-align: middle;">金额信息</th>
				<th colspan="2" class="center" style="vertical-align: middle;">时间信息</th>
				<th rowspan="" class="center" style="vertical-align: middle;">交易描述</th>
			</tr>
			<tr>

				<th>交易编号</th>
				<th>流出账户</th>
				<th>流入账户</th>
				<th>交易类型</th>
				<th>交易方式</th>
				<!-- <th>交易描述</th> -->
				<th>交易状态</th>
				<th>交易金额</th>
				<th>交易前金额</th>
				<th>交易后金额</th>
				<th>交易时间</th>
				<th>更新时间</th>
				<th>明细</th>
				<%-- <shiro:hasPermission name="wlpt:consume:consumerecod:edit">
            <th>操作</th>
        </shiro:hasPermission> --%>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="consumerecod">
				<tr>
					<td>${consumerecod.consumecode}</td>
					<td>${consumerecod.account.loginName}</td>
					<td>${consumerecod.target.loginName}</td>
					<td>${fns:getDictLabel(consumerecod.consumetype, 'consumerecode_type', '')}
					</td>
					<td>${fns:getDictLabel(consumerecod.consumeway, 'consumerecode_way', '')}
					</td>
					<%-- <td>
                    ${consumerecod.consumewaydesp}
            </td> --%>
					<td>${fns:getDictLabel(consumerecod.consumestatus, 'consume_status', '')}
					</td>
					<td>${consumerecod.consumemony}</td>
					<td>${consumerecod.beforemony}</td>
					<td>${consumerecod.aftermony}</td>
					<td><fmt:formatDate value="${consumerecod.createDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td><fmt:formatDate value="${consumerecod.updateDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>${consumerecod.remarks}</td>
					<%--  <shiro:hasPermission name="wlpt:consume:consumerecod:edit">
                <td>
                    <a href="${ctx}/wlpt/consume/consumerecod/form?id=${consumerecod.id}">修改</a>
                    <a href="${ctx}/wlpt/consume/consumerecod/delete?id=${consumerecod.id}"
                       onclick="return confirmx('确认要删除该交易信息吗？', this.href)">删除</a>
                </td>
            </shiro:hasPermission> --%>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>