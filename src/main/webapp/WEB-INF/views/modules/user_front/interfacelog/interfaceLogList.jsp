<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>接口调用日志信息管理</title>
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
		function divonclick(){
			$("#divid").show();
		}
		
		
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/wlpt/interfacelog/interfaceLog/">接口调用日志信息列表</a></li>
		<shiro:hasPermission name="wlpt:interfacelog:interfaceLog:edit"><li><a href="${ctx}/wlpt/interfacelog/interfaceLog/form">接口调用日志信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="interfaceLog" action="${ctx}/wlpt/interfacelog/interfaceLog/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>手机号：</label>
				<form:input path="phone" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>用户名：</label>
				<form:input path="username" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>接口类型：</label>
				<form:select path="interfaceType" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('zjxl_port')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>接口来源：</label>
				<form:select path="interfaceSource" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('interface_source')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			
			
			<li><label>·查询到数据：</label>
				<form:select path="msgFlag" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('msg_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			
			
<!-- 			<li><label>数据开关：</label> -->
<%-- 				<form:input path="msgFlag" htmlEscape="false" maxlength="1" class="input-medium"/> --%>
<!-- 			</li> -->
			<li><label>创建时间：</label>
				<input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${interfaceLog.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/> - 
				<input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${interfaceLog.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li class="btns">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
				<input type="button" id="butid" class="btn btn-primary" onclick="divonclick()" value="统计服务"/>
				<input id="token" onclick="interfacetoken();" class="btn btn-primary" value="生成接口令牌"/>
			</li>
			<li class="btns">
					</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<div id="divid" style="display:none">
		<table id="contentTable2" class="table table-striped table-bordered table-condensed">
			<thead>
				<tr>
					
					<th>调用接口</th>
					<th>调用次数</th>
					<th>合计价格</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach items="${page1}" var="Interface" varStatus="step_status">
				<tr>
					<td>${fns:getDictLabel(Interface.interfaceSource, 'interface_source', '')}</td>
					<td>${Interface.count}</td>
					<td>${Interface.total}</td>
				</tr>
			</c:forEach>	
			</tbody>
		</table>
		
	</div>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>序号</th>	
				<th>手机号</th>
				<th>用户名</th>
				<th>接口名称</th>
				<th>接口来源</th>
				<th>是否查询到数据</th>
				<th>价格</th>
				<th>创建时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="wlpt:interfacelog:interfaceLog:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="interfaceLog" varStatus="step_status">
			<tr>
				<td>${step_status.index+1}</td>
				<td><a href="${ctx}/wlpt/interfacelog/interfaceLog/form?id=${interfaceLog.id}">
					${interfaceLog.phone}
				</a></td>
				<td>
					${interfaceLog.username}
				</td>
				<td>
					${interfaceLog.interfaceName}
					
				</td>
				<td>
					${fns:getDictLabel(interfaceLog.interfaceSource, 'interface_source', '')}
				</td>
				<td>
					${fns:getDictLabel(interfaceLog.msgFlag, 'msg_flag', '')}
				</td>
				<td>
					${interfaceLog.price}
				</td>
				<td>
					<fmt:formatDate value="${interfaceLog.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${interfaceLog.remarks}
				</td>
				<shiro:hasPermission name="wlpt:interfacelog:interfaceLog:edit"><td>
    				<a href="${ctx}/wlpt/interfacelog/interfaceLog/form?id=${interfaceLog.id}">修改</a>
					<a href="${ctx}/wlpt/interfacelog/interfaceLog/delete?id=${interfaceLog.id}" onclick="return confirmx('确认要删除该接口调用日志信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
		<script type="text/javascript">
		function interfacetoken() {
			$.ajax({
				url:"${ctx}/wlpt/interfacelog/interfaceToken/token",
				contentType:'charset=UTF-8',
				success:function(result) {
					alert(result);
				},
				error : function(message){
					alert("失败");
				}
			});
		}
	</script>
</body>
</html>