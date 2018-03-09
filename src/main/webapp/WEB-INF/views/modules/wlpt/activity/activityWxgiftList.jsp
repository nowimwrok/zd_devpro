<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>奖品列表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
              $("#btnReset").click(function(){
				
				location.href="${ctx}/wlpt/activity/activityWxgift?tabPageId=jerichotabiframe_77";
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
		<li class="active"><a href="${ctx}/wlpt/activity/activityWxgift/">奖品列表</a></li>
		<%-- <shiro:hasPermission name="wlpt:activity:activityWxgift:edit"><li><a href="${ctx}/wlpt/activity/activityWxgift/form">奖品列表添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="activityWxgift" action="${ctx}/wlpt/activity/activityWxgift?tabPageId=jerichotabiframe_77" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li style="margin-left:-40px;"><label>奖品名称：</label>
				<form:input path="giftname"  htmlEscape="false" maxlength="64" class="input-medium" />
			</li>
			<li><label>奖品类型：</label>
				<form:select path="gifttype" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('gifttype')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			
			<li><label>创建时间(开始)：</label>
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
            <th>奖品名称</th>
            <th>活动说明</th>
            <th>奖品数量</th>
            <th>每天奖品量</th>
            <th>中奖机率</th>
            <th>奖品价值</th>
            <th>奖品剩余</th>
            <th>奖品类型</th>
            <th>中奖人数</th>
            <th>创建时间</th>
            <th>修改时间</th>
            <th>是否删除</th>
			<shiro:hasPermission name="wlpt:activity:activityWxgift:edit"><th>操作</th></shiro:hasPermission>
			
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="activityWxgift" varStatus="vs">
			<tr>
				<td class='center' style="width: 30px;">${vs.index+1}</td>

                <td>${activityWxgift.giftname}</td>
                <td>${activityWxgift.giftcontent}</td>
                <td>${activityWxgift.giftnum}</td>
                <td>${activityWxgift.giftdaynum}</td>
                <td>${activityWxgift.chance}</td>
                <td>${activityWxgift.giftworth}</td>
                <td>${activityWxgift.surplusnum}</td>
                <td>${fns:getDictLabel(activityWxgift.gifttype, 'gifttype', '')}</td>
                <td>${activityWxgift.winnum}</td>
                <td><fmt:formatDate value="${activityWxgift.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <td><fmt:formatDate value="${activityWxgift.updatetime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <td>${activityWxgift.isdelete==0?'否':'是'}</td>
				<shiro:hasPermission name="wlpt:activity:activityWxgift:edit"><td>
    				<a href="${ctx}/wlpt/activity/activityWxgift/form?id=${activityWxgift.id}">修改</a>
					<a href="${ctx}/wlpt/activity/activityWxgift/delete?id=${activityWxgift.id}" onclick="return confirmx('确认要删除该奖品吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>