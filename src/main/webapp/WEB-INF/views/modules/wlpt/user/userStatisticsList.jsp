<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>用户数据统计管理</title>
	<meta name="decorator" content="default"/>
	<style>
th, td {
	text-align: center !important;
}

.select2-choice {
	width: 166px;
	text-align: center;
}

#loginName {
	width: 176px !important;
}

#phone {
	width: 176px !important;
}

.active:hover {
	cursor: pointer;
}
</style>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#btnReset").click(function() {
				$("#userId").val('');
				$("#userName").val('');
				$("#accruelogincount").val('');
				$("#continuelogincount").val('');
				$("#tradeordercount").val('');
				$("#successtrade").val('');
				$("#canceltrade").val('');
				$("#judgetrade").val('');
				/* $("#goodjudge").val('');
				$("#middlejudge").val('');
				$("#badjudge").val(''); */
				$("#rechargemoney").val('');
				$("#pubgodscount").val('');
				$("#quotecount").val('');
				$("#cancelgodscount").val('');
				$("#addcarcount").val('');
				$("#pubbidcount").val('');
				$("#cancelbidcount").val('');
				$("#biddingcount").val('');
			});
			$("#btnExport").click(function() {
				top.$.jBox.confirm("确认要导出用户数据统计信息数据吗？","系统提示",
					function(v, h, f) {
						if (v == "ok") {
							$("#searchForm").attr("action","${ctx}/wlpt/user/userStatistics/statisticsExport");
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
		<li class="active"><a href="${ctx}/wlpt/user/userStatistics/">用户数据统计列表</a></li>
		
	</ul>
	<form:form id="searchForm" modelAttribute="userStatistics" action="${ctx}/wlpt/user/userStatistics/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>用户：</label>
				<sys:treeselect id="user" name="user.id" value="${userStatistics.user.id}" labelName="user.name" labelValue="${userStatistics.user.name}"
					title="用户" url="/sys/office/treeData?type=3" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<%-- <li><label>累计登录天数：</label>
				<form:input path="accruelogincount" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>连续登录天数：</label>
				<form:input path="continuelogincount" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>交易接单总数：</label>
				<form:input path="tradeordercount" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>成功交易单数：</label>
				<form:input path="successtrade" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>取消交易单数：</label>
				<form:input path="canceltrade" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>已评价单数：</label>
				<form:input path="judgetrade" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li> --%>
			<%-- <li><label>好评：</label>
				<form:input path="goodjudge" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>中评：</label>
				<form:input path="middlejudge" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>差评：</label>
				<form:input path="badjudge" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li> --%>
			<%-- <li><label>累计充值金额：</label>
				<form:input path="rechargemoney" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>发布货源量：</label>
				<form:input path="pubgodscount" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>报价次数：</label>
				<form:input path="quotecount" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>取消或删除货源量：</label>
				<form:input path="cancelgodscount" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>添加车数据量：</label>
				<form:input path="addcarcount" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>发布招标量：</label>
				<form:input path="pubbidcount" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>废标次数：</label>
				<form:input path="cancelbidcount" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li>
			<li><label>成功竞标量：</label>
				<form:input path="biddingcount" htmlEscape="false" maxlength="11" class="input-medium"/>
			</li> --%>
			
			
			<li><label>数据状态：</label>
				<form:radiobuttons path="delFlag" items="${fns:getDictList('del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
			<input
				type="button" id="btnReset" class="btn btn-primary" value="重置" /> <input
				id="btnExport" class="btn btn-primary" type="button" value="导出" /></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th rowspan="2" class="center" style="vertical-align: middle">序号</th>
				<th colspan="3" class="center" style="vertical-align: middle">用户信息</th>
				<th colspan="2" class="center ">登录统计</th>
				<th colspan="7" class="center ">运单统计</th>
				<th colspan="1" class="center ">充值统计(元)</th>
				<th colspan="4" class="center ">车货统计</th>
				<th colspan="3" class="center ">标量统计</th>
				<th colspan="4" class="center ">其他信息</th>
			</tr>
			<tr>
				<th>登录名</th>
				<th>姓名</th>
				<th>手机号</th>
				<th>累计天数</th>
				<th>连续天数</th>
				<th>交易接单总数</th>
				<th>成功交易单数</th>
				<th>取消交易单数</th>
				<th>已评价单数</th>
				<th>好评</th>
				<th>中评</th>
				<th>差评</th>
				<th>累计充值金额</th>
				<th>发布货源量</th>
				<th>报价次数</th>
				<th>取消或删除货源量</th>
				<th>添加车数据量</th>
				<th>发布招标量</th>
				<th>废标次数</th>
				<th>成功竞标量</th>
				<th>创建时间</th>
				<th>更新时间</th>
				<th>数据状态</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="userStatistics" varStatus="step_status">
			<tr>
				<td>${step_status.index+1 }</td>
				<td>
					${userStatistics.user.loginName}
				</td>
				<td>
					${userStatistics.user.name}
				</td>
				<td>
					${userStatistics.user.phone}
				</td>
				<td>
					${userStatistics.accruelogincount}
				</td>
				<td>
					${userStatistics.continuelogincount}
				</td>
				<td>
					${userStatistics.tradeordercount}
				</td>
				<td>
					${userStatistics.successtrade}
				</td>
				<td>
					${userStatistics.canceltrade}
				</td>
				<td>
					${userStatistics.judgetrade}
				</td>
				<td>
					${userStatistics.goodjudge}
				</td>
				<td>
					${userStatistics.middlejudge}
				</td>
				<td>
					${userStatistics.badjudge}
				</td>
				<td>
					${userStatistics.rechargemoney}
				</td>
				<td>
					${userStatistics.pubgodscount}
				</td>
				<td>
					${userStatistics.quotecount}
				</td>
				<td>
					${userStatistics.cancelgodscount}
				</td>
				<td>
					${userStatistics.addcarcount}
				</td>
				<td>
					${userStatistics.pubbidcount}
				</td>
				<td>
					${userStatistics.cancelbidcount}
				</td>
				<td>
					${userStatistics.biddingcount}
				</td>
				<td>
					<fmt:formatDate value="${userStatistics.createDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					<fmt:formatDate value="${userStatistics.updateDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td>
					${fns:getDictLabel(userStatistics.delFlag, 'del_flag', '')}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>