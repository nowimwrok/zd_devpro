<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>账户出金</title>
    <meta name="decorator" content="default"/>
    <style>
        .control-group{
            border: none;
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row-fluid">
        <div class="span12" style="text-align: center">
            <div class="row-fluid">
                <div class="span6" style="border-right: 1px solid ;padding-right: 30px;">
                    <legend class="" style="text-align: left">收款方</legend>
                    <form class="form-horizontal">
                        <div class="control-group">
                            <label  class="control-label" for="fromAccountName">账户名：</label>
                            <div class="controls">
                                <input type="text" id="fromAccountName" readonly>
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="cardNo" class="control-label" >账户号：</label>
                            <div class="controls">
                                <input type="text" id="cardNo" readonly>
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="cashAmount">转账金额：</label>
                            <div class="controls">
                                <input type="text" id="cashAmount" placeholder="转账金额" >
                            </div>
                        </div>
                        <div class="control-group">
                            <label class="control-label" for="remark">备注：</label>
                            <div class="controls">
                               <textarea id="remark" name="remark"></textarea>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="span6">
                    <legend class="" style="text-align: left">付款方</legend>
                    <form class="form-horizontal">
                        <div class="control-group">
                            <label  class="control-label" for="accountId">账户号：</label>
                            <div class="controls">
                                <input type="text" id="accountId" readonly >
                            </div >
                        </div>
                        <div class="control-group">
                            <label for="toAccountName" class="control-label" >账户名：</label>
                            <div class="controls">
                                <input type="text" id="toAccountName" readonly>
                            </div>
                        </div>
                        <div class="control-group">
                            <label for="accountType" class="control-label" >账户类型：</label>
                            <div class="controls">
                                <input type="text" id="accountType" readonly>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <button type="submit" class="btn btn-primary " style="margin: 50px 0">确  定</button>
        </div>
    </div>
</div>

<c:if test="${userBank==null}">
    <script>
        alert("请先绑定银行卡");
        window.location.href="${ctx}/wlpt/account/myAccountList";
    </script>
</c:if>



</body>
</html>