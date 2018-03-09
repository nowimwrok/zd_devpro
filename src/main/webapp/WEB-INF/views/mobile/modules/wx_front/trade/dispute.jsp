<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>--发起争议</title>

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

<script type="text/javascript" src="static/js/weixin/errorpage.js"></script>
	<script>
		var _hmt = _hmt || [];
		(function() {
			var hm = document.createElement("script");
			hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
			var s = document.getElementsByTagName("script")[0];
			s.parentNode.insertBefore(hm, s);
		})();
	</script>


	<link href="static/css/weixin/base.css" rel="stylesheet" type="text/css">
<link href="static/css/weixin/global.css" rel="stylesheet"
	type="text/css">
<style type="text/css">
/*整体div 布局*/
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
	width: 97%;
	height: 50px;
	line-height: 50px;
	padding-left: 3%;
	border-bottom: 1px solid #CCC;
}

.data_center {
	width: 100%;
}

.data_bottom {
	height: 100px;
	margin-top: 20px;
	border-top: 1px solid #CCC;
	padding-top: 10px;
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
	padding-top: 10px;
}

.center_top {
	height: 80px;
	border-bottom: 1px solid #CCC;
}

.ct_left {
	width: 70%;
	height: 80px;
}

.ct_right {
	width: 29%;
	height: 80px;
	line-height:75px;
}

.split {
	clear: both;
	width: 100%;
	border: 1px solid #CCC;
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

#imgCredit {
	margin-top: 5px;
}

.ic_call {
	margin-top: 10px;
	width: 50px;
}

.cb_tle {
	width: 32.5%;
	text-align: right;
}

.cb_val {
	width: 60%;
}

.cb_val_rt {
	width: 25%
}

.in_txt {
	border-bottom: 1px solid #CCC;
	height: 30px;
	font-size: 16px;
	width: 50%;
}

.sub_btn {
	width: 95%;
	height: 50px;
	font-size: 20px;
	text-align: center;
	line-height: 45px;
	margin: 0 auto;
	margin-top: 20px;
	font-weight: bold;
	color: #FFF;
	background-color: rgb(32, 134, 226);
	letter-spacing: 10px;
	clear: both;
}
.sub_btn2 {
	width: 95%;
	height: 50px;
	font-size: 20px;
	text-align: center;
	line-height: 45px;
	margin: 0 auto;
	margin-top: 20px;
	font-weight: bold;
	color: #FFF;
	background-color:rgb(146, 154, 160);
	letter-spacing: 10px;
	clear: both;
}
.authened {
	color: white;
	margin-right: 5px;
	background: rgb(32, 134, 226);
	font-size: 0.8em;
	vertical-align: text-top;
	padding: 5px;
}

.unauthen {
	color: white;
	margin-left: 5px;
	margin-right: 5px;
	background: rgb(1232, 173, 109);
	font-size: 0.8em;
	vertical-align: text-top;
}

.linediv p {
	line-height: 20px;
}

.data_tab div {
	float: left;
	text-align: center;
}

.selected {
	background-color: rgb(32, 134, 226);
	color: #FFF;
}

.data_tab_left {
	width: 49%;
}

.data_tab_right {
	width: 50%;
}

