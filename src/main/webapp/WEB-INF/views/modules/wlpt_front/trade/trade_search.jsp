<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head lang="en">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_default_basic"/>
    <title>运单查询</title>
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/banner.css">
    <style type="text/css">
        .container {
            width: 100%;
            padding-right: 0px;
            padding-left: 0px;
        }

        .wrap {
            width: 80%;
        }

        footer {
            width: 100%;
            /* margin-top: 80px; */
            clear: both;
            background-color: #363E41;
            padding-bottom: 2%;
        }
    </style>
    <script type="text/javascript">
        $(function () {
            setTimeout("changeDivStyle();", 100); // 0.1秒后展示结果，因为HTML加载顺序，先加载脚本+样式，再加载body内容。所以加个延时
        });
        function changeDivStyle() {
//		var o_status = $("#o_status").val();	//获取隐藏框值
            var o_status = ${orderinfo.orderstatus};
            if (o_status == 0) {
                $('#create').css('background', '#red');
                $('#createText').css('color', '#DD0000');
            } else if (o_status == 1 || o_status == 2) {
                $('#check').addClass('stepIco');
                $('#checkText').css('color', '#DD0000');
            } else if (o_status == 3) {
                $('#produce').addClass('stepIco');

                $('#produceText').css('color', '#DD0000');
            } else if (o_status == 4) {
                $('#delivery').addClass('stepIco');
                $('#deliveryText').css('color', '#DD0000');
            } else if (o_status >= 5) {
                $('#received').css('background', 'red');
                $('#receivedText').css('color', '#DD0000');
            }else if (o_status ==6) {
                $('#received').addClass('stepIco');
                $('#receivedText').css('color', '#DD0000');
            }
            forlt(o_status);
            $(".stepInfo_y li").height($("#stepfg").height());
        }
        function forlt(o_status) {
            if (o_status == 1) {
                $('#create').addClass('stepIco');
                $('#check').css('background', '#red');
                $('#createText').css('color', '#DD0000');
            } else if (o_status == 2) {
                $('#create').addClass('stepIco');
                $('#checkText').html('取消运单');
            } else if (o_status == 3) {
                $('#create').addClass('stepIco');
                $('#check').addClass('stepIco');

            } else if (o_status == 4) {
                $('#create').addClass('stepIco');
                $('#check').addClass('stepIco');

                $('#produce').addClass('stepIco');
            } else if (o_status == 5) {
                $('#create').addClass('stepIco');
                $('#check').addClass('stepIco');
                $('#produce').addClass('stepIco');
                $('#delivery').addClass('stepIco');

            }else if (o_status >= 6) {
                $('#create').addClass('stepIco');
                $('#check').addClass('stepIco');
                $('#produce').addClass('stepIco');
                $('#delivery').addClass('stepIco');
                $('#receivedText').html('争议中');
            }
        }
    </script>

    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
            list-style-type: none;
        }

        a, img {
            border: 0;
        }

        body {
            background: #f2f2f2;
            font: 12px/180% Arial, Helvetica, sans-serif, "新宋体";
        }

        /* stepInfo
            border-radius：0为正方形，0~N，由正方形向圆形转化，N越大越圆。
            padding：图形的内边距
            background：图形背景色
            text-align：文本对齐
            line-height：行高
            color：文字颜色
            position：定位
            width：宽度
            height：高度
        */
        .stepInfo {
            position: relative;
            background: #f2f2f2;
            margin: 20px auto 0 auto;
            width: 600px;
            height: 50px;
        }

        .stepInfo li {
            float: left;
            width: 48%;
            height: 0.15em;
            background: #bbb;
        }

        .stepIco-df {
            border-radius: 1em;
            padding: 0.25em;
            background: #bbb;
            background-repeat: no-repeat;
            -moz-box-shadow: -3px 0px 4px #ccc;
            -webkit-box-shadow: 4px 0px 6px #FFF;
            text-align: center;
            background-size: contain;
            line-height: 1.5em;
            color: #fff;
            position: absolute;
            width: 2em;
            top: -0.8em;
            height: 2em;
        }

        .stepIco {
            border-radius: 1em;
            padding: 0.25em;
            /* background: #bbb; */
            background-image: url("${ctxStatic}/images/weixin/tick_easyicon.png");
            background-repeat: no-repeat;
            -moz-box-shadow: -3px 0px 4px #ccc;
            -webkit-box-shadow: 4px 0px 6px #FFF;
            text-align: center;
            background-size: contain;
            line-height: 1.5em;
            color: #fff;
            position: absolute;
            width: 2em;
            top: -0.8em;
            height: 2em;
        }

        .stepIco1 {
            left: -1%;
        }

        .stepIco2 {
            left: 21%;
        }

        .stepIco3 {
            left: 46%;
        }

        .stepIco4 {
            left: 71%;
        }

        .stepIco5 {

            left: 95%;
        }

        .stepIco6 {
            top: -0.8em;
            left: 113%;
        }

        .stepText {
            color: #666;
            margin-top: 2.2em;
            width: 5em;
            text-align: center;
            margin-left: -1.7em;
        }

        .tab_nav {
            height: 35px;
        }

        .tab_nav li {
            float: right;
            width: 94%;
            text-align: left;
            cursor: pointer;
            border-bottom: 1px solid #ccc;
        }

        .shadow_left, .shadow_right {
            margin-left: 10%;
            height: 350px;
            float: left;
        }

        .shadow_right {
            width: 60%;
            float: right;
            height: 60%;
        }

        .stepInfo_y {
            /*-webkit-transform: rotate(90deg);!*Safari 4+,Google Chrome 1+  *!
            -moz-transform: rotate(90deg);!*Firefox 3.5+*!
            filter: progid:DXImageTransform.Microsoft.BasicImage(rotation=1);!*ie*!*/
            float: left;
            z-index: 0;
            height: 0px;

        }

        .stepInfo_y li {
            border: 1px solid #CCC;
            height: 266px;
            position: relative;
            z-index: 1;
            margin-top: 0px;
        }

        .stepIco_y {
            border-radius: 1em;
            padding: 0.25em;
            clear: both;
            background: rgb(78, 188, 237);
            background-repeat: no-repeat;
            -moz-box-shadow: -3px 0px 4px #ccc;
            -webkit-box-shadow: 4px 0px 6px #FFF;
            text-align: center;
            background-size: contain;
            line-height: 1.5em;
            color: #fff;
            position: relative;
            width: 1.4em;
            height: 1.4em;
            /* clear: both; */
            margin-bottom: 50px;
            z-index: 112;
            margin-left: -0.65em;
        }

        .stepIco_y .stepText {
            color: #666;
            margin-top: -5px;
            width: 25em;
            text-align: left;
            margin-left: 2.3em;
        }

        .ct_lf div {
            float: left;
            margin-right: 5px;
            line-height: 30px;
            display: table-cell;
            vertical-align: middle;
            display: table-cell;
            font-size: 14px;
            text-align: left;
        }

        .img_text img {
            width: 60px;
            height: 60px;
        }

        .ct_lf {
            width: 100%;
            height: 30px;
            display: table;
        }

        .ct_blk {
            padding-left: 10%;
        }

        .ct_lf div {
            float: left;
            margin-right: 5px;
            line-height: 30px;
            display: table-cell;
            vertical-align: middle;
            display: table-cell;
            font-size: 14px;
        }

        .ic_img {
            height: 25px;
            display: table;
            margin: 0px;
        }

        .ic_img img {
            width: 25px;
            display: table-cell;
            vertical-align: middle;
            display: table-cell;
        }

        .cb_tle {

            text-align: right;
            float: left;
        }

        .cb_val {
            width: 80%;
            float: left;
            display: block;
            word-wrap: break-word;
        }

        .cb_val div {
            float: left;
            word-wrap: break-word;
            text-align: left;
        }

        .map_div {
            clear: both;
            margin-bottom: 15px;
        }
        #stepfg{
            display: block;
        }

    </style>
