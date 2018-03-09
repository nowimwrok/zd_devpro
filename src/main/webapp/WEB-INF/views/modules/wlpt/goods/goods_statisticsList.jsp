<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>用户货源信息统计</title>
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
	$(document).ready(function() {
		$("#btnReset").click(function() {
			$("#userId").val('');
			$("#userName").val('');
			
			$("#phone").val('');
			$("#gsoddtype").val('');
			$("#istrading").val('');
		});
		$("#btnExport").click(function() {
			top.$.jBox.confirm(
							"确认要导出货源信息统计数据信息吗？",
							"系统提示",
							function(v, h, f) {
								if (v == "ok") {
									$("#searchForm").attr("action","${ctx}/wlpt/goods/goodsStatisticsExport");
									$("#searchForm").submit();
								}
							},
							{
								buttonsFocus : 1
							});
			top.$('.jbox-body .jbox-icon').css('top', '55px');
		});
	});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
	}
</script>
</head>
<body>
	<ul class="nav nav-tabs">
	</ul>
	<form:form id="searchForm" modelAttribute="goods"
		action="${ctx}/wlpt/goods/goodsStatisticsList"
		method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<ul class="ul-form">
			<li><label>用户：</label>
				<sys:treeselect id="user" name="user.id" value="${goods.user.id}" labelName="user.name" labelValue="${goods.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			
			<li><label>手机号码：</label> <form:input path="user.phone"
					id="phone" /></li>
			<li ><label>货源类型：</label>
				<form:select path="gsoddtype" class="input-medium" style="width: 178px">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('gsoddtype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>支付状态：</label> <form:select path="istrading">
					<form:option value="" label="全部" />
					<form:option value="1" label="未支付" />
					<form:option value="2" label="待支付" />
					<form:option value="3" label="已支付" />
				</form:select></li>		
					
			
			<li class="btns" style="float: right;"><input id="btnSubmit"
				class="btn btn-primary" type="submit" value="查询" /><input
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
				<th rowspan="3" class="center" style="vertical-align: middle">序号</th>
				<th colspan="3" class="center" style="vertical-align: middle">用户信息</th>
				<th colspan="3" class="center ">货物</th>
				<th colspan="3" class="center ">运单</th>
			</tr>
			<tr>
				<!-- 账户信息 -->
				<th>登录名</th>
				<th>姓名</th>
				<th>手机号码</th>
				<th>货运量</th>
				<th>剩余货运量</th>
				<th>货物价值</th>
				<th>单数</th>
				<th>报价吨数</th>
				<th>金额</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="goods" varStatus="step_status">
				<tr>
					<td>${step_status.index+1 }</td>
					<td>${goods.user.loginName}</td>
					<td>${goods.user.name}</td>
					<td>${goods.user.phone}</td>
					<!-- 货物 -->
					<td>${not empty goods.freightvolume?goods.freightvolume:0}</td>
					<td>${not empty goods.residualvolume?goods.residualvolume:0 }</td>
					<td>${not empty goods.worth?goods.worth:0.0 }</td>
					<!-- 运单 -->
					<td>${not empty goods.ordernum?goods.ordernum:0}</td>
					<td>${not empty goods.sumoddloadweight?goods.sumoddloadweight:0 }</td>
					<td>${not empty goods.sumtotalcost?goods.sumtotalcost:0.0 }</td>
					
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>