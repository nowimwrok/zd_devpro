<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货源管理</title>
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
		<li class="active"><a href="${ctx}/wlpt/gds/goods/">货源大厅</a></li>
		<%--<shiro:hasPermission name="wlpt:goods:goodsBiz:edit"><li><a href="${ctx}/wlpt/goods/goodsBiz/form">货源添加</a></li></shiro:hasPermission>--%>
	</ul>
	<form:form id="searchForm" modelAttribute="goods" action="${ctx}/wlpt/gds/goods/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>货物名称：</label>
				<form:input path="goodsname" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>货物类型：</label>
				<form:select path="goodstype" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('goodstype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>货源类型：</label>
				<form:select path="gsoddtype" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('gsoddtype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>运输方式：</label>
				<form:input path="transportway" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>车型要求：</label>
				<form:input path="cartype" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>车长：</label>
				<form:input path="carlength" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>车长单位：</label>
				<form:input path="lengthunit" htmlEscape="false" maxlength="5" class="input-medium"/>
			</li>
			<li><label>货运量：</label>
				<form:input path="freightvolume" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>剩余货运量：</label>
				<form:input path="residualvolume" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>货运单位：</label>
				<form:select path="freightunit" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('freightunit')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>件数：</label>
				<form:input path="piecenumber" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>搬运工：</label>
				<form:input path="stevedore" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>包装方式：</label>
				<form:input path="packageway" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>货物价值：</label>
				<form:input path="worth" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>期望价格：</label>
				<form:input path="expectedprice" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>发货时间：</label>
				<input name="beginSendtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${goods.beginSendtime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endSendtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${goods.endSendtime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>到达时间：</label>
				<input name="arrivetime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${goods.arrivetime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>交易状态：</label>
				<form:input path="tradestatus" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>有效期：</label>
				<form:input path="effectdays" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>数据发布源：</label>
				<form:input path="datasource" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>

			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>货物名称</th>
				<th>货源类型</th>
				<th>货主信息</th>
				<th>车辆要求</th>
				<th>货运量</th>
				<th>发货时间</th>

				<shiro:hasPermission name="wlpt:gds:goods:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="goods">
			<tr>
				<td><a href="${ctx}/wlpt/gds/goods/form?id=${goods.id}">
						${goods.goodsname}
				</a></td>
				<td><a href="${ctx}/wlpt/gds/goods/form?id=${goods.id}">
					${fns:getDictLabel(goods.gsoddtype, 'gsoddtype', '')}
				</a></td>
				<td>
					用户:${goods.user.loginName}<br>
					手机:${goods.user.phone}
				</td>
				<td>
					车型:${goods.cartype},${goods.carlength}米,
				</td>
				<td>
					${goods.carlength}
				</td>
				<td>
					货运量:${goods.freightvolume}${fns:getDictLabel(goods.freightunit, 'freightunit', '')}
					剩余量:${goods.residualvolume}${fns:getDictLabel(goods.freightunit, 'freightunit', '')}
				</td>
				<td>
					<fmt:formatDate value="${goods.sendtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="wlpt:gds:goods:edit">
					<td>
    					<a href="${ctx}/wlpt/gds/quoteinfo/goodsQuote?id=${goods.id}">我要报价</a>
					</td>
				</shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>