<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<html>
<head>

<title>货源报价</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-con trol" content="no-cache">
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

	<style type="text/css">
body {
	padding: 0px;
	margin: 0px;
}

.font-red {
	color: Red
}

input {
	border: none;
	font-size: 18px;
	height: 35px;
	line-height: 35px;
	text-align:left;
}
.input_full{
	width:100%;
}
.input_eigth{
	width:80%;
}
table {
	border: 1px solid #CCC;
	width: 95%;
	margin: 5px auto;
	-moz-border-radius: 4px;
	-webkit-border-radius: 4px;
	border-radius: 4px;
}

table tr {
	line-height: 35px;
}

table tr td {
	border-bottom: 1px solid #CCC;
	font-size: 18px;
	line-height:35px;
}
.span_flt_right {
	float: right;
	text-align: left;
	width: 15%;
}
.btn {
	width: 20%;
	height: 35px;
	line-height:35px;
	border: solid 1px;
	color: #FFFFFF;
	font-size:14px;
	background: rgb(32, 134, 226);;
	cursor: pointer;
	font-weight: bold;
	text-align: center;
	-moz-border-radius: 4px;
	-webkit-border-radius: 4px;
	border-radius: 4px;
}
.data_top,.data_center,.data_bottom {
	width: 97%;
	clear: both;
	margin: 0 auto;
	background-color: #FFF;
}

.data_top {
	width: 97%;
	height: 50px;
	line-height: 50px;
	padding-left: 3%;
	border-bottom: 1px solid #CCC;
}
.data_tab_left {
	width: 50%;
}

.data_tab_right {
	width: 50%;
}
.selected {
	background-color: rgb(32, 134, 226);
	color: #FFF;
}
.data_tab div {
	float: left;
	text-align: center;
}

/**竞价**/
#data_box1 {
	width: 100%;
	margin-top: 8px;
	margin-bottom:30px;
}
.data_div {
	width: 98%;
	background-color: #FFF;
	clear: both;
	height: 190px;
	margin: 0 auto;
	margin-bottom: 5px;
	border:1px solid #CCC;
	padding-top:3px; 
}

.floatl{
	float:left;
}
.floatr{
	float:right;
}

.sub_btn{
	width:95%;
	height:50px;
	font-size:20px;
	text-align:center;
	line-height:45px;
	margin:0 auto;
	margin-top:10px;
	font-weight:bold;
	color:#FFF;
	background-color:rgb(32, 134, 226);
	letter-spacing:10px;
	clear:both;
}
.shang{
    width:100%;
    text-align:center;
    line-height:44px;
}
/*详情
*/
.data_box {
	width: 100%;
	margin: 0 auto;
}
.data_top,.data_center,.data_bottom {
	width: 97%;
	clear: both;
	margin: 0 auto;
	background-color: #FFF;
}

.data_top {
	width:97%;
	height: 50px;
	line-height: 50px;
	padding-left:3%;
	border-bottom: 1px solid #CCC;
}

.data_center {
	width:100%;
}

.data_bottom {
	height: 200px;
	margin-top:20px;
	border-top:1px solid #CCC;
	padding-top:10px;
	padding-left:10px;
}
/*top 信息布局*/
.top_icon {
	width: 25px;
	height: 50px;
	margin-right: 10px;
}

.top_text {
	width: 38%;
	height: 50px;
}

.top_icon img {
	width: 25px;
	margin-top: 5px;
}
/*data_center 信息布局*/
.icon {
	width: 25px;
 }

.ic_img {
	width: 30px;
 }

.center_top,.center_bottom {
	width: 100%;
	padding-top:10px;
 }

.center_top {
	height: 80px;
	border-bottom:1px solid #CCC;
 }

.ct_left {
	width: 84%;
	height: 80px;
 }

.ct_right {
	width: 15%;
	height: 80px;
 }

.split {
	clear: both;
	width: 100%;
	border:1px solid #CCC;
 }

.ct_lf {
	clear: both;
	height: 35px;
	line-height: 25px;
	padding-left: 10px;
 }

.ct_lf div {
	float: left;
 }