</head>
<body>

<div class="stepInfo">
    <ul>
        <li></li>
        <li></li>
    </ul>
    <div class="stepIco-df stepIco1" id="create">
        <div class="stepText" id="createText">生成运单</div>
    </div>
    <div class="stepIco-df stepIco2" id="check">
        <div class="stepText" id="checkText">确认运单</div>
    </div>
    <div class="stepIco-df stepIco3" id="produce">
        <div class="stepText" id="produceText">上传提货单</div>
    </div>
    <div class="stepIco-df stepIco4" id="delivery">
        <div class="stepText" id="deliveryText">上传回执单</div>
    </div>
    <div class="stepIco-df stepIco5" id="received">
        <div class="stepText" id="receivedText">完成</div>
    </div>
    <!--<div class="stepIco stepIco5" id="dispute">
        <div class="stepText" id="disputeText">争议中</div>
    </div>-->
</div>

<div class="map_div" id="trdshd" style="height: auto;">
<input type="hidden" id="ISLBS" value="${islbs }"/>
    <ul class="tab_nav">
        <li id="trade_shadow" class="liselect">运单跟踪&nbsp;&nbsp;&nbsp;&nbsp;运单号：${orderinfo.orderno!=null?orderinfo.orderno:"未查询到信息"}</li>
    </ul>
    <div class="shadow_left" style="height: auto;" ng-app="dataHall" ng-controller="dataHallCtrl">
        <ul class="stepInfo_y">
            <li></li>
        </ul>
        <div id="stepfg" style="display: none;">
            <div class="stepIco_y">
                <div class="stepText createText">
                    当前定位
                    <br>
                    ${gpsCar.carLocs.info!=null?gpsCar.carLocs.info:'暂无定位信息'}
                </div>
            </div>
            <div class="stepIco_y" ng-repeat="x in data">
                <div class="stepText createText">
                    {{x.status}}
                    <br>
                    {{x.createDate}}
                </div>
            </div>
        </div>
        <%--<div class="stepIco_y stepIco_y2 check">
            <div class="stepText checkText">确认运单<br>
                2016-10-13 00:24:13
            </div>
        </div>
        <div class="stepIco_y stepIco_y3 produce">
            <div class="stepText produceText">上传提货单<br>
                2016-10-13 00:24:13
            </div>
        </div>
        <div class="stepIco_y stepIco_y4 delivery">
            <div class="stepText deliveryText">上传回执单<br>
                2016-10-13 00:24:13
            </div>
        </div>
        <div class="stepIco_y stepIco_y5 received">
            <div class="stepText receivedText">完成<br>
                2016-10-13 00:24:13
            </div>
        </div>--%>
    </div>
    <div class="shadow_right">
        <div style="width:100%;height: 400px;" id="locationmap"></div>
        <c:if test="${islbs != 'true' }">
        <div id="guijiShow" style='text-align: center;margin-top: 20px'>
            <button style="width: 110px" class="btn btn-defalut btn-warning" id="btn-warning">开始轨迹回放</button>
        </div>
        </c:if>
    </div>
