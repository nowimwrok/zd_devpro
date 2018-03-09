<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>意见反馈管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
$("#btnReset").click(function(){
				
				location.href="${ctx}/wlpt/base/baseFeedback/list?tabPageId=jerichotabiframe_90";
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
		<li class="active"><a href="${ctx}/wlpt/base/baseFeedback/">意见反馈列表</a></li>
		<!-- <shiro:hasPermission name="wlpt:base:baseFeedback:edit"><li><a href="${ctx}/wlpt/base/baseFeedback/form">意见反馈添加</a></li></shiro:hasPermission> -->
	</ul>
	<form:form id="searchForm" modelAttribute="baseFeedback" action="${ctx}/wlpt/base/baseFeedback/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>反馈系统：</label>
				<select id="scantype" name="scantype" path="scantype" htmlEscape="false" maxlength="256" class="input-medium">
                       <option value="">全部</option>
                       <option value="1" <c:if test="${baseFeedback.scantype == '1'}">selected</c:if>>物流平台</option>
                       <option value="2" <c:if test="${baseFeedback.scantype == '2'}">selected</c:if>>Android</option>
                       <option value="3" <c:if test="${baseFeedback.scantype == '3'}">selected</c:if>>WebChat</option>
                       <option value="4" <c:if test="${baseFeedback.scantype == '4'}">selected</c:if>>IOS</option>
				</select>
			</li>
			<li class="btns" style="float:right;"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/><input type="button" value="重置" class="btn btn-primary" id="btnReset"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
			    <th class="center">
					<label><input type="checkbox" id="zcheckbox" /></label>
				</th>
				<th>反馈内容</th>
				<th>反馈用户手机</th>
				<th>反馈时间</th>
				<th>反馈系统</th>
				<th>应答内容</th>
				<th>应答时间</th>
				<th>应答姓名</th>
				<shiro:hasPermission name="wlpt:base:baseFeedback:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="baseFeedback">
			<tr>
			    <td class='center' style="width: 30px;">
					<label><input type='checkbox' name='ids' value="${baseFeedback.feedbackId}" /></label>
				</td>
				<td><a href="${ctx}/wlpt/base/baseFeedback/form?id=${baseFeedback.feedbackId}">
					${baseFeedback.content}
				</a></td>
				<td>
					${baseFeedback.phone}
				</td>
				<td>
					<fmt:formatDate value="${baseFeedback.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<c:if test="${baseFeedback.scantype == '1'}">物流平台</c:if>
					<c:if test="${baseFeedback.scantype == '2'}">Android</c:if>
					<c:if test="${baseFeedback.scantype == '3'}">WebChat</c:if>
					<c:if test="${baseFeedback.scantype == '4'}">IOS</c:if>
				</td>
				<td>
					${baseFeedback.responsecontent}
				</td>
				<td>
					<fmt:formatDate value="${baseFeedback.responsetime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${baseFeedback.responseusername}
				</td>
				<shiro:hasPermission name="wlpt:base:baseFeedback:edit"><td>
    				<a href="${ctx}/wlpt/base/baseFeedback/form?id=${baseFeedback.feedbackId}">应答</a>
					<a href="${ctx}/wlpt/base/baseFeedback/delete?id=${baseFeedback.feedbackId}" onclick="return confirmx('确认要删除该意见反馈吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<table style="width:100%;">
	<tr>
	<shiro:hasPermission name="wlpt:base:baseFeedback:edit"><td style="vertical-align:top;">
	<!-- <a class="btn btn-primary" href="${ctx}/wlpt/base/baseFeedback/form">新增</a>   -->
	<a class="btn btn-primary" onclick="makeAll();" title="批量删除" ><i class='icon-trash'></i></a>
	
	</td></shiro:hasPermission>
	<td>
	<div class="pagination">${page}</div>
	</td>
	</tr>
	</table>
	<script type="text/javascript">
		
		$(function() {
			//复选框
			$('table th input:checkbox').on('click' , function(){
				var that = this;
				$(this).closest('table').find('tr > td:first-child input:checkbox')
				.each(function(){
					this.checked = that.checked;
					$(this).closest('tr').toggleClass('selected');
				});	
			});
		});
		//批量操作
		function makeAll(){
					var str = '';
					for(var i=0;i < document.getElementsByName('ids').length;i++)
					{
						  if(document.getElementsByName('ids')[i].checked){
						  	if(str=='') str += document.getElementsByName('ids')[i].value;
						  	else str += ',' + document.getElementsByName('ids')[i].value;
						  }
					}
					if(str==''){
						//var a=confirmx('您没有选择任何数据','${ctx}/wlpt/base/bscAgreement/');
						return;
					}else{
						confirmx('您确定删除选中的数据？',"${ctx}/wlpt/base/baseFeedback/deleteAll?DATA_IDS="+str);
		}};
 </script>
</body>
</html>