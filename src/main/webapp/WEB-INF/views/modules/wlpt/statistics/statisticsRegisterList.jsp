<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户注册统计管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function() {
				top.$.jBox.confirm("确认要导出用户注册统计信息数据吗？","系统提示",
					function(v, h, f) {
						if (v == "ok") {
							$("#searchForm").attr("action","${ctx}/wlpt/statistics/statisticsRegister/statisticsExport");
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
		<li class="active"><a href="${ctx}/wlpt/statistics/statisticsRegister/">用户注册统计列表</a></li>
		</ul>
	<form:form id="searchForm" modelAttribute="statisticsRegister" action="${ctx}/wlpt/statistics/statisticsRegister/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			
			<li><label>统计时间(开始):</label> <input
                name="beginCreateDate" type="text" readonly="readonly"
                maxlength="20" class="input-medium Wdate"
                value='<fmt:formatDate value="${statisticsRegister.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>'
                onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
            - (结束)<input name="endCreateDate" type="text"
                         readonly="readonly" maxlength="20" class="input-medium Wdate"
                         value='<fmt:formatDate value="${statisticsRegister.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>'
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
				<th>车主量</th>
				<th>货主量</th>
				<th>物流企业量</th>
				
				<th>当前平台注册总量</th>
				<th>统计时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="statisticsRegister">
			<tr>
				<td>
					${statisticsRegister.careverycount}
				</td>
				<td>
					${statisticsRegister.goodeverycount}
				</td>
				<td>
					${statisticsRegister.compeverycount}
				</td>
				
				<td>
					${statisticsRegister.allcount}
				</td>
				
				<td>
					<fmt:formatDate value="${statisticsRegister.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>