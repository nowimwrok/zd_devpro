<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<html>
<head>
<title>${fns:getConst('SYSTEMTITLE')}--我的运单</title>

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

	<link href="${ctxStatic }/weixin/css/carsource.css" rel="stylesheet"
	type="text/css">
	<link href="${ctxStatic }/weixin/css/global.css" rel="stylesheet"
	type="text/css">
<style type="text/css">
.search_top,.result_bottom {
	width: 100%;
	display: block;
	border-bottom: 1px dashed #999;
	z-index: 2;
	position: fixed;
	background-color: #EBEBEB;
}

.search_top {
	height: 50px;
	width: 100%;
	line-height: 50px;
	border-bottom: 1px solid #EBEBEB;
	background-color: #FFF;
	margin: 0px auto;
}

.result_bottom {
	height: 30px;
	border: none;
	text-align: center;
	line-height: 30px;
	bottom: 0px;
}

.top {
	top: 0px;
}

.bottom {
	bottom: 0px;
}

#data_box,#data_add {
	width: 98%;
	margin: 0 auto;
	margin-top: 55px;
	margin-bottom: 30px;
}

.data_div {
	width: 98%;
	background-color: #FFF;
	clear: both;
	height: 112px;
	margin: 0 auto;
	margin-bottom: 5px;
	border-radius:10px;
}

.data_content {
	vertical-align: middle;
	display: table-cell;
}

.top_icon {
	width: 20px;
	height: 35px;
}

.top_text {
	width: 78%;
	height: 40px;
	line-height: 40px;
}

.top_icon img {
	width: 20px;
	margin-top: 5px;
}

.icon {
	width: 25px;
}

.ic_img {
	width: 30px;
}

.data_row {
	width: 100%;
	border-bottom: 1px solid #EBEBEB;
	clear: both;
	height: 40px;
}

.data_row div {
	font-size: 16px;
}

.mag_right {
	margin-right: 4%;
}

.flt {
	float: left;
	text-align: left;
}

.frt {
	float: right;
	text-align: right;
}

.data_btm {
	width: 98%;
	padding-left: 6px;
	height: 25px;
	padding-top: 5px;
}

.data_btm div {
	float: left;
	margin-right: 3%;
	line-height: 25px;
}

.data_tab div {
	float: left;
	text-align: center;
	width: 25%;
}

.data_tab {
	width: 100%;
	margin: 0px auto;
}

/* .selected {
	color: #F74000;
} */
.selected {
    /* background-color: rgb(255,247,244); */
    /* color: rgb(27, 216, 244); */
    color:#FFBB66;
    border-bottom: 2px solid #FFBB66;
    background-color:rgba(32, 162, 226, 1);
}
.data_tab_left {
	width: 25%;
}

.data_tab_right {
	width: 24%;
}
.authened{
background-color:rgba(20, 181, 47, 0.83);
-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px;
}
</style>
</head>

