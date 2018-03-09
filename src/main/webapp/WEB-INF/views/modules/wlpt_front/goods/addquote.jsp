<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
     <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>添加报价</title>
    <style type="text/css">
        body {
            padding: 0;
            margin: 0;
            width: 100%;
            margin: 0 auto;
            text-align: center;
            border: 1px solid #D6D3CE;
            font-family: "微软雅黑"
        }

        ul p span a input td {
            font-family: "微软雅黑";
        }

        .goods-manage td, .goods-manage th {
            text-align: center;
        }

        .goods-manage td p {
            text-align: center;
            margin: 10px 0px;
        }

        .td-left {
            width: 22%;
            height: 30px;
            text-align: right;
        }

        .input {
            height: 30px;
        }

        .loading_lock {
            display: none;
            width: 88%;
            height: 100%;
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
            width: 200px;
            height: 35px;
            border: solid 1px;
            border-radius: 0px;
            background-color: #FFC52F;
            border-color: #FFC52F;
            cursor: pointer;
            font-weight: bold;
            text-align: center;
            color: white;
            margin-top: 6px;
            font-size: 16px;
        }
  /* 自动补全 */
  .custom-combobox {
    position: relative;
    display: inline-block;
  }
  .custom-combobox-toggle {
    position: absolute;
    top: 0;
    bottom: 0;
    margin-left: -1px;
    padding: 0;
    /* 支持： IE7 */
    *height: 1.7em;
    *top: 0.1em;
  }
  .custom-combobox-input {
    margin: 0;
    padding: 0.3em;
  }
  </style>
    </style>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link href="${ctxStatic}/jquery-ui/1.10.4/jquery-ui.css" type="text/css" rel="stylesheet"/>
    <link href="${ctxStatic}/bootstrap/2.3.1/css_3.2cerulean/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="${ctxStatic }/bootstrap/2.3.1/awesome/font-awesome.min.css" type="text/css" rel="stylesheet">
    <link href="${ctxStatic }/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet">
    

</head>
<body ng-app="dataHall" ng-controller="dataHallCtrl">
<div class="content-2 baojia-list" style="border-bottom: 0 solid #ccc;">
    <p class="user_data">
        <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">添加</span><span
            class="title_orange">报价</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
    </p>
	<div>
        <label class="control-label">用户：</label>
        <input id="searchinfo" name="searchinfo" style="font-size: 14px;line-height: 25px;" placeholder="用户名/电话"/>
        <button type="button" onclick="search();" class="regbt" style="width: 100px;">
            <span class="glyphicon glyphicon-search"></span><span class="goods_search_btn">搜索</span>
            
        </button>
        <span onclick="showBg1();"><a href="#">常用联系人</a></span>
    </div>
    <div id="info" hidden="hidden">
        <form:form id="inputForm" modelAttribute="user" action="${wlpt}/wlpt/driver/saveAttach" method="post">
            <input id="userid" name="reuser.id" type="hidden"/>
            <input id="role" type="hidden"/>
            <table class="table_border" cellpadding="0" cellspacing="0"
                   style="margin: auto;margin-top: 30px;margin-bottom: 30px;">
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
        </form:form>
    
    <input id="gsid" value="${goods.id}" type="hidden"/>
    <table class="table_border" cellpadding="0" cellspacing="0" style="margin-bottom: 0px;">
        <tr>
            <td class="td-left">报价：</td>
            <td><input id="ooferprice" name="ooferprice" placeholder="请输入报价" value="${goods.expectedprice}" class="input required number" type="text"
                       style="border:0;"/><span>元/${goods.freightunit}</span></td>
        </tr>
        <tr>
            <td class="td-left">指派吨数：</td>
            <td>
                <input id=residualvolume value="${goods.residualvolume}" type="hidden"/>
                <input id="oddloadweight" name="oddloadweight" placeholder="请输入运输量" value="${goods.residualvolume}" class="input required number"
                       type="text" style="border:0;"/><span>${goods.freightunit}</span></td>
        </tr>
        <tr>
            <td colspan=2 style="text-align: center;">
	            <input id="btnSubmit" class="btn btn-warning" type="button"
	            style="min-width:100px;margin-bottom: 30px;background-color:#FFC52F;border-color:#FFC52F;margin-top: 30px;"/>
                &nbsp;<input id="btnCancel" class="btn btn-warning" type="button"
                style="width: 95px;margin-bottom: 30px;background-color:#FFC52F;border-color:#FFC52F;margin-top: 30px;"
                value="返 回" onclick="history.go(-1)"/>
            </td>
        </tr>
        <sys:wlptmessage content="${message}"/>
    </table>
