<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>编辑货源</title>

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
<link href="${pageContext.request.contextPath}/static/css/weixin/global.css" rel="stylesheet" type="text/css">
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
#content{
	padding-top:55px;
}
</style>
<script type="text/javascript" src="static/js/weixin/errorpage.js"></script>
</head>
<body>
<div class="menu_top top" s>
		<div class="data_top data_tab">
			<div class="data_tab_left" ><a style="display:block;width:100%;" href="${pageContext.request.contextPath}/weixin/goodsSource/goods_list">我的货源</a></div>
			<div class="data_tab_right selected"><a style="display:block;width:100%;" href="${pageContext.request.contextPath}/weixin/goodsSource/goodsSource_add">发布货源</a></div>
		</div>
	</div>
	<div id="content">
		<div>
			<form
				action="${pageContext.request.contextPath}/wlpt/goods/addGoodsSource"
				id="goodsfabu" method="post">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="30%" style="text-align:right;">
						<col width="65%" style="text-align:right;">
					</colgroup>
					<tbody>
						<tr>
							<td align="right"><span class="font-red">*</span>货物名称：</td>
							<td><input type="text" class="input_full" name="GOODSNAME" id="GoodsName"
								maxlength="20" value="${result.data.GOODSNAME}"> 
									<input type="hidden" name="GOODSID" value="${result.data.GOODSID }"></td>
						</tr>
						<tr>
							<td align="right"><span class="font-red">*</span>期望运费：</td>
							<td><input type="text" class="input_full" name="GOODSNAME" id="GoodsName"
								maxlength="20" value="${result.data.GOODSNAME}"> 
									<input type="hidden" name="GOODSID" value="${result.data.GOODSID }"></td>
						</tr>
						<tr>
							<td  align="right"><span class="font-red">*</span>始发地：</td>
							<td>
									<input type="text" style="width:90%;" readonly="readonly" placeholder="请选择省市区" id="fromAddress" class="input_full"
										name="fromAddress" value="${result.data.GOODS_FROMADDRESS }" /> 
									<input type="hidden" name="FROMPROVINCE" id="FromProv" value="${result.data.FROMPROVINCE }" /> 
									<input type="hidden" name="FROMCITY" id="FromCity" value="${result.data.FROMCITY }" /> 
									<input type="hidden" name="FROMDISTRICT" id="FromArea" value="${result.data.FROMDISTRICT }" />
									<div class="slideup">+</div>
							</td>
						</tr>
						<tr>
							<td align="right">详细地址：</td>
							<td>
									<input value="${result.data.FROMADDRESS}" class="input_full" type="text" maxlength="50"	name="FROMADDRESS">
							</td>
						</tr>
						<tr>
							<td align="right"><span class="font-red">*</span>目的地：</td>
							<td>
									<input type="text" id="toAddress" name="toAddress" readonly="readonly" placeholder="请选择省市区" class="input_full"
										value="${result.data.GOODS_TOADDRESS }" /> 
									<input type="hidden" name="TOPROVINCE" id="ToProv" value="${result.data.TOPROVINCE }" /> 
									<input type="hidden" name="TOCITY" id="ToCity" value="${result.data.TOCITY }" />
									<input type="hidden" name="TODISTRICT" id="ToArea" value="${result.data.TODISTRICT}" />
							</td>
						</tr>
						<tr>
							<td align="right">详细地址：</td>
							<td>
									<input value="${result.data.TOADDRESS}"  class="input_full" maxlength="50" type="text" name="TOADDRESS">
							</td>
						</tr>
						<tr>
							<td align="right"><span class="font-red">*</span>发货时间：</td>
							<td>
									<input type="text" name="SENDTIME" class="input_full" value="${result.data.SENDTIME }" id="SendTime" readonly="readonly"
										onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
							</td>
						</tr>
						<tr>
							<td align="right">货物类型：</td>
							<td>
									<input type="text" class="input_full" readonly="readonly"
										id="GoodsType" name="GOODSTYPE"	value="${result.data.GOODSTYPE!=null?result.data.GOODSTYPE:'重货'}" />
							</td>
						</tr>
						<tr>
							<td align="right">货物价值：</td>
							<td>
									<input type="text" class="input_eigth" name="WORTH"	id="Worth" value="${result.data.WORTH }" maxlength="10"><span  class="span_flt_right">元</span>
							</td>
						</tr>
						<tr>
							<td align="right">运输方式：</td>
							<td>
									<input type="text" readonly="readonly"  class="input_full" id="TransportWay"
										value="${result.data.TRANSPORTWAY!=null?result.data.TRANSPORTWAY:'整车'}"
										name="TRANSPORTWAY" />
							</td>
						</tr>
						<tr>
							<td align="right"><span class="font-red">*</span>货物重量：</td>
							<td>
									<input type="text" name="LOADWEIGHT" class="input_eigth" id="LoadWeight" maxlength="10" value="${result.data.LOADWEIGHT }"><span class="span_flt_right">吨</span>
									<input style="display:none;height:34px" id="WeightUnit"	name="WEIGHTUNIT" value="吨" />
							</td>
						</tr>
						<tr>
							<td align="right"><span class="font-red">*</span>车长要求：</td>
							<td>
									<input type="text"  class="input_eigth"
								id="CarLength" name="CARLENGTH" value="${result.data.CARLENGTH}" />
								<span class="span_flt_right">米</span><input name="LENGTHUNIT" type="hidden" value="米">
							</td>
						</tr>
						<tr>
							<td align="right"><span class="font-red">*</span>有效天数：</td>
							<td>
									<input type="text" class="input_eigth" value="${result.data.EFFECTDAYS!='0'?result.data.EFFECTDAYS:'7'}" id="Effectdays"
										name="EFFECTDAYS" /><span class="span_flt_right">天</span>
							</td>
						</tr>
						<tr>
							<td align="right"><span class="font-red">*</span>车型要求：</td>
							<td>
									<input type="text" id="CarType" readonly="readonly" class="input_full"
									 name="CARTYPE" value="${result.data.CARTYPE}" /></td>
						</tr>

						<tr>
							<td valign="top" align="right">补充说明：</td>
							<td><textarea name="REMARKS" rows="5" id="REMARKS" style="border:none;width:99%" maxlength="100">${result.data.REMARKS }</textarea>
							</td>
						</tr>
						<tr>
							<td style="text-align:left;" colspan="2">联系人信息</td>
						</tr>
						<tr>
							<td align="right"><span class="font-red">*</span>姓名：</td>
							<td>
									<input type="text" name="LINKMAN" class="input_full"
									id="LinkMan" maxlength="10" value="${result.data.LINKMAN!=null?result.data.LINKMAN:userPd.NAME}"> <span
									class="errorTip"></span>
							</td>
						</tr>
						<tr>
							<td style="border:none;" align="right"><span class="font-red">*</span>手机号码：</td>
							<td style="border:none;">
									<input type="text" name="LINKMOBILE" id="LinkMobile"  class="input_full"
										maxlength="11" value="${result.data.LINKMOBILE!=null?result.data.LINKMOBILE:userPd.PHONE}">
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			<div id='loading' style='width:100%;vertical-align: middle;text-align:center;height:45px'>
				<div>
					<img src='static/images/loading-30x30.gif'>
				</div>
				<div style="font-size:14px;font-weight:bold;" id="loadtext">小运正在努力加载，请稍等!</div>
			</div>
			<p align="center" style="margin-top:20px;padding-bottom: 30px;">
				<input type="button" class="regbt" id="fabu" value="保 存"/>
			</p>
		</div>
	</div>
	<!-- content-end -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/jquery-1.7.2.js"
	language="javascript"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/zDialog/zDialog.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/zDialog/zDrag.js"></script>
