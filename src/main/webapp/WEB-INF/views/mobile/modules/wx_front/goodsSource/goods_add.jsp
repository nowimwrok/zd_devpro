<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<html>
<head>

<title>${fns:getConst('SYSTEMTITLE')}--编辑货源</title>

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

	<link href="${ctxStatic }/weixin/css/global.css" rel="stylesheet"
	type="text/css">
<style type="text/css">
/*整体div 布局*/
.data_box {
	width: 100%;
	margin: 0 auto;
}

.data_top,.data_center,.data_bottom {
	width: 100%;
	clear: both;
	margin: 0 auto;
	background-color: #FFF;
}

.data_top {
	width: 100%;
	height: 50px;
	line-height: 50px;
	padding-left: 3%;
}

.data_center {
	width: 100%;
}

.data_bottom {
	height: 200px;
	margin-top: 20px;
	border-top: 1px solid #CCC;
	padding-top: 10px;
	padding-left: 10px;
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
	float: left;
	width: 25%;
	height: 70px;
	position: relative;
}

.ic_img img {
	position: absolute;
	left: 0;
	right: 0;
	top: 0;
	bottom: 0;
	margin: auto;
}

.center_top,.center_bottom {
	width: 100%;
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
	line-height: 75px;
}

.split {
	clear: both;
	width: 100%;
	border: 1px solid #CCC;
}

.ct_lf {
	clear: both;
	height: 40px;
	line-height: 35px;
}

.ct_lf div {
	float: left;
}

.ct_lf .input_contet {
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
	width: 25%;
	height:40px;
	line-height:40px;
	text-align: right;
}

