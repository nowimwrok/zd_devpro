<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <title>添加车源</title>
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
    <link href="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css">
    
    <script src="${ctxStatic }/common/jeesite.js" type="text/javascript"></script>
    <script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${ctxStatic }/jquery-select2/3.4/select2.min.js" type="text/javascript"></script>
    <script src="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
    <script src="${ctxStatic }/common/mustache.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctxStatic }/common/global.js"></script>
    <script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
    <script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>

</head>
<body style="height: 1000px;">
<div class="tab_fir tab-all" style="height: 940px;">
    <form:form action="${wlpt}/wlpt/carsource/saveCarSource" name="Form" id="Form" modelAttribute="carsource" method="post">
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"/><span class="title_blue">添加</span>
            <span class="title_orange">车源</span><img src="${ctxStatic }/images/wlptfront/line-right.png"/>
        </p>
        <table width="100%" border="0" style="margin-top:10px;">
            <tr>
                <td class="cy_left_td xiao_td">车牌号码：</td>
                <td class="cy_center_td xiao_td">
                	<input type="hidden" id="id" name="id" value="${carsource.id }"/>
                    <input type="hidden" id="status" name="status" value="${carsource.status}"/>
                    <input type="hidden" id="carid" name="car.id" value="${carsource.car.id }"/>
                    <input type="hidden" name="user.id" value="${carsource.user.id }"/>
                    
                    <input type="text" id="carnumber" name="carnumber"
                           value="${carsource.car.carnumber }" class="inputtext" readonly="readonly" maxlength="6"/>
                </td>
            </tr>
            <tr>
                <td class="cy_left_td xiao_td">车辆类型：</td>
                <td class="cy_center_td xiao_td">
                    <input id="cartype" value="${carsource.car.cartype}" readonly="readonly" type="text"
                           style="width: 74px;;text-align:center;" />
                </td>

            </tr>
            <tr>
                <td class="cy_left_td xiao_td">车&nbsp;&nbsp;长：</td>
                <td class="cy_center_td xiao_td">
                    <input type="text" value="${carsource.car.carlength}" id="carlength" readonly="readonly" class="input-xlarge"/>
                    <span>米</span></td>

            </tr>
            <tr>
                <td class="cy_left_td xiao_td">载&nbsp;&nbsp;重：</td>
                <td class="cy_center_td xiao_td">
                    <input type="text"  id="loadweight" value="${carsource.car.loadweight}" class="input-xlarge" readonly="readonly"/>
                    <span>吨</span>
                </td>
            </tr>
            <tr>
                <td class="cy_left_td xiao_td"><span class="xinghao">*</span>本次路线：</td>
                <td class="cy_center_td xiao_td">
                    <input type="text" name="fromaddress" id="fromAddress" value="${carsource.fromaddress }" readonly="readonly" class="inputwidth inputborder required" placeholder="请选择出发地" maxlength="100"/>
                    <img style="vertical-align: middle;height:30px;" src="${ctxStatic }/images/wlptfront/switch_btn.png"/>
                    <input type="text" name="toaddress" id="toAddress" value="${carsource.toaddress }" readonly="readonly" class="inputwidth inputborder required" placeholder="请选择目的地" maxlength="100"/>
                    <input type="hidden" name="mainroad" id="MAINROAD" value=""/></td>
            </tr>
            <tr>
                <td class="cy_left_td xiao_td"><span class="xinghao">*</span>发车时间：</td>
                <td class="cy_center_td xiao_td">
                    <input name="departure" id="departuretime" type="text" readonly="readonly" maxlength="20"
                           style="height: 28px;" class="Wdate "
                           value="<fmt:formatDate value="${carsource.departuretime}" pattern="yyyy-MM-dd"/>"
                           onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                </td>
            </tr>
            <tr>
                <td class="cy_left_td xiao_td">联系人：</td>
                <td class="cy_center_td xiao_td"><input name="contactname"
                                                        id="contactname" value="${car.contactname }"
                                                        class="inputwidth inputborder" type="text" maxlength="20"></td>
            </tr>
            <tr>
                <td class="cy_left_td xiao_td">联系手机号：</td>
                <td class="cy_center_td xiao_td"><input name="contactmobile" maxlength="11"
                                                        id="contactmobile" value="${car.contactmobile }"
                                                        class="inputwidth inputborder mobile" type="text"></td>

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
   
    $("#fromAddress").PCC({
        hasCounty: false,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
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
        
        isnul = isnul && $("input[name=fromaddress]").valid({
                    methods: "required"
                });
        isnul = isnul && $("input[name=toaddress]").valid({
                    methods: "required"
                });
       
        isnul = isnul && $("input[name=departure]").valid({
            methods: "required"
        });
		if (isnul) {
		    if (diffDate($("input[name=departure]")) <= 0) {
		        isnul = false;
		    }
		}
        if ($("#contactname").val() != "" && $("#contactname").val() != null) {
            isnul = isnul && $("input[name=contactname]").valid({
                        methods: "isName"
                    });
        }
        if ($("#contactmobile").val() != "" && $("#contactmobile").val() != null) {
            isnul = isnul && $("input[name=contactmobile]").valid({
                        methods: "isPhone"
                    });
        }
       

        if ($(".load").is(':hidden') && isnul) {
            $(".load").show();
        } else {
            return false;
        }
        $.ajax({
            url: "${wlpt}/wlpt/carsource/saveCarSource?" + $("#Form").serialize(),
            dataType: 'json',
            type: "post",
            success: function (data) {
                if (data.value.state == 1) {
                    window.location.href = '${wlpt}/wlpt/carsource/carSource_list';
                } else {
                	$(".load").hide();
                    $.MsgBox.Alert("保存提示", data.value.message);
                }
            }
        });
    });

</script>
</body>
</html>
