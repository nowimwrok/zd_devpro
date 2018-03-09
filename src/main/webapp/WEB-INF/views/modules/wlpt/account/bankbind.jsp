<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>用户银行卡管理</title>
    <style type="text/css">
        body {
            padding: 0;
            width: 100%;
            border: 1px solid #D6D3CE;
        }

        .cash_title {
            margin: 20px 0 50px 20px;
            height: 50px;
            line-height: 50px;
            text-align: left;
            border-bottom: 1px solid #ccc;
        }
    </style>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
</head>

<body>
<form:form id="inputForm" modelAttribute="userBankinfo" action="${ctx}/wlpt/account/bankBind" method="post" class="col-sm-8 form-horizontal">
    <form:hidden path="id"/>

    <input type="hidden" name="user.id" id="userId" value="${loginUser.id}">

    <div class="form-group">
        <label for="bindname" class="col-sm-4 control-label">持卡人：</label>
        <div class="col-sm-8">
            <input type="text" class="form-control" id="bindname" name="bindname" readonly value="${loginUser.name}" >
        </div>
    </div>
    
    <div class="form-group">
        <label for="accountName" class="col-sm-4 control-label">户名：</label>
        <div class="col-sm-8">
            <input type="tel" class="form-control" id="accountName" name="accountName">
        </div>
    </div>

    <div class="form-group">
        <label for="bankcard" class="col-sm-4 control-label">卡号：</label>
        <div class="col-sm-8">
            <input type="tel" class="form-control" id="bankcard" name="bankcard">
        </div>
    </div>

    <div class="form-group">
        <label for="bindphone" class="col-sm-4 control-label">手机号：</label>
        <div class="col-sm-8">
            <input type="tel" class="form-control" id="bindphone" name="bindphone">
        </div>
    </div>

    <%-- <div class="form-group">
        <label class="col-sm-4 control-label">所属银行：</label>
        <div class="col-sm-8">
            <form:select path="unionpayNo" class="form-control">
                <form:options items="${fns:getDictList('unionpay_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
            </form:select>
            <input type="text" class="form-control" id="bankname" name="bankname" readonly >
        </div>
    </div> --%>

</form:form>
<script type="text/javascript">
/* $("#bankcard").change(function () {
	var bankcard=$("#bankcard").val();
	$.ajax({
        url: "${ctx}/wlpt/account/getNameByCard",
        dataType: 'json',
        type: "post",
        data : {"cardNo":bankcard},
        success: function (data) {
        	if (data.state == 1) {
        		$("#bankname").val(data.message);
        	}else{
        		$("#bankname").val("");
        	}
        }
    });
}); */
</script>
</body>
</html>