</div>
</div>
<div class="loading_lock" style="width: 88%;"><img src="${ctxStatic }/images/loading.gif">
    <p>等待中</p></div>

<div class="content-2 baojia-list" style="border-bottom: 0 solid #ccc;">
    <p class="user_data">
        <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">货物</span><span
            class="title_orange">详情</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
    </p>
    <p class="list_two">
        <table class="table_border" cellpadding="0" cellspacing="0">
            <tr>
                <td class="cols_1 center-tit" colspan=4><span class="orange_bold">${goods.goodsname}</span></td>
            </tr>

            <tr>
                <td class="cols_1">始发地：</td>
                <td class="cols_2" colspan=3>${goods.shipAddress.city}${goods.shipAddress.district}
                </td>
            </tr>

            <tr>
                <td class="cols_1">详细地址：</td>
                <td class="cols_2" colspan=3>${goods.shipAddress.address }
                </td>
            </tr>

            <tr>
                <td class="cols_1">目的地：</td>
                <td class="cols_2" colspan=3>${goods.consignAddress.city }${goods.consignAddress.district }
                </td>
            </tr>

            <tr>
                <td class="cols_1">详细地址：</td>
                <td class="cols_2" colspan=3>${goods.consignAddress.address }</td>
            </tr>

            <tr>
                <td class="cols_1">货运量：</td>
                <td class="cols_2">${goods.freightvolume }${goods.freightunit} &nbsp;&nbsp;剩余运量：${goods.residualvolume }${goods.freightunit}</td>
                <td class="cols_3">货物类型：</td>
                <td class="cols_4"><c:if test="${goods.goodstype == '0'}">轻货</c:if><c:if
                        test="${goods.goodstype == '1'}">重货</c:if></td>
            </tr>

            <tr>
                <td class="cols_1">货主出价：</td>
                <td class="cols_2">${goods.expectedprice!=null?goods.expectedprice:'0.00' }${goods.expectedprice!='0.00'?'元/吨':''}</td>
                <td class="cols_3">货物类别：</td>
                <td class="cols_4"><c:if test="${goods.gsoddtype == '1'}">成品</c:if><c:if
                        test="${goods.gsoddtype == '2'}">原料</c:if></td>
            </tr>
            <tr>
                <td class="cols_1">运输方式：</td>
                <td class="cols_2">${goods.transportway }</td>
                <td class="cols_3">货物价值：</td>
                <td class="cols_4">${goods.worth!=null?goods.worth:"0.00"}元</td>
            </tr>
            <tr>
                <td class="cols_1">车型要求：</td>
                <td class="cols_2">${goods.cartype }</td>
                <td class="cols_3">车长要求：</td>
                <td class="cols_4">${not empty goods.carlength?goods.carlength:"不限"}${not empty goods.carlength?"米":""}</td>
            </tr>
            <tr>
                <td class="cols_1">用户名：</td>
                <td class="cols_2" colspan=3>${goods.user.name }
                    <c:if test="${goods.user.userinfo.status == '2' }">
                        <span class="list_one_2 bg_light_green">已认证</span></c:if>
                    <c:if test="${goods.user.userinfo.status != '2' }">
                        <span class="list_one_2 bg_light_green">未认证</span></c:if>
                </td>
            </tr>
            <tr>
                <td class="cols_1">信用等级：</td>
                <td class="cols_2"><img
                        src="${ctxStatic}/images/wlptfront/pointlevel/point_level_${goods.user.userinfo.pointlevle!=null?goods.user.userinfo.pointlevle:0}.gif">
                </td>
                <td class="cols_3">担保金额：</td>
                <td class="cols_4"><span
                        class="orange_bold">${not empty goods.user.userPurse.guaranteemone?goods.user.userPurse.guaranteemone:"0.00"}</span>元
                </td>
            </tr>

            <tr>
                <td class="cols_1">联系人姓名：</td>
                <td class="cols_2">${goods.shipAddress.linkman }</td>
                <td class="cols_3">联系电话：</td>
                <td class="cols_4">${goods.shipAddress.linkmobile }</td>
            </tr>

            <tr>
                <td class="cols_1">发货时间：</td>
                <td class="cols_2">${sendtime}</td>
                <td class="cols_3">有效天数：</td>
                <td class="cols_4">${goods.effectdays }</td>
            </tr>

            <tr>
                <td class="cols_1">补充说明：</td>
                <td class="cols_2" colspan=3>${goods.remarks }</td>
            </tr>

          
