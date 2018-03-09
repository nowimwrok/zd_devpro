<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet"
          href="${ctxStatic }/modules/wlpt/front/css/analysis/global.css"/>
    <style type="text/css">
        #carTypediv, #monthdiv {
            float: left;
            height: 450px;
        }

        .contentdiv {
            width: 100%;
            height: 100%;
        }

        .bodydiv {
            width: 100%;
            height: 400px;
        }

        .bodyLeftdiv {
            width: 50%;
            float: left;
            height: 400px;
        }

        .bodyLeftdivtop {
            width: 100%;
            height: 100px;
        }

        .bodyLeftdivtopc {
            width: 100%;
            height: 30px;
            padding: 35px 0px;
        }

        .bodyLeftdivtop1 {
            float: left;
            width: 32%;
        }

        .bodyLeftdivtop2 {
            float: left;
            width: 6%;
        }

        .bodyLeftdivtop3 {
            float: left;
            width: 18%;
            font-size: 18px;
        }

        .bodyLeftdivtop4 {
            float: left;
            width: 6%;
        }

        .bodyLeftdivtop5 {
            float: left;
            width: 32%;
        }

        .bodyLeftdivtopborder {
            width: 60%;
            border-bottom: 1px dashed #EBEBEB;
            padding-top: 11px;
        }

        .bodyLeftdivbtm {
            height: 300px;
            width: 100%;
            font-family: "微软雅黑" !important;
            font-size: 14px;
        }

        .bodyLeftdivbtmc {
            height: 250px;
            width: 100%
        }

        .bodyLeftdivbtm1 {
            height: 75px;
            width: 100%;
        }

        .bodyLeftdivbtm2 {
            height: 50px;
            width: 100%
        }

        .bodyLeftdivbtm3 {
            height: 100px;
            width: 100%
        }

        .bodyLeftdivbtmdiv {
            height: 75px;
            width: 50%;
            float: left;
        }

        .bodyLeftdivbtmdivLeft {
            width: 20%;
            float: left;
        }

        .bodyLeftdivbtmdivRight {
            width: 80%;
            float: left;
        }

        .bodyLeftdivbtmdivRightTop {
            width: 40%;
            float: left;
        }

        .bodyLeftdivbtmdivRightBtm {
            width: 60%;
            float: left;
            height: 75px;
        }

        .bodyLeftdivbtmdivRightBtmDiv {
            width: 100%;
            height: 50%;
            line-height: 37.5px;
        }

        .bodyLeftdivbtmdivRightTopLeft {
            width: 100%;
            height: 80%;
        }

        .bodyLeftdivbtmdivRightTopRight {
            width: 100%;
            height: 25px;
        }

        .bodyLeftdivbtmdivRightTopImg {
            width: 50px;
            height: 56px;
        }

        .bodyLeftdivbtmdivRightTopFont {
            padding-left: 5px;
            font-size: 14px;
        }

        .bodyRightdiv {
            width: 50%;
            float: left;
            height: 400px;
        }

        .bodyRightdivTop {
            width: 100%;
            height: 10%;
            float: left;
        }

        .bodyRightdivCen {
            width: 100%;
            height: 80%;
            float: left;
        }

        .bodyRightdivBtm {
            width: 100%;
            height: 10%;
            float: left;
            color: rgb(51, 187, 255);
            font-size: 15px;
            cursor: pointer;
            text-align: center;
            font-family: "微软雅黑" !important;
        }
    </style>
</head>
<body>

