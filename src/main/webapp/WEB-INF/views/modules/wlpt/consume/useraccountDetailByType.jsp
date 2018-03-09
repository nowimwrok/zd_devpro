<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>用户个人交易流水详情</title>
<meta name="decorator" content="default" />
<style type="text/css">
td, th {
	text-align: center !important;
}
</style>
<script type="text/javascript">
$(document)
.ready(
		function() {
			/* $("#btnReset")
					.click(
							function() {
								$("#j_time").val('');
								$("#c_time").val('');
								location.href = "${ctx}/wlpt/consume/useraccount/detailByway?id=${userid}&consumeway=${consumeway}&tradeType=${tradeType}";
							}); */
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
																"${ctx}/wlpt/consume/consumerecod/consumeRecodExportByType?trademodel=${trademodel}&tradeType=${tradeType}");
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
										"${ctx}/wlpt/consume/useraccount/detailByType?trademodel=${trademodel}&tradeType=${tradeType}");
						$("#searchForm").submit();
					});
		});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm")
		.attr("action",
				"${ctx}/wlpt/consume/useraccount/detailByType?trademodel=${trademodel}&tradeType=${tradeType}");
		$("#searchForm").submit();
		return false;
	}
</script>

</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a>个人交易流水信息列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="consumerecod"
		action="${ctx}/wlpt/consume/useraccount/detailByType?trademodel=${trademodel}&tradeType=${tradeType}"
		method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<ul class="ul-form">
			<li><label>流出账户：</label> <form:input path="account.loginName" placeholder="用户登录名或者手机号码"
					id="j_id" htmlEscape="false" maxlength="64" class="input-medium" /></li>
			<li><label>流入用户：</label> <form:input path="target.loginName" placeholder="用户登录名或者手机号码"
					id="j_user" htmlEscape="false" maxlength="64" class="input-medium" />
					
			<li><label>交易时间：</label> <input name="beginCreateDate" placeholder="开始时间"
				id="c_time" type="text" readonly="readonly" maxlength="20"
				class="input-medium Wdate"
				value="<fmt:formatDate value="${consumerecod.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" />
				-- <input name="endCreateDate" type="text" id="j_time" placeholder="结束时间"
				readonly="readonly" maxlength="20" class="input-medium Wdate"
				value="<fmt:formatDate value="${consumerecod.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" />
			</li>
			<li class="btns"><input id="btnSubmit"
				class="btn btn-primary" type="button" value="查询" />
				<!-- <input
				type="button" id="btnReset" class="btn btn-primary" value="重置" /> -->
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
				<th colspan="3" class="center" style="vertical-align: middle;">交易信息</th>
				<th colspan="3" class="center" style="vertical-align: middle;">金额信息</th>
				<th colspan="2" class="center" style="vertical-align: middle;">时间信息</th>
				<th rowspan="" class="center" style="vertical-align: middle;">交易描述</th>
			</tr>
			<tr>

				<th>交易编号</th>
				<th>流出账户登陆名</th>
				<th>流出账户手机号</th>
				<th>流入账户登陆名</th>
				<th>流入账户手机号</th>
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
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>