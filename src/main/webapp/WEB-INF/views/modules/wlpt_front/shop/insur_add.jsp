<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_web_basic"/>
    <title>填写保单</title>


    <link href="${ctxStatic}/bootstrap/2.3.1/css_3.2cerulean/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" type="text/css">
<style>
        * {
            margin: 0px;
            padding: 0px;
        }

        body {
            font-size: 1.4rem;
            line-height: 1.42857143;
            color: #333;
            background-color: #fff;
            font-family: "微软雅黑";
        }
    
        @media screen and (max-width: 900px) {
            body {
                font-size: 1rem;
            }
        }  
        form {
            width: 100%;
            margin: 50px 0;
        }
        .main-center{
            width:900px;
            margin: 0 auto;
            text-align: center;
        }
    	.from_group{
    		width:900px;
            margin: 15px auto;
            height: 35.2px;
            
    	}
        .one { 
        	float: left;
    		width: 49%;
    		} 
    	 .two { 
        	float: right;
    		width: 49%;
    		} 
        .from_group label { 
            width:25%; 
            float:left; 
            text-align:right; 
            height:35px; 
            line-height:35px;
            font-weight: normal;
        }
        .from_group input { 
            width: 70%;
            border:1px solid #ccc;
			padding-left:5px;
            height:35px;
            margin-left: 10px;
        }
        
       
        .main-center h3{
            width: 100%;
            font-size: 22px;
            text-align: center;
            border-bottom :1px solid #ccc;
        }
        .main-center .btn{
            margin: 20px 20px;
            width: 35%;
        }
        .user_data{
            margin: 30px auto;
			text-align: center;
        }
        .load{
            width: 100%;
            height: 94%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 30px;
            left:0px;
            text-align: center;
        }
        .load img{
            margin-top: 25%;
        }
        .regbt {
            width: 200px;
            height: 33px;
            border: solid 1px;
            border-radius: 0px;
            background-color: #FFC52F;
            border-color: #FFC52F;
            cursor: pointer;
            font-weight: bold;
            text-align: center;
            color: white;
            font-size: 16px;
        }
	body{
		background-color: #FFF!important;
	}
	.imgdiv{
		float: left;
		text-align: right;
		height: 35px;
		line-height: 35px;
		font-weight: normal;
	}
		ol li {
			float: left;
			text-align: center;
		}
	#clear{
		text-align: left;
	}
</style>