<script type="text/javascript"
		src="${pageContext.request.contextPath}/static/js/myjs/wlpt/config.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/jquery.valid.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/jquery.gridSelector.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/weixin/global.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/jquery.tips.js"></script>
<script type="text/javascript" src="static/js/weixin/jquery.pcc.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/static/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
$(function(){(function(){
		var list = [];
		var i = 0;
		for(var item in $.myConfig.goodsType){
			list[i] = {
				id : i++,
				text: item,
				val: $.myConfig.goodsType[item]
			};
		}
		$("#GoodsType").gridSelector({
			idKey: "id",
			textKey:"text",
			cellWidth:50,
			cellHeight:25,
			data: list,
			multiSelect:false,
			position: "lb", 
	    icon: "",
			complete:function(data){
				$("#GoodsType").val(data.text);
			}
		});
	})();
	(function(){
		var list = [];
		var i = 0;
		for(var item in $.myConfig.TransportWay){
			list[i] = {
				id : i++,
				text: item,
				val: $.myConfig.TransportWay[item]
			};
		}
		$("#TransportWay").gridSelector({
			idKey: "id",
			textKey:"text",
			cellWidth:30,
			cellHeight:25,
			data: list,
			multiSelect:false,
			position: "lb", 
		  icon: "",
			complete:function(data){
				$("#TransportWay").val(data.text);
			}
		});
	})();
	//车辆类型$.myConfig
	$.ajax({
		url : "${pageContext.request.contextPath}/wlpt/cartype/getCarType.do?tm="+ new Date().getTime(),
		dataType : 'json',
		cache : false,
		success : function(data) {
			$("input[name=CARTYPE]").gridSelector({
				idKey: "ORDERNUMBER",
				textKey:"NAME",
				cellWidth:100,
				cellHeight:36,
				data:data.ChinaArea,
				multiSelect:false,
				position: "lb", 
			  icon: "",
				complete:function(data){
					$("input[name=CARTYPE]").val(data.NAME);
				}
			});
		}
	});
});

	//********************************************************初始化地区********************************************************//

	$("#fromAddress").PCC({
		hasCounty : true,
		width : "94%",
		height : 325,
		//color: "blue"
		url : "${pageContext.request.contextPath}/wlpt/area/getarea",
		closeIcon : "static/images/pic12.gif",
		isPhone:true,
		complete : function(data) {
			var str = "";
			if (data.province) {
				str += data.province.NAME + " ";
				$("#FromProv").val(data.province.NAME);
				$("#fromAddress").val(str);
			}
			if (data.city) {
				str += data.city.NAME + " ";
				$("#FromCity").val(data.city.NAME);
				$("#fromAddress").val(str);
			}
			if (data.county) {
				str += data.county.NAME;
				$("#FromArea").val(data.county.NAME);
				$("#fromAddress").val(str);
			}
			$("#fromAddress").val(str);
		}
	});

	$("#toAddress").PCC({
		hasCounty : true,
		width : "94%",
		height : 325,
		//color: "blue"
		url : "${pageContext.request.contextPath}/wlpt/area/getarea",
		closeIcon : "static/images/pic12.gif",
		isPhone:true,
		complete : function(data) {
			var str = "";
			if (data.province) {
				str += data.province.NAME + " ";
				$("#ToProv").val(data.province.NAME);
				$("#toAddress").val(str);
			}
			if (data.city) {
				str += data.city.NAME + " ";
				$("#ToCity").val(data.city.NAME);
				$("#toAddress").val(str);
			}
			if (data.county) {
				str += data.county.NAME;
				$("#ToArea").val(data.county.NAME);
				$("#toAddress").val(str);
			}
			$("#toAddress").val(str);
		}
	});
	var i = 0;
	var y = 0;
	$("#fromAddress").click(function() {
		i++;
		if (i % 2 == 0) {
			$(".pcc-container").hide();
		}
	});
	$("#toAddress").click(function() {
		y++;
		if (y % 2 == 0) {
			$(".pcc-container").hide();
		}
	});
