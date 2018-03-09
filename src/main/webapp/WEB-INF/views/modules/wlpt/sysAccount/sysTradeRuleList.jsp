<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>规则管理</title>
<meta name="decorator" content="default" />

<style type="text/css">
.hfont {
	font-size: 25px;
}

.ulclass {
	padding: 20px;
}

.tiltclass {
	padding: 10px 0px;
	padding-left: 20px;
}

.fontright {
	text-align: right;
}

.btn {
	margin-left: 48%;
	margin-right: 48%;
}

table tr td {
	text-align: center;
}

.inputclass {
	text-align: center;
}

.inputwidth {
	width: 60px;
}

.fontsize {
	font-size: 18px;
	padding: 5px 0px;
	position: relative;
	top: 2.5px;
}

.table tr th, .table tr td {
	text-align: center;
}

.divclass {
	width: 225px;
	margin: 0 auto;
}
</style>
<script src="${ctxStatic}/jquery/jquery-1.8.3.min.js"
	type="text/javascript"></script>
<script type="text/javascript"
	src="${ctxStatic}/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript"
	src="${ctxStatic}/modules/wlpt/front/js/jquery.valid.js"></script>
<script type="text/javascript">
	$(document).ready(
			function() {

				var unitA = '${ruleA.cashQuotaUnit}';
				var unitB = '${ruleB.cashQuotaUnit}';
				var unitC = '${ruleC.cashQuotaUnit}';

				if (unitA != null && unitA == '0') {
					$("#aCashQuota").val(0);
				} else if (unitA != null && unitA == '1') {
					$("#aCashQuotaPc").val(0);
				}
				if (unitB != null && unitB == '0') {
					$("#bCashQuota").val(0);
				} else if (unitB != null && unitB == '1') {
					$("#bCashQuotaPc").val(0);
				}
				if (unitC != null && unitC == '0') {
					$("#cCashQuota").val(0);
				} else if (unitC != null && unitC == '1') {
					$("#cCashQuotaPc").val(0);
				}

				window.changeUnit = function() {

					var unitAPc = $("#aCashQuotaPc").val();
					var unitBPc = $("#bCashQuotaPc").val();
					var unitCPc = $("#cCashQuotaPc").val();
					var unitAMon = $("#aCashQuota").val();
					var unitBMon = $("#bCashQuota").val();
					var unitCMon = $("#cCashQuota").val();

					if (unitAPc > 0) {
						$("#aCashQuota").attr("disabled", "disabled");
					} else {
						$("#aCashQuota").attr("disabled", false);
					}
					if (unitBPc > 0) {
						$("#bCashQuota").attr("disabled", "disabled");
					} else {
						$("#bCashQuota").attr("disabled", false);
					}
					if (unitCPc > 0) {
						$("#cCashQuota").attr("disabled", "disabled");
					} else {
						$("#cCashQuota").attr("disabled", false);
					}

					if (unitAMon > 0) {
						$("#aCashQuotaPc").attr("disabled", "disabled");
					} else {
						$("#aCashQuotaPc").attr("disabled", false);
					}
					if (unitBMon > 0) {
						$("#bCashQuotaPc").attr("disabled", "disabled");
					} else {
						$("#bCashQuotaPc").attr("disabled", false);
					}
					if (unitCMon > 0) {
						$("#cCashQuotaPc").attr("disabled", "disabled");
					} else {
						$("#cCashQuotaPc").attr("disabled", false);
					}
				}

				$("#btnSubmit").click(
						function() {
							var isnul = true;
							if ($("#aTradeQuota").val() != null
									&& $("#aTradeQuota").val() != '') {
								isnul = isnul && $("#aTradeQuota").valid({
									methods : "decimalTwo"
								});
							}
							if ($("#bTradeQuota").val() != null
									&& $("#bTradeQuota").val() != '') {
								isnul = isnul && $("#bTradeQuota").valid({
									methods : "decimalTwo"
								});
							}
							if ($("#cTradeQuota").val() != null
									&& $("#cTradeQuota").val() != '') {
								isnul = isnul && $("#cTradeQuota").valid({
									methods : "decimalTwo"
								});
							}

							if ($("#aTradeCommission").val() != null
									&& $("#aTradeCommission").val() != '') {
								isnul = isnul && $("#aTradeCommission").valid({
									methods : "decimalTwo"
								});
							}
							if ($("#bTradeCommission").val() != null
									&& $("#bTradeCommission").val() != '') {
								isnul = isnul && $("#bTradeCommission").valid({
									methods : "decimalTwo"
								});
							}
							if ($("#cTradeCommission").val() != null
									&& $("#cTradeCommission").val() != '') {
								isnul = isnul && $("#cTradeCommission").valid({
									methods : "decimalTwo"
								});
							}

							if ($("#aCashQuotaPc").val() != null
									&& $("#aCashQuotaPc").val() != '') {
								isnul = isnul && $("#aCashQuotaPc").valid({
									methods : "decimalTwo"
								});
							}
							if ($("#bCashQuotaPc").val() != null
									&& $("#bCashQuotaPc").val() != '') {
								isnul = isnul && $("#bCashQuotaPc").valid({
									methods : "decimalTwo"
								});
							}
							if ($("#cCashQuotaPc").val() != null
									&& $("#cCashQuotaPc").val() != '') {
								isnul = isnul && $("#cCashQuotaPc").valid({
									methods : "decimalTwo"
								});
							}

							if ($("#aCashQuota").val() != null
									&& $("#aCashQuota").val() != '') {
								isnul = isnul && $("#aCashQuota").valid({
									methods : "decimalTwo"
								});
							}
							if ($("#aCashQuota").val() != null
									&& $("#aCashQuota").val() != '') {
								isnul = isnul && $("#aCashQuota").valid({
									methods : "decimalTwo"
								});
							}
							if ($("#aCashQuota").val() != null
									&& $("#aCashQuota").val() != '') {
								isnul = isnul && $("#aCashQuota").valid({
									methods : "decimalTwo"
								});
							}

							if ($("#aLowestAmount").val() != null
									&& $("#aLowestAmount").val() != '') {
								isnul = isnul && $("#aLowestAmount").valid({
									methods : "decimalTwo"
								});
							}
							if ($("#aLowestAmount").val() != null
									&& $("#aLowestAmount").val() != '') {
								isnul = isnul && $("#aLowestAmount").valid({
									methods : "decimalTwo"
								});
							}
							if ($("#aLowestAmount").val() != null
									&& $("#aLowestAmount").val() != '') {
								isnul = isnul && $("#aLowestAmount").valid({
									methods : "decimalTwo"
								});
							}

							if ($("#aTradeQuotaDay").val() != null
									&& $("#aTradeQuotaDay").val() != '') {
								isnul = isnul && $("#aTradeQuotaDay").valid({
									methods : "decimalTwo"
								});
							}
							if ($("#bTradeQuotaDay").val() != null
									&& $("#bTradeQuotaDay").val() != '') {
								isnul = isnul && $("#bTradeQuotaDay").valid({
									methods : "decimalTwo"
								});
							}
							if ($("#cTradeQuotaDay").val() != null
									&& $("#cTradeQuotaDay").val() != '') {
								isnul = isnul && $("#cTradeQuotaDay").valid({
									methods : "decimalTwo"
								});
							}

							if (!isnul) {
								return false;
							}
							$("#inputForm").submit();
						});

				changeUnit();
			});
