<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>我的账户</title>
    <meta name="decorator" content="default"/>
    <style type="text/css">
       
    </style>
</head>
<body>
<div>
    <h3 style="margin: 10px 20px;font-size:20px;">
    <span style="display: inline-block;width: 49%;">账户名：${result.accountName}</span>
    <span style="display: inline-block;width: 49%;">可用余额：${result.availableBalance}元</span>
    </h3>
    <h3 style="margin: 10px 20px;font-size:20px;">账户号：${result.bankAccount}</h3>
    <sys:message content="${message}"/>
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th style="text-align: center">三级账户类型</th>
            <th style="text-align: center">三级可用余额（元）</th>
            <th style="text-align: center">三级在途金额（元）</th>
            <th style="text-align: center">三级冻结金额（元）</th>
            <th style="text-align: center">三级锁定金额（元）</th>
            <th style="text-align: center">账户状态</th>
            <th style="text-align: center">最后交易时间</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${result1}" var="item">
        <tr>
            <td style="text-align: center"><a href="${ctx}/wlpt/account/memberTreeFlowList?accountId=${item.accountId}">${fns:getDictLabel(item.accountType,'accountType','')}</a></td>
            <td style="text-align: right">${item.availableBalance}</td>
            <td style="text-align: right">${item.undeterminedBalance}</td>
            <td style="text-align: right">${item.freezeBalance}</td>
            <td style="text-align: right">${item.lockBalance}</td>
            <td style="text-align: center">${fns:getDictLabel(item.accountStatus,'accountStatus','')}</td>
            <td style="text-align: center">${item.lastTranTime}</td>
        </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
    <c:if test="${flag!=null&&flag==1}">
    <div class="form-actions" style="text-align: center">
    <input id="btnCancel" class="btn btn-primary" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
    </c:if>
<script>

</script>


</body>
</html>