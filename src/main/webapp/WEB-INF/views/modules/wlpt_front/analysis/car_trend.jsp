<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>

    <link rel="stylesheet" href="/static/modules/wlpt/front/css/analysis/global.css"/>
    <style type="text/css">
        #carTypediv, #monthdiv {
            float: left;
            height: 450px;
        }
    </style>
</head>
<body>

<div style="width: 100%;height: 100%;">
    <div id="carTypediv" class="echart-content" style="width: 40%"></div>
    <div id="monthdiv" class="echart-content" style="width: 60%;float: left;height: 450px;">

    </div>
</div>
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/static/echarts/echarts.min.js"></script>
<script type="text/javascript" src="/static/echarts/echarts-all.js"></script>
<script type="text/javascript">
    $(function () {
        var dom = document.getElementById("monthdiv");
        var myChart = echarts.init(dom);
        var date = [];
        var everyCount=[];
        var title = ['平台车辆'];
        getUserCount();
        function getUserCount() {
            date = [];
            everyCount=[];
            $.ajax({
                type: "POST",
                url: '${wlpt}/wlpt/dataCenter/getCarMothData',
                dataType: 'json',
                cache: false,
                success: function (data) {

                    for (var i=0;i<data.data.varList.length;i++){
                        var nowdata=data.data.varList[i];
                        date.push(nowdata.cretime);
                        everyCount.push(nowdata.everycount);
                     }
                    function optionFun(everyCount) {

                        var option = {
                            tooltip: {
                                trigger: 'axis',
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
                            xAxis: {
                                type: 'category',
                                boundaryGap: false,
                                data: date
                            },
                            yAxis: {
                                type: 'value'
                            },
                            dataZoom: [{
                                type: 'inside',
                                startValue: 0,
                                endValue: 100
                            }, {
                                startValue: 0,
                                endValue: 100
                            }],
                            series: [
                                {
                                    name: title[0],
                                    type: 'line',
                                    smooth: false,
                                    symbol: 'circle',
                                    sampling: 'average',
                                    itemStyle: {
                                        normal: {
                                            color: 'rgb(255, 70, 10)',
                                            label: {show: true}
                                        }
                                    },
                                    data: everyCount
                                }
                            ]
                        };

                        myChart.setOption(option);
                    }

                    optionFun(everyCount);
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
            getUserCount();
        })

    });

</script>


<script type="text/javascript">
    $(function () {
        var dom = document.getElementById("carTypediv");
        var myChart = echarts.init(dom);
        var title = [];
        var dataVar = [];
        var TOTALCOUNT = 0;//
        geroleCount();
        function geroleCount() {
            $.ajax({
                type: "POST",
                url: '${wlpt}/wlpt/dataCenter/getCarTypeCount',
                dataType: 'json',
                cache: false,
                success: function (data) {
                    for (var i = 0; i < data.data.varList.length; i++) {
                        var nowdata = data.data.varList[i];
                        title[i] = nowdata.carType;
                        dataVar[i] = {value: nowdata.everycount, name: nowdata.carType};
                        TOTALCOUNT += nowdata.everycount;
                    }
                    setoption();
                }
            });
        }

        function setoption() {
            option = {
                title: {
                    text: '平台车辆总计' + TOTALCOUNT + "辆",
                    subtext:"车型分析",
                    x: 'center',
                    top: 10
                },
                legend: {
                    top:20,
                    orient: 'vertical',
                    x: 'left',
                    data: title,
                    padding:[30,5,5,10]
                },
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                series: [
                    {
                        name: "平台车辆",
                        type: 'pie',
                        radius: '55%',
                        center: ['50%', '50%'],
                        data: dataVar,
                        label: {
                            normal: {
                                textStyle: {
                                    color: 'rgba(255, 255, 255, 0.3)'
                                },
                                label: {show: true}
                            }
                        }


                    }
                ]
            };
            myChart.setOption(option);
        }
    });
</script>
</body>
</html>

