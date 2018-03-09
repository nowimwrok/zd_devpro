<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>编辑车源</title>

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
<link href="static/css/weixin/global.css" rel="stylesheet" type="text/css">
<style type="text/css">
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
</style>
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

</head>
<body>
	<div id="content">
		<%-- <%@ include file="../pagetitle.jsp"%> --%>
		<div>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="30%" style="text-align:right;">
						<col width="65%" style="text-align:right;">
					</colgroup>
					<tbody>
						<tr>
							<td align="right"><span class="font-red">*</span>车牌号码：</td>
							<td>
								<input id="carnumber" name="carNumber" readonly="readonly"style="float:left;width:60%"
								type="text" value="${result.data.CARNUMBER }"> <input id="btn-selectcar"
								type="button" class="regbt smallbtn" style="float:right;" value="选择车辆">
								<input id="btn-addcar"
								type="button" class="regbt smallbtn noinfo_btn" style="float:right;" value="添加车辆">
								<input type="hidden" name="CARSOURCEID" value="${result.data.CARSOURCEID }"/>
								<input type="hidden" id="hasCardID" value="${result.data.CARID  }"/>
							</td>
						</tr>
						<tr>
							<td  align="right"><span class="font-red">*</span>始发地：</td>
							<td>
									<input type="text" readonly="readonly" placeholder="请选择省市区" id="fromAddress" class="input_full"
										name="fromAddress" value="${result.data.CAR_FROMADDRESS }" /> 
									<input type="hidden" name="FROMPROVINCE" id="FromProv" value="${result.data.FROMPROVINCE }" /> 
									<input type="hidden" name="FROMCITY" id="FromCity" value="${result.data.FROMCITY }" /> 
									<input type="hidden" name="FROMDISTRICT" id="FromArea" value="${result.data.FROMDISTRICT }" />
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
										value="${result.data.CAR_TOADDRESS }" /> 
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
							<td align="right"><span class="font-red">*</span>发车时间：</td>
							<td>
									<input type="text" name="DEPARTURETIME" class="input_full" value="${result.data.DEPARTURETIME }" id="DEPARTURETIME" readonly="readonly"
										onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
							</td>
						</tr>
						<tr>
							<td align="right">车型：</td>
							<td>
									<input type="text" class="input_full" readonly="readonly"	id="CarType" name="CARTYPE"	value="${result.data.CARTYPE}" />
							</td>
						</tr>
						<tr>
							<td align="right">车长：</td>
							<td>
									<input type="text" class="input_eigth" name="CARLENGTH"	id="CarLength" value="${result.data.CARLENGTH }" maxlength="10">
									<span class="span_flt_right">米</span><input name="LENGTHUNIT" type="hidden" value="米">
							</td>
						</tr>
						<tr>
							<td align="right">载重：</td>
							<td>
									<input type="text" readonly="readonly"  class="input_full" id="LoadWeight"
										value="${result.data.LOADWEIGHT}"	name="LOADWEIGHT" />
									<input style="display:none;height:34px" id="WeightUnit"	name="WEIGHTUNIT" value="吨" />
							</td>
						</tr>
						<tr>
							<td align="right">剩余载重：</td>
							<td>
									<input type="text" name="REMAINWEIGHT" class="input_eigth" id="REMAINWEIGHT" maxlength="10" value="${result.data.LOADWEIGHT }"><span class="span_flt_right">吨</span>
							</td>
						</tr>
						<tr>
							<td align="right"><span class="font-red">*</span>有效天数：</td>
							<td>
									<input type="text" class="input_eigth" value="${result.data.EFFECTDAY!=null?result.data.EFFECTDAY:'7'}" id="Effectdays"
										name="EFFECTDAYS" /><span class="span_flt_right">天</span>
							</td>
						</tr>
						<tr>
							<td valign="top" align="right">补充说明：</td>
							<td><textarea name="REMARKS" rows="5" id="REMARKS" style="border:none;" maxlength="100">${result.data.REMARKS }</textarea>
							</td>
						</tr>
						<tr>
							<td style="text-align:left;" colspan="2">联系人信息</td>
						</tr>
						<tr>
							<td align="right"><span class="font-red">*</span>姓名：</td>
							<td>
									<input type="text" name="CONTACTNAME" class="input_full"
									id="CONTACTNAME" maxlength="10" value="${result.data.CONTACTNAME!=null?result.data.CONTACTNAME:userPd.NAME}"> <span
									class="errorTip"></span>
							</td>
						</tr>
						<tr>
							<td style="border:none;" align="right"><span class="font-red">*</span>手机号码：</td>
							<td style="border:none;">
									<input type="text" name="CONTACTMOBILE" id="CONTACTMOBILE"  class="input_full"
										maxlength="11" value="${result.data.CONTACTMOBILE!=null?result.data.CONTACTMOBILE:userPd.PHONE}">
							</td>
						</tr>
					</tbody>
				</table>
			<div id='loading' style='width:100%;vertical-align: middle;text-align:center;height:45px'>
				<div>
					<img src='static/images/loading-30x30.gif'>
				</div>
				<div style="font-size:14px;font-weight:bold;" id="loadtext">小卓正在努力加载，请稍等!</div>
			</div>
			<p align="center" style="margin-top:20px;padding-bottom: 30px;">
				<button class="regbt" id="fabu">
					<span style="margin-top: -1px;">保&nbsp;存</span>
				</button>
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
$(function(){
	//车辆类型$.myConfig
	$.ajax({
		url : "${pageContext.request.contextPath}/weixin/car/getCarType.do?tm="+ new Date().getTime(),
		dataType : 'json',
		cache : false,
		width : "94%",
		success : function(data) {
			$("input[name=CARTYPE]").gridSelector({
				idKey: "ORDERNUMBER",
				textKey:"NAME",
				cellWidth:100,
				cellHeight:36,
				data:data.data,
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
		complete : function(data) {
			var str = "";
			if (data.province) {
				str += data.province.NAME + " ";
				$("#FromProv").val(data.province.NAME);
			}
			if (data.city) {
				str += data.city.NAME + " ";
				$("#FromCity").val(data.city.NAME);
			}
			if (data.county) {
				str += data.county.NAME;
				$("#FromArea").val(data.county.NAME);
			}
			if(str!=" "){
				$("#fromAddress").val(str);
			}else{
				$("#fromAddress").val("");
			}
		}
	});

	$("#toAddress").PCC({
		hasCounty : true,
		width : "94%",
		height : 325,
		//color: "blue"
		url : "${pageContext.request.contextPath}/wlpt/area/getarea",
		closeIcon : "static/images/pic12.gif",
		complete : function(data) {
			var str = "";
			if (data.province) {
				str += data.province.NAME + " ";
				$("#ToProv").val(data.province.NAME);
			}
			if (data.city) {
				str += data.city.NAME + " ";
				$("#ToCity").val(data.city.NAME);
			}
			if (data.county) {
				str += data.county.NAME;
				$("#ToArea").val(data.county.NAME);
			}
			if(str!=" "){
				$("#toAddress").val(str);
			}else{
				$("#toAddress").val("");
			}
		}
	});
</script>
<script type="text/javascript">
$(function(){
	$("#btn-addcar").click(function(){
		window.location.href="${pageContext.request.contextPath}/weixin/car/car_add";
	});
	$("#loading").hide();
	$("#fabu").click(function() {
		if (isnull()) {
			$("#loading").show();
			$("#fabu").hide();
			var data = {
					CARNUMBER:$("#carnumber").val(),
					FROMADDRESS:$("input[name=FROMADDRESS]").val(),
					FROMPROVINCE:$("input[name=FROMPROVINCE]").val(),
					FROMCITY:$("input[name=FROMCITY]").val(),
					FROMDISTRICT:$("input[name=FROMDISTRICT]").val(),
					TOADDRESS:$("input[name=TOADDRESS]").val(),
					TOPROVINCE:$("input[name=TOPROVINCE]").val(),
					TOCITY:$("input[name=TOCITY]").val(),
					TODISTRICT:$("input[name=TODISTRICT]").val(),
					REMAINWEIGHT:$("input[name=REMAINWEIGHT]").val(),
					WEIGHTUNIT:"吨",
					LENGTHUNIT:"米",
					CARTYPE:$("input[name=CARTYPE]").val(),
					CARLENGTH:$("input[name=CARLENGTH]").val(),
					LOADWEIGHT:$("input[name=LOADWEIGHT]").val(),
					/* COMPANYNAME:$("input[name=CompanyName]").val(), */
					CONTACTNAME:$("input[name=CONTACTNAME]").val(),
					CONTACTMOBILE:$("input[name=CONTACTMOBILE]").val(),
					DEPARTURETIME:$("input[name=DEPARTURETIME]").val(),
					REMARKS:$("input[name=REMARKS]").val(),
					EFFECTDAY:$("input[name=EFFECTDAY]").val()
				};
			$.ajax({
				url: "${pageContext.request.contextPath}/weixin/carSource/saveCarSource",
				data:data,
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
		  $("#fabu").show();
			$("#loading").hide();
			$("#loadtext").html("小卓正在努力加载，请稍等！");
	  };
	window.isnull=function() {
		var isnul = true;
		isnul = isnul && $("input[name=carNumber]").valid({
			methods : "required|isCarNumbers",tipSide : "3"
		});
		isnul = isnul && $("input[name=fromAddress]").valid({
			methods : "required",tipSide : "3"
		});
		isnul = isnul && $("input[name=toAddress]").valid({
			methods : "required",tipSide : "3"
		});
		isnul = isnul && $("input[name=DEPARTURETIME]").valid({
			methods : "required",tipSide : "3"
		});
		if(isnul){
			if(diffDate($("input[name=DEPARTURETIME]"))<=0){isnul=false;}
		}
		isnul = isnul && $("input[name=	CARTYPE]").valid({
			methods : "required",tipSide : "3"
		});
		isnul = isnul && $("#CarLength").valid({
			methods : "required|isdecimal",tipSide : "3"
		});
		isnul = isnul && $("#LoadWeight").valid({
			methods : "required|isdecimal",tipSide : "3"
		});
		if($("input[name=REMAINWEIGHT]").val()!=""){
			isnul = isnul && $("input[name=REMAINWEIGHT]").valid({
				methods : "required|isdecimal",tipSide : "3"
			});
		}
		isnul = isnul && $("input[name=EFFECTDAYS]").valid({
			methods : "required|isNum",tipSide : "3"
		});
		isnul = isnul && $("input[name=CONTACTNAME]").valid({
			methods : "required|isName",tipSide : "3"
		});
		isnul = isnul && $("input[name=CONTACTMOBILE]").valid({
			methods : "isPhone",tipSide : "3"
		});
		return isnul;
	};
	});
///获取车辆number
$.ajax({
	type : "POST",
	url : '${pageContext.request.contextPath}/weixin/car/getCarNumber',
	dataType : 'json',
	data:"",
	cache : false,
	success : function(data) {
		$("#btn-selectcar").gridSelector({
			idKey: "CARID",
			textKey:"CARNUMBER",
			colNum: 2,
			cellWidth:100,
			cellHeight:36,
			data:data.data,
			multiSelect:false,
			complete:function(data){
				$("#carnumber").val(data.CARNUMBER);
				$("#CarType").val(data.CARTYPE);
				$("#CarLength").val(data.CARLENGTH);
				//$("#carlength").val(data.CarLength);
				$("#LoadWeight").val(data.LOADWEIGHT);
				//$("#WeightUnit").val(data.WeightUnit);
			}
					});
		if(data.ltcarpd.length<=0){
			$("#btn-selectcar").css("display","none");
			$("#noinfo").css("display","block");
		}
	},
	error : function() {
		alert("erron");
	}
});
</script>
</body>
</html>
