<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.js %>
 
<html>
<head>


<title>运单lbs定位</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="decorator" content="site_personal_basic"/>


	<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/My97DatePicker/WdatePicker.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/mycss/wlpt/global.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/static/css/mycss/wlpt/yqlindex.css" />
<link
	href="${pageContext.request.contextPath}/static/css/mycss/wlpt/member.css"
	type="text/css" rel="stylesheet" />

<style>
* {
	margin: 0;
	padding: 0;
	font-family: "微软雅黑";
}

input {
	height: 26px;
}
select {
margin:0px;
  margin-left:5px;
  cursor: pointer;
  font-weight: normal;
  align-items: center;
  background-color: #fff;
  border: 1px solid #ccc;
  height: 30px;
}
.all {
	height: auto;
	margin: 0 auto;
	padding-bottom: 10px;
}

.forsearch {
	padding: 10px 0 10px 12px;
}

.mennycount {
	width: 716px;
	height: 30px;
	line-height: 30px;
	padding: 0 10px;
	font-size: 16px;
}

#mennycount {
	color: #F00;
	font-size: 18px;
	font-weight: bold;
}

#titler {
	width: 150px;
	height: 30px;
	margin-right: 10px;
}

.time {
	width: 110px;
	height: 30px;
	margin-right: 5px;
}

.options {
	width: 100px;
	height: 24px;
	margin-right: 5px;
}

#gosearch {
	width: 85px;
	height: 30px;
	color: #fff;
	background: #F74000;
	border: 1px solid #F74000;
	border-radius: 4px;
}

.fortab {
	width: 740px;
	height: auto;
	border-collapse: collapse;
	border: none;
	text-align: center;
}

.toptitle {
	height: 37px;
	background: #EFEFEF;
	border-top: 3px solid #F00;
	font-size: 12px;
}

.fordata {
	height: 35px;
	border-bottom: 1px dotted #ccc;
}

.fordata:hover {
	background: #FFE2E2;
}

.fordata>td,.bor {
	vertical-align: middle;
	font-size: 12px;
}

.menny {
	width: 70px;
}

.title {
	width: 100px;
}

.status {
	width: 70px;
}

.promulgator {
	width: 180px;
}

.collecttime {
	width: 170px;
}

.type {
	width: 150px;
}

.detail {
	margin-right: 10px;
}

.min_title {
	padding: 5px 0;
	font-size: 14px;
}
.paytyperadio {
	vertical-align: text-bottom;
	margin-bottom: -5px;
	margin-right:10px;
}
.paydiv{padding-left:30px;}
.paydiv p{margin-bottom:10px;}
#frequency,#frequencyval,#frequencymsg{float:left;}
#frequencymsg{line-height: 30px;}
#paymsg{display:block;float:left;height: 30px;line-height: 30px;margin-left: 20px;padding:0px 5px 0px 5px;}
</style>

</head>

