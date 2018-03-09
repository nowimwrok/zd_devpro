<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>一卡通消费记录管理</title>
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
															"确认要导出一卡通消费记录信息数据吗？",
															"系统提示",
															function(v, h, f) {
																if (v == "ok") {
																	$(
																			"#searchForm")
																			.attr(
																					"action",
																					"${ctx}/wlpt/card/userMetroCardRecord/cardRecodExport");
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
															"${ctx}/wlpt/card/userMetroCardRecord/list");
											$("#searchForm").submit();
										});
						$("#btnReconciliation").click(function() {
							window.location.href = '${ctx}/wlpt/card/userMetroCardRecord/form';
						});
					});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").attr("action",
				"${ctx}/wlpt/card/userMetroCardRecord/list");
		$("#searchForm").submit();
		return false;
	}
	function detail(e) {
        $(e).closest('tr').next().toggleClass('detail-row');
    }
</script>

<style type="text/css">
        td, th {
            text-align: center !important;
        }

        .detail-row {
            display: none;
        }
    </style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a
			href="${ctx}/wlpt/card/userMetroCardRecord/list">一卡通消费记录列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="userMetroCardRecord"
		action="${ctx}/wlpt/card/userMetroCardRecord/" method="post"
		class="breadcrumb form-search">
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
				value="<fmt:formatDate value="${userMetroCardRecord.beginOperateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" />
				(结束)：<input name="endOperateDate" type="text" readonly="readonly"
				maxlength="20" class="input-medium Wdate"
				value="<fmt:formatDate value="${userMetroCardRecord.endOperateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" />
			</li>

			<li class="btns"><input id="btnSubmit" class="btn btn-primary"
				type="button" value="查询" /> <!-- <input
				type="button" id="btnReset" class="btn btn-primary" value="重置" />  -->
				<input id="btnExport" class="btn btn-primary" type="button"
				value="导出" />
				<input id="btnReconciliation" class="btn btn-primary" type="button" value="同步消费记录" /></li>
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
				<th>单据号</th>
				<th>备注</th>
				<th>会员姓名</th>
				<th>付应金额</th>
				<th>实付金额</th>
				<th>现金支付</th>
				<th>储值支付</th>
				<th>积分支付</th>
				<th>获得积分</th>
				<th>操作店面</th>
				<th>工号</th>
				<th>交易时间</th>
				<th>更新时间</th>
				<%-- <shiro:hasPermission name="wlpt:card:userMetroCardRecord:edit"><th>操作</th></shiro:hasPermission> --%>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="userMetroCardRecord">
				<tr >
					<td><a onclick="detail(this);" title="点击查看交易明细">${userMetroCardRecord.cardid}</a></td>
					<td>${userMetroCardRecord.user.loginName}</td>
					<td>${userMetroCardRecord.billnumber}</td>
					<td>${userMetroCardRecord.meno}</td>
					<td>${userMetroCardRecord.truename}</td>
					<td>${userMetroCardRecord.totalmoney}</td>
					<td>${userMetroCardRecord.totalpaid}</td>
					<td>${userMetroCardRecord.paidmoney}</td>
					<td>${userMetroCardRecord.paidvalue}</td>
					<td>${userMetroCardRecord.paidpoint}</td>
					<td>${userMetroCardRecord.point}</td>
					<td>${userMetroCardRecord.storename}</td>
					<td>${userMetroCardRecord.useraccount}</td>
					<td><fmt:formatDate value="${userMetroCardRecord.operatetime}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td><fmt:formatDate value="${userMetroCardRecord.updateDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<%-- <shiro:hasPermission name="wlpt:card:userMetroCardRecord:edit"><td>
    				<a href="${ctx}/wlpt/card/userMetroCardRecord/form?id=${userMetroCardRecord.id}">修改</a>
					<a href="${ctx}/wlpt/card/userMetroCardRecord/delete?id=${userMetroCardRecord.id}" onclick="return confirmx('确认要删除该一卡通消费记录吗？', this.href)">删除</a>
				</td></shiro:hasPermission> --%>
				</tr>
				<tr class="detail-row">
					<td colspan="15">
		                <table class="table table-condensed">
			                <thead>
			                	<th>商品编码</th>
								<th>商品名称</th>
								<th>明细总金额</th>
								<th>商品数量</th>
								<th>商品原价</th>
								<th>实付金额</th>
								<th>折扣</th>
								<th>获得积分</th>
								<th>备注</th>
			                </thead>
			                <tbody>
			                <c:if test="${not empty recorditemlLst}">
                    		<c:forEach items="${recorditemlLst}" var="userMetroCardRecorditem">
                    			<c:if test="${userMetroCardRecorditem.record.guid==userMetroCardRecord.guid}">
	                    		<tr>
	                    			<td>
										${userMetroCardRecorditem.barcode}
									</td>
									<td>
										${userMetroCardRecorditem.gooditemname}
									</td>
									<td>
										${userMetroCardRecorditem.totalmoney}
									</td>
									<td>
										${userMetroCardRecorditem.number}
									</td>
									<td>
										${userMetroCardRecorditem.oldprice}
									</td>
									<td>
										${userMetroCardRecorditem.paidmoney}
									</td>
									<td>
										${userMetroCardRecorditem.discount}
									</td>
									<td>
										${userMetroCardRecorditem.point}
									</td>
									<td>
										${userMetroCardRecorditem.meno}
									</td>
	                    		</tr>
	                    		</c:if>
                    		</c:forEach>
                    		</c:if>
                    		</tbody>
		                </table>
	                </td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>

</html>