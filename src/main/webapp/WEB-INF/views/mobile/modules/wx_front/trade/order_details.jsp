<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<html>
<head>

<title>${fns:getConst('SYSTEMTITLE')}--运单详情</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">

<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/errorpage.js"></script>
<script>
	var _hmt = _hmt || [];
	(function() {
		var hm = document.createElement("script");
		hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
		var s = document.getElementsByTagName("script")[0];
		s.parentNode.insertBefore(hm, s);
	})();
</script>

<link href="${ctxStatic }/weixin/css/base.css" rel="stylesheet" type="text/css">
<link href="${ctxStatic }/weixin/css/global.css" rel="stylesheet" type="text/css">

<style type="text/css">
/*整体div -top布局*/
.data_top,.data_bottom {
	width: 100%;
	display: block;
	z-index: 2;
	position: fixed;
	background-color: #FFF;
}

.data_top div {
	float: left;
	height: 50px;
	line-height: 50px;
}

.dt_top,.data_tab {
	clear: both;
	width: 100%;
}

.dt_top {
	height: 40px;
	line-height: 40px;
}

.dt_top div {
	
}

.data_tab div {
	width: 33.33%;
	text-align: center;
}

.data_tab {
	border-bottom: 1px solid rgb(369, 218, 463);
}

.bord_rt {
	border-right: 1px solid #CCC;
}

/* 数据中部信息 */
.data_box {
	width: 97%;
	margin: 0 auto;
	padding-top: 50px;
	margin-bottom: 50px;
}

.data_title {
	clear: both;
	font-size: 16px;
	background: #EBEBEB;
	height: 40px;
	line-height: 40px;
	width: 100%;
	text-indent: 10px;
}

.data_cent {
	width: 96%;
	padding: 5px 0px;
	padding-left: 4%;
}

.ct_lf {
	width: 100%;
	height: 30px;
	margin-top: 10px;
	display: table;
}

.ct_lf div {
	float: left;
	margin-right: 5px;
	line-height: 30px;
	display: table-cell;
	vertical-align: middle;
	display: table-cell;
	font-size: 16px;
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
	width: 15%;
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
}

.val_info {
	width: 30%;
}

.disnone {
	display: none;
}

.img_text {
	font-size: 1em;
	width: 60px;
	text-align: center;
	background-image: url(${ctxStatic }/images/weixin/pic_bg_normal.png);
	height: 60px;
	background-repeat: no-repeat;
	line-height: 35px;
	background-size: 60px;
	margin: 5%;
	float: left;
	cursor: pointer;
	position: relative;
	clear: both;
}

.img_text img {
	width: 60px;
	height: 60px;
}

.img_t {
	color: rgba(37, 35, 35, 0.57);
	position: absolute;
	bottom: 0px;
	width: 60px;
	height: 35px;
}

.upimg {
	width: 60px;
	height: 60px;
}

#imgCredit {
	margin-top: 15px;
}

.up_ct {
	clear: both;
	width: 100%;
	margin-top: 10px;
	height: 50px;
}

.data_bottom {
	bottom: 0px;
	height: 40px;
	line-height: 40px;
	text-align: right;
	background: rgba(241, 234, 234, 0.67);
}

.timeline-content {
	width: 95%;
	padding-bottom: 0px;
}

.timeline-content p {
	width: 100%;
	border-top: 1 solid #CCC;
	padding-top: 5px;
}

.in_txt {
	border-bottom: 1px solid #CCC;
	height: 40px;
	font-size: 16px;
	width: 50%;
}

