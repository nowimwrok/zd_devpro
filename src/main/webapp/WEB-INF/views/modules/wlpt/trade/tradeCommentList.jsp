<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>运单评价管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
			$(document).ready(function() {
				$("#btnExport").click(function() {
					top.$.jBox.confirm("确认要导出运单评价信息数据吗？","系统提示",
						function(v, h, f) {
							if (v == "ok") {
								$("#searchForm").attr("action","${ctx}/wlpt/tradeComment/commentExport");
								$("#searchForm").submit();
							}
						},
						{
							buttonsFocus : 1
						});
					top.$('.jbox-body .jbox-icon').css('top', '55px');
				});
				$("#btnSubmit").click(function() {
					$("#searchForm").attr("action","${ctx}/wlpt/tradeComment/");
					$("#searchForm").submit();
				});
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
		<li class="active"><a href="${ctx}/wlpt/tradeComment/">运单评价列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="tradeComment" action="${ctx}/wlpt/tradeComment/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>订单号：</label>
				<form:input path="orderno" htmlEscape="false" maxlength="50"  class="input-medium"/>
			</li>
			<li><label>卖家评论满意度：</label>
			    <form:select path="sellercommentlv" style="width:100px" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('order_commentlv')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>服务态度评分：</label>
			    <form:select path="serviceattitudepoint" style="width:100px" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('order_point')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>运输费用评分：</label>
			    <form:select path="transportationcostpoint" style="width:100px" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('order_point')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>运输失效评分：</label>
			    <form:select path="transportlimitationpoint" style="width:100px" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('order_point')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>货物安全评分：</label>
			    <form:select path="goodssafetypoint" style="width:100px" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('order_point')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns">
			<input id="btnSubmit" class="btn btn-primary" type="button" value="查询"/>
			<input id="btnExport" class="btn btn-primary" type="button" value="导出" />
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>订单号</th>
				<th>卖家</th>
				<th>卖家评论满意度</th>	
				<th>服务态度评分</th>
				<th>运输费用评分</th>
				<th>运输失效评分</th>
				<th>货物安全评分</th>
				<th>综合评分</th>
				<th>卖家评论内容</th>
				<th>卖家评论时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="tradeComment">
			<tr>
				<td>
					${tradeComment.orderno}
				</td>
				<td>${tradeComment.user.name}</td>
				<td>
					${fns:getDictLabel(tradeComment.sellercommentlv, 'order_commentlv', '')}
				</td>
				<td>
					${tradeComment.serviceattitudepoint}
				</td>
				<td>
					${tradeComment.transportationcostpoint}
				</td>
				<td>
					${tradeComment.transportlimitationpoint}
				</td>
				<td>
					${tradeComment.goodssafetypoint}
				</td>
				<td>
					${tradeComment.comprehensivepoint}
				</td>
				<td>
					${tradeComment.sellercomment}
				</td>
				<td>
					<fmt:formatDate value="${tradeComment.sellercommenttime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>