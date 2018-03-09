<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>账户申请管理</title>
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
		<li class="active"><a href="${ctx}/wlpt/user/userApplicationAccount/list">开户申请列表</a></li>
		<shiro:hasPermission name="wlpt:user:userApplicationAccount:edit"><li><a href="${ctx}/wlpt/user/userApplicationAccount/form">申请开户</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="userApplicationAccount" action="${ctx}/wlpt/user/userApplicationAccount/list" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>会员类型 ：</label>
				<form:select path="type" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('member_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>名称 ：</label>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>身份证号：</label>
				<form:input path="idcard" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>业务结算单ID：</label>
				<form:input path="applyid" htmlEscape="false" maxlength="30" class="input-medium"/>
			</li>
			<li><label>目标用户：</label>
				<form:input path="user.phone" htmlEscape="false" maxlength="30" class="input-medium"/>
			</li>
			<%-- <li><label>是否绑定 ：</label>
				<form:select path="isBind" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('member_isBind')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li> --%>
			<li><label>开户状态 ：</label>
				<form:select path="accountStatus" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('accountStatus_application')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="btns"><a href="${ctx}/wlpt/user/userApplicationAccount/form" class="btn btn-primary">申请开户</a></li>
			<li class="btns"><a href="${ctx}/wlpt/user/userApplicationAccount/goBindAccount" class="btn btn-primary">直接绑定</a></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
			    <th>业务结算单ID</th>
				<th>会员类型 </th>
				<th>名称 </th>
				<th>身份证号</th>
				<th>联系人</th>
				<th>联系手机</th>
				<th>联系地址</th>
				<th>法人姓名</th>
				<th>营业执照号</th>
				<th>开户状态</th>
				<th>目标用户</th>
				<!-- <th>是否绑定</th> -->
				<th>申请时间</th>
				<shiro:hasPermission name="wlpt:user:userApplicationAccount:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="userApplicationAccount">
			<tr>
			    <td>
					${userApplicationAccount.applyid}
				</td>
				<td>
					${fns:getDictLabel(userApplicationAccount.type, 'member_type', '')}
				</td>
				<td>
					${userApplicationAccount.name}
				</td>
				<td>
					${userApplicationAccount.idcard}
				</td>
				<td>
					${userApplicationAccount.linkman}
				</td>
				<td>
					${userApplicationAccount.linkmobile}
				</td>
				<td>
					${userApplicationAccount.linkaddress}
				</td>
				<td>
					${userApplicationAccount.legalname}
				</td>
				<td>
					${userApplicationAccount.bizlicenceno}
				</td>
				<td>
			    	${fns:getDictLabel(userApplicationAccount.accountStatus, 'accountStatus_application', '')}
				</td>
				<td>
				    ${userApplicationAccount.user.phone}
				</td>
				<%-- <td>
				    ${fns:getDictLabel(userApplicationAccount.isBind, 'member_isBind', '')}
				</td> --%>
				<td>
					<fmt:formatDate value="${userApplicationAccount.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="wlpt:user:userApplicationAccount:edit"><td>
    				<a href="${ctx}/wlpt/user/userApplicationAccount/memberApplicationInfo?applyId=${userApplicationAccount.applyid}">查看</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>