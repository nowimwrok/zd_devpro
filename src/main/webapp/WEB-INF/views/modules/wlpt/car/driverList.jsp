<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>司机信息管理</title>
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
		<li class="active"><a href="${ctx}/wlpt/car/driver/">司机信息列表</a></li>
		<shiro:hasPermission name="wlpt:car:driver:edit"><li><a href="${ctx}/wlpt/car/driver/form">司机信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="driver" action="${ctx}/wlpt/car/driver/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>物流企业Id：</label>
				<sys:treeselect id="user" name="user.id" value="${driver.user.id}" labelName="user.name" labelValue="${driver.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>司机名：</label>
				<form:input path="drivername" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>手机号码：</label>
				<form:input path="drivermobile" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li><label>身份证号：</label>
				<form:input path="idcardnum" htmlEscape="false" maxlength="30" class="input-medium"/>
			</li>
			<li><label>认证状态：</label>
				<form:input path="status" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>是否默认：</label>
				<form:input path="isdefault" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>是否已删除：</label>
				<form:radiobuttons path="delFlag" items="${fns:getDictList('del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li><label>创建时间：</label>
				<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${driver.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${driver.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>更新时间：</label>
				<input name="beginUpdateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${driver.beginUpdateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endUpdateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${driver.endUpdateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>create_by：</label>
				<form:input path="createBy.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>update_by：</label>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>物流企业Id</th>
				<th>司机名</th>
				<th>手机号码</th>
				<th>身份证号</th>
				<th>认证状态</th>
				<th>是否默认</th>
				<th>是否已删除</th>
				<th>创建时间</th>
				<th>更新时间</th>
				<th>create_by</th>
				<th>update_by</th>
				<shiro:hasPermission name="wlpt:car:driver:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="driver">
			<tr>
				<td><a href="${ctx}/wlpt/car/driver/form?id=${driver.id}">
					${driver.user.name}
				</a></td>
				<td>
					${driver.drivername}
				</td>
				<td>
					${driver.drivermobile}
				</td>
				<td>
					${driver.idcardnum}
				</td>
				<td>
					${driver.status}
				</td>
				<td>
					${driver.isdefault}
				</td>
				<td>
					${fns:getDictLabel(driver.delFlag, 'del_flag', '')}
				</td>
				<td>
					<fmt:formatDate value="${driver.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<fmt:formatDate value="${driver.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${driver.createBy.id}
				</td>
				<td>
					${driver.updateBy.id}
				</td>
				<shiro:hasPermission name="wlpt:car:driver:edit"><td>
    				<a href="${ctx}/wlpt/car/driver/form?id=${driver.id}">修改</a>
					<a href="${ctx}/wlpt/car/driver/delete?id=${driver.id}" onclick="return confirmx('确认要删除该司机信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>