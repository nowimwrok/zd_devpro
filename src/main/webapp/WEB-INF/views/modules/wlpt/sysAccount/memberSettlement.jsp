<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>结算单查询</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
	$(document).ready(function() {
		var tradeSettlementId='${tradeSettlementId}';
		$("#tradeSettlementId").val(tradeSettlementId);
	});
    </script>
    <style type="text/css">
       
    </style>
</head>
<body>
<div>
    <form:form id="searchForm" action="${ctx}/wlpt/account/memberSettlement"
			method="post" class="breadcrumb form-search">
			<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
			<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
			<input id="flag" name="flag" type="hidden" value="${flag}" />
			<ul class="ul-form">
			    <li><label>结算单ID ：</label> <input id="tradeSettlementId" name="tradeSettlementId" htmlEscape="false" maxlength="40" placeholder="结算单ID" class="input-medium"/></li>
				<li class="btns"><input id="btnSubmit" class="btn btn-primary"
					type="submit" value="查询" /></li>
				<li class="clearfix"></li>
			</ul>
	</form:form>
	<sys:message content="${message}"/>
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th style="text-align: center">业务结算ID</th>
            <th style="text-align: center">交易类型</th>
            <th style="text-align: center">交易金额</th>
            <th style="text-align: center">实际转出金额</th>
            <th style="text-align: center">实际转入金额</th>
            <th style="text-align: center">手续费</th>
            <th style="text-align: center">交易状态</th>
            <th style="text-align: center">开单时间</th>
            <th style="text-align: center">交易时间</th>
            <th style="text-align: center">备注</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td style="text-align: center">${result.tradeSettlementId}</td>
            <td style="text-align: center">${fns:getDictLabel(result.tradeType,'tradeType_settlement','')}</td>
            <td style="text-align: center">${result.amount}</td>
            <td style="text-align: center">${result.outAmount}</td>
            <td style="text-align: center">${result.inAmount}</td>
            <td style="text-align: center">${result.handleFee}</td>
            <td style="text-align: center">${fns:getDictLabel(result.tradeStatus,'tradeStatus','')}</td>
            <td style="text-align: center">${result.createTime}</td>
            <td style="text-align: center">${result.tradeStatusTime}</td>
            <td style="text-align: center">${result.remark}</td>
        </tr>
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