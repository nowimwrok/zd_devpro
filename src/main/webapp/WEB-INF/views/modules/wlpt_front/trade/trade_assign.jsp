<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_personal_basic"/>

    <title>修改报价信息</title>
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

    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link href="${ctxStatic}/jquery-ui/1.10.4/jquery-ui.css" type="text/css" rel="stylesheet"/>
    <link href="${ctxStatic}/bootstrap/2.3.1/css_3.2cerulean/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="${ctxStatic }/bootstrap/2.3.1/awesome/font-awesome.min.css" type="text/css" rel="stylesheet">
    <link href="${ctxStatic }/jquery-jbox/2.3/Skins/Bootstrap/jbox.min.css" rel="stylesheet">
    <script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${ctxStatic }/jquery-jbox/2.3/jquery.jBox-2.3.min.js" type="text/javascript"></script>
    <script src="${ctxStatic }/common/mustache.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctxStatic }/common/global.js"></script>
    <script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
    <script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>

</head>
<body>
<div ng-app="dataHall" ng-controller="dataHallCtrl">
    <div class="content-2 baojia-list" style="border-bottom: 0 solid #ccc;">
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">运输</span><span
                class="title_orange">信息</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
        </p>

        <table class="table_border" cellpadding="0" cellspacing="0" style="margin-bottom: 0px;">
            <tr>
                <td class="td-left">司机：</td>
                <td id="driverinfo">
                    <select name="driverid" id="driverid" style="border:0;" class="required" placeholder="请输入司机手机号码或姓名">
                        <option value="" id="driveroption">请选择...</option>
                    </select>

                </td>
            </tr>
            <tr>
                <td class="td-left">车辆：</td>
                <td id="carinfo">
                    <select name="carid" id="carid" style="border:0;" class="required" placeholder="请输入车牌号码">
                        <option value="" id="caroption">请选择...</option>
                    </select>

                </td>
            </tr>

            <tr>
                <td colspan=2 style="text-align: center;">
                    <input id="btnSubmit" class="btn btn-warning" type="button" value="确认运输"
                           style="width: 95px;margin-bottom: 30px;background-color:#FFC52F;border-color:#FFC52F;margin-top: 30px;"/>
                    &nbsp;<input id="btnCancel" class="btn btn-warning" type="button"
                                 style="width: 95px;margin-bottom: 30px;background-color:#FFC52F;border-color:#FFC52F;margin-top: 30px;"
                                 value="返 回" onclick="history.go(-1)"/>
                </td>
            </tr>
            <sys:wlptmessage content="${message}"/>
        </table>
    </div>
    <div class="loading_lock" style="width: 88%;"><img src="${ctxStatic }/images/loading.gif">
        <p>等待中</p></div>

    <div class="content-2 baojia-list" style="border-bottom: 0 solid #ccc;">
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">报价</span><span
                class="title_orange">信息</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
        </p>
        <p class="list_two">
        <table class="table_border" cellpadding="0" cellspacing="0">
            <tr>
                <td class="cols_1 center-tit" colspan=4><span
                        class="orange_bold">${quoteinfo.driver.name!=null?quoteinfo.driver.name:quoteinfo.driver.loginName }</span>
                </td>
            </tr>


            <tr>
                <td class="cols_1">报价吨位：</td>
                <td class="cols_2" colspan=3>${quoteinfo.oddloadweight}吨
                </td>
            </tr>
            <c:if test="${quoteinfo.isreload==1 }">
                <tr>
                    <td class="cols_1">实际配载：</td>
                    <td class="cols_2" colspan=3>${quoteinfo.actload}吨
                    </td>
                </tr>
            </c:if>
            <tr>
                <td class="cols_1">本次报价：</td>
                <td class="cols_2" colspan=3>${quoteinfo.ooferprice}元/吨</td>
            </tr>
            <tr>
                <td class="cols_1">状态：</td>
                <td class="cols_2" colspan=3><span
                        class="list_one_2 bg_light_green">${fns:getDictLabel(quoteinfo.quotestatus, 'quotestatus', '')}</span>
                </td>

            </tr>
            <tr>
                <td class="cols_1">报价时间：</td>
                <td class="cols_2"><fmt:formatDate value="${quoteinfo.beginCreateDate}" pattern="yyyy-MM-dd"/></td>
            </tr>
        </table>
        </p>
    </div>
    <div class="content-2 baojia-list">
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">货物</span><span
                class="title_orange">信息</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
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
                <td class="cols_1">货物重量：</td>
                <td class="cols_2" colspan=3>${goods.freightvolume }吨</td>

            </tr>
            <tr>
                <td class="cols_1">车型要求：</td>
                <td class="cols_2">${goods.cartype }</td>
                <td class="cols_3">车长要求：</td>
                <td class="cols_4">${goods.carlength }米</td>
            </tr>
        </table>
        </p>
    </div>
