<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <title>添加车辆</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <style type="text/css">
        body {
            padding: 0;
            margin: 0;
            margin: 0 auto;
            height: 700px;
            text-align: center;
            border: 1px solid #D6D3CE;
            font-family: "微软雅黑"
            font-size: 14px;
        }

        * {
            font-family: "微软雅黑";
            margin: 0;
            font-size: 14px;
        }

        .godsName {
            width: 179px;
            height: 200px;
            -webkit-border-radius: 4px;
            border: solid 1px #CCC;
            display: none;
            z-index: 2;
            background: rgba(255, 255, 255, 0.8) none repeat scroll 0 0 !important;
            position: absolute;
            min-height: 200px;
            overflow-y: auto;
            max-height: 200px;
            margin-top: 30px;
        }

        .inputtext {
            width: 100px;
        }

        /* 车牌号码 */
        .cgs-key-text {
            font-size: 14px;
            font-weight: bold;
            color: #3499D4;
        }

        /* 车辆的车主信息 */
        .carforcompany {
            font-size: 14px;
            font-weight: bold;
            color: #3499D4;
        }

        .regbt {
            width: 100px;
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

        .godsName ul {
            width: 100%;
        }

        .godsName ul li {
            height: 20px;
            line-height: 20px;
            cursor: pointer;
            over-flowt: scoller;
            width: 100%;
        }

        .godsName ul li:HOVER {
            background-color: #DDDDDD;
        }

        .page-title {
            border-left: solid 4px #FF0000;
            width: 200px;
            height: 1.5em;
            font-size: 14px;
            font-weight: bold;
            line-height: 24px;
            padding-left: 10px;
            color: #555;
            margin: 20px;
            text-align: left;
        }

        input[type='button'] {
            display: inline-block;
            font-size: 14px;
        }

        .xiao_td {
            height: 37px;
            line-height: 37px;
            color: #333;
            font-size: 14px;
            font-family: "微软雅黑";
        }

        .cy_left_td {
            width: 30%;
            text-align: right;
        }

        .cy_center_td {
            width: 45%;
        }

        .cy_right_td {
            width: 40%;
        }

        .xinghao {
            color: #F00;
        }
        .load{
            width: 100%;
            height: 94%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 0px;
            text-align: center;
        }
        .load img{
            margin-top: 25%;
        }
      	ol li{
      		float:left;
      	}
    </style>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <link href="${ctxStatic }/common/jeesite.css" type="text/css" rel="stylesheet">
    <script src="${ctxStatic }/common/jeesite.js" type="text/javascript"></script>
    <script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${ctxStatic }/jquery-select2/3.4/select2.min.js" type="text/javascript"></script>
    <script src="${ctxStatic }/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="${ctxStatic }/common/mustache.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctxStatic }/common/global.js"></script>
    <script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
    <script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>

