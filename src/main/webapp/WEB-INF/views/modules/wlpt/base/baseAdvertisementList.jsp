<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>广告管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
$("#btnReset").click(function(){
				
				location.href="${ctx}/wlpt/base/baseAdvertisement/list?tabPageId=jerichotabiframe_87";
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
		<li class="active"><a href="${ctx}/wlpt/base/baseAdvertisement/">广告列表</a></li>
		<shiro:hasPermission name="wlpt:base:baseAdvertisement:edit"><li><a href="${ctx}/wlpt/base/baseAdvertisement/form">广告添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="baseAdvertisement" action="${ctx}/wlpt/base/baseAdvertisement/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>广告标题：</label>
				<form:input path="adverttitle" htmlEscape="false" maxlength="256" class="input-medium"/>
			</li>
			<li><label>广告名称：</label>
				<form:input path="advertname" htmlEscape="false" maxlength="256" class="input-medium"/>
			</li>
			<li><label>应用系统：</label>
				<select id="accesssystemcode" name="accesssystemcode" path="accesssystemcode" htmlEscape="false" maxlength="256" class="input-medium">
				    <option value="">全部</option>
					<option value="0" <c:if test="${baseAdvertisement.accesssystemcode == '0'}">selected</c:if>>门户网站</option>
					<option value="1" <c:if test="${baseAdvertisement.accesssystemcode == '1'}">selected</c:if>>物流平台</option>
				</select>
			</li>
			<li><label>状态：</label>
				<select id="isdelete" name="isdelete" path="isdelete" htmlEscape="false" maxlength="256" class="input-medium">
					<option value="">全部</option>
					<option value="0" <c:if test="${baseAdvertisement.isdelete == '0'}">selected</c:if>>显示</option>
					<option value="1" <c:if test="${baseAdvertisement.isdelete == '1'}">selected</c:if>>隐藏</option>
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
				<th>应用系统</th>
				<th>广告标题</th>
				<th>广告名称</th>
				<th>文件大小(KB)</th>
				<th>广告尺寸</th>
				<th>摆放位置</th>
				<th>图片名称</th>
				<th>图片</th>
				<th>背景颜色</th>
				<th>链接地址</th>
				<th>排序码</th>
				<th>上传者</th>
				<th>上传时间</th>
				<th>是否显示</th>
				<shiro:hasPermission name="wlpt:base:baseAdvertisement:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="baseAdvertisement">
			<tr>
			     <td class='center' style="width: 30px;">
					<label><input type='checkbox' name='ids' value="${baseAdvertisement.advertisementId}" /></label>
				</td>
				<td>
				    <c:if test="${baseAdvertisement.accesssystemcode == '0'}">门户网站</c:if>
					<c:if test="${baseAdvertisement.accesssystemcode == '1'}">物流平台</c:if>
				</td>
				<td><a href="${ctx}/wlpt/base/baseAdvertisement/form?id=${baseAdvertisement.advertisementId}">
					${baseAdvertisement.adverttitle}
				</a></td>
				<td>
					${baseAdvertisement.advertname}
				</td>
				<td>
					${baseAdvertisement.advertbytes}
				</td>
				<td>
					${baseAdvertisement.advertsize}
				</td>
				<td>
				    <c:if test="${baseAdvertisement.accesssystemcode == '0' }">
					  <c:choose>
						<c:when test="${baseAdvertisement.positionid == '0' }">上面(首页轮播)</c:when>
						<c:when test="${baseAdvertisement.positionid== '1' }">中间广告</c:when>
						<c:when test="${baseAdvertisement.positionid== '2' }">左边广告</c:when>
						<c:otherwise>右边广告</c:otherwise>
					  </c:choose>
					</c:if>
					<c:if test="${baseAdvertisement.accesssystemcode == '1' }">
					  <c:choose>
						<c:when test="${baseAdvertisement.positionid== '0' }">上面(首页轮播)</c:when>
						<c:when test="${baseAdvertisement.positionid== '1' }">中间广告</c:when>
						<c:when test="${baseAdvertisement.positionid== '2' }">左边广告</c:when>
						<c:otherwise>右边广告</c:otherwise>
					  </c:choose>
					</c:if>
				</td>
				<td>
					${baseAdvertisement.picname}
				</td>
				<!--                                                         
				<td>     
				<a href="/zd-logistics/userfiles/1/files/wlpt/base/baseAdvertisement/${baseAdvertisement.picture}" title="${baseAdvertisement.picture}"> 
				   <img src="/zd-logistics/userfiles/1/files/wlpt/base/baseAdvertisement/${baseAdvertisement.picture}" alt="${baseAdvertisement.picture}" width="100" style="height:50px"/></a>
				</td>
				 -->  
				 <td>
				  <img onclick="addTabPage('广告图片', '${baseAdvertisement.picture}');" src="${baseAdvertisement.picture}" alt="${baseAdvertisement.picname}" width="100" style="height:50px;cursor:pointer"/>
				 </td>
				<td>
					${baseAdvertisement.backgroundcolor}
				</td>
				<td>
					${baseAdvertisement.linkaddress}
				</td>
				<td>
					${baseAdvertisement.sortcode}
				</td>
				<td>
					${baseAdvertisement.uploader}
				</td>
				<td>
					${baseAdvertisement.uploadtime}
				</td>
				<td>
				    <c:choose>
						<c:when test="${baseAdvertisement.isdelete eq '0'}">显示 </c:when>
					    <c:otherwise> 隐藏</c:otherwise>
					</c:choose>
				</td>
				<shiro:hasPermission name="wlpt:base:baseAdvertisement:edit"><td>
    				<a href="${ctx}/wlpt/base/baseAdvertisement/form?id=${baseAdvertisement.advertisementId}">修改</a>
					<a href="${ctx}/wlpt/base/baseAdvertisement/delete?id=${baseAdvertisement.advertisementId}" onclick="return confirmx('确认要删除该base_advertisement吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<table style="width:100%;">
	<tr>
	<shiro:hasPermission name="wlpt:base:baseAdvertisement:edit"><td style="vertical-align:top;">
	<a class="btn btn-primary" href="${ctx}/wlpt/base/baseAdvertisement/form">新增</a>
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
						confirmx('您确定删除选中的数据？',"${ctx}/wlpt/base/baseAdvertisement/deleteAll?DATA_IDS="+str);
		}};
 </script>
</body>
</html>