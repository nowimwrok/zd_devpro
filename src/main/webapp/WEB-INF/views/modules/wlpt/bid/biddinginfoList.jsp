<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>竞标信息管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {

        });
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
    <li class="active"><a href="${ctx}/wlpt/bid/biddinginfo/">竞标信息列表</a></li>
    <shiro:hasPermission name="wlpt:bid:biddinginfo:edit">
        <li><a href="${ctx}/wlpt/bid/biddinginfo/form">竞标信息添加</a></li>
    </shiro:hasPermission>
</ul>
<form:form id="searchForm" modelAttribute="biddinginfo" action="${ctx}/wlpt/bid/biddinginfo/" method="post"
           class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li><label>标竞用户：</label>
            <form:input path="biddinguser.id" htmlEscape="false" maxlength="32" class="input-medium"/>
        </li>
        <li><label>竞标状态：</label>
            <form:select path="biddingstatus" class="input-medium">
                <form:option value="" label=""/>
                <form:options items="${fns:getDictList('bidding_status')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
        </li>
        <li><label>保证金：</label>
            <form:select path="guarantee" class="input-medium">
                <form:option value="" label=""/>
                <form:options items="${fns:getDictList('guarantee')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
        </li>
        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>竞标编号</th>
        <th>招标信息</th>
        <th>标竞用户</th>
        <th>竞标价格</th>
        <th>联系人</th>
        <th>联系电话</th>
        <th>竞标状态</th>
        <th>保证金</th>
        <th>更新时间</th>
        <th>备注信息</th>
        <shiro:hasPermission name="wlpt:bid:biddinginfo:edit">
            <th>操作</th>
        </shiro:hasPermission>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="biddinginfo">
        <tr>
            <td>
                <a href="${ctx}/wlpt/bid/biddinginfo/form?id=${biddinginfo.id}">
                        ${biddinginfo.biddingcode}
                </a>
            </td>
            <td>
                    ${biddinginfo.bidinfo.bidcode}
            </td>
            <td>
                    ${biddinginfo.biddinguser.loginName}
            </td>
            <td>
                    ${biddinginfo.biddingprice}
            </td>
            <td>
                    ${biddinginfo.linkman}
            </td>
            <td>
                    ${biddinginfo.linkphone}
            </td>
            <td>
                    ${fns:getDictLabel(biddinginfo.biddingstatus, 'bidding_status', '')}
            </td>
            <td>
                    ${fns:getDictLabel(biddinginfo.guarantee, 'guarantee', '')}
            </td>
            <td>
                <fmt:formatDate value="${biddinginfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </td>
            <td>
                    ${biddinginfo.remarks}
            </td>
            <shiro:hasPermission name="wlpt:bid:biddinginfo:edit">
                <td>
                    <a href="${ctx}/wlpt/bid/biddinginfo/form?id=${biddinginfo.id}">修改</a>
                    <a href="${ctx}/wlpt/bid/biddinginfo/delete?id=${biddinginfo.id}"
                       onclick="return confirmx('确认要删除该竞标信息吗？', this.href)">删除</a>
                </td>
            </shiro:hasPermission>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>