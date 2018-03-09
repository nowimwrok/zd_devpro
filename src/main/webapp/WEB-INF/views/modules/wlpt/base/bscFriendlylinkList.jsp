<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>友情链接管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
$("#btnReset").click(function(){
				
				location.href="${ctx}/wlpt/base/bscFriendlylink/list?tabPageId=jerichotabiframe_82";
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
		<li class="active"><a href="${ctx}/wlpt/base/bscFriendlylink/">友情链接列表</a></li>
		<shiro:hasPermission name="wlpt:base:bscFriendlylink:edit"><li><a href="${ctx}/wlpt/base/bscFriendlylink/form">友情链接添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="bscFriendlylink" action="${ctx}/wlpt/base/bscFriendlylink/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>网站名字：</label>
				<form:input path="webname" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>网站类型：</label>
				<select id="webtype" name="webtype" path="webtype" htmlEscape="false" maxlength="256" class="input-medium">
                       <option value="">全部</option>
                       <option value="1" <c:if test="${bscFriendlylink.webtype == '1'}">selected</c:if>>政府行业协会</option>
                       <option value="2" <c:if test="${bscFriendlylink.webtype == '2'}">selected</c:if>>商贸网站</option>
                       <option value="3" <c:if test="${bscFriendlylink.webtype == '3'}">selected</c:if>>物流企业</option>
                       <option value="4" <c:if test="${bscFriendlylink.webtype == '4'}">selected</c:if>>互联网企业</option>
                       <option value="5" <c:if test="${bscFriendlylink.webtype == '5'}">selected</c:if>>其他</option>
				</select>
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
				<th>网站名字</th>
				<th>网站路径</th>
				<th>网站类型</th>
				<th>网站信息</th>
				<th>联系人</th>
				<th>联系电话</th>
				<th>联系邮箱</th>
				<th>状态</th>
				<th>更新时间</th>
				<th>是否显示</th>
				<th>所属模块</th>
				<th>排序码</th>
				<shiro:hasPermission name="wlpt:base:bscFriendlylink:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="bscFriendlylink">
			<tr>
			    <td class='center' style="width: 30px;">
					<label><input type='checkbox' name='ids' value="${bscFriendlylink.friendlylinkId}" /></label>
				</td>
				<td><a href="${ctx}/wlpt/base/bscFriendlylink/form?id=${bscFriendlylink.friendlylinkId}">
					${bscFriendlylink.webname}
				</a></td>
				<td>
					${bscFriendlylink.weburl}
				</td>
				<td>
					<c:if test="${bscFriendlylink.webtype == '1'}">政府行业协会</c:if>
                    <c:if test="${bscFriendlylink.webtype == '2'}">商贸网站</c:if>
                    <c:if test="${bscFriendlylink.webtype == '3'}">物流企业</c:if>
                    <c:if test="${bscFriendlylink.webtype == '4'}">互联网企业</c:if>
                    <c:if test="${bscFriendlylink.webtype == '5'}">其他</c:if>
				</td>
				<td>
					${bscFriendlylink.webinfo}
				</td>
				<td>
					${bscFriendlylink.linkname}
				</td>
				<td>
					${bscFriendlylink.linkmobile}
				</td>
				<td>
					${bscFriendlylink.linkemail}
				</td>
				<td>
					<c:if test="${bscFriendlylink.auditstatus == '0'}">待审批</c:if>
					<c:if test="${bscFriendlylink.auditstatus == '1'}">审批通过</c:if>
					<c:if test="${bscFriendlylink.auditstatus == '2'}">审批不通过</c:if>
				</td>
				<td>
					<fmt:formatDate value="${bscFriendlylink.updatetime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<c:if test="${bscFriendlylink.isvisible == '0'}">否</c:if>
					<c:if test="${bscFriendlylink.isvisible == '1'}">是</c:if>
				</td>
				<td>
					<c:if test="${bscFriendlylink.module == '0'}">common</c:if>
					<c:if test="${bscFriendlylink.module == '1'}">wlpt</c:if>
				</td>
				<td>
					${bscFriendlylink.sortcode}
				</td>
				<shiro:hasPermission name="wlpt:base:bscFriendlylink:edit"><td>
    				<a href="${ctx}/wlpt/base/bscFriendlylink/form?id=${bscFriendlylink.friendlylinkId}">修改</a>
					<a href="${ctx}/wlpt/base/bscFriendlylink/delete?id=${bscFriendlylink.friendlylinkId}" onclick="return confirmx('确认要删除该友情链接吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
<table style="width:100%;">
	<tr>
	<shiro:hasPermission name="wlpt:base:bscFriendlylink:edit"><td style="vertical-align:top;">
	<a class="btn btn-primary" href="${ctx}/wlpt/base/bscFriendlylink/form">新增</a>
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
						confirmx('您确定删除选中的数据？',"${ctx}/wlpt/base/bscFriendlylink/deleteAll?DATA_IDS="+str);
		}};
 </script>
</body>
</html>