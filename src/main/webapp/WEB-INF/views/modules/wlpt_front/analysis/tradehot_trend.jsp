<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<html lang="en">
<head>
    <link rel="stylesheet" href="${ctxStatic}/modules/wlpt/front/css/analysis/global.css"/>
    <style type="text/css">
        * {
            margin: 0px;
            padding: 0px;
        }

        #datachart, #monthdiv {
            float: left;
            height: 450px;
        }

        .rightdiv {
            width: 240px;
            height: 380px;
            position: fixed;
            bottom: 20px;
            right: 2%;
            background-color: transparent;
            z-index: 22;
            border: solid 1px #FFFFFF;
        }

        .rtitle {
            height: 45px;
            width: 100%;
            font-size: 16px;
            color: #f1f2ed;
            text-align: center;
            line-height: 45px;
        }

        a {
            background: transparent;
            text-decoration: none;
            color: #0088cc;
        }

        .input-group-addon .i {
            display: inline-block;
            background: url('http://bcscdn.baidu.com/baidu-qianxi/chuxing/images/icon-common.png');
            vertical-align: middle;
            cursor: pointer;
            width: 23px;
            height: 23px;
            background-position: -59px -170px;
            vertical-align: top;
        }

        .i {
            display: inline-block;
            background: url('http://bcscdn.baidu.com/baidu-qianxi/chuxing/images/icon-common.png');
            vertical-align: middle;
            cursor: pointer;
        }

        .div_list_container .row {
            margin-bottom: 18px;
        }

        .serial-number {
            border-radius: 4px;
            height: 20px;
            width: 20px;
            line-height: 20px;
            background-color: #008cff;
            text-align: center;
            display: inline-block;
            margin-left: 10px;
            margin-right: 5px;
        }

        .i12 {
            width: 45px;
            height: 15px;
            background-position: -48px -137px;
        }

        .city-name {
            width: 50px;
            display: inline-block;
            color: #fff;
        }

        a {
            background: transparent;
            text-decoration: none;
            color: #0088cc;
        }

        .col {
            float: left;
        }

        .outer-wrap {
            height: 336px;

        }
    </style>
</head>
<body>
<div class="data-echart bgcolr-white">
    <div style="width: 100%;height: 100%;">
        <div id="datachart" class="echart-content" style="height:450px;width: 100%;"></div>
    </div>
    <div id="tradeline" class="rightdiv">
        <div class="rtitle">运输流量</div>
        <div class="outer-wrap" style="overflow: hidden;">
            <div class="div_list_container" id="data_list" style="position:relative;top:0">
                <div class="row">
                    <span class="serial-number col" data="index">1</span>
                    <a href="javascript:;" class="col city-name" data="startName" title="上海">上海</a>
                    <i class="col i i12"></i>
                    <a href="javascript:;" class="city-name" data="endName" title="北京">北京</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/static/echarts/echarts.min.js"></script>