</head>
<body>
        <form method="post" id="Form">
            <div class="main-center">
                <div class="baodan-one">
                    <p class="user_data">
                        <img src="/static/images/wlptfront/line-left.png">
                        <span class="title_blue">投保</span>
                        <span class="title_orange">信息</span>
                        <img src="/static/images/wlptfront/line-right.png">
                    </p>
                    <c:if test="${insurlist.insuranceway eq 0 }">
                    <div class="from_group">
	                    <div class="one">
	                        <label for="toubao_people">运单号:</label>
	                        <input type="text" id="searchinfo" name="searchinfo" class="a1" placeholder="关联运单号"/>
	                        <input type="hidden" id="orderno" name="orderno" />
	                    </div>
	                    <div class="two" style="text-align: left;">
	                        <button type="button" onclick="search();" class="regbt" style="width: 100px;">
					            <span class="goods_search_btn">搜索</span>
					        </button>
	                    </div>
                    </div>
                    </c:if>
                    <div class="from_group">
	                    <div class="one">
	                        <label for="toubao_people">投保人:</label>
	                        <input type="text" id="toubao_people" name="applicant" class="a1" placeholder="投保人姓名"/>
	                    </div>
	                    <div class="two">
	                        <label for="tel">联系电话:</label>
	                        <input type="text" id="tel" class="a1" name="applicantAddress.linkmobile" placeholder="联系电话"/>
	                    </div>
	                    
                    </div>
					<div class="from_group">
						<div class="one">
							<label for="applicantUnit">投保单位:</label>
							<input type="text" id="applicantUnit" name="applicantUnit" class="a1" placeholder="投保单位"/>
						</div>
						<div class="two">
						</div>

					</div>
 					<div class="from_group">
	                    <div class="one">
	                        <label for="Address">投保人联系地址:</label>
	                        <input id="applicantprovince" name="applicantAddress.province" type="hidden">
	                        <input id="applicantcity" name="applicantAddress.city" type="hidden">
	                        <input id="applicantdistrict" name="applicantAddress.district" type="hidden">
	                        <input name="applicantAddress.type" value="0" type="hidden">
	                        <input type="text" id="Address" readonly="readonly" placeholder="省市区/县">
	                    </div>
	                    <div class="two">
	                    	<label >投保人详细地址:</label>
	                        <input type="text"  id="applicant_address" name="applicantAddress.address" placeholder="投保人详细地址"/>
	
	                    </div>
					</div>  
					<c:if test="${insurlist.insuranceway eq 1 }">  
						<div class="from_group">
		                    <div class="one">
		                        <label for="toubao_people">证件号:</label>
		                        <input type="text" id="cardNo" name="cardNo" class="a1" placeholder="身份证/组织机构代码证"/>
		                    </div>
		                    
	                    </div>
	                    <div class="from_group" style="text-align: left;">
	                    <div class="one" style="width:98%">
	                        <label for="toubao_people"  style="width:12.5%">选择险种:</label>
	                        <input type="hidden" id="subtype" name="subtype"/>
	                        <c:if test="${not empty insurlist.subtype }">
	                        	<c:forEach items="${fn:split(insurlist.subtype,'|')}" var="val" varStatus="i" >
	                        	<input type="checkbox" id="sub_type${i.index}" name="sub_type" class="a1" 
	                        	style="height: 15px;width:15px;margin-left: 15px;"
	                        	 ${i.index==0?'checked="checked"':''} ${i.index==0?'disabled="disabled"':''} value="${val }"/>${val }
	                        	</c:forEach>
	                        </c:if>
	                    </div>
	                    
                    </div>
					</c:if>
					<c:if test="${insurlist.insuranceway eq 0 }">            
                    <div class="from_group">
						<div class="one">
	                        <label for="toubao_goods">被保货物:</label>
	                        <input type="text" id="toubao_goods" class="a1" name="goodsname" placeholder="被保险货物的名称"/>
	                    </div>
	                    <div class="two">
	                        <label for="goods_worth">货物价值(元):</label>
	                        <input type="number" id="goods_worth" class="a1" name="worth" placeholder="被保险货物的价值"/>
	                    </div>
	                    
					</div>
					<div class="from_group">
	                    <div class="one">
	                        <label for="goods_type">货物类型:</label>
	                        <input type="text" id="goods_type" class="a1" name="goodstype" placeholder="被保险货物的类型"/>
	                    	
	                    </div>
					</div>
                    
                    </c:if>
                </div>
                <div class="baodan-two">
                    <p class="user_data">
                        <img src="/static/images/wlptfront/line-left.png">
                        <span class="title_blue">车辆</span>
                        <span class="title_orange">信息</span>
                        <img src="/static/images/wlptfront/line-right.png">
                    </p>
                    
					<div class="from_group">
                    <div class="one">
                        <label for="car_id">车牌号码:</label>
                        <input type="text" id="car_id" class="a1" name="carnumber" placeholder="运输车辆车牌号码"/>
                    </div>
					</div>
                    
					<div class="from_group">
	                    <div class="one">
	                        <label for="car_type">机动车类型:</label>
	                        <input type="text" id="car_type" class="a1" name="cartype" placeholder="运输车辆机动车类型"/>
	                    </div>
                    	<div class="two">
	                        <label for="chanp_tn">厂牌型号:</label>
	                        <input type="text" id="chanp_tn" class="a1" name="carmodel" placeholder="运输车辆厂牌型号"/>
	                    </div>
					</div>
                    
					<div class="from_group">
	                    <div class="one">
	                        <label for="all_weight">总质量(吨):</label>
	                        <input type="number" id="all_weight" class="a1" name="totalweight" placeholder="运输车辆机总质量"/>
	                    </div>
                    	<div class="two">
	                        <label for="hed_weight">核定载质量(吨):</label>
	                        <input type="number" id="hed_weight" class="a1" name="carweight" placeholder="运输车辆核定载质量"/>
	                    </div>
					</div>
					<c:if test="${insurlist.insuranceway eq 1 }">  
						<div class="from_group">
		                    <div class="one">
		                        <label for="all_weight">核定载客(人):</label>
		                        <input type="number" id="passengersnum" class="a1" name="passengersnum" placeholder="核定载客人数"/>
		                    </div>
	                    	<div class="two">
		                        <label for="hed_weight">使用性质:</label>
		                        <input type="text" id="usecharacter" class="a1" name="usecharacter" placeholder="使用性质"/>
		                    </div>
						</div>
						<div class="from_group">
		                    <div class="one">
		                        <label for="all_weight">识别代码:</label>
		                        <input type="text" id="vin" class="a1" name="vin" placeholder="识别代码(车架号)"/>
		                    </div>
	                    	<div class="two">
		                        <label for="hed_weight">发动机号码:</label>
		                        <input type="text" id="engineNo" class="a1" name="engineNo" placeholder="发动机号码"/>
		                    </div>
						</div>
						<div class="from_group">
		                    <div class="one">
		                        <label for="all_weight">登记日期:</label>
		                        <input type="text" id="sendtime" class="Wdate a1" name="sendtime" readonly="readonly" placeholder="登记日期"
		                        onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm',isShowClear:false,maxDate: '%y-%M-%d %H:%m'});"/>
		                    </div>
	                    	
						</div>
					</c:if>
                </div>
                <c:if test="${insurlist.insuranceway eq 0 }">
                <div class="baodan-three">
                    <p class="user_data">
                        <img src="/static/images/wlptfront/line-left.png">
                        <span class="title_blue">运输</span>
                        <span class="title_orange">信息</span>
                        <img src="/static/images/wlptfront/line-right.png">
                    </p>
                    
					<div class="from_group">
	                    <div class="one">
	                        <label for="from_address">始发地:</label>
	                        <input id="fromprovince" name="shipAddress.province" type="hidden">
	                        <input id="fromcity" name="shipAddress.city" type="hidden">
	                        <input id="fromdistrict" name="shipAddress.district" type="hidden">
	                        <input name="shipAddress.type" value="0" type="hidden">
	                        <input type="text" id="from_address" class="a1" placeholder="始发地址" readonly="readonly"/>
	                    </div>
	                    <div class="two">
	                        <label for="from_address">详细地址:</label>
	                        <input type="text" id="detail_faddress" class="a1" name="shipAddress.address" placeholder="始发详细地址"/>
	                    </div>
					</div>
                    
					<div class="from_group">
	                    <div class="one">
	
	                        <label for="end_address">目的地:</label>
	                        <input id="toprovince" name="consignAddress.province" type="hidden">
	                        <input id="tocity" name="consignAddress.city" type="hidden">
	                        <input id="todistrict" name="consignAddress.district" type="hidden">
	                        <input name="consignAddress.type" value="1" type="hidden">
	                        <input type="text" id="end_address" class="a1" placeholder="目的地址" readonly="readonly"/>
	                    </div>
                    	<div class="two">

	                        <label for="end_address">详细地址:</label>
	                        <input type="text" id="detail_taddress" class="a1" name="consignAddress.address" placeholder="目的详细地址"/>
	                    </div>
					</div>
					
                </div>
                </c:if>

				<c:if test="${insurlist.insuranceway eq 1 }">
					<div class="baodan-three">
						<p class="user_data">
							<img src="/static/images/wlptfront/line-left.png">
							<span class="title_blue">图片</span>
							<span class="title_orange">信息</span>
							<img src="/static/images/wlptfront/line-right.png">
						</p>

						<div class="from_group" style="height: 150px;">
							<div class="one" style="height: 140px;width:70%;">
								<div class="imgdiv" style="width: 17.5%;">营业执照或身份证:</div>
								<div class="imgdiv" style="width: 70%;text-align: center;margin-left: 40px;">
								<input type="hidden" id="idCardImg" name="idCardImg" htmlEscape="false" maxlength="255" class="input-xlarge" >
								<sys:ckfinder input="idCardImg" type="images"
											  uploadPath="/insurance" selectMultiple="true" maxWidth="165"
											  maxHeight="165" btnName="上传照片" maxnumber="2"/>
								</div>
							</div>
							</div>
						</div>
						<div class="from_group" style="height: 150px;">
							<div class="one" style="height: 140px;width:70%;">
								<div class="imgdiv" style="width: 17.5%;">行驶证:</div>
								<div class="imgdiv" style="width: 70%;text-align: center;margin-left: 40px;">
									<input type="hidden" id="vehicleLicenseImg" name="vehicleLicenseImg" htmlEscape="false" maxlength="255" class="input-xlarge" >
									<sys:ckfinder input="vehicleLicenseImg" type="images"
												  uploadPath="/insurance" selectMultiple="false" maxWidth="165"
												  maxHeight="165" btnName="上传照片" />
								</div>
							</div>
							</div>
						</div>
						<div class="from_group" style="height: 150px;">
							<div class="one" style="height: 140px;width:70%;">
								<div class="imgdiv" style="width: 17.5%;">合格证:</div>
								<div class="imgdiv" style="width: 70%;text-align: center;margin-left: 40px;">
									<input type="hidden" id="qualifiedImg" name="qualifiedImg" htmlEscape="false" maxlength="255" class="input-xlarge" >
									<sys:ckfinder input="qualifiedImg" type="images"
												  uploadPath="/insurance" selectMultiple="true" maxWidth="165"
												  maxHeight="165" btnName="上传照片" maxnumber="2"/>
								</div>
							</div>
							</div>
						</div>
						<div class="from_group" style="height: 150px;">
							<div class="one" style="height: 140px;width:70%;">
								<div class="imgdiv" style="width: 17.5%;">发票照片:</div>
								<div class="imgdiv" style="width: 70%;text-align: center;margin-left: 40px;">
									<input type="hidden" id="invoiceImg" name="invoiceImg" htmlEscape="false" maxlength="255" class="input-xlarge" >
									<sys:ckfinder input="invoiceImg" type="images"
												  uploadPath="/insurance" selectMultiple="true" maxWidth="165"
												  maxHeight="165" btnName="上传照片" maxnumber="2"/>
								</div>
							</div>
							</div>
						</div>
					</div>
				</c:if>

                <div class="baodan-four">
                    <p class="user_data">
                        <img src="/static/images/wlptfront/line-left.png">
                        <span class="title_blue">承保</span>
                        <span class="title_orange">信息</span>
                        <img src="/static/images/wlptfront/line-right.png">
                    </p>
                    
					<div class="from_group">
	                    <div class="one">
	                        <label >承保险种:</label>
	                        <input type="text"  class="a1" name="insurancetype" value="${insurlist.insurName }" readonly="readonly"/>
	                        <input type="hidden"  class="a1" name="insurlist.id" value="${insurlist.id }" readonly="readonly"/>
	                        
	                    </div>
	                    
					</div>
                    <c:if test="${insurlist.insuranceway eq 0 }">
					<div class="from_group">
	                    <div class="one">
	                        <label >理赔金额:</label>
	                        <input type="text"  value="最高${insurlist.maxAmount }元" readonly="readonly"/>
	                        <input type="hidden" class="a1" name="insuranceamount" value="${insurlist.maxAmount }"/>
	                    </div>
	                    <div class="two">
	                        <label >保险费合计(元):</label>
	                        <input type="text"  class="a1" name="insurancefeel" value="${insurlist.insurAmount }" readonly="readonly"/>
	                    </div>
					</div>
                    </c:if>
                </div>
                <div class="load">
                   <img src="/static/images/loading.gif">
                   <p>加载中</p>
                </div>
                <div class="baodan-four" style="text-align: center;">
                <input id="btnSubmit" type="button" class="btn btn-warning" value="提&nbsp;&nbsp;交&nbsp;&nbsp;保&nbsp;&nbsp;单">
                </div>
            </div>
        </form>
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.gridSelector.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script type="text/javascript" src="${ctxStatic }/jquery-select2/3.4/select2.min.js"></script>
<script src="${ctxStatic }/common/jeesite.js" type="text/javascript"></script>

