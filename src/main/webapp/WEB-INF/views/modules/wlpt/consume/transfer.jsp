<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>账户转账管理</title>
    <meta name="decorator" content="default"/>
    <style type="text/css">
        .fltdiv {
            float: left;
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            
            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
            $("#asearchinfo").change(function () {
                $.ajax({
                    type: "POST",
                    url: '${ctx}/sys/Userinfo/searchInfo',
                    dataType: 'json',
                    data: {searchinfo: $("#asearchinfo").val()},
                    cache: false,
                    success: function (data) {
                        if (data) {
                            var userinfo=data.userinfo;
                            $("#accountid").val(userinfo.id);
                            $("#aloginName").html(userinfo.loginName);
                            $("#atrueName").html(userinfo.name);
                            $("#auserphone").html(userinfo.phone);
                            $("#aavailablebalance").html(data.userPurse.availablebalance);
                        } else {
                            top.$.jBox.tip('请填写正确的手机号码', 'warning');
                        }
                    },
                    error: function () {
                        top.$.jBox.tip('用户不存在', 'warning');
                    }
                });
            });
            $("#tsearchinfo").change(function () {
                $.ajax({
                    type: "POST",
                    url: '${ctx}/sys/Userinfo/searchInfo',
                    dataType: 'json',
                    data: {searchinfo: $("#tsearchinfo").val()},
                    cache: false,
                    success: function (data) {
                        if (data) {
                            var userinfo=data.userinfo;
                            $("#targetid").val(userinfo.id);
                            $("#tloginName").html(userinfo.loginName);
                            $("#ttrueName").html(userinfo.name);
                            $("#tuserphone").html(userinfo.phone);
                            $("#tavailablebalance").html(data.userPurse.availablebalance);
                        } else {
                            top.$.jBox.tip('请填写正确的手机号码', 'warning');
                        }
                    },
                    error: function () {
                        top.$.jBox.tip('用户不存在', 'warning');
                    }
                });
            });
        });
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/wlpt/consume/consumerecod/toTransfer">账户转账</a></li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="consumerecod" action="${ctx}/wlpt/consume/consumerecod/transfer" method="post" class="form-horizontal">
    <sys:message content="${message}"/>
    <input id="consumeway" name="consumeway" value="0" type="hidden"/>
    <div class="control-group">
        <label class="control-label">转账用户：</label>
        <div class="controls">
            <input id="asearchinfo" htmlEscape="false" maxlength="255" class="input-xlarge"/>
            <input id="accountid" name="account.id" type="hidden"/>
        </div>
    </div>
    <div id="account">
        <div class="control-group">
            <label class="control-label">用户名：</label>
            <div class="controls">
                <label class="lbl" id="aloginName"></label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">真实姓名：</label>
            <div class="controls">
                <label class="lbl" id="atrueName"></label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">手机号：</label>
            <div class="controls">
                <label class="lbl" id="auserphone"></label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">可用余额：</label>
            <div class="controls">
                <label class="lbl" id="aavailablebalance"></label>
            </div>
        </div>
    </div>
    
    <div class="control-group">
        <label class="control-label">转账目标用户：</label>
        <div class="controls">
            <input id="tsearchinfo" htmlEscape="false" maxlength="255" class="input-xlarge  "/>
            <input id="targetid" name="target.id" type="hidden"/>
        </div>
    </div>
    <div id="target">
        <div class="control-group">
            <label class="control-label">用户名：</label>
            <div class="controls">
                <label class="lbl" id="tloginName"></label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">真实姓名：</label>
            <div class="controls">
                <label class="lbl" id="ttrueName"></label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">手机号：</label>
            <div class="controls">
                <label class="lbl" id="tuserphone"></label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">可用余额：</label>
            <div class="controls">
                <label class="lbl" id="tavailablebalance"></label>
            </div>
        </div>
    </div>
    
    <div class="control-group">
        <label class="control-label">转账金额：</label>
        <div class="controls">
            <form:input path="consumemony" htmlEscape="false" class="input-xlarge "/>
        </div>
    </div>
   
    <div class="form-actions">
        <shiro:hasPermission name="wlpt:consume:consumeaudit:edit">
        <input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/></shiro:hasPermission>
    </div>
</form:form>
</body>
</html>