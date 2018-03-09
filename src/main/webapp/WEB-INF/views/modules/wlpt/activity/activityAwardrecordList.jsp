<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>中奖记录管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
$("#btnReset").click(function(){
				
				location.href="${ctx}/wlpt/activity/activityAwardrecord?tabPageId=jerichotabiframe_79";
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
		<li class="active"><a href="${ctx}/wlpt/activity/activityAwardrecord/">中奖记录列表</a></li>
		<%-- <shiro:hasPermission name="wlpt:activity:activityAwardrecord:edit"><li><a href="${ctx}/wlpt/activity/activityAwardrecord/form">中奖记录添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="activityAwardrecord" action="${ctx}/wlpt/activity/activityAwardrecord/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>关键字：</label>
				<form:input path="searchcondition"  htmlEscape="false" maxlength="64" class="input-medium" placeholder="这里输入用户名或手机号、兑换号"/>
			</li>
			<li><label>奖品类型：</label>
				<form:select path="wxgift.gifttype" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('gifttype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>发放状态：</label>
				<form:select path="issue" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('issue')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			
			<li><label>获奖时间(开始)：</label>
				<input name="timeStart" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${activityAwardrecord.timeStart}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/> - (结束)：
				<input name="timeEnd" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${activityAwardrecord.timeEnd}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</li>
			<li class="btns" style="float:right;"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/><input id="btnReset" class="btn btn-primary" type="button" value="重置"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
		   <th>序号</th>
		   <th>兑换号</th>
           <th>中奖手机</th>
           <th>是否发放</th>
           <th>开始使用时间</th>
           <th>结束使用时间</th>
           <th>活动名称</th>
           <th>奖品名称</th>
           <th>奖品类型</th>
           <th>奖品说明</th>
           <th>奖品价值</th>
		   <shiro:hasPermission name="wlpt:activity:activityAwardrecord:edit"><th>操作</th></shiro:hasPermission>
			
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="var" varStatus="vs">
			<tr>
				<td class='center' style="width: 30px;">${vs.index+1}</td>
				<td>${var.awardno}</td>
                <td>${var.phone}</td>
                <td>
                	${fns:getDictLabel(var.issue, 'issue', '')}
                    
                </td>
                <td><fmt:formatDate value="${var.starttime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <td><fmt:formatDate value="${var.endtime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <td>${var.wxinfo.activityName}</td>
                <td>${var.wxgift.giftname}</td>
                <td>${fns:getDictLabel(var.wxgift.gifttype, 'gifttype', '')}</td>
                <td>${var.wxgift.giftcontent}</td>
                <td>${var.wxgift.giftworth}</td>
				<shiro:hasPermission name="wlpt:activity:activityAwardrecord:edit"><td>
					${fns:getDictLabel(var.issue, 'issue', '')}<%-- <c:if test="${var.issue eq 0 and not empty var.issue}">｜<a href="${ctx}/wlpt/activity/activityAwardrecord/pubgift?issue=1&id=${var.id}" onclick="return confirmx('确认要发放该奖品吗？', this.href)">发放</a></c:if> --%>
						<c:if test="${var.wxgift.gifttype eq 0 and var.issue eq 1 and not empty var.issue}">｜<a href="${ctx}/wlpt/activity/activityAwardrecord/pubgift?issue=3&id=${var.id}" onclick="return confirmx('确认已兑换该奖品吗？', this.href)">已兑换</a></c:if>
                    
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>