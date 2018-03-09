<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>流失报表</title>
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
					<form:option value="" label="全部" />
					<form:options items="${fns:getDictList('consumerecode_type')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select></li>
			<li><label>交易模块：</label> <form:select
					path="trademodel" class="input-medium">
				<form:option value="" label="全部" />
				<form:options items="${fns:getDictList('consumerecode_model')}"
							  itemLabel="label" itemValue="value" htmlEscape="false" />
			</form:select>
			</li>
			<li><label>交易方式：</label> <form:select
					path="consumeway" id="j_way" class="input-medium">
					<form:option value="" label="全部" />
					<form:options items="${fns:getDictList('consumerecode_way')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</li>

			<li><label>交易状态：</label> <form:select
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
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" />
				-- <input name="endCreateDate" type="text" id="j_time" title="结束时间"
				readonly="readonly" maxlength="20" class="input-medium Wdate"
				value="<fmt:formatDate value="${consumerecod.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" />
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
				<th colspan="5" class="center" style="vertical-align: middle;">用户信息</th>
				<th colspan="4" class="center" style="vertical-align: middle;">交易信息</th>
				<th colspan="3" class="center" style="vertical-align: middle;">金额信息</th>
				<th colspan="2" class="center" style="vertical-align: middle;">时间信息</th>
				<th colspan="2" class="center" style="vertical-align: middle;">其他</th>
			</tr>
			<tr>

				<th>交易编号</th>
				<th>业务帐户</th>
				<th>业务手机</th>
				<th>目标账户</th>
				<th>目标手机</th>

				<th>交易模块</th>
				<th>交易类型</th>
				<th>交易方式</th>
				<th>交易状态</th>

				<th>交易前金额</th>
				<th>交易金额</th>
				<th>交易后金额</th>
				<th>交易时间</th>
				<th>更新时间</th>
				<th>交易描述</th>
				<th>运单号</th>
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
					<td>${consumerecod.account.phone}</td>

					<td>${consumerecod.target.loginName}</td>
					<td>${consumerecod.target.phone}</td>

					<td>${fns:getDictLabel(consumerecod.trademodel, 'consumerecode_model', '')}

					<td>${fns:getDictLabel(consumerecod.consumetype, 'consumerecode_type', '')}
					</td>
					<td>${fns:getDictLabel(consumerecod.consumeway, 'consumerecode_way', '')}
					</td>
					<td>${fns:getDictLabel(consumerecod.consumestatus, 'consume_status', '')}
					</td>

					<td>${consumerecod.beforemony}</td>
					<td>${consumerecod.consumemony}</td>
					<td>${consumerecod.aftermony}</td>
					<td><fmt:formatDate value="${consumerecod.createDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td><fmt:formatDate value="${consumerecod.updateDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>${consumerecod.consumewaydesp}</td>
					<td>${consumerecod.orderinfo.orderno}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>