 <%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<html>
<head>

<title>${fns:getConst('SYSTEMTITLE')}--车辆信息</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
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
	<link href="${ctxStatic }/weixin/css/global.css" rel="stylesheet" type="text/css">
	<link href="${ctxStatic }/weixin/css/infoHall_detail.css" rel="stylesheet" type="text/css">
	<style type="text/css">
		.ct_center .ct_lf {
			height: 40px;
			line-height: 40px;
		}
	</style>
</head>

<body>
<div class="data_box">
<%-- 	<div class="data_top">
		<div class="top_icon flt_left" style="padding-left:10px;"><img alt="出发地" src="${pageContext.request.contextPath}/static/images/weixin/ic_start.png"></div>
		<div class="top_text flt_left">${result.data.FROMPROVINCE }&nbsp;${result.data.FROMCITY }</div>
		<div class="top_icon flt_left"><img alt="目的地" src="${pageContext.request.contextPath}/static/images/weixin/ic_end.png"></div>
		<div class="top_text flt_left">${result.data.TOPROVINCE }&nbsp;${result.data.TOCITY }</div>
	</div> --%><!-- data_top end -->
	<div class="data_center">
		<div class="center_top">
			<div class="ct_left flt_left">
				<div>
					<c:if test="${car.user.photo!=null }">
						<img class="ic_img ic_imgborder" alt="用户" src="${car.user.photo}">
					</c:if>
					<c:if test="${car.user.photo==null }">
						<img class="ic_img ic_imgborder" alt="用户" src="${ctxStatic }/images/weixin/ic_user.png">
					</c:if>
				</div>
			</div>

			<div class="ct_center flt_left">
				<div class="ct_lf">
					${car.ownername!=null?car.ownername:car.user.name }
					<img class="icon" alt="用户" src="${ctxStatic }/images/weixin/personal_certificate.png"/>
				</div>
				<div class="ct_lf">
					<div>${car.ownermobile!=null?car.ownermobile:car.user.phone }</div>
				</div>

			</div>

			<div class="ct_right flt_left" >
				<a style="display:block;" href="tel:${car.ownermobile!=null?car.ownermobile:car.user.phone}"><img class="ic_img" alt="拨打电话"
																					 src="${ctxStatic }/images/weixin/ic_call.png"></a>
			</div><!-- ct_right end -->
		</div><!-- center_top end -->
		<div class="center_bottom">
			<div class="cbm_info">
<%-- 			<div class="ct_lf">
					<div class="cb_tle">交易量：</div>
					<div class="cb_val">${result.data.TRADECOUNT}次</div>
				</div> --%>
				<div class="ct_lf border">
					<div class="cb_tle" >车牌号码：</div>
					<div class="cb_val" >${car.carnumber}
						<%-- <c:if test="${sessionScope.USERPD.ROLE_CODE ne 'carowner' }"><div class="addCar" id="addCar">加入车队</div></c:if> --%>
					</div>
				</div>
				<div class="ct_lf border">
					<div class="cb_tle">车辆信息：</div>
					<div class="cb_val">${car.cartype}&nbsp;${car.carlength}米&nbsp;${car.loadweight}${car.weightunit!=null?car.weightunit:"吨"}</div>
				</div>
				<div class="ct_lf border">
					<div class="cb_tle">始发地：</div>
					<div class="cb_val">${car.fromaddress}
				</div>
				</div>
								<div class="ct_lf border">
					<div class="cb_tle">目的地：</div>
					<div class="cb_val">${car.toaddress}</div>
				</div>
<%-- 				<div class="ct_lf">
					<div class="cb_tle">最新定位：</div>
					<div class="cb_val">${result.data.INFO!=null?result.data.INFO:"暂无位置信息"}</div>
				</div> --%>
			<!-- 	<div class="ct_lf" id="wantBid">

				</div> -->
			</div><!-- cbm_info end -->
		</div><!-- center_bottom end -->
<!-- 		<div id='loading' style='width:100%;display:none;vertical-align: middle;text-align:center;height:45px'>
				<div>
					<img src='static/images/loading-30x30.gif'>
				</div>
				<div style="font-size:14px;font-weight:bold;" id="loadtext">加载中，请稍等!</div>
			</div> -->
	</div><!-- data_center end -->

	<div class="data_bottom">
		<div style="font-size:20px;margin-top:10px;padding-left: 10px">主营线路：</div>
		<c:choose>
			<c:when test="${car.mainroad!=null}"><p class="center">${car.mainroad}</p></c:when>
			<%-- 		<c:when test="${carPd.data.linepd.fromAddress2!=null}"><p>线路2：${carPd.data.linepd.fromAddress2}--${carPd.data.linepd.toAddress2}</p></c:when>
                    <c:when test="${carPd.data.linepd.fromAddress3!=null}"><p>线路3：${carPd.data.linepd.fromAddress3}--${carPd.data.linepd.toAddress3}</p></c:when> --%>
			<c:otherwise>暂无线路</c:otherwise>
		</c:choose>
	</div><!-- data_bottom end -->

	<p align="center" style="margin-top:20px;padding-bottom: 30px;">
				<c:if test="${car.status==0||car.status==3 }">
				<button class="regbt" id="btnSubmit" style="width:45%;">
					<span style="margin-top: -1px;" onclick="apply('${car.id}')">申请认证</span>
				</button>
				<button class="regbt" id="btnSubmit" style="width:45%;">
					<span style="margin-top: -1px;" onclick="Edit('${car.id}')">编辑</span>
				</button>
				</c:if>
			</p>
		
	<!-- <div style="background-color:#EBEBEB;height:10px;"></div> -->

</div><!-- data_box end -->
	<script type="text/javascript" src="${ctxStatic }/weixin/js/jquery-1.7.2.js"></script>
	<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/global.js"></script>
	<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/jquery.gridSelector.js"></script>
	<script type="text/javascript">
	
	window.Edit=function(id){
		window.location.href="${wx}/weixin/car/toSave?id=" + id;
		
	};
	window.apply=function(id){
		window.location.href="${wx}/weixin/car/carApply?id=" + id;
		
	};
	//格式数字后面的0
	function geShi(num){
		if(num!=null&&num!=""){
			return parseFloat(num);
		}else{
			return "--";
		}
	}
	$("#loadweight").html(geShi($("#loadweight").html()));
	$("#RESIDUALWEIGHT").html(geShi($("#RESIDUALWEIGHT").html()));
	$("#worth").html(geShi($("#worth").html()));
	

	
	</script>
</body>
</html>