.data_notice div {
	margin-bottom: 0px;
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
</style>
</head>

<body>
	<div class="data_box">
		<div class="data_top data_tab" style="width:100%;padding:0px;">
			<div class="selected data_tab_left">发起争议</div>
			<div class="data_tab_right">争议解决进度</div>
		</div>
		<!-- data_top end -->
		<div id="data">
			<div class="data_center">
				<div class="center_top" style="height:50px;">
					<div class="ct_left flt_left" style="width:98%;padding-left:1%;">
						<div class="ct_lf" style="background-color:#DDDDDD;line-height:35px;">
						争议内容
						</div>
					</div>
					<!-- ct_left end -->
<!-- 					<div class="ct_right flt_left" id="bidstatus">
					</div> -->
					<!-- ct_right end -->
				</div>
				<!-- center_top end -->
				<div class="center_bottom">
					<div class="cbm_info">
						<div class="ct_lf">
							<div class="cb_tle" style="width:24%;">货物名称：</div>
							<div class="cb_val" style="width:60%;">
							<input class="in_txt" id="goodsname" maxlength="6" style="width:100%;height:36px;" type="text" value="${TAKEGOODSNAME}"/>
							</div>
						</div>
						<div class="ct_lf">
							<div class="cb_tle" style="width:24%;">提货吨数：</div>
							<div class="cb_val" style="width:60%;">
							<input class="in_txt" id="TAKELOADWEIGHT" maxlength="6" style="width:100%;height:36px;" type="text" value="${disinfospd.TAKELOADWEIGHT!=null?disinfospd.TAKELOADWEIGHT:TAKELOADWEIGHT}"/>
							</div>
						</div>
						<div class="ct_lf">
							<div class="cb_tle" style="width:24%;">卸货吨数：</div>
							<div class="cb_val" style="width:60%;">
							<input class="in_txt" id="UNLOADWEIGHT" maxlength="6" style="width:100%;height:36px;" type="text" value="${disinfospd.UNLOADWEIGHT!=null?disinfospd.UNLOADWEIGHT:UNLOADWEIGHT}"/>
						</div>
					</div>
					<div class="ct_lf">
							<div class="cb_tle" style="width:24%;">争议说明：</div>
							<div class="cb_val" style="width:60%;"></div>
					</div>
					<div style="clear: both;padding-left:5%;">
					<textarea rows="" cols="" id="DISPUTEINFO" style="width:95%;height:100px;">${disinfospd.DISPUTEINFO}</textarea>
					</div>
				</div>
				<!-- center_bottom end -->
			</div>
			<!-- data_center end -->
			<div class="data_bottom">
					<c:choose>
					<c:when test="${disinfospd.STATUS!=null}">
				<div class="sub_btn" id="save_dicpute" style="background-color:rgb(146, 154, 160);">
					<span style="margin-top: -1px;">您已提交争议</span>
				</div></c:when>
					<c:otherwise>
				<div class="sub_btn" id="save_dicputes" onclick="save()">
					<span style="margin-top: -1px;" id="save_dicputes_font">提交争议</span>
				</div>
					</c:otherwise>
					</c:choose>

			</div>
			<!-- data_bottom end -->
		</div>
		</div>
		<div class="data_center data_notice" id="data_notice"
			style="display:none;width:95%;margin:0px auto;margin-top:10px;">
							<div id="timeline">
							<c:choose>
							<c:when test="${disinfospd.STATUS!=null}">
							<c:if test="${disinfospd.STATUS!=null}">
					<div class="timeline-item">
						<div class="timeline-icon">
							<img
								src="${pageContext.request.contextPath}/static/images/weixin/goods_owner.png"
								alt="货主">
						</div>
						<div class="timeline-content">
							<h2>发起争议</h2>
							<div class="ct_lf">
								<div class="cb_tle">
									<div class="ic_img">
										<img alt="货物" style="width:20px;"
											src="${pageContext.request.contextPath}/static/images/weixin/ic_goods.png">
									</div>
								</div>
								<div class="cb_val">
									<div>货物名称：<span id="dgoodsname">${disinfospd.GOODSNAME}</span></div>
									<div>吨位：<span id="dloadweight">${disinfospd.UNLOADWEIGHT}</span>吨</div>
									<div>发起方：<span id="duser">${disinfospd.COMPANYNAME}</span></div>
								</div>
							</div>
							<div class="ct_lf">
								<div class="cb_tle">
									<div class="ic_img">
									</div>
									<!--ic_img end  -->
								</div>
								<div class="cb_val" id="fromAddress"></div>
							</div>
							<!--ct_lf end  -->
							<div class="ct_lf">
								<div class="cb_tle">
									<div class="ic_img">
									</div>
									<!--ic_img end  -->
								</div>
								<div class="cb_val" id="toAddress"></div>
							</div>
							<p><span id="crtime">${disinfospd.CREATETIME}</span></p>
						</div>
					</div>
 </c:if>
							</c:when>
							<c:otherwise><span style="padding-left:10px;" id="sussessinfos">暂未提交争议信息...</span></c:otherwise>
							</c:choose>

 <c:if test="${disinfospd.STATUS==1||disinfospd.STATUS==2}">
					<div class="timeline-item">
						<div class="timeline-icon">
							<img
								src="${pageContext.request.contextPath}/static/images/weixin/car_owner.png"
								alt="司机">
						</div>
						<div class="timeline-content ">
							<h2>平台处理</h2>
							<div class="ct_lf">
								<div class="cb_tle">
									<div class="ic_img">
										<img alt="车辆" style="width:20px;"
											src="${pageContext.request.contextPath}/static/images/weixin/home_mycars_img.png">
									</div>
								</div>
								<div class="cb_val">
									<div>平台已安排工作人员进行处理...</div>
									<div>请您耐心等候！</div>
									<div></div>
									<div>处理人：${disinfospd.DEALNAME}</div>
								</div>
							</div>
							<!--ct_lf end  -->
							<div class="ct_lf">
								<div class="cb_tle">
									<div class="ic_img">
										<img alt="司机" style="width:20px;"
											src="${pageContext.request.contextPath}/static/images/weixin/icon_finddriver.png">
									</div>
								</div>
								<div class="cb_val">
									<div></div>
									<div></div>
								</div>
							</div>
							<!--ct_lf end  -->
							<p>${disinfospd.UPDATETIME}</p>
						</div>
					</div>
</c:if>
<c:if test="${disinfospd.STATUS==2}">
						<div class="timeline-item">
							<div class="timeline-icon">
								<img
									src="${pageContext.request.contextPath}/static/images/weixin/goods_owner.png"
									alt="货主">
							</div>
							<div class="timeline-content">
								<h2>处理结果</h2>
								<div class="ct_lf">
									<div class="cb_tle">
										<div class="ic_img">
											<img alt="运单" style="width:20px;"
												src="${pageContext.request.contextPath}/static/images/weixin/icon_bidding.png">
										</div>
									</div>
									<div class="cb_val">
										<div id="orderNo">${disinfospd.DISPUTECONTENT}</div>
									</div>
								</div>
								<!--ct_lf end  -->
								<div class="ct_lf">
									<div class="cb_tle">
										<div class="ic_img">
											<img alt="发货方" style="width:20px;"
												src="${pageContext.request.contextPath}/static/images/weixin/icon_goods_statitions.png">
										</div>
									</div>
									<div class="cb_val">
										<div></div>
										<div>处理人：${disinfospd.DEALNAME}</div>
									</div>
								</div>
								<!--ct_lf end  -->
								<p>${disinfospd.UPDATETIME}</p>
							</div>
						</div>
</c:if>
				</div>
		</div>
	</div>
	<!-- data_box end -->
	<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/js/jquery.tips.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/js/jquery.valid.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/js/weixin/global.js"></script>
	<script type="text/javascript">
	
	function save() {
		if(!checkInfo()){
			return;
		}
		var ORDERNO='${ORDERNO}';
		if(ORDERNO==null){
			return;
		}
		$("#save_dicputes").unbind();
		$("#save_dicputes").attr('disabled','disabled');
		$("#save_dicputes").removeClass("sub_btn");
		$("#save_dicputes").addClass("sub_btn2");
		var infos={};
		infos.ORDERNO=ORDERNO;
		infos.GOODSNAME=$("#goodsname").val();
		infos.TAKELOADWEIGHT=$("#TAKELOADWEIGHT").val();
		infos.UNLOADWEIGHT=$("#UNLOADWEIGHT").val();
		infos.DISPUTEINFO=$("#DISPUTEINFO").val();
		
		$.ajax({
					url : "${pageContext.request.contextPath}/weixin/trade/saveDispute",
					data : infos,
					type : 'post',
					dataType : 'json',
					cache : false,
					success : function(data) {
					/* 	$("#data_notice").show();
						$("#data").hide(); */
						$("#dgoodsname").html(data.data.GOODSNAME);
						$("#dloadweight").html(data.data.UNLOADWEIGHT);
						$("#duser").html(data.data.COMPANYNAME);
						$("#crtime").html(data.data.CREATETIME);
						$("#sussessinfos").html("成功提交争议,请重新刷新进入页面查看...");
						$("#save_dicputes").unbind();
						
						$("#save_dicputes_font").html("您已提交争议!");
						if(data.state==2){
							$("#goodsname").attr("readonly","readonly");
							$("#TAKELOADWEIGHT").attr("readonly","readonly");
							$("#UNLOADWEIGHT").attr("readonly","readonly");
							$("#DISPUTEINFO").attr("readonly","readonly");
							$("#save_dicputes").removeClass("sub_btn");
							$("#save_dicputes").addClass("sub_btn2");
							$("#save_dicputes_font").html("您已提交争议!");
						}
					}
				});
	}
	
	   //top菜单 点击切换
		$(function() {
			$(".data_tab div").click(function() {
					var i = $(this).index();
					$(this).addClass("selected");
					$(".data_tab div").not(this).removeClass("selected");
					if (i == 0) {
						$(".data_notice").hide();
						$("#data").show();
					} else {
						$(".data_notice").show();
						$("#data_notice").show();
						$("#data").hide();
					}
			});
			
			var status='${disinfospd.STATUS}';
			if(status!=null&&status!=""){
				$("#goodsname").attr("readonly","readonly");
				$("#TAKELOADWEIGHT").attr("readonly","readonly");
				$("#UNLOADWEIGHT").attr("readonly","readonly");
				$("#DISPUTEINFO").attr("readonly","readonly");
			}
			
/* 			function getOnload() {
				var ORDERID='${ORDERID}';
				if(ORDERID==null){
					return;
				}
				var info={};
				info.ORDERID=ORDERID;			
				$.ajax({
							url : "${pageContext.request.contextPath}/weixin/trade/getDis",
							data : infos,
							type : 'post',
							dataType : 'json',
							cache : false,
							success : function(data) {
								$("#TAKELOADWEIGHT").val();
								$("#UNLOADWEIGHT").val();
								$("#DISPUTEINFO").val();
							}
						});
			} */
			
			//提交 验证信息
			window.checkInfo=function(){
				var isnul = true;
				isnul = isnul && $("#goodsname").valid({
					methods : "required",tipSide : "3"
				});
				isnul = isnul && $("#TAKELOADWEIGHT").valid({
					methods : "required|isdecimal",tipSide : "3"
				});
				isnul = isnul && $("#UNLOADWEIGHT").valid({
					methods : "required|isdecimal",tipSide : "3"
				});
				isnul = isnul && $("#DISPUTEINFO").valid({
					methods : "required",tipSide : "3"
				});
				return isnul;
		};
			

			//格式数字后面的0
			function geShi(num){
				if(num!=null&&num!=""){
					return parseFloat(num);
				}else{
					return "--";
				}
			}
			$("#dloadweight").html(geShi($("#dloadweight").html()));
			$("#UNLOADWEIGHT").val(geShi($("#UNLOADWEIGHT").val()));
			$("#TAKELOADWEIGHT").val(geShi($("#TAKELOADWEIGHT").val()));
		});
	</script>
</body>
</html>
