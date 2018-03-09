<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>报价管理</title>
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
		<li class="active">报价列表</li>
	</ul>
	<form:form id="searchForm" modelAttribute="quoteinfo" action="" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>货源名称：</label>
			    <form:input path="goods.id" type="hidden"/>
				<form:input path="goods.goodsname" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>报价状态</label>
			    <form:select path="quotestatus" class="input-medium" style="width: 178px">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('quotestatus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>货物信息</th>
				<th>报价报价</th>
				<th>车辆信息</th>
				<th>司机信息</th>
				<th>报价状态</th>
				<th>更新时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="quoteinfo">
			<tr>
				<td>
					货物名称:${quoteinfo.goods.goodsname}<br>
					货运量:${quoteinfo.goods.residualvolume}${quoteinfo.goods.freightunit}
				</td>
				<td>
					报价:${quoteinfo.ooferprice}<br>
					吨位:${quoteinfo.oddloadweight}
				</td>
				<td>
					车牌:${quoteinfo.car.carnumber}<br>
					车型:${quoteinfo.car.cartype}
				</td>
				<td>
					司机:${quoteinfo.driver.loginName}<br>
					司机手机:${quoteinfo.driver.phone}
				</td>
				<td>
					${fns:getDictLabel(quoteinfo.quotestatus, 'quotestatus', '')}
				</td>
				<td>
					<fmt:formatDate value="${quoteinfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>