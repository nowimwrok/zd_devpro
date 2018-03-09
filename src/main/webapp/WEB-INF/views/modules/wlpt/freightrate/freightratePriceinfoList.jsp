<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>历史运价管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnReset").click(function(){
				
				location.href="${ctx}/wlpt/freightrate/freightratePriceinfo?tabPageId=jerichotabiframe_74";
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
		<li class="active"><a href="${ctx}/wlpt/freightrate/freightratePriceinfo?tabPageId=jerichotabiframe_74">历史运价列表</a></li>
		
	</ul>
	<form:form id="searchForm" modelAttribute="freightratePriceinfo" action="${ctx}/wlpt/freightrate/freightratePriceinfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li style="margin-left: -65px;"><label>	路线：</label>
				<form:input path="address" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>货源类型：</label>
				<form:select path="goodstype" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('gsoddtype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			
			<li><label>更新时间(开始)：</label>
				<input name="timeStart" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${freightratePriceinfo.timeStart}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/> - (结束)：
				<input name="timeEnd" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${freightratePriceinfo.timeEnd}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</li>
			
			
			<li class="btns" style="float:right;"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/><input type="button" value="重置" id="btnReset" class="btn btn-primary"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>路线</th>
                <th>货源类型</th>
                <th>现价(吨/元)</th>
                <th>均价(吨/元)</th>
                <th>运输方式</th>
                <th>车辆长度(对应车型)(米)</th>
                <th>更新时间</th>
				<shiro:hasPermission name="wlpt:freightrate:freightratePriceinfo:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="Priceinfo">
			<tr>
				<td>${Priceinfo.address}</td>
                <td>${fns:getDictLabel(Priceinfo.goodstype, 'gsoddtype', '')}</td>
                <td>${Priceinfo.newprice}</td>
                <td>${Priceinfo.averageprice}</td>
                <td>${Priceinfo.modetranspor}</td>
                <td>${Priceinfo.carlength}</td>
                <td><fmt:formatDate value="${Priceinfo.updatetime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<shiro:hasPermission name="wlpt:freightrate:freightratePriceinfo:edit"><td>
    				<a href="${ctx}/wlpt/freightrate/freightratePriceinfo/form?frlineId=${Priceinfo.frlineId}">编辑价格</a>
					<a href="${ctx}/wlpt/freightrate/freightratePriceinfo/delete?frpriceId=${Priceinfo.frpriceId}" onclick="return confirmx('确认要删除该历史运价吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>