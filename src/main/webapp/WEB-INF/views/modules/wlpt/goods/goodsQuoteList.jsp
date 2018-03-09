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
		<li class="active"><a href="${ctx}/wlpt/gds/quoteinfo/">报价列表</a></li>
		<shiro:hasPermission name="wlpt:gds:quoteinfo:edit"><li><a href="${ctx}/wlpt/gds/quoteinfo/form">报价添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="quoteinfo" action="${ctx}/wlpt/gds/quoteinfo/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>货源id：</label>
				<form:input path="goods.id" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>用户id，：</label>
				<sys:treeselect id="user" name="user.id" value="${quoteinfo.user.id}" labelName="user.name" labelValue="${quoteinfo.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>报价车辆：</label>
				<form:input path="car.id" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>报价：</label>
				<form:input path="ooferprice" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>1:已报价状态,2报价通过状态3:报价未通过状态：</label>
				<form:input path="quotestatus" htmlEscape="false" maxlength="2" class="input-medium"/>
			</li>
			<li><label>create_date：</label>
				<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${quoteinfo.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${quoteinfo.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>update_date：</label>
				<input name="beginUpdateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${quoteinfo.beginUpdateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endUpdateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${quoteinfo.endUpdateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>del_flag：</label>
				<form:radiobuttons path="delFlag" items="${fns:getDictList('del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li><label>报价吨位：</label>
				<form:input path="oddloadweight" htmlEscape="false" maxlength="16" class="input-medium"/>
			</li>
			<li><label>create_by：</label>
				<form:input path="createBy.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>update_by：</label>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>remarks：</label>
				<form:input path="remarks" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>司机ID：</label>
				<sys:treeselect id="driver" name="driver.id" value="${quoteinfo.driver.id}" labelName="" labelValue="${quoteinfo.driver.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
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
				<th>remarks</th>
				<shiro:hasPermission name="wlpt:goods:quoteinfo:edit"><th>操作</th></shiro:hasPermission>
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
				<td></td>
				<td><a href="${ctx}/wlpt/goods/quoteinfo/form?id=${quoteinfo.id}">
					<fmt:formatDate value="${quoteinfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${quoteinfo.remarks}
				</td>
				<shiro:hasPermission name="wlpt:goods:quoteinfo:edit"><td>
    				<c:if test="${quoteinfo.quotestatus eq '1'}">
						<a href="${ctx}/wlpt/goods/quoteinfo/quoteOrder?id=${quoteinfo.id}">生成运单</a>
					</c:if>
					<a href="${ctx}/wlpt/goods/quoteinfo/delete?id=${quoteinfo.id}" onclick="return confirmx('确认要删除该报价吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>