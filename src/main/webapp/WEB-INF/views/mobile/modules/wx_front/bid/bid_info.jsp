<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>${fns:getConst('SYSTEMTITLE')}--招标详情</title>

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
<link href="${ctxStatic}/weixin/css/global.css" rel="stylesheet"
	type="text/css">
<link href="${ctxStatic}/weixin/css/infoHall_detail.css"
	rel="stylesheet" type="text/css">

<style type="text/css">
</style>
<script>
	var _hmt = _hmt || [];
	(function() {
		var hm = document.createElement("script");
		hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
		var s = document.getElementsByTagName("script")[0];
		s.parentNode.insertBefore(hm, s);
	})();
</script>

</head>

<body>
	<div class="data_box">
		<div class="data_top">
			<div class="top_text flt_left">
				<img class="icon" alt="出发地"
					src="${ctxStatic}/images/weixin/img_location_start_point.png">
				<span>${bidinfo.goods.shipAddress.province }&nbsp;${bidinfo.goods.shipAddress.city}</span>
			</div>
			<div class="top_text flt_left">
				<img class="icon" alt="目的地"
					src="${ctxStatic}/images/weixin/img_location_end_point.png">
				<span>${bidinfo.goods.consignAddress.province }&nbsp;${bidinfo.goods.consignAddress.city}</span>
			</div>
		</div>
		<!-- data_top end -->
		<div class="data_center">
			<div class="center_top">
				<div class="ct_left flt_left">
					<div>
						<c:if test="${bidinfo.goods.user.photo!=null !=null }">
							<img class="ic_img ic_imgborder" alt="用户"
								src="${ctxStatic}/images/weixin/ic_user.png">
						</c:if>
						<c:if test="${bidinfo.goods.user.photo!=null ==null }">
							<img class="ic_img ic_imgborder" alt="用户"
								src="${ctxStatic}/images/weixin/ic_user.png">
						</c:if>
					</div>
				</div>
				<div class="ct_center flt_left">
					<div class="ct_lf">
						<div id="usernameval">${bidinfo.biduser.loginName!=null?bidinfo.biduser.loginName:bidinfo.biduser.phone }</div>
					</div>
					<div class="ct_lf">
						<c:choose>
							<c:when test="${bidinfo.biduser.userinfo.status eq '2' }">
								<img class="icon" alt="认证"
									src="${ctxStatic}/images/weixin/rz.png" />
							</c:when>
							<c:otherwise>
								<img class="icon" alt="未认证"
									src="${ctxStatic}/images/weixin/wrz.png" />
							</c:otherwise>
						</c:choose>

						<img class="icon" id="imgCredit"
							src="${ctxStatic}/images/wlptfront/pointlevel/point_level_${bidding.bidinfo.biduser.userinfo.pointlevle!=null?bidding.bidinfo.biduser.userinfo.pointlevle:0}.gif"
							alt="LEVEL1" />
					</div>
				</div>
				<!-- ct_left end -->
				 <div class="ct_right flt_left" style="height:70px;line-height: 70px;color: #cc4c37;">
					<%-- <a style="display: block;" href="tel:${bidinfo.biduser.phone}">
						<img class="ic_img" alt="拨打电话"
						src="${ctxStatic}/images/weixin/ic_call.png">
					</a> --%>
					${bidstatus=='发布'?'竞标中':bidstatus}
				</div> 
			</div>
			<!-- center_top end -->
			<div class="center_bottom">
				<div class="cbm_info">
					<div class="ct_lf">
						<div class="cb_tle">招标文号：</div>
						<div class="cb_val">${bidinfo.bidcode}</div>
					</div>
					<div class="ct_lf">
						<div class="cb_tle">应标次数：</div>
						<div class="cb_val">${bidinfo.biddingcount}次</div>
					</div>
					<div class="ct_lf">
						<div class="cb_tle">招标货物：</div>
						<div class="cb_val">${bidinfo.goods.goodsname}</div>
					</div>
					<div class="ct_lf">
						<div class="cb_tle">招标吨位：</div>
						<div class="cb_val">
							<span id="loadweight">${bidinfo.goods.freightvolume}</span>${bidinfo.goods.freightunit}</div>
					</div>
					
					
					
					<div class="ct_lf">
						<div class="cb_tle">拦标价：</div>
						<div class="cb_val">
							<span id="expectedprice">${bidinfo.expectedprice}</span>元/${bidinfo.goods.freightunit}
						</div>
						<!-- <div class="cb_val_rt">已有<span class="red font_weight font16">200</span>竞价</div> -->
					</div>
					<div class="ct_lf">
						<div class="cb_tle">结算方式：</div>
						<div class="cb_val">
							 ${fns:getDictLabel(bidinfo.settlementtype, 'settlement_type', '')}
						</div>
					</div>
					
					<div class="ct_lf">
						<div class="cb_tle">含税：</div>
						<div class="cb_val">
							<c:choose>
								<c:when test="${bidinfo.isbill eq '0' }">
                            是
                        </c:when>
								<c:otherwise>
                            否
                        </c:otherwise>
							</c:choose>
						</div>
					</div>
					<div class="ct_lf">
						<div class="cb_tle">发布时间：</div>
						<div class="cb_val">
							${bidinfo.publishtimeFM }
						</div>
					</div>
					<div class="ct_lf">
						<div class="cb_tle">截止时间：</div>
						<div class="cb_val" id="endtime">
							${bidinfo.endtimeFM }
						</div>
					</div>
				</div>
			</div>
			<!-- center_bottom end -->
			<div id='loading'
				style='width: 100%; display: none; vertical-align: middle; text-align: center; height: 45px'>
				<div>
					<img src='${ctxStatic}/images/loading-30x30.gif'>
				</div>
				<div style="font-size: 14px; font-weight: bold;" id="loadtext">加载中，请稍等!</div>
			</div>
		</div>
		
	</div>
	<!-- data_box end -->
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/jquery-1.7.2.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/jquery.tips.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/jquery.valid.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/weixin/global.js"></script>
		<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(function() {
			var isDerate=false;
			$.ajax({
				url : "${wlpt}/wlpt/bid/isDerate",
				dataType : 'json',
				data : {},
				type : 'post',
				cache : false,
				async : false,
				success : function(data) {
					if (data) {
		            	isDerate=true;
		            }
				}
			});

			var isderate="0";
			
			var usernameval = $.trim($("#usernameval").html());
			if (usernameval != null && usernameval != ''
					&& usernameval.length > 10) {
				usernameval = usernameval.substring(0, 9) + "…";
				$("#usernameval").html(usernameval);
			}
		});

		//格式数字后面的0
		function geShi(num) {
			if (num != null && num != "") {
				return parseFloat(num);
			} else {
				return "--";
			}
		}
		$("#loadweight").html(geShi($("#loadweight").html()));
		$("#expectedprice").html(geShi($("#expectedprice").html()));
	</script>
</body>
</html>