</head>
<body style="height: 1000px;">
<div class="tab_fir tab-all" style="height: 940px;">
    <form:form action="${wlpt}/wlpt/car/saveCar" name="Form" id="Form" modelAttribute="car" method="post">
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"/><span class="title_blue">添加</span>
            <span class="title_orange">车辆</span><img src="${ctxStatic }/images/wlptfront/line-right.png"/>
        </p>
        <table width="100%" border="0" style="margin-top:10px;">
            <tr>
                <td class="cy_left_td xiao_td"><span class="xinghao">*</span>车牌号码：</td>
                <td class="cy_center_td xiao_td">
                    <input type="hidden" id="status" name="status" value="${car.status}"/>
                    <input type="hidden" id="carid" name="id" value="${car.id }"/>
                    <input type="hidden" name="user.id" value="${car.user.id }"/>
                    <input id="MININAME" name="mininame" value="${car.mininame}" readonly="readonly" type="text"
                           class="required"
                           style="width:30px;text-align:center;"/>
                    <input type="text" id="NUMBER" name="number"
                           value="${car.number }" class="inputtext required isCarNumber" maxlength="6"/>
                    <input type="hidden" name="carnumber" id="carnumber" value="${car.carnumber}"/>
                    <form:select path="issocialcar" name="issocialcar" class="input-xlarge " cssClass="required">
                        <form:options items="${fns:getDictList('issocialcar')}" itemLabel="label" itemValue="value"
                                      htmlEscape="false"/>
                    </form:select>
                </td>
            </tr>
            <tr>
                <td class="cy_left_td xiao_td"><span class="xinghao">*</span>车辆类型：</td>
                <td class="cy_center_td xiao_td">
                    <input id="cartype" name="cartype" value="${car.cartype}" readonly="readonly" type="text"
                           style="width: 74px;;text-align:center;"/>
                </td>

            </tr>
            <tr>
                <td class="cy_left_td xiao_td"><span class="xinghao">*</span>车&nbsp;&nbsp;长：</td>
                <td class="cy_center_td xiao_td">
                    <form:input path="carlength" name="carlength" htmlEscape="false" class="input-xlarge"
                                cssClass="required number"/>
                    <span>米</span></td>

            </tr>
            <tr>
                <td class="cy_left_td xiao_td"><span class="xinghao">*</span>载&nbsp;&nbsp;重：</td>
                <td class="cy_center_td xiao_td">
                    <form:input path="loadweight" name="loadweight" htmlEscape="false" class="input-xlarge" cssClass="required number"/>
                    <span>吨</span>
                </td>
            </tr>
            <tr>
                <td class="cy_left_td xiao_td"><span class="xinghao">*</span>主营路线：</td>
                <td class="cy_center_td xiao_td">
                    <input type="text" name="fromaddress" id="fromAddress" value="${car.fromaddress }" readonly="readonly" class="inputwidth inputborder required" placeholder="请选择出发地" maxlength="100"/>
                    <img style="vertical-align: middle;height:30px;" src="${ctxStatic }/images/wlptfront/switch_btn.png"/>
                    <input type="text" name="toaddress" id="toAddress" value="${car.toaddress }" readonly="readonly" class="inputwidth inputborder required" placeholder="请选择目的地" maxlength="100"/>
                    <input type="hidden" name="mainroad" id="MAINROAD" value=""/></td>
            </tr>
            <tr>
                <td class="cy_left_td xiao_td"><span class="xinghao" id=xinhaos></span>定位手机号：</td>
                <td class="cy_center_td xiao_td"><input name="locationmobile" maxlength="11" type="text"
                                                        id="LOCATIONMOBILE" value="${car.locationmobile }"
                                                        class="inputwidth inputborder mobile"/>
                    <input style="margin-left:5px;" id="WHITELISTID" name="WHITELISTID" type="checkbox" value="1"
                           onclick="iswhitelistid()"/><span>是否开启定位</span></td>

            </tr>
            <tr>
                <td></td>
                <td style="color:red;" id="lcmsg">车辆的定位跟踪功能会用到定位手机号，填写定位手机号，增加交易成功的几率，<br/>同时享受平台优先推送优质货源的特权。</td>
            </tr>
            <tr>
                <td class="cy_left_td xiao_td">常停放位置：</td>
                <td class="cy_center_td xiao_td"><input type="text"
                                                        name="oftenparkedposition" id="OFTENPARKEDPOSITION"
                                                        value="${car.oftenparkedposition }"
                                                        class="inputwidth inputborder" maxlength="150"></td>

            </tr>

            <tr>
                <td class="cy_left_td xiao_td">车主姓名：</td>
                <td class="cy_center_td xiao_td"><input name="ownername"
                                                        id="OWNERNAME" value="${car.ownername }"
                                                        class="inputwidth inputborder" type="text" maxlength="20"></td>
            </tr>
            <tr>
                <td class="cy_left_td xiao_td">车主手机号：</td>
                <td class="cy_center_td xiao_td"><input name="ownermobile" maxlength="11"
                                                        id="OWNERMOBILE" value="${car.ownermobile }"
                                                        class="inputwidth inputborder mobile" type="text"></td>

            </tr>
            <tr>
                <td class="cy_left_td xiao_td" ><span class="xinghao">*</span>行驶证照片：</td>
                <td id="a"><form:hidden id="travellicimg" path="travellicimg" htmlEscape="false" maxlength="256"/>
                    <sys:ckfinder input="travellicimg" type="images" uploadPath="/car" maxnumber="2" selectMultiple="true"
                                  maxWidth="100" maxHeight="100"/></td>
            </tr>
            <tr>
                <td class="cy_left_td xiao_td" ><span class="xinghao">*</span>车辆外观照片：</td>
                <td id="b"><form:hidden id="carsurfaceimg" path="carsurfaceimg" htmlEscape="false" maxlength="256"/>
                    <sys:ckfinder input="carsurfaceimg" type="images" uploadPath="/car" maxnumber="2" selectMultiple="true"
                                  maxWidth="100" maxHeight="100"/></td>
            </tr>
        </table>
        <div class="form-actions" style="padding: 30px;">
            
            <input id="btnSubmit" class="regbt" type="button" value="保 存"/>&nbsp;
            <input id="btnSubmit" class="regbt" type="button" value="返回" onclick="history.go(-1)"/>
        </div>
        <div class="load">
            <img src="/static/images/loading.gif">
            <p>加载中</p>
        </div>
    </form:form>
