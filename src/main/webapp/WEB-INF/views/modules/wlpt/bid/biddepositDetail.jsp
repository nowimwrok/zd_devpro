<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>竞标押金详情</title>
    <meta name="decorator" content="default"/>
    <style type="text/css">
      th,td{
        text-align:center !important;
      }
      #contentTable{
        width:2000px;
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
    <li><a href="${ctx}/wlpt/bid/biddeposit/">竞标押金信息列表</a></li>
    <li class="active"><a href="${ctx}/wlpt/bid/biddeposit/detail">个人交易信息列表</a></li>
</ul>
<form:form id="searchForm" modelAttribute="consumerecod" action="${ctx}/wlpt/bid/biddeposit/detail" method="post"
           class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>交易编号</th>
        <th>充值账户</th>
        <th>目标账户</th>
        <th>交易类型：</th>
        <th>交易方式</th>
        <th>交易描述</th>
        <th>交易状态：</th>
        <th>浏览方式：</th>
        <th>消费金额</th>
        <th>消费前金额</th>
        <th>消费后金额</th>
        <th>交易时间</th>
        <th>创建者</th>
        <th>更新时间</th>
        <th>更新者</th>
        <th>备注</th>
        <th>sysaccount_id</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="consumerecod">
        <tr>
            <td>
                        ${consumerecod.consumecode}
            </td>
            <td>
                    ${consumerecod.account.loginName}
             </td>
            <td>
                    ${consumerecod.target.loginName}
            </td>
            <td>
                    ${fns:getDictLabel(consumerecod.consumetype, 'consumerecode_type', '')}
            </td>
            <td>
                    ${fns:getDictLabel(consumerecod.consumeway, 'consumerecode_way', '')}
            </td>
            <td>
                    ${consumerecod.consumewaydesp}
            </td>
            <td>
                    ${fns:getDictLabel(consumerecod.consumestatus, 'consume_status', '')}
            </td>
            <td>
                    ${consumerecod.scantype}
            </td>
            <td>
                    ${consumerecod.consumemony}
            </td>
            <td>
                    ${consumerecod.beforemony}
            </td>
            <td>
                    ${consumerecod.aftermony}
            </td>
            <td>
                <fmt:formatDate value="${consumerecod.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </td>
            <td>
                    ${consumerecod.createBy.loginName}
            </td>
            <td>
                <fmt:formatDate value="${consumerecod.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </td>
            <td>
                    ${consumerecod.updateBy.loginName}
            </td>
            <td>
                    ${consumerecod.remarks}
            </td>
            <td>
                    ${consumerecod.sysaccount.loginName}
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>