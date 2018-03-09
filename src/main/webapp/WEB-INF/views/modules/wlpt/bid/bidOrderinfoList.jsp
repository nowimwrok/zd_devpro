<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>招标合同管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnExport").click(function () {
                top.$.jBox.confirm("确认要导出用户数据统计信息数据吗？", "系统提示",
                        function (v, h, f) {
                            if (v == "ok") {
                                $("#searchForm").attr("action", "${ctx}/wlpt/bid/bidOrderinfo/bidovExport");
                                $("#searchForm").submit();
                            }
                        },
                        {
                            buttonsFocus: 1
                        });
                top.$('.jbox-body .jbox-icon').css('top', '55px');
            });
            $("#btnSubmit").click(function () {
                $("#searchForm").attr("action", "${ctx}/wlpt/bid/bidOrderinfo/");
                $("#searchForm").submit();
            });
        });
        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }
    </script>
    <style type="text/css">
        .detail-row {
            display: none;
        }

        .center {
            text-align: center;;
        }
        th,td{
            text-align: center;
        }
    </style>
</head>
<body>
<ul class="nav nav-tabs">
    <li class="active"><a href="${ctx}/wlpt/bid/bidOrderinfo/">招标合同列表</a></li>
</ul>
<form:form id="searchForm" modelAttribute="bidOrderinfo" action="${ctx}/wlpt/bid/bidOrderinfo/" method="post"
           class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

    <ul class="ul-form">
        <li><label>关键词：</label>
            <form:input path="searchInfo" value="${bidOrderinfo.searchInfo}" htmlEscape="false" maxlength="32" class="input-medium"/>
        </li>
        <li>
            <label>招标文号：</label>
            <form:input path="bidinfo.bidcode" htmlEscape="false" maxlength="32" class="input-medium"/>
        </li>
        <li><label>合同状态：</label>
            <form:select path="contractstatus" class="input-medium">
                <form:option value="" label="全部"/>
                <form:options items="${fns:getDictList('bidOrder_status')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
        </li>
        <li><label>结算状态：</label>
            <form:select path="settlestatus" class="input-medium">
                <form:option value="" label="全部"/>
                <form:options items="${fns:getDictList('bidOrder_settleStatus')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
        </li>
        <li><label>保证金状态：</label>
            <form:select path="biddinginfo.guarantee" class="input-medium">
                <form:option value="" label="全部"/>
                <form:options items="${fns:getDictList('guarantee')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
        </li>
        <li>
            <label>创建时间：</label>
            <input name="beginCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                   value="<fmt:formatDate value="${bidOrderinfo.beginCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/> -
            <input name="endCreateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
                   value="<fmt:formatDate value="${bidOrderinfo.endCreateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:true});"/>
        </li>

        <li class="btns">
            <input id="btnSubmit" class="btn btn-primary" type="button" value="查询"/>
            <input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
        </li>
        <li class="clearfix"></li>
    </ul>

