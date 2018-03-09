<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="/static/modules/wlpt/front/css/analysis/global.css"/>
    <style type="text/css">
        #roleidiv, #authenidiv {
            float: left;
            height: 450px;
        }
    </style>
</head>
<body>

<div style="width: 100%;height: 100%;">
    <div id="roleidiv" class="echart-content" style="width: 40%"></div>
    <div id="authenidiv" class="echart-content" style="width: 60%;float: left;height: 450px;">

    </div>
</div>

<%--<script type="text/javascript" src="/static/echart/echarts.min.js"></script>--%>
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/static/echarts/echarts.min.js"></script>
<script type="text/javascript" src="/static/echarts/echarts-all.js"></script>
<script type="text/javascript">
    $(function () {
        /* var dom = document.getElementById("roleidiv");
         var myChart = echarts.init(dom);*/
        var title = ["货主","物流企业","车主"];
        var ENTPRISECOUNT = 0;//物流企业总数
        var GOODSOWNERSCOUNT = 0;//货主总数
        var CAROWNERCOUNT = 0;//车主总数
        var TOTALCOUNT = 0;//
        var pieData = [];

        var date = [];
        var everyDayCount = [];///每日总注册
        var carownerCount = [];///每日车主注册
        var goodsownerCount = [];///每日货主注册
        var enterpownerCount = [];///每日企业注册
        var userDataName = "everyDay";
        var timeTicket = new Object();
        geroleCount();
        ///获取角色数据
        function geroleCount() {
            $.ajax({
                type: "POST",
                url: '${wlpt}/wlpt/dataCenter/getRoleCount',
                dataType: 'json',
                cache: false,
                success: function (data) {
                    for (var i = 0; i < data.data.varList.length; i++) {
                        var nowdata = data.data.varList[i];
                        if ("goodsowner" == nowdata.enname) {
                            GOODSOWNERSCOUNT = nowdata.count;
                        } else if ("enterprise" == nowdata.enname) {
                            ENTPRISECOUNT = nowdata.count;
                        } else if ("carowner" == nowdata.enname) {
                            CAROWNERCOUNT = nowdata.count;
                        }
                    }
                    ///具体数据
                    pieData.push({value: GOODSOWNERSCOUNT, name: "货主"});
                    pieData.push({value: CAROWNERCOUNT, name: "车主"});
                    pieData.push({value: ENTPRISECOUNT, name: "物流企业"});
                    TOTALCOUNT = GOODSOWNERSCOUNT*1 + ENTPRISECOUNT*1 + CAROWNERCOUNT*1;
                    //setoption();
                    getUserCount(userDataName);
                }
            });
        }

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
                    setOption();
                }
            });
        }

        function setOption() {
            option = {
                title: {
                    text: '平台总计会员' + TOTALCOUNT + "人",
                    subtext: '角色构成',
                    x: 'center'
                },
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                legend: {
                    orient: 'vertical',
                    x: 'left',
                    data: title
                },
                calculable: false
                ,
                series: [
                    {
                        name: '角色构成',
                        type: 'pie',
                        radius: '55%',
                        center: ['50%', 225],
                        data: pieData
                    }
                ]
            };

            option2 = {
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {
                        type: 'shadow'
                    }
                },
                legend: {
                    data: title
                },
                toolbox: {
                    show: true,
                    orient: 'vertical',
                    y: 'center',
                    feature: {
                        mark: {show: true},
                        magicType: {show: true, type: ['line', 'bar', 'stack', 'tiled']},
                        restore: {show: true},
                        saveAsImage: {show: true}
                    }
                },
                calculable: true,
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
                        type: 'value',
                        splitNumber: 5,
                        scale: false
                    }
                ],
                dataZoom: [{
                    type: 'inside',
                    startValue: 0,
                    endValue: 100
                }, {
                    startValue: 0,
                    endValue: 100
                }],
                dataZoom: {
                    show: true,
                    realtime: true,
                    start: 0,
                    end: 100
                },
                grid: {
                    x2: 40
                },
                series: [
                    {
                        name: title[0],
                        type: 'line',
                        stack: '总量',
                        data: goodsownerCount
                    },
                    {
                        name: title[1],
                        type: 'line',
                        stack: '总量',
                        data: enterpownerCount
                    },
                    {
                        name: title[2],
                        type: 'line',
                        stack: '总量',
                        data: carownerCount
                    }
                ]
            };

            var myChart = echarts.init(document.getElementById('roleidiv'));
            myChart.clear();

            myChart.setOption(option);
            var myChart2 = echarts.init(document.getElementById('authenidiv'));
            myChart2.clear();
            var lastIndex = 0;
            var len = option2.series[0].data.length;
            clearInterval(timeTicket);
            timeTicket = setInterval(function () {
                // 动态数据接口 addData
                lastIndex += 1;
                myChart2.addData([
                    [
                        0,        // 系列索引
                        option2.series[0].data[lastIndex % len], // 新增数据
                        false,     // 新增数据是否从队列头部插入
                        false,     // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
                        option2.xAxis[0].data[lastIndex % len]
                    ],
                    [
                        1,        // 系列索引
                        option2.series[1].data[lastIndex % len], // 新增数据
                        false,     // 新增数据是否从队列头部插入
                        false,     // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
                        option2.xAxis[0].data[lastIndex % len]
                    ],
                    [
                        2,        // 系列索引
                        option2.series[2].data[lastIndex % len], // 新增数据
                        false,     // 新增数据是否从队列头部插入
                        false,     // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
                        option2.xAxis[0].data[lastIndex % len]
                    ]
                ]);
            }, 2000);
            myChart2.setOption(option2);
            myChart.connect(myChart2);
            myChart2.connect(myChart);
            setTimeout(function () {
                window.onresize = function () {
                    myChart.resize();
                    myChart2.resize();
                }
            }, 200)
        }

    });
</script>
</body>
</html>

