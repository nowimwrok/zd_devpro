<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>业务数据统计管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function() {
				top.$.jBox.confirm("确认要导出业务数据统计信息数据吗？","系统提示",
					function(v, h, f) {
						if (v == "ok") {
							$("#searchForm").attr("action","${ctx}/wlpt/statistics/statisticsBusiness/statisticsExport");
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
		<li class="active"><a href="${ctx}/wlpt/statistics/statisticsBusiness/">业务数据统计列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="statisticsBusiness" action="${ctx}/wlpt/statistics/statisticsBusiness/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>统计时间(开始):</label> <input
                name="beginCreateDate" type="text" readonly="readonly"
                maxlength="20" class="input-medium Wdate"
                value='<fmt:formatDate value="${statisticsBusiness.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>'
                onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
            - (结束)<input name="endCreateDate" type="text"
                         readonly="readonly" maxlength="20" class="input-medium Wdate"
                         value='<fmt:formatDate value="${statisticsBusiness.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>'
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
				<th colspan="3" style="vertical-align: middle; text-align: center;">招标</th>
				<th colspan="6" style="vertical-align: middle; text-align: center;">运单</th>
				<th colspan="3" style="vertical-align: middle; text-align: center;">合同</th>
				<th rowspan="2" style="vertical-align: middle; text-align: center;">统计时间</th>
			</tr>
			<tr>
				<th>招标数量</th>
				<th>招标总价</th>
				<th>招标总吨位</th>
				
				<th>交易量</th>
				<th>交易吨位</th>
				<th>交易金额</th>
				<th>达到量</th>
				<th>到达吨位</th>
				<th>到达支付金额</th>
				
				<th>结算单数</th>
				<th>结算吨位</th>
				<th>结算金额</th>
				
				<th>统计时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="statisticsBusiness">
			<tr>
				<td>
					${statisticsBusiness.bidcount}
				</td>
				<td>
					${statisticsBusiness.bidprice}
				</td>
				<td>
					${statisticsBusiness.bidweight}
				</td>
				
				<td>
					${statisticsBusiness.trasportcount}
				</td>
				<td>
					${statisticsBusiness.tradeweight}
				</td>
				<td>
					${statisticsBusiness.trademoney}
				</td>
				
				<td>
					${statisticsBusiness.arrivecount}
				</td>
				<td>
					${statisticsBusiness.arriveweight}
				</td>
				<td>
					${statisticsBusiness.arrivemoney}
				</td>
				
				
				<td>
					${statisticsBusiness.settlecount}
				</td>
				<td>
					${statisticsBusiness.settleweight}
				</td>
				<td>
					${statisticsBusiness.settlemoney}
				</td>
				<td>
					<fmt:formatDate value="${statisticsBusiness.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>