</div>
<div class="map_div">
    <ul class="tab_nav">
        <li class="liselect">运输线路</li>
    </ul>
    <div class="ct_blk">
        <div class="ct_lf">
            <div class="cb_tle">
                <div class="ic_img">
                    <img alt="始发地" style="width:20px;margin-right:4px;"
                         src="/static/images/weixin/ic_start.png">
                </div>
                <!--ic_img end  -->
            </div>
            <div class="cb_val">
                ${orderinfo.quoteinfo.goods.shipAddress.province}&nbsp;&nbsp;
                ${orderinfo.quoteinfo.goods.shipAddress.city}&nbsp;&nbsp;
                ${orderinfo.quoteinfo.goods.shipAddress.district}
            </div>
            <div class="cb_val" style="margin-left: 35px;">
                <div>${orderinfo.seller.loginName}</div>
                <div>${orderinfo.seller.phone}</div>
                <div>${orderinfo.seller.userinfo.companyname}</div>
                <div>${orderinfo.seller.name}</div>

            </div>
        </div>


    </div>
    <div class="ct_blk">
        <div class="ct_lf">
            <div class="cb_tle">
                <div class="ic_img">
                    <img alt="目的地" style="width:20px;margin-right:4px;"
                         src="/static/images/weixin/ic_end.png">
                </div>
                <!--ic_img end  -->
            </div>
            <div class="cb_val">
                ${orderinfo.quoteinfo.goods.consignAddress.province}&nbsp;&nbsp;
                ${orderinfo.quoteinfo.goods.consignAddress.city}&nbsp;&nbsp;
                ${orderinfo.quoteinfo.goods.consignAddress.district}&nbsp;&nbsp;
            </div>
            <div class="cb_val" style="margin-left: 35px;">
                <div>${orderinfo.quoteinfo.goods.consignAddress.linkman }</div>
                <div>${orderinfo.quoteinfo.goods.consignAddress.linkmobile }</div>
                <div>${orderinfo.quoteinfo.goods.consignAddress.linkcompany }</div>
                <div>${orderinfo.quoteinfo.goods.consignAddress.linktelphone }</div>

            </div>
        </div>

    </div>
