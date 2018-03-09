<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>${fns:getConst('SYSTEMTITLE')}--一卡通挂失</title>

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
<script type="text/javascript" src="${ctxStatic}/weixin/js/weixin/errorpage.js"></script>
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
<style type="text/css">
/*整体div -top布局*/
.data_top,.result_bottom {
	width: 100%;
	display: block;
	z-index: 2;
	position: fixed;
	background-color: #FFF;
}

.result_bottom {
	height: 30px;
	border: none;
	text-align: center;
	line-height: 30px;
	bottom: 0px;
}

.data_top div {
	float: left;
	height: 50px;
	line-height: 50px;
	background-color: rgba(32, 162, 226, 1);
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
	width: 50%;
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
	padding-top: 0px;
	margin-bottom: 50px;
}

.data_title {
	clear: both;
	font-size: 14px;
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
	height: 35px;
	display: table;
}

.ct_lf div {
	float: left;
	margin-right: 5px;
	line-height: 45px;
	display: table-cell;
	vertical-align: middle;
	display: table-cell
}

.ic_img {
	height: 35px;
	display: table;
}

.ic_img img {
	width: 30px;
	margin-top: 7px;
	display: table-cell;
	vertical-align: middle;
	display: table-cell;
}

.cb_tle {
	width: 26%;
	text-align: right;
	float: left;
}