</div>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-ui/1.10.4/jquery-ui.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/autocomplete.js?id=22" type="text/javascript"></script>
<script>

    getcaranddriverinfo("${user.id}");
    function getcaranddriverinfo(userid) {
        $("#driverid").combobox();
        $("#carid").combobox();
        if (userid != undefined && userid != "" && userid != null) {
            $.ajax({
                url: "${wlpt}/wlpt/goods/getCarAndDriverInfo",
                dataType: 'json',
                data: {id: userid},
                cache: false,
                success: function (data) {
                    if (data.value) {
                        var driverarray = data.value.driver;
                        if (driverarray != null && driverarray.length > 0) {
                            var driverhtml = "";
                            for (var i = 0; i < driverarray.length; i++) {
                                var name = driverarray[i].reuser.name != undefined && driverarray[i].reuser.name != null ? driverarray[i].reuser.name : "";
                                var phone = driverarray[i].reuser.phone != undefined && driverarray[i].reuser.phone != null ? driverarray[i].reuser.phone : "";
                                var driverid = "${quoteinfo.driver.id}";
                                if (driverid != "" && driverid == driverarray[i].reuser.id) {
                                    driverhtml += '<option value="' + driverarray[i].reuser.id + '" selected="selected">' + name + '&nbsp;' + phone + '</option>';
                                } else {
                                    driverhtml += '<option value="' + driverarray[i].reuser.id + '">' + name + '&nbsp;' + phone + '</option>';
                                }

                            }
                            $("#driverid").append(driverhtml);

                        } else {
                            $("#driverinfo").html("该用户没有可以选择的司机！");
                        }
                        var cararray = data.value.car;
                        if (cararray != null && cararray.length > 0) {
                            var carhtml = "";
                            for (var i = 0; i < cararray.length; i++) {
                                var carnumber = cararray[i].carnumber != undefined && cararray[i].carnumber != null ? cararray[i].carnumber : "";
                                var loadweight = cararray[i].loadweight != undefined && cararray[i].loadweight != null ? cararray[i].loadweight : "";
                                var carid = "${quoteinfo.car.id}";
                                if (carid != "" && carid == cararray[i].id) {
                                    carhtml += '<option value="' + cararray[i].id + '" selected="selected">' + carnumber + '&nbsp;' + loadweight + '吨</option>';
                                } else {
                                    carhtml += '<option value="' + cararray[i].id + '">' + carnumber + '&nbsp;' + loadweight + '吨</option>';
                                }

                            }
                            $("#carid").append(carhtml);

                        } else {
                            $("#carinfo").html("该用户没有可以选择的车辆！");
                        }


                    } else {
                        $("#driverinfo").html("该用户没有可以选择的司机！");
                        $("#carinfo").html("该用户没有可以选择的车辆！");
                    }

                }
            });

        }

    }

    $("#btnSubmit").click(function () {
        var isnul = true;
        if ($("#driverid").val() == null || $("#driverid").val() == "") {
            $("#driverinfo").tips({
                side: 3,
                msg: '请选择司机！',
                bg: '#00A2E9',
                time: 2
            });
            return false;
        }
        if ($("#carid").val() == null || $("#carid").val() == "") {
            $("#carinfo").tips({
                side: 3,
                msg: '请选择车辆！',
                bg: '#00A2E9',
                time: 2
            });
            return false;
        }


        var driverid = $("#driverid").val();
        var carid = $("#carid").val();
        var userid = $("#userid").val();
        $(".loading_lock").show();
        $.ajax({
            type: "POST",
            url: '${wlpt}/wlpt/trade/confrimOrder',
            dataType: 'json',
            data: {
                'id': '${oinfo.id}',
                'quoteinfo.ischange': '1',
                'quoteinfo.driver.id': driverid,
                'quoteinfo.car.id': carid,

            },
            cache: false,
            success: function (data) {
                if (data.state == "1") {
                    $.MsgBox.Alert("交易提示", data.message);
                    window.location.href = "${wlpt}/wlpt/trade/trade_list?isRedrect=true"
                } else {
                    $(".loading_lock").hide();
                    $.MsgBox.Alert("交易提示", data.message);
                }
            }
        });
    });


</script>
</body>
</html>