<body height="600px;">
	<div id="cp_content">
		<div class="cp_contentdiv" style="padding-bottom:0px;">
		<input type="hidden" id="loctionmobile" value="${pd.LOCATIONMOBILE }"/>
		<input type="hidden" id="isreplay" value="${pd.WHITELIST_ISREPLY }"/>
			<div class="page-title">运单定位</div>
			<table width="100%" border="0" cellspacing="8" cellpadding="0"
				style="margin:0px 0px;">
				<tbody>
					<tr>
						<td width="10%" align="right">运单编号：</td>
						<td><span id="lbsOrderNo">${pd.ORDERNO}</span></td>
						<td colspan="2"><div id="locationmsg">检测到运单承运车辆未填写定位手机号，请填写后<a target="_blank" href="${pageContext.request.contextPath}/wlpt/trade/orderdetail.do?ORDERNO=${pd.ORDERNO}" style="color:#F74000">开启定位</a></div>
						<div style="display:none;" id="replaymsg">检测到运单承运车辆定位手机号未授权定位功能，请通知司机短信回复Y授权定位。</div></td>
					</tr>
					<tr>
						<td align="right">始发地：</td>
						<td colspan="3">${pd.GOODS_FROMADDRESS}</td>
					</tr>
					
					<tr>
						<td align="right">目的地：</td>
						<td colspan="3">${pd.GOODS_TOADDRESS}</td>
					</tr>
					<tr>
						<td align="right">lbs定位：</td>
						<td colspan="3"><input type="text" id="LOCATIONMOBILE" value="${pd.LOCATIONMOBILE}" name="LOCATIONMOBILE" id="LOCATIONMOBILE" placeholder="请输入定位手机号" maxlength="11"/>&nbsp;&nbsp;车牌号码:<span id="carNum">${pd.CARNUMBER}</span></td>
					</tr>
					<tr>
						<td width="10%" align="right"><span>定位频率：</span></td>
						<td colspan="3"><input type="text" class="numbertext"
							id="frequency" maxlength="10" value="10">
							<select id="frequencyval">
								<option value="1">分钟</option>
								<option value="2">小时</option>
							</select>
							<span id="frequencymsg" style="margin-left: 10px;">即每隔<span id="freqval">10</span><span id="freunit">分钟</span>系统自动定位一次</span>
						</td>
					</tr>
					<tr>
						<td width="10%" align="right"><span>定位时长：</span></td>
						<td colspan="3"><input type="text" class="numbertext"
							id="longtime" maxlength="10" value="1"><select id="longtimeval" style="margin-right: 7px;">
								<option value="1">小时</option>
								<option value="2">天</option>
							</select>
							<span>定位开通后，<span id="locatval">1</span><span id="locatvalutil">小时</span>内，系统按定位频率进行定位</span>
						</td>
					</tr>
					<tr>
						<td align="right">费用总计：</td>
						<td colspan="3"><div style="float:left;line-height:30px;"><span id="paycount"></span>元</div><span id="paymsg">您的<span id="payfrom">红包</span>余额不足，请<a style="color: #2E0CDD;font-weight: bold;" target="_blank" href="wlpt/user/index/accountrecharge">充值</a>后开通定位</span></td>
					</tr>

				</tbody>
			</table>

		</div>
		<div class="cp_contentdiv" style="margin-top:0px;padding-top:0px;">
			<div class="page-title">支付方式</div>
			<div class="paydiv">
				<%-- <div style="height: 30px;"><input type="radio" name="payway" value="redpacket" class="paytyperadio"
					 /><span>使用红包支付(当前红包：<span id="redmoney">${pd.RedPacket }</span>元)</span></div> --%>
				<div style="height: 30px;"><input type="radio" class="paytyperadio" checked="checked"
					name="payway" value="webbalance"/><span>使用账户余额(当前余额：<span id="webmoney">${pd.WebBalance}</span>元)</span></div>
				<div style="margin-top:20px;" id="success"><input id="subtn" type="button" class="regbt" value="提交"/></div>
			</div>
			<div>
				<div class="page-title">定位说明：</div>
				<div class="paydiv">
					<p>1、货物在途定位功能，让您实时掌握车辆与货物位置，并减少货主咨询次数，给客户更好的体验。</p>
					<p>2、当运单确认完成后，将停止定位。</p>
					<p>3、停止定位后，剩余费用将返还到您的账户余额中。</p>
					<p>4、货物定位使用LBS定位，需要向通信运营商缴纳0.15元/每次定位费。</p>
					<!-- <p>5、定位轨迹可以在运单详情中，通过地图展现运输路径。</p> -->
				</div>
			</div>
		</div>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/static/js/jquery-1.7.2.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/static/js/jquery.tips.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/static/zDialog/zDialog.js"></script>
		<script type="text/javascript"
			src="${pageContext.request.contextPath}/static/zDialog/zDrag.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/jquery.valid.js"></script>