</div>
<div class="map_div">
    <ul class="tab_nav">
        <li class="liselect">货物信息</li>
    </ul>
    <div class="ct_blk">
        <div class="ct_lf">
            <div class="cb_tle">
                货物名称：
            </div>
            <div class="cb_val">
                ${orderinfo.quoteinfo.goods.goodsname }
            </div>
        </div>
        <div class="ct_lf">
            <div class="cb_tle">
                货物类型：
            </div>
            <div class="cb_val">
                ${orderinfo.quoteinfo.goods.gsoddtype==1?"成品":"原材料" }
            </div>
        </div>
         <div class="ct_lf">
            <div class="cb_tle">
                货物价值：
            </div>
            <div class="cb_val">
                ${orderinfo.quoteinfo.goods.worth }元
            </div>
        </div>
        <div class="ct_lf">
            <div class="cb_tle">
                运输方式：
            </div>
            <div class="cb_val">
                ${orderinfo.quoteinfo.goods.transportway }
            </div>
        </div>
        <div class="ct_lf">
            <div class="cb_tle">
                报价吨位：
            </div>
            <div class="cb_val">
                ${orderinfo.quoteinfo.oddloadweight } ${orderinfo.quoteinfo.goods.freightunit }

            </div>
        </div>
        <div class="ct_lf">
            <div class="cb_tle">
                实际运输：
            </div>
            <div class="cb_val">
                ${orderinfo.quoteinfo.actload }${orderinfo.quoteinfo.goods.freightunit }

            </div>
        </div>
        <div class="ct_lf">
            <div class="cb_tle">
                剩余货量：
            </div>
            <div class="cb_val">
                ${orderinfo.quoteinfo.goods.residualvolume} ${orderinfo.quoteinfo.goods.freightunit }

            </div>
        </div>
        <div class="ct_lf">
            <div class="cb_tle">
                发货时间：
            </div>
            <div class="cb_val">
                ${orderinfo.quoteinfo.goods.sendtime }
            </div>
        </div>
    </div>