<script type="text/javascript">
    $(function () {

        $.get('${ctxStatic}/echarts/china.json', function (chinaJson) {
            echarts.registerMap('china', chinaJson);
            var chart = echarts.init(document.getElementById('datachart'));
            chart.setOption({
                series: [{
                    type: 'map',
                    map: 'china'
                }]
            });
            var datachart = document.getElementById("datachart");
            var myChart = echarts.init(datachart);
            var dataVar = [];//数据对象
            var geoCoordMap = {
                '海门': [121.15, 31.89],
                '鄂尔多斯': [109.781327, 39.608266],
                '招远': [120.38, 37.35],
                '舟山': [122.207216, 29.985295],
                '齐齐哈尔': [123.97, 47.33],
                '盐城': [120.13, 33.38],
                '赤峰': [118.87, 42.28],
                '青岛': [120.33, 36.07],
                '乳山': [121.52, 36.89],
                '金昌': [102.188043, 38.520089],
                '泉州': [118.58, 24.93],
                '莱西': [120.53, 36.86],
                '日照': [119.46, 35.42],
                '胶南': [119.97, 35.88],
                '南通': [121.05, 32.08],
                '拉萨': [91.11, 29.97],
                '云浮': [112.02, 22.93],
                '梅州': [116.1, 24.55],
                '文登': [122.05, 37.2],
                '上海': [121.48, 31.22],
                '攀枝花': [101.718637, 26.582347],
                '威海': [122.1, 37.5],
                '承德': [117.93, 40.97],
                '厦门': [118.1, 24.46],
                '汕尾': [115.375279, 22.786211],
                '潮州': [116.63, 23.68],
                '丹东': [124.37, 40.13],
                '太仓': [121.1, 31.45],
                '曲靖': [103.79, 25.51],
                '烟台': [121.39, 37.52],
                '福州': [119.3, 26.08],
                '瓦房店': [121.979603, 39.627114],
                '即墨': [120.45, 36.38],
                '抚顺': [123.97, 41.97],
                '玉溪': [102.52, 24.35],
                '张家口': [114.87, 40.82],
                '阳泉': [113.57, 37.85],
                '莱州': [119.942327, 37.177017],
                '湖州': [120.1, 30.86],
                '汕头': [116.69, 23.39],
                '昆山': [120.95, 31.39],
                '宁波': [121.56, 29.86],
                '湛江': [110.359377, 21.270708],
                '揭阳': [116.35, 23.55],
                '荣成': [122.41, 37.16],
                '连云港': [119.16, 34.59],
                '葫芦岛': [120.836932, 40.711052],
                '常熟': [120.74, 31.64],
                '东莞': [113.75, 23.04],
                '河源': [114.68, 23.73],
                '淮安': [119.15, 33.5],
                '泰州': [119.9, 32.49],
                '南宁': [108.33, 22.84],
                '营口': [122.18, 40.65],
                '惠州': [114.4, 23.09],
                '江阴': [120.26, 31.91],
                '蓬莱': [120.75, 37.8],
                '韶关': [113.62, 24.84],
                '嘉峪关': [98.289152, 39.77313],
                '广州': [113.23, 23.16],
                '延安': [109.47, 36.6],
                '太原': [112.53, 37.87],
                '清远': [113.01, 23.7],
                '中山': [113.38, 22.52],
                '昆明': [102.73, 25.04],
                '寿光': [118.73, 36.86],
                '盘锦': [122.070714, 41.119997],
                '长治': [113.08, 36.18],
                '深圳': [114.07, 22.62],
                '珠海': [113.52, 22.3],
                '宿迁': [118.3, 33.96],
                '咸阳': [108.72, 34.36],
                '铜川': [109.11, 35.09],
                '平度': [119.97, 36.77],
                '佛山': [113.11, 23.05],
                '海口': [110.35, 20.02],
                '江门': [113.06, 22.61],
                '章丘': [117.53, 36.72],
                '肇庆': [112.44, 23.05],
                '大连': [121.62, 38.92],
                '临汾': [111.5, 36.08],
                '吴江': [120.63, 31.16],
                '石嘴山': [106.39, 39.04],
                '沈阳': [123.38, 41.8],
                '苏州': [120.62, 31.32],
                '茂名': [110.88, 21.68],
                '嘉兴': [120.76, 30.77],
                '长春': [125.35, 43.88],
                '胶州': [120.03336, 36.264622],
                '银川': [106.27, 38.47],
                '张家港': [120.555821, 31.875428],
                '三门峡': [111.19, 34.76],
                '锦州': [121.15, 41.13],
                '南昌': [115.89, 28.68],
                '柳州': [109.4, 24.33],
                '三亚': [109.511909, 18.252847],
                '自贡': [104.778442, 29.33903],
                '吉林': [126.57, 43.87],
                '阳江': [111.95, 21.85],
                '泸州': [105.39, 28.91],
                '西宁': [101.74, 36.56],
                '宜宾': [104.56, 29.77],
                '呼和浩特': [111.65, 40.82],
                '成都': [104.06, 30.67],
                '大同': [113.3, 40.12],
                '镇江': [119.44, 32.2],
                '桂林': [110.28, 25.29],
                '张家界': [110.479191, 29.117096],
                '宜兴': [119.82, 31.36],
                '北海': [109.12, 21.49],
                '西安': [108.95, 34.27],
                '金坛': [119.56, 31.74],
                '东营': [118.49, 37.46],
                '牡丹江': [129.58, 44.6],
                '遵义': [106.9, 27.7],
                '绍兴': [120.58, 30.01],
                '扬州': [119.42, 32.39],
                '常州': [119.95, 31.79],
                '潍坊': [119.1, 36.62],
                '重庆': [106.54, 29.59],
                '台州': [121.420757, 28.656386],
                '南京': [118.78, 32.04],
                '滨州': [118.03, 37.36],
                '贵阳': [106.71, 26.57],
                '无锡': [120.29, 31.59],
                '本溪': [123.73, 41.3],
                '克拉玛依': [84.77, 45.59],
                '渭南': [109.5, 34.52],
                '马鞍山': [118.48, 31.56],
                '宝鸡': [107.15, 34.38],
                '焦作': [113.21, 35.24],
                '句容': [119.16, 31.95],
                '北京': [116.46, 39.92],
                '徐州': [117.2, 34.26],
                '衡水': [115.72, 37.72],
                '包头': [110, 40.58],
                '绵阳': [104.73, 31.48],
                '乌鲁木齐': [87.68, 43.77],
                '枣庄': [117.57, 34.86],
                '杭州': [120.19, 30.26],
                '淄博': [118.05, 36.78],
                '鞍山': [122.85, 41.12],
                '溧阳': [119.48, 31.43],
                '库尔勒': [86.06, 41.68],
                '安阳': [114.35, 36.1],
                '开封': [114.35, 34.79],
                '济南': [117, 36.65],
                '德阳': [104.37, 31.13],
                '温州': [120.65, 28.01],
                '九江': [115.97, 29.71],
                '邯郸': [114.47, 36.6],
                '临安': [119.72, 30.23],
                '兰州': [103.73, 36.03],
                '沧州': [116.83, 38.33],
                '临沂': [118.35, 35.05],
                '南充': [106.110698, 30.837793],
                '天津': [117.2, 39.13],
                '富阳': [119.95, 30.07],
                '泰安': [117.13, 36.18],
                '诸暨': [120.23, 29.71],
                '郑州': [113.65, 34.76],
                '哈尔滨': [126.63, 45.75],
                '聊城': [115.97, 36.45],
                '芜湖': [118.38, 31.33],
                '唐山': [118.02, 39.63],
                '平顶山': [113.29, 33.75],
                '邢台': [114.48, 37.05],
                '德州': [116.29, 37.45],
                '济宁': [116.59, 35.38],
                '荆州': [112.239741, 30.335165],
                '宜昌': [111.3, 30.7],
                '义乌': [120.06, 29.32],
                '丽水': [119.92, 28.45],
                '洛阳': [112.44, 34.7],
                '秦皇岛': [119.57, 39.95],
                '株洲': [113.16, 27.83],
                '石家庄': [114.48, 38.03],
                '莱芜': [117.67, 36.19],
                '常德': [111.69, 29.05],
                '保定': [115.48, 38.85],
                '湘潭': [112.91, 27.87],
                '金华': [119.64, 29.12],
                '岳阳': [113.09, 29.37],
                '长沙': [113, 28.21],
                '衢州': [118.88, 28.97],
                '廊坊': [116.7, 39.53],
                '菏泽': [115.480656, 35.23375],
                '合肥': [117.27, 31.86],
                '武汉': [114.31, 30.52],
                '大庆': [125.03, 46.58]
            };

            var convertData = function (data) {
                var res = [];
                for (var i = 0; i < data.length; i++) {

                    var geoCoord = geoCoordMap[data[i].name];
                    if (geoCoord) {
                        res.push({
                            name: data[i].name,
                            value: geoCoord.concat(data[i].value)
                        });
                    }
                }
                return res;
            };
            loadData();
            function loadData() {
                $.ajax({
                    url: "${wlpt}/wlpt/dataCenter/getTradeHotData",
                    type: "POST",
                    dataType: 'json',
                    async: false,
                    success: function (data) {
                        var fillHtml = "";
                        $("#data_list").html("");
                        if (data.data.varList.length > 0) {
                            for (var i = 0; i < data.data.varList.length; i++) {
                                var nowdata = data.data.varList[i];
                                var STARTADDRESS = nowdata.startaddress.replace("市", "");
                                var val = new Object();
                                val.name = STARTADDRESS;
                                val.value = nowdata.everycount;
                                dataVar.push(val);
                                fillHtml += loadRightData(nowdata, i + 1);

                            }
                            $("#data_list").html(fillHtml);
                            listScroll('data_list');
                            option = {
                                backgroundColor: '#404a59',
                                tooltip: {
                                    trigger: 'item'
                                },
                                legend: {
                                    orient: 'vertical',
                                    y: 'bottom',
                                    x: 'right',
                                    data: ['发布'],
                                    textStyle: {
                                        color: '#fff'
                                    }
                                },
                                geo: {
                                    map: 'china',
                                    label: {
                                        emphasis: {
                                            show: true
                                        }
                                    },
                                    roam: true,
                                    itemStyle: {
                                        normal: {
                                            areaColor: '#323c48',
                                            borderColor: '#111'
                                        },
                                        emphasis: {
                                            areaColor: '#2a333d'
                                        }
                                    }
                                },
                                series: [
                                    {
                                        name: '发布',
                                        type: 'scatter',
                                        coordinateSystem: 'geo',
                                        data: convertData(dataVar),
                                        symbolSize: function (val) {
                                            return val[2] / 500;
                                        },
                                        label: {
                                            normal: {
                                                formatter: '{b}',
                                                position: 'right',
                                                show: true
                                            },
                                            emphasis: {
                                                show: true
                                            }
                                        },
                                        itemStyle: {
                                            normal: {
                                                color: '#ddb926'
                                            }
                                        }
                                    },
                                    {
                                        name: '主分布',
                                        type: 'effectScatter',
                                        coordinateSystem: 'geo',
                                        data: convertData(dataVar.sort(function (a, b) {
                                            return b.value - a.value;
                                        }).slice(0, 6)),
                                        symbolSize: function (val) {
                                            return val[2] / 500;
                                        },
                                        showEffectOn: 'render',
                                        rippleEffect: {
                                            brushType: 'stroke'
                                        },
                                        hoverAnimation: true,
                                        label: {
                                            normal: {
                                                formatter: '{b}',
                                                position: 'right',
                                                show: true
                                            }
                                        },
                                        itemStyle: {
                                            normal: {
                                                color: '#f4e925',
                                                shadowBlur: 10,
                                                shadowColor: '#333'
                                            }
                                        },
                                        zlevel: 1
                                    }
                                ]
                            };
                            myChart.setOption(option);
                        }

                    }
                });
            }
        });
        function loadRightData(data, i) {
            var start = data.startaddress.replace("市", "");
            var end = data.endaddress.replace("市", "");
            var valpr = end + data.everycount + '车次'
            var html = '<div class="row" style="padding: 0px;margin: 0px 0px 18px 0px;">'
                + '<span class="serial-number col" data="index">' + i + '</span>'
                + '<a href="javascript:;" class="col city-name"  data="startName" title="' + start + '">' + start + '</a>'
                + '<i class="col i i12"></i>'
                + '<a href="javascript:;" class="city-name" data="endName" style="width: 110px;" title="' + end + '">' + valpr + '</a>'
                + '</div>';
            return html;
        }

        //列表滚动方法
        function listScroll(domid) {//传入滚动table的id
            var $domid = $("#" + domid + "");
            $domid.css("top", 0);
            var inittop = $domid.offset().top;//初始位置top
            var trheight = $domid.find(".row").height() + 18;//行高
            console.log(inittop + "----" + trheight);
            function scrollRun() {
                if (inittop - $domid.offset().top >= $domid.height() - $domid.parent("div").height()) {
                    //  $domid.offset({top:inittop})
                    $domid.css("top", 0);
                } else {
                    // var dd=$domid.css("top").replace("px","")-trheight;
                    //$domid.offset({top:$domid.offset().top-trheight});
                    $domid.animate({top: $domid.css("top").replace("px", "") - trheight}, 1500)
                }
            };
            if ($domid.find(".row").length > 7) {
                var myInter = setInterval(scrollRun, 2500);
                $domid.mouseenter(function () {
                    clearInterval(myInter);
                });
                $domid.mouseleave(function () {
                    myInter = setInterval(scrollRun, 2500);
                });
                $domid.mouseenter();
                $domid.mouseleave();
            }
        };

    });
