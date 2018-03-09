 <%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<html>
<head>

<title>${fns:getConst('SYSTEMTITLE')}--报价信息</title>

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
		.authened {
		    background-color: rgba(20, 181, 47, 0.83);
		    -moz-border-radius: 6px;
		    -webkit-border-radius: 6px;
		    border-radius: 6px;
		}
	</style>
</head>

<body style="background-color:#EBEBEB;">
<div class="data_box">
	<!-- data_top end -->
	<div class="data_center" >
		<div class="center_top">
			<div class="ct_left flt_left">
				<div>
					<c:if test="${quoteinfo.driver.photo!=null }">
						<img class="ic_img ic_imgborder" alt="用户" src="${quoteinfo.driver.photo}">
					</c:if>
					<c:if test="${quoteinfo.driver.photo==null }">
						<img class="ic_img ic_imgborder" alt="用户" src="${ctxStatic }/images/weixin/ic_user.png">
					</c:if>
				</div>
			</div>

			<div class="ct_center flt_left">
				<div class="ct_lf">
					${quoteinfo.driver.name!=null?quoteinfo.driver.name:quoteinfo.driver.loginName }
					<img class="icon" alt="用户" src="${ctxStatic }/images/weixin/personal_certificate.png"/>
				</div>
				<div class="ct_lf">
					<div>${quoteinfo.driver.phone}</div>
				</div>

			</div>

			<div class="ct_right flt_left" >
				<a style="display:block;" href="tel:${quoteinfo.driver.phone}"><img class="ic_img" alt="拨打电话"
																					 src="${ctxStatic }/images/weixin/ic_call.png"></a>
			</div><!-- ct_right end -->
		</div><!-- center_top end -->
		<div class="center_bottom" >
			<div class="cbm_info">
				<div class="ct_lf border">
					<div class="cb_tle" >报价吨位：</div>
					<div class="cb_val" >${quoteinfo.oddloadweight}吨
					</div>
				</div>
				<div class="ct_lf border">
					<div class="cb_tle">本次报价：</div>
					<div class="cb_val">${quoteinfo.ooferprice}元/吨</div>
				</div>
				<div class="ct_lf border">
					<div class="cb_tle" >状态：</div>
					<div class="cb_val" ><span class="authened" style="line-height:30px;">${fns:getDictLabel(quoteinfo.quotestatus, 'quotestatus', '')}</span>
					</div>
				</div>
				<div class="ct_lf border">
					<div class="cb_tle">报价时间：</div>
					<div class="cb_val"><fmt:formatDate value="${quoteinfo.beginCreateDate}" pattern="yyyy-MM-dd"/></div>
				</div>
			</div><!-- cbm_info end -->
		</div><!-- center_bottom end -->
		<div class="center_bottom" style="border-top: 1px solid #ccc;">
			<div class="cbm_info">
				<div class="ct_lf border">
					<div class="cb_tle" >货物名称：</div>
					<div class="cb_val" >${quoteinfo.goods.goodsname}
					</div>
				</div>
				<div class="ct_lf border">
					<div class="cb_tle">货物重量：</div>
					<div class="cb_val">${quoteinfo.goods.freightvolume}吨</div>
				</div>
				<div class="ct_lf border">
					<div class="cb_tle" >期望报价：</div>
					<div class="cb_val" >${quoteinfo.goods.expectedprice} 元/吨
					</div>
				</div>
			</div><!-- cbm_info end -->
		</div><!-- center_bottom end -->
		<div class="center_bottom"  style="border-top: 1px solid #ccc;">
			<div class="cbm_info">
				<div class="ct_lf border">
					<div class="cb_tle" >车牌号码：</div>
					<div class="cb_val" >${quoteinfo.car.carnumber}
						
					</div>
				</div>
				<div class="ct_lf border">
					<div class="cb_tle">车辆信息：</div>
					<div class="cb_val">${quoteinfo.car.cartype}&nbsp;${quoteinfo.car.carlength}米&nbsp;${quoteinfo.car.loadweight}${quoteinfo.car.weightunit!=null?quoteinfo.car.weightunit:"吨"}</div>
				</div>
			
			</div><!-- cbm_info end -->
		</div><!-- center_bottom end -->
	</div><!-- data_center end -->
	

</div><!-- data_box end -->
	<script type="text/javascript" src="${ctxStatic }/weixin/js/jquery-1.7.2.js"></script>
	<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/global.js"></script>
	<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/jquery.gridSelector.js"></script>
	<script type="text/javascript">
	

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