.cb_val {
	width: 74%;
	height:40px;
	line-height:40px;
	border-bottom:1px solid #CCC;
}
.cb_val input{
	width: 90%;
	float:left;
	line-height:42px;
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

.data_tab div {
	float: left;
	text-align: center;
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

.data_title {
	clear: both;
	font-size: 16px;
	background: #EBEBEB;
	height: 35px;
	line-height: 35px;
	width: 100%;
	margin-top:10px;
	text-indent: 10px;
}

.data_title span {
	color: red;
}

.input_contet {
	height: 90px;
	float: left;
	width: 74%;
}

.input_contet div {
	height: 40px;
	width: 100%;
	border-bottom: 1px solid #CCC;
}

.input_contet div input {
	height: 40px;
	width: 100%;
}
.with_unitl{
	width:74%;
}
.cbm_btn{
	margin-bottom:20px;
	bottom:20px;
	-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px;
}
.selected {
    color:#FFBB66;
    border-bottom: 2px solid #FFBB66;
    background-color:rgba(32, 162, 226, 1);
}
a:hover {
    text-decoration: none;
    cursor: pointer;
    color: #FFBB66;
}
</style>
</head>

<body>
	<div class="data_box">
		<div class="data_top data_tab" style="width:100%;padding:0px;background-color:rgba(32, 162, 226, 1);color:white;">
			<div class="data_tab_left"><a style="display:block;width:100%;color:white;" href="${wx}/weixin/goodssource/goods_list">我的货源</a></div>
			<div class="data_tab_right selected">发布货源</div>
		</div>
		<form:form id="inputForm" modelAttribute="goods"   method="post" >
		<!-- data_top end -->
		<div id="data">
			<div class="data_center">
				<div class="data_title">
					地址信息<span>*</span>
				</div>
				<!-- center_top end -->
				<div class="center_bottom">
					<div class="cbm_info">
						<div class="ct_lf">
							<div class="ic_img">
								<img class="icon" style="width:30px;" alt="出发地"
									src="${ctxStatic }/images/weixin/ic_start.png">
							</div>
							<div class="input_contet">
								<div>
									<input id="fromAddress"  readonly="readonly" value="${goods.shipAddress.province } ${goods.shipAddress.city } ${goods.shipAddress.district }" placeholder="请选择发货地点" />
									<input type="hidden" name="shipAddress.province" id="FromProv" value="${goods.shipAddress.province }" /> 
									<input type="hidden" name="shipAddress.city" id="FromCity" value="${goods.shipAddress.city }" /> 
									<input type="hidden" name="shipAddress.district" id="FromArea" value="${goods.shipAddress.district }" />
									<input type="hidden" name="shipAddress.type"  value="0" /> 
								</div>
								<div>
									<input name="shipAddress.address" value="${goods.shipAddress.address }" placeholder="请输入发货详细地址"/>
								</div>
							</div>
						</div>
						<div class="ct_lf">
							<div class="ic_img">
								<img class="icon" style="width:30px;" alt="目的地"
									src="${ctxStatic }/images/weixin/ic_end.png">
							</div>
							<div class="input_contet">
								<div>
									<input id="toAddress" readonly="readonly" value="${goods.consignAddress.province } ${goods.consignAddress.city  } ${goods.consignAddress.district }"placeholder="请选择收货地点" />
									<input type="hidden" name="consignAddress.province" id="ToProv" value="${goods.consignAddress.province  }" /> 
									<input type="hidden" name="consignAddress.city" id="ToCity" value="${goods.consignAddress.city  }" />
									<input type="hidden" name="consignAddress.district" id="ToArea" value="${goods.consignAddress.district }" />
									<input type="hidden" name="consignAddress.type"  value="1" /> 
								</div>
								<div>
									<input name="consignAddress.address" value="${goods.consignAddress.address }" placeholder="请输入收货详细地址"/>
								</div>
							</div>
						</div>
						<div class="data_title">
							货物信息<span>*</span>
						</div>
						<div class="ct_lf">
							<div class="cb_tle" >货物名称：</div>
							<div class="cb_val">
								<input type="text" name="goodsname" maxlength="20" value="${goods.goodsname}" placeholder="请输入货物名称"/>
							</div>
						</div>
						<%-- <div class="ct_lf">
							<div class="cb_tle">货物类型：</div>
							<div class="cb_val">
								<input type="text" readonly="readonly"
								id="GoodsType" name="GOODSTYPE"	value="${result.data.GOODSTYPE!=null?result.data.GOODSTYPE:'重货' }" placeholder="请选择货物类型" /></div>
						</div> --%>
						<div class="ct_lf">
							<div class="cb_tle">货物类别：</div>
							<div class="with_unitl" >
                             <div style="line-height:40px;width:100%;">
                             <div style="float:left;"><input type="radio" id="gsoddtype" name="gsoddtype" value="0" style="" checked="checked"  /></div><div style="float:left;">成品</div>&nbsp;&nbsp;&nbsp;&nbsp;
                             <div style="float:left;"><input id="gsoddtypes" name="gsoddtype" type="radio" value="1"/></div><div style="float:left;">原材料</div>
							</div>
							</div>
						</div>
						<div class="ct_lf">
							<div class="cb_tle">货物重量：</div>
							<div class="cb_val with_unitl">
								<input type="text" name="freightvolume"id="freightvolume" maxlength="10" value="${goods.freightvolume }" placeholder="请输入货物重量" onblur="checkInvalid()"/>吨
								<input style="display:none;height:34px" id="freightunit" name="freightunit" value="吨" />
							</div>
						</div>
						<div class="ct_lf">
							<div class="cb_tle">期望价格：</div>
							<div class="cb_val with_unitl"><input type="text" name="expectedprice" style="width:81%;"
								id="expectedprice" maxlength="20" value="${goods.expectedprice}" placeholder="请输入期望价格" />元/吨</div>
						</div>
						<div class="ct_lf">
							<div class="cb_tle">运输方式：</div>
							<div class="cb_val with_unitl"><input type="text" id="TransportWay" readonly="readonly"
										value="${result.data.TRANSPORTWAY!=null?result.data.TRANSPORTWAY:'整车'}"
										name="TRANSPORTWAY" placeholder="请选择运输方式" /></div>
						</div>
						<div class="ct_lf">
							<div class="cb_tle">发货时间：</div>
							<div class="cb_val"><input type="text" name="sendtime" value="${goods.sendtime }" id="sendtime" readonly="readonly"
								onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" placeholder="请选择发货时间"/>
							</div>
						</div>
						<div class="data_title">
							车辆信息
						</div>
						<div class="ct_lf">
							<div class="cb_tle">车型要求：</div>
							<div class="cb_val"><input type="text" id="cartype" readonly="readonly" class="input_full"
									 name="cartype" value="${goods.cartype}" placeholder="建议选择车型"/></div>
						</div>
						<div class="ct_lf">
							<div class="cb_tle">车长要求：</div>
							<div class="cb_val">								
								<input type="text" id="CarLength" name="carlength" value="${goods.carlength}" placeholder="建议填写车长"/>
								<input name="lengthunit" type="hidden" value="米">
							</div>
						</div>
						<div class="data_title">
							联系人信息<span>*</span>
						</div>
						<div class="ct_lf">
							<div class="cb_tle">联系人：</div>
							<div class="cb_val"><input type="text" name="shipAddress.linkman" 
									id="shipAddresslinkman" maxlength="10" value="${goods.shipAddress.linkman}" placeholder="请输入联系人"/></div>
						</div>
						<div class="ct_lf">
							<div class="cb_tle">公司名称：</div>
							<div class="cb_val"><input type="text" name="shipAddress.linkcompany" 
									id="shipAddresslinkcompany" maxlength="30" value="${goods.shipAddress.linkcompany}" placeholder="请输入公司名称"/></div>
						</div>
						<div class="ct_lf">
							<div class="cb_tle">手机号码：</div>
							<div class="cb_val"><input type="text" name="shipAddress.linkmobile" id="linkmobile"
										maxlength="11" value="${goods.shipAddress.linkmobile}" placeholder="请输入联系手机" /></div>
						</div>
						<div class="data_title">
							收货人信息<span>*</span>
						</div>
						<div class="ct_lf">
							<div class="cb_tle">联系人：</div>
							<div class="cb_val"><input type="text" name="consignAddress.linkman" 
									id="consignAddresslinkman" maxlength="10" value="${goods.consignAddress.linkman}" placeholder="请输入收货人姓名"/></div>
						</div>
						<div class="ct_lf">
							<div class="cb_tle">公司名称：</div>
							<div class="cb_val"><input type="text" name="consignAddress.linkcompany" 
									id="consignAddresslinkcompany" maxlength="30" value="${goods.consignAddress.linkcompany}" placeholder="请输入收货人公司名称"/></div>
						</div>
						<div class="ct_lf">
							<div class="cb_tle">手机号码：</div>
							<div class="cb_val"><input type="text" name="consignAddress.linkmobile" id="consignAddresslinkmobile"
										maxlength="11" value="${goods.consignAddress.linkmobile}" placeholder="请输入收货人手机" /></div>
						</div>
					</div>
				</div>
				<!-- center_bottom end -->
			</div>
			<!-- data_center end -->
			<div id='loading' style='width:100%;display:none;vertical-align: middle;text-align:center;height:45px'>
				<div>
					<img src='${ctxStatic }/images/weixin/loading-30x30.gif'>
				</div>
				<div style="font-size:14px;font-weight:bold;" id="loadtext">加载中，请稍等!</div>
			</div>
			<div class="cbm_btn sub_btn" id="sub_btn">提交</div>
			<input type="hidden" id="id" name="id" value="${goods.id}"/>
		</div>
		</form:form>
	</div>
	<!-- data_box end -->
	<script type="text/javascript" src="${ctxStatic }/weixin/js/jquery-1.7.2.js"></script>
	<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/jquery.pcc.js"></script>
	<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/config.js"></script>

	<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
	<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
	<script src="${ctxStatic }/weixin/js/weixin/global.js"></script>
	<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/jquery.gridSelector.js"></script>
	<script type="text/javascript" src="${ctxStatic }/My97DatePicker/WdatePicker.js"></script>
	
	<script type="text/javascript">
	
		$(function() {
			$(".data_tab div").click(function() {
				$(this).addClass("selected");
				$(".data_tab div").not(this).removeClass("selected");
				$(this).css("color","red"); 
			});
		});
		
		//运输方式
		(function(){
	        $.ajax({
	            url: "${wlpt}/getDictListJson?type=transportway",
	            dataType: 'json',
	            cache: false,
	            success: function (data) {
	                if (data) {
	                    var adds = data;
	                    $("#transportway").gridSelector({
	                        idKey: "value",
	                        textKey: "label",
	                        cellWidth: 50,
	                        cellHeight: 28,
	                        data: adds,
	                        colNum: 7,
	                        multiSelect: false,
	                        complete: function (data) {
	                            if (data) {
	                                $("#transportway").val(data.value);
	                            }
	                        }
	                    });
	                }
	            }
	        });
	    })();
		//车型
		(function() {
	        $.ajax({
	            url: "${wlpt}/getDictListJson?type=car_type",
	            dataType: 'json',
	            cache: false,
	            success: function (data) {
	                if (data) {
	                    var adds = data;
	                    $("#cartype").gridSelector({
	                        idKey: "value",
	                        textKey: "label",
	                        cellWidth: 50,
	                        cellHeight: 28,
	                        data: adds,
	                        colNum: 7,
	                        multiSelect: false,
	                        complete: function (data) {
	                            if (data) {
	                                $("#cartype").val(data.value);
	                            }
	                        }
	                    });
	                }
	            }
	        });
	    })();


		//********************************************************初始化地区********************************************************//

		$("#fromAddress").PCC({
			hasCounty : true,
			width : "94%",
			height : 325,
			//color: "blue"
			url : "${wlpt}/wlpt/chinaarea/getArea",
			closeIcon : "static/images/pic12.gif",
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
				if(str!=""){
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
			url : "${wlpt}/wlpt/chinaarea/getArea",
			closeIcon : "static/images/pic12.gif",
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
				if(str!=""){
					$("#toAddress").val(str);
				}else{
					$("#toAddress").val("");
				}
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
	//选中货物类别
	$("input[name='GSODDTYPE']").on('click',function(){
		$(this).attr("checked","checked");
	});
	
	$("#loading").hide();
	$("#sub_btn").click(function() {
		/*  isStatused(); */
		var status ='${user.userinfo.status}';		
		/* $.ajax({
			url : "${pageContext.request.contextPath}/weixin/user/islogined",
			type : "GET",
			data : {},
			async:false,  ///同步请求传递
			success : function(data) {
				status=data.status;
			}
			}); */
		//验证是否认证
		if (status!=$.myConfig.certificateStatus.status) {
			       //没有认证
			$("#linkmobile").tips({
				side:3,
	            msg:'请先完成认证!',
	            bg:'#FF7300',
	            time:3
	        });
		}else{
			//已认证即可去发布	
		 if (isnull()) {
			$("#loading").show();
			$("#sub_btn").hide();
			
/* 			var bool = checkInvalid();			
			if(!bool){
				return;
			} */
			
			 $.ajax({
	                cache: true,
	                type: "POST",
	                url: "${wx}/weixin/goodssource/saveGoods",
	                data: $('#inputForm').serialize(),// 你的formid
	                async: false,
	                error: function (request) {
	                    alert("Connection error");
	                },
	                success: function (data) {
	                	if(data.state=="1"){
							$("#loadtext").html("保存成功");
						}else{
							$("#loadtext").html("保存失败");
						}
						window.setTimeout(altmesg, "1000");
	                }
	            });
			} 
		}
	});
	window.altmesg=function(){
			window.location.href="${wx}/weixin/goodssource/goods_list";
		  $("#sub_btn").show();
			$("#loading").hide();
			$("#loadtext").html("小运正在努力加载，请稍等！");
	  };
	window.isnull=function() {
		var isnul = true;
		isnul = isnul && $("#fromAddress").valid({
			methods : "required",tipSide : "3"
		});
		isnul = isnul && $("#toAddress").valid({
			methods : "required",tipSide : "3"
		});
		isnul = isnul && $("input[name=goodsname]").valid({
			methods : "required|isName",tipSide : "3"
		});
		isnul = isnul && $("#freightvolume").valid({
			methods : "required|isdecimal",tipSide : "3"
		});
		isnul = isnul && $("#expectedprice").valid({
			methods : "required|isdecimal",tipSide : "3"
		});
		isnul = isnul && $("input[name=sendtime]").valid({
			methods : "required",tipSide : "3"
		});
		if(isnul){
			if(diffDate($("input[name=sendtime]"))<=0){isnul=false;}
		}
		
		isnul = isnul && $("#shipAddresslinkman").valid({
			methods : "required|ischinese",tipSide : "3"
		});
		isnul = isnul && $("#shipAddresslinkcompany").valid({
			methods : "required|ischinese",tipSide : "3"
		});
		isnul = isnul && $("#linkmobile").valid({
			methods : "isPhone",tipSide : "3"
		});
		isnul = isnul && $("#consignAddresslinkman").valid({
			methods : "required|ischinese",tipSide : "3"
		});
		isnul = isnul && $("#consignAddresslinkcompany").valid({
			methods : "required|ischinese",tipSide : "3"
		});
		isnul = isnul && $("#consignAddresslinkmobile").valid({
			methods : "isPhone",tipSide : "3"
		});
		return isnul;
	};
	});
	//判断货物数量输入是否大于0;
	function checkInvalid(){
		var freight = $("#freightvolume").val();
		
		//if(freight == 0){
		if(freight == 0||freight == null || freight == "" || freight == undefined){
			$("#freightvolume").tips({
				side:3,
				msg:'货物重量要大于0',
				bg:'#FF7300',
				time:3
			});
			return false;
		}
	}
</script>
</body>
</html>
