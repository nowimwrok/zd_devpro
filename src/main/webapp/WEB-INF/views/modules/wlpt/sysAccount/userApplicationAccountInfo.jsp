<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>开户状态查询</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
	$(document).ready(function() {
		var applyId='${applyId}';
		$("#applyId").val(applyId);
	});
    </script>
    <style type="text/css">
       
    </style>
</head>
<body>
<div>
    <h3 style="margin: 10px 20px;font-size:20px;">
    <span style="display: inline-block;width: 49%;">目标用户：${userApplicationAccount.user!=null?userApplicationAccount.user.phone:''}</span>
    </h3>
    <sys:message content="${message}"/>
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th style="text-align: center">业务结算ID</th>
            <th style="text-align: center">申请时间</th>
            <th style="text-align: center">开户状态</th>
            <th style="text-align: center">会员ID</th>
            <th style="text-align: center">二级账户ID</th>
            <th style="text-align: center">审批时间</th>
            <th style="text-align: center">备注</th>
            <!-- <th style="text-align: center">操作</th> -->
        </tr>
        </thead>
        <tbody>
        <tr>
            <td style="text-align: center">${result.applyId}</td>
            <td style="text-align: center">${result.applyTime}</td>
            <td style="text-align: center">${fns:getDictLabel(result.accountStatus, 'accountStatus_application', '')}</td>
            <td style="text-align: center">${result.memberId}</td>
            <td style="text-align: center">${result.accountIds}</td>
            <td style="text-align: center">${result.approveTime}</td>
            <td style="text-align: center">${result.statusMsg}</td>
            <%-- <td style="text-align: center"><c:if test="${result.accountStatus==6&&userApplicationAccount.isBind==0}"><a href="${ctx}/wlpt/user/userApplicationAccount/bindUserAccount?memberId=${result.memberId}&target=${userApplicationAccount.user.phone}">绑定</a></c:if></td> --%>
        </tr>
        </tbody>
    </table>
</div>
    <div class="form-actions" style="text-align: center">
    <input id="btnCancel" class="btn btn-primary" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
<script>

</script>


</body>
</html>