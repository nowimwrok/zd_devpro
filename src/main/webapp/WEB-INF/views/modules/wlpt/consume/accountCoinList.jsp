<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>用户卓币流水</title>
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
											location.href = "${ctx}/wlpt/consume/useraccount/typeList?models=1";
										});
					});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").attr("action",
				"${ctx}/wlpt/consume/useraccount/typeList?models=1");
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
															"确认要导出用户卓币流水统计信息数据吗？",
															"系统提示",
															function(v, h, f) {
																if (v == "ok") {
																	$(
																			"#searchForm")
																			.attr(
																					"action",
																					"${ctx}/wlpt/consume/useraccount/typeExport?models=9");
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
															"${ctx}/wlpt/consume/useraccount/typeList?models=1");
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
		<li><a
			href="${ctx}/wlpt/consume/useraccount/detailByType?trademodel=6"
			title="查看所有交易">卓币交易流水详情</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="account"
		action="${ctx}/wlpt/consume/useraccount/typeList?models=1&tabPageId=jerichotabiframe_62"
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
				id="btnExport" class="btn btn-primary" type="button" value="导出" /></li>
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
				<th colspan="4" class="center ">卓币金额</th>

				<th colspan="2" class="center ">卓币转账（累计）</th>

				<th colspan="2" class="center ">卓币合同结算（累计）</th>
				<th colspan="6" class="center ">卓币运单结算（累计）</th>
				<th colspan="2" class="center ">商城</th>
				<th colspan="1" class="center ">其它</th>
			</tr>
			<tr>
				<!-- 账户信息 -->
				<th>用户类型</th>
				<th>用户名</th>
				<th>手机号码</th>
				<!--  账户钱包 -->
				<th>Z币余额</th>
				<th>Z币可用余额</th>
				<th>Z币冻结</th>
				<th>Z币充值</th>

				<th>转账收入</th>
				<th>转账支出</th>

				<th>结算收入</th>
				<th>结算支出</th>

				<th>运费冻结</th>
				<th>运费预付</th>
				<th>运费尾付</th>
				<th>运单取消退款</th>
				<th>预付收入</th>
				<th>尾款收入</th>

				<th>消费支出</th>
				<th>销售收入</th>

				<!--  卓币 -->
				<th>购买油气</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="account" varStatus="step_status">
				<tr>
					<td>${step_status.index+1 }</td>
					<td>${account.user.role.name }</td>
					<td><a
						href="${ctx}/wlpt/consume/useraccount/detailByType?trademodel=6&id=${account.user.id}"
						target="_self"> ${account.user.loginName} </a></td>
					<td>${account.user.phone}</td>

					<td>${account.user.userPurse.webcoin != null ? account.user.userPurse.webcoin:0.0 }</td>
					<td>${account.user.userPurse.availablecoin != null ? account.user.userPurse.availablecoin:0.0 }</td>
					<td>${account.user.userPurse.freezecoin != null ? account.user.userPurse.freezecoin:0.0 }</td>
					<td>${account.coinbalanace != null ? account.coinbalanace:0.0 }</td>

					<td>${account.getcointransfer}</td>
					<td>${account.cointransfer}</td>

					<td>${account.getsettlecoin }</td>
					<td>${account.settlepaycoin }</td>

					<td>${account.forzenonlinecoin }</td>
					<td>${account.payprecoin }</td>
					<td>${account.payonliencoin }</td>
					<td>${account.conrefound }</td>
					<td>${account.getprecoin }</td>
					<td>${account.getonlinecoin }</td>

					<td>${account.getcoinconsume }</td>
					<td>0.0</td>

					<td>${account.coinbuypetrol }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>