<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>卓币转账</title>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">


    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/static/modules/wlpt/front/css/personal/count.css">
    <style type="text/css">
        body {
            padding: 0;
            margin: 0;
            width: 100%;
            margin: 0 auto;
            text-align: center;
            border: 1px solid #D6D3CE;
            font-family: "微软雅黑";
        }

        ul p span a input td {
            font-family: "微软雅黑";
        }

        .loading_lock {
            display: none;
            width: 100%;
            height: 94%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 0px;
            text-align: center;
        }

        .loading_lock img {
            margin-top: 25%;
        }

        .regbt {
            width: 55px;
            height: 28px;
            border: solid 1px;
            border-radius: 0px;
            background-color: #FFC52F;
            border-color: #FFC52F;
            cursor: pointer;
            font-weight: bold;
            text-align: center;
            color: white;
            margin-top: 0px;
            font-size: 16px;
            line-height: 25px;
        }

        .detail-row {
            display: none;
        }

        .withdraw_cash_wrap table tr {
            line-height: 40px;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/modules/wlpt_front/contacts/contacts_info.jsp" %>
<style type="text/css">
#dialog {
    top: 45%;
}
</style>
<ul class="qiye_menu">
		<li data-type="1"><a href="${wlpt }/wlpt/consume/toPurse" target="content" style="color: #000;">账户余额</a></li>
		<li data-type="2" class="qiye_menu_1"><a href="${wlpt}/wlpt/consume/toTransferCoin" target="content" style="color: #000;">卓币转账</a></li>
		<li data-type="3" ><a href="${wlpt}/wlpt/consume/toTransferPetro" target="content" style="color: #000;">油气转账</a></li>
    <%-- <li data-type="3" ><a href="${wlpt}/wlpt/consume/toPetroRecharge" target="content" style="color: #000;">油气充值</a></li> --%>
		<li data-type="4"><a href="${wlpt}/wlpt/consume/toGueanRecharge" target="content" style="color: #000;">保证金充值</a></li>
	</ul>
<div class="withdraw_cash_wrap">
    <p class="user_data">
        <img src="/static/images/wlptfront/line-left.png"><span class="title_blue">卓币</span><span class="title_orange">转账</span><img
            src="/static/images/wlptfront/line-right.png">
    </p>
    <table>
        <tr>
            <td class="left_title" style="width:20%;">转账账号：</td>
            <td class="right_con right_con_1" style="width:25%;font-size: 16px;">
                <input type="text" id="searchinfo" placeholder="请输入用户名/手机号">
            </td>
            <td style="width:25%;">
                <button type="button" onclick="search();" class="regbt">搜索</button>
                <span onclick="showBg1();"><a href="#">常用联系人</a></span>
            </td>
            <td style="width:25%;"></td>
        </tr>
        <tr id="info" class="detail-row">
            <td colspan="4">
                <table class="table_border" cellpadding="0" cellspacing="0" style=" margin-left: 80px;">
                    <tr>
                        <td id="login">登录名：</td>
                        <td id="name">真实姓名：</td>
                        <td id="phone">电话：</td>
                    </tr>
                    <tr>
                        <td id="email">邮箱：</td>
                        <td id="sex">性别：</td>
                        <td id="status">认证：</td>
                    </tr>
                </table>
        </tr>
        <tr>
            <td class="left_title">转账金额：</td>
            <td class="right_con" colspan=3><input type="text" id="num" style="height: 28px;line-height: 28px;">&nbsp;元&nbsp;&nbsp;&nbsp;<span
                    class="count_state">可用卓币：</span><span
                    class="count_green">${not empty user.userPurse.availablecoin ? user.userPurse.availablecoin:'0.00'}</span>
            </td>
        </tr>
        <tr>
            <td class="left_title">支付密码：</td>
            <td colspan="3">
                <input id="password" type="password" style="height: 28px;line-height: 28px;"/>
            </td>
        </tr>
        <tr>
            <td class="left_title"></td>
            <td class="right_con please_note" colspan=3>请注意：向账户转账，金额从账户余额扣减，转账金额大于0并且小于账户余额，如有问题，请致电卓大客服办理</td>
        </tr>
        <tr>
            <td class="left_title"></td>
            <td class="right_con cash_type_list cash_type_list1" colspan=3>
                <p class="custom_service">客服电话：0310-3188756&nbsp;&nbsp;服务时间：周一至周日9：00-17:30</p>
            </td>
        </tr>
        <tr>
            <td class="right_con cash_type_list" colspan=4>
                <a class="btn btn-default bg_blue_btn" id="btnSubmit">转账</a>
            </td>
        </tr>
    </table>
    <!-- <div class="loading">
    <img src="/static/images/loading.gif">
    <p>加载中</p>
    </div> -->

    <div class="loading_lock" style="width: 100%;"><img src="${ctxStatic }/images/loading.gif">
        <p>等待中</p></div>
    <div class="kind_reminder">
        <h5>温馨提示：</h5>
        <p>1、转账支付金额确认支付后不可修改，请熟知</p>
        <p>2、转账完成后，在充值中心可以查看转账操作记录</p>
    </div>