.btnclass {
	width: 95%;
	height: 50px;
	font-size: 1.2em;
	text-align: center;
	line-height: 45px;
	margin: 0 auto;
	margin-top: 20px;
	font-weight: bold;
	color: #FFF;
	background-color: rgb(32, 134, 226);
	letter-spacing: 10px;
	/* clear: both; */
}
</style>
</head>
<body scroll="no" ng-app="dataHall" ng-controller="dataHallCtrl">
	<div class="data_top">
		<div class="data_tab" style="width:100%;padding:0px;">
			<div class="selected">运单信息</div>
			<div>运输轨迹</div>
			<div style="float:right">运输凭据</div>
		</div>
	</div>
	<!-- data_top end -->
	<div class="data_box data_box0">
		<!-- <div class="data_title">运单处理过程</div> -->
		<div class="data_cent">
			<div class="container">
				<div id="timeline">
					<div class="timeline-item">
						<div class="timeline-icon">
							<img
								src="${ctxStatic }/images/weixin/goods_owner.png"
								alt="货主">
						</div>
						<div class="timeline-content">
							<h2>发布货源</h2>
							<div class="ct_lf">
								<div class="cb_tle">
									<div class="ic_img">
										<img alt="货物"
											src="${ctxStatic }/images/weixin/ic_goods.png">
									</div>
								</div>
								<div class="cb_val">
									<div>${orderinfo.quoteinfo.goods.goodsname }</div>
									<div>
										<span id="goods_loadweights">${orderinfo.quoteinfo.goods.freightvolume }</span>${orderinfo.quoteinfo.goods.freightunit}
									</div>
									<%-- <div>
										￥<span id="goods_money">${orderinfo.quoteinfo.goods.worth }</span>
									</div> --%>
								</div>
							</div>
							<div class="ct_lf">
								<div class="cb_tle">
									<div class="ic_img">
										<img alt="始发地" style="width:20px;margin-right:4px;"
											src="${ctxStatic }/images/weixin/ic_start.png">
									</div>
									<!--ic_img end  -->
								</div>
								<div class="cb_val" id="fromAddress">
									${orderinfo.quoteinfo.goods.shipAddress.province}
			                        ${orderinfo.quoteinfo.goods.shipAddress.city}
			                        ${orderinfo.quoteinfo.goods.shipAddress.district}</div>
								</div>
							<!--ct_lf end  -->
							<div class="ct_lf">
								<div class="cb_tle">
									<div class="ic_img">
										<img alt="目的地" style="width:20px;margin-right:4px;"
											src="${ctxStatic }/images/weixin/ic_end.png">
									</div>
									<!--ic_img end  -->
								</div>
								<div class="cb_val" id="toAddress">
									${orderinfo.quoteinfo.goods.consignAddress.province}
			                        ${orderinfo.quoteinfo.goods.consignAddress.city}
			                        ${orderinfo.quoteinfo.goods.consignAddress.district}
								</div>
							</div>
							<p><fmt:formatDate value="${orderinfo.quoteinfo.goods.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
						</div>
					</div>

					<div class="timeline-item">
						<div class="timeline-icon">
							<img
								src="${ctxStatic }/images/weixin/car_owner.png"
								alt="司机">
						</div>
						<div class="timeline-content right">
							<h2>车主抢单</h2>
							<div class="ct_lf">
								<div class="cb_tle">
									<div class="ic_img">
										<img alt="车辆"
											src="${ctxStatic }/images/weixin/home_mycars_img.png">
									</div>
								</div>
								<div class="cb_val">
									<div>${orderinfo.quoteinfo.car.carnumber}</div>
									<div>${orderinfo.quoteinfo.car.cartype}</div>
									<div>
										<span id="cars_carlength">${orderinfo.quoteinfo.car.carlength}</span>米
									</div>
									<div>
										<span id="cars_loadweight">${orderinfo.quoteinfo.oddloadweight}</span>吨
									</div>
									<c:if test="${orderinfo.quoteinfo.isreload==1 }">
									<div>
										<span id="cars_loadweight">实际配载：${orderinfo.quoteinfo.actload}</span>吨
									</div>
						            </c:if>
									<div>
										<span id="cars_loadweight">报价：${orderinfo.quoteinfo.ooferprice}</span>元/吨
									</div>
									
									
								</div>
							</div>
							<!--ct_lf end  -->
							<div class="ct_lf">
								<div class="cb_tle">
									<div class="ic_img">
										<img alt="司机"
											src="${ctxStatic }/images/weixin/icon_finddriver.png">
									</div>
								</div>
								<div class="cb_val">
									<div>${orderinfo.quoteinfo.driver.loginName}</div>
									<div>${orderinfo.quoteinfo.driver.phone}</div>
								</div>
							</div>
							<!--ct_lf end  -->
							<p><fmt:formatDate value="${orderinfo.quoteinfo.beginCreateDate }" pattern="yyyy-MM-dd HH:mm:ss"/></p>
						</div>
					</div>
					
					<!-- 生成运单后的操作 -->
					<div class="timeline-item" ng-repeat="x in data">
						<div class="timeline-icon">
							<img
								src="${ctxStatic }/images/weixin/goods_owner.png"
								alt="货主">
						</div>
						<div class="timeline-content">
							<h2>{{x.status}}</h2>
							<div class="ct_lf">
								<div class="cb_tle">
									<div class="ic_img">
										<img alt="运单"
											src="${ctxStatic }/images/weixin/icon_bidding.png">
									</div>
								</div>
								<div class="cb_val">
									<div id="orderNo">{{x.content}}</div>
								</div>
							</div>
							<!--ct_lf end  -->
							<div class="ct_lf">
								<%-- <div class="cb_tle">
									<div class="ic_img">
										<img alt="发货方"
											src="${ctxStatic }/images/weixin/icon_goods_statitions.png">
									</div>
								</div>
								<div class="cb_val">
									<div>{{x.createBy.loginName}}</div>
								</div> --%>
							</div>
							<!--ct_lf end  -->
							<p>{{x.createDate}}</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 轨迹回放 -->
	<!-- data_box end -->
	<div class="data_box data_box1 disnone">
		<!-- <div class="data_title">运单运输轨迹</div> -->
		<div style='position: absolute;z-index: 99999'>
			<button id="run">开始轨迹回放</button>
		</div>
		<input type="hidden" id="CID" value="${gpsCar.cid}" /> <input
			type="hidden" id="CKEY" value="${gpsCar.ckey}" /> <input
			type="hidden" id="CORDERSTATU" value="${orderinfo.orderstatus}" />
		<div class="data_cent" style="height:600px;width:97%;margin:0 auto;"
			id="locationmap"></div>
	</div>
	
	<!-- 运输凭证 -->
	<div class="data_box data_box2 disnone" style="padding-bottom:100px;">
		<div class="data_title">
			提货凭据<input type="hidden" id="id"
				value="${orderinfo.id }" />
		</div>
		<div class="data_cent">
			<div class="ct_lf">
				提货凭据是司机运输提货凭据。为了您的交易安全，请保持单据照片清晰可见，并保留纸质凭据。<input type="hidden"
					id="thisgoodsid" value="${orderinfo.quoteinfo.goods.id}">
			</div>
			<div class="ct_lf" style="width:100%;height:auto;" id='divUpload'>
				<c:choose>
					<c:when test="${empty takeGoods.receiptimg}">
							<c:if test="${orderinfo.seller.id ne fns:getUser().id}">
								<input type="hidden" name="takegoods"
									id="takegoods" value=""/>
								<div style="width:30%;">
									<div class="img_text" id="GReceiptImg"
										onclick="uploadImg('GReceiptImg','takegoods','60','60','tradereceipt')">
										<img class="upimg"
											src="${ctxStatic }/images/weixin/pic_bg_normal.png" />
										<div class="img_t">凭据</div>

									</div>
								</div>
							</c:if>
							<c:if test="${orderinfo.seller.id eq fns:getUser().id}">
								<div class="img_text" id="GReceiptImg">
									<img class="upimg lookimg"
										src="${ctxStatic }/images/weixin/pic_bg_normal.png" />
									<div class="img_t">凭据</div>
								</div>
							</c:if>
					</c:when>
					<c:otherwise>
							<div class="img_text">
								<img class="upimg lookimg"
									src="${takeGoods.receiptimg }" />
							</div>
							<input type="hidden" name="takegoods"
									id="takegoods" value/>
							<c:if test="${orderinfo.seller.id ne fns:getUser().id && (orderinfo.orderstatus==3||orderinfo.orderstatus==1)}">
							<c:if test="${takeGoods.updatecount>0}">
								<div class="img_text" id="GReceiptImg" onclick="uploadImg('GReceiptImg','takegoods','60','60','tradereceipt')"></div>
							</c:if>
							</c:if>
							<span style="padding-left:20px;" id="sendTimeP" ><p><fmt:formatDate value="${orderinfo.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p></span>
					</c:otherwise>
				</c:choose>
			</div>
			<c:if test="${orderinfo.seller.id ne fns:getUser().id }">
				<c:if test="${orderinfo.seller.id ne fns:getUser().id && (orderinfo.orderstatus==3||orderinfo.orderstatus==1)}">
					<div class="sub_btn" id="sub_Googs" style="-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px;">保存货单</div>
				</c:if>
			</c:if>
		</div>
		<div class="data_title">
			上传回单<input type="hidden" id="id"
				value="${orderinfo.id }" />
		</div>
		<div class="data_cent">
			<div class="ct_lf">电子凭据是司机运输完成的凭据。为了您的交易安全，请保持凭据照片清晰可见，并保留纸质凭据。
			</div>
			<div class="ct_lf" style="width:100%;height:auto;" id='divUpload'>
				<c:choose>
					<c:when test="${empty tradeReceipt.receiptimg}">
							<c:if test="${orderinfo.seller.id ne fns:getUser().id}">
								<input type="hidden" name="receipt" id="receipt" />

								<div style="width:30%;">
									<div class="img_text" id="ReceiptImg"
										onclick="uploadImg('ReceiptImg','receipt','60','60','tradereceipt')">
										<img class="upimg"
											src="${ctxStatic }/images/weixin/pic_bg_normal.png" />
										<div class="img_t">凭据</div>
									</div>
								</div>
							</c:if>
							<c:if test="${orderinfo.seller.id eq fns:getUser().id}">
								<div class="img_text" id="ReceiptImg">
									<img class="upimg lookimg"
										src="${ctxStatic }/images/weixin/pic_bg_normal.png" />
									<div class="img_t">凭据</div>
								</div>
							</c:if>
					</c:when>
					<c:otherwise>
							<!-- -当订单的状态为已上传提货单3、4的状态或者是上传回单后 -->
						
							<div class="img_text">
								<img class="upimg lookimg"
									src="${tradeReceipt.receiptimg}" />
							</div>
							<input type="hidden" name="receipt" id="receipt" value />
							<c:if test="${orderinfo.seller.id ne fns:getUser().id && (orderinfo.orderstatus==3||orderinfo.orderstatus==4)}">
							<c:if test="${tradeReceipt.updatecount>0}">
							<div class="img_text" id="ReceiptImg" onclick="uploadImg('ReceiptImg','receipt','60','60','tradereceipt')"></div>
							</c:if>
							</c:if>
							<span style="padding-left:20px;" ><p id="returnTimeP"><fmt:formatDate value="${orderinfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p></span>
							
					</c:otherwise>
				</c:choose>
			</div>
				<c:if test="${orderinfo.seller.id ne fns:getUser().id && (orderinfo.orderstatus==3||orderinfo.orderstatus==4)}">
					<div class="sub_btn" id="sub_Result" style="-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px;">
						<span style="margin-top: -1px;">保存凭据</span>
					</div>
				</c:if>
		</div>
		
		<!-- 争议 -->
		<%-- <c:if
			test="${orderinfo.seller.id eq fns:getUser().id && (orderinfo.orderstatus=='4'||orderinfo.orderstatus=='6')&&orderinfo.isBuyer==false}">
			<div class="data_title">
				发起争议<input type="hidden" id="id"
					value="${orderinfo.id }" />
			</div>
			<div class="data_cent">
				<div class="ct_lf">发起争议是对运价以及运输过程中产生车耗过多等产生双方争议的情况，可提交到平台，由平台专人进行协商，平台将在3个工作日内进行处理。</div>
				<div class="ct_lf" style="width:100%;height:auto;" id='divUpload'>
				</div>
				<c:if test="${orderinfo.seller.id eq fns:getUser().id}">
					<c:if test="${(orderinfo.orderstatus=='4'||orderinfo.orderstatus=='6')&&orderinfo.isBuyer==false}">
						<div class="sub_btn" id="sub_dicpute" style="-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px;">
							<span style="margin-top: -1px;">点我发起争议</span>
						</div>
					</c:if>
				</c:if>
			</div>
		</c:if> --%>

		<div id='loading'
			style='width:100%;vertical-align: middle;text-align:center;height:45px'>
			<div>
				<img src='${ctxStatic }/images/weixin/loading-30x30.gif'>
			</div>
			<div style="font-size:14px;font-weight:bold;" id="loadtext">小卓正在努力加载，请稍等!</div>
		</div>
	</div>
	<!-- box -->

	<%-- <c:if
		test="${orderinfo.seller.id eq fns:getUser().id && result.data.ORDERSTATUS eq 8}">
		<div class="data_top data_bottom" style="line-height:40px;">
			<div id="sub"
				style="width:100%;height:40px;line-height:40px;margin:0px;"
				class="sub_btn">支付运费</div>
		</div>
	</c:if> --%>
	<c:if
		test="${orderinfo.seller.id ne fns:getUser().id  && orderinfo.orderstatus==1}">
		<div class="data_top data_bottom" id="upOrderImg"
			style="line-height:40px;">
			<div style="width:100%;height:40px;line-height:40px;margin:0px;"
				class="sub_btn">请上传提货单</div>
		</div>
	</c:if>
	<c:if
		test="${orderinfo.seller.id ne fns:getUser().id && orderinfo.orderstatus==3}">
		<div class="data_top data_bottom" id="upOrderImg"
			style="line-height:40px;">
			<div style="width:100%;height:40px;line-height:40px;margin:0px;"
				class="sub_btn">请上传回单</div>
		</div>
	</c:if>
	