</script>
<script type="text/javascript">
$(function(){
	$("#loading").hide();
	$("#fabu").click(function() {
		if (isnull()) {
			$("#loading").show();
			$("#fabu").hide();
			var GOODSID=$("input[name=GOODSID]").val();
			var GOODSNAME=$("input[name=GOODSNAME]").val();
			var FROMPROVINCE=$("input[name=FROMPROVINCE]").val();
			var FROMCITY=$("input[name=FROMCITY]").val();
			var FROMDISTRICT=$("input[name=FROMDISTRICT]").val();
			var SENDTIME=$("input[name=SENDTIME]").val();
			var FROMADDRESS=$("input[name=FROMADDRESS]").val();
			var TOPROVINCE=$("input[name=TOPROVINCE]").val();
			var TOCITY=$("input[name=TOCITY]").val();
			var TODISTRICT=$("input[name=TODISTRICT]").val();
			var TOADDRESS=$("input[name=TOADDRESS]").val();
			var TRANSPORTWAY=$("input[name=TRANSPORTWAY]").val();
			var WORTH=$("input[name=WORTH]").val();
			var CARTYPE=$("input[name=CARTYPE]").val();
			var CARLENGTH=$("input[name=CARLENGTH]").val()!=""?$("input[name=CARLENGTH]").val():null;
			var LENGTHUNIT=$("input[name=LENGTHUNIT]").val();
			var LOADWEIGHT=$("input[name=LOADWEIGHT]").val();
			var WEIGHTUNIT=$("input[name=WEIGHTUNIT]").val();
			var GOODSTYPE=$("input[name=GOODSTYPE]").val();
			var EFFECTDAYS=$("input[name=EFFECTDAYS]").val();
			var REMARKS=$("textarea[name=REMARKS]").val();
			var LINKMAN=$("input[name=LINKMAN]").val();
			var LINKMOBILE=$("input[name=LINKMOBILE]").val();
			var goodsData={
				GOODSID:GOODSID,
				GOODSNAME:GOODSNAME,
				FROMADDRESS:FROMADDRESS,	
				FROMPROVINCE:FROMPROVINCE,
				FROMCITY:FROMCITY,
				FROMDISTRICT:FROMDISTRICT,
				TOADDRESS:TOADDRESS,
				TOPROVINCE:TOPROVINCE,
				TOCITY:TOCITY,
				TODISTRICT:TODISTRICT,
				TRANSPORTWAY:TRANSPORTWAY,
				WORTH:WORTH,
				GOODSTYPE:GOODSTYPE,
				CARTYPE:CARTYPE,
				CARLENGTH:CARLENGTH,
				LOADWEIGHT:LOADWEIGHT,
				WEIGHTUNIT:WEIGHTUNIT,
				LENGTHUNIT:LENGTHUNIT,
				EFFECTDAYS:EFFECTDAYS,
				REMARKS:REMARKS,
				LINKMAN:LINKMAN,
				LINKMOBILE:LINKMOBILE,
				SENDTIME:SENDTIME,
			};
			$.ajax({
				url: "${pageContext.request.contextPath}/weixin/goodsSource/saveGoodsSource",
				data:goodsData,
				type:'post',
				dataType:'json',
				cache : false,
				success:function(data){
						if(data.state=="1"){
								$("#loadtext").html("保存成功");
							}else{
								$("#loadtext").html("保存失败");
						}
						window.setTimeout(altmesg, "1000");
				}
			});
		}
	});
	window.altmesg=function(){
			window.location.href="${pageContext.request.contextPath}/weixin/goodsSource/goodsSource_list";
		  $("#fabu").show();
			$("#loading").hide();
			$("#loadtext").html("小运正在努力加载，请稍等！");
	  };
	window.isnull=function() {
		var isnul = true;
		isnul = isnul && $("input[name=GOODSNAME]").valid({
			methods : "required|isName",tipSide : "3"
		});
		isnul = isnul && $("input[name=fromAddress]").valid({
			methods : "required",tipSide : "3"
		});
		isnul = isnul && $("input[name=toAddress]").valid({
			methods : "required",tipSide : "3"
		});
		isnul = isnul && $("input[name=SENDTIME]").valid({
			methods : "required",tipSide : "3"
		});
		if(isnul){
			if(diffDate($("input[name=SENDTIME]"))<=0){isnul=false;}
		}
		if($("input[name=WORTH]").val()!=""){
			isnul = isnul && $("input[name=WORTH]").valid({
				methods : "required|isdecimal",tipSide : "3"
			});
			if(isnul){
				isnul=checkDecimal($("input[name=WORTH]"),3);
			}
		}
		isnul = isnul && $("#LoadWeight").valid({
			methods : "required|isdecimal",tipSide : "3"
		});
		if(isnul){
			isnul=checkDecimal($("#LoadWeight"),3);
		}
		isnul = isnul && $("#CarLength").valid({
			methods : "required|isdecimal",tipSide : "3"
		});
		if(isnul){
			isnul=checkDecimal($("#CarLength"),3);
		}
		isnul = isnul && $("input[name=	CARTYPE]").valid({
			methods : "required",tipSide : "3"
		});
		isnul = isnul && $("input[name=LINKMAN]").valid({
			methods : "required|ischinese",tipSide : "3"
		});
		isnul = isnul && $("input[name=LINKMOBILE]").valid({
			methods : "isPhone",tipSide : "3"
		});
		return isnul;
	};
	});

</script>
</body>
</html>
