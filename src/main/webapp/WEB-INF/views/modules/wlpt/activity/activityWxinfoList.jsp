<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>活动信息管理</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
	.open{
		display: none;
	}
	
	</style>
	<script type="text/javascript">
		$(document).ready(function() {
$("#btnReset").click(function(){
				
				location.href="${ctx}/wlpt/activity/activityWxinfo?tabPageId=jerichotabiframe_76";
			});
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		function showinfo(e) {
		    $(e).closest('tr').next().toggleClass('open');
		    
		};
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/wlpt/activity/activityWxinfo/">活动信息列表</a></li>
		<shiro:hasPermission name="wlpt:activity:activityWxinfo:edit"><li><a href="${ctx}/wlpt/activity/activityWxinfo/form">活动信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="activityWxinfo" action="${ctx}/wlpt/activity/activityWxinfo?tabPageId=jerichotabiframe_76" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>活动名称：</label>
				<form:input path="activityName"  htmlEscape="false" maxlength="64" class="input-medium" />
			</li>
			<li><label>活动状态：</label>
				<form:select path="iseffective" class="input-medium">
					<form:option value="" label="状态"/>
					<form:options items="${fns:getDictList('iseffective')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>活动类型：</label>
				<form:select path="type" class="input-medium">
					<form:option value="" label="类型"/>
					<form:options items="${fns:getDictList('activity_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>开始时间：</label>
				<input name="starttime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${activityWxinfo.starttime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/> 
			</li>
			<li><label>结束时间：</label>
				<input name="endtime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${activityWxinfo.endtime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
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
			<th>下拉</th>
            <th>活动名称</th>
            <th>活动说明</th>
            <th>开始时间</th>
            <th>结束时间</th>
            <th>活动状态</th>
            <th>活动对象</th>
			<th>活动类型</th>
			<th>浏览量</th>
            <th>中奖量</th>
            <th>创建时间</th>
            <th>修改时间</th>
            <th>是否删除</th>
			
				<shiro:hasPermission name="wlpt:activity:activityWxinfo:edit"><th>操作</th></shiro:hasPermission>
			
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="activityWxinfo" varStatus="vs">
			
			<tr>     
                <td class='center' style="width: 30px;">${vs.index+1}</td>
                <td class="center">
                    <div class="action-buttons" id="show-details-btn"  >
                       	<a onclick="showinfo(this)" class="green bigger-140 show-details-btn" title="Show Details">查看</a>
                    </div>
                </td>
                <td>${activityWxinfo.activityName}</td>
                <td>${activityWxinfo.activityContent}</td>
                <td><fmt:formatDate value="${activityWxinfo.starttime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <td><fmt:formatDate value="${activityWxinfo.endtime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <td>
                	${fns:getDictLabel(activityWxinfo.iseffective, 'iseffective', '')}
                </td>
                <td>${activityWxinfo.roletype}</td>
				<td>
					${fns:getDictLabel(activityWxinfo.type, 'activity_type', '')}
				</td>
                <td>${activityWxinfo.scannum}</td>
                <td>${activityWxinfo.winnum}</td>
                <td><fmt:formatDate value="${activityWxinfo.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <td><fmt:formatDate value="${activityWxinfo.updatetime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <td>${activityWxinfo.isdelete==0?'否':'是'}</td>
				<shiro:hasPermission name="wlpt:activity:activityWxinfo:edit"><td>
    				<a href="${ctx}/wlpt/activity/activityWxinfo/form?id=${activityWxinfo.id}">修改</a>
    				<a href="${ctx}/wlpt/activity/activityWxgift/form?pagetype=info&wxinfo.id=${activityWxinfo.id}">添加礼物</a>
					<a href="${ctx}/wlpt/activity/activityWxinfo/delete?id=${activityWxinfo.id}" onclick="return confirmx('确认要删除该活动信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
			<tr class="detail-row open" >
                <td colspan="16">
                    <table class="table table-condensed">
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
                        <th>操作</th>
                        </thead>
                        <tbody>
                        <c:if test="${not empty groupList}">
                        <c:forEach items="${groupList}" var="gpvar" varStatus="gp">
                            <c:if test="${gpvar.wxinfo.id==activityWxinfo.id}">
                                <tr>
                                    <td class='center' style="width: 30px;">${gp.index+1}</td>
                                    <td>${gpvar.giftname}</td>
                                    <td>${gpvar.giftcontent}</td>
                                    <td>${gpvar.giftnum}</td>
                                    <td>${gpvar.giftdaynum}</td>
                                    <td>${gpvar.chance}</td>
                                    <td>${gpvar.giftworth}</td>
                                    <td>${gpvar.surplusnum}</td>
                                    <td>${fns:getDictLabel(gpvar.gifttype, 'gifttype', '')}</td>
                                    <td>${gpvar.winnum}</td>
                                    <td>发放</td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        </c:if>
                        </tbody>
                    </table>
                </td>
            </tr>
			
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>