<div class="contentdiv">
    <div class="bodydiv">
        <div class="bodyLeftdiv">
            <div class="bodyLeftdivtop">
                <div class="bodyLeftdivtopc">
                    <div class="bodyLeftdivtop1">
                        <div class="bodyLeftdivtopborder" style="margin-left: 40%;"></div>
                    </div>
                    <div class="bodyLeftdivtop2">
                        <img style="width: 25px;" class="" alt=""
                             src="${ctxStatic}/images/wlptfront/img_location_start_point.png"/>
                    </div>
                    <div class="bodyLeftdivtop3">业务概览</div>
                    <div class="bodyLeftdivtop4">
                        <img style="width: 25px;" class="" alt=""
                             src="${ctxStatic}/images/wlptfront/img_location_end_point.png"/>
                    </div>
                    <div class="bodyLeftdivtop5">
                        <div class="bodyLeftdivtopborder"></div>
                    </div>
                </div>
            </div>
            <div class="bodyLeftdivbtm">
                <div class="bodyLeftdivbtmc">
                    <div class="bodyLeftdivbtm1">
                        <div class="bodyLeftdivbtmdiv">
                            <div class="bodyLeftdivbtmdivLeft">&nbsp;</div>
                            <div class="bodyLeftdivbtmdivRight">
                                <div class="bodyLeftdivbtmdivRightTop">
                                    <div class="bodyLeftdivbtmdivRightTopLeft">
                                        <img class="bodyLeftdivbtmdivRightTopImg" alt=""
                                             src="${ctxStatic}/images/wlptfront/persionlogo/persionallogo5.png"/>
                                    </div>
                                    <div class="bodyLeftdivbtmdivRightTopRight">
                                        <span class="bodyLeftdivbtmdivRightTopFont">新运单</span>
                                    </div>
                                </div>
                                <div class="bodyLeftdivbtmdivRightBtm">
                                    <div class="bodyLeftdivbtmdivRightBtmDiv">
											<span id="tlCount"><fmt:parseNumber type="number"
                                                                                value="0"></fmt:parseNumber></span>单
                                    </div>

                                    <div class="bodyLeftdivbtmdivRightBtmDiv">
											<span id="tlWEIGHT" title=""><fmt:parseNumber
                                                    type="number" value="0"></fmt:parseNumber></span>吨
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="bodyLeftdivbtmdiv">
                            <div class="bodyLeftdivbtmdivLeft">&nbsp;</div>
                            <div class="bodyLeftdivbtmdivRight">
                                <div class="bodyLeftdivbtmdivRightTop">
                                    <div class="bodyLeftdivbtmdivRightTopLeft">
                                        <img class="bodyLeftdivbtmdivRightTopImg" alt=""
                                             src="${ctxStatic}/images/wlptfront/persionlogo/persionallogo9.png"/>
                                    </div>
                                    <div class="bodyLeftdivbtmdivRightTopRight">
                                        <span class="bodyLeftdivbtmdivRightTopFont">运输中</span>
                                    </div>
                                </div>
                                <div class="bodyLeftdivbtmdivRightBtm">
                                    <div class="bodyLeftdivbtmdivRightBtmDiv">
											<span id="trCount"><fmt:parseNumber type="number"
                                                                                value="0"></fmt:parseNumber></span>单
                                    </div>

                                    <div class="bodyLeftdivbtmdivRightBtmDiv">
											<span id="trWEIGHT" title=""><fmt:parseNumber
                                                    type="number" value="0"></fmt:parseNumber></span>吨
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="bodyLeftdivbtm2"></div>
                    <div class="bodyLeftdivbtm1">
                        <div class="bodyLeftdivbtmdiv">
                            <div class="bodyLeftdivbtmdivLeft">&nbsp;</div>
                            <div class="bodyLeftdivbtmdivRight">
                                <div class="bodyLeftdivbtmdivRightTop">
                                    <div class="bodyLeftdivbtmdivRightTopLeft">
                                        <img class="bodyLeftdivbtmdivRightTopImg" alt=""
                                             src="${ctxStatic}/images/wlptfront/persionlogo/persionallogo1.png"/>
                                    </div>
                                    <div class="bodyLeftdivbtmdivRightTopRight">
                                        <span class="bodyLeftdivbtmdivRightTopFont">待支付</span>
                                    </div>
                                </div>
                                <div class="bodyLeftdivbtmdivRightBtm">
                                    <div class="bodyLeftdivbtmdivRightBtmDiv">
											<span id="blCount"><fmt:parseNumber type="number"
                                                                                value="0"></fmt:parseNumber></span>单
                                    </div>

                                    <div class="bodyLeftdivbtmdivRightBtmDiv">
											<span id="blWEIGHT" title=""><fmt:parseNumber
                                                    type="number" value="0"></fmt:parseNumber></span>吨
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="bodyLeftdivbtmdiv">
                            <div class="bodyLeftdivbtmdivLeft">&nbsp;</div>
                            <div class="bodyLeftdivbtmdivRight">
                                <div class="bodyLeftdivbtmdivRightTop">
                                    <div class="bodyLeftdivbtmdivRightTopLeft">
                                        <img class="bodyLeftdivbtmdivRightTopImg" alt=""
                                             src="${ctxStatic}/images/wlptfront/persionlogo/persionallogo3.png"/>
                                    </div>
                                    <div class="bodyLeftdivbtmdivRightTopRight">
                                        <span class="bodyLeftdivbtmdivRightTopFont">已支付</span>
                                    </div>
                                </div>
                                <div class="bodyLeftdivbtmdivRightBtm">
                                    <div class="bodyLeftdivbtmdivRightBtmDiv">
											<span id="brCount"><fmt:parseNumber type="number"
                                                                                value="0"></fmt:parseNumber></span>单
                                    </div>

                                    <div class="bodyLeftdivbtmdivRightBtmDiv">
											<span id="brWEIGHT" title=""><fmt:parseNumber
                                                    type="number" value="0"></fmt:parseNumber></span>吨
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="bodyLeftdivbtm3"></div>
                </div>
            </div>

        </div>
        <div class="bodyRightdiv">
            <div class="bodyRightdivTop"></div>
            <%--  <div style="width:100%;height:20%;float:left;">
            <img style="" class="" alt=""
                 src="${pageContext.request.contextPath}/static/images/wlpt/images/persionlogo/persiontop.png"/>
        </div>
        <div style="width:100%;height:10%;float:left;text-align:center;">
                        <span>您的业务在平台排在<span style="color:orange;">22.25%</span>的人之前,加油哦!
                        </span>
        </div> --%>
            <div class="bodyRightdivCen">
                <%--<img style="" class="" alt=""
                 src="${pageContext.request.contextPath}/static/images/wlpt/images/persionlogo/persioncenter.png"/>--%>
                <div id="orderAnalysis" style="width: 100%; height: 320px;"></div>
            </div>
            <div class="bodyRightdivBtm">
					<span title="点击查看详细的业务报表"><a
                            onclick="showorder()">查看详细业务报表</a></span>
            </div>
        </div>
    </div>
