<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_default_basic"/>
    <title>报价查看</title>
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
        /* 自动补全 */
  .custom-combobox {
    position: relative;
    display: inline-block;
    width: 80%;
   
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
    width:80%;
  }
    </style>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <link href="${ctxStatic}/jquery-ui/1.10.4/jquery-ui.css" type="text/css" rel="stylesheet"/>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
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
<body ng-app="dataHall" ng-controller="dataHallCtrl">
<div class="content-2 baojia-list" style="width: 68%;border-bottom: 0 solid #ccc;">
    <p class="user_data">
        <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">司机</span><span
            class="title_orange">报价</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
    </p>

    <input id="gsid" value="${goods.id}" type="hidden"/>
    <table class="table_border" cellpadding="0" cellspacing="0" style="margin-bottom: 0px;">
        <tr>
            <td class="td-left">司机：</td>
            <td id="driverinfo">
                <c:choose>
                    <c:when test="${not empty driver}">
                        <select name="driverid" id="driverid" style="border:0;" class="required" placeholder="请输入司机手机号码或姓名">
                            <option value="">请选择...</option>
                            <c:forEach items="${driver}" var="dr" varStatus="i">
                                <option value="${dr.reuser.id}" selected="<c:if test="${s.index==0 }">selected</c:if>">${dr.reuser.name}&nbsp;${dr.reuser.phone}</option>
                            </c:forEach>
                        </select>
                    </c:when>
                    <c:otherwise><span style="margin-right: 24%;">您没有可以选择的司机，请先绑定司机！</span></c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <td class="td-left">车辆：</td>
            <td id="carinfo">
                <c:choose>
                    <c:when test="${not empty car}">
                        <select name="carid" id="carid" style="border:0;" class="required" placeholder="请输入车牌号码">
                        <option  value="">请选择...</option>
                            <c:forEach items="${car}" var="c" varStatus="s">
                                <option value="${c.id}" selected="<c:if test="${s.index==0 }">selected</c:if>"  >${c.carnumber}&nbsp;${c.cartype}&nbsp;${c.carlength}米&nbsp;${c.loadweight}吨</option>
                            </c:forEach>
                        </select>
                    </c:when>
                    <c:otherwise><span style="margin-right: 24%;">您没有可以选择的车辆，请先发布车辆！</span></c:otherwise>
                </c:choose>
            </td>
        </tr>
        <tr>
            <td class="td-left">报价：</td>
            <td><input id="ooferprice" name="ooferprice" placeholder="请输入报价" value="${goods.expectedprice}" class="input required number" type="text"
                       style="border:0;margin-left:-25%;"/><span>元/${goods.freightunit}</span></td>
        </tr>
        <tr>
            <td class="td-left">我要运：</td>
            <td>
                <input id=residualvolume value="${goods.residualvolume}" type="hidden"/>
                <input id="oddloadweight" name="oddloadweight" placeholder="请输入运输量" value="${goods.residualvolume}" class="input required number"
                       type="text" style="border:0;margin-left:-28%;"/><span>${goods.freightunit}</span></td>
        </tr>
        <tr>
            <td colspan=2 style="text-align: center;"><input id="btnSubmit" class="btn btn-warning" type="button"
                                                             style="width: 95px;margin-bottom: 30px;background-color:#FFC52F;border-color:#FFC52F;margin-top: 30px;"/>
                &nbsp;<input id="btnCancel" class="btn btn-warning" type="button"
                             style="width: 95px;margin-bottom: 30px;background-color:#FFC52F;border-color:#FFC52F;margin-top: 30px;"
                             value="返 回" onclick="history.go(-1)"/>
            </td>
        </tr>
        <c:if test="${line !=null }">
        <tr>
            <td colspan=2 style="text-align: center;">
            	温馨提示：当前${line.startaddress }-${line.endaddress }的线路运价为${line.priceinfo.newprice } 元/${goods.freightunit}!
            </td>
        </tr>
        </c:if>
        <sys:wlptmessage content="${message}"/>
    </table>
</div>
<div class="loading_lock" style="width: 88%;"><img src="${ctxStatic }/images/loading.gif">
    <p>等待中</p></div>

<div class="content-2 baojia-list" style="width: 68%;border-bottom: 0 solid #ccc;">
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
			<c:if test="${not empty goods.isinsur and goods.isinsur eq 1 }">
	        <tr>
	            <td class="cols_1">是否投保:</td>
	            <td class="cols_2">${fns:getDictLabel(goods.isinsur,'yes_no','')}</td>
	            <td class="cols_3">保单支付方:</td>
	            <td class="cols_4">${fns:getDictLabel(goods.paypeople,'insur_paypeople','')}</td>
	        </tr>
	        </c:if>
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

            <tr class="tr-last">
                <td class="cols_1" style="border-right:none;"></td>
                <td class="cols_2" colspan=3 style="border-left:none;padding-top: 20px;">

<div class="cols_last">
    <a href="javascript:;" onclick="updatePraiseNumber();"><img src="${ctxStatic }/images/wlptfront/zan.png">
        <p>赞一下</p></a>
</div>
<div class="cols_last">
    <div class="right_orange cols_orange"><span id="num">${goods.praisenumber }</span></div>
    <p>点击量</p>
</div>
</td>
</tr>
</table>
</p>
</div>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script src="${ctxStatic}/jquery-ui/1.10.4/jquery-ui.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/autocomplete.js?id=22" type="text/javascript"></script>

<script>
$("#driverid").combobox();
$("#carid" ).combobox();
    if ($("#residualvolume").val() == 0) {
        $("#btnSubmit").val("报价已结束");
        $("#btnSubmit").attr('disabled', 'disabled');
    } else {
    	
        $("#btnSubmit").val("报价");
        if ($("#driverid").val() == null || $("#driverid").val() == "") {
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
        }
		
        $("#btnSubmit").click(function () {
            var isnul = true;
            var did =  $("#driverid").val();
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
                var title = "";
                if('${goods.isinsur}'=="1"){
                	if('${goods.paypeople}'=="1"){
                		title = "该运单需购买货运保险，付款方为：承运方，";
                    }else{
                    	title = "该运单需购买货运保险，付款方为：发货方，";
                    }
                }
                $.MsgBox.Confirm("抢单提示", title+"确定报价?", function () {
                $(".loading_lock").show();
                $.ajax({
                    type: "POST",
                    url: '${wlpt}/wlpt/goods/saveQuote',
                    dataType: 'json',
                    data: {
                        'goods.id': gdsid,
                        'driver.id': driverid,
                        'car.id': carid,
                        'ooferprice': ooferprice,
                        'oddloadweight': oddloadweight

                    },
                    cache: false,
                    success: function (data) {
                        if (data.value == "请先登录系统") {
                            window.location.href = "${wlpt}/login?login=login";
                        }
                        else if (data.value == "报价成功") {
                            window.location.href = "${wlpt}/wlpt/hall/goods";
                        } else {
                            $(".loading_lock").hide();
                            $.MsgBox.Alert("报价提示", data.value);
                        }
                    }
                });
                }, function () {
                	 $(".loading_lock").hide();
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
