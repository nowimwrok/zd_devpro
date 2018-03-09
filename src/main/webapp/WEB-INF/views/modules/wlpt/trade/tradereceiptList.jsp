<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>运单证明管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/wlpt/trade/tradeReceipt/">运单证明列表</a></li>
		<shiro:hasPermission name="wlpt:trade:tradeReceipt:edit"><li><a href="${ctx}/wlpt/trade/tradeReceipt/form">运单证明添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="tradeReceipt" action="${ctx}/wlpt/trade/tradeReceipt/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>订单Id：</label>
				<form:input path="orderinfo.id" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>上传用户Id：</label>
				<form:input path="createBy.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>上传时间：</label>
				<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${tradeReceipt.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${tradeReceipt.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>0:提货单据；1:回单单据：</label>
				<form:input path="type" htmlEscape="false" maxlength="2" class="input-medium"/>
			</li>
			<li><label>载重 吨位：</label>
				<form:input path="oddloadweight" htmlEscape="false" maxlength="16" class="input-medium"/>
			</li>
			<li><label>上传次数:最多上传5次：</label>
				<form:input path="updatecount" htmlEscape="false" maxlength="2" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>订单Id</th>
				<th>回单图片名称</th>
				<th>上传用户Id</th>
				<th>上传时间</th>
				<th>0:提货单据；1:回单单据</th>
				<shiro:hasPermission name="wlpt:trade:tradeReceipt:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="tradeReceipt">
			<tr>
				<td><a href="${ctx}/wlpt/trade/tradeReceipt/form?id=${tradeReceipt.id}">
					${tradeReceipt.orderinfo.id}
				</a></td>
				<td>
					${tradeReceipt.receiptimg}
				</td>
				<td>
					${tradeReceipt.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${tradeReceipt.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${tradeReceipt.type}
				</td>
				<shiro:hasPermission name="wlpt:trade:tradeReceipt:edit"><td>
    				<a href="${ctx}/wlpt/trade/tradeReceipt/form?id=${tradeReceipt.id}">修改</a>
					<a href="${ctx}/wlpt/trade/tradeReceipt/delete?id=${tradeReceipt.id}" onclick="return confirmx('确认要删除该运单证明吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>