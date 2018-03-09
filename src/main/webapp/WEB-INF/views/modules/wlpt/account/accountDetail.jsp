<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>账户明细</title>
    <meta name="decorator" content="default"/>

    <style>
        th, td {
            text-align: center !important;
        }
    </style>
</head>
<body>
<div style="padding-top: 20px;">
    <table id="contentTable" class="table table-striped table-bordered table-condensed">
        <thead>
        <tr>
            <th style="width:7%;">账户类型</th>
            <th style="width:7%;">可用余额（元）</th>
            <th style="width:7%;">在途余额（元）</th>
            <th style="width:7%;">冻结余额（元）</th>
            <th style="width:7%;">锁定余额（元）</th>
            <th style="width:7%;">合计（元）</th>
            <th style="width:7%;">账户状态</th>
            <th style="width:7%;">备注</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${memberDetail}" var="item" varStatus="vs">
            <tr>
                <td>${fns:getDictLabel(item.accountType, 'account_type', '')}</td>
                <td>${item.availableBalance}</td>
                <td>${item.undeterminedBalance}</td>
                <td>${item.freezeBalance}</td>
                <td>${item.lockBalance}</td>
                <td>${item.availableBalance+item.undeterminedBalance+item.freezeBalance+item.lockBalance}</td>
                <td>${fns:getDictLabel(item.accountStatus, 'accountStatus', '')}</td>
                <td></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<div style="font-size: 16px;padding-top: 40px;padding-left: 20px;">
    <p>
        <span><b>已绑定的银行账户</b></span>
        <c:if test="${bankList== null || fn:length(bankList) < 3}">
            <input style="margin-left: 10px;" class="btn btn-success" type="button" value="绑定卡" onclick="bindCard()"/>
        </c:if>
    </p>
</div>

<table class="table table-striped table-bordered table-condensed">
    <thead>
    <tr>
        <th style="width:10%;">绑卡姓名</th>
        <th style="width:10%;">绑卡手机</th>
        <th style="width:10%;">银行卡号</th>
        <th style="width:10%;">银行卡类型</th>
        <th style="width:10%;">是否默认卡</th>
        <th style="width:10%">操作</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach items="${bankList}" var="item" varStatus="vs">
        <tr>
            <td>${item.bindname}</td>
            <td>${item.bindphone}</td>
            <td>${item.bankcard}</td>
            <td>${item.bankname}</td>
            <td>${item.isdefault==1?"是":"否"}</td>
            <td>
                <c:if test="${item.isdefault==0}">
                    <a href="${ctx}/wlpt/account/bankDefault?id=${item.id}" onclick="return confirmx('确认设为默认卡？', this.href)">设为默认卡</a>
                    &nbsp;&nbsp;
                </c:if>
                <a href="${ctx}/wlpt/account/deteleBank?id=${item.id}" onclick="return confirmx('确认要删除银行卡？', this.href)">删除银行卡</a></td>
        </tr>
    </c:forEach>
    </tbody>
</table>


<div style="padding-left: 20px;"><p><span>注：一个账户最多可绑定3张同名银行卡。</span></p></div>
<div class="form-actions" style="text-align: center;">
    <input id="btnCancel" class="btn btn-primary" type="button" value="返 回" onclick="history.go(-1)"/>
</div>

<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"
        type="text/javascript"></script>
<script>
    function bindCard() {
        $.jBox("iframe:${ctx}/wlpt/account/toBankbind", {
            title: "绑定卡",
            width: 600,
            height: 400,
            buttons: {'保存': true, '关闭': false},
            submit: function (v, h, f) {
                var we = h.find("#jbox-iframe")[0].contentWindow;
                if (v == true) {
                    h.find('.errorBlock').hide('fast', function () {
                        $(this).remove();
                    });

                    if (we.accountName.value == '') {
                        $('<div class="errorBlock" style="display: none;">对不起，请输入户名！</div>').prependTo(h).show('fast');
                        we.accountName.focus();
                        return false;
                    }

                    if (we.bankcard.value == '') {
                        $('<div class="errorBlock" style="display: none;">对不起，请输入卡号！</div>').prependTo(h).show('fast');
                        we.bankcard.focus();
                        return false;
                    }
                    
                    if (we.bindphone.value == '') {
                        $('<div class="errorBlock" style="display: none;">对不起，请输入联系电话！</div>').prependTo(h).show('fast');
                        we.bindphone.focus();
                        return false;
                    }

                    var p1 = /(^[0-9]{3,4}\-[0-9]{3,8}$)|(^[0-9]{3,8}$)|(^\([0-9]{3,4}\)[0-9]{3,8}$)|(^0{0,1}1[3-9][0-9]{9}$)|(^\d{11}$)/;
                    if (!p1.test(we.bindphone.value)) {
                        $('<div class="errorBlock" style="display: none;">对不起，您输入的联系电话有误！</div>').prependTo(h).show('fast');
                        we.bindphone.focus();
                        return false;
                    }

                    var userBankinfo = {
                        "user.id": we.userId.value,
                        "bindname": we.bindname.value,
                        "accountName": we.accountName.value,
                        "bankcard": we.bankcard.value,
                        "bindphone": we.bindphone.value
                    };


                    $.ajax({
                        type: "POST",
                        url: "${ctx}/wlpt/account/bankBind.do",
                        data: userBankinfo,
                        dataType: "html",
                        success: function (data) {
                            location.reload();
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            $.jBox.error(XMLHttpRequest.status + "错误信息：" + XMLHttpRequest.responseText, "错误提示");
                        }
                    });
                    return true;
                }
                return true;
            }
        });
    }



    function bankDefault(id) {
        $.MsgBox.Confirm("提示", "设置此卡为默认卡?", function () {
            window.location.href = "${ctx}/wlpt/account/bankDefault?id=" + id;
        }, function () {

        });
        return true;
    }
    function deteleAccount(id) {
        $.MsgBox.Confirm("删除提示", "是否删除该卡?", function () {
            window.location.href = "${ctx}/wlpt/account/deteleBank?id=" + id;
        }, function () {

        });
        return true;
    }
</script>

</body>
</html>