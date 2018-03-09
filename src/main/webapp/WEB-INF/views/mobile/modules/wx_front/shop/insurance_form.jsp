<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>投保信息填写</title>
	<meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <meta name="viewport"
          content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/ionic.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/ionicons.min.css">
    <style type="text/css">
    html{
    	overflow-y:scroll; 
    }
    body{
    	background-color: #dddddd;
    	overflow-y:scroll; 
    	font-family: 微软雅黑;
    }
    .bar-bottom{
    	height: 60px;
	    bottom: 0px;
	    position: fixed;
	   
    }
    .title-font{
    	font-size: 18px;
    	font-weight: 500;
    }

    </style>
</head>
<body>
	

<!-- <div class="bar bar-header bar-dark">
	<a href="javasrcipt:" class="button button-clear icon ion-android-arrow-back"></a>
	<h1 class="title">保单确定</h1>
</div>  -->
	
	<div class="" style=" margin-bottom: 80px;">
		<form action="insurance_form_submit" method="post" id="Form" accept-charset="utf-8">
			<div class="list">
				<label class="item">
					<span class="title-font">投保信息</span>
				</label>
				<c:if test="${insurlist.insuranceway eq 0 }">
				<label class="item item-input">
				  	<span class="input-label">运单号</span>
				  	<input type="hidden" id="orderno" name="orderno" />
				    <span style="width: 62%;">
				    <input type="text" id="searchinfo" name="searchinfo"  onchange="search();"  placeholder="关联运单号" style="display: initial;    margin-right: 0px;padding-right: 0px;width: 70%;">
				    <button type="button" onclick="search();" class="button button-calm" style="width: 50px;min-width: 50px;padding: 0px 0px;min-height: 30px;height: 30px;line-height: 30px;">
			            <span class="goods_search_btn">搜索</span>
			        </button></span>
				</label>
				</c:if>
				
				<label class="item item-input">
				  	<span class="input-label">投保人</span>
				    <input type="text" placeholder="投保人姓名" id="toubao_people" name="applicant">
				</label>
				<label class="item item-input">
					<span class="input-label">联系电话</span>
					<input type="text" placeholder="投保人电话" id="tel" name="applicantAddress.linkmobile">
				</label>
				
				<c:if test="${insurlist.insuranceway eq 1 }">  
				<label class="item item-input">
					<span class="input-label">证件号</span>
				    <input type="text" placeholder="身份证/组织机构代码证" id="cardNo" name="cardNo">
				</label>
				<label class="item" style="white-space: inherit;">
					<span class="input-label">选择险种</span>
					<input type="hidden" id="subtype" name="subtype"/>
					<c:if test="${not empty insurlist.subtype }">
                       	<c:forEach items="${fn:split(insurlist.subtype,'|')}" var="val" varStatus="i" >
                       	<label class="checkbox" style=" padding: 0px 0px;" >
                       	<input type="checkbox" id="sub_type${i.index}" name="sub_type"  
                       	style="height:20px;width:20px;margin-left: 5px;"
                       	 ${i.index==0?'checked="checked"':''} ${i.index==0?'disabled="disabled"':''} value="${val }"/>
                       	 </label>
                       	 ${val }
                       	</c:forEach>
                    </c:if>
				    
				</label>
				
				</c:if>
				
				<c:if test="${insurlist.insuranceway eq 0 }">  
				<label class="item item-input">
					<span class="input-label">被保物品</span>
				    <input type="text" placeholder="被保险物品的名称" id="toubao_goods" name="goodsname">
				</label>
				<label class="item item-input">
					<span class="input-label">货物价值(元)</span>
					<input type="text" placeholder="被保险的货物价值" id="goods_worth" name="worth" >
				</label>
				<label class="item item-input">
					<span class="input-label">货物类型</span>
					<input type="text" placeholder="被保险的货物类型" id="goods_type" name="goodstype" >	
				</label>
				</c:if>
				

				<label class="item item-input">
				    <span class="input-label">
				      地址
				    </span>
				    <input id="applicantprovince" name="applicantAddress.province" type="hidden">
                    <input id="applicantcity" name="applicantAddress.city" type="hidden">
                    <input id="applicantdistrict" name="applicantAddress.district" type="hidden">
                    <input name="applicantAddress.type" value="0" type="hidden">
                    <input type="text" id="Address" readonly="readonly" placeholder="请选择联系地址">
				</label>
				<label class="item item-input">
					<span class="input-label"></span>
					<input type="text" placeholder="详细地址" id="applicant_address" name="applicantAddress.address">
				</label>
				
			</div>
			<div class="list">
				<label class="item">
					<span class="title-font">车辆信息</span>
				</label>
				<label class="item item-input">
					<span class="input-label">车牌号码</span>
					<input type="text" placeholder="运输车的车牌号码" id="car_id" name="carnumber">
				</label>
				<label class="item item-input">
					<span class="input-label">机动车类型</span>
					<input type="text" placeholder="运输车的机动车类型" id="car_type" name="cartype" >
				</label>
				<label class="item item-input">
					<span class="input-label">厂牌型号</span>
					<input type="text" placeholder="运输车辆的厂牌类型" id="chanp_tn" name="carmodel" >
				</label>
				<label class="item item-input">
					<span class="input-label">总质量(吨)</span>
					<input type="text" placeholder="运输车辆的核定载量" id="all_weight" name="totalweight" >
				</label>
				<label class="item item-input">
					<span class="input-label">核定载质量(吨)</span>
					<input type="text" id="hed_weight" name="carweight" placeholder="运输车辆核定载质量">
				</label>
				
				
				<c:if test="${insurlist.insuranceway eq 1 }">  
				<label class="item item-input">
					<span class="input-label">核定载客(人)</span>
					<input type="text" id="passengersnum" name="passengersnum" placeholder="核定载客人数">
				</label>
				<label class="item item-input">
					<span class="input-label">使用性质</span>
					<input type="text" id="usecharacter" name="usecharacter" placeholder="使用性质">
				</label>
				<label class="item item-input">
					<span class="input-label">识别代码</span>
					<input type="text" id="v" name="vin" placeholder="识别代码">
				</label>
				<label class="item item-input">
					<span class="input-label">发动机号码</span>
					<input type="text" id="engineNo" name="engineNo" placeholder="发动机号码" />
				</label>
				<label class="item item-input">
					<span class="input-label">登记日期</span>
					<input type="text" id="sendtime" name="sendtime"  placeholder="登记日期" readonly="readonly"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false,maxDate: '%y-%M-%d %H:%m'});" />
				</label>
				</c:if>
				
			</div>
			
			 <c:if test="${insurlist.insuranceway eq 0 }">
			<div class="list">
				<label class="item">
					<span class="title-font">运输信息</span>
				</label>
				<label class="item item-input">
				    <div class="input-label col col-15">
				      始发地
				    </div>
				    <input id="fromprovince" name="shipAddress.province" type="hidden">
                    <input id="fromcity" name="shipAddress.city" type="hidden">
                    <input id="fromdistrict" name="shipAddress.district" type="hidden">
                    <input name="shipAddress.type" value="0" type="hidden">
                    <input type="text" id="from_address" placeholder="始发地址" readonly="readonly"/>
				</label>
				<label class="item item-input">
					<span class="input-label col col-20"></span>
					<input type="text" id="detail_faddress" name="shipAddress.address" placeholder="始发详细地址">
				</label>
				
				<label class="item item-input">
				    <div class="input-label col col-15">
				      目的地
				    </div>
				    <input id="toprovince" name="consignAddress.province" type="hidden">
                    <input id="tocity" name="consignAddress.city" type="hidden">
                    <input id="todistrict" name="consignAddress.district" type="hidden">
                    <input name="consignAddress.type" value="1" type="hidden">
                    <input type="text" id="end_address" placeholder="目的地址" readonly="readonly"/>
				</label>
				<label class="item item-input">
					<span class="input-label col col-20"></span>
					<input type="text" id="detail_taddress" name="consignAddress.address" placeholder="目的详细地址">
				</label>
			</div>
			</c:if>
			
			<div class="list">
				<label class="item">
					<span class="title-font">承保信息</span>
				</label>
				<label class="item item-input">
					<span class="input-label">承保险种</span>
					<input type="text" name="insurancetype" value="${insurlist.insurName }" readonly="readonly">
					<input type="hidden" id="" class="a1" name="insurlist.id" value="${insurlist.id }" />
					<input type="hidden" id="" class="a1" name="insuranceamount" value="${insurlist.maxAmount }"/>
				</label>
				
				<c:if test="${insurlist.insuranceway eq 0 }">
				<label class="item item-input">
					<span class="input-label">理赔金额</span>
					<input type="text" id="" value="最高${insurlist.maxAmount }元" readonly="readonly"/>
					<input type="hidden" id="insuranceamount" name="insuranceamount" value="${insurlist.maxAmount }"/>
					<input type="hidden" id="insurancefeel" name="insurancefeel" value="${insurlist.insurAmount }" readonly="readonly">
				</label>
				</c:if>
				
			</div>
		</form>
	</div>

	<div class="bar bar-footer bar-light bar-bottom" >
	
		<div class="col">
		<c:if test="${insurlist.insuranceway eq 0 }">
			<span style="height:20px;width:20px;">合计：<span class="assertive" >${insurlist.insurAmount }元</span></span>	
		</c:if>				
		<div class="item item-checkbox col " style="font-size:8px;border: 0px;">
			<label class="checkbox" >
				<input type="checkbox"  style="height:20px;width:20px;">
			</label>
			&nbsp;&nbsp;<span>&nbsp;我已经阅读了并同意<a href="javascript:">《保险适用条款》</a></span>			
		</div>
		</div>
		<div class="col-25">
			<button class="button button-calm pull-right" id="btnSubmit">保存</button>  
		</div>
	</div>   
