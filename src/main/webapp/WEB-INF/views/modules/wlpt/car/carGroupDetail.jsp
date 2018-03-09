<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>车辆管理</title>
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
	<style>
	  th,td{
	    text-align:center !important;
	  }
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li ><a href="${ctx}/wlpt/car/group/">车队列表</a></li>
		<li class="active"><a href="${ctx}/wlpt/car/group/detail">车队车辆详情</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="car" action="${ctx}/wlpt/car/cargroup/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>用户名</th>
				<th>车辆信息</th>
				<th>订单数</th>
				<th>主营路线</th>
				<th>车主姓名</th>
				<th>车主手机</th>
				<th>认证状态</th>
				<th>常停放位置</th>
				<th>定位手机</th>
				<th>更新时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="car">
			<tr>
				<td>
					${car.user.name}
				</td>
				<td>${car.carnumber}<br>${car.cartype}|${fns:getDictLabel(car.issocialcar, 'issocialcar', '')}&nbsp;${car.carlength}${car.lengthunit}&nbsp;${car.loadweight}${car.weightunit}</td>
				<td>
					${car.tradecount}
				</td>
				<td>
					${car.mainroad}
				</td>
				<td>
					${car.ownername }
				</td>
				<td>
					${car.ownermobile}
				</td>
				<td>
					${fns:getDictLabel(car.status, 'authenStatus', '')}
				</td>
				<td>
					${car.oftenparkedposition}
				</td>
				<td>
					${car.locationmobile}
				</td>
				<td>
					<fmt:formatDate value="${car.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>