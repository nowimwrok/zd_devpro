<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>保险品种管理</title>
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
		<li class="active"><a href="${ctx}/wlpt/insur/userInsurancelist/">保险品种列表</a></li>
		<shiro:hasPermission name="wlpt:insur:userInsurancelist:edit"><li><a href="${ctx}/wlpt/insur/userInsurancelist/form">保险品种添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="userInsurancelist" action="${ctx}/wlpt/insur/userInsurancelist/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>保险名称：</label>
				<form:input path="insurName" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>支付方式：</label>
				<form:input path="payType" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>卓大直购价：</label>
				<form:input path="insurAmount" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>保障项目：</label>
				<form:input path="insurProject" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>保险公司简称：</label>
				<form:input path="insurCompanyname" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>保险分类：</label>
				<form:select path="type" class="input-medium" style="width: 178px">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('insuranceType')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
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
				<th>保险名称</th>
				<th>保险分类</th>
				<th>适用人群</th>
				<th>保障期限</th>
				<th>产品特点</th>
				<th>高金额</th>
				<th>低金额</th>
				<th>支付方式</th>
				<th>卓大直购价</th>
				<th>保障项目</th>
				<th>保障范围</th>
				<th>官网电话</th>
				<th>保险公司简称</th>
				<th>保险条款编号</th>
				<th>更新时间</th>
				<th>保险公司简介</th>
				<shiro:hasPermission name="wlpt:insur:userInsurancelist:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="userInsurancelist">
			<tr>
				<td><a href="${ctx}/wlpt/insur/userInsurancelist/form?id=${userInsurancelist.id}">
					${userInsurancelist.insurName}
				</a></td>
				<td>
					${fns:getDictLabel(userInsurancelist.type,'insuranceType','')}
				</td>
				<td>
					${userInsurancelist.suitableCrowd}
				</td>
				<td>
					${userInsurancelist.validityTerm}
				</td>
				<td>
					${userInsurancelist.productFeatures}
				</td>
				<td>
					${userInsurancelist.maxAmount}
				</td>
				<td>
					${userInsurancelist.minAmount}
				</td>
				<td>
					${userInsurancelist.payType}
				</td>
				<td>
					${userInsurancelist.insurAmount}
				</td>
				<td>
					${userInsurancelist.insurProject}
				</td>
				<td>
					${userInsurancelist.insurRange}
				</td>
				<td>
					${userInsurancelist.insurPhone}
				</td>
				<td>
					${userInsurancelist.insurCompanyname}
				</td>
				<td>
					${userInsurancelist.clauseCode}
				</td>
				<td>
					<fmt:formatDate value="${userInsurancelist.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${userInsurancelist.remarks}
				</td>
				<shiro:hasPermission name="wlpt:insur:userInsurancelist:edit"><td>
    				<a href="${ctx}/wlpt/insur/userInsurancelist/form?id=${userInsurancelist.id}">修改</a>
					<a href="${ctx}/wlpt/insur/userInsurancelist/delete?id=${userInsurancelist.id}" onclick="return confirmx('确认要删除该保险品种吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>