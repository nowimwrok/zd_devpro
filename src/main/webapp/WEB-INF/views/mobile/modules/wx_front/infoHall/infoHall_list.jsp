<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>${fns:getConst('SYSTEMTITLE')}--信息大厅</title>

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

<script type="text/javascript"
	src="${ctxStatic}/weixin/js/weixin/errorpage.js"></script>
<script type="text/javascript"
	src="${ctxStatic}/weixin/js/weixin/global.js"></script>
<script>
	var _hmt = _hmt || [];
	(function() {
		var hm = document.createElement("script");
		hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
		var s = document.getElementsByTagName("script")[0];
		s.parentNode.insertBefore(hm, s);
	})();
</script>
<link href="${ctxStatic}/weixin/css/global.css" rel="stylesheet"
	type="text/css">
<link href="${ctxStatic}/weixin/css/infoHall.css" rel="stylesheet"
	type="text/css">
<style type="text/css">
* {
	font-family: "微软雅黑";
}

.search_top {
	height: 90px;
}

.result_bottom {
	height: 30px;
}

.data_box {
	margin-top: 98px;
	padding-bottom: 30px;
}

.hot_play span.qiang {
	background: url("${ctxStatic}/img/qiang.gif") no-repeat;
	background-size: 100%;
}

.hot_play span.pai {
	background: url("${ctxStatic}/img/pai.gif") no-repeat;
	background-size: 100%;
}

.data_div {
	height: 160px;
	width: 96%;
	background-color: white;
	-moz-border-radius: 6px;
	-webkit-border-radius: 6px;
	border-radius: 10px;
	margin: 0px 2%;
	margin-bottom: 5px
}

.data_top {
	height: 40px;
	width: 99%;
	border-bottom: 1px solid #EBEBEB;
	margin-left: 1%;
}

.data_cet {
	height: 80px;
	width: 99%;
	border-bottom: 1px solid #EBEBEB;
	margin-left: 1%;
}

.data_btms {
	height: 40px;
	width: 99%;
	border-bottom: 1px solid #EBEBEB;
	margin-left: 1%;
	line-height: 40px;
}

.data_btmwidthf {
	width: 24%;
	text-align: center;
	border-radius: 8px;
	background-color: rgba(61, 170, 252, 0.65);
	color: white;
	height: 26px;
	margin-top: 6px;
	margin-bottom: 6px;
	line-height: 26px;
}

.data_btmwidths {
	width: 24%;
	text-align: center;
	border-radius: 8px;
	background-color: rgba(255, 102, 0, 0.73);
	color: white;
	margin-left: 5%;
	height: 26px;
	margin-top: 6px;
	margin-bottom: 6px;
	line-height: 26px;
}

/* .data_btmwidtht {
	width: 52%;
} */
.data_cl {
	height: 80px;
	width: 70%;
	float: left;
}

.data_cr {
	height: 80px;
	width: 30%;
	float: left;
}

.data_cltop {
	height: 40px;
	border-bottom: 1px solid #EBEBEB;
	line-height: 40px;
}

.data_clbtm {
	height: 40px;
	line-height: 40px;
}

.data_topimg {
	padding-left: 10px;
	width: 15px;
	height: 15px;
	padding-top: 12.5px;
	padding-bottom: 12.5px;
}

.data_topimgc {
	width: 15px;
	height: 15px;
	padding-top: 12.5px;
	padding-bottom: 12.5px;
}

.data_topserimg {
	padding-left: 12px;
	width: 15px;
	height: 15px;
	padding-top: 10px;
	padding-bottom: 10px;
}

.data_topf {
	width: 40px;
	height: 40px;
	float: left;
}

.data_tops {
	height: 40px;
	float: left;
	text-align: center;
	line-height: 40px;
	padding: 0px 5px;
}

.data_topt {
	width: 70px;
	height: 40px;
	float: left;
}

.data_topfo {
	width: 50px;
	height: 40px;
	float: left;
}

.data_topfi {
	height: 40px;
	float: right;
	text-align: center;
	line-height: 40px;
	color: #999;
	padding-right: 10px;
}

