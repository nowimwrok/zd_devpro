<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>货源运输量统计管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function() {
				top.$.jBox.confirm("确认要导出货源运输量统计信息数据吗？","系统提示",
					function(v, h, f) {
						if (v == "ok") {
							$("#searchForm").attr("action","${ctx}/wlpt/statistics/statisticsTradetype/statisticsExport");
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
		<li class="active"><a href="${ctx}/wlpt/statistics/statisticsTradetype/">货源运输量统计列表</a></li>
		
	</ul>
	<form:form id="searchForm" modelAttribute="statisticsTradetype" action="${ctx}/wlpt/statistics/statisticsTradetype/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			
			<li><label>统计时间(开始):</label> <input
                name="tradetypevo.beginCreateDate" type="text" readonly="readonly"
                maxlength="20" class="input-medium Wdate"
                value='<fmt:formatDate value="${statisticsTradetype.tradetypevo.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>'
                onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
            - (结束)<input name="tradetypevo.endCreateDate" type="text"
                         readonly="readonly" maxlength="20" class="input-medium Wdate"
                         value='<fmt:formatDate value="${statisticsTradetype.tradetypevo.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>'
                         onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
        </li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
			<!-- <input id="btnExport" class="btn btn-primary" type="button" value="导出" /> -->
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				
				<th>成品运输量</th>
				<th>成品运输吨位</th>
				<th>成品运费</th>
				<th>原材料运输量</th>
				<th>原材料运输吨位</th>
				<th>原材料运费</th>
				
				<th>新运单</th>
				<th>已取消运单</th>
				<th>已提货运单</th>
				<th>待提货</th>
				<th>待支付</th>
				<th>已支付</th>
				<th>统计时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="statisticsTradetype">
			<tr>
				
				<td>
					${statisticsTradetype.tradetypevo.ctrasportcount}
				</td>
				<td>
					${statisticsTradetype.tradetypevo.ctransportweight}
				</td>
				<td>
					${statisticsTradetype.tradetypevo.ctransportmoney}
				</td>
				<td>
					${statisticsTradetype.tradetypevo.ytrasportcount}
				</td>
				<td>
					${statisticsTradetype.tradetypevo.ytransportweight}
				</td>
				<td>
					${statisticsTradetype.tradetypevo.ytransportmoney}
				</td>
				
				<td>
					${statisticsTradetype.tradetypevo.newordermoney}
				</td>
				<td>
					${statisticsTradetype.tradetypevo.cancelordermoney}
				</td>
				<td>
					${statisticsTradetype.tradetypevo.takegdordermoney}
				</td>
				<td>
					${statisticsTradetype.tradetypevo.waitinggdordermoney}
				</td>
				<td>
					${statisticsTradetype.tradetypevo.waitingpay}
				</td>
				<td>
					${statisticsTradetype.tradetypevo.pay}
				</td>
				<td>
					<fmt:formatDate value="${statisticsTradetype.tradetypevo.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>