<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户认证统计表管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function() {
				top.$.jBox.confirm("确认要导出用户认证统计信息数据吗？","系统提示",
					function(v, h, f) {
						if (v == "ok") {
							$("#searchForm").attr("action","${ctx}/wlpt/statistics/statisticsAuthen/statisticsExport");
							$("#searchForm").submit();
						}
					},
					{
						buttonsFocus : 1
					});
				top.$('.jbox-body .jbox-icon').css('top', '55px');
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
		<li class="active"><a href="${ctx}/wlpt/statistics/statisticsAuthen/">用户认证统计表列表</a></li>
		</ul>
	<form:form id="searchForm" modelAttribute="statisticsAuthen" action="${ctx}/wlpt/statistics/statisticsAuthen/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			
			<li><label>创建时间(开始):</label> <input
                name="beginCreateDate" type="text" readonly="readonly"
                maxlength="20" class="input-medium Wdate"
                value='<fmt:formatDate value="${statisticsAuthen.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>'
                onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
            - (结束)<input name="endCreateDate" type="text"
                         readonly="readonly" maxlength="20" class="input-medium Wdate"
                         value='<fmt:formatDate value="${statisticsAuthen.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>'
                         onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
        </li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
			<input id="btnExport" class="btn btn-primary" type="button" value="导出" />
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>认证中</th>
				<th>已认证</th>
				<th>认证不通过</th>
				<th>申请认证</th>
				<th>所有认证数</th>
				<th>创建时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="statisticsAuthen">
			<tr>
				<td>
					${statisticsAuthen.authening}
				</td>
				<td>
					${statisticsAuthen.authened}
				</td>
				<td>
					${statisticsAuthen.authenfailed}
				</td>
				<td>
					${statisticsAuthen.applyauthen}
				</td>
				
				<td>
					${statisticsAuthen.allauthen}
				</td>
				<td>
					<fmt:formatDate value="${statisticsAuthen.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>