</div>
<div class="map_div">
    <ul class="tab_nav">
        <li class="liselect">承运车辆信息</li>
    </ul>
    <div class="ct_blk">
        <div class="ct_lf">
            <div class="cb_tle">
                承运方：
            </div>
            <div class="cb_val">
                ${orderinfo.buyer.loginName }&nbsp;&nbsp;${orderinfo.buyer.phone }
            </div>
        </div>
        <div class="ct_lf">
            <div class="cb_tle">
                司机：
            </div>
            <div class="cb_val">
                ${orderinfo.quoteinfo.driver.name }&nbsp;&nbsp;${orderinfo.quoteinfo.driver.phone }
            </div>

        </div>
         <div class="ct_lf">
            <div class="cb_tle">
                车牌号：
            </div>
            <div class="cb_val">
                ${orderinfo.quoteinfo.car.carnumber }
            </div>

        </div>
        <div class="ct_lf">
            <div class="cb_tle">
                车型：
            </div>
            <div class="cb_val">
                ${orderinfo.quoteinfo.car.cartype }

            </div>
        </div>
        <div class="ct_lf">
            <div class="cb_tle">
                载重：
            </div>
            <div class="cb_val">
                ${orderinfo.quoteinfo.car.loadweight } ${orderinfo.quoteinfo.car.lengthunit }


            </div>
        </div>
        <div class="ct_lf">
            <div class="cb_tle">
                车长：
            </div>
            <div class="cb_val">
                ${orderinfo.quoteinfo.car.carlength }米

            </div>
        </div>
    </div>
</div>
<div class="main">
    <div class="clients">
        <div class="wrap">
            <h2 class="head">合作伙伴</h2>
            <ul id="flexiselDemo4">
                <li><a href="http://www.zhaogang.com" target="_blank"><img src="${ctxStatic }/images/wlptfront/c1.png"/></a>
                </li>
                <li><a href="http://www.hbistc.com" target="_blank"><img
                        src="${ctxStatic }/images/wlptfront/c2.png"/></a></li>
                <li><a href="http://www.ouyeel.cn" target="_blank"><img
                        src="${ctxStatic }/images/wlptfront/c3.png"/></a></li>
                <li><a href="http://www.money56.com" target="_blank"><img src="${ctxStatic }/images/wlptfront/c4.png"/></a>
                </li>
            </ul>

        </div>
    </div>
</div>
<!-- jQuery -->
<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="/static/modules/wlpt/front/js/angular/angular.min.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/jquery.magnific-popup.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/jquery.hoverdir.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.flexisel.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/jquery.wmuSlider.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/jquery.magnific-popup.js" type="text/javascript"></script>
<script type="text/javascript"
        src="http://api.map.baidu.com/api?v=2.0&ak=80f73f31cfbb40be26acda67af03da43"></script>
<script type="text/javascript"
        src="http://api.map.baidu.com/library/LuShu/1.2/src/LuShu_min.js"></script>
<script type="text/javascript">
    var app = angular.module("dataHall", []);
    app.controller('dataHallCtrl', function ($scope, $http) {
        $scope.currentPage = 1;
        $scope.pageSize = 10;
        $scope.pages = [];
        $scope.id = '${orderinfo.id}';
        //get first page
        $http({
            url: '${wlpt}/wlpt/trade/getTraceList',
            method: 'post',
            params: {
                'id': $scope.id,
                'orderBy': "create_date desc",
                'pageNo': $scope.currentPage,
                'pageSize': $scope.pageSize
            }
        }).success(function (response) {
            $scope.data = response.data;
            if (!$scope.data) {
                $(".shadow_left").html("未查询到相关信息");
                $(".ct_blk").html("未查询到相关信息");
            }else {
                $("#stepfg").show();
            }
            isReturn = true;
            $(".stepInfo_y li").height($("#stepfg").height());
        });

    });