#imgCredit{
	margin-top:5px;
 }
.ic_call{
	margin-top:10px;
	width:50px;
 }
.cb_tle{
	width:32.5%;
	text-align:right;
 }
.cb_val{
	width:60%;
 }
.cb_val_rt{
	width:25%
 }
.in_txt{
	border-bottom:1px solid #CCC;
	height:40px;
	font-size:16px;
	width:50%;
 }

.authened {
	color: white;
	margin-right: 5px;
	background: rgb(32, 134, 226);
	font-size: 0.8em;
	vertical-align: text-top;
	padding:5px;
 }
.unauthen {
	color: white;
	margin-left: 5px;
	margin-right: 5px;
	background: rgb(1232,173,109);
	font-size: 0.8em;
	vertical-align: text-top;
 }
.linediv p{
	line-height:20px;
 }
.flt_left{
 float:left;
 }
 /**/
 .result_bottom {
	height: 30px;
	border: none;
	text-align: center;
	line-height: 30px;
	bottom: 0px;
}
.search_top,.result_bottom {
	width: 100%;
	display: block;
	border-bottom: 1px dashed #999;
	z-index: 2;
	position: fixed;
	background-color: #EBEBEB;
}
.search_top{
	height:30px;
	width:100%;
	line-height:33px;
	border-bottom: 1px solid #EBEBEB;
	background-color: #FFF;
	margin:0px auto;
}
.bottom {
	bottom: 0px;
}
</style>
</head>
<body>
		<c:if test="${goods.gsoddtype eq 1 }">
				<div class="data_top data_tab" style="width:100%;padding:0px;">
			<div class="selected data_tab_left">报价列表</div>
			<div class="data_tab_right">运输情况</div>
			</div>
			</c:if>
	<div id="content">
			<input type="hidden" id="isGodsOld" value="${goods.gsoddtype }"/>
			<input type="hidden" id="residualvolume" value="${goods.residualvolume }"/>
			<input type="hidden" id="freightvolume" value="${goods.freightvolume }"/>
			<input type="hidden" id="id" value="${goods.id}"/>
			<input type="hidden" id="orderId" value=""/>
			<input type="hidden" id="orderNo" value=""/>
		<div id="data_box" style="display:none;padding-top:3px;margin-bottom:95px;">
				<div id='loading' style='width:100%;display:none;vertical-align: middle;text-align:center;height:45px'>
				<div>
					<img src='${ctxStatic }/images/weixin/loading-30x30.gif'>
				</div>
				<div style="font-size:14px;font-weight:bold;" id="loadtext">加载中，请稍等!</div>
			</div>

		</div>
		</div>
		<div id="trade_cont" style="display:none;width:100%;">
			<div id="mainWlptInfo"
				style="height:350px;width:350px;display:block;margin:0 auto;margin-top:10px;"></div>
			<div id="data_box" style="margin-bottom:95px;">
				
			</div>
			
		</div>
		<div class="search_top result_bottom bottom" style="height:35px;"><div class="cbm_btn sub_btn" id="" style="display:none;"></div><!-- <div class="cbm_btn sub_btn" id="sub_btn" style="display:none;">生成运单</div> -->
		<div>共<b id="totalCount">0</b>条信息</div></div>
	
	<!-- content-end -->
	<script src="${ctxStatic }/echarts/echarts-all.js"></script>
<script type="text/javascript"
	src="${ctxStatic }/weixin/js/weixin/Chart.js"
	language="javascript"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/jquery-1.7.2.js"></script>
