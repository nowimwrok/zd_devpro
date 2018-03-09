<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>诚信积分日志管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            $("#btnExport")
                .click(
                    function () {
                        top.$.jBox
                            .confirm(
                                "确认要导出积分日志记录数据吗？",
                                "系统提示",
                                function (v, h, f) {
                                    if (v == "ok") {
                                        $(
                                            "#searchForm")
                                            .attr(
                                                "action",
                                                "${ctx}/wlpt/integrity/integrityStandardlog/export");
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
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/wlpt/integrity/integrityRecord/list">诚信积分报表</a></li>
		<li class="active"><a href="${ctx}/wlpt/integrity/integrityStandardlog/list?user.id=${userid}">诚信积分日志列表</a></li>
		
	</ul>
	<form:form id="searchForm" modelAttribute="integrityStandardlog" action="${ctx}/wlpt/integrity/integrityStandardlog/list?user.id=${userid}" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>评分项：</label>
				<input type="hidden" name="user.id" value="${userid}">
				<form:input path="standarditems.scoreitem" htmlEscape="false" maxlength="32" class="input-medium"/>

			</li>
			<li><label>创建时间(开始):</label> <input
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
				<input id="btnExport" class="btn btn-primary" type="button" value="导出"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>用户名</th>
				<th>评分项</th>
				<th>本次变化的积分</th>
				<th>变化前的积分</th>
				<th>变化后的积分</th>
				<th>创建时间</th>
				<th>备注信息</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="integrityStandardlog">
			<tr>
				<td>
					${integrityStandardlog.user.loginName}
				</td>
				<td>
					${integrityStandardlog.standarditems.scoreitem}
				</td>
				<td>
					${integrityStandardlog.pointvalue}
				</td>
				<td>
					${integrityStandardlog.pointbefore}
				</td>
				<td>
					${integrityStandardlog.pointafter}
				</td>
				<td>
					<fmt:formatDate value="${integrityStandardlog.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${integrityStandardlog.remarks}
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>