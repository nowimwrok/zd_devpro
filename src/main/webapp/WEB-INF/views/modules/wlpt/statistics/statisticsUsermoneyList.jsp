<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>账户资金统计管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function() {
				top.$.jBox.confirm("确认要导出账户资金统计信息数据吗？","系统提示",
					function(v, h, f) {
						if (v == "ok") {
							$("#searchForm").attr("action","${ctx}/wlpt/statistics/statisticsUsermoney/statisticsExport");
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
		<li class="active"><a href="${ctx}/wlpt/statistics/statisticsUsermoney/">账户资金统计列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="statisticsUsermoney" action="${ctx}/wlpt/statistics/statisticsUsermoney/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>统计时间(开始):</label> <input
                name="beginCreateDate" type="text" readonly="readonly"
                maxlength="20" class="input-medium Wdate"
                value='<fmt:formatDate value="${statisticsUsermoney.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>'
                onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
            - (结束)<input name="endCreateDate" type="text"
                         readonly="readonly" maxlength="20" class="input-medium Wdate"
                         value='<fmt:formatDate value="${statisticsUsermoney.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>'
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
				<th>账户资金</th>
				<!-- <th>授信资金</th> -->
				<th>平台余额支出</th>
				<th>余额入账</th>
				<!-- <th>授信入账</th>
				<th>授信出账</th> -->
				
				<th>油气金额</th>
				<th>运费退款</th>
				<!-- <th>油气返现</th> -->
				<!-- <th>授信运费返款</th>
				<th>授信油气返款</th> -->
				<th>争议返款</th>
				<th>统计时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="statisticsUsermoney">
			<tr>
				<td>
					${statisticsUsermoney.webbalance}
				</td>
				<%-- <td>
					${statisticsUsermoney.credit}
				</td> --%>
				<td>
					${statisticsUsermoney.webchu}
				</td>
				<td>
					${statisticsUsermoney.webru}
				</td>
				<%-- <td>
					${statisticsUsermoney.creditru}
				</td>
				<td>
					${statisticsUsermoney.creditchu}
				</td> --%>
				
				<td>
					${statisticsUsermoney.petrolebalance}
				</td>
				<td>
					${statisticsUsermoney.returnmoney}
				</td>
				<%-- <td>
					${statisticsUsermoney.returnfreight}
				</td> --%>
				<%-- <td>
					${statisticsUsermoney.creditfreightrebates}
				</td>
				<td>
					${statisticsUsermoney.creditgasrebate}
				</td> --%>
				<td>
					${statisticsUsermoney.refunddisputes}
				</td>
				<td>
					<fmt:formatDate value="${statisticsUsermoney.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>