<script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js"></script>

	<script type="text/javascript"
		src="${ctxStatic }/weixin/js/weixin/jquery-ui-1.10.2.custom.min.js"></script>
	<!-- <script type="text/javascript"
		src="static/js/jquery.ui.touch-punch.min.js"></script> -->
		
	<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/jquery.slimscroll.min.js"></script>
	<script type="text/javascript"
		src="${ctxStatic }/weixin/js/weixin/jquery.easy-pie-chart.min.js"></script>
	<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/jquery.flot.pie.min.js"></script>
	<script type="text/javascript"
		src="${ctxStatic }/weixin/js/weixin/jquery.flot.resize.min.js"></script>
	<script src="${ctxStatic }/weixin/js/weixin/ace-elements.min.js"></script>
	<script src="${ctxStatic }/weixin/js/weixin/ace.min.js"></script>
	<script src="${ctxStatic }/weixin/js/weixin/global.js"></script>
	<script src="${ctxStatic }/common/global.js"></script>
	<script type="text/javascript">
		function initChart(chartDom, chartTitle, chartSubtext, legendData,
				seriesData) {
			// 基于准备好的dom，初始化echarts图表
			var myChart = echarts.init(document.getElementById(chartDom));
			option = {
				title : {
					text : chartTitle,
					subtext : chartSubtext,
					x : 'center'
				},
				tooltip : {
					trigger : 'item',
					formatter : "{a} <br/>{b}  ({d}%)"
				},
				legend : {
					orient : 'vertical',
					x : 'left',
					data : legendData
				},
				toolbox : {
					show : false,
					feature : {
						mark : {
							show : false
						},
						dataView : {
							show : false,
							readOnly : false
						},
						magicType : {
							show : false,
							type : [ 'pie', 'funnel' ],
							option : {
								funnel : {
									x : '15%',
									width : '40%',
									funnelAlign : 'left',
									max : 100000
								}
							}
						},
						restore : {
							show : false
						},
						saveAsImage : {
							show : false
						}
					}
				},
				calculable : false,
				series : [ {
					name : chartTitle,
					type : 'pie',
					radius : '50%',
					center : [ '50%', '60%' ],
					data : seriesData
				} ]
			};

			// 为echarts对象加载数据 
			myChart.setOption(option);
		}
		$(function() {
			    var residualvolume = xround($("#residualvolume").val()*1, 3);
			    var freightvolume = xround($("#freightvolume").val()*1, 3);
			    var has = xround(freightvolume*1-residualvolume*1,3);
				var legendData = [ '未拉:' + residualvolume,'已拉:' + has];
							initChart('mainWlptInfo', '运输概况', '单位:吨', legendData, 
									[ {	value : legendData[0].split(':')[1], name : legendData[0]}, 
									  { value : legendData[1].split(':')[1], name : legendData[1]}
									  ]);
		});
	</script>

<script type="text/javascript">

