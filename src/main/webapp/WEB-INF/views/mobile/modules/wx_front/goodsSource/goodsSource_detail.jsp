<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>${fns:getConst('SYSTEMTITLE')}--货源信息</title>

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

<script type="text/javascript">
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
<link href="${ctxStatic}/weixin/css/infoHall_detail.css"
	rel="stylesheet" type="text/css">

<style type="text/css">
</style>
</head>

<body>
	<div class="data_box">
		<div class="data_top">
			<div class="top_text flt_left">
				<img class="icon" alt="出发地"
					src="${ctxStatic}/images/weixin/img_location_start_point.png">
				<span>${goods.shipAddress.province}&nbsp;${goods.shipAddress.city }</span>
			</div>
			<div class="top_text flt_left">
				<img class="icon" alt="目的地"
					src="${ctxStatic}/images/weixin/img_location_end_point.png">
				<span>${goods.consignAddress.province}&nbsp;${goods.consignAddress.city }</span>
			</div>
		</div>
		<!-- data_top end -->
		<div class="data_center">
			<div class="center_top">
				<div class="ct_left flt_left" style="border-radius: 5px;">
					<div>
						<c:if test="${goods.user.photo!=null }">
							<img class="ic_img ic_imgborder" alt="用户"
								src="${ctxStatic}/images/weixin/ic_user.png">
						</c:if>
						<c:if test="${goods.user.photo==null }">
							<img class="ic_img ic_imgborder" alt="用户"
								src="${ctxStatic}/images/weixin/ic_user.png">
						</c:if>
					</div>
				</div>
				<div class="ct_center flt_left">
					<div class="ct_lf">
						<div id="usernameval">${goods.user.loginName!=null?goods.user.loginName:goods.user.phone }</div>
					</div>
					<div class="ct_lf">
						<c:choose>
							<c:when test="${goods.user.userinfo.status eq '2' }">
								<img class="icon" alt="认证"
									src="${ctxStatic}/images/weixin/rz.png" />
							</c:when>
							<c:otherwise>
								<img class="icon" alt="未认证"
									src="${ctxStatic}/images/weixin/wrz.png" />
							</c:otherwise>
						</c:choose>
						<img class="icon" id="imgCredit"
							src="${ctxStatic}/images/wlptfront/pointlevel/point_level_${goods.user.userinfo.pointlevle!=null?goods.user.userinfo.pointlevle:0}.gif"
							alt="LEVEL1" />
					</div>
				</div>
				<!-- ct_left end -->
				<div class="ct_right flt_left">
					<a style="display: block;" href="tel:${goods.user.phone}"> <img
						class="ic_img" alt="拨打电话"
						src="${ctxStatic}/images/weixin/ic_call.png">
					</a>
				</div>
			</div>
			<!-- center_top end -->
			<div class="center_bottom">
				<div class="cbm_info">
					<div class="ct_lf">
						<div class="cb_tle">发布时间：</div>
						<div class="cb_val">
							<fmt:formatDate value="${goods.createDate}" />
						</div>
					</div>
					<div class="ct_lf">
						<div class="cb_tle">货物名称：</div>
						<div class="cb_val">${goods.goodsname}</div>
					</div>
					<div class="ct_lf">
						<div class="cb_tle">重量/体积：</div>
						<div class="cb_val">
							<span id="loadweight">${goods.freightvolume}</span>${goods.freightunit}<c:if
								test="${goods.gsoddtype eq 2 }">/剩余<span
									id="RESIDUALWEIGHT">${goods.residualvolume}</span>${goods.freightunit}</c:if>
						</div>
					</div>
					<div class="ct_lf">
						<div class="cb_tle">货主出价：</div>
						<div class="cb_val">
							<span id="worth">${goods.expectedprice}</span>元/${goods.freightunit}
						</div>
					</div>
					<div class="ct_lf">
						<div class="cb_tle">选择车辆：</div>
						<div class="cb_val">
							<select name="carid" id="carid" style="border: 0;">
								<c:choose>
									<c:when test="${not empty car}">
										<c:forEach items="${car}" var="c" varStatus="s">
											<option value="${c.id}">${c.carnumber}</option>
										</c:forEach>
									</c:when>
								</c:choose>
							</select>
						</div>
					</div>
					<div class="ct_lf">
						<div class="cb_tle">选择司机：</div>
						<div class="cb_val">
							<select name="driverid" id="driverid" style="border: 0;">
								<c:choose>
									<c:when test="${not empty driver}">
										<c:forEach items="${driver}" var="dr" varStatus="i">
											<option value="${dr.reuser.id}">
												${dr.reuser.name}&nbsp;${dr.reuser.phone}</option>
										</c:forEach>
									</c:when>
								</c:choose>
							</select>
						</div>
					</div>
					<div class="ct_lf">
						<div class="cb_tle">我要拉：</div>
						<div class="cb_val">
							<input class="in_txt" id="carLoadWeight" maxlength="12"
								type="text" />吨
						</div>
					</div>
					<div class="ct_lf" id="wantBid">
						<div class="cb_tle">我的出价：</div>
						<div class="cb_val">
							<input class="in_txt" id="bidPrice" type="text" value="" />元/${goods.freightunit}
						</div>
					</div>
				</div>
				<!-- cbm_info end -->
				<div class="cbm_btn sub_btn" id="sub_btn"
					style="font-size: 1.2em; background: rgba(32, 162, 226, 0.87);">抢单</div>
				<!-- cbm_btn end -->
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
		<!-- data_center end -->
		<div class="data_bottom">
			<input type="hidden" id="gsid" value="${goods.id}" />
			<div style="font-size: 20px; margin-top: 10px; padding-left: 10px">抢单规则</div>
			<ol>
				<li>参与抢单的用户必须为平台认证会员。</li>
				<li>竞价抢单提交后，同一货源的不可进行二次抢单。</li>
				<li>抢单结束后，成功抢单者保证金由平台暂时扣除，未成功的会员全额退还保证金。</li>

			</ol>
		</div>
		<!-- data_bottom end -->
	</div>
	<!-- data_box end -->
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/jquery-1.7.2.js"></script>
	<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
    <script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/weixin/global.js"></script>
	<script type="text/javascript"
		src="${ctxStatic}/weixin/js/jquery.gridSelector.js"></script>
	<script type="text/javascript">
		$(function() {
			//格式用户名长度
			var usernameVal = $.trim($("#usernameval").html());
			if (usernameVal != null && usernameVal != ''
					&& usernameVal.length > 10) {
				usernameVal = usernameVal.substring(0, 9) + "…";
				$("#usernameval").html(usernameVal);
			}
			$("#sub_btn").click(
					function() {
						if (!checkInfo()) {
							return;
						}

						$("#loading").show();
						$("#sub_btn").hide();
						var gdsid = $("#gsid").val();
						var driverid = $("#driverid").val();
						var carid = $("#carid").val();
						var ooferprice = $("#bidPrice").val();
						var oddloadweight = $("#carLoadWeight").val();
						$.ajax({
							type : "POST",
							url : '${wx}/weixin/goodssource/saveQuote',
							dataType : 'json',
							data : {
								'goods.id' : gdsid,
								'driver.id' : driverid,
								'car.id' : carid,
								'ooferprice' : ooferprice,
								'oddloadweight' : oddloadweight

							},
							cache : false,
							success : function(data) {
								/* jBox.tip(data.value,'warning'); */
								$("#loadtext").html(data.value);
								$('#sub_btn').html(data.value).css(
										"background-color",
										"rgb(146, 154, 160)");
								$('#sub_btn').unbind();
								$("#loading").hide();
								$("#sub_btn").show();
							}
						});
					});
		});
		window.checkInfo = function() {
			var isnul = true;
			var residweight = '${goods.residualvolume}';
			var carLoadweight = $("#carLoadWeight").val() * 1;
			isnul = isnul && $("#carid").valid({
				methods : "required"
			});
			isnul = isnul && $("#driverid").valid({
				methods : "required"
			});
			isnul = isnul && $("#bidPrice").valid({
				methods : "required|decimalTwo"
			});
			isnul = isnul && $("#carLoadWeight").valid({
				methods : "required|decimal"
			});
			if (isnul) {
				var money = $("#bidPrice").val() * 1;
				if (money < 1) {
					$("#bidPrice").tips({
						side : 3,
						msg : '报价必须大于1元！',
						bg : '#AE81FF',
						time : 2
					});
					isnul = false;
					return isnul;
				}
				/* if ($("#goodsOddType").val() == 1) { */
					if (residweight*1 < carLoadweight*1||carLoadweight*1<=0) {
						$("#carLoadWeight").tips({
							side : 3,
							msg : '剩余吨位为' + residweight + '吨！',
							bg : '#AE81FF',
							time : 2
						});
						$("#carLoadWeight").val(residweight);
						isnul = false;
						return isnul;
					}
				/* } */
			}
			return isnul;
		};
		//格式数字后面的0
		function geShi(num) {
			if (num != null && num != "") {
				return parseFloat(num);
			} else {
				return "--";
			}
		}
		$("#loadweight").html(geShi($("#loadweight").html()));
		$("#RESIDUALWEIGHT").html(geShi($("#RESIDUALWEIGHT").html()));
		$("#worth").html(geShi($("#worth").html()));
	</script>
</body>
</html>
