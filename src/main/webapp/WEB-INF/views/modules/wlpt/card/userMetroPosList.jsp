<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>一卡通POS机列表管理</title>
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
		<li class="active"><a href="${ctx}/wlpt/card/userMetroPos/">一卡通POS机列表列表</a></li>
		<shiro:hasPermission name="wlpt:card:userMetroPos:edit"><li><a href="${ctx}/wlpt/card/userMetroPos/form">一卡通POS机列表添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="userMetroPos" action="${ctx}/wlpt/card/userMetroPos/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li style="margin-left: -25px;"><label>搜索关键字：</label> <form:input
					path="searchinfo" htmlEscape="false" maxlength="32"
					placeholder="用户名/会员名/工号/店铺名称" class="input-medium" /></li>
			<li><label style="width:160px;">POS机绑定时间(开始)：</label> <input name="beginOperateDate"
				type="text" readonly="readonly" maxlength="20"
				class="input-medium Wdate"
				value="<fmt:formatDate value="${userMetroPos.beginOperateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" />
				(结束)：<input name="endOperateDate" type="text" readonly="readonly"
				maxlength="20" class="input-medium Wdate"
				value="<fmt:formatDate value="${userMetroPos.endOperateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});" />
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>登陆名</th>
				<th>手机号</th>
				<th>用户名</th>
				<th>会员姓名</th>
				<th>店铺名称</th>
				<th>POS机工号</th>
				<th>绑定时间</th>
				<th>更新时间</th>
				<th>备注</th>
				<shiro:hasPermission name="wlpt:card:userMetroPos:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="userMetroPos">
			<tr>
				<td>
					${userMetroPos.user.loginName}
				</td>
				<td>
					${userMetroPos.user.phone}
				</td>
				<td>
					${userMetroPos.user.name}
				</td>
				<td>
					${userMetroPos.memberName}
				</td>
				<td>
					${userMetroPos.storeName}
				</td>
				<td>
					${userMetroPos.useraccount}
				</td>
				<td>
					<fmt:formatDate value="${userMetroPos.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${userMetroPos.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${userMetroPos.remarks}
				</td>
				<shiro:hasPermission name="wlpt:card:userMetroPos:edit"><td>
    				<a href="${ctx}/wlpt/card/userMetroPos/form?id=${userMetroPos.id}">修改</a>
					<a href="${ctx}/wlpt/card/userMetroPos/delete?id=${userMetroPos.id}" onclick="return confirmx('确认要删除该一卡通POS机列表吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>