<script type="text/javascript">
$(function(){
		payfn();	
		comt();
		if($("#loctionmobile").val()!=""){
			$("#locationmsg").css("display","none");
			//填写了定位手机号，判断是否同意定位
			if($("#isreplay").val()=="Y"){
				$("#replaymsg").css("display","none");
			}else{
				$("#replaymsg").css("display","block");
			}
		}else{
			$("#locationmsg").css("display","block");
		}
		/* if($("#isreplay").val()=="Y"){
			$("#replaymsg").css("display","none");
		}else{
			$("#replaymsg").css("display","block");
		} */
		$("#frequencyval").change(function(){
			var frenval=$(this).val();
			//var fretime=
			var bl=$("#frequency").valid({
				methods : "isNum"
			});		
			if(!bl){
				return;
			}
			if(frenval==1){
				$("#freqval").html($("#frequency").val()*1);
				$("#freunit").html("分钟");
			}
			if(frenval==2){
				$("#freqval").html($("#frequency").val()*1);
				$("#freunit").html("小时");
			}
			payfn();
		});
		$("#frequency").blur(function(){
			if($(this).val()<=0){
				$("#frequency").tips({
	                   msg: "定位频率必须是大于0的整数",
	                   side: 2,
	                   bg: "#FF7300"
	               });
				$(this).focus();
				return;
			}
			var bl=$("#frequency").valid({
				methods : "isNum"
			});
			if(!bl){
				$(this).focus();
				return;
			}
			payfn();
			$("#freqval").html($("#frequency").val());
			comt();
		});
		$("#longtime").blur(function(){
			if($(this).val()<=0){
				$("#longtime").tips({
	                   msg: "定位时长必须是大于0的整数",
	                   side: 2,
	                   bg: "#FF7300"
	               });
				$(this).focus();
				return;
			}
			var bl=$("#longtime").valid({
				methods : "isNum"
			});
			if(!bl){
				$(this).focus();
				return;
			}
			payfn();
			comt();
		});
		$("#longtimeval").change(function(){
			payfn();
			comt();
		});
		$("input[name=payway]").click(function(){
			comt();
		});
	$("#subtn").click(function(){
		if($("#isreplay").val()!="Y"&&checkOpenLocation()){
			$("#replaymsg").css({"display":"block","color":"#F74000"});
			return;
		}
		var isnul=true;
		payfn();
		comt();
		isnul = isnul && $("#frequency").valid({
			methods : "isNum"
		});
		isnul = isnul && $("#longtime").valid({
			methods : "isNum"
		});
		isnul=comt();
		if(isnul){
			var datainfo={
					LOCATIONRATE:$("#frequency").val()*1,
					LOCATIONRATETYPE:$("#frequencyval").val(),
					LOCATIONTIMESECTION:$("#longtime").val()*1,
					LOCATIONTIMESECTIONTYPE:$("#longtimeval").val(),
					LOCATIONAMOUNT:$("#paycount").html()*1,
					LOCATIONMOBILE:$("#LOCATIONMOBILE").val(),
					PAYWAY:$("#payway").val(),
					ORDERNO:$("#lbsOrderNo").html()
			};
				$.ajax({
							url : "${pageContext.request.contextPath}/wlpt/orderlbs/subinfo",
							data :datainfo,
							dataType : 'json',
							cache : false,
							success : function(data) {
								if(data.result=='true'){
									$("#success").html("支付成功").css({"color":"#F74000","font-size":"14px","font-weight":"bold"});
								}else{
									if(data.payway=='1'){
										$("#paymsg").css("display","block");
										$("#payfrom").html("红包");
									}else{
										$("#paymsg").css("display","block");
										$("#payfrom").html("账户");
									}
								}
							}
					});
		}
	});
		
		
	function payfn(){
		var pay=0;
		var freqtype=$("#frequencyval").val();//定位频率的单位（1分钟，2小时）
		var freq=$("#frequency").val()*1;//定位频率的值
		var longtime=$("#longtime").val()*1;//定位时长的值
		var longtimetype=$("#longtimeval").val();//定位时长的单位
		var util="小时";
		if(longtimetype==1){
			if(freqtype==1){
				pay=longtime*60/freq;
			}else{
				pay=longtime/freq;
			}
			util="小时";
		}else{
			if(freqtype==1){
				pay=longtime*24*60/freq;
			}else{
				pay=longtime*24/freq;
			}
			util="天";
		}
		pay=parseFloat(Math.ceil(pay)*0.15).toFixed(2);
		$("#paycount").html(pay);
		$("#locatval").html(longtime);
		$("#locatvalutil").html(util);
	}
	function comt(){
		var paytype=$("input[name=payway]:checked").val();
		var pay=$("#paycount").html()*1;
		var redmoney=$("#redmoney").html()*1;
		var webmoney=$("#webmoney").html()*1;
		var freqtype=$("#frequencyval").val();
		var freq=$("#frequency").val()*1;//定位频率的值
		if(paytype=='redpacket'){
			if(pay>redmoney){
				$("#paymsg").css("display","block");
				$("#payfrom").html("红包");
				return false;
			}else{
				$("#paymsg").css("display","none");
			}
		}
		if(paytype=='webbalance'){
			if(pay>webmoney){
				$("#paymsg").css("display","block");
				$("#payfrom").html("账户");
				return false;
			}else{
				$("#paymsg").css("display","none");
			}
		}
		if(freqtype==1){
			if(freq<10){
				$("#frequency").tips({
	                msg: "定位频率必须是大于10的整数",
	                side: 2,
	                bg: "#FF7300"
	            });
				$(this).focus();
				return false;
			}
		}
		if($("#loctionmobile").val()==""){
			$("#locationmsg").css("display","block");
			return false;
		}
		return true;
	}
	function checkOpenLocation(){
		var LOCATIONMOBILE=$("#LOCATIONMOBILE").val();
		var carNum =$("#carNum").html();
		$.ajax({
			url : "${pageContext.request.contextPath}/wlpt/lbsinfo/SendList",
			data :{LOCATIONMOBILE:LOCATIONMOBILE,CARNUMBER:carNum},
			dataType : 'json',
			cache : false,
			success : function(data) {
				if(data.result!='2'){
					return false;
				}else{
					return true;
				}
			}
		});
	}
});

</script>
	</div>
</body>
</html>