<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>用户个人交易流水详情</title>
    <meta name="decorator" content="default"/>
    <style type="text/css">
      td,th{
        text-align:center !important;
      }

      
    </style>
    <script type="text/javascript">
        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
    </script>
    
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a>个人交易流水信息列表</a></li>
</ul>
<form:form id="searchForm" modelAttribute="consumerecod" action="${ctx}/wlpt/consume/useraccount/detail?ismemberAccount=${consumerecod.ismemberAccount}&id=${userid}" method="post"
           class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
   <thead>
			<tr>
				<th colspan="3" class="center" style="vertical-align: middle;">用户信息</th>
				<th colspan="3" class="center" style="vertical-align: middle;">交易信息</th>
				<th colspan="3" class="center" style="vertical-align: middle;">金额信息</th>
				<th colspan="2" class="center" style="vertical-align: middle;">时间信息</th>
				<th rowspan="" class="center" style="vertical-align: middle;">交易描述</th>
			</tr>
			<tr>

				<th>交易编号</th>
				<th>流出账户</th>
				<th>流入账户</th>
				<th>交易类型</th>
				<th>交易方式</th>
				<!-- <th>交易描述</th> -->
				<th>交易状态</th>
				<th>交易金额</th>
				<th>交易前金额</th>
				<th>交易后金额</th>
				<th>交易时间</th>
				<th>更新时间</th>
				<th>明细</th>
			</tr>
		</thead>
    <tbody>
    <c:forEach items="${page.list}" var="consumerecod">
<tr>
					<td>${consumerecod.consumecode}</td>
					<td>${consumerecod.account.loginName}</td>
					<td>${consumerecod.target.loginName}</td>
					<td>${fns:getDictLabel(consumerecod.consumetype, 'consumerecode_type', '')}
					</td>
					<td>${fns:getDictLabel(consumerecod.consumeway, 'consumerecode_way', '')}
					</td>
					<%-- <td>
                    ${consumerecod.consumewaydesp}
            </td> --%>
					<td>${fns:getDictLabel(consumerecod.consumestatus, 'consume_status', '')}
					</td>
					<td>${consumerecod.consumemony}</td>
					<td>${consumerecod.beforemony}</td>
					<td>${consumerecod.aftermony}</td>
					<td><fmt:formatDate value="${consumerecod.createDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td><fmt:formatDate value="${consumerecod.updateDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>${consumerecod.remarks}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>