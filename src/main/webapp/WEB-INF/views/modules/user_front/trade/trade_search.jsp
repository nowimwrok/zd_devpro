<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head lang="en">
    <!-- <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_default_basic"/>
    <title>运单查询</title> -->
    <meta charset="UTF-8">
		<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
		<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1"/>
		<title>运单查询</title>
		<meta name="decorator" content="site_web_newbasic"/>
   <link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/banner.css"> 
   <link rel="stylesheet" href="${ctxStatic}/front/css/add.css?id=2" />
   <script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/front/js/angular.min.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/jquery.magnific-popup.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/jquery.hoverdir.js"></script>


<script src="${ctxStatic}/modules/wlpt/front/js/jquery.magnific-popup.js" type="text/javascript"></script>
<script type="text/javascript"
        src="http://api.map.baidu.com/api?v=2.0&ak=80f73f31cfbb40be26acda67af03da43"></script>
<script type="text/javascript"
		src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>

<link rel="stylesheet"
		href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css" />        
<script type="text/javascript"
        src="http://api.map.baidu.com/library/LuShu/1.2/src/LuShu_min.js"></script>
        
<script type="text/javascript" src="${ctxStatic}/office/js/index.js"></script> 
<script
        src="${ctxStatic}/modules/wlpt/front/js/My97DatePicker/WdatePicker.js"></script>
 
    <style type="text/css">
       /* .container {
            width: 80%;
            padding-right: 0px;
            padding-left: 0px;
            text-align:center;
        }

        .wrap {
            width: 60%;
            text-align:center;
        }

        footer {
            width: 90%;
            /* margin-top: 80px; */
            /*clear: both;
            background-color: #363E41;
            padding-bottom: 2%;
            text-align:center;
        }*/
        
    </style>
    

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
        .contact{padding:0 15px;}
		.footer p, .footer a{margin-bottom:10px;}
		.contact i,.contact p,.copy span,.copy p{text-align:left;}
		.copy div{text-align:left;}
		.car_track_play .close{position:absolute;top:-3px;font-size:20px;}
		.car_track_play{height:54px;bottom:-93%;}
		.play_time input{box-shadow:none;-webkit-box-shadow:none;background-color:#f6f6f6!important;}
		.play_btn .glyphicon{top:5px}
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
            <div class="stepIco_y" ng-repeat="x in data" >
            	<p style="display: none;" id="yundan">{{x}}</p>
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
    <div class="shadow_right" style="position:relative">
        <div style="width:100%;height: 400px;" id="locationmap"></div>
        <c:if test="${islbs != 'true' }">
        <div class="playShow" id="guijiShow" style='text-align: center;margin-top: 20px;position:relative;'>
            <button style="width: 110px" class="btn btn-defalut btn-warning" id="btn-warning" >开始轨迹回放</button>
		  
        </div>
        </c:if>
          <div class="car_track_play">
		                			<button class="close text-center" id="we">x</button>
		                			<div class="col-sm-12 clearfix play_time">
						                    <input type="text" readonly="readonly" class="form-control pull-left"
						                           name="beginCreateDate" id="beginCreateDate" 
						                           placeholder="选择开始时间"
						                           onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
						                    <input type="text" readonly="readonly" class="form-control pull-right"
						                           name="endCreateDate" id="endCreateDate" 
						                           placeholder="选择结束时间"
						                           onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
		                				<!-- <input type="text" placeholder="请选择开始时间" class="form-control pull-left"/>
		                				<input type="text" placeholder="请选择结束时间" class="form-control pull-right"/> -->
		                				<span class="play_btn text-center" onclick="getCarGpsinfo()"><i class="glyphicon glyphicon-play"></i></span>
		                			</div>
		      </div>
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
                         src="${ctxStatic}/images/weixin/ic_start.png">
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
                         src="${ctxStatic}/images/weixin/ic_end.png">
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
                <fmt:formatDate value="${orderinfo.quoteinfo.goods.sendtime }" pattern="yyyy-MM-dd HH:mm:ss"/>
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
<%-- <div class="main">
    <div class="clients">
        <div class="wrap">
            <h2 class="head" style="text-align: center;">战略合作伙伴</h2>
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
</div> --%>
<!--合作伙伴-->
			<div class="partner open_box">
				<h3 class="text-nowrap text-center wow fadeInDown">战略合作伙伴</h3>
				<div class="line"></div>
				<div class="container swiper-container partner-container wow bounceIn">
					<div class="swiper-wrapper">
						<div class="swiper-slide pull-left col-sm-3 col-sx-6 text-center">
							<a><img src="${ctxStatic }/office/img/index/partner_one.png" alt=""/></a>
						</div>
						<div class="swiper-slide pull-left col-sm-3 col-sx-6 text-center">
							<a><img src="${ctxStatic }/office/img/index/partner_two.png" alt=""/></a>
						</div>
						<div class="swiper-slide pull-left col-sm-3 col-sx-6 text-center">
							<a><img src="${ctxStatic }/office/img/index/partner_three.png" alt=""/></a>
						</div>
						<div class="swiper-slide pull-left col-sm-3 col-sx-6 text-center">
							<a><img src="${ctxStatic }/office/img/index/partner_four.png" alt=""/></a>
						</div>
					</div>
					<div class="swiper-button-next er_next"></div>
	        		<div class="swiper-button-prev er_prev"></div>
				</div>
			</div>
<!-- jQuery -->
   <script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.flexisel.js"></script>
   <script src="${ctxStatic}/modules/wlpt/front/js/jquery.wmuSlider.js"></script>
   <script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/common/global.js"></script>
<script type="text/javascript">

	//显示隐藏底下内容
	/* $('.map_r .closeAll').click(function(){
		$('.map_r').hide(500);
		$('.toggle_msg').show(500);
	});
	$('.toggle_msg').click(function(){
		$('.map_r').show(500);
		$('.toggle_msg').hide(500);
	}); */
	$('.playShow').click(function(){
		$('#beginCreateDate').val(btime);
		$('#endCreateDate').val(etime);
	   $('.car_track_play').show(500);
	})
	$('#we').click(function(){
	   $('.car_track_play').hide(500);
	   
	})
	
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
var btime="";
var etime="";
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




    //页面载入定位地图标记出红色坐标点
    function loadMap(data,type) {
    	map.clearOverlays();
    	var myIcon = new BMap.Icon(
                "${ctxStatic }/images/cc.png",
                new BMap.Size(50, 55));
    	if(type==1){
    		myIcon = new BMap.Icon("${ctxStatic}/front/img/carwz.png", new BMap.Size(30, 50));
    	}

        if (data ) {
    		
        	$.each(data, function (i, item) {
        		
        		if(item.carLocs!=null){
        			
	        		var point = new BMap.Point(item.carLocs.lng*1, item.carLocs.lat*1), marker = new BMap.Marker(point,{icon:myIcon});
	        		
		            marker.addEventListener('click', showInfos);
		           
		            function showInfos() {
		                var gpstimes;
		                var addressinfo;
		                var phone;
		                if(item.carLocs.formatgpstime){
		                    gpstimes=item.carLocs.formatgpstime;
		                }else {
		                    gpstimes='无定位时间';
		                }
		                if(item.carLocs.info){
		                	addressinfo=item.carLocs.info;
		                }else {
		                	addressinfo='当前无定位';
		                }
		                if(item.carLocs.mobile){
		                	phone=item.carLocs.mobile;
		                }else{
		                	phone="无联系方式";
		                }
							//最后定位时间：' + gpstimes + '
		                var content = '<p style="width:280px;margin:0;line-height:20px;">联系方式：' + phone + ' <br/> 车辆状态：' + item.carLocs.state + ' <br/>地址：' + addressinfo + '<br/>最后定位时间：' + gpstimes + '<br/>  </p>';
		
		                //创建检索信息窗口对象
		                var searchInfoWindows = new BMapLib.SearchInfoWindow(map, content, {
		                    title: item.carLocs.name, //标题
		                    width: 300, //宽度
		                    height: 120, //高度
		                    panel: "panel", //检索结果面板
		                    enableAutoPan: false, //自动平移
		                    enableSendToPhone: false, //是否显示发送到手机按钮
		                    searchTypes: []
		                });
		                searchInfoWindows.open(marker);
		            }
		            map.addOverlay(marker);

        		}
        		////////////////////////北斗显示
        		if(item.adr!=null){
        			
	        		var point = new BMap.Point(item.lon/600000, item.lat/600000), marker = new BMap.Marker(point,{icon:myIcon});
	        		
		            marker.addEventListener('click', showInfos);
		            function showInfos() {
		            	
		                var gpstimes;
		                var addressinfo;
		                var phone;
		                if(item.utc!=null){
		                    
		                    var timestr=item.utc;
              				gpstimes = new Date();
              				gpstimes.setTime(timestr);
		                }else {
		                    gpstimes='无定位时间';
		                }
		                if(item.adr!=null){
		                	addressinfo=item.adr;
		                	
		                }else {
		                	addressinfo='当前无定位';
		                }
							//最后定位时间：' + gpstimes + '
		                var content = '<p style="width:280px;margin:0;line-height:20px;">'  + ' <br/> 车辆状态：' + item.spd + 'km/小时 <br/>地址：' + addressinfo + '<br/>最后定位时间：' + gpstimes.toLocaleString() + '<br/>  </p>';
						
		                //创建检索信息窗口对象
		                var searchInfoWindows = new BMapLib.SearchInfoWindow(map, content, {
		                    title: "北斗定位位置", //标题
		                    width: 300, //宽度
		                    height: 120, //高度
		                    panel: "panel", //检索结果面板
		                    enableAutoPan: false, //自动平移
		                    enableSendToPhone: false, //是否显示发送到手机按钮
		                    searchTypes: []
		                });
		                searchInfoWindows.open(marker);
		            }
		            map.addOverlay(marker);
		            

        		}
        	});
        }
    }
    
   	//轨迹回放地图展示回放动画
    function renderMaplist(date){
   	 map.clearOverlays();
		
	 	var state= date.state;
	   	var data=date.data; 
		//////////////////////////////////////////// 状态码1 就调用 zjxl的解析轨迹方法
		if( state==1 || data.length>0){
		var datazjxl=data.TrackVcl;
		 //设置地图中心点
        var lng = datazjxl[0].lon/600000;
        var lat = datazjxl[0].lat/600000;
		console.log(lng,lat);	
        var arrPois = [];
        for (var i = 0; i < datazjxl.length; i++) {
            var x = datazjxl[i].lon/600000;
            var y = datazjxl[i].lat/600000;
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
                            '${ctxStatic }/images/car.png',
                            new BMap.Size(50, 55),
                            {
                                /* anchor: new BMap.Size(
                                        27, 13) */
                            }),
                    speed: 4500,
                    enableRotation: true,//是否设置marker随着道路的走向进行旋转
                    landmarkPois: []
                });
        lushu.start();
        $("btn-start").onclick = function () {
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
       
	}
   	 ///////////////////////////////////////状态码为2就调用永奎解析轨迹方法
   	 if (state==2 || data.length>0) {
   			var maplist=data.mapListJson;
            //设置地图中心点
            var lng = maplist[0].REAL_X;
            var lat = maplist[0].REAL_Y;

            var arrPois = [];
            for (var i = 0; i < maplist.length; i++) {
                var x = maplist[i].REAL_X;
                var y = maplist[i].REAL_Y;
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
                                '${ctxStatic }/images/car.png',
                                new BMap.Size(50, 55),
                                {
                                    /* anchor: new BMap.Size(
                                            27, 13) */
                                }),
                        speed: 4500,
                        enableRotation: true,//是否设置marker随着道路的走向进行旋转
                        landmarkPois: []
                    });
            lushu.start();
            $("btn-start").onclick = function () {
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
        }
   }
   	
    /**
     * 渲染地图模式
     * @param result
     * @param page
     */
    function renderMap(res) {
        map.clearOverlays();

        if (res.length == 0) {
            alert("未找到查找的车辆");
            return;
        }
        var myIcon = new BMap.Icon("${ctxStatic}/front/img/carwz.png", new BMap.Size(30, 50));

        var point = new BMap.Point(res.REAL_X, res.REAL_Y), marker = new BMap.Marker(point, {icon: myIcon});
        map.centerAndZoom(point, 10); // 初始化地图,设置中心点坐标和地图级
        marker.addEventListener('click', showInfo);
        function showInfo() {
            var gpstime;
            if (res.RECEIVE_TIME) {
                gpstime = res.RECEIVE_TIME;
            } else {
                gpstime = '无定位时间';
            }


            var content = '<p style="width:280px;margin:0;line-height:20px;"> 车辆状态：' + res.DRIVING_STATE + ' <br/>速度：' + res.SPEED + '公里/小时  <br/> 最后定位时间：' + gpstime + ' </p>';

            //创建检索信息窗口对象
            var searchInfoWindow = new BMapLib.SearchInfoWindow(map, content, {
                title: res.LICENSE_PLATE, //标题
                width: 300, //宽度
                height: 120, //高度
                panel: "panel", //检索结果面板
                enableAutoPan: false, //自动平移
                enableSendToPhone: false, //是否显示发送到手机按钮
                searchTypes: []
            });
            searchInfoWindow.open(marker);
        }

        map.addOverlay(marker);


    };
  //将经纬度转为地址
    function map_click(lng,lat){ 
    	var address = "";
		var point = new BMap.Point(lng,lat); 
		var geoc = new BMap.Geocoder(); 
		geoc.getLocation(point,function(rs){ 
		var addComp = rs.addressComponents; 
		address = addComp.province + " " + addComp.city + " "+ addComp.district + " "+ addComp.street + " " + addComp.streetNumber; 
		$("#x_address").html("位置："+address);
		});
	}
   	window.onload=function () {
   		console.log($("#yundan").text());
   		var status = '${fns:getUser().loginName==null or fns:getUser().loginName eq ''}';
   		if(status != 'true'){
   	   		var orderno='${orderinfo.orderno}';
   	   		var carnumber='${orderinfo.quoteinfo.car.carnumber}';
   	    	$.MsgBox.Confirm("提示信息", "平台运输轨迹包含收费服务，使用将收取服务费用<a style='color:red'>${fns:getMsgLabel('zjxl006','zjxl_port','')}元</a>，请仔细阅读<a target='_blank' onclick='openagreement(&quot;LocationService&quot;)' style='line-height: 30px;text-decoration: none;'>《平台定位增值服务协议》</a>，是否使用？", function () {            $("#maskloading", parent.document).show();
   	        	newtime=new Date().getHours();
   	        	$('.map_r').hide();
   	          	$("#maskloading" , parent.document).show();
   	              $.ajax({
   	                  url: "${wlpt}/wlpt/trade/carAndTradeInfo",
   	                  data: {
   	                	  orderNos:orderno,
   	                	  carNumber:carnumber,
   	                	  newtime:newtime
   	                  },
   	                  dataType: 'json',
   	                  cache: false,
   	                  success: function (date) {
   	                	  $("#maskloading" , parent.document).show();
   	                	 var state=date.value.state;
   	                	 var data=date.value.data;
   	                     var orderdata = data[1];
   	                	 if(state==2){
   	                		 
   	                	  var datalist = data[0][0]; 
   	                	 }
   	                      if(orderno!=""&&orderno!=''&&orderno!=undefined){
   	                    	  $("#ordernotext").html("<b>运单号：</b>"+orderno);
   	                      }else{
   	                    	  $("#ordernotext").html("");
   	                      }
   	                	  if(state!=5){//判断是否扣费成功
   	                      if(carnumber==""||carnumber==''||carnumber==undefined){
   	                    	  $.MsgBox.Alert("系统提示", "未绑定车辆信息");
   	                      }else{
   	                    	  if(data[2] != null && data[2][0] != null){
   	    	                	  $("#carnumbertext").html(carnumber);
   			                  		if(data[2][0].carLocs != null){
   			                  			loadMap(data[2],1);
   				                    		$("#datetext").html((" "+data[2][0].carLocs.formatgpstime).substring(0, 11));
   				  	                  	    $("#timetext").html((data[2][0].carLocs.formatgpstime).substring(10, 19));
   				  	                  	    //$("#drivingstatetext").html(data.value[2][0].carLocs.state);
   				  	                  	    $("#speedtext").html("<b >"+data[2][0].carLocs.speed+"km/</b>小时");
   				  	                  	    map_click(data[2][0].carLocs.lng*1, data[2][0].carLocs.lat*1);
   				                        	lng = data[2][0].carLocs.lng*1;
   				    	                	lat = data[2][0].carLocs.lat*1;
   				    	                	speed = data[2][0].carLocs.speed;
   			                  		}else{
   			                  			$.MsgBox.Alert("系统提示", "该车辆无定位信息");
   			                  		}
   	    	                	  
   	    	                  }else{
   	    	                	  	
   	    	                	  	if(datalist!=null){                                 //调用永奎
   	    		                  		
   	    	                	  		  renderMap(datalist);
   	    	    	                	  $("#datetext").html((" "+datalist.RECEIVE_TIME).substring(0, 11));                        //lbs
   	    	    	                	  $("#timetext").html((datalist.RECEIVE_TIME).substring(10, 19));
   	    	    	                	  $("#carnumbertext").html(datalist.LICENSE_PLATE);
   	    	    	                	  //$("#drivingstatetext").html(datalist.DRIVING_STATE);
   	    	    	                	  $("#speedtext").html("<b >"+datalist.SPEED+"公里/</b>小时");
   	    	    	                	  map_click(datalist.REAL_X, datalist.REAL_Y);
   	    	    	                	  lng = datalist.REAL_X;
   	    	    	                	  lat = datalist.REAL_Y;
   	    	    	                	  speed = datalist.SPEED;
   	    		                  		
   	    		                  	}else{
   	    		                  			//调用北斗
   		    	                  			var LocationVcln=data[3].LocationVcln.LocationVcln;
   	    		                  			loadMap(data[3].LocationVcln,1);
   	    		                  			if( LocationVcln!=null && LocationVcln.hasOwnProperty('utc')){
   	    		                  				
   	    		                  				var timestr=parseInt(LocationVcln.utc);
   	    		                  				var newDate1 = new Date();
   	    		                  				newDate1.setTime(timestr);
   	        	                  				$("#carnumbertext").html(carnumber);
   	        	                  				$("#datetext").html(newDate1.toLocaleString());
   	        	                  				$("#speedtext").html("<b >"+LocationVcln.spd+"km/</b>小时");
   	        	                  				lat=LocationVcln.lat/600000;                                          //北斗接口返回的经纬度需要除以600000 才能使用
   	        	                  				lng=LocationVcln.lon/600000;
   	        	                  				map_click(lng,lat);
   	        	                  				speed=LocationVcln.spd;
   	    		                  			}else{
   	    		                  				$.MsgBox.Alert("系统提示", "该车辆无定位信息");
   	    		                  			}
   	    		                  			
   	    		                  		}
   	    		                  		
   	    		                  	}
   	    	                	
   	                      		}
   	                      
   	                      if(orderdata!=null){
   	                    	  if(orderdata.quoteinfo.driver!=null){
   	                    		  $("#drivername").html(orderdata.quoteinfo.driver.name);
   	                              $("#driverphone").html(orderdata.quoteinfo.driver.phone);
   	                              $("#x_name").html(orderdata.quoteinfo.driver.loginName);
   	                    	  }
   	                   		  $("#locCount").html(orderdata.locCount);
   	                   		  $("#trailCount").html(orderdata.trailCount);
   	                    	  $("#x_tradestatus").html(orderdata.statusStr);
   	                    	  $("#x_carnumber").html(carnumber);
   	                    	  
   	                    	  $("#x_orderno").html(orderdata.orderNo);
   	                    	  $("#x_goodsname").html("货物："+orderdata.quoteinfo.goods.goodsname);
   	                    	  $("#x_freightvolume").html("运量："+orderdata.quoteinfo.actload+"吨");
   	                    	  $("#x_consignaddress").html("卸货地址："+orderdata.quoteinfo.goods.consignAddress.province+orderdata.quoteinfo.goods.consignAddress.city+orderdata.quoteinfo.goods.consignAddress.district);
   	                    	  btime = orderdata.createDate;
   	                      	  if (orderdata.orderstatus == 4 || orderdata.orderstatus == 5) {
   	                      	     etime = orderdata.updateDate;
   	                      	  }else if(orderdata.orderstatus == 3 || orderdata.orderstatus == 6 || orderdata.orderstatus == 7){
   	                      		 etime = new Date().toLocaleDateString(); 
   	                      	  }else{
   	                      		etime = orderdata.createDate;
   	                      	  }
   	                    	  
   	                      }
   	                      $('.map_r').show();
   	                 	 $("#maskloading" , parent.document).hide();
   	                	  }else{
   	                      	$("#maskloading" , parent.document).hide();
   	                      	$.MsgBox.Alert("系统提示", "余额不足请充值");
   	                      }	
   	                  }
   	              });
   	        }, function () {
   	        }, "是", "否");
   		}else{
   			$.MsgBox.Alert("系统提示", "请先登录账号");
   		}

    };	
    
    //查询轨迹方法
    window.getCarGpsinfo = function () {     
    	
    	var status = '${fns:getUser().loginName==null or fns:getUser().loginName eq ''}';
   		if(status != 'true'){
   		btime=$("#beginCreateDate").val();
        etime=$("#endCreateDate").val();
        if(btime<etime){
        	
		   	$.MsgBox.Confirm("提示信息", "平台运输轨迹包含收费服务，使用将收取服务费用<a style='color:red'>${fns:getMsgLabel('zjxl009','zjxl_port','')}元</a>，请仔细阅读<a target='_blank' onclick='openagreement(&quot;LocationService&quot;)' style='line-height: 30px;text-decoration: none;'>《平台定位增值服务协议》</a>，是否使用？", function () {
		        $("#maskloading" , parent.document).show();
		   		orderno='${orderinfo.orderno}';
		       	carnumber='${orderinfo.quoteinfo.car.carnumber}';
		        //btime = '${orderinfo.createDate}';
		   		var newDate1 = new Date();
		   		var timestamp2 = Date.parse(new Date(btime));
		   		var sixtime=newDate1-timestamp2
		   		var timestamp3=6*30*24*60*60*1000;
		   		if(sixtime<timestamp3){
		   		
		             $.ajax({
		                 url: "${wlpt}/wlpt/trade/getCarGpsInfo",
		                 data: {
		               	  orderNos:orderno,
		               	  carnumber:carnumber,
		                  beginTime:btime,
		                  endTime: etime 
		               	 
		                 },
		                 dataType: 'json',
		                 cache: false,
		                 success: function (date) {
		                	var data=date.value.data;
		                 	var state=date.value.state;
		                 	console.log(data);
		                 	console.log(state);
		                 	  if(state!=5){               
		 	                                       //状态码5是余额不足  1是中兴的数据  2 是永奎数据
		 	                	  $("#maskloading" , parent.document).hide();
		                 		 if(data!=""&&data!=null){
		                 			 renderMaplist(date.value);
		                 		 }else{
		                 			 $.MsgBox.Alert("系统提示", "该车辆暂无轨迹信息");
		                 		 }
		                 	  }else{
		                     	$("#maskloading" , parent.document).hide();
		                       	$.MsgBox.Alert("系统提示", "账号余额不足请充值");
		                       }
		                 }	  
		             });
		   	}else{
		   		 $("#maskloading" , parent.document).hide();
		   		$.MsgBox.Alert("系统提示","轨迹信息为半年以内数据，此轨迹信息已失效");
		   	}
			}, function () {
		       }, null, null, "是", "否");  
       	   }else{
       			$.MsgBox.Alert("系统提示", "您选择的开始时间大于结束时间，请重新选择！");
       	   }
	   	 }else{
	   		$.MsgBox.Alert("系统提示", "请先登录账号");
	   	 }
   };
    

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
    
  //合作伙伴轮播
		var swiper2 = new Swiper('.partner-container', {
	        nextButton: '.er_next',
    		prevButton: '.er_prev',
    		loop:true,
    		autoplay:2000,
    		speed:1000,
	        paginationClickable: true,
	        slidesPerView: 4,
	        spaceBetween:0,
	        breakpoints:{
	        	500:{
	        		slidesPerView:2,
	        	}
	        }
	});

		//wow 动画
	    if (!(/msie [6|7|8|9]/i.test(navigator.userAgent))){
			new WOW().init();
		};
</script>
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
      //微信app悬浮
    	$('.wechat').hover(function(){
    		$('.wechat_hover').fadeIn();
    	},function(){
    		$('.wechat_hover').fadeOut();
    	});
    	$('.app').hover(function(){
    		$('.app_hover').fadeIn();
    	},function(){
    		$('.app_hover').fadeOut();
    	});
    </script>
</body>
</html>