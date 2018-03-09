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
        <ul id="period">
            <li id="day-index" class="noac actives">日指数</li>
            <li id="week-index" class="noac">周指数</li>
            <li id="month-index" class="noac">月指数</li>
            <li id="year-index" class="noac">年度指数</li>
        </ul>
    </div>
    <div id="bidAnalysis" class="echart-content"></div>
</div>
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/static/echarts/echarts.min.js"></script>
<script type="text/javascript" src="/static/echarts/echarts-all.js"></script>

<script type="text/javascript">
    $(function () {
        var dom = document.getElementById("bidAnalysis");
        var myChart = echarts.init(dom);
        var date = [];
        var LOADWEIGHT = [];///吨位
        var BIDPRICE = [];///价格
        var BIDCOUNT = [];///发布量
        var DataName = "everyDay";
        var title = ['招标量', '招标吨位', '招标整价'];
        getEveryCount(DataName);
        var timeTicket = new Object();
        function getEveryCount(DataName) {

            date = [];
            LOADWEIGHT = [];///吨位
            BIDPRICE = [];///价格
            BIDCOUNT = [];///发布量
            $.ajax({
                type: "POST",
                url: '${wlpt}/wlpt/dataCenter/getBidCount',
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
                        LOADWEIGHT.push(nowdata.bidweight);
                        BIDPRICE.push(nowdata.bidprice);
                        BIDCOUNT.push(nowdata.bidcount);
                    }

                    function optionFun(LOADWEIGHT, BIDPRICE, BIDCOUNT) {

                        var option = {
                            tooltip: {
                                trigger: 'axis',
                            },
                            // title: {
                            //     left: 'center',
                            //     text: '大数据量折线图',
                            // },
                            legend: {
                                x:25,
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
                                    name : '招标:元/吨',
                                    type: 'value',
                                    splitNumber: 5,
                                    scale: false
                                },
                                {
                                    name : '单位:标',
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
                                    sampling: 'average',
                                    yAxisIndex:1,
                                    itemStyle: {
                                        normal: {
                                            color: 'rgb(255, 70, 10)',
                                            label: {show: true}
                                        }
                                    },
                                    data: BIDCOUNT
                                }, {
                                    name: title[1],
                                    type: 'line',
                                    smooth: false,
                                    symbol: 'circle',
                                    sampling: 'average',
                                    itemStyle: {
                                        normal: {
                                            color: 'green',
                                            label: {show: true}
                                        }
                                    },
                                    data: LOADWEIGHT
                                }, {
                                    name: title[2],
                                    type: 'line',
                                    smooth: false,
                                    symbol: 'circle',
                                    sampling: 'average',
                                    itemStyle: {
                                        normal: {
                                            color: 'blue',
                                            label: {show: true}
                                        }
                                    },
                                    data: BIDPRICE
                                }
                            ]
                        };
                        var lastIndex = 0;
                        var len = option.series[0].data.length;
                        clearInterval(timeTicket);
                        timeTicket = setInterval(function () {
                            // 动态数据接口 addData
                            lastIndex += 1;
                            myChart.addData([
                                [
                                    0,        // 系列索引
                                    option.series[0].data[lastIndex % len], // 新增数据
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
                        myChart.setOption(option);
                    }

                    optionFun(LOADWEIGHT, BIDPRICE, BIDCOUNT);
                }
            });
        }

        //重置chart缩放级别
        function resetIndex(period) {
            myChart.setOption({
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

        //指数周期切换
        $("#period").on("click", "li", function () {
            $("#period").find("li").removeClass("actives");
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
            getEveryCount(DataName);
        })

    });

</script>
</body>
</html>