</div>
<script src="${ctxStatic}/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script>
    $(".loading_lock").hide();
    $("#searchinfo").change(function () {
        search();
    });
    var reuserenname;
    var flag;
    var targetstatus=null;
    function search() {
        var isnul = true;
        isnul = isnul && $("#searchinfo").valid({
                    methods: "required"
                });
        if (isnul) {
            var searchinfo = $("#searchinfo").val();
            $(".loading_lock").show();
            $.ajax({
                url: "${wlpt}/wlpt/personal/searchInfo",
                dataType: 'json',
                data: {searchinfo: searchinfo},
                cache: false,
                success: function (data) {
                    $(".loading_lock").hide();
                    if (data) {
                        if (data.value == '未查到指定用户') {
                            $("#info").addClass("detail-row");
                            flag = "false";
                            $("#searchinfo").tips({
                                side: 3,
                                msg: '未找到指定用户',
                                bg: '#00A2E9',
                                time: 4
                            });
                        } else {
                            flag = "true";
                            if (data.value.role.enname) {
                                reuserenname = data.value.role.enname;
                            }
                            if (data.value.user.loginName) {
                                $("#login").html("登录名：" + data.value.user.loginName);
                            }
                            if (data.value.user.name) {
                                $("#name").html("真实姓名：" + data.value.user.name);
                            }
                            if (data.value.user.phone) {
                                $("#phone").html("电话：" + data.value.user.phone);
                            }
                            if (data.value.user.email) {
                                $("#email").html("邮箱：" + data.value.user.email);
                            }
                            if (data.value.info.sex) {
                                if (data.value.info.sex == '1') {
                                    $("#sex").html("性别：" + '男');
                                }
                                if (data.value.info.sex == '0') {
                                    $("#sex").html("性别：" + '女');
                                }
                            }
                            if (data.value.info.status) {
                            	targetstatus=data.value.info.status;
                                if (data.value.info.status == '2') {
                                    $("#status").html("认证：" + '认证通过');
                                } else {
                                    $("#status").html("认证：" + '未通过');
                                }

                            }
                            $("#info").removeClass("detail-row");
                        }
                    }
                }
            });
        }
    }
    $("#btnSubmit").click(function () {
    	var status='${user.userinfo.status}';
    	if(status==null||status==''||status==undefined||status!='2'){
    		$("#btnSubmit").tips({
                side: 3,
                msg: '请先完成认证',
                bg: '#00A2E9',
                time: 4
            });
            return false;
    	}
        var nul = true;
        nul = nul && $("#searchinfo").valid({
                    methods: "required"
                });
        nul = nul && $("#num").valid({
                    methods: "required"
                });
        nul = nul && $("#num").valid({
            		methods: "decimalTwo"
        });
        nul = nul && $("#password").valid({
                    methods: "required"
                });
        if (flag == "false") {
            $("#searchinfo").tips({
                side: 3,
                msg: '请输入正确用户',
                bg: '#00A2E9',
                time: 4
            });
            return false;
        }
        if (nul) {
            var phone = "${user.phone}";
            var name = "${user.name}";
            var search = $("#searchinfo").val();
            if (search == phone || search == name) {
                $("#searchinfo").tips({
                    side: 3,
                    msg: '不能给自己转账',
                    bg: '#00A2E9',
                    time: 4
                });
                return false;
            }
            if(targetstatus!='2'){
        		$("#searchinfo").tips({
                    side: 3,
                    msg: '目标用户未完成认证，不可转账',
                    bg: '#00A2E9',
                    time: 4
                });
                return false;
        	}

            var num = $("#num").val();
            var total = "${not empty user.userPurse.availablecoin ? user.userPurse.availablecoin:'0.00'}"
            if (num * 1 > total * 1 || num * 1 <= 0) {
                $("#num").tips({
                    side: 3,
                    msg: '转账金额必须大于0并且小于可用金额',
                    bg: '#00A2E9',
                    time: 4
                });
                return false;
            }
            /* if ($(".loading").is(':hidden')) {
             $(".loading").show();
             } else {
             return false;
             } */
            $(".loading_lock").show();
            if ($("#password").val() != "" && $("#password").val() != null) {
                $.ajax({
                    url: "${ctx}/wlpt/user/validateCashPwd",
                    dataType: 'json',
                    data: {"cashPwd": $("#password").val(), "isSave": false},
                    type: "post",
                    success: function (data) {
                        if (data == false) {
                            $("#password").tips({
                                side: 3,
                                msg: '支付密码错误或未设置支付密码',
                                bg: '#00A2E9',
                                time: 4
                            });
                            $(".loading_lock").hide();
                        } else {
                            $.ajax({
                                url: "${wlpt}/wlpt/consume/transferCoin",
                                dataType: 'json',
                                data: {"target.searchinfo": $("#searchinfo").val(), "consumemony": num},
                                type: "post",
                                success: function (data) {
                                    if (data.value == 1) {
                                        window.location.href = '${wlpt}/wlpt/consume/toPurse';
                                    } else if (data.value == 5) {
                                        $.MsgBox.Alert("转账提示", "可用卓币不足");
                                        $(".loading_lock").hide();
                                    } else if (data.value == 2) {
                                        $.MsgBox.Alert("转账提示", "用户不存在");
                                        $(".loading_lock").hide();
                                    }
                                    else {
                                        $.MsgBox.Alert("转账提示", "转账失败");
                                        $(".loading_lock").hide();
                                    }
                                }
                            });
                        }
                    }
                });
            }
        }
    });
</script>
</body>
</html>