</table>
</p>
</div>
<%@ include file="/WEB-INF/views/modules/wlpt_front/contacts/contacts_info.jsp" %>
<style type="text/css">
#dialog {
    top: 45%;
}
</style>
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/jquery-jbox/2.3/jquery.jBox-2.3.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/common/mustache.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/common/global.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-ui/1.10.4/jquery-ui.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/autocomplete.js?id=22" type="text/javascript"></script>
<script>
function search() {
    var isnul = true;
    isnul = isnul && $("#searchinfo").valid({
                methods: "required"
            });
    if (isnul) {
    	$(".loading_lock").show();
        var searchinfo = $("#searchinfo").val();
        $.ajax({
            url: "${wlpt}/wlpt/goods/searchInfo",
            dataType: 'json',
            data: {searchinfo: searchinfo},
            cache: false,
            success: function (data) {
            	$(".loading_lock").hide();
            	if (data) {
            		if (data.value == '未查到指定用户') {
            			$("#info").hide();
                        $("#searchinfo").tips({
                            side: 3,
                            msg: '未查到指定用户!请确认用户是否已注册',
                            bg: '#00A2E9',
                            time: 4
                        });
                    } else if(data.value=='该用户无车辆信息'){
                    	$("#info").hide();
                    	$("#searchinfo").tips({
                            side: 3,
                            msg: '该用户无车辆信息,不可指派',
                            bg: '#00A2E9',
                            time: 4
                        });
                    }else if(data.value=='该用户无司机信息'){
                    	$("#info").hide();
                    	$("#searchinfo").tips({
                            side: 3,
                            msg: '该用户无司机信息,不可指派',
                            bg: '#00A2E9',
                            time: 4
                        });
                    }else {
                        if(data.value.role.enname!="carowner"&&data.value.role.enname!="enterprise"){
                        	$("#info").hide();
                        	$("#searchinfo").tips({
                                side: 3,
                                msg: '只能指派给物流企业或车主',
                                bg: '#00A2E9',
                                time: 4
                            });
                        }else{
                        	if (data.value.role.enname) {
                                $("#role").val(data.value.role.enname);
                            }
                            if (data.value.user.id) {
                                $("#userid").val(data.value.user.id);
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
                                if (data.value.info.status == '2') {
                                    $("#status").html("认证：" + '认证通过');
                                } else {
                                    $("#status").html("认证：" + '未通过');
                                }

                            }
                            $("#info").show();
                            if (data.value.user.id) {
                                $("#userid").val(data.value.user.id);
                            }
                            
                        }
                        
                    }
                }
            }
        });
        
    }
   
}


    if ($("#residualvolume").val() == 0) {
        $("#btnSubmit").val("报价已结束");
        $("#btnSubmit").attr('disabled', 'disabled');
    } else {
        $("#btnSubmit").val("下一步,生成运单");
        /* if ($("#driverid").val() == null || $("#driverid").val() == "") {
            $("#driverid").tips({
                side: 3,
                msg: '您没有可以选择的司机！',
                bg: '#00A2E9',
                time: 2
            });
            $("#btnSubmit").attr('disabled', 'disabled');
        }
        else if ($("#carid").val() == null || $("#carid").val() == "") {
            $("#carid").tips({
                side: 3,
                msg: '您没有可以选择的车辆！',
                bg: '#00A2E9',
                time: 2
            });
            $("#btnSubmit").attr('disabled', 'disabled');
        } */

        $("#btnSubmit").click(function () {
            var isnul = true;
            
            if ($("#userid").val() == null || $("#userid").val() == "") {
                $("#searchinfo").tips({
                    side: 3,
                    msg: '请输入用户！',
                    bg: '#00A2E9',
                    time: 2
                });
                return false;
            }
            isnul = isnul && $("input[name=ooferprice]").valid({
                        methods: "required|decimalTwo"
                    });
            isnul = isnul && $("input[name=oddloadweight]").valid({
                        methods: "required|decimal"
                    });
            if (($("#ooferprice").val() * 1) <= 0) {
                $("#ooferprice").tips({
                    side: 3,
                    msg: '报价不能小于0',
                    bg: '#00A2E9',
                    time: 2
                });
                return false;
            }
            if (($("#oddloadweight").val() * 1) < 0) {
                $("#oddloadweight").tips({
                    side: 3,
                    msg: '报价吨位不能小于0',
                    bg: '#00A2E9',
                    time: 2
                });
                return false;
            }
            if (($("#residualvolume").val() * 1) < ($("#oddloadweight").val() * 1)) {
                $("#oddloadweight").tips({
                    side: 3,
                    msg: '报价吨位不能大于货物剩余吨位！',
                    bg: '#00A2E9',
                    time: 2
                });
                return false;
            }
            if (isnul) {
                var gdsid = $("#gsid").val();
                var driverid = $("#driverid").val();
                var carid = $("#carid").val();
                var ooferprice = $("#ooferprice").val() * 1;
                var oddloadweight = $("#oddloadweight").val() * 1;
                var userid = $("#userid").val();
                $(".loading_lock").show();
                $.ajax({
                    type: "POST",
                    url: '${wlpt}/wlpt/goods/saveAddQuote',
                    dataType: 'json',
                    data: {
                    	'userid':userid,
                        'goods.id': gdsid,
                        'ooferprice': ooferprice,
                        'oddloadweight': oddloadweight

                    },
                    cache: false,
                    success: function (data) {
                    	if (data.value.state == 1) {
                            if(data.value.data !=null && data.value.data.id!=""){
                            	window.location.href = '${wlpt}/wlpt/goods/quoteOrder?id='+data.value.data.id;
                            }else{
                            	window.location.href = '${wlpt}/wlpt/goods/goods_list?isRedrect=true';
                            }
                            
                        } else {
                        	$(".loading_lock").hide();
                            $.MsgBox.Alert("保存提示", data.value.message);
                        }
                        
                    }
                });
            }
        });
    }
    function updatePraiseNumber() {
        var gdsid = $("#gsid").val();
        var num =${goods.praisenumber};
        var newnum = $("#num").html();
        if ((num * 1) < (newnum * 1)) {
            return;
        }
        $.ajax({
            type: "POST",
            url: '${wlpt}/wlpt/goods/updatePraiseNumber',
            dataType: 'json',
            data: {
                'id': gdsid
            },
            cache: false,
            success: function (data) {

                $("#num").html(num + 1);
            }
        });
    }
</script>
</body>
</html>
