<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>余额管理</title>
<meta name="decorator" content="default" />
<style>
th, td {
	text-align: center !important;
}

.select2-choice {
	width: 166px;
	text-align: center;
}

#loginName {
	width: 176px !important;
}

#phone {
	width: 176px !important;
}

.active:hover {
	cursor: pointer;
}

#contentTable {
	width: 3100px;
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
											location.href = "${ctx}/wlpt/consume/useraccount/balanceManageList";
										});
					});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").attr("action",
				"${ctx}/wlpt/consume/useraccount/balanceManageList");
		$("#searchForm").submit();
		return false;
	}
	$(document)
			.ready(
					function() {
						$("#btnExport")
								.click(
										function() {
											top.$.jBox
													.confirm(
															"确认要导出账户数据吗？",
															"系统提示",
															function(v, h, f) {
																if (v == "ok") {
																	$(
																			"#searchForm")
																			.attr(
																					"action",
																					"${ctx}/wlpt/consume/useraccount/balanceExport");
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
															"${ctx}/wlpt/consume/useraccount/balanceManageList");
											$("#searchForm").submit();
										});
						$("#btnImport")
								.click(
										function() {
											$
													.jBox(
															$("#importBox")
																	.html(),
															{
																title : "导入数据",
																buttons : {
																	"关闭" : true
																},
																bottomText : "导入文件不能超过5M，仅允许导入“xls”或“xlsx”格式文件！"
															});
										});
					});
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/wlpt/consume/useraccount/">余额管理</a></li>
		<li><a href="${ctx}/wlpt/consume/useraccount/detail"
			title="查看所有交易">交易详情</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="account"
		action="${ctx}/wlpt/consume/useraccount/balanceManageList"
		method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<ul class="ul-form">
			<li><label>用户名：</label> <form:input path="user.loginName"
					id="loginName" /></li>
			<li><label>用户角色：</label> <form:select path="user.role.name">
					<form:option value="" label="全部" />
					<form:option value="车主" label="车主" />
					<form:option value="货主" label="货主" />
					<form:option value="物流企业" label="物流企业" />

				</form:select></li>
			<li><label>手机号码：</label> <form:input path="user.phone"
					id="phone" /></li>
			<li class="btns" style="float: right;"><input id="btnSubmit"
				class="btn btn-primary" type="button" value="查询" /><input
				type="button" id="btnReset" class="btn btn-primary" value="重置" /> <input
				id="btnExport" class="btn btn-primary" type="button" value="导出" />
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}" />
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th rowspan="2" class="center" style="vertical-align: middle">序号</th>
				<th colspan="3" class="center" style="vertical-align: middle">用户信息</th>
				<th colspan="5" class="center ">金额</th>

				<th colspan="2" class="center ">转账（累计）</th>
				<th colspan="6" class="center ">合同结算（累计）</th>
				<th colspan="4" class="center ">运单结算（累计）</th>
				<th colspan="3" class="center ">提现</th>
				<th colspan="2" class="center ">商城</th>
				<th colspan="4" class="center ">其它</th>
			</tr>
			<tr>
				<!-- 账户信息 -->
				<th>用户类型</th>
				<th>用户名</th>
				<th>联系方式</th>
				<!--  账户钱包 -->
				<th>保证金余额</th>
				<th>账户余额</th>
				<th>可用账户余额</th>
				<th>冻结金额</th>

				<th>充值</th>

				<!-- 转帐 -->
				<th>转账收入</th>
				<th>转账支出</th>

				<th>竞标保证金冻结</th>
				<th>竞标保证金缴纳</th>
				<th>竞标保证金退款</th>
				<th>结算支出</th>
				<th>结算收入</th>
				<th>结算提现</th>

				<th>运费冻结</th>
				<!-- <th>运费预付</th>
				<th>运费尾付</th> -->
				<th>运费取消退款</th>
				<th>运费预付</th>
				<th>运费尾款</th>

				<th>提现冻结</th>
				<th>提现驳回退款</th>
				<th>已提现</th>

				<th>消费支出</th>
				<th>销售收入</th>

				<th>保证金冻结</th>
				<th>争议收入</th>
				<th>缴费支出</th>
				<th>缴费收入</th>

			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="account" varStatus="step_status">
				<tr>
					<td>${step_status.index+1 }</td>
					<td>${account.user.role.name }</td>
					<td><a
						href="${ctx}/wlpt/consume/useraccount/detail?id=${account.user.id}"
						target="_self"> ${account.user.loginName} </a></td>
					<td>${account.user.phone}</td>
					<!-- 保证金 -->
					<td>${account.user.userPurse.guaranteemone != null ? account.user.userPurse.guaranteemone:0.0 }</td>
					<!-- 余额 -->
					<td>${account.user.userPurse.webbalance != null ? account.user.userPurse.webbalance:0.0 }</td>
					<!-- 可用余额 -->
					<td>${account.user.userPurse.availablebalance != null ? account.user.userPurse.availablebalance:0.0 }</td>
					<!-- 冻结金额 -->
					<td>${account.user.userPurse.freezemoney != null ? account.user.userPurse.freezemoney:0.0 }</td>
					<!-- 充值 -->
					<td>${account.balanace }</td>

					<!-- 转账 -->
					<!-- 收入 -->
					<td>${account.receivedtransfer }</td>
					<!-- 支出 -->
					<td>${account.accounttransfer }</td>


					<!-- 竞标保证金冻结 -->
					<td>${account.user.userPurse.biddingmoney != null ? account.user.userPurse.biddingmoney:0.0 }</td>
					<!-- 竞标保证金缴纳 -->
					<td>${account.bidingpay }</td>
					<!-- 竞标保证金退款 -->
					<td>${account.bidingreturn }</td>
					<!-- 招标结算 -->
					<!-- 支出 -->
					<td>${account.settlepay }</td>
					<!-- 收入 -->
					<td>${account.getsettle }</td>
					<!-- 结算提现 -->
					<td>${account.settlecash }</td>

					<!-- 运单交易 -->
					<!-- 运费冻结 -->
					<td>${account.forzenonline }</td>
<%-- 					<!-- 运费预付 -->
					<td>${account.paypremoney }</td>
					<!-- 运费尾付 -->
					<td>${account.payonlienmoney }</td> --%>
					<!-- 运费取消返款 -->
					<td>${account.returnforzen }</td>
					<!-- 预付收入 -->
					<td>${account.getpremoney }</td>
					<!-- 尾款收入 -->
					<td>${account.getonlinemoney }</td>

					<!-- 提现冻结 -->
					<td>${account.cashmoney }</td>
					<!-- 提现退款 -->
					<td>${account.cashmoneyreturn }</td>
					<!-- 收到提现 -->
					<td>${account.getcashmoney }</td>

					<!-- 消费支出 -->
					<td>${account.coinrecharge }</td>
					<!-- 消费收入 -->
					<td>0.0</td>
					<!-- 保证金冻结 -->
					<td>${account.user.userPurse.guaranteemone != null ? account.user.userPurse.guaranteemone:0.0 }</td>
					<!-- 争议退款 -->
					<td>${account.disputemoneyreturn }</td>

					<!-- 缴费支出 -->
					<td>${account.printpay }</td>
					<!-- 缴费收入 -->
					<td>${account.getprintpay }</td>


				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>