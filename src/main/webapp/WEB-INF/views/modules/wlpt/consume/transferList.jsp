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
        $(document).ready(function () {
        	$("#btnExport").click(function() {
				top.$.jBox.confirm("确认要导出转账数据统计信息数据吗？","系统提示",
					function(v, h, f) {
						if (v == "ok") {
							$("#searchForm").attr("action","${ctx}/wlpt/consume/consumerecod/transferExport");
							$("#searchForm").submit();
						}
					},
					{
						buttonsFocus : 1
					});
				top.$('.jbox-body .jbox-icon').css('top', '55px');
			});
        	$("#btnSubmit").click(function() {
				$("#searchForm").attr("action","${ctx}/wlpt/consume/consumerecod/transferList");
				$("#searchForm").submit();
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
	   .detail-row{
	     display: none;
	   }
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active">转账信息列表</li>
	</ul>
	<form:form id="searchForm" modelAttribute="transfer"
		action="${ctx}/wlpt/consume/consumerecod/transferList"
		method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<ul class="ul-form">
			<li><label>手机号码：</label> <form:input path="user.phone" htmlEscape="false" maxlength="64" class="input-medium" /></li>
			<li class="btns" style="float: left;"><input id="btnSubmit" class="btn btn-primary" type="button" value="查询" /><input id="btnExport" class="btn btn-primary" type="button" value="导出" /></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}" />
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
			    <th class="center" style="vertical-align: middle;">序号</th>
			    <th class="center" style="vertical-align: middle;">转账明细</th>
				<th class="center" style="vertical-align: middle;">登录名</th>
				<th class="center" style="vertical-align: middle;">姓名</th>
				<th class="center" style="vertical-align: middle;">手机</th>
				<th class="center" style="vertical-align: middle;">账户余额</th>
				<th class="center" style="vertical-align: middle;">可用余额</th>
				<th class="center" style="vertical-align: middle;">账户转账总额</th>
				<th class="center" style="vertical-align: middle;">收到转账总额</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="transfer" varStatus="vs">
				<tr>
				    <td class='center' style="width: 30px;">${vs.index+1}</td>
				    <td>
			        <a href="javascript:;" onclick="detail(this);">查看</a>
				    </td>
					<td>${transfer.user.loginName}</td>
					<td>${transfer.user.name}</td>
					<td>${transfer.user.phone}</td>
					<td>${not empty transfer.webbalance?transfer.webbalance:0.00}</td>
					<td>${not empty transfer.availablebalance?transfer.availablebalance:0.00}</td>
					<td>${not empty transfer.consumemonyout?transfer.consumemonyout:0.00}</td>
					<td>${not empty transfer.consumemonyin?transfer.consumemonyin:0.00}</td>
				</tr>
				<tr class="detail-row">
				<td colspan="9">
				<table class="table table-condensed">
				<thead>
				<th>交易编号</th>
				<th>流出账户</th>
				<th>流入账户</th>
				<th>交易类型</th>
				<th>交易方式</th>
				<th>交易状态</th>
				<th>交易金额</th>
				<th>交易前金额</th>
				<th>交易后金额</th>
				<th>交易时间</th>
				<th>更新时间</th>
				<th>明细</th>
				</thead>
				<tbody>
				<c:forEach items="${transfer.list}" var="consumerecod">
				<tr>
				    <td>${consumerecod.consumecode}</td>
					<td>${consumerecod.account.loginName}</td>
					<td>${consumerecod.target.loginName}</td>
					<td>${fns:getDictLabel(consumerecod.consumetype, 'consumerecode_type', '')}</td>
					<td>${fns:getDictLabel(consumerecod.consumeway, 'consumerecode_way', '')}</td>
					<td>${fns:getDictLabel(consumerecod.consumestatus, 'consume_status', '')}</td>
					<td>${consumerecod.consumemony}</td>
					<td>${consumerecod.beforemony}</td>
					<td>${consumerecod.aftermony}</td>
					<td><fmt:formatDate value="${consumerecod.createDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td><fmt:formatDate value="${consumerecod.updateDate}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>${consumerecod.remarks}</td>
				</tr>
				</c:forEach>
				</tbody>
				</table>
				</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
		<script type="text/javascript">
       function detail(e){
    	   $(e).closest('tr').next().toggleClass('detail-row');
       }
	</script>
</body>
</html>