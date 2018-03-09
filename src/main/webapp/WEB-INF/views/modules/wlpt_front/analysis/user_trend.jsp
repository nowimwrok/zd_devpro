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
    <div id="userAnalysis" class="echart-content"></div>
</div>
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/static/echarts/echarts.min.js"></script>
<script type="text/javascript" src="/static/echarts/echarts-all.js"></script>

<script type="text/javascript">
    $(function () {
        var dom = document.getElementById("userAnalysis");
        var myChart = echarts.init(dom);
        var date = [];
        var everyDayCount = [];///每日总注册
        var carownerCount = [];///每日车主注册
        var goodsownerCount = [];///每日货主注册
        var enterpownerCount = [];///每日企业注册
        var userDataName = "everyDay";
        var userTitle = ['总计', '车主', '企业', '货主'];
        var allDateCount = [];
        var timeTicket = new Object();
        getUserCount(userDataName);
        function getUserCount(userDataName) {
            date = [];
            everyDayCount = [];
            carownerCount = [];
            goodsownerCount = [];
            enterpownerCount = []
            $.ajax({
                type: "POST",
                url: '${wlpt}/wlpt/dataCenter/getUseCount',
                dataType: 'json',
                data: {dataName: userDataName},
                cache: false,
                success: function (data) {

                    for (var i = 0; i < data.data.roleList.length; i++) {
                        var nowdata = data.data.roleList[i];//当钱数据对象
                        if (userDataName == 'everyWeek') {
                            date.push(nowdata.cretime + '第' + nowdata.timeflg + '周');
                        } else {
                            date.push(nowdata.cretime);
                        }
                        carownerCount.push(nowdata.carownercount);
                        goodsownerCount.push(nowdata.goodsownerscount);
                        enterpownerCount.push(nowdata.entprisecount);
                        everyDayCount.push(nowdata.carownercount * 1 + nowdata.goodsownerscount * 1 + nowdata.entprisecount * 1);


                    }

                    function optionFun(everyDayCount, carownerCount, enterpownerCount, goodsownerCount) {
                        myChart.clear();
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
                                data: userTitle
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
                                    name : '角色(个)',
                                    type: 'value',
                                    splitNumber: 5,
                                    scale: false
                                },
                                {
                                    name : '总计(个)',
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
                                    name: userTitle[0],
                                    type: 'bar',
                                    smooth: false,
                                    symbol: 'circle',
                                    yAxisIndex:1,
                                    sampling: 'average',
                                    itemStyle: {
                                        normal: {
                                            color: 'rgb(255, 70, 10)',
                                            label: {show: true}
                                        }
                                    },
                                    data: everyDayCount
                                }, {
                                    name: userTitle[1],
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
                                    data: carownerCount
                                }, {
                                    name: userTitle[2],
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
                                    data: enterpownerCount
                                }, {
                                    name: userTitle[3],
                                    type: 'line',
                                    smooth: false,
                                    symbol: 'circle',
                                    sampling: 'average',
                                    itemStyle: {
                                        normal: {
                                            color: 'yellow',
                                            label: {show: true}
                                        }
                                    },
                                    data: goodsownerCount
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
                                ],[
                                    3,        // 系列索引
                                    option.series[3].data[lastIndex % len], // 新增数据
                                    false,     // 新增数据是否从队列头部插入
                                    false,     // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
                                    option.xAxis[0].data[lastIndex % len]
                                ]
                            ]);
                        }, 2000);
                        myChart.setOption(option);
                    }

                    optionFun(everyDayCount, carownerCount, enterpownerCount, goodsownerCount);
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
                    userDataName = "everyDay";
                    break;
                case "week-index":
                    resetIndex(180);
                    userDataName = "everyWeek";
                    break;
                case "month-index":
                    resetIndex(540);
                    userDataName = "everyMoth";
                    break;
                case "year-index":
                    resetIndex(365 * 6);
                    userDataName = "everyYear";
                    break;
            }
            getUserCount(userDataName);
        })

    });

</script>
</body>
</html>