.data_topimgt {
	width: 50px;
	height: 20px;
	padding: 10px 10px;
}

.floatlcon {
	width: 15px;
	padding: 0 10px;
}

.floatl {
	float: left;
}

.floatr {
	float: right;
}

.data_crimg {
	width: 50px;
	height: 50px;
	padding: 15px 30px;
}

.fon {
	font-size: 14px;
}

.fonws {
	font-size: 14px;
}

.sertopdiv {
	background-color: white;
	border-radius: 10px;
	width: 96%;
	margin-left: 2%;
	margin-right: 2%;
	margin-top: 5px;
	margin-bottom: 5px;
}

.grayscale_none {
	-webkit-filter: none;
	filter: none;
}

.grayscale {
	-webkit-filter: grayscale(1);
	filter: grayscale(1);
}
</style>
</head>

<body>

	<input type="hidden" id="loginPhone" value="${user.phone}" />

	<div class="search_top top">
		<div class="search_center">
			<ul class="search_ul contype_per">
				<li class="selected" style="color: #FFBB66">货源信息</li>
				<li style="float: right;">招标信息</li>
			</ul>
			<div style="height: 55px;">
				<div class="sertopdiv">
					<div class="address_div">
						<div class="address_input">
							<img class="data_topserimg floatl" alt="始发地"
								src="${ctxStatic}/images/weixin/img_location_start_point.png" />
							<input class="li_txt fon" type="text" id="fromAddress"
								readonly="readonly" placeholder="全部地区" /> <img
								class="address_img"
								src="${ctxStatic}/images/weixin/switch_btn.png" /> <img
								class="data_topserimg floatl" alt="目的地"
								src="${ctxStatic}/images/weixin/img_location_end_point.png" />
							<input class="li_txt fon" type="text" id="toAddress"
								readonly="readonly" placeholder="全部地区" />

						</div>
						<div class="search_div">
							<button id="search" value="搜索">搜&nbsp;索</button>
						</div>
						<input id="Fpro" type="hidden" value="" /><input id="FCity"
							type="hidden" value="" /> <input id="Tpro" type="hidden"
							value="" /><input id="TCity" type="hidden" value="" />
					</div>
				</div>
			</div>
		</div>
		<!-- search_center end  -->
	</div>
	<div id="data_box" class="data_box"></div>
	<div id='loading'
		style='width: 100%; display: none; vertical-align: middle; text-align: center; height: 45px; padding-top: 110px;'>
		<div>
			<img src='${ctxStatic}/images/loading-30x30.gif'>
		</div>
		<div style="font-size: 14px; font-weight: bold;" id="loadtext">加载中……</div>
	</div>
	<div id="pages" style="display: none;">
		<span id="firstPage"><a>首页</a></span> <span id="previewPage"><a>上一页</a></span>
		<span id="nextPage"><a>下一页</a></span> <span id="lastPage"><a>尾页</a></span>
		<span id="pageInfo"><span>第</span> <b id="curPage"
			style="font-weight: bold;">1</b> <span>页/共</span> <span
			id="pageCount">1</span> <span>页</span> </span> <input type="hidden"
			id="roleType" value="${sessionScope.rolePd.ROLE_CODE}" />
	</div>
	<div class="search_top result_bottom bottom">
		<div id="allCount" style="display: none">0</div>
		共<span id="totalCount" style="font-weight: bold;">0</span>条结果
		<!-- ,今天<span
			id="NOWTIMECOUNT"></span>条,交易<span id="tradeCount"></span>笔 -->
	</div>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/jquery-1.7.2.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/weixin/jquery.touchSwipe.min.js"></script>
	<script type="text/javascript">
		$("#loading").show();
		$(function() {
			var HALLTYPE = 0;//全局 默认 0货源 1招标
			var roleType = $("#roleType").val();
			document.body.scrollWidth = 320;
			//条件
			var searchConditions = {};
			searchConditions.pageSize = 10;
			searchConditions.pageNo = 1;
			if (roleType == "carowner") {
				$(".contype_per li").removeClass("selected");
				$(".contype_per li:eq(0)").addClass("selected").css("width",
						"100%");
				$(".contype_per li:eq(1)").remove();
			}
			searchGoodsData(1);
			/* searchData(1); */
			var nowpage = 1; ///当前页数
			var nowcount = 1;
			//按地址条件查询
			$("#search").click(function() {
				$("#data_box").html("");
				searchConditions.pageSize = 10;
				searchConditions.pageNo = 1;
				nowpage=1;
				nowcount = 1;
				searchConditions.fromcity = $("#FCity").val();
				searchConditions.fromprovince = $("#Fpro").val();
				searchConditions.tocity = $("#TCity").val();
				searchConditions.toprovince = $("#Tpro").val();
				if (HALLTYPE == 0) {
					searchGoodsData(1); 
				} else {
					searchData(1);
				}
			});
			$(window).scroll(
					function() {
						var curPageNo = $("#curPage").html();
						var pageCount = $("#pageCount").html();
						//下面这句主要是获取网页的总高度，主要是考虑兼容性所以把Ie支持的documentElement也写了，这个方法至少支持IE8
						var htmlHeight = document.body.scrollHeight
								|| document.documentElement.scrollHeight;
						//clientHeight是网页在浏览器中的可视高度，
						var clientHeight = document.body.clientHeight
								|| document.documentElement.clientHeight;
						//scrollTop是浏览器滚动条的top位置，
						var scrollTop = document.body.scrollTop
								|| document.documentElement.scrollTop;
						//通过判断滚动条的top位置与可视网页之和与整个网页的高度是否相等来决定是否加载内容；
						if (scrollTop + clientHeight == htmlHeight) {
							nowpage += 1;
							if (nowpage*1<= pageCount*1) {
								if (HALLTYPE == 0) {
									searchGoodsData(nowpage);
								} else {
									searchData(nowpage);
								}
							}

						}
					});
			//类型查询
			$(".contype_per li").click(function() {
				$(this).css("color", "#FFBB66");
				$(this).addClass("selected");
				searchConditions = {};
				searchConditions.tocity = '';
				searchConditions.toprovince = '';
				$("#FCity").val("");
				$("#Fpro").val("");
				$("#TCity").val("");
				$("#Tpro").val("");
				$("#fromAddress").val("");
				$("#toAddress").val("");
				searchConditions.pageSize = 10;
				searchConditions.pageNo = 1;
				nowpage=1;
				nowcount = 1;
				var type = $(this).index();
				if (type == 0) {
					searchGoodsData(1);
					HALLTYPE = 0;
				} else {
					searchData(1);
					HALLTYPE = 1;
				}
				$(".contype_per li").not(this).css("color", "#FFF");
				$(".contype_per li").not(this).removeClass("selected");
				$("#data_box").html("");
			});

			//查询数据ajax
			function searchData(currentPage) {
				$("#loading").show();
				searchConditions.pageNo = currentPage;
				$
						.ajax({
							type : "POST",
							url : '${wx}/weixin/bid/getbidsList',
							data : {
								pageNo : searchConditions.pageNo,
								pageSize : searchConditions.pageSize,
								"goods.shipAddress.province" : searchConditions.fromprovince,
								"goods.shipAddress.city" : searchConditions.fromcity,
								"goods.consignAddress.province" : searchConditions.toprovince,
								"goods.consignAddress.city" : searchConditions.tocity
							},
							dataType : 'json',
							cache : false,
							success : function(data) {
								if (data.value.list != null) {
									if (data.value.list.length <= 0) {
										$("#data_box").html("");
										$("#totalCount").html(0);
										$("#data_box")
												.show()
												.append(
														'<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
									} else {
										rolename = data.value.message;									
										nowpage = data.value.pageNo;
										searchConditions.pageNo = nowpage;
										if(searchConditions.pageNo*1==1){
											$("#data_box").html("");
										}
										nowcount = data.value.count;
										$("#pageCount").html(Math.ceil(data.value.count / searchConditions.pageSize));
										$("#allCount").html(nowcount);
										$("#curPage").html(searchConditions.pageNo);
										
										$("#totalCount").html(nowcount);
										var fillDatas = "";
										for (var i = 0; i < data.value.list.length; i++) {
											fillDatas += fillDataOne(data.value.list[i]);
										}
										$("#data_box").append(fillDatas);
	
									}
								}else{
									$("#data_box").html("");
									$("#totalCount").html(0);
									$("#data_box")
									.show()
									.append(
											'<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
									
								}

								$("#loading").css('display', 'none');
							}
							
						});
			}

			/***************招标数据***************/
			function fillDataOne(data) {
				var endDate = ((data.endtimeFM != null && data.endtimeFM != "" && data.endtimeFM != undefined) ? data.endtimeFM.substr(0,10)
						: "");
				var endDate1 = ((data.endtimeFM != null && data.endtimeFM != "" && data.endtimeFM != undefined) ? data.endtimeFM : "");
				var userName = data.biduser.loginName;
				
				var userLevel = 0;
				if(data.biduser.pointlevle !=null&&data.biduser.pointlevle !=""){
					userLevel=data.biduser.pointlevle;
				}
				
				var rightLogo = 'weixinpai';
				var fromAddress = "";
				var toAddress = "";

				if (data.goods.shipAddress != undefined
						&& data.goods.shipAddress != null
						&& data.goods.shipAddress != "") {
					fromAddress = data.goods.shipAddress.province
							+ data.goods.shipAddress.city;
				}
				if (data.goods.consignAddress != undefined
						&& data.goods.consignAddress != null
						&& data.goods.consignAddress != "") {
					toAddress = data.goods.consignAddress.province
							+ data.goods.consignAddress.city;
				}
				var goodName = data.goods.goodsname;
				var loadWeight = "";
				if (data.goods.freightvolume != null
						&& data.goods.freightvolume != ""
						&& data.goods.freightvolume != undefined) {
					loadWeight = parseFloat(data.goods.freightvolume)
							+ data.goods.freightunit;
				}

				if (userName !=undefined &&userName.length > 4) {
					userName = userName.substring(0, 3) + "…";
				}
				if (goodName !=undefined &&goodName.length > 5) {
					goodName = goodName.substring(0, 5);
				}
				if (loadWeight !=undefined &&loadWeight.length > 8) {
					loadWeight = loadWeight.substring(0, 8);
				}
				var grayscaleClass = "grayscale_none";
				var bindclick = 'onclick="dataDetails(' + "'"+ data.id+ "','"+ "1"+ "'"+ ')"';
				var endtimes = "";
				var nowtimes = new Date().getTime();
				if (endDate1 != null && endDate1 != "" && endDate1 != undefined) {
					endtimes = new Date(endDate1).getTime();
					if (nowtimes > endtimes) {
						grayscaleClass = "grayscale";
						bindclick = '';
					}
				}
				if (data.bidstatus != '草稿' && data.bidstatus != '发布') {
					grayscaleClass = "grayscale";
					bindclick = '';
				}
				var userid='${user.id}';
				if(userid!=null&&userid!=''&&userid!=undefined){
					if(userid==data.biduser.id){
						grayscaleClass = "grayscale";
						bindclick = '';
					}
				}
				//对车主隐藏拍
	 			var rolename = '${user.role.enname}';
				if(rolename=='carowner'){
					grayscaleClass = "grayscale";
					bindclick = '';
				} 

				var html = '<div class="data_div" '+bindclick+'>'
						+ '<div class="data_top">'
						+ '<div class="data_topf">'
						+ '	<img class="data_topimg" alt="发布用户" src="${ctxStatic}/images/weixin/ic_user.png" />'
						+ '</div>'
						+ '<div class="data_tops ">'
						+ '	<span class="fonws">'
						+ userName
						+ '</span>'
						+ '	</div>'
						+ '<div class="data_topt">';
						if(userLevel==0||userLevel==1){
							html=html+'	<img class="data_topimg" style="width:24px" alt="s" src="${ctxStatic}/images/wlptfront/pointlevel/point_level_';
						}else if(userLevel==2){
							html=html+'	<img class="data_topimg" style="width:30px" alt="s" src="${ctxStatic}/images/wlptfront/pointlevel/point_level_';
						}else if(userLevel==3){
							html=html+'	<img class="data_topimg" style="width:36px" alt="s" src="${ctxStatic}/images/wlptfront/pointlevel/point_level_';
						}else if(userLevel==4){
							html=html+'	<img class="data_topimg" style="width:42px" alt="s" src="${ctxStatic}/images/wlptfront/pointlevel/point_level_';
						}else if(userLevel==5){
							html=html+'	<img class="data_topimg" style="width:48px" alt="s" src="${ctxStatic}/images/wlptfront/pointlevel/point_level_';
						}
						
						html=html + userLevel
						+ '.gif">'
						+ '</div>'
						+ '<div class="data_topfi fonwe">'
						+ endDate
						+ '</div>'
						+ '</div>'
						+ '<div class="data_cet">'
						+ '<div class="data_cl">'
						+ '<div class="data_cltop"><div class="floatl floatlcon"><img class="data_topimgc" alt="始发地" src="${ctxStatic}/images/weixin/img_location_start_point.png" /></div><div class="floatl fon">'
						+ fromAddress
						+ '</div></div>'
						+ '	<div class="data_clbtm"><div class="floatl floatlcon"><img class="data_topimgc" alt="目的地" src="${ctxStatic}/images/weixin/img_location_end_point.png" /></div><div class="floatl fon">'
						+ toAddress
						+ '</div></div>'
						+ '</div>'
						+ '<div class="data_cr">'
						+ '<a><img class="data_crimg '+grayscaleClass+'" alt="货主" src="${ctxStatic}/images/weixin/'+rightLogo+'.png" /></a>'
						+ '</div>'
						+ '</div>'
						+ '<div class="data_btms fonws"><div class="floatl" style="width:10%;">&nbsp;</div><div class="floatl data_btmwidthf fonws">'
						+ goodName
						+ '</div> <div class="floatl data_btmwidths fonws">'
						+ loadWeight + '</div></div>' + '</div>';

				return html;
			}

			//货源
			function searchGoodsData(currentPage) {
				$("#loading").show();
				searchConditions.pageNo = currentPage;
				$
						.ajax({
							type : "POST",
							url : '${wx}/weixin/goodssource/getHallGoodsList',
							data : {
								pageNo : searchConditions.pageNo,
								pageSize : searchConditions.pageSize,
								"shipAddress.province" : searchConditions.fromprovince,
								"shipAddress.city" : searchConditions.fromcity,
								"consignAddress.province" : searchConditions.toprovince,
								"consignAddress.city" : searchConditions.tocity
							},
							dataType : 'json',
							cache : false,
							success : function(data) {
								if (data.value.list != null) {
									if (data.value.list.length <= 0) {
										$("#data_box").html("");
										$("#totalCount").html(0);
										$("#data_box")
												.show()
												.append(
														'<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
									} else {
	
										nowpage = data.value.pageNo;
										searchConditions.pageNo = nowpage;
										if(searchConditions.pageNo*1==1){
											$("#data_box").html("");
										}
										nowcount = data.value.count;
										$("#pageCount").html(Math.ceil(data.value.count / searchConditions.pageSize));
										$("#allCount").html(nowcount);
										$("#curPage").html(searchConditions.pageNo);
										
										$("#totalCount").html(nowcount);
										var fillDatas = "";
										for (var i = 0; i < data.value.list.length; i++) {
											fillDatas += fillGoodsDataOne(data.value.list[i]);
										}
										$("#data_box").append(fillDatas);
	
									}
								}else{
									$("#data_box").html("");
									$("#totalCount").html(0);
									$("#data_box")
									.show()
									.append(
											'<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">'+data.value.message+'</p>');
									
								}
								$("#loading").css('display', 'none');
							}
						});
			}

			/***************货源数据***************/
			function fillGoodsDataOne(data) {
				var sendDate = ((data.sendtime != null && data.sendtime != "" && data.sendtime != undefined) ? data.sendtime
						: "");
				var ymdDate = ((data.ymdDate != null && data.ymdDate != "" && data.ymdDate != undefined) ? data.ymdDate
						: "");
				var userName = data.user.loginName;
				var userLevel = 0;
				//if(data.user.userinfo!=undefined && data.user.userinfo != null){
					userLevel = data.user.pointlevle;
					if(userLevel==undefined ||userLevel == null ||userLevel==""){
						userLevel= 0 ;
					}
				//}
				
				var rightLogo = 'weixinqiang';
				var fromAddress = "";
				var toAddress = "";

				if (data.shipAddress != undefined && data.shipAddress != null
						&& data.shipAddress != "") {
					fromAddress = data.shipAddress.province
							+ data.shipAddress.city;
				}
				if (data.consignAddress != undefined
						&& data.consignAddress != null
						&& data.consignAddress != "") {
					toAddress = data.consignAddress.province
							+ data.consignAddress.city;
				}

				var goodName = data.goodsname;
				var loadWeight = "";
				if (data.freightvolume != null && data.freightvolume != ""
						&& data.freightvolume != undefined) {
					loadWeight = parseFloat(data.freightvolume)
							+ data.freightunit;
				}
				var carlength = "不限";
				if (data.carlength != null && data.carlength != ""
						&& data.carlength != undefined) {
					carlength = parseFloat(data.carlength)
							+ "米";
				}
				if (userName!=undefined &&userName.length > 5) {
					userName = userName.substring(0, 4) + "…";
				}
				if (goodName!=undefined &&goodName.length > 5) {
					goodName = goodName.substring(0, 5);
				}
				if (loadWeight!=undefined &&loadWeight.length > 8) {
					loadWeight = loadWeight.substring(0, 8);
				}

				var grayscaleClass = "grayscale_none";
				var bindclick = 'onclick="dataDetails(' + "'"+ data.id+ "','"+ "0"+ "'"+ ')"';
				var endtimes = "";
				var nowtimes = new Date().getTime();
				
				if (sendDate != null && sendDate != "" && sendDate != undefined) {
					endtimes = new Date(sendDate).getTime();
					if (nowtimes > endtimes) {
						grayscaleClass = "grayscale";
						bindclick = '';
					}
				}
				if (data.tradestatus == "2") {
					grayscaleClass = "grayscale";
					bindclick = '';
				}
				var userid='${user.id}';
				if(userid!=undefined && userid!=null && userid!=''){
					if(userid==data.user.id){
						grayscaleClass = "grayscale";
						bindclick = '';
					}
					//bindclick = '';
				}				
				var html = '<div class="data_div" '+bindclick+'>'
						+ '<div class="data_top">'
						+ '<div class="data_topf">'
						+ '	<img class="data_topimg" alt="发布用户" src="${ctxStatic}/images/weixin/ic_user.png" />'
						+ '</div>'
						+ '<div class="data_tops ">'
						+ '	<span class="fonws">'
						+ userName
						+ '</span>'
						+ '	</div>'
						+ '<div class="data_topt">';
				if(userLevel==0||userLevel==1){
					html=html+'	<img class="data_topimg" style="width:24px" alt="s" src="${ctxStatic}/images/wlptfront/pointlevel/point_level_';
				}else if(userLevel==2){
					html=html+'	<img class="data_topimg" style="width:30px" alt="s" src="${ctxStatic}/images/wlptfront/pointlevel/point_level_';
				}else if(userLevel==3){
					html=html+'	<img class="data_topimg" style="width:36px" alt="s" src="${ctxStatic}/images/wlptfront/pointlevel/point_level_';
				}else if(userLevel==4){
					html=html+'	<img class="data_topimg" style="width:42px" alt="s" src="${ctxStatic}/images/wlptfront/pointlevel/point_level_';
				}else if(userLevel==5){
					html=html+'	<img class="data_topimg" style="width:48px" alt="s" src="${ctxStatic}/images/wlptfront/pointlevel/point_level_';
				}
				
				html=html + userLevel
						+ '.gif">'
						+ '</div>'
						+ '<div class="data_topfi fonwe">'
						+ ymdDate
						+ '</div>'
						+ '</div>'
						+ '<div class="data_cet">'
						+ '<div class="data_cl">'
						+ '<div class="data_cltop"><div class="floatl floatlcon"><img class="data_topimgc" alt="始发地" src="${ctxStatic}/images/weixin/img_location_start_point.png" /></div><div class="floatl fon">'
						+ fromAddress
						+ '</div></div>'
						+ '	<div class="data_clbtm"><div class="floatl floatlcon"><img class="data_topimgc" alt="目的地" src="${ctxStatic}/images/weixin/img_location_end_point.png" /></div><div class="floatl fon">'
						+ toAddress
						+ '</div></div>'
						+ '</div>'
						+ '<div class="data_cr">'
						+ '<a><img class="data_crimg '+grayscaleClass+'" alt="货主" src="${ctxStatic}/images/weixin/'+rightLogo+'.png" /></a>'
						+ '</div>'
						+ '</div>'
						+ '<div class="data_btms fonws"><div class="floatl" style="width:10%;">&nbsp;</div><div class="floatl data_btmwidthf fonws">'
						+ goodName
						+ '</div> <div class="floatl data_btmwidths fonws">'
						+ loadWeight + '</div><div class="floatl data_btmwidths fonws" style="background-color: #ffcb00;">'
						+ carlength + '</div></div>' + '</div>';

				return html;
			}
			/*******通过ID查询详细信息********/
			window.dataDetails = function(id, type) {
				if ($("#loginPhone").val() != null
						&& $("#loginPhone").val() != "") {
					var userstatus = '${user.userinfo.status }';
					/* var rolename = '${user.role.enname}';
					var driverstatus ='${user.driver.status}'; */
					if (type == '0') {//货源						
						if(userstatus != '2')
							alert("未认证用户请先认证");
						/* else if(rolename == 'carowner' && driverstatus != '2')
								alert("未认证车主请先认证"); */
						else
							window.location.href = "${wx}/weixin/goodssource/toGoodsQuote?id="
								+ id;
					}
					if (type == '1') {//招标
						if(userstatus != '2'){
							alert("未认证用户请先认证");
						}else{
							window.location.href = "${wx}/weixin/bid/toBidding?id="
								+ id;
						}
					}
				} else {
					alert("请先绑定或注册新的账号");
				}

			};
			//---------------------------------地址数据
			$("#fromAddress").PCC({
				hasCounty : false,
				width : "65%",
				height : 330,
				location : "left",
				ismiddle : true,
				url : "${wlpt}/wlpt/chinaarea/getArea",
				closeIcon : "${ctxStatic}/images/pic12.gif",
				complete : function(data) {
					var str = "";
					
					searchConditions.fromcity = '';
					searchConditions.fromprovince = '';
					if (data.province) {
						str = data.province.NAME;
						searchConditions.fromprovince = data.province.NAME;
						$("#Fpro").val(data.province.NAME);
					}
					if (data.city) {
						if (data.city.NAME != data.province.NAME) {
							str = data.city.NAME;
							if (str == null || str == "") {
								str = data.province.NAME;
							}
							searchConditions.fromcity = data.city.NAME;
							$("#FCity").val(data.city.NAME);
						}
					}
					if (str != "") {
						$("#fromAddress").val(str);
					} else {
						$("#fromAddress").val("");
					}
				}
			});

			$("#toAddress").PCC({
				hasCounty : false,
				width : "65%",
				height : 330,
				url : "${wlpt}/wlpt/chinaarea/getArea",
				closeIcon : "${ctxStatic}/images/pic12.gif",
				location : "left",
				ismiddle : true,
				complete : function(data) {
					var str = "";
					searchConditions.tocity = '';
					searchConditions.toprovince = '';
					if (data.province) {
						str = data.province.NAME;
						searchConditions.toprovince = data.province.NAME;
						$("#Tpro").val(data.province.NAME);
					}
					if (data.city) {

						if (data.city.NAME != data.province.NAME) {
							str = data.city.NAME;
							if (str == null || str == "") {
								str = data.province.NAME;
							}
							searchConditions.tocity = data.city.NAME;
							$("#TCity").val(data.city.NAME);
						}
					}
					if (str != "") {
						$("#toAddress").val(str);
					} else {
						$("#toAddress").val("");
					}
				}
			});
		});
	</script>
</body>
</html>
