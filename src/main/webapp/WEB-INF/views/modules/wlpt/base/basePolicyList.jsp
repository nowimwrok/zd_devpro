<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>政策公告管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
$("#btnReset").click(function(){
				
				location.href="${ctx}/wlpt/base/basePolicy/list?tabPageId=jerichotabiframe_86";
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
		<li class="active"><a href="${ctx}/wlpt/base/basePolicy/">政策公告列表</a></li>
		<shiro:hasPermission name="wlpt:base:basePolicy:edit"><li><a href="${ctx}/wlpt/base/basePolicy/form">政策公告添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="basePolicy" action="${ctx}/wlpt/base/basePolicy/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>政策标题：</label>
				<form:input path="title" htmlEscape="false" maxlength="512" class="input-medium"/>
			</li>
			<li><label>发布时间(开始)：</label>
				<input name="beginReleaseTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${basePolicy.beginReleaseTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/> - (结束)：
				<input name="endReleaseTime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${basePolicy.endReleaseTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/><input id="btnReset" class="btn btn-primary" type="button" value="重置"/></li>
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
				<th>政策标题</th>
				<th>点击量</th>
				<th>发布时间</th>
				<shiro:hasPermission name="wlpt:base:basePolicy:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="basePolicy">
			<tr>
			    <td class='center' style="width: 30px;">
					<label><input type='checkbox' name='ids' value="${basePolicy.id}" /></label>
				</td>
				<td><a href="${ctx}/wlpt/base/basePolicy/form?id=${basePolicy.id}">
					${basePolicy.title}
				</a></td>
				<td>${basePolicy.hot}</td>
				<td>${basePolicy.time}</td>
				<shiro:hasPermission name="wlpt:base:basePolicy:edit"><td>
    				<a href="${ctx}/wlpt/base/basePolicy/form?id=${basePolicy.id}">修改</a>
					<a href="${ctx}/wlpt/base/basePolicy/delete?id=${basePolicy.id}" onclick="return confirmx('确认要删除该政策公告吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<table style="width:100%;">
	<tr>
	<shiro:hasPermission name="wlpt:base:basePolicy:edit"><td style="vertical-align:top;">
	<a class="btn btn-primary" href="${ctx}/wlpt/base/basePolicy/form">新增</a>
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
						confirmx('您确定删除选中的数据？',"${ctx}/wlpt/base/basePolicy/deleteAll?DATA_IDS="+str);
		}};
 </script>
</body>
</html>