.cb_val {
	width: 70%;
	float: left;
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
	background-image: url(${ctxStatic}/images/weixin/pic_bg_normal.png);
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

input[type='text'] {
	border-bottom: 1px solid #ccc;
	font-size: 18px;
	line-height: 25px;
	height: 30px;
}

.data_div {
	width: 98%;
	background-color: #EBEBEB;
	clear: both;
	height: 62px;
	margin: 0 auto;
	margin-bottom: 5px;
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
	width: 43%;
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
.selected {
    color:#FFBB66;
    border-bottom: 2px solid #FFBB66;
    background-color:rgba(32, 162, 226, 1);
}
 .detail-row {
            display: none;
        }
</style>
</head>

<body>
	<!-- <div class="data_top data_tab" style="width:100%;padding:0px;color: white;">
		<div class="selected data_tab_left">余额转账</div>
		<div class="data_tab_right">卓币转账</div>
	</div> -->
	<div class="data_box data_box0">
		<div class="data_title">挂失一卡通</div>
		
		<div class="data_cent detail-row" id="companyTable">
			<div class="ct_lf ">
				<div class="cb_tle">企业名称：</div>
				<div class="cb_val ">${user.userCompany.companyname}</div>	
			</div>	
			<div class="ct_lf">
				<div class="cb_tle">营业执照：</div>
				<div class="cb_val ">${user.userCompany.businesslicencenum}</div>
			</div>	
			<div class="ct_lf">
				<div class="cb_tle">企业法人：</div>
				<div class="cb_val ">${user.userCompany.legalperson}</div>
			</div>	
			<div class="ct_lf">
				<div class="cb_tle">联系人：</div>
				<div class="cb_val ">${user.userCompany.headerperson}</div>
			</div>
			<div class="ct_lf">
				<div class="cb_tle">手机号：</div>
				<div class="cb_val ">${user.phone}</div>
			</div>
			<div class="ct_lf">
				<div class="cb_tle">公司地址：</div>
				<div class="cb_val ">${user.userCompany.provinceCityDistrict}${user.userCompany.companyaddress}</div>
			</div>	
		</div>
		<div class="data_cent " id="otherRoleTable">
			<div class="ct_lf ">
				<div class="cb_tle">姓名：</div>
				<div class="cb_val ">${user.name}</div>	
			</div>	
			<div class="ct_lf">
				<div class="cb_tle">手机号：</div>
				<div class="cb_val ">${user.phone}</div>
			</div>	
			<div class="ct_lf">
				<div class="cb_tle">身份证号：</div>
				<div class="cb_val ">${user.userinfo.identitycard}</div>
			</div>	
			<div class="ct_lf">
				<div class="cb_tle">联系地址：</div>
				<div class="cb_val ">${user.userinfo.contactaddress}</div>
			</div>
			
		</div>
		<!--data_cent end  -->
		<form:form id="inputForm" modelAttribute="address" method="post"
			class="form-horizontal">
		<div class="data_title">收货人信息</div> 
		<div class="data_cent">
			<div class="ct_lf">
				<div class="cb_tle">收货人：</div>
				<div class="cb_val red" style="font-size:20;font-weight:bold;">
					<input type="text" id="linkman" value="${userMetroCard.address.linkman}"
						name="linkman" maxlength="10"
						style="height:45px;border-bottom:1px solid #ccc;width:98%;"
						placeholder="请输入收货人姓名" />
				</div>
			</div>
			<div class="ct_lf">
				<div class="cb_tle">联系电话：</div>
				<div class="cb_val red" style="font-size:20;font-weight:bold;">
					<input type="text" id="linkmobile"
						value="${userMetroCard.address.linkmobile}" name="linkmobile" maxlength="11"
						style="height:45px;border-bottom:1px solid #ccc;width:98%;"
						placeholder="请输入联系电话" />
				</div>
			</div>
			<div class="ct_lf">
				<div class="cb_tle">所在地区：</div>
				<div class="cb_val red" style="font-size:20;font-weight:bold;">
					<input type="text" id="address" value="${userMetroCard.address.province}${userMetroCard.address.city}${userMetroCard.address.district}"
						name="location" maxlength="50" readonly="readonly"
						style="height:45px;border-bottom:1px solid #ccc;width:98%;"
						placeholder="请选择所在地区" /><input
						id="fromprovince" name="province" type="hidden"
						value="${userMetroCard.address.province}" /> <input id="fromcity"
						name="city" type="hidden" value="${userMetroCard.address.city}" />
						<input id="fromdistrict" name="district" type="hidden"
						value="${userMetroCard.address.district}" />
				</div>
			</div>
			<div class="ct_lf">
				<div class="cb_tle">详细地址：</div>
				<div class="cb_val red" style="font-size:20;font-weight:bold;">
					<input type="text" id="detailAddress" name="address"
						value="${userMetroCard.address.address}"
						style="height:45px;border-bottom:1px solid #ccc;width:98%;"
						placeholder="请输入详细地址" maxlength="50"/>
				</div>
			</div>
			<div class="ct_lf">
				<div class="cb_tle">邮政编码：</div>
				<div class="cb_val red">
					<input type="text" id="postalcode"
						value="${userMetroCard.address.postcode}" name="postcode" maxlength="6"
						style="height:45px;border-bottom:1px solid #ccc;width:98%;"
						placeholder="请输入邮政编码" />
				</div>
			</div>
		</div>
		</form:form>
		<div id='loading'
			style='width:100%;vertical-align: middle;text-align:center;height:45px'>
			<div>
				<img src='${ctxStatic}/images/loading-30x30.gif'>
			</div>
			<div style="font-size:14px;font-weight:bold;" id="loadtext">小卓正在努力加载，请稍等!</div>
		</div>
		<!--data_cent end  -->
		<div class="sub_btn" id="apply" onclick="lossCard()"
			style="background:rgba(32, 162, 226, 0.87);-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px;">挂失换卡</div>
		<!-- <div class="data_cent">
			<div style="font-size:20px;margin-top:10px;">余额转账须知</div>
			<div class="linediv" style="line-height:15px;font-size:14px;">
				<p>1、确认账户卡号是否正确。</p>
				<p>2、转账金额是否与无误。</p>
				<p>3、如有问题，请及时与平台服务联系。</p>
				<p>客户热线：0310-3188756。</p>
			</div>
		</div> -->
	</div>
	<!-- <div class="data_box data_box1" style="display:none;">
		
	</div> -->
</body>
<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery-1.7.2.js"></script>
<script type="text/javascript"
	src="${ctxStatic}/weixin/js/jquery.valid.js"></script>
<script type="text/javascript"
	src="${ctxStatic}/weixin/js/jquery.tips.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"
	type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/jquery.pcc.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/jquery.gridSelector.js"></script>
<script type="text/javascript">
	$(function() {
		$("#loading").hide();
		var isenterprise = '${isenterprise}';
		if (isenterprise == 'true') {
			$("#otherRoleTable").hide();
			$("#companyTable").show();
			$("#companyTable").removeClass("detail-row");
		}
	/* 	var status='${userMetroCard.status}';
		if(status!=null&&status!=""&&status!=undefined){
			if(status==0||status==1){
				$("#apply").attr("disabled", "true");
				$("#apply").css("background-color", "#ccc");
				$("#apply").css("color", "white");
				$("#linkman").attr("readonly", "true");
				$("#linkmobile").attr("readonly", "true");
				$("#address").attr("disabled", "true");
				$("#detailAddress").attr("readonly", "true");
				$("#postalcode").attr("readonly", "true");
				$("#apply").html("申请中");
				if(status==1){
					$("#apply").html("已申请");
				}
			}
		} */
		
		window.lossCard=function () {
			var userstatus='${user.userinfo.status}';
			if(userstatus!='2'){
				$.MsgBox.Alert("温馨提示", "请先完成认证");
				window.location.href = "${wx}/weixin/authentication/toAuthentications";
				return false;
			}
			$("#apply").hide();
			$("#loading").show();
			
			var isnul = true;
			isnul = isnul && $("#linkman").valid({
				methods : "required|isName"
			});
			isnul = isnul && $("#linkmobile").valid({
				methods : "required|isPhone"
			});
			isnul = isnul && $("#address").valid({
				methods : "required|string"
			});
			isnul = isnul && $("#detailAddress").valid({
				methods : "required|string"
			});
			isnul = isnul && $("#postalcode").valid({
				methods : "required|isZipCode"
			});
			if (!isnul) {
				altmesg();
				return false;
			}
			$.ajax({
				cache : true,
				type : "POST",
				url : "${wx}/weixin/user/lossCard",
				data : $('#inputForm').serialize(),// 你的formid
				async : false,
				error : function(request) {
					$.MsgBox.Alert("保存提示", "保存失败");
					$("#apply").attr("disabled","none");
				},
				success : function(data) {
					if(data.state == 1){
						 $("#apply").show();
						 $("#apply").html("挂失成功");
						 $("#apply").unbind();
						window.location.href = '${wx}/weixin/user/userHome';
					}else{
						$.MsgBox.Alert("保存提示", data.message);
						window.setTimeout(altmesg, "1000");
					}
					
				}
			});
		};
		
		$("#address").PCC({
			hasCounty : true,
			width : 360,
			height : 220,
			url : "${wlpt}/wlpt/chinaarea/getArea",
			closeIcon : "static/images/pic12.gif",
			complete : function(data) {
				var str = "";
				if (data.province) {
					str += data.province.NAME;
					$("#fromprovince").val(data.province.NAME);
				}
				if (data.city) {
					str += data.city.NAME;
					$("#fromcity").val(data.city.NAME);
				}
				if (data.county) {
					str += data.county.NAME;
					$("#fromdistrict").val(data.county.NAME);
				}
				if(str!=" "){
					$("#address").val(str);
				}else{
					$("#address").val("");
				}
			}
		});
		
		
		
		
		
		window.altmesg = function() {
			$("#apply").show();
			$("#loading").hide();
			$("#loadtext").html("加载中，请稍等！");
		};

		$(".data_tab div").click(function() {
			var i = $(this).index();
			$(this).addClass("selected");
			$(".data_tab div").not(this).removeClass("selected");
			if (i == 0) {
				window.location.href = '${wx}/weixin/user/toTransfer';
			} else {
				window.location.href = '${wx}/weixin/user/toTransferCoin';
			}
		});
		
		
	});
</script>

</html>
