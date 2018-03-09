<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>诚信积分报表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
                $("#btnExport")
                    .click(
                        function () {
                            top.$.jBox
                                .confirm(
                                    "确认要导出积分数据吗？",
                                    "系统提示",
                                    function (v, h, f) {
                                        if (v == "ok") {
                                            $(
                                                "#searchForm")
                                                .attr(
                                                    "action",
                                                    "${ctx}/wlpt/integrity/integrityRecord/export");
                                            $(
                                                "#searchForm")
                                                .submit();
                                        }
                                    },
                                    {
                                        buttonsFocus: 1
                                    });
                            top.$('.jbox-body .jbox-icon').css(
                                'top', '55px');
                        });
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;0
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/wlpt/integrity/integrityRecord/">诚信积分列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="integrityRecordVO" action="${ctx}/wlpt/integrity/integrityRecord/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>关键词：</label>
				<form:input path="searchinfo" value="${integrityRecordVO.searchinfo}" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>更新时间(开始):</label> <input
					name="beginCreateDate" type="text" readonly="readonly"
					maxlength="20" class="input-medium Wdate"
					value='<fmt:formatDate value="${integrityRecordVO.beginCreateDate}" pattern="yyyy-MM-dd"/>'
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
				- (结束)<input name="endCreateDate" type="text"
							 readonly="readonly" maxlength="20" class="input-medium Wdate"
							 value='<fmt:formatDate value="${integrityRecordVO.endCreateDate}" pattern="yyyy-MM-dd"/>'
							 onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:true});"/>
			</li>

			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
				<input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>登陆名</th>
				<th>姓名</th>
				<th>手机号</th>
				<th>总分</th>
				<th>交易得分</th>
				<th>商城消费得分</th>
				<th>其他得分</th>
				<th>积分消费</th>
				<th>更新时间</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="integrityRecord">
			<tr>
				<td>
					<a href="${ctx}/wlpt/integrity/integrityStandardlog/list?user.id=${integrityRecord.user.id}">${integrityRecord.user.loginName}</a>
				</td>
				<td>
						${integrityRecord.user.name}
				</td>
				<td>
						${integrityRecord.user.phone}
				</td>

				<td>
					${integrityRecord.totalValue}
				</td>
				<td>
						${integrityRecord.tradeValue}
				</td>
				<td>
						${integrityRecord.shopValue}
				</td>
				<td>
						${integrityRecord.otherValue}
				</td>
				<td>
						${integrityRecord.consumeValue}
				</td>
				<td>
					<fmt:formatDate value="${integrityRecord.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>