</div>
<script src="${ctxStatic}/jquery/jquery-1.8.3.min.js"
        type="text/javascript"></script>
<script type="text/javascript" src="/static/echarts/echarts.min.js"></script>
<script type="text/javascript"
        src="${ctxStatic}/echarts/echarts-all.js"></script>
<script type="text/javascript">
    $(function () {

        $.ajax({
            type: "POST",
            url: '${wlpt}/wlpt/personal/getOrderinfoSum',
            dataType: 'json',
            data: {},
            cache: false,
            success: function (data) {
                if (data.state == 1) {
                    $("#tlCount").html(data.newOrder.sumorder);
                    $("#tlWEIGHT").html(data.newOrder.sumoddloadweight);
                    $("#trCount").html(data.intransitOrder.sumorder);
                    $("#trWEIGHT").html(
                            data.intransitOrder.sumoddloadweight);
                    $("#blCount").html(data.nopaymentOrder.sumorder);
                    $("#blWEIGHT").html(
                            data.nopaymentOrder.sumoddloadweight);
                    $("#brCount").html(data.endOrder.sumorder);
                    $("#brWEIGHT").html(data.endOrder.sumoddloadweight);
                    fomatNum();
                } else {

                }
            }
        });

        var orderdom = document.getElementById("orderAnalysis");
        var myChart = echarts.init(orderdom);
        var date = [];
        var neworder = [];///新运单
        var trading = [];///运输中
        var waitingpay = [];///待支付
        var payorder = [];//已支付
        var timeTicket = new Object();
        var timeflag = "%Y-%m-%d";
        var showtime = "%Y-%m-%d";
        var title = ['新运单', '运输中', '待支付', '已支付'];
        getOrderCount(timeflag);
        function getOrderCount(timeflag) {
            date = [];
            neworder = [];///新运单
            trading = [];///运输中
            waitingpay = [];///待支付
            payorder = [];//已支付
            $.ajax({
                type: "POST",
                url: '${wlpt}/wlpt/trade/getEverData',
                dataType: 'json',
                data: {
                    "timeflag": timeflag,
                    "showtime": showtime
                },
                cache: false,
                success: function (data) {
                    for (var i = 0; i < data.data.length; i++) {
                        var nowdata = data.data[i].orderInfoVo;//当钱数据对象
                        if (timeflag == 'everyWeek') {
                            date.push(nowdata.showtime + '第'
                                    + nowdata.timeflag + '周');
                        } else {
                            date.push(nowdata.showtime);
                        }
                        neworder.push({
                            name: "运单" + nowdata.newodload,
                            value: xround(
                                    nowdata.newodload * 1, 2)
                        });///运输中
                        trading.push({
                            name: "运单" + nowdata.tradingodload,
                            value: xround(nowdata.tradingodload * 1, 2)
                        });

                        waitingpay.push({
                            name: "运单" + nowdata.waitpayodload,
                            value: xround(
                                    nowdata.waitpayodload * 1, 2)
                        }); //待支付
                        payorder.push({
                            name: "运单" + nowdata.endodload,
                            value: xround(
                                    nowdata.endodload * 1, 2)
                        });//已支付
                    }

                    optionFun(neworder, trading, waitingpay, payorder);
                }
            });
        }

        function xround(x, num) {
            return Math.round(x * Math.pow(10, num)) / Math.pow(10, num);
        }

        function optionFun(neworder, trading, waitingpay, payorder) {
            option = {
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'shadow'
                    }
                },
                legend: {
                    data: title,
                    selectedMode: 'single',
                    selected: {
                        '运输中': false,
                        '待支付': false,
                        '已支付': false
                    }

                },
                toolbox: {
                    show: false,
                    y: 'center',
                    feature: {
                        mark: {
                            show: true
                        },
                        magicType: {
                            show: true,
                            type: ['line', 'bar', 'stack', 'tiled']
                        },
                        restore: {
                            show: true
                        },
                        saveAsImage: {
                            show: true
                        }
                    }
                },
                calculable: true,
                xAxis: [{
                    type: 'category',
                    boundaryGap: false,
                    data: date
                }],
                yAxis: [{
                    name: "单位:吨",
                    type: 'value',
                    splitNumber: 4,
                    scale: false
                }],
                dataZoom: {
                    show: false,
                    realtime: true,
                    start: 0,
                    end: 100
                },
                grid: {
                    x2: 40
                },
                series: [{
                    name: title[0],
                    type: 'line',
                    data: neworder
                }, {
                    name: title[1],
                    type: 'line',
                    data: trading
                }, {
                    name: title[2],
                    type: 'line',
                    data: waitingpay
                }, {
                    name: title[3],
                    type: 'line',
                    data: payorder
                }]
            };
            myChart.clear();
            var lastIndex = 0;
            var len = option.series[0].data.length;
            clearInterval(timeTicket);
            timeTicket = setInterval(function () {
                // 动态数据接口 addData
                lastIndex += 1;
                myChart.addData([[0, // 系列索引
                    option.series[0].data[lastIndex % len], // 新增数据
                    false, // 新增数据是否从队列头部插入
                    false, // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
                    option.xAxis[0].data[lastIndex % len]],
                    [1, // 系列索引
                        option.series[1].data[lastIndex % len], // 新增数据
                        false, // 新增数据是否从队列头部插入
                        false, // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
                        option.xAxis[0].data[lastIndex % len]],
                    [2, // 系列索引
                        option.series[2].data[lastIndex % len], // 新增数据
                        false, // 新增数据是否从队列头部插入
                        false, // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
                        option.xAxis[0].data[lastIndex % len]],
                    [3, // 系列索引
                        option.series[3].data[lastIndex % len], // 新增数据
                        false, // 新增数据是否从队列头部插入
                        false, // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
                        option.xAxis[0].data[lastIndex % len]]]);
            }, 2000);

            myChart.setOption(option);
            setTimeout(function () {
                window.onresize = function () {
                    myChart.resize();
                };
            }, 200);
        }

        window.showorder = function () {
            $("#order_info", window.parent.document).show();
            if ($("#orderval", window.parent.document).val() == "0") {
                $("#mainFrame", window.parent.parent.document).height(
                        $("#mainFrame", window.parent.parent.document)
                                .height() + 580);
                $("#orderval", window.parent.document).val(1);
            }
        };
        function fomatFloat(src, pos) {
            return Math.round(src * Math.pow(10, pos)) / Math.pow(10, pos);

        }

        function fomatPrice(price) {
            if (price * 1 >= 100000) {
                var p = price / 10000;
                p = p.toString();
                var index = p.indexOf(".", 0);
                index = index >= 0 ? index : p.length;
                index += 2;
                index = index < p.length ? index : p.length;
                price = "" + p.substring(0, index) + "万";
            } else {
                price = fomatFloat(price, 4);
            }
            return price;
        }
	function fomatNum(){
		 var tlTOTALCOST = $("#tlTOTALCOST").html();
	        var trTOTALCOST = $("#trTOTALCOST").html();
	        var blTOTALCOST = $("#blTOTALCOST").html();
	        var brTOTALCOST = $("#brTOTALCOST").html();
	        var tlWEIGHT = $("#tlWEIGHT").html();
	        var trWEIGHT = $("#trWEIGHT").html();
	        var blWEIGHT = $("#blWEIGHT").html();
	        var brWEIGHT = $("#brWEIGHT").html();
	        $("#tlTOTALCOST").html(
	                fomatPrice(tlTOTALCOST > 0 ? tlTOTALCOST : 0));
	        $("#trTOTALCOST").html(
	                fomatPrice(trTOTALCOST > 0 ? trTOTALCOST : 0));
	        $("#blTOTALCOST").html(
	                fomatPrice(blTOTALCOST > 0 ? blTOTALCOST : 0));
	        $("#brTOTALCOST").html(
	                fomatPrice(brTOTALCOST > 0 ? brTOTALCOST : 0));
	        $("#tlWEIGHT").html(fomatPrice(tlWEIGHT > 0 ? tlWEIGHT : 0));
	        $("#trWEIGHT").html(fomatPrice(trWEIGHT > 0 ? trWEIGHT : 0));
	        $("#blWEIGHT").html(fomatPrice(blWEIGHT > 0 ? blWEIGHT : 0));
	        $("#brWEIGHT").html(fomatPrice(brWEIGHT > 0 ? brWEIGHT : 0));
	}
       
    });
</script>
</body>
</html>