</body>
<script type="text/javascript" 
	src="${ctxStatic }/weixin/js/jquery-1.7.2.js"></script>
<script type="text/javascript"
	src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" 
	src="${ctxStatic }/weixin/js/weixin/weiXinUpload.js"></script>
<script type="text/javascript"
	src="http://api.map.baidu.com/api?v=2.0&ak=YYnbCRSKd9CGoqfP6PcM5wNo"></script>
<script type="text/javascript"
	src="http://api.map.baidu.com/library/LuShu/1.2/src/LuShu_min.js"></script>
<script type="text/javascript"
	src="${ctxStatic }/modules/wlpt/front/js/jqzoom/underscore.js"></script>
<script type="text/javascript"
	src="${ctxStatic }/modules/wlpt/front/js/jqzoom/pinchzoom.js"></script>

<script src="http://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script src="http://apps.bdimg.com/libs/angular.js/1.4.6/angular.min.js"></script>
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
            'pageNo': $scope.currentPage,
            'pageSize': $scope.pageSize
        }
    }).success(function (response) {
        $scope.data = response.data;
    });
    
});

	$(function() {
		
		////查询地图
		/* var localSearch = new BMap.LocalSearch(map); */
		var map = new BMap.Map("locationmap", {
			minZoom : 4,
			maxZoom : 20
		}); // 创建Map实例
		map.setCurrentCity("邯郸"); // 设置地图显示的城市 此项是必须设置的
		map.centerAndZoom("邯郸", 15);
		map.enableScrollWheelZoom(true); //开启鼠标滚轮缩放
		
		var myIcon = new BMap.Icon(
	            "http://cdn-img.easyicon.net/png/11298/1129853.gif",
	            new BMap.Size(25, 25));
	    map.centerAndZoom("邯郸", 10); // 初始化地图,设置中心点坐标和地图级
		

	    var p1;
	    var p2;
	    var poline = [];
	    /* if ($("#CORDERSTATU").val() != "1") { */
	    	if ($("#ISLBS").val() == "true") {
		        searchLocation();
		    }else{
		    	loadMap();
		    }
		/* } */
	    
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

			var btime = "${orderinfo.createDate}";
	        var etime = "${orderinfo.updateDate}";

			btime = btime.replace(new RegExp("-", "gm"), "/");
			btime = (new Date(btime)).getTime(); //得到毫秒数
			if ($("#CORDERSTATU").val() == '8'
					|| $("#CORDERSTATU").val() == '5') {
				etime = etime.replace(new RegExp("-", "gm"), "/");
				etime = (new Date(btime)).getTime(); //得到毫秒数
			} else {
				etime = (new Date()).getTime(); //得到毫秒数
			}
			var data = {};
			data.version = 1;
			data.method = 'loadHistory';
			data.vid = $("#CID").val();
			data.vKey = $("#CKEY").val();
			data.bTime = btime;
			data.eTime = etime;
			/* data.version=1;
			data.method='loadHistory';
			data.vid='5732166';
			data.vKey='2427fdff20897691b247d963210ec9ec';
			data.bTime='1448680598000';
			data.eTime='1448694375867'; */
			$
					.ajax({
						type : "get",
						url : "http://219.148.85.56:89/gpsonline/GPSAPI",
						data : data,
						dataType : "json",
						success : function(data) {
							if (data.success==true && data.history.length > 0) {
								//设置地图中心点
								var lng = data.history[0].lng
										+ data.history[0].lng_xz;
								var lat = data.history[0].lat
										+ data.history[0].lat_xz;

								var arrPois = [];
								for ( var i = 0; i < data.history.length; i++) {
									var x = data.history[i].lng
											+ data.history[i].lng_xz;
									var y = data.history[i].lat
											+ data.history[i].lat_xz;
									arrPois[i] = new BMap.Point(x, y);
								}

								map.addOverlay(new BMap.Polyline(arrPois, {
									strokeColor : '#111'
								}));
								var arrStartEnd = [];
								arrStartEnd[0] = arrPois[0];
								arrStartEnd[1] = arrPois[1];
								//map.setViewport(arrStartEnd);
								map.centerAndZoom(new BMap.Point(lng, lat), 14);
								var lushu = new BMapLib.LuShu(
										map,
										arrPois,
										{
											defaultContent : "",
											autoView : true,
											icon : new BMap.Icon(
													'${ctxStatic }/images/car.png',
													new BMap.Size(52, 26), {
														anchor : new BMap.Size(
																27, 13)
													}),
											speed : 4500,
											enableRotation : true,//是否设置marker随着道路的走向进行旋转
											landmarkPois : []
										});
								lushu.start();

								$("run").onclick = function() {
									lushu.start();
								};
								$("stop").onclick = function() {
									lushu.stop();
								};
								$("pause").onclick = function() {
									lushu.pause();
								};
								$("pause").hide();
								$("hide").onclick = function() {
									lushu.hideInfoWindow();
								};
								$("show").onclick = function() {
									lushu.showInfoWindow();
								};
								$("show").hide();
								function $(element) {
									return document.getElementById(element);
								}
								;
							}
						}
					});
		}
	});
