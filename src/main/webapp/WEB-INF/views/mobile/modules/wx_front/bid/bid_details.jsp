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
				<div class="ct_right flt_left">
					<a style="display: block;" href="tel:${bidinfo.biduser.phone}">
						<img class="ic_img" alt="拨打电话"
						src="${ctxStatic}/images/weixin/ic_call.png">
					</a>
				</div>
			</div>
			<!-- center_top end -->
			<div class="center_bottom">
				<div class="cbm_info">
					<div class="ct_lf">
						<div class="cb_tle">货物名称：</div>
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
						<div class="cb_tle">截止时间：</div>
						<div class="cb_val" id="endtime">
							<fmt:formatDate value="${bidinfo.endtime }" />
						</div>
					</div>
					<div class="ct_lf">
						<div class="cb_tle">结算方式：</div>
						<div class="cb_val">
							<c:choose>
								<c:when test="${bidinfo.paytype eq '0' }">
                            回执单现金结算
                        </c:when>
								<c:otherwise>
                            其他
                        </c:otherwise>
							</c:choose>
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
					<div class="ct_lf" id="wantBid">
						<div class="cb_tle">我要竞价：</div>
						<div class="cb_val">
							<input class="in_txt" id="bidPrice" maxlength="6" type="text"
								value="" />元/吨
						</div>
					</div>
					<div class="ct_lf" style="color: #F74000;">
						<div class="cb_tle">缴纳保证金：</div>
						<div class="cb_val">
							<span style="color: red; font-weight: bold;">1000</span>元 <input
								type="hidden" id="bidinfoid" value="${bidinfo.id}" />
						</div>
					</div>
				</div>
				<!-- cbm_info end -->
				<div class="cbm_btn sub_btn" id="sub_btn"
					style="font-size: 1.2em; background: rgba(32, 162, 226, 0.87);">提交竞价</div>
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
			<c:if test="${bidinfo.remarks!=null && bidinfo.remarks!=''}">
				<div style="font-size: 20px;">本标要求</div>
				<div
					style="line-height: 20px; font-size: 14px; margin-top: 10px; padding-left: 10px;">
					${bidinfo.remarks}</div>
			</c:if>
			<div style="font-size: 20px; margin-top: 10px; padding-left: 10px">投标须知</div>
			<ol>
				<li>参与招投标的用户必须为平台认证会员。</li>
				<li>单次竞价投标，需缴纳1000元/标投标保证金。账户余额不足，无法参与投标。</li>
				<li>竞价投标提交后，同一标的不可进行二次投标。</li>
				<li>投标结束后，中标者保证金由平台暂时扣除，未中标的会员全额退还保证金。</li>

			</ol>

		</div>
		<!-- data_bottom end -->
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
			$("#sub_btn").click(
					function() {
						if (!checkInfo()) {
							return;
						}
						$("#loading").show();
						$("#sub_btn").hide();

						var bidinfo_id = $("#bidinfoid").val();
						if(isDerate){
			                $.MsgBox.Confirm("交易提示","您有一次减免保证金的资格,是否使用?",function(){
			                	isderate="1";
			                	saveBidding();
			                },function(){
			                	saveBidding();
			                },null,null,"是","否");
			            }else{
			            	saveBidding();
			            }
						window.saveBidding=function(){
							$.ajax({
								url : "${wx}/weixin/bid/bidding",
								dataType : 'json',
								data : {
									biddingprice : $("#bidPrice").val(),
									"bidinfo.id" : bidinfo_id,
									isderate : isderate
								},
								type : 'post',
								cache : false,
								async : false,
								success : function(data) {
									/*  $.alert(data.message); */
									if (data.state == 1) {
										$("#loadtext").html(data.message);
										$("#sub_btn").html(data.message).css(
												"background-color",
												"rgb(146, 154, 160)");
									} else {
										$("#loadtext").html(data.message);
										$("#sub_btn").html(data.message).css(
												"background-color",
												"rgb(146, 154, 160)");
									}
									$('#sub_btn').unbind();
									$("#loading").hide();
									$("#sub_btn").show();
								}

							});
						}
						
					});
		});
		window.checkInfo = function() {
			var isnul = true;
			var exprice = $("#expectedprice").html() * 1;
			var money = $("#bidPrice").val() * 1;
			isnul = isnul && $("#bidPrice").valid({
				methods : "required|isdecimal",
				tipSide : "3"
			});
			if (isnul) {
				if (money < 1) {
					$("#bidPrice").tips({
						side : 3,
						msg : '竞价金额必须大于1元！',
						bg : '#AE81FF',
						time : 2
					});
					isnul = false;
				}
			}
			if (isnul) {
				if (money > exprice) {
					$("#bidPrice").tips({
						side : 3,
						msg : '竞价金额不能高于拦标价！',
						bg : '#AE81FF',
						time : 2
					});
					isnul = false;
				}
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
		$("#expectedprice").html(geShi($("#expectedprice").html()));
	</script>
</body>
</html>
