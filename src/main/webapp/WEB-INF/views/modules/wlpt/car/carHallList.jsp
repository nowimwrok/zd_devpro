<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>车源大厅</title>
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
		<li class="active"><a href="${ctx}/wlpt/car/carHall">车源大厅</a></li>
		
	</ul>
	<form:form id="searchForm" modelAttribute="car" action="${ctx}/wlpt/car/carHall" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>车主姓名：</label>
				<form:input path="ownername" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>车主手机：</label>
				<form:input path="ownermobile" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			
			<li><label>车牌号码：</label>
				<form:input path="carnumber" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li> 
			
			<li><label>车型：</label>
				<form:input path="cartype" htmlEscape="false" maxlength="5" class="input-medium"/>
			</li>
			<li><label>车长：</label>
				<form:input path="carlength" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>车长单位：</label>
				<form:input path="lengthunit" htmlEscape="false" maxlength="5" class="input-medium"/>
			</li>
			<li><label>载重：</label>
				<form:input path="loadweight" htmlEscape="false" class="input-medium"/>
			</li>
			
			<li><label>载重单位：</label>
				<form:select path="weightunit" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('freightunit')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			
			
			<%-- <li><label>认证状态：</label>
				<form:input path="status" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li> --%>
			
			<%-- <li><label>数据发布源：</label>
				<form:input path="datasource" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li> --%>

			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>车牌号</th>
				<th>车辆类型</th>
				<th>车辆信息</th>
				<th>车主信息</th>
				<th>线路信息</th>
				<th>订单数</th>

				<%-- <shiro:hasPermission name="wlpt:car:car:edit"><th>操作</th></shiro:hasPermission> --%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="car">
			<tr>
				<td><a href="${ctx}/wlpt/car/detail?id=${car.id}">
						${car.carnumber}
				</a></td>
				<td>
					${car.issocialcar}
				</td>
				<td>
					车型:${car.cartype},${car.carlength}米,${car.loadweight}${car.weightunit}<br>
				</td>
				<td>
					用户:${car.ownername}<br>
					手机:${car.ownermobile}
				</td>
				<td>
					${car.mainroad}
				</td>
				<td>
					${car.tradecount}
				</td><%-- 
				<shiro:hasPermission name="wlpt:car:car:edit">
					<td>
    					<a href="${ctx}/wlpt/goods/quoteinfo/goodsQuote?id=${car.id}">我要报价</a>
					</td>
				</shiro:hasPermission> --%>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>