<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>交易明细</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(document).ready(function() {
		var memberId='${memberId}';
		$("#memberId").val(memberId);
		var accountId='${accountId}';
		$("#accountId").val(accountId);
		$("#btnSubmit").click(
				function() {
					$("#searchForm").attr("action","${ctx}/wlpt/account/traceList");
					$("#searchForm").submit();
				});
		$("#btnExport").click(
				function() {
					top.$.jBox.confirm("确认要导出流水数据吗？","系统提示",
									function(v, h, f) {
										if (v == "ok") {
											$("#searchForm").attr("action","${ctx}/wlpt/account/exportTrace");
									        $("#searchForm").submit();
										}
									},
									{
										buttonsFocus : 1
									});
					top.$('.jbox-body .jbox-icon').css(
							'top', '55px');
				});
	});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
	}
</script>
<style type="text/css">
.table tr th, .table tr td {
	text-align: center;
}
</style>
</head>
<body>
	<div>
		<form:form id="searchForm" action="${ctx}/wlpt/account/traceList"
			method="post" class="breadcrumb form-search">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
			<ul class="ul-form">
			    <li><label>会员ID ：</label> <input id="memberId" name="memberId" htmlEscape="false" maxlength="40" placeholder="会员ID" class="input-medium"/></li>
			    <li><label>三级账户ID ：</label> <input id="accountId" name="accountId" htmlEscape="false" maxlength="40" placeholder="三级账户ID" class="input-medium"/></li>
				<li>
				<label>交易类型:</label> 
				<select id="tradeType" style="width: 100px;" name="tradeType">
						<option <c:if test="${tradeType=='0'}">selected</c:if> value="0">全部</option>
						<option <c:if test="${tradeType=='1'}">selected</c:if> value="1">出账</option>
						<option <c:if test="${tradeType=='2'}">selected</c:if> value="2">入账</option>
						<option <c:if test="${tradeType=='3'}">selected</c:if> value="3">冲正</option>
						<option <c:if test="${tradeType=='5'}">selected</c:if> value="5">锁定金额</option>
						<option <c:if test="${tradeType=='6'}">selected</c:if> value="6">解锁金额</option>
						<option <c:if test="${tradeType=='9'}">selected</c:if> value="9">冻结金额</option>
						<option <c:if test="${tradeType=='10'}">selected</c:if> value="10">解冻金额</option>
						<option <c:if test="${tradeType=='11'}">selected</c:if> value="11">手续费</option>
				</select>
				</li>
				<li>
				<label>交易状态:</label> 
				<select id="tradeStatus" style="width: 100px;" name="tradeStatus">
						<option <c:if test="${tradeStatus=='0'}">selected</c:if> value="0">全部</option>
						<option <c:if test="${tradeStatus=='1'}">selected</c:if> value="1">提交成功</option>
						<option <c:if test="${tradeStatus=='-1'}">selected</c:if> value="-1">提交失败</option>
						<option <c:if test="${tradeStatus=='2'}">selected</c:if> value="2">交易成功</option>
						<option <c:if test="${tradeStatus=='-2'}">selected</c:if> value="-2">交易失败</option>
				</select>
				</li>

				<li><label>交易时间：</label> <input id="beginDate"
					name="beginDate" type="text" readonly="readonly" maxlength="20"
					class="input-medium Wdate" value="${beginDate}"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,maxDate:new Date()});" />
					-<input id="endDate" name="endDate" type="text"
					readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="${endDate}"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,maxDate:new Date()});" />
				</li>

				<li class="btns"><input id="btnSubmit" class="btn btn-primary"
					type="button" value="查询" /></li>
					<li class="btns"><input id="btnExport" class="btn btn-primary"
					type="button" value="导出" /></li>
				<li class="clearfix"></li>
			</ul>
		</form:form>
		<sys:message content="${message}"/>
		<table id="contentTable" class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					<th>业务结算ID</th>
					<th>会员ID</th>
					<th>交易类型</th>
					<th>交易金额</th>
					<th>实际转出金额</th>
					<th>付款账户ID</th>
					<th>付款账户号</th>
					<th>付款账户名</th>
					<th>收款账户ID</th>
					<th>收款账户号</th>
					<th>收款账户名</th>
					<th>收款银行</th>
					<th>交易状态</th>
					<th>交易时间</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${page.list}" var="item" varStatus="vs">
					<tr>
						<td><a href="${ctx}/wlpt/account/memberSettlement?tradeSettlementId=${item.tradeSettlementId}&flag=1">${item.tradeSettlementId}</a></td>
						<td>${memberId}</td>
						<td>${fns:getDictLabel(item.tradeType,'tradeType','')}</td>
						<td>${item.amount}</td>
						<td>${item.outAmount}</td>
						<td>${item.fromAccountId}</td>
						<td>${item.fromAccountNo}</td>
						<td>${item.fromAccountName}</td>
						<td>${item.toAccountId}</td>
						<td>${item.toAccountNo}</td>
						<td>${item.toAccountName}</td>
						<td>${item.toBankName}</td>
						<td>${fns:getDictLabel(item.tradeStatus,'tradeStatus','')}</td>
						<td>${item.tradeStatusTime}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div class="pagination">${page}</div>
	</div>
</body>
</html>