<body>
	<div class="search_top top" style="background-color:rgba(32, 162, 226, 1);color:white;">
		<div class="data_top data_tab" >
			<div class="selected">全部</div>
			<div>交易中</div>
			<div>待支付</div>
			<div style="float:right">已完成</div>
			<!-- <div>待评价</div> -->
		</div>
	</div>
	<div id="data_box">
			<div id="data_div" class="data_div" style="display:none;"
				onclick="dataDetails('{{ORDERNO}}')">
				<div class="data_row data_btm">
					<div class="flt">运单:{{ORDERNO}}</div>
				</div>
				<div class="data_row">
					<div class="top_icon flt" style="padding-left:10px;">
						<img alt="出发地"
							src="${ctxStatic }/images/weixin/ic_start.png">
					</div>
					<div class="top_text flt">{{GOODS_FROMADDRESS}}</div>
					<div class="top_icon flt">
						<img alt="目的地"
							src="${ctxStatic }/images/weixin/ic_end.png">
					</div>
					<div class="top_text flt">{{GOODS_TOADDRESS}}</div>
				</div>
				<div class="data_row data_btm" style="border:none">
					<div class="ic_img" style="margin:0px;">
						<img class="icon" style="margin:0px;" alt="货物"
							src="${ctxStatic }/images/weixin/ic_goods.png">
					</div>
					<div>{{GOODSNAME}}</div>
					<div>{{LOADWEIGHT}}{{WEIGHTUNIT}}</div>
					<div>￥{{FREIGHT}}元</div>
					<div class="frt flt_left" style="float:right;">
						<span class="authened">{{ORDERSTATUS}}</span>
					</div>
				</div>
			</div>
		</div>
	<div id="data_add"
		style="display:none;margin-top:50px;background:#FFF;">
		<%-- <jsp:include page="goodsSource_add.jsp"  flush="true"></jsp:include> --%>
	</div>
	<div id='loading'
			style='width:100%;vertical-align: middle;text-align:center;height:45px'>
			<div>
				<img src='${ctxStatic }/images/weixin/loading-30x30.gif'>
			</div>
			<div style="font-size:14px;font-weight:bold;" id="loadtext">小卓正在努力加载，请稍等!</div>
		</div>
	<div id="pages" style="display:none;">
		<span id="firstPage"><a>首页</a></span> <span id="previewPage"><a>上一页</a></span>
		<span id="nextPage"><a>下一页</a></span> <span id="lastPage"><a>尾页</a></span>
		<span id="pageInfo"><span>第</span><b id="curPage">1</b><span>页/共</span><b
			id="pageCount">1</b><span>页</span> </span>
	</div>
	<div class="search_top result_bottom bottom">
		共<b id="totalCount">0</b>条信息
	</div>
	<script type="text/javascript" src="${ctxStatic }/weixin/js/jquery-1.7.2.js"></script>
	<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/jquery.pcc.js"></script>
	<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/jquery.touchSwipe.min.js"></script>
	<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/config.js"></script>
	<script src="${ctxStatic }/weixin/js/weixin/global.js"></script>
	
	<script type="text/javascript">
		$("#loading").show();
		$(function() {
			//条件
			var tab_i = 0;
			var searchConditions = {};
			searchConditions.pageSize = 10;
			searchConditions.pageNo = 1;
			searchData(1);
			var nowpage = 1; ///当前页数
			var nowcount = 1;
			//------------------------------------------------
			$(".data_tab div").click(function() {
					tab_i = $(this).index();
					$(this).addClass("selected");
					$(".data_tab div").not(this).removeClass("selected");
					searchConditions={};
					searchConditions.pageSize = 10;
					searchConditions.pageNo = 1;
					nowpage=1;
					nowcount = 1;
					if(tab_i==0){
					}else if(tab_i==1){
						searchConditions.istrading='1';
					}else if(tab_i==2){
						searchConditions.orderstatus='4';
					}else if(tab_i==3){
						searchConditions.orderstatus='5';
					}
					$("#data_box").html("");
					searchData(1);
			});
			$(window).scroll(
					function() {
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
							if (nowpage <= parseInt(pageCount)) {
								searchData(nowpage);
							}

						}
					});
			//查询数据ajax
			function searchData(pageNo) {
				$("#loading").show();
				$("#page").hide();
				//$("#data_box").html("");
				searchConditions.pageNo = pageNo;
				$.ajax({
							type : "POST",
							url : '${wx}/weixin/trade/getTradeList',
							data : searchConditions,
							dataType : 'json',
							cache : false,
							success : function(data) {
								if (data.value.list != null) {
									if (data.value.list.length <= 0) {
										$("#totalCount").html(0);
										$("#data_box").show().append(
											'<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
									} else {
										$("#page").show();
										nowcount = data.value.count;
										//赋值分页总数
										$("#pageCount").html(Math.ceil(data.value.count / searchConditions.pageSize));
										//赋值当前页数
										$("#curPage").html(searchConditions.pageNo);
										//赋值数据总条数
										$("#totalCount").html(nowcount);
										var fillDatas = "";
										for (var i = 0; i < data.value.list.length; i++) {
											fillDatas += fillDataOne(data.value.list[i]);
										}
										if(Math.ceil(data.value.count / searchConditions.pageSize)==1){
											$("#data_box").html("");	
										}
										$("#data_box").append(fillDatas);
									}
								} else {
									$("#totalCount").html(0);
									$("#data_box").html("");
									$("#data_box").show().append(
										'<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
									$("#loading").hide();
								}
								$("#loading").css('display', 'none');
								$("#loading").hide();
							}
						});
			}

			/***************填充到页面的数据***************/

			function fillDataOne(data) {
				var price = "";
				var TOTALCOST=data.totalcost!=undefined?data.totalcost:0;
				if (TOTALCOST* 1 >= 10000) {
					var p = TOTALCOST / 10000;
					p = p.toString();
					var index = p.indexOf(".", 0);
					index = index >= 0 ? index : p.length;
					index += 2;
					index = index < p.length ? index : p.length;
					price = p.substring(0, index) + "万元";
				} else {
						price = TOTALCOST + "元";
				}
				var isreload=data.quoteinfo.isreload!=undefined?data.quoteinfo.isreload:0;
				var weight=data.quoteinfo.oddloadweight!=undefined?data.quoteinfo.oddloadweight:0;
				if(isreload==1){
					weight=data.quoteinfo.actload!=undefined?data.quoteinfo.actload:0;
				}
				if (weight * 1 > 999) {
					var p = weight/ 1000;
					p = p.toString();
					var index = p.indexOf(".", 0);
					index = index >= 0 ? index : p.length;
					index += 2;
					index = index < p.length ? index : p.length;
					weight = p.substring(0, index) + "千";
				}else{
					weight= fmoney(weight,3);
				}
				var goodsName = data.quoteinfo.goods.goodsname!=undefined?data.quoteinfo.goods.goodsname:"--";
				if (goodsName.length > 6) {
					goodsName = goodsName.substring(0, 6) ;
				}
				
				//地址
				var from = "";
				var to =  "";
				var fromaddress = "";
				var toaddress = "";
				//判断发货地址是否为空
				if(data.quoteinfo.goods.shipAddress!=undefined &&data.quoteinfo.goods.shipAddress!=null && data.quoteinfo.goods.shipAddress!=""){
					from = data.quoteinfo.goods.shipAddress.city+data.quoteinfo.goods.shipAddress.district;
					fromaddress = from
					if(from!=null&&from.length>6){
						fromaddress = from.substring(0, 6);
					}
					
				}
				//判断收货地址是否为空
				if(data.quoteinfo.goods.consignAddress!=undefined &&data.quoteinfo.goods.consignAddress!=null && data.quoteinfo.goods.consignAddress!=""){
					to = data.quoteinfo.goods.consignAddress.city+data.quoteinfo.goods.consignAddress.district;
					toaddress = to;
					if(from!=null&&from.length>6){
						toaddress = to.substring(0, 6); 
					}
				}
				
				
				var orderStatus=data.orderstatus;
				var statusStr = data.statusStr;
				var statusbnt =  '<span class="authened" style="line-height:40px;">'+statusStr+'</span>';
				if(orderStatus*1 == 0 && data.isBuyer){
					statusbnt =  '<span class="authened" style="line-height:40px;background-color:#FFC52F" id="'+ data.id+'" onclick="orderConfirm(' + "'"+ data.id+"'"+ ')">确认交易</span>';
				}
				
				var html = '<div class="data_div" >'
						+'<div onclick="dataDetails(' + "'"
						+ data.orderno
						+ "','"+data.id+"','"+data.orderstatus+"'"
						+ ')">'
						+ '<div class="data_row data_btm" style="border:none">'
						+'<div class="flt" style="color:#AAAAAA;">'+data.orderno+'</div>'
					
						+ '</div>'
						+ '<div class="data_row" style="border:none">'
						+ ''
						+ '<div class="top_text flt">'
						+ '&nbsp;'+fromaddress+ ' - '+toaddress
						+ '</div>'
						+ '</div>'
						+ '</div>'
						+ '<div class="data_row data_btm" style="border:none">'
						+ ''
						+ '<div style="color:#AAAAAA;">' + goodsName + '</div><div style="color:#FFBB66;">' + weight+data.quoteinfo.goods.freightunit
						+ '</div><div style="color:#AAAAAA;">运费:' + price + '</div>'
						
						+ '<div class="frt flt_left" style="float:right;">'+statusbnt+'</div>';
				html = html + '</div></div>';
				return html;
			}

			window.dataDetails=function(orderno,orderId,status) {
				if(status==2){
					window.location.href = "${wx}/weixin/trade/order_details?id="+orderId;
				}else{
					window.location.href = "${wx}/weixin/trade/order_details?id="+orderId;
				}
			};
			//接受订单受理
			window.orderConfirm = function(id) {
				$("#loading").show();
				$("#"+id).removeAttr("onclick");
				$("#"+id).css("background-color","#ccc");
				$.ajax({
							url : "${wx}/weixin/trade/confrimOrder",
							data : {
								id : id
							},
							dataType : 'json',
							cache : false,
							async:false,
							success : function(data) {
								alert(data.message);
								$("#loading").hide();
								$("#data_box").html("");
								searchData(1);
							}
						});
			};

		});
	</script>
</body>
</html>
