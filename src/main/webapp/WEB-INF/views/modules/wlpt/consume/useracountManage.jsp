<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>账户钱包管理</title>
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
	$(document).ready(function() {
		$("#btnReset").click(function() {
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
			location.href = "${ctx}/wlpt/consume/useraccount/";
		});
	});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").attr("action", "${ctx}/wlpt/consume/useraccount/list");
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
															"确认要导出钱包数据吗？",
															"系统提示",
															function(v, h, f) {
																if (v == "ok") {
																	$(
																			"#searchForm")
																			.attr(
																					"action",
																					"${ctx}/wlpt/consume/useraccount/export");
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
															"${ctx}/wlpt/consume/useraccount/list");
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
		<li class="active"><a href="${ctx}/wlpt/consume/useraccount/">账户钱包列表</a></li>
		<li><a href="${ctx}/wlpt/consume/useraccount/detail" title="查看所有交易">账户交易详情</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="account"
		action="${ctx}/wlpt/consume/useraccount/list?tabPageId=jerichotabiframe_62"
		method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<ul class="ul-form">
			<li><label>登录名：</label> <form:input path="user.loginName"
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
				<th colspan="4" class="center" style="vertical-align: middle">用户信息</th>
				<th colspan="8" class="center ">余额</th>

				<th colspan="3" class="center ">竞标</th>
				<th colspan="5" class="center ">招标结算</th>
				<th colspan="3" class="center ">提现</th>
				<th colspan="3" class="center ">卓币</th>
				<th colspan="4" class="center ">油气</th>
				<th colspan="3" class="center ">充值</th>
				<th colspan="9" class="center ">余额运费</th>
				<th colspan="7" class="center ">卓币运费</th>
				<th colspan="2" class="center ">打印缴费</th>
				<th colspan="2" class="center ">转账</th>
			</tr>
			<tr>
				<!-- 账户信息 -->
				<th>登录名</th>
				<th>用户名</th>
				<th>角色</th>
				<th>手机号码</th>
				<!--  账户钱包 -->
				<th>账户余额</th>
				<th>可用账户余额</th>
				<th>油气余额</th>
				<th>担保金</th>
				<th>红包金额</th>
				<th>冻结资金(运费冻结)</th>
				<th>竞标押金</th>
				<th>授信可用金额</th>
				<!-- 竞标 -->
				<th>缴纳竞标押金</th>
				<th>收到竞标押金</th>
				<th>退还竞标押金</th>
				<!-- 招标结算 -->
				<th>结算支付</th>
				<th>收到结算</th>
				<th>结算提现</th>
				<th>结算卓币</th>
				<th>收到结算卓币</th>
				<!-- 提现 -->
				<th>余额提现</th>
				<th>收到余额提现</th>
				<th>提现退款</th>
				<!--  卓币 -->
				<th>卓币充值</th>
				<th>卓币购买油气</th>
				<th>卓币消费</th>
				<!--  油气 -->
				<th>油气充值</th>
				<th>油气消费</th>
				<th>油气支付充值</th>
				<th>油气收到消费</th>
				<!--  充值 -->
				<th>余额充值</th>
				<th>卓币充值</th>
				<th>保证金充值</th>
				<!-- 运单交易 -->
				<th>支出</th>
				<th>返款</th>
				<th>收到预付</th>
				<th>支出预付</th>
				<th>支付余款</th>
				<th>收到余款</th>
				<th>争议退款</th>
				<th>争议余款支付</th>
				<th>收到冻结</th>

				<th>卓币冻结</th>
				<th>卓币预付</th>
				<th>收到预付</th>
				<th>支付余款</th>
				<th>收到余款</th>
				<th>收到冻结</th>
				<th>解冻卓币</th>

				<th>打印缴费</th>
				<th>收到缴费</th>
				<!-- 转帐 -->
				<th>账户余额转账</th>
				<th>收到余额转账</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="account" varStatus="step_status">
				<tr>
					<td>${step_status.index+1 }</td>
					<%--  <td>user. 
							${user.id} </a> </td> --%>
					<td><a
						href="${ctx}/wlpt/consume/useraccount/detail?id=${account.user.id}"
						target="_self"> ${account.user.loginName} </a></td>
					<td>${account.user.name}</td>
					<td>${account.user.role.name }</td>
					<td>${account.user.phone}</td>
					<td>${account.user.userPurse.webbalance != null ? account.user.userPurse.webbalance:0.0 }</td>
					<td>${account.user.userPurse.availablebalance != null ? account.user.userPurse.availablebalance:0.0 }</td>
					<td>${account.user.userPurse.petrolbalance != null ? account.user.userPurse.petrolbalance:0.0 }</td>
					<td>${account.user.userPurse.guaranteemone != null ? account.user.userPurse.guaranteemone:0.0 }</td>

					<td>${account.user.userPurse.redpacket != null ? account.user.userPurse.redpacket:0.0 }</td>
					<td>${account.user.userPurse.freezemoney != null ? account.user.userPurse.freezemoney:0.0 }</td>
					<td>${account.user.userPurse.biddingmoney != null ? account.user.userPurse.biddingmoney:0.0 }</td>
					<td>${account.user.userPurse.creditmoney != null ? account.user.userPurse.creditmoney:0.0 }</td>

					<!-- 竞标 -->
					<td>${account.bidingpay }</td>
					<td>${account.bidinggetpay }</td>
					<td>${account.bidingreturn }</td>
					<!-- 招标结算 -->
					<td>${account.settlepay }</td>
					<td>${account.getsettle }</td>
					<td>${account.settlecash }</td>
					<td>${account.settlepaycoin }</td>
					<td>${account.getsettlecoin }</td>
					<!-- 提现 -->
					<td>${account.cashmoney }</td>
					<td>${account.getcashmoney }</td>
					<td>${account.cashmoneyreturn }</td>
					<!-- 卓币 -->
					<td>${account.coinrecharge }</td>
					<td>${account.coinbuypetrol }</td>
					<td>${account.getcoinconsume }</td>
					<!-- 油气 -->
					<td>${account.petrolrecharge }</td>
					<td>${account.petrolconsume }</td>
					<td>${account.paypetrolrecharge }</td>
					<td>${account.getpetrolconsume }</td>
					<!-- 充值 -->
					<td>${account.balanace }</td>
					<td>${account.coinbalanace }</td>
					<td>${account.guenalanace }</td>
					<!-- 运单交易 -->
					<td>${account.forzenonline }</td>
					<td>${account.returnforzen }</td>
					<td>${account.getpremoney }</td>
					<td>${account.paypremoney }</td>
					<td>${account.payonlienmoney }</td>
					<td>${account.getonlinemoney }</td>
					<td>${account.disputemoneyreturn }</td>
					<td>${account.disputepaymoney }</td>
					<td>${account.getforzenonline }</td>

					<td>${account.forzenonlinecoin }</td>
					<td>${account.payprecoin }</td>
					<td>${account.getprecoin }</td>
					<td>${account.payonliencoin }</td>
					<td>${account.getonlinecoin }</td>
					<td>${account.getforzenonlinecoin }</td>
					<td>${account.conrefound }</td>

					<td>${account.printpay }</td>
					<td>${account.getprintpay }</td>

					<!-- 转账 -->
					<td>${account.accounttransfer }</td>
					<td>${account.receivedtransfer }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>