<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货源管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
                $("#btnReset").click(function(){
				location.href="${ctx}/wlpt/goods/goods_list?tabPageId=jerichotabiframe_91";
			});
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
	<style>
      #contentTable{
       width:1900px;
      }
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/wlpt/gds/goods/goods_list">货源列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="goods" action="${ctx}/wlpt/goods/goods_list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>货物名称：</label>
				<form:input path="goodsname" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>货运量：</label>
				<form:input path="freightvolume" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>交易状态：</label>
				<form:select path="tradestatus" class="input-medium" style="width: 178px">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('gds_tradeStatus')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li ><label>货源类型：</label>
				<form:select path="gsoddtype" class="input-medium" style="width: 178px">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('gsoddtype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns" style="float:right;"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/><input id="btnReset" class="btn btn-primary" type="button" value="重置"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
			    <th style="width:1%;">序号</th>
			    <th style="width:2%;">货物名称</th>
			    <th style="width:3%;">货主</th>
				<th style="width:5%;">货源类型</th>
				<th style="width:5%;">货运量</th>
				<th style="width:5%;">剩余货运量</th>
				<th style="width:6%;">发货地址</th>
				<th style="width:6%;">收货地址</th>
				<th style="width:5%;">车辆要求</th>
				<th style="width:5%;">交易状态</th>
				<th style="width:5%;">报价次数</th>
                <th style="width:5%;">货物价值</th>
                <th style="width:5%;">期望价格</th>
                <th style="width:5%;">发货时间</th>
				<th style="width:5%;">更新时间</th>
				<th style="width:5%;">操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="goods" varStatus="vs">
			<tr>
			    <td class='center'>${vs.index+1}</td>
				<td>${goods.goodsname}</td>
				<td>${goods.user.loginName}</td>
				<td>${fns:getDictLabel(goods.gsoddtype,'gsoddtype','')}</td>
				<td>${goods.freightvolume}${fns:getDictLabel(goods.freightunit, 'freightunit', '')}</td>
				<td>${goods.residualvolume}${fns:getDictLabel(goods.freightunit, 'freightunit', '')}</td>
				<td>${goods.shipAddress.province}${goods.shipAddress.city}${goods.shipAddress.district}</td>
				<td>${goods.consignAddress.province}${goods.consignAddress.city}${goods.consignAddress.district}</td>
				<td>${goods.cartype}|${goods.carlength}${goods.lengthunit}</td>
				<td>${fns:getDictLabel(goods.tradestatus,'gds_tradeStatus','')}</td>
				<td>${goods.quotecount}</td>
				<td>${goods.worth}</td>
				<td>${goods.expectedprice}</td>
				<td><fmt:formatDate value="${goods.sendtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${goods.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
    				<a href="${ctx}/wlpt/goods/quoteinfo/quoteList?id=${goods.id}">查看报价</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>