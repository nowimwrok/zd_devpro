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
        <label><input type="radio" checked="checked" value="" name="goodsType"/><span class="lbl">全部</span></label>
        <label><input type="radio" value="1" name="goodsType"/><span class="lbl">成品</span></label>
        <label><input type="radio" value="2" name="goodsType"/><span class="lbl">原材料</span></label>
    </div>

    <div id="orderAnalysis" class="echart-content" style="padding-left: 20px; "></div>
</div>
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/static/echarts/echarts.min.js"></script>

<script type="text/javascript">
    $(function () {
        var orderdom = document.getElementById("orderAnalysis");
        var myChart_order = echarts.init(orderdom);
        var date = [];
        var everCount = [];///运单量
        var alltradmy = [];///总运费
        var neworder = [];///待提货
        var cancel = [];///取消运单
        var getgd = [];//已提货
        var uporder = []; //待支付
        var payorder = [];//已支付
        var nieorder = [];//新建单
        var DataName = "everyDay";
        var userTitle = ['运单量', '总运费', '待提货', '取消运单', '已提货', '待支付', '已支付', '新建单'];
        var allDateCount = [];
        //$("#orderFrame")[0].contentWindow.nowDayNO=0;
        var nowDayNO = 0;
        var nowDayMY = 0;
        var yesteDayNO = 0;
        var yesteDayMY = 0;
        var addpid = 0;
        $("[name=goodsType]").click(function () {

            getOrderCount(DataName);
        });
        getOrderCount(DataName);
        function getOrderCount(DataName) {
            date = [];
            everCount = [];///运单量
            alltradmy = [];///总运费
            neworder = [];///待提货
            cancel = [];///取消运单
            getgd = [];//已提货
            uporder = []; //待支付
            payorder = [];//已支付
            nieorder = [];//新建单
            $.ajax({
                type: "POST",
                url: '${wlpt}/wlpt/dataCenter/getOrderCount',
                dataType: 'json',
                data: {dataName: DataName, gsType: $("[name=goodsType]:checked").val()},
                cache: false,
                success: function (data) {
                    var nowallmy = 0;
                    var yesallmy = 0;
                    for (var i = 0; i < data.data.roleList.length; i++) {
                        var nowdata = data.data.roleList[i];//当钱数据对象

                        if (DataName == 'everyWeek') {
                            date.push(nowdata.cretime + '第' + nowdata.timeflg + '周');
                        } else {
                            date.push(nowdata.cretime);
                        }
                        if (i == data.data.roleList.length - 1) {
                            nowDayNO = nowdata.evercout;
                            nowDayMY = nowdata.alltradmy;
                            $('#nowDayNO', parent.document).html(nowDayNO);
                            $('#nowDayMY', parent.document).html(nowDayMY);
                            nowallmy = nowdata.alltradmy * 1;
                        }
                        if (i == data.data.roleList.length - 2) {
                            $('#yesteDayNO', parent.document).html(nowdata.evercout);
                            $('#yesteDayMY', parent.document).html(nowdata.alltradmy);
                            yesteDayNO = nowdata.evercout;
                            yesteDayMY = nowdata.alltradmy;
                            yesallmy = nowdata.alltradmy * 1;

                        }

                        everCount.push(nowdata.evercout)///运单量
                        alltradmy.push(nowdata.alltradmy);///总运费
                        neworder.push(nowdata.newordermoney);///待提货
                        cancel.push(nowdata.cancelordermoney);///取消运单
                        getgd.push(nowdata.getgdordermoney);//已提货
                        uporder.push(nowdata.upordermoney); //待支付
                        payorder.push(nowdata.payordermoney);//已支付
                        nieorder.push(nowdata.nieordermoney);//新建单
                    }

                    addpid = ((nowallmy - yesallmy) / (yesallmy + nowallmy)) * 100;
                    addpid = xround(addpid, 2);
                    /* $("#addPid").html(addpid);*/
                    $('#addPid', parent.document).html(addpid);
                    function optionFun(everCount, alltradmy, neworder, cancel, getgd, uporder, payorder, nieorder) {

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
                                    scale: false
                                }
                            ],
                            yAxis: [
                                {
                                    name: '运费(元)',
                                    type: 'value',
                                    splitNumber: 5,
                                    boundaryGap:false,
                                    scale: false
                                },
                                { name: '运单(单)',
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
                            series: [
                                {
                                    name: userTitle[0],
                                    type: 'bar',
                                    smooth: false,
                                    symbol: 'circle',
                                    sampling: 'average',
                                    yAxisIndex:1,
                                    itemStyle: {
                                        normal: {
                                            color: 'rgb(255, 70, 10)'
                                        }
                                    },
                                    data: everCount
                                }, {
                                    name: userTitle[1],
                                    type: 'line',
                                    smooth: false,
                                    symbol: 'circle',
                                    sampling: 'average',
                                    itemStyle: {
                                        normal: {
                                            color: 'green',
                                        }
                                    },
                                    data: alltradmy
                                }, {
                                    name: userTitle[2],
                                    type: 'line',
                                    smooth: false,
                                    symbol: 'circle',
                                    sampling: 'average',
                                    itemStyle: {
                                        normal: {
                                            color: 'blue'
                                        }
                                    },
                                    data: neworder
                                }, {
                                    name: userTitle[3],
                                    type: 'line',
                                    smooth: false,
                                    symbol: 'circle',
                                    sampling: 'average',
                                    itemStyle: {
                                        normal: {
                                            color: 'yellow'
                                        }
                                    },
                                    data: cancel
                                }, {
                                    name: userTitle[4],
                                    type: 'line',
                                    smooth: false,
                                    symbol: 'circle',
                                    sampling: 'average',
                                    itemStyle: {
                                        normal: {
                                            color: '#749f83'
                                        }
                                    },
                                    data: getgd
                                }, {
                                    name: userTitle[5],
                                    type: 'line',
                                    smooth: false,
                                    symbol: 'circle',
                                    sampling: 'average',
                                    itemStyle: {
                                        normal: {
                                            color: '#91c7ae'
                                        }
                                    },
                                    data: uporder
                                }, {
                                    name: userTitle[6],
                                    type: 'line',
                                    smooth: false,
                                    symbol: 'circle',
                                    sampling: 'average',
                                    itemStyle: {
                                        normal: {
                                            color: '#d48265'
                                        }
                                    },
                                    data: payorder
                                }, {
                                    name: userTitle[7],
                                    type: 'line',
                                    smooth: false,
                                    symbol: 'circle',
                                    sampling: 'average',
                                    itemStyle: {
                                        normal: {
                                            color: '#61a0a8'
                                        }
                                    },
                                    data: nieorder
                                }

                            ]
                        };

                        myChart_order.setOption(option);
                    }

                    optionFun(everCount, alltradmy, neworder, cancel, getgd, uporder, payorder, nieorder);
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
        });

    });

</script>
</body>
</html>