</div>

<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.gridSelector.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script type="text/javascript">


    $(".load").hide();

    if ($("#LOCATIONMOBILE").val() != "") {
        $("#WHITELISTID").attr("checked", "true");
        iswhitelistid();
    }
    function iswhitelistid() {
        if ($("#WHITELISTID").attr("checked")) {
            $("#xinhaos").html("*");
        } else {
            $("#xinhaos").html("");
        }
    }
    //获取车牌所属地区
    getArea();
    getCarType();
    function getArea() {
        $.ajax({
            url: "${wlpt}/wlpt/chinaarea/getArea",
            dataType: 'json',
            data: {parentCode: "0"},
            cache: false,
            success: function (data) {
                if (data) {
                    var adds = data;
                    $("#MININAME").gridSelector({
                        idKey: "code",
                        textKey: "mininame",
                        cellWidth: 50,
                        cellHeight: 28,
                        data: adds,
                        colNum: 7,
                        multiSelect: false,
                        complete: function (data) {
                            if (data) {
                                $("#MININAME").val(data.mininame);
                            }
                        }

                    });
                }
            }
        });

    }
    function getCarType() {
        $.ajax({
            url: "${wlpt}/getDictListJson?type=car_type",
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data) {
                    var adds = data;
                    $("#cartype").gridSelector({
                        idKey: "value",
                        textKey: "label",
                        cellWidth: 50,
                        cellHeight: 28,
                        data: adds,
                        colNum: 7,
                        multiSelect: false,
                        complete: function (data) {
                            if (data) {
                                $("#cartype").val(data.value);
                            }
                        }
                    });
                }
            }
        });
    }
    $("#fromAddress").PCC({
        hasCounty: false,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        //closeIcon: "static/images/pic12.gif",
        complete: function (data) {
            var str = "";
            if (data.province) {
                str += data.province.NAME;
                //searchConditions.fromProvince = data.province.NAME;
            }
            if (data.city) {
                if (data.city.NAME != data.province.NAME) {
                    str += data.city.NAME;
                }
                //searchConditions.fromCity = data.city.NAME;
            }
            $("#fromAddress").val(str);
        }
    });

    $("#toAddress").PCC({
        hasCounty: false,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        //closeIcon: "static/images/pic12.gif",
        complete: function (data) {
            var str = "";
            if (data.province) {
                str += data.province.NAME;

            }
            if (data.city) {
                if (data.city.NAME != data.province.NAME) {
                    str += data.city.NAME;
                }

            }
            $("#toAddress").val(str);
        }
    });
    $("#btnSubmit").click(function () {
        var isnul = true;
        isnul = isnul && $("input[name=mininame]").valid({
                    methods: "required"
                });
        isnul = isnul && $("input[name=number]").valid({
                    methods: "required|isCarNumber"
                });
        isnul = isnul && $("#cartype").valid({
                    methods: "required"
                });
        isnul = isnul && $("input[name=carlength]").valid({
                    methods: "required|isdecimal"
                });
        isnul = isnul && $("input[name=loadweight]").valid({
                    methods: "required|isdecimal"
                });
        isnul = isnul && $("input[name=fromaddress]").valid({
                    methods: "required"
                });
        isnul = isnul && $("input[name=toaddress]").valid({
                    methods: "required"
                });
        if ($("#locationmobile").val() != "" && $("#locationmobile").val() != null) {
            isnul = isnul && $("input[name=locationmobile]").valid({
                        methods: "isPhone"
                    });
        }
        if ($("#WHITELISTID").attr("checked")) {
            //负责人手机号码
            isnul = isnul && $("input[name=locationmobile]").valid({
                        methods: "required|isPhone"
                    });
        }
        if ($("#ownername").val() != "" && $("#ownername").val() != null) {
            isnul = isnul && $("input[name=ownername]").valid({
                        methods: "isName"
                    });
        }
        if ($("#ownermobile").val() != "" && $("#ownermobile").val() != null) {
            isnul = isnul && $("input[name=ownermobile]").valid({
                        methods: "isPhone"
                    });
        }
        if($("#travellicimg").val()==null||$("#travellicimg").val()==""){
        	$("#a").tips({
                side: 3,
                msg: '请上传驾驶证照片',
                bg: '#00A2E9',
                time: 4
            });
        	return false;
        }
        if($("#carsurfaceimg").val()==null||$("#carsurfaceimg").val()==""){
        	$("#b").tips({
                side: 3,
                msg: '请上传车辆外观照片',
                bg: '#00A2E9',
                time: 4
            });
        	return false;
        }

        if ($(".load").is(':hidden') && isnul) {
            $(".load").show();
        } else {
            return false;
        }

        var mininame = $("#MININAME").val();
        var number = $("#NUMBER").val();
        var newcarnumber = mininame + number;
        var carnumber = $("#carnumber").val();
        var carid = $("#carid").val();
        if (carid == '' || carid == null || newcarnumber != carnumber) {
            $.ajax({
                url: "${wlpt}/wlpt/car/validCarnumber",
                dataType: 'json',
                type: "post",
                async: false,
                data: {carnumber: newcarnumber},
                success: function (data) {
                    $(".load").hide();

                    if (data.value == "1") {
                        $("#NUMBER").tips({
                            side: 3,
                            msg: '车牌号码已存在',
                            bg: '#00A2E9',
                            time: 4
                        });
                        $("#NUMBER").focus();
                    } else {
                        $.ajax({
                            url: "${wlpt}/wlpt/car/saveCar?" + $("#Form").serialize(),
                            dataType: 'json',
                            type: "post",
                            success: function (data) {
                                if (data.value.state == 1) {
                                    window.location.href = '${wlpt}/wlpt/car/car_list';
                                } else {
                                    $.MsgBox.Alert("保存提示", data.value.message);
                                }
                            }
                        });
                    }
                }
            });
        } else {
            $.ajax({
                url: "${wlpt}/wlpt/car/saveCar?" + $("#Form").serialize(),
                dataType: 'json',
                type: "post",
                success: function (data) {
                    if (data.value.state == 1) {
                        window.location.href = '${wlpt}/wlpt/car/car_list';
                    } else {
                    	$(".load").hide();
                        $.MsgBox.Alert("保存提示", data.value.message);
                    }
                }
            });
        }
    });

</script>
</body>
</html>
