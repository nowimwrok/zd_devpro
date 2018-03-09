<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<html>
<head>

<title>${fns:getConst('SYSTEMTITLE')}--车辆认证</title>


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
	<link href="${ctxStatic }/weixin/css/global.css" rel="stylesheet"
	type="text/css">
<style type="text/css">
table {
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
.small_img{
	width:40px;
	height:40px;
}
.img_text {
    font-size: 0.4em;
    width: 40px;
    text-align: center;
    background-image: url(./static/images/weixin/pic_bg_normal.png);
    height: 40px;
    background-repeat: no-repeat;
    line-height: 40px;
    background-size: 40px;
    margin: 5px;
    float: left;
    cursor: pointer;
    position:relative ;
}
.img_t {
    color: rgba(37, 35, 35, 0.57);
    position: absolute;
    bottom: 0px;
    width: 40px;
    height: 28px;
}
.icon {
	float: left;
	width: 26px;
	height: 26px;
	margin-top: 7px;
}
.input_load{
	width:70%;
}
.driver_div{
	float:left;
	word-break:break-all; width:65%;
}
.upimg{width:40px;height:40px;}
.smallbtn{width:65px;};
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
	<div id="content">
		<div>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<colgroup>
						<col width="35%" style="text-align:right;">
						<col width="60%" style="text-align:right;">
					</colgroup>
					<tbody>
					<form:form action="${wx}/wlpt/car/saveCar" name="Form" id="Form" modelAttribute="car" method="post">
						<tr>
							<td align="right"><span class="font-red">*</span>车牌号码：</td>
							<td>
								<input type="hidden" id="status" name="status" value="${car.status}"/>
			                    <input type="hidden" id="carid" name="id" value="${car.id }"/>
			                    <input type="hidden" name="user.id" value="${car.user.id }"/>
			                    
								<input type="text" style="width:20%;float:left;border:1px solid #CCC;margin-top:5px;height:25px;line-height:25px;text-align:center;" 
									id="MININAME" name="mininame" value="${car.mininame}" readonly="readonly"/>
									
								<input  id="NUMBER" name="number" style="float:left;width:60%" placeholder="如：A88888"
								type="text" value="${car.number }" readonly="readonly">
							</td>
						</tr>
						<tr>
							<td align="right"><span class="font-red">*</span>车辆来源：</td>
							<td>     
							<select id="issocialcar" name="issocialcar" style="height: 30px;" disabled="disabled">
				                        <option value="0" <c:if test="${car.issocialcar==0 }">selected="selected" </c:if>>自有车辆</option>
				                        <option value="1" <c:if test="${car.issocialcar==1 }">selected="selected" </c:if>>社会车辆</option>
				                    </select>
							</td>
						</tr>
						<tr>
							<td align="right"><span class="font-red">*</span>车型：</td>
							<td>
									<input type="text" class="input_full" readonly="readonly"	id="cartype" name="cartype" value="${car.cartype}" />
							</td>
						</tr>
						<tr>
							<td align="right"><span class="font-red">*</span>车长：</td>
							<td>
									<input type="text" class="input_eigth" readonly="readonly" name="carlength"	id="carlength" value="${car.carlength }" maxlength="10">
									<span class="span_flt_right">米</span>
							</td>
						</tr>
						<tr>
							<td align="right"><span class="font-red">*</span>载重：</td>
							<td>
									<input type="text" class="input_eigth" id="loadweight"
										value="${car.loadweight}"	name="loadweight" readonly="readonly"/>
									<span class="span_flt_right">吨</span>
							</td>
						</tr>
						<tr>
							<td align="right"><span class="font-red">*</span>主营线路：</td>
							<td>
									<img class="icon"
								src="${pageContext.request.contextPath}/static/images/weixin/local.png" /><input
								type="text" readonly="readonly" placeholder="请选择省市"
								name="fromaddress" id="fromAddress" value="${car.fromaddress }" class="input_load" />
								<hr> <img class="icon"
								src="${pageContext.request.contextPath}/static/images/weixin/flag.png" />
								<input type="text"  name="toaddress" id="toAddress" value="${car.toaddress }" readonly="readonly"
								placeholder="请选择省市" class="input_load" /> 
							</td>
						</tr>
						
						<tr>
							<td align="right">常停放位置：</td>
							<td>
									<input type="text" style="height:35px;" maxlength="150" class="input_full" readonly="readonly" id="oftenparkedposition"	name="oftenparkedposition" value="${car.oftenparkedposition }"/>
							</td>
						</tr>
						
						<tr>
							<td align="right">车主姓名：</td>
							<td>
									<input type="text" name="ownername" id="ownername" value="${car.ownername }"class="input_full" 
									maxlength="10" readonly="readonly"> <span
									class="errorTip"></span>
							</td>
						</tr>
						<tr>
							<td align="right">车主手机号：</td>
							<td>
									<input type="text" name="ownermobile" id="ownermobile"  class="input_full"
										maxlength="11" value="${car.ownermobile }" readonly="readonly">
							</td>
						</tr>
						<tr>
							<td align="right">行驶证：</td>
							<td id="a">
									<input type="hidden" name="travellicimg" id="travellicimg" value="${travellicimg }"/>
									<input type="hidden" name="TRAVELLICIMG1" id="TRAVELLICIMG1" value="${travellicimg1 }"/>
									<input type="hidden" name="TRAVELLICIMG2" id="TRAVELLICIMG2" value="${travellicimg2 }"/>
									<c:choose>
										<c:when test="${not empty travellicimg1 }">
											<div class="img_text" id="TravelLicImg1" >
											<img src="${travellicimg1}" class="upimg"/></div>
										</c:when>
										<c:otherwise>
												<div class="img_text" id="TravelLicImg1" ><div class="img_t">正面</div></div>
										</c:otherwise>
									</c:choose>
									<c:choose>
										<c:when test="${not empty travellicimg2 }">
											<div class="img_text" id="TravelLicImg2" >
											<img src="${travellicimg2}" class="upimg"/></div>
										</c:when>
										<c:otherwise>
												<div class="img_text" id="TravelLicImg2"><div class="img_t">正面</div></div>
										</c:otherwise>
									</c:choose>
							</td>
						</tr>
						<tr>
							<td style="border:none;" align="right">车辆外观：</td>
							<td style="border:none;"   id="b">
								<input type="hidden" name="carsurfaceimg" id="carsurfaceimg" value="${carsurfaceimg }"/>
								<input type="hidden" name="CARSURFACEIMG1" id="CARSURFACEIMG1" value="${carsurfaceimg1 }"/>
								<input type="hidden" name="CARSURFACEIMG2" id="CARSURFACEIMG2" value="${carsurfaceimg2 }"/>
								<c:choose>
										<c:when test="${not empty carsurfaceimg1 }">
											<div class="img_text" id="CarSurfaceImg1" >
												<img class="upimg" src="${carsurfaceimg1}" />
											</div>
										</c:when>
										<c:otherwise>
												<div class="img_text" id="CarSurfaceImg1" ><div class="img_t">外观1</div></div>
										</c:otherwise>
								</c:choose>
								<c:choose>
										<c:when test="${not empty carsurfaceimg2 }">
											<div class="img_text" id="CarSurfaceImg2">
												<img src="${carsurfaceimg2}" class="upimg"/>
											</div>
										</c:when>
										<c:otherwise>
												<div class="img_text" id="CarSurfaceImg2" ><div class="img_t">外观2</div></div>
										</c:otherwise>
								</c:choose>
								
							</td>
						</tr>
						 </form:form>
					</tbody>
				</table>
			<div id='loading' style='width:100%;display:none;vertical-align: middle;text-align:center;height:45px'>
				<div>
					<img src='${ctxStatic }/images/weixin/loading-30x30.gif'>
				</div>
				<div style="font-size:14px;font-weight:bold;" id="loadtext">加载中，请稍等!</div>
			</div>
			<p align="center" style="margin-top:20px;padding-bottom: 30px;">
				 <c:if test="${car.status=='0'||car.status=='3'}"><button class="regbt" id="btnSubmit">
					<span style="margin-top: -1px;">申请认证</span>
				</button></c:if>
			</p>
		</div>
	</div>
	<!-- content-end -->
<script type="text/javascript" src="${ctxStatic }/weixin/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/config.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/jquery.gridSelector.js?id=111"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/global.js"></script>
<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery.valid.js"></script>
<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/jquery.pcc.js"></script>
<script type="text/javascript" src="${ctxStatic }/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/errorpage.js"></script>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="${ctxStatic}/weixin/js/weixin/weiXinUpload.js"></script>

<script type="text/javascript">

	
	$("#loading").hide();

	  window.altmesg = function() {
			$("#btnSubmit").show();
			$("#loading").hide();
			$("#loadtext").html("加载中，请稍等！");
		};
	  $("#btnSubmit").click(function () {
		    $("#loading").show();
			$("#btnSubmit").hide();
			var id="${car.id}";
	            $.ajax({
	            	url : "${wx}/weixin/authentication/car_authentication?id="+id,
	                dataType: 'json',
	                type: "post",
	                success: function (data) {
	                    if (data.state == 1) {
	                    	$("#btnSubmit").show();
							 $("#btnSubmit").html("申请认证成功");
							 $("#btnSubmit").unbind();
	                        window.location.href = '${wx}/weixin/car/car_list';
	                    } else {
	                    	altmesg();
	                        $.MsgBox.Alert("保存提示", data.message);
	                    }
	                }
	            });
	    });
</script>
</body>
</html>