</script>
<script type="text/javascript">
	$("#loading").hide();
	window.altmesg = function(text) {
		$("#loadtext").html(text);
		$("#loading").hide();
	};
	$(function() {
		if ($("#sendTime1").html() != "") {
			$("#sendTimeP").html($("#sendTime1").html());
		}
		if ($("#returnTime1").html() != "") {
			$("#returnTimeP").html($("#returnTime1").html());
		}
		$("#sub").click(function() {
			var orderNo = $("#orderNo").html();
			var id = $("#id").val();
			window.location.href = "${pageContext.request.contextPath}/weixin/trade/order_pay?ORDERNO="
					+ orderNo + "&id=" + id;
			;
		});
		$("#sub_dicpute").click(function() {
				var orderNo = $("#orderNo").html();
				var id = $("#id").val();
				window.location.href = "${pageContext.request.contextPath}/weixin/trade/godispute?ORDERNO="
						+ orderNo + "&id=" + id;
				;
			});

		$("#upOrderImg").click(function() {
			$(".data_box").addClass("disnone");
			$(".data_box2").removeClass("disnone");
			$(".data_tab div").removeClass("selected");
			$(".data_tab div:eq(2)").addClass("selected");
			$(this).hide();
		});
		
		
		/* 保存提货单 */
		$("#sub_Googs").click(function() {
			$("#loading").show();
			
			var orderid = $("#id").val();
	        var takegoodsImg = $("#takegoods").val();
			if (takegoodsImg=="") {
				window.setTimeout(altmesg("请上传凭据！"), "3000");
				return;
			}
			$("#sub_Googs").hide();
			var data = {
					id: orderid,
	                receiptimg: takegoodsImg
			};
			upImg(data, "sub_Googs","${wlpt}/wlpt/trade/saveTradeTakeGoods");
		});
		/* 保存凭据 */
		$("#sub_Result").click(function() {
			$("#loading").show();
			var orderid = $("#id").val();
	        var receiptImg = $("#receipt").val();
			if (receiptImg=="") {
				window.setTimeout(altmesg("请上传凭据！"), "1000");
				return;
			}
			
			$("#sub_Result").hide();
			var data = {
					id: orderid,
	                receiptimg: receiptImg
			};
			
			upImg(data, "sub_Result","${wlpt}/wlpt/trade/saveTradeReceipt");
		});
		
		function upImg(data, btn,url) {
			$("#loading").show();
			$.ajax({
	            url:url,
	            data: data,
	            dataType: 'json',
	            cache: false,
	            async: false,
	            success: function (data) {
	                var text = "";
					if (data.state == "1") {
						text = "保存成功";
						$("#" + btn).hide();
					} else {
						text = data.message;
					}
					window.setTimeout(altmesg(text), "1000");
	            }
			});
		}

		$(".lookimg").toggle(function() {
			$(".lookimg").css({
				"width" : "60px",
				"height" : "60px",
				"z-index" : "0",
				"position" : "inherit"
			});
			/* $(this).parent().each(function () {
				new RTP.PinchZoom($(this), {});
			}); */
			$(this).css({
				"width" : "250px",
				"height" : "400px",
				"z-index" : "99",
				"position" : "absolute"
			});
		}, function() {
			$(".lookimg").css({
				"width" : "60px",
				"height" : "60px",
				"z-index" : "0",
				"position" : "inherit"
			});
		});

		$("#divUpload .lookimg").toggle(function() {
			$("#divUpload .lookimg").css({
				"width" : "60px",
				"height" : "60px",
				"z-index" : "0",
				"position" : "inherit"
			});
			$(this).css({
				"width" : "250px",
				"height" : "400px",
				"z-index" : "99",
				"position" : "absolute"
			});
		}, function() {
			$("#divUpload .lookimg").css({
				"width" : "60px",
				"height" : "60px",
				"z-index" : "0",
				"position" : "inherit"
			});
		});
		/* $(".data_box3 div:not(.upimg)").click(function(){
			$("#divUpload .upimg").css({"width":"60px","height":"60px"});
		}); */
		$(".data_tab div").click(function() {
			var i = $(this).index();
			$(this).addClass("selected");
			$(".data_tab div").not(this).removeClass("selected");
			$("#upOrderImg").show();
			switch (i) {
			case 0:
				$(".data_box").addClass("disnone");
				$(".data_box" + i).removeClass("disnone");
				break;
			case 1:
				$(".data_box").addClass("disnone");
				$(".data_box" + i).removeClass("disnone");
				break;
			case 2:
				$(".data_box").addClass("disnone");
				$(".data_box" + i).removeClass("disnone");
				$("#upOrderImg").hide();
				break;
			}
		});
	});
	//格式数字后面的0
	function geShi(num) {
		if (num != null && num != "") {
			return parseFloat(num);
		} else {
			return "--";
		}
	}
	$("#goods_loadweights").html(geShi($("#goods_loadweights").html()));
	$("#goods_money").html(geShi($("#goods_money").html()));
	$("#cars_carlength").html(geShi($("#cars_carlength").html()));
	$("#cars_loadweight").html(geShi($("#cars_loadweight").html()));
</script>
</html>
