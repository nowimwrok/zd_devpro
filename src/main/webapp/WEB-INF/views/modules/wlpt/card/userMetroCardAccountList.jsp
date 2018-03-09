<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>用户一卡通消费统计管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(document)
			.ready(
					function() {
						$("#btnExport")
								.click(
										function() {
											top.$.jBox
													.confirm(
															"确认要导出用户一卡通消费统计信息数据吗？",
															"系统提示",
															function(v, h, f) {
																if (v == "ok") {
																	$(
																			"#searchForm")
																			.attr(
																					"action",
																					"${ctx}/wlpt/card/userMetroCardRecord/cardAccountExport");
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
															"${ctx}/wlpt/card/userMetroCardRecord/listAccount");
											$("#searchForm").submit();
										});
					});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").attr("action",
				"${ctx}/wlpt/card/userMetroCardRecord/listAccount");
		$("#searchForm").submit();
		return false;
	}
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a
			href="${ctx}/wlpt/card/userMetroCardRecord/">用户一卡通消费列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="accountUserMetroCard"
		action="${ctx}/wlpt/card/userMetroCardRecord/listAccount"
		method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<ul class="ul-form">

			<li style="margin-left: -25px;"><label>搜索关键字：</label> <form:input
					path="searchinfo" htmlEscape="false" maxlength="32"
					placeholder="用户名/手机号/卡号/工号" class="input-medium" /></li>
			<li><label>交易时间(开始)：</label> <input name="beginOperateDate"
				type="text" readonly="readonly" maxlength="20"
				class="input-medium Wdate"
				value="<fmt:formatDate value="${accountUserMetroCard.beginOperateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" />
				(结束)：<input name="endOperateDate" type="text" readonly="readonly"
				maxlength="20" class="input-medium Wdate"
				value="<fmt:formatDate value="${accountUserMetroCard.endOperateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" />
			</li>

			<li class="btns"><input id="btnSubmit" class="btn btn-primary"
				type="button" value="查询" /> <!-- <input
				type="button" id="btnReset" class="btn btn-primary" value="重置" />  -->
				<input id="btnExport" class="btn btn-primary" type="button"
				value="导出" /></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}" />
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>卡号</th>
				<th>所属用户</th>
				<th>会员姓名</th>
				<th>付应金额</th>
				<th>实付金额</th>
				<th>现金支付</th>
				<th>储值支付</th>
				<th>积分支付</th>
				<th>获得积分</th>
				<th>工号</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="accountUserMetroCard">
				<tr>
					<td>${accountUserMetroCard.cardid}</td>
					<td>${accountUserMetroCard.user.loginName}</td>
					<td>${accountUserMetroCard.truename}</td>
					<td>${accountUserMetroCard.totalmoneyAccount}</td>
					<td>${accountUserMetroCard.totalpaidAccount}</td>
					<td>${accountUserMetroCard.paidmoneyAccount}</td>
					<td>${accountUserMetroCard.paidvalueAccount}</td>
					<td>${accountUserMetroCard.paidpointAccount}</td>
					<td>${accountUserMetroCard.pointAccount}</td>
					<td>${accountUserMetroCard.useraccount}</td>

				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>