<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script>
   $(".load").hide();
   
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
    	//外面的是公用的
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
        /*isnul = isnul && $("#tel").valid({
            methods: "required|isPhone"
        });*/
        
        isnul = isnul && $("input[name=carnumber]").valid({
            methods: "required"
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
        if ($(".load").is(':hidden') && isnul) {
        	if($("#goods_worth").val()*1>300000){
            	$("#goods_worth").tips({
                    side: 3,
                    msg: '货物价值不能高于30万元',
                    bg: '#00A2E9',
                    time: 4
                });
            	return false;
            }
            $(".load").show();
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
	            url: "${wlpt}/wlpt/shop/saveInsur?" + $("#Form").serialize(),
	            dataType: 'json',
	            type: "post",
	            success: function (data) {
	                if (data.state == 1) {
	                	<c:if test="${insurlist.ismeasure eq 0 }">
	                	$.MsgBox.Confirm("温馨提示", "您的保单已提交，可立即支付或在我的保单页面后续支付。是否立即支付？", function() {
	                    	window.location.href = "${wlpt}/wlpt/shop/toinsurpay?id="+data.data.id+"&index=4";
	                	 }, function() {
	                		 window.location.href = "${wlpt}/wlpt/shop/insur_list?index=2";
	             		}, null, null, "立即支付", "取消");
	                	</c:if>
	                	<c:if test="${insurlist.ismeasure eq 1 }">
	                		$.MsgBox.Alert("保存提示", "保单提交成功，等待客服人员测算保费，再在我的保单页面进行支付!");
	                		$(".load").hide();
	                		window.location.href = "${wlpt}/wlpt/shop/insur_list?index=2";
	                		
	                	</c:if>
	                } else {
	                    $.MsgBox.Alert("保存提示", data.value.message);
	                }
	            }
	        });
        }, function() {
        	 $(".load").hide();
		}, null, null, "确定", "取消");
    });
</script>
</body>

</html>