</script>
<%--<script type="text/javascript">
    var valary = [];
    $.ajax({
        url: "${pageContext.request.contextPath}/dataCenter/getTradeHotData", 
        type: "POST", 
        dataType: 'json', 
        async: false, 
        success: function (data) {
            if (data.data.varList.length> 0) { 
                for (var i = 0; i < data.data.varList.length; i++) { 
                    var nowdata = data.data.varList[i];//当数据对象 
                    var STARTADDRESS=nowdata.FROMPRO.replace("市","").replace("省",""); 
                    var val = new Object(); 
                    val.name = STARTADDRESS; 
                    val.value = nowdata.EVERYCOUNT; 
                    valary.push(val); 
                } 
            } 
        } });
    //点击不相关的地方隐藏地区选择框
    document.onclick = myfunc;
    function myfunc() {
        var tagName = window.event.srcElement.tagName;
        if (tagName != "INPUT" && tagName != "A" && tagName != "LI") {
            $(".pcc-container").hide();
        }
    };
    //关闭
    function close_p(idname) {
        $("#" + idname).hide();
    }

    var myChart = echarts.init(document.getElementById('datachart'));

    option = {
        tooltip : {
            trigger : 'item',
            formatter : "{b0}{c0}发布量",
        },
        toolbox : {
            show : true,
            orient : 'vertical',
            x : 'right',
            y : 'center',
            feature : {}
        },
        visualMap: {
            min: 0,
            max: 2500,
            left: 'left',
            top: 'bottom',
            text: ['高','低'],           // 文本，默认为数值文本
            calculable: true
        },
        series : [ {
            name : '发布量',
            type : 'map',
            mapType : 'china',
            itemStyle : {
                normal : {
                    color : '#97D6F5',
                    label : {
                        show : true
                    },
                    borderWidth : 1,
                    borderColor : '#ECECEC',
                },
                emphasis : {
                    label : {
                        show : true
                    },
                    color : '#FF7400'
                }
            },
            label: {
                normal: {
                    show: true
                },
                emphasis: {
                    show: true
                }
            },
            data : valary
        } ]
    };

    // 为echarts对象加载数据
    myChart.setOption(option);
</script>--%>
</body>
</html>

