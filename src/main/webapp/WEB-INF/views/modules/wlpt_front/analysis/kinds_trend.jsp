<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="/static/modules/wlpt/front/css/analysis/global.css"/>
</head>
<body>

<div style="width: 100%;height: 100%;">
    <div class="switch_t">
        <ul id="orderPeriod" style="width: 50%;">
            <li id="day-index" class="noac actives">日指数</li>
            <li id="week-index" class="noac">周指数</li>
            <li id="month-index" class="noac">月指数</li>
            <li id="year-index" class="noac">年度指数</li>
        </ul>
        <label><input type="radio" checked="checked" value="1" name="goodsType"/><span class="lbl">成品</span></label>
        <label><input type="radio" value="2" name="goodsType"/><span class="lbl">原材料</span></label>
    </div>

    <div id="orderAnalysis" class="echart-content" style="padding-left: 20px; "></div>
</div>
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/static/echarts/echarts-all.js"></script>
<script type="text/javascript">
    $(function () {
        var orderdom = document.getElementById("orderAnalysis");
        var myChart_order = echarts.init(orderdom);
        var date = [];
        var CTRANSPORTWEIGHT = []; //运输吨位
        var CTRANSPORTMONEY = [];//运输金额
        var CTRASPORTCOUNT = [];//运输量
        var dataVar = [];
        var timeTicket = new Object();
        var DataName = "everyDay";
        var title = ['货单', '运输量', '运输资金'];
        $("[name=goodsType]").click(function () {

            getOrderCount(DataName);
        });
        getOrderCount(DataName);
        function getOrderCount(DataName) {
            date = [];
            CTRANSPORTWEIGHT = []; //运输吨位
            CTRANSPORTMONEY = [];//运输金额
            CTRASPORTCOUNT = [];//运输量
            var gsType=$("[name=goodsType]:checked").val();
            $.ajax({
                type: "POST",
                url: '${wlpt}/wlpt/dataCenter/getTradeKindData',
                dataType: 'json',
                data: {dataName: DataName},
                cache: false,
                success: function (data) {
                    for (var i = 0; i < data.data.varList.length; i++) {
                        var nowdata = data.data.varList[i];//当钱数据对象

                        if (DataName == 'everyWeek') {
                            date.push(nowdata.cretime + '第' + nowdata.timeflg + '周');
                        } else {
                            date.push(nowdata.cretime);
                        }
                        if(gsType=='1'){
                        	CTRANSPORTWEIGHT.push(nowdata.ctransportweight)///吨位
                            CTRANSPORTMONEY.push(nowdata.ctransportmoney);///总运费
                            CTRASPORTCOUNT.push(nowdata.ctrasportcount);//运单量
                            dataVar[i] = [{name: nowdata.ctrasportcount + "单"}, {
                                name: nowdata.ctransportweight + "吨",
                                value: nowdata.ctransportmoney + "元"
                            }];
                        }
                        else{
                        	CTRANSPORTWEIGHT.push(nowdata.ytransportweight)///吨位
                            CTRANSPORTMONEY.push(nowdata.ytransportmoney);///总运费
                            CTRASPORTCOUNT.push(nowdata.ytrasportcount);//运单量
                            dataVar[i] = [{name: nowdata.ytrasportcount + "单"}, {
                                name: nowdata.ytransportweight + "吨",
                                value: nowdata.ytransportmoney + "元"
                            }];
                        }
                    }
                    function optionFun(CTRANSPORTWEIGHT, CTRANSPORTMONEY, CTRASPORTCOUNT) {
                        myChart_order.clear();
                        var option = {
                            tooltip: {
                                trigger: 'axis',
                            },
                            // title: {
                            //     left: 'center',
                            //     text: '大数据量折线图',
                            // },
                            legend: {
                                x: 'left',
                                data: title
                            },
                            toolbox: {
                                show: true,
                                feature: {
                                    dataView: {show: true, readOnly: false},
                                    magicType: {show: true, type: ['line', 'bar', 'stack', 'tiled']},
                                    restore: {show: true},
                                    saveAsImage: {show: true}
                                }
                            },
                            xAxis: [
                                {
                                    type: 'category',
                                    boundaryGap: true,
                                    data: date
                                },
                                {
                                    type: 'value',
                                    max: 100,
                                    scale: true
                                }
                            ],
                            yAxis: [
                                {
                                    name:"运费/吨",
                                    type: 'value',
                                    splitNumber: 5,
                                    scale: false
                                },
                                {
                                    name:"货单(单)",
                                    type: 'value',
                                    splitNumber: 5,
                                    scale: false
                                }
                            ],

                            dataZoom: {
                                type: 'inside',
                                show: true,
                                realtime: true,
                                start: 0,
                                end: 100
                            },
                            series: [
                                {
                                    name: title[0],
                                    type: 'bar',
                                    smooth: false,
                                    symbol: 'circle',
                                    yAxisIndex:1,
                                    sampling: 'average',
                                    itemStyle: {
                                        normal: {
                                            color: 'rgb(255, 70, 10)'
                                        }
                                    },
                                    data: CTRASPORTCOUNT
                                }, {
                                    name: title[1],
                                    type: 'line',
                                    smooth: false,
                                    symbol: 'circle',
                                    sampling: 'average',
                                    itemStyle: {
                                        normal: {
                                            color: 'green',
                                        }
                                    },
                                    data: CTRANSPORTWEIGHT
                                }, {
                                    name: title[2],
                                    type: 'line',
                                    smooth: false,
                                    symbol: 'circle',
                                    sampling: 'average',
                                    itemStyle: {
                                        normal: {
                                            color: 'blue'
                                        }
                                    },
                                    data: CTRANSPORTMONEY
                                }
                            ]
                        };

                        var lastIndex = 0;
                        var len = option.series[0].data.length;
                        clearInterval(timeTicket);
                        timeTicket = setInterval(function () {
                            // 动态数据接口 addData
                            lastIndex += 1;
                            myChart_order.addData([
                                [
                                    0,        // 系列索引
                                    option.series[0].data[lastIndex % len], // 新增数据 对应着series的值
                                    false,     // 新增数据是否从队列头部插入
                                    false,     // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
                                    option.xAxis[0].data[lastIndex % len]
                                ],
                                [
                                    1,        // 系列索引
                                    option.series[1].data[lastIndex % len], // 新增数据
                                    false,     // 新增数据是否从队列头部插入
                                    false,     // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
                                    option.xAxis[0].data[lastIndex % len]
                                ],
                                [
                                    2,        // 系列索引
                                    option.series[2].data[lastIndex % len], // 新增数据
                                    false,     // 新增数据是否从队列头部插入
                                    false,     // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
                                    option.xAxis[0].data[lastIndex % len]
                                ]
                            ]);
                        }, 2000);
                        myChart_order.setOption(option);
                    }

                    optionFun(CTRANSPORTWEIGHT, CTRANSPORTMONEY, CTRASPORTCOUNT);
                }
            });
        }

        //重置chart缩放级别
        function resetIndex(period) {
            myChart_order.setOption({
                dataZoom: [{
                    type: 'inside',
                    startValue: date.length - period,
                    endValue: date.length
                }, {
                    startValue: date.length - period,
                    endValue: date.length
                }]
            });
        }

        function xround(x, num) {
            return Math.round(x * Math.pow(10, num)) / Math.pow(10, num);
        }

        //指数周期切换
        $("#orderPeriod").on("click", "li", function () {
            $("#orderPeriod").find("li").removeClass("actives");
            $(this).addClass("actives");

            switch ($(this).attr("id")) {
                case "day-index":
                    resetIndex(30);
                    DataName = "everyDay";
                    break;
                case "week-index":
                    resetIndex(180);
                    DataName = "everyWeek";
                    break;
                case "month-index":
                    resetIndex(540);
                    DataName = "everyMoth";
                    break;
                case "year-index":
                    resetIndex(365 * 6);
                    DataName = "everyYear";
                    break;
            }
            getOrderCount(DataName);
        })

    });

</script>
</body>
</html>

