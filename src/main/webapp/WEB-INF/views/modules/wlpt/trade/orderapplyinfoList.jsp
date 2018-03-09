<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>运单尾款支付审核</title>
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
    <li class="active"><a href="${ctx}/wlpt/trade/orderinfo/orderPayApplylist">运单尾款支付审核列表</a></li>
    
</ul>
<form:form id="searchForm" modelAttribute="orderinfo" action="${ctx}/wlpt/trade/orderinfo/orderPayApplylist" method="post"
           class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
    <ul class="ul-form">

        
        <li><label>关键字：</label>
            <form:input path="searchinfo" htmlEscape="false" maxlength="64" class="input-medium" placeholder="运单号/用户名/手机号/配载重量/货物名称"/>
        </li>
        <%-- <li><label>创建时间：</label>
            <input name="createDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                   value="<fmt:formatDate value="${orderinfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
        </li>
        <li><label>更新时间：</label>
            <input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                   value="<fmt:formatDate value="${orderinfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
        </li> --%>
        
        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
        <li class="clearfix"></li>
    </ul>
</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th>运单号</th>
        <th>报价信息</th>
        <th>车队</th>
        <th>货主</th>
        <th>总运费</th>
        <th>支付信息</th>
        <th>运单状态</th>
        <th>尾款支付状态</th>
        <th>创建时间</th>
        <th>更新时间</th>
        <shiro:hasPermission name="wlpt:trade:orderinfo:edit">
            <th>操作</th>
        </shiro:hasPermission>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${page.list}" var="orderinfo">
        <tr>
            <td>
                <a href="${ctx}/wlpt/trade/orderinfo/form?id=${orderinfo.id}">
                        ${orderinfo.orderno}
                </a>
            </td>
            <td><a href="${ctx}/wlpt/trade/orderinfo/form?id=${orderinfo.id}">
                货物名:${orderinfo.quoteinfo.goods.goodsname}<br>
                货物类型: ${orderinfo.quoteinfo.goods.gsoddtype}<br>
                报价吨位:${orderinfo.quoteinfo.oddloadweight} ${orderinfo.quoteinfo.goods.freightunit}<br>
                报价:${orderinfo.quoteinfo.ooferprice}元

            </a></td>
            <td>
                车主:${orderinfo.buyer.name}<br>
                手机:${orderinfo.buyer.phone}<br>
                车辆:${orderinfo.quoteinfo.car.carnumber}<br>
                车型:${orderinfo.quoteinfo.car.cartype}<br>
            </td>
            <td>
                货主:${orderinfo.seller.name}<br>
                手机:${orderinfo.seller.phone}
            </td>
            <td>
                    ${orderinfo.totalcost}
            </td>
            <td>
                    线上支付比例:${orderinfo.payinfo.onlineratio}
                    线上支付:${orderinfo.payinfo.onlineamount}元
                    线下支付:${orderinfo.payinfo.lineamount}元
            </td>
            <td>
                    ${fns:getDictLabel(orderinfo.orderstatus, 'order_status', '')}
            </td>
            <td>
                    ${fns:getDictLabel(orderinfo.orderispay, 'order_ispay', '')}
            </td>
            <td>
                <fmt:formatDate value="${orderinfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </td>
            <td>
                <fmt:formatDate value="${orderinfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
            </td>
            <shiro:hasPermission name="wlpt:trade:orderinfo:edit">
                <td>
                    <a href="${ctx}/wlpt/trade/orderinfo/tradePayinfoApply?id=${orderinfo.id}">审核</a>
                </td>
            </shiro:hasPermission>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>