</script>
<script>
    var map = new BMap.Map("locationmap", {
        minZoom: 4,
        maxZoom: 20
    }); // 创建Map实例
    map.setCurrentCity("邯郸"); // 设置地图显示的城市 此项是必须设置的
    map.enableScrollWheelZoom(true); //开启鼠标滚轮缩放
    //map.centerAndZoom("邯郸",13);         ///当前地方与等级
    map.centerAndZoom("邯郸", 10);


    var myIcon = new BMap.Icon(
            "http://cdn-img.easyicon.net/png/11298/1129853.gif",
            new BMap.Size(25, 25));
    map.centerAndZoom("邯郸", 10); // 初始化地图,设置中心点坐标和地图级

    var p1;
    var p2;
    var poline = [];
    if ($("#ISLBS").val() == "true") {
        searchLocation();
    }else{
    	loadMap();
    }
    function searchLocation() {
        var datainfo = {
            orderNo: "${orderinfo.orderno}"
        };
        $.ajax({
            url: "${wlpt}/wlpt/lbsinfo/getlocation",
            type: "POST",
            data: datainfo,
            async: false,
            success: function (data) {
                $("input[name=loctPhone]").val(data.localphone);
                if (data.state==1) {
                	var list = data.data.list;
                    var html = "";
                    /* $("#licont").nextAll().remove(); */

                    for (var i = 0; i < list.length; i++) {
                        /* html += fillOneData(list[i]); */
                        ///定位的位置是有偏差的所以进行了移动
                        p2 = new BMap.Point(
                                list[list.length - 1].lng,
                                list[list.length - 1].lat);
                        p1 = new BMap.Point(list[0].lng,
                                list[0].lat);
                        var firstpoint = new BMap.Point(
                                list[list.length - 1].lng,
                                list[list.length - 1].lat);
                        map.centerAndZoom(firstpoint, 10); // 初始化地图,设置中心点坐标和地图级别
                        var point = new BMap.Point(
                                list[i].lng,
                                list[i].lat);
                        poline.push(new BMap.Point(
                                list[i].lng,
                                list[i].lat));//折线
                        addMarker(point,
                                list[i].createtime, i,
                                list.length);
                    }
                    //当没有数据的时候以邯郸为中心
                    if (list.length <= 0) {
                        map.centerAndZoom("邯郸", 10); // 初始化地图,设置中心点坐标和地图级别
                    }
                    /* $("#ltcont li").first().nextAll().remove();
                    $("#ltcont li").first().css("display", "none");
                    $("#licont").after(html);
                    $("#allcount").html(data.allcount);
                    $("#pageCount").html(data.pageCount);
                    $("#curPage").html(data.curPage); */
                } else {
                    /* $("#ltcont li").first().css("display", "none"); */
                    map.centerAndZoom("邯郸", 10); // 初始化地图,设置中心点坐标和地图级别
                }
            },
            error: function () {
                map.centerAndZoom("邯郸", 10); // 初始化地图,设置中心点坐标和地图级别
            }
        });
        var polyline = new BMap.Polyline(poline, {
            strokeColor: "blue",
            strokeWeight: 2,
            strokeOpacity: 0.5
        }); //创建折线
        // 编写自定义函数,创建标注
        function addMarker(point, info, curindex, maxindex) {
            var marker = new BMap.Marker(point);
            var opts = {
                position: point, // 指定文本标注所在的地理位置
                offset: new BMap.Size(20, -20)
                //设置文本偏移量
            };
            var label = new BMap.Label(info, opts); // 创建文本标注对象
            label.setStyle({
                color: "blue",
                fontSize: "12px",
                height: "20px",
                lineHeight: "20px",
                fontFamily: "微软雅黑"
            });
            marker.setLabel(label);
            map.addOverlay(marker);
            /* if(curindex==0||curindex>=maxindex){
             marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
             var marker2 = new BMap.Marker(point,{icon:myIcon});  // 创建标注
             map.addOverlay(marker2);              // 将标注添加到地图中
             //map.addOverlay(polyline);   //增加折线
             } */
        }

        var driving = new BMap.DrivingRoute(map, {
            renderOptions: {
                map: map,
                autoViewport: true
            }
        });
        driving.search(p1, p2, {
            waypoints: poline
        });//waypoints表示途经点
    }




    
    function loadMap() {
        var btime = "${start}";
        var etime = "${end}";
        if (btime == null || btime == "") {
            //btime = btime.replace(new RegExp("-", "gm"), "/");
            btime = (new Date()).getTime(); //得到毫秒数
        }
        // btime = (new Date(btime)).getTime(); //得到毫秒数
        if (etime == null || etime == '') {
            etime = (new Date()).getTime(); //得到毫秒数
        }
        var data = {};
        data.version = 1;
        data.method = 'loadHistory';
        data.vid = "${gpsCar.cid}";
        data.vKey = "${gpsCar.ckey}";
        data.bTime = btime;
        data.eTime = etime;
        $.ajax({
            type: "get",
            url: "http://219.148.85.56:89/gpsonline/GPSAPI",
            data: data,
            dataType: "json",
            success: function (data) {
                if (data.history && data.history.length > 0) {
                    //设置地图中心点
                    var lng = data.history[0].lng
                            + data.history[0].lng_xz;
                    var lat = data.history[0].lat
                            + data.history[0].lat_xz;

                    var arrPois = [];
                    for (var i = 0; i < data.history.length; i++) {
                        var x = data.history[i].lng
                                + data.history[i].lng_xz;
                        var y = data.history[i].lat
                                + data.history[i].lat_xz;
                        arrPois[i] = new BMap.Point(x, y);
                    }

                    map.addOverlay(new BMap.Polyline(arrPois, {
                        strokeColor: '#111'
                    }));
                    var arrStartEnd = [];
                    arrStartEnd[0] = arrPois[0];
                    arrStartEnd[1] = arrPois[1];
                    //map.setViewport(arrStartEnd);
                    map.centerAndZoom(new BMap.Point(lng, lat),
                            14);
                    var lushu = new BMapLib.LuShu(
                            map,
                            arrPois,
                            {
                                defaultContent: "",
                                autoView: true,
                                icon: new BMap.Icon(
                                        '${ctxStatic }/images/cc.png',
                                        new BMap.Size(25, 30),
                                        {
                                            /* anchor: new BMap.Size(
                                                    27, 13) */
                                        }),
                                speed: 4500,
                                enableRotation: true,//是否设置marker随着道路的走向进行旋转
                                landmarkPois: []
                            });
                    lushu.start();

                    $("btn-warning").onclick = function () {
                        lushu.start();
                    };
                    $("stop").onclick = function () {
                        lushu.stop();
                    };
                    $("pause").onclick = function () {
                        lushu.pause();
                    };
                    $("pause").hide();
                    $("hide").onclick = function () {
                        lushu.hideInfoWindow();
                    };
                    $("show").onclick = function () {
                        lushu.showInfoWindow();
                    };
                    $("show").hide();
                    function $(element) {
                        return document.getElementById(element);
                    }
                    ;

                } else {
                    $("#btn-warning").val("无定位信息");
                }

            }
        });
    }

</script>
<script type="text/javascript">
    $(window).load(function () {
        setInterval("timer()", 100);
        window.timer=function(){
            $(".stepInfo_y li").height($("#stepfg").height()-5);
        }
        $("#flexiselDemo1").flexisel();
        $("#flexiselDemo2").flexisel({
            enableResponsiveBreakpoints: true,
            responsiveBreakpoints: {
                portrait: {
                    changePoint: 480,
                    visibleItems: 1
                },
                landscape: {
                    changePoint: 640,
                    visibleItems: 2
                },
                tablet: {
                    changePoint: 768,
                    visibleItems: 3
                }
            }
        });

        $("#flexiselDemo3").flexisel({
            visibleItems: 5,
            animationSpeed: 1000,
            autoPlay: true,
            autoPlaySpeed: 3000,
            pauseOnHover: true,
            enableResponsiveBreakpoints: true,
            responsiveBreakpoints: {
                portrait: {
                    changePoint: 480,
                    visibleItems: 1
                },
                landscape: {
                    changePoint: 640,
                    visibleItems: 2
                },
                tablet: {
                    changePoint: 768,
                    visibleItems: 3
                }
            }
        });

    });


    $('.example1').wmuSlider();

</script>
</body>
</html>