</body>
<script type="text/javascript" src="${ctxStatic }/weixin/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/config.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/jquery.gridSelector.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/global.js"></script>
<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery.valid.js"></script>
<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/jquery.pcc.js"></script>
<script type="text/javascript" src="${ctxStatic }/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/errorpage.js"></script>
<script>
   //$(".load").hide();
   function search() {
	    var isnul = true;
	    isnul = isnul && $("#searchinfo").valid({
	                methods: "required"
	            });
	    if (isnul) {
	        var searchinfo = $("#searchinfo").val();
	        $.ajax({
	            url: "${wlpt}/wlpt/trade/searchInfo",
	            dataType: 'json',
	            data: {searchinfo: searchinfo},
	            cache: false,
	            success: function (data) {
	                if (data) {
	                	setinputnull();
	                    if (data.value == '1') {
	                    	$("#searchinfo").val("");
	                    	$("#searchinfo").tips({
	                            side: 3,
	                            msg: '找不到指定的运单信息',
	                            bg: '#00A2E9',
	                            time: 4
	                        });
	                    	
	                    }else if (data.value == '2') {
	                    	$("#searchinfo").val("");
	                    	$("#searchinfo").tips({
	                            side: 3,
	                            msg: '只能为还未上传回单的运单购买保险',
	                            bg: '#00A2E9',
	                            time: 4
	                        });
	                    } else if (data.value == '3') {
	                    	$("#searchinfo").val("");
	                    	$("#searchinfo").tips({
	                            side: 3,
	                            msg: '该运单已购买保险',
	                            bg: '#00A2E9',
	                            time: 4
	                        });
	                    } else {
	                    	$("#orderno").val(searchinfo);
	                    	if(data.value.oinfo.quoteinfo.goods.goodsname){
	                    		$("input[name=goodsname]").val(data.value.oinfo.quoteinfo.goods.goodsname); //货物名称
	                    	}
	                    	if(data.value.oinfo.quoteinfo.goods.gsoddtype){
	                    		$("input[name=goodstype]").val(data.value.oinfo.quoteinfo.goods.gsoddtype); //货物类型
	                    	}
							if(data.value.oinfo.quoteinfo.goods.worth){
								$("input[name=worth]").val(data.value.oinfo.quoteinfo.goods.worth); //货物价值
	                    	}
	                    	
	                        
	                		//$("#Address").val(); //联系地址
	                    	//$("#applicant_address").val(); //详细地址
			                //$("#tel").val(); //联系手机号码
			                //车辆信息
							if(data.value.oinfo.quoteinfo.car.carnumber){
								 $("input[name=carnumber]").val(data.value.oinfo.quoteinfo.car.carnumber); //车牌号码
	                    	}
							if(data.value.oinfo.quoteinfo.car.cartype){
								$("input[name=cartype]").val(data.value.oinfo.quoteinfo.car.cartype); //车牌类型
	                    	}
			                //$("input[name=carmodel]").val(); //车厂牌型号
			                //$("input[name=totalweight]").val(); //重重量
			                //$("input[name=carweight]").val(); //核定载重
			                //线路地址
							if(data.value.oinfo.quoteinfo.goods.shipAddress){
								var province = data.value.oinfo.quoteinfo.goods.shipAddress.province == undefined ?"":data.value.oinfo.quoteinfo.goods.shipAddress.province;
								var city = data.value.oinfo.quoteinfo.goods.shipAddress.city == undefined ?"":data.value.oinfo.quoteinfo.goods.shipAddress.city;
								var district = data.value.oinfo.quoteinfo.goods.shipAddress.district == undefined ?"":data.value.oinfo.quoteinfo.goods.shipAddress.district;
								var address = province+city+district;
								$("#fromprovince").val(province);//始发省
								$("#fromcity").val(city);//始发市
								$("#fromdistrict").val(district);//始发县
								
								$("#from_address").val(address);//始发地
								$("#detail_faddress").val(data.value.oinfo.quoteinfo.goods.consignAddress.address);
	                    	}
			                
			                if(data.value.oinfo.quoteinfo.goods.consignAddress){
			                	var province = data.value.oinfo.quoteinfo.goods.consignAddress.province == undefined ?"":data.value.oinfo.quoteinfo.goods.consignAddress.province;
								var city = data.value.oinfo.quoteinfo.goods.consignAddress.city == undefined ?"":data.value.oinfo.quoteinfo.goods.consignAddress.city;
								var district = data.value.oinfo.quoteinfo.goods.consignAddress.district == undefined ?"":data.value.oinfo.quoteinfo.goods.consignAddress.district;
								var address = province+city+district;
								$("#toprovince").val(province);//始发省
								$("#tocity").val(city);//始发市
								$("#todistrict").val(district);//始发县
								
								$("#end_address").val(address);//目的地
								$("#detail_taddress").val(data.value.oinfo.quoteinfo.goods.consignAddress.address);
	                    	}
			                
			                
			            }
	                }
	            }
	        });
	    }else{
	    	$("#orderno").val("");
	    }
	}
   function setinputnull(){
       $("input[name=goodsname]").val(""); //货物名称
       $("input[name=goodstype]").val(""); //货物类型
       $("input[name=worth]").val(""); //货物价值
	   //$("#Address").val(""); //联系地址
       //车辆信息
       $("input[name=carnumber]").val(""); //车牌号码
       $("input[name=cartype]").val(""); //车牌类型
       //线路地址
       $("#from_address").val("");//始发地
       $("#detail_faddress").val("");
       $("#end_address").val("");//目的地
       $("#detail_taddress").val("");
   }
   //======================================================地址控件==============================================
   $("#Address").PCC({
        hasCounty: true,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        closeIcon: "/static/images/close_hover.png",
        complete: function (data) {
        	var str = "";
            var applicantcounty="";
            if (data.province) {
                str += data.province.NAME;
                $("#applicantprovince").val(data.province.NAME);
            }
            if (data.city) {
                str += data.city.NAME;
                $("#applicantcity").val(data.city.NAME);
            }
            if (data.county) {
                str += data.county.NAME;
                applicantcounty=data.county.NAME;
                $("#applicantdistrict").val(data.county.NAME);
            }
            if(applicantcounty==""){
            	str="";
            }
            $("#Address").val(str);
        }
    });
    $("#from_address").PCC({
        hasCounty: true,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        closeIcon: "/static/images/close_hover.png",
        complete: function (data) {
        	var str = "";
            var fromcounty="";
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
                fromcounty=data.county.NAME;
                $("#fromdistrict").val(data.county.NAME);
            }
            if(fromcounty==""){
            	str="";
            }
            $("#from_address").val(str);
        }
    });
    $("#end_address").PCC({
        hasCounty: true,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        closeIcon: "/static/images/close_hover.png",
        complete: function (data) {
        	var str = "";
            var tocounty="";
            if (data.province) {
                str += data.province.NAME;
                $("#toprovince").val(data.province.NAME);
            }
            if (data.city) {
                str += data.city.NAME;
                $("#tocity").val(data.city.NAME);
            }
            if (data.county) {
                str += data.county.NAME;
                tocounty=data.county.NAME;
                $("#todistrict").val(data.county.NAME);
            }
            if(tocounty==""){
            	str="";
            }
            $("#end_address").val(str);
        }
    });
    
    getCarType();

    function getCarType() {
        $.ajax({
            url: "${wlpt}/getDictListJson?type=car_type",
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data) {
                    var adds = data;
                    $("#car_type").gridSelector({
                        idKey: "value",
                        textKey: "label",
                        cellWidth: 50,
                        cellHeight: 28,
                        data: adds,
                        colNum: 7,
                        multiSelect: false,
                        complete: function (data) {
                            if (data) {
                                $("#car_type").val(data.value);
                            }
                        }
                    });
                }
            }
        });
    }
    
    $("#btnSubmit").click(function () {
    	var status = "${user.userinfo.status}";
        if (status != '2') {
        	$.MsgBox.Alert("温馨提示", "认证用户才可购买");
        	return;
        }

    	var isnul = true;
        isnul = isnul && $("input[name=applicant]").valid({
                    methods: "required|isName"
                });
        
        
        var worth =  $("input[name=worth]").val();
        isnul = isnul && $("#Address").valid({
            methods: "required"
        });
        isnul = isnul && $("#applicant_address").valid({
            methods: "required"
        });
        isnul = isnul && $("#tel").valid({
            methods: "required|isPhone"
        });
        
        isnul = isnul && $("input[name=carnumber]").valid({
            methods: "required|isCarNumbers"
        });
        isnul = isnul && $("input[name=cartype]").valid({
            methods: "required"
        });
        isnul = isnul && $("input[name=carmodel]").valid({
            methods: "required"
        });
        isnul = isnul && $("input[name=totalweight]").valid({
            methods: "required|isdecimal"
        });
        isnul = isnul && $("input[name=carweight]").valid({
            methods: "required|isdecimal"
        });
        
      //货物险
		<c:if test="${insurlist.insuranceway eq 0 }">
		
			isnul = isnul && $("input[name=goodsname]").valid({
	            methods: "required"
	        });
			isnul = isnul && $("input[name=goodstype]").valid({
			            methods: "required"
			        });
			isnul = isnul && $("input[name=worth]").valid({
			    methods: "required|isdecimal"
			});
			isnul = isnul && $("#from_address").valid({
	            methods: "required"
	        });
	        isnul = isnul && $("#detail_faddress").valid({
	            methods: "required"
	        });
	        isnul = isnul && $("#end_address").valid({
	           methods: "required"
	        });
	        isnul = isnul && $("#detail_taddress").valid({
	           methods: "required"
	        });
	        
        </c:if>
        
        //商业险
        <c:if test="${insurlist.insuranceway eq 1 }">
	        isnul = isnul && $("input[name=cardNo]").valid({
	            methods: "required"
	        });
	        isnul = isnul && $("input[name=passengersnum]").valid({
	            methods: "required|isNum"
	        });
	        isnul = isnul && $("input[name=usecharacter]").valid({
	            methods: "required"
	        });
	        isnul = isnul && $("input[name=vin]").valid({
	            methods: "required"
	        });
	        isnul = isnul && $("input[name=engineNo]").valid({
	            methods: "required"
	        });
	        isnul = isnul && $("input[name=sendtime]").valid({
                methods: "required"
            });
        </c:if>
        
        if (isnul) {
        	if($("#goods_worth").val()*1>300000){
            	$("#goods_worth").tips({
                    side: 3,
                    msg: '货物价值不能高于30万元',
                    bg: '#00A2E9',
                    time: 4
                });
            	return false;
            }
            //$(".load").show();
        } else {
            return false;
        }
        $.MsgBox.Confirm("温馨提示", "确定提交保单？", function() {
        	//商业险
            <c:if test="${insurlist.insuranceway eq 1 }">
        	var str ="";
        	$("input[name='sub_type']:checked").each(function(){ 
        		str=str+$(this).val()+"|"; 
        		//alert($(this).val()); 
        		}) 
        	$("#subtype").val(str);
        	</c:if>
        	
	        $.ajax({
	            url: "${wx}/weixin/shop/saveInsur?" + $("#Form").serialize(),
	            dataType: 'json',
	            type: "post",
	            success: function (data) {
	                if (data.state == 1) {
	                	<c:if test="${insurlist.ismeasure eq 0 }">
		                	$.MsgBox.Confirm("温馨提示", "您的保单已提交，可立即支付或在我的保单页面后续支付。是否立即支付？", function() {
		                    	window.location.href = "${wx}/weixin/shop/toinsurpay?id="+data.data.id;
		                	 }, function() {
		                		 window.location.href = "${wx}/weixin/shop/insur_list";
		             		}, null, null, "立即支付", "取消");
	                	</c:if>
	                	
	                	<c:if test="${insurlist.ismeasure eq 1 }">
	                		$.MsgBox.Alert("保存提示", "保单提交成功，等待客服人员测算保费，再在我的保单页面进行支付!");
	                		window.location.href = "${wx}/weixin/shop/insur_list";
	                		
	                	</c:if>
	                } else {
	                    $.MsgBox.Alert("保存提示", data.value.message);
	                }
	            }
	        });
        }, function() {
        	// $(".load").hide();
		}, null, null, "确定", "取消");
    });
</script>
</html>