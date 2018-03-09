<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>诚信积分统计管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnExport").click(function() {
				top.$.jBox.confirm("确认要导出诚信积分统计信息数据吗？","系统提示",
					function(v, h, f) {
						if (v == "ok") {
							$("#searchForm").attr("action","${ctx}/wlpt/statistics/statisticsScore/statisticsExport");
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
		<li class="active"><a href="${ctx}/wlpt/statistics/statisticsScore/">诚信积分统计列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="statisticsScore" action="${ctx}/wlpt/statistics/statisticsScore/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>统计时间(开始):</label> <input
                name="beginCreateDate" type="text" readonly="readonly"
                maxlength="20" class="input-medium Wdate"
                value='<fmt:formatDate value="${statisticsScore.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>'
                onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
            - (结束)<input name="endCreateDate" type="text"
                         readonly="readonly" maxlength="20" class="input-medium Wdate"
                         value='<fmt:formatDate value="${statisticsScore.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>'
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
				<th colspan="5" style="vertical-align: middle; text-align: center;">等级0</th>
				<th colspan="5" style="vertical-align: middle; text-align: center;">等级1</th>
				<th colspan="5" style="vertical-align: middle; text-align: center;">等级2</th>
				<th colspan="5" style="vertical-align: middle; text-align: center;">等级3</th>
				<th colspan="5" style="vertical-align: middle; text-align: center;">等级4</th>
				<th colspan="5" style="vertical-align: middle; text-align: center;">等级5</th>
				<th colspan="5" style="vertical-align: middle; text-align: center;">总量</th>
				<th rowspan="2" style="vertical-align: middle; text-align: center;">统计时间</th>
			</tr>
			<tr>
				<th>会员数量</th>
				<th>总授信</th>
				<th>可用授信</th>
				<th>押金－担保金</th>
				<th>比例</th>
				<th>会员数量</th>
				<th>总授信</th>
				<th>可用授信</th>
				<th>押金－担保金</th>
				<th>比例</th>
				<th>会员数量</th>
				<th>总授信</th>
				<th>可用授信</th>
				<th>押金－担保金</th>
				<th>比例</th>
				<th>会员数量</th>
				<th>总授信</th>
				<th>可用授信</th>
				<th>押金－担保金</th>
				<th>比例</th>
				<th>会员数量</th>
				<th>总授信</th>
				<th>可用授信</th>
				<th>押金－担保金</th>
				<th>比例</th>
				<th>会员数量</th>
				<th>总授信</th>
				<th>可用授信</th>
				<th>押金－担保金</th>
				<th>比例</th>
				<th>会员数量</th>
				<th>总授信</th>
				<th>可用授信</th>
				<th>押金－担保金</th>
				<th>比例</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="statisticsScore">
			<tr>
				<td>
					${statisticsScore.zerothCustnum}
				</td>
				<td>
					${statisticsScore.zerothAllcredit}
				</td>
				<td>
					${statisticsScore.zerothDocredit}
				</td>
				<td>
					${statisticsScore.zerothDeposit}
				</td>
				<td>
					${statisticsScore.zerothProportion}
				</td>
				<td>
					${statisticsScore.firstCustnum}
				</td>
				<td>
					${statisticsScore.firstAllcredit}
				</td>
				<td>
					${statisticsScore.firstDocredit}
				</td>
				<td>
					${statisticsScore.firstDeposit}
				</td>
				<td>
					${statisticsScore.firstProportion}
				</td>
				<td>
					${statisticsScore.secondCustnum}
				</td>
				<td>
					${statisticsScore.secondAllcredit}
				</td>
				<td>
					${statisticsScore.secondDocredit}
				</td>
				<td>
					${statisticsScore.secondDeposit}
				</td>
				<td>
					${statisticsScore.secondProportion}
				</td>
				<td>
					${statisticsScore.thirdCustnum}
				</td>
				<td>
					${statisticsScore.thirdAllcredit}
				</td>
				<td>
					${statisticsScore.thirdDocredit}
				</td>
				<td>
					${statisticsScore.thirdDeposit}
				</td>
				<td>
					${statisticsScore.thirdProportion}
				</td>
				<td>
					${statisticsScore.fourthCustnum}
				</td>
				<td>
					${statisticsScore.fourthAllcredit}
				</td>
				<td>
					${statisticsScore.fourthDocredit}
				</td>
				<td>
					${statisticsScore.fourthDeposit}
				</td>
				<td>
					${statisticsScore.fourthProportion}
				</td>
				<td>
					${statisticsScore.fifthCustnum}
				</td>
				<td>
					${statisticsScore.fifthAllcredit}
				</td>
				<td>
					${statisticsScore.fifthDocredit}
				</td>
				<td>
					${statisticsScore.fifthDeposit}
				</td>
				<td>
					${statisticsScore.fifthProportion}
				</td>
				<td>
					${statisticsScore.totlaCustnum}
				</td>
				<td>
					${statisticsScore.totlaAllcredit}
				</td>
				<td>
					${statisticsScore.totlaDocredit}
				</td>
				<td>
					${statisticsScore.totlaDeposit}
				</td>
				<td>
					${statisticsScore.totlaProportion}
				</td>
				<td>
					<fmt:formatDate value="${statisticsScore.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>