</script>
</head>
<body>
	<ul class="nav nav-tabs ulclass">
		<li class="active"><span class="hfont">规则表</span></li>
	</ul>
	<ul class="nav nav-tabs tiltclass">
		<li class="active">会员账户交易规则明细</li>
	</ul>
	<sys:message content="${message}" />
	<form:form id="inputForm" action="${ctx}/wlpt/account/saveRule"
		method="post" class="form-horizontal">
		<table id="contentTable"
			class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th width="100">-</th>
					<th width="100">A类规则</th>
					<th width="100">B类规则</th>
					<th width="100">C类规则</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="text-align: right;">单笔交易最高限额（元）</td>
					<td><input id="aTradeQuota" name="aTradeQuota"
						class="inputclass" type="text"
						value="${ruleA.tradeQuota!=null?ruleA.tradeQuota:0}"
						style="margin: 0px;" /></td>
					<td><input id="bTradeQuota" name="bTradeQuota"
						class="inputclass" type="text"
						value="${ruleB.tradeQuota!=null?ruleB.tradeQuota:0}"
						style="margin: 0px;" /></td>
					<td><input id="cTradeQuota" name="cTradeQuota"
						class="inputclass" type="text"
						value="${ruleC.tradeQuota!=null?ruleC.tradeQuota:0}"
						style="margin: 0px;" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">单笔交易佣金（元）</td>
					<td><input id="aTradeCommission" name="aTradeCommission"
						class="inputclass" type="text"
						value="${ruleA.tradeCommission!=null?ruleA.tradeCommission:0}"
						style="margin: 0px;" /></td>
					<td><input id="bTradeCommission" name="bTradeCommission"
						class="inputclass" type="text"
						value="${ruleB.tradeCommission!=null?ruleB.tradeCommission:0}"
						style="margin: 0px;" /></td>
					<td><input id="cTradeCommission" name="cTradeCommission"
						class="inputclass" type="text"
						value="${ruleC.tradeCommission!=null?ruleC.tradeCommission:0}"
						style="margin: 0px;" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">单个账户单日累计提现额度（% 或 元）</td>
					<td><div class="divclass">
							<input id="aCashQuotaPc" onchange="changeUnit()"
								name="aCashQuotaPc" class="inputclass inputwidth" type="text"
								value="${ruleA.cashQuota!=null?ruleA.cashQuota:0}"
								style="margin: 0px;" /><span class="fontsize"> % </span> <span
								class="fontsize"> 或 </span> <input id="aCashQuota"
								onchange="changeUnit()" name="aCashQuota"
								class="inputclass inputwidth" type="text"
								value="${ruleA.cashQuota!=null?ruleA.cashQuota:0}"
								style="margin: 0px;" /><span class="fontsize"> 元 </span>
						</div></td>
					<td><div class="divclass">
							<input id="bCashQuotaPc" onchange="changeUnit()"
								name="bCashQuotaPc" class="inputclass inputwidth" type="text"
								value="${ruleB.cashQuota!=null?ruleB.cashQuota:0}"
								style="margin: 0px;" /><span class="fontsize"> % </span> <span
								class="fontsize"> 或 </span> <input id="bCashQuota"
								onchange="changeUnit()" name="bCashQuota"
								class="inputclass inputwidth" type="text"
								value="${ruleB.cashQuota!=null?ruleB.cashQuota:0}"
								style="margin: 0px;" /><span class="fontsize"> 元 </span>
						</div></td>
					<td><div class="divclass">
							<input id="cCashQuotaPc" onchange="changeUnit()"
								name="cCashQuotaPc" class="inputclass inputwidth" type="text"
								value="${ruleC.cashQuota!=null?ruleC.cashQuota:0}"
								style="margin: 0px;" /><span class="fontsize"> % </span> <span
								class="fontsize"> 或 </span> <input id="cCashQuota"
								onchange="changeUnit()" name="cCashQuota"
								class="inputclass inputwidth" type="text"
								value="${ruleC.cashQuota!=null?ruleC.cashQuota:0}"
								style="margin: 0px;" /><span class="fontsize"> 元 </span>
						</div></td>
				</tr>
				<tr>
					<td style="text-align: right;">电子钱包最低留存额度（元）</td>
					<td><input id="aLowestAmount" name="aLowestAmount"
						class="inputclass" type="text"
						value="${ruleA.lowestAmount!=null?ruleA.lowestAmount:0}"
						style="margin: 0px;" /></td>
					<td><input id="bLowestAmount" name="bLowestAmount"
						class="inputclass" type="text"
						value="${ruleB.lowestAmount!=null?ruleB.lowestAmount:0}"
						style="margin: 0px;" /></td>
					<td><input id="cLowestAmount" name="cLowestAmount"
						class="inputclass" type="text"
						value="${ruleC.lowestAmount!=null?ruleC.lowestAmount:0}"
						style="margin: 0px;" /></td>
				</tr>
				<tr>
					<td style="text-align: right;">单日非同名交易最高限额（元）</td>
					<td><input id="aTradeQuotaDay" name="aTradeQuotaDay"
						class="inputclass" type="text"
						value="${ruleA.tradeQuotaDay!=null?ruleA.tradeQuotaDay:0}"
						style="margin: 0px;" /></td>
					<td><input id="bTradeQuotaDay" name="bTradeQuotaDay"
						class="inputclass" type="text"
						value="${ruleB.tradeQuotaDay!=null?ruleB.tradeQuotaDay:0}"
						style="margin: 0px;" /></td>
					<td><input id="cTradeQuotaDay" name="cTradeQuotaDay"
						class="inputclass" type="text"
						value="${ruleC.tradeQuotaDay!=null?ruleC.tradeQuotaDay:0}"
						style="margin: 0px;" /></td>
				</tr>
			</tbody>
		</table>
	</form:form>
	<ul class="nav nav-tabs tiltclass">
		<li class="active">注意：如果相同用户多次配置不同类的规则，则以最近一次配置为准。</li>
	</ul>

	<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="button" value="保 存" />
	</div>
</body>
</html>