<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>系统文案管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
$("#btnReset").click(function(){
				
				location.href="${ctx}/wlpt/base/bscAgreement/list?tabPageId=jerichotabiframe_80";
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
		<li class="active"><a href="${ctx}/wlpt/base/bscAgreement/">系统文案列表</a></li>
		<shiro:hasPermission name="wlpt:base:bscAgreement:edit"><li><a href="${ctx}/wlpt/base/bscAgreement/form">系统文案添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bscAgreement" action="${ctx}/wlpt/base/bscAgreement/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>编码：</label>
				<form:input path="code" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li class="btns" style="float:right;"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/><input id="btnReset" class="btn btn-primary" type="button" value="重置"/></li>
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
				<th>名称</th>
				<th>编码</th>
				<th>类型</th>
				<th>排序码</th>
				<th>状态</th>
				<shiro:hasPermission name="wlpt:base:bscAgreement:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bscAgreement">
			<tr>
			    <td class='center' style="width: 30px;">
					<label><input type='checkbox' name='ids' value="${bscAgreement.agreementId}" /></label>
				</td>
				<td><a href="${ctx}/wlpt/base/bscAgreement/form?id=${bscAgreement.agreementId}">
					${bscAgreement.name}
				</a></td>
				<td>${bscAgreement.code}</td>
				<td><c:choose>
					<c:when test="${bscAgreement.type==1}">菜单</c:when> 
					<c:when test="${bscAgreement.type==2}">其他</c:when> 
                    <c:otherwise>链接 </c:otherwise>
				</c:choose></td>
				<td>${bscAgreement.sortcode}</td>
				<td><c:choose>
					<c:when test="${bscAgreement.isdelete==1}">隐藏</c:when> 
                    <c:otherwise>显示 </c:otherwise>
				</c:choose></td>
				<shiro:hasPermission name="wlpt:base:bscAgreement:edit"><td>
    				<a href="${ctx}/wlpt/base/bscAgreement/form?id=${bscAgreement.agreementId}">修改</a>
					<a href="${ctx}/wlpt/base/bscAgreement/delete?id=${bscAgreement.agreementId}" onclick="return confirmx('确认要删除该系统文案吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<table style="width:100%;">
	<tr>
	<shiro:hasPermission name="wlpt:base:bscAgreement:edit"><td style="vertical-align:top;">
	<a class="btn btn-primary" href="${ctx}/wlpt/base/bscAgreement/form">新增</a>
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
						confirmx('您确定删除选中的数据？',"${ctx}/wlpt/base/bscAgreement/deleteAll?DATA_IDS="+str);
		}};
 </script>
</body>
</html>