</form:form>
<sys:message content="${message}"/>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th rowspan="2" class="center" style="vertical-align: middle;">招标文号</th>
        <th colspan="2" class="center">招标方用户信息</th>

        <th colspan="2" class="center">竞标方用户信息</th>

        <th colspan="3" class="center">状态</th>

        <th colspan="2" class="center">业务信息</th>

        <th colspan="9" class="center">支付信息</th>
        <th colspan="2" class="center">时间</th>


    </tr>
    <tr>
        <th>招标方</th>
        <th>联系方式</th>
        <th>竞标方</th>
        <th>联系方式</th>

        <th>合同状态</th>
        <th>结算状态</th>
        <th>保证金状态</th>

        <th>货单量</th>
        <th>运输量</th>
        <td>竞价</td>
        <th>合同总额</th>

        <th>是否线上</th>
        <th>线上支付</th>
        <th>线下支付</th>
        <th>是否支付卓币</th>
        <th>卓币支付</th>
        
        <th>是否免保证金</th>
        <th>缴纳的保证金</th>

        <td>创建时间</td>
        <shiro:hasPermission name="wlpt:bid:bidOrderinfo:edit"><th>操作</th></shiro:hasPermission>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${varList.list}" var="bidOrderinfo" varStatus="vs">
        <tr>
            <td class='center' style="width: 30px;">${bidOrderinfo.bidinfo.bidcode}</td>
            <%--<td>
                <a href="javascript:;" onclick="detail(this);">查看</a>
            </td>--%>
            <td>
                    ${bidOrderinfo.biduser.loginName}
            </td>
            <td>
                    ${bidOrderinfo.biduser.phone}
            </td>
            <td>
                    ${bidOrderinfo.biddinguser.loginName}
            </td>
            <td>
                    ${bidOrderinfo.biddinguser.phone}
            </td>

            <td>
                    ${fns:getDictLabel(bidOrderinfo.contractstatus, 'bidOrder_status', '')}
            </td>
            <td>
                    ${fns:getDictLabel(bidOrderinfo.settlestatus, 'bidOrder_settleStatus', '')}
            </td>
			<td>${fns:getDictLabel(bidOrderinfo.biddinginfo.guarantee, 'guarantee', '')}</td>
            <td>
                    <fmt:formatNumber value="${bidOrderinfo.total}" type="Double" pattern="0.000"></fmt:formatNumber>
            </td>
            <td>
                <fmt:formatNumber value="${bidOrderinfo.quantity}" type="Double" pattern="0.000"></fmt:formatNumber>

            </td>
            <td>
                <fmt:formatNumber value="${bidOrderinfo.biddinginfo.biddingprice}" type="Double"
                                  pattern="0.00"></fmt:formatNumber>

            </td>
            <td>
                <fmt:formatNumber value="${bidOrderinfo.contracttotal}" type="Double" pattern="0.00"></fmt:formatNumber>
            </td>

            <td>
                    ${fns:getDictLabel(bidOrderinfo.isOnlinePay, 'yesorno', '')}
            </td>

            <td>
                <fmt:formatNumber value="${bidOrderinfo.webamount}" type="Double" pattern="0.00"></fmt:formatNumber>
            </td>
            <td>
                <fmt:formatNumber value="${bidOrderinfo.lineAmount}" type="Double" pattern="0.00"></fmt:formatNumber>
            </td>
            <td>
                    ${fns:getDictLabel(bidOrderinfo.ispaycoin, 'yesorno', '')}
            </td>
            <td>
                <fmt:formatNumber value="${bidOrderinfo.coinamount}" type="Double" pattern="0.00"></fmt:formatNumber>
            </td>
            <td>${fns:getDictLabel(bidOrderinfo.biddinginfo.isderate, 'yesorno', '')}</td>
            
            <td>${bidOrderinfo.biddinginfo.biddingmargin}</td>
            <td>
                <fmt:formatDate value="${bidOrderinfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>

            </td>
            <shiro:hasPermission name="wlpt:bid:bidOrderinfo:edit"><td>
           		<c:if test="${bidOrderinfo.biddinginfo.guarantee eq 0 }">
   				<a href="${ctx}/wlpt/bid/bidOrderinfo/biddingReturnPayBid?id=${bidOrderinfo.biddinginfo.id}" onclick="return confirmx('确认退还保证金吗？', this.href)">退还保证金</a>
				</c:if>
				</td></shiro:hasPermission>
        </tr>
        <%--<tr class="detail-row">
            <td colspan="9">
                <table class="table table-condensed">
                    <thead>
                    <th>提货单编号</th>
                    <th>品名材质</th>
                    <th>规格</th>
                    <th>数量</th>
                    <th>批次</th>
                    <th>交易状态</th>
                    </thead>
                    <tbody>
                    <c:forEach items="${bidOrderinfo.blinfoList}" var="item">
                        <tr>
                            <td>${item.blcode}</td>
                            <td>${item.namematerials}</td>
                            <td>${item.standard}</td>
                            <td>${item.quantity}</td>
                            <td>${item.batch}</td>
                            <td>${fns:getDictLabel(item.tradestatus, 'trade_status', '')}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </td>
        </tr>--%>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${varList}</div>
<script type="text/javascript">
    function detail(e) {
        $(e).closest('tr').next().toggleClass('detail-row');
    }
</script>
</body>
</html>