$(function() {
	$(".data_tab div").click(function() {
		tab_i = $(this).index();
		$(this).addClass("selected");
		$(".data_tab div").not(this).removeClass("selected");
		if(tab_i == 0){
			$("#content").show();
			$("#trade_cont").hide();
		}else{
			$("#content").hide();
			$("#trade_cont").show();
		}
	});
	$("#loading").show();
	$("#data_box").show();
	/* $("#sub_btn").show(); */
	//isorder();
	searhTrade();
	
	//条件
	var tab_i=0;
	var searchConditions = {};
	searchConditions.pageSize = 10;
	searchConditions.pageNo = 1;
	var nowpage = 1; ///当前页数
	var nowcount = 1;
	var isGodsOld=$("#isGodsOld").val();
	if(isGodsOld==0||isGodsOld==""){
		$("#sub_btn").html("成品请在平台操作").css("background-color","#CCC");
		$("#sub_btn").unbind();
	}
	searchData(1);  
	//------------------------------------------------

/* $(".data_tab div").click(function() {
	var i = $(this).index();
	$(this).addClass("selected");
	$(".data_tab div").not(this).removeClass("selected");
	if (i == 0) {
		$("#goodsSourcedetails").show();
		$("#data_box").hide();
		$("#sub_btn").hide();
		$("#data_box1").show();
		$("#pages").hide();
		$("#bomtom").hide();
		
	} else {
		$("#goodsSourcedetails").hide();
		$("#data_box").show();
		$("#sub_btn").show();
		$("#data_box1").hide();
	/* 	$("#pages").show(); */
		/* $("#bomtom").show(); */
		/*  searchData(1); */ 
	/* } */
/* }); */ 
	/* $("body").scroll(function(){
		alert("---");
		var winPos = $(ducument).scrollTop();
	}); */
	$(window).scroll(function() {
			if(tab_i==1){
				return;
			}
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
				if (nowpage <= parseInt(pageCount)) {
					searchData(nowpage);
				}

			}
			});
	
	function searhTrade(){
		$.ajax({
			type : "POST",
			url : '${wx}/weixin/goodssource/dataTradeQuote',
			data : {id:$("#id").val()},
			dataType : 'json',
			cache : false,
			success : function(data) {
				if (data.value.list!=null) {
					if (data.data.length <= 0) {
						$("#trade_cont #data_box").show().append('<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
					} else {
						var fillDatas = "";
						for (var i = 0; i < data.value.list.length; i++) {
							fillDatas += fillTradeDataOne(data.value.list[i]);
						}
						/* $("#data_box").html(""); */
						$("#trade_cont #data_box").append(fillDatas);
					}
				} else {
					$("#trade_cont #data_box").html("");
					$("#trade_cont #data_box").show().append('<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
				}
			}
		});
	};
	//查询数据ajax
	function searchData(pageNo) {
		$("#loading").show();
		$("#page").hide();
		searchConditions.id=$("#id").val();
		//$("#data_box").html("");         
		searchConditions.pageNo = pageNo;
		$.ajax({
					type : "POST",
					url : '${wx}/weixin/goodssource/getQuote',
					data : searchConditions,
					dataType : 'json',
					cache : false,
					success : function(data) {
						if (data.value.list != null) {
							if (data.value.list.length <= 0) {
								$("#data_box").show().append('<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
							} else {
								$("#page").show();
								nowcount = data.value.count;
								$("#pageCount").html(Math.ceil(data.value.count / data.value.pageSize));
								//$("#allCount").html(data.data.ALLCOUNT);
								$("#curPage").html(
										searchConditions.pageNo);
								$("#totalCount").html(nowcount);
								var fillDatas = "";
								for (var i = 0; i < data.value.list.length; i++) {
									fillDatas += fillDataOne(data.value.list[i]);
								}
								/* $("#data_box").html(""); */
								$("#data_box").append(fillDatas);
								$("#sub_btn").show();
							}
						} else {
							$("#data_box").html("");
							$("#data_box").show().append('<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
							$("#sub_btn").hide();
						}
						$("#loading").css('display', 'none');
						$("#loading").hide();
						
					}
				});
	}

	/***************填充到页面的数据***************/
	function fillDataOne(data) {
		var name=data.user.loginName!=null?data.user.loginName:data.user.name;
		if(name==null || name==""){
			name=data.user.userinfo.companyname;
		}
		var level = 0;
		if(data.user.userinfo!=undefined && data.user.userinfo != null){
			level = data.user.userinfo.pointlevle;
			if(level==undefined ||level == null ||level==""){
				level= 0 ;
			}
		}
		if(level==undefined ||level==null ||level==''){
			level= 0;
		}
		var ooferprice = data.ooferprice;
		if(ooferprice==undefined||ooferprice==null||ooferprice==''){
			ooferprice=0;
		}
		var oddloadweight = data.oddloadweight;
		if(oddloadweight==undefined||oddloadweight==null||oddloadweight==''){
			oddloadweight=0;
		}
		var carnumber = data.car.carnumber;
		if(carnumber==undefined||carnumber==null||carnumber==''){
			carnumber=0;
		}
		
		var carid = data.car.id;
		if(carid == undefined || carid == null || carid == ''){
			carid = 0;
		}
		
		var cartype = data.car.cartype;
		if(cartype == undefined || cartype == null || cartype == ''){
			cartype = 0;
		}
		
		var carlength = data.car.carlength;
		if(carlength == undefined || carlength == null || carlength == ''){
			carlength = 0;
		}
		
		var html='<div class="data_div" onclick="checks('+ "''"+data.car.id+"''"+')">'
		+'<div class="shang" ><div style="width:10%" class="floatl"><!-- <input type="radio"  name="radio" value="'+data.id+'/'+ooferprice+"/"+data.oddloadweight+'"/> --></div><div class="floatl" style="text-overflow: ellipsis;white-space:nowrap;overflow:hidden;margin-left: 30px;"><span >'+name+'</span></div>'
		+'<div class="floatl" style="padding-left:1%;"><img alt="荣誉" src="${ctxStatic }/images/wlptfront/pointlevel/point_level_'+level+'.gif" style="padding:15px 0;"></div><div class="floatr" style="padding-right:6%;color:#AAAAAA;">'+oddloadweight+'吨</div></div>'
		+'<div style="width:100%;"><div style="border-bottom:1px solid #CCC;width:90%;margin-left:8%;" class="floatl"></div></div>'
		+'<div style="width:90%;text-align:center;padding-left:10%;line-height:48px;" class="floatl"><div style="width:5%" class="floatl"></div><div style="width:36%;" class="floatl"><span style="font-size:18px;float:left;color:#FFBB66;">'+'车型:'+cartype+'</span></div>'
		+'<div style="float: right;text-align: right;padding-right: 6%;width:50%;height:25%;color:#AAAAAA;" class="floatl">'+'车长:'+carlength+'米'+'</div><!-- <div style="width:50%;display:none;" class="floatl">最近成交10单</div> --></div>'
		+'<div style="width:100%;"><div style="border-bottom:1px solid #CCC;width:90%;margin-left:8%;" class="floatl"></div></div>'
		+'<div style="width:90%;text-align:center;padding-left:10%;line-height:48px;" class="floatl"><div style="width:5%" class="floatl"></div><div style="width:36%;" class="floatl"><span style="font-size:18px;float:left;color:#FFBB66;">'+'车牌号:'+'</span></div>'
		+'<div style="float: right;text-align: right;padding-right: 6%;width:50%;height:25%;color:#AAAAAA;" class="floatl">'+carnumber+'</div><!-- <div style="width:50%;display:none;" class="floatl">最近成交10单</div> --></div>'		
		+'<div style="width:100%;"><div style="border-bottom:1px solid #CCC;width:90%;margin-left:8%;" class="floatl"></div></div>'
		+'<div style="width:90%;text-align:center;padding-left:10%;line-height:48px;" class="floatl"><div style="width:5%" class="floatl"><img alt="" src="${pageContext.request.contextPath}/static/images/weixin/money.png" style="padding-top:12px;"/></div><div style="width:36%;" class="floatl"><span style="font-size:18px;float:left;color:#FFBB66;">'+ooferprice+'</span></div>'
		+'<div style="float: right;text-align: right;padding-right: 6%;width:50%;height:25%;color:#AAAAAA;" class="floatl">'+data.beginCreateDate+'</div><!-- <div style="width:50%;display:none;" class="floatl">最近成交10单</div> --></div>'
		+'</div>';
		return html;
	}
	
	function fillTradeDataOne(data) {
		var name=data.user.loginName!=null?data.user.loginName:data.user.name;
		if(name==null || name==""){
			name=data.user.userinfo.companyname;
		}
		var level = data.POINTLEVEL;
		if(level==undefined ||level==null ||level==''){
			level= 0;
		}
		var ooferprice = data.ooferprice;
		if(ooferprice==undefined||ooferprice==null||ooferprice==''){
			ooferprice=0;
		}
		var oddloadweight = data.oddloadweight;
		if(oddloadweight==undefined||oddloadweight==null||oddloadweight==''){
			oddloadweight=0;
		}
		var html='<div class="data_div">'
		+'<div class="shang" ><div class="floatl" style="text-overflow: ellipsis;white-space:nowrap;overflow:hidden;"><span >'+name+'</span></div>'
		+'<div class="floatl" style="padding-left:1%;"><img alt="荣誉" src="${ctxStatic }/images/wlptfront/pointlevel/point_level_'+level+'.gif" style="padding:15px 0;"></div><div class="floatr" style="padding-right:4%;">'+oddloadweight+'吨</div></div>'
		+'<div style="width:100%;"><div style="border-bottom:1px solid #CCC;width:90%;margin-left:8%;" class="floatl"></div></div>'
		+'<div style="width:90%;text-align:center;padding-left:10%;line-height:48px;" class="floatl"><div style="width:5%" class="floatl"><img alt="" src="${pageContext.request.contextPath}/static/images/weixin/money.png" style="padding-top:12px;"/></div><div style="width:36%;" class="floatl"><span style="font-size:18px;float:left;">'+ooferprice+'</span></div>'
		+'<div style="width:50%;height:50%;text-align:center;" class="floatl">'+data.beginCreateDate+'</div><!-- <div style="width:50%;display:none;" class="floatl">最近成交10单</div> --></div>'
		+'</div>';
		return html;
	}
function isorder(){
	$("#loading").show();
	var id=$("#id").val();
 	$.ajax({
		url: "${pageContext.request.contextPath}/weixin/quote/isOrders",
		data:{id:id},
		type:'post',
		dataType:'json',
		cache : false,
		success:function(data){
				if(data.state=="2"){
					$('#sub_btn').show();
					$("#loadtext").html("该货源已经生成运单");
/* 					$("#sub_btn").html(data.message).css("background-color","rgb(146, 154, 160)"); */
					$("#sub_btn").html("查看运单详情");
					$("#orderId").val(data.data.Order_Id);
					$("#orderNo").val(data.data.OrderNo);
					searchData(1); 
					/* $('#sub_btn').unbind(); */
					}else if(data.state=="1"){
						 searchData(1);  
					}
		}
	}); 
}
/* window.dataDetails=function(id,orderId) {
	window.location.href = "${pageContext.request.contextPath}weixin/trade/order_details?ORDERNO="+ id+"&ORDERID="+orderId;
}	 */
	$("#sub_btn").click(function(){
		if(!($("#orderId").val()!=null&&$("#orderId").val()!="")){
		var val_checkeds = $('input[name="radio"]:checked ').val();
		var val_checked="";
		var ooprices="";
		var oddloadweight="";
		if(val_checkeds!=""&&val_checkeds!=null){
			var checked_val=val_checkeds.split("/");
			val_checked=checked_val[0];
			ooprices=checked_val[1];
			oddloadweight=checked_val[2];
		}
		var id=$("#id").val();

		if ($(":radio:checked").length == 0)
		{
			$('#sub_btn').html("请选择一条信息");
		}else{
			$("#loading").show();
			$("#sub_btn").hide();

		}
			if ($(":radio:checked").length == 0)
			{
				$('#sub_btn').html("请选择一条信息");
			}
			else{
			$.ajax({
				url: "${pageContext.request.contextPath}/weixin/quote/saveOrderwx",
				data:{id:id,QUOTEINFO_ID:val_checked,OOPRICE:ooprices,ODDLOADWEIGHT:oddloadweight},
				type:'post',
				dataType:'json',
				cache : false,
				success:function(data){
						if(data.state=="1"){
								$("#loadtext").html("保存成功");
								$('#sub_btn').html("生成运单成功");
								$('#sub_btn').unbind();
							}else{
								$("#loadtext").html(data.message);
								$("#sub_btn").html(data.message).css("background-color","rgb(146, 154, 160)");
								$('#sub_btn').unbind();
						}
								$("#loading").hide();
								$("#sub_btn").show();
						window.setTimeout(altmesg, "5000");
				}
			});
			}
		}else{

			var id=$("#orderId").val();
			var no=$("#orderNo").val();
			window.location.href = "weixin/trade/order_details?ORDERNO="+no+"&ORDERID="+id;
		}
	});
	window.altmesg=function(){
		window.location.href="${pageContext.request.contextPath}/weixin/goodsSource/goods_list";
	  $("#sub_btn").show();
		$("#loading").hide();
		$("#loadtext").html("小卓正在努力加载，请稍等！");
  };
  
});
	//选择按钮事件
/*  	function checks(id){
           $('#data_box .data_div').bind('click', function () {
				$(this).find("input[type=radio]").attr("checked", 'checked');
				getcarinfo(id);
			});  
		}  */

</script>
</body>
</html>
