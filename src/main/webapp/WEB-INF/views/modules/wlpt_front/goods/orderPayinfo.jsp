<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <title>支付信息管理</title>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic }/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
    <script type="text/javascript" src="/static/common/global.js"></script>
    <script type="text/javascript">
    
        $(document).ready(function () {
        	var ooferprice="${quoteinfo.ooferprice}"*1;
        	var oddloadweight="${quoteinfo.oddloadweight}"*1;
            var total=xround(ooferprice*oddloadweight,2);
            $("#totalCost").html(total);
            ///单选按钮第一个值选择
            $('input:radio:first').attr('checked', 'checked');
            ////是否线上支付
            $("input[name='isonlinepay']").click(function () {
                var isonline = $("input[name='isonlinepay']:checked").val();
                if (isonline == 1) {
                    $("#onlinepay").slideDown("slow");
                } else {
                    $("#onlinepay").slideUp();
                    $("#lineamount").html("0.00");
                    $("#onlineamount").val("");
                    $("input[name='isprecoin']").attr("checked",false); 
                    $("input[name='payinfo.coinprepaio']").attr("checked",false); 
                    $("#coinpreamount").html("0.00");
                    $("#coinactualpay").html("0.00");
                    $("#prepay").hide();
                    //卓币
                    $("input[name='ispaycoin']").attr("checked",false); 
                    $("#paycoin").slideUp();
                    $("#coinamount").val("");
                    $("input[name='isprepay']").attr("checked",false); 
                    $("input[name='payinfo.preraio']").attr("checked",false); 
                    $("#preamount").html("0.00");
                    $("#onlinebalance").html("0.00");
                    $("#precoin").hide();
                }
            });
            
            ////卓币支付
            $("input[name='ispaycoin']").click(function () {
                var isonline = $("input[name='ispaycoin']:checked").val();
                if (isonline == 1) {
                    $("#paycoin").slideDown("slow");
                } else {
                    $("#paycoin").slideUp();
                    $("#coinamount").val("");
                    $("input[name='isprecoin']").attr("checked",false); 
                    $("input[name='payinfo.preraio']").attr("checked",false); 
                    $("#preamount").html("0.00");
                    $("#onlinebalance").html("0.00");
                    $("#precoin").hide();
                    setmount("#coinamount");
                }
            });
            
            ///余额是否预支付
            $("input[name='isprepay']").click(function(){
                var isprepay = $("input[name='isprepay']:checked").val();
                if (isprepay == 1) {
                   // $("#prepaydiv").slideDown("slow");
                    $("#prepay").slideDown("show");
                    $("input[name='payinfo.preraio']:radio:first").attr('checked', 'checked');
                } else {
                    //$("#prepaydiv").slideUp();
                    $("#prepay").slideUp();
                    $("input[name='payinfo.preraio']").attr("checked",false); 
                    $("#preamount").html("0.00");
                    $("#onlinebalance").html("0.00");
                }
            });
            
           ///卓币是否预支付
            $("input[name='isprecoin']").click(function(){
                var isprecoin = $("input[name='isprecoin']:checked").val();
                if (isprecoin == 1) {
                    //$("#prepaydiv").slideDown("slow");
                    $("#precoin").slideDown("show");
                    $("input[name='payinfo.coinprepaio']:radio:first").attr('checked', 'checked');
                } else {
                    //$("#prepaydiv").slideUp();
                    $("#precoin").slideUp();
                    $("input[name='payinfo.coinprepaio']").attr("checked",false); 
                    $("#coinpreamount").html("0.00");
                    $("#coinactualpay").html("0.00");
                }
            });

            ///线上支付
            $("input[name='payinfo.onlineamount']").change(function(){
            	///总运费
                var totalCost=$("#totalCost").html()*1;
                var isnul = true;
                isnul = isnul && $("#onlineamount").valid({
					methods : "decimal"
					});
                if(!isnul){
                	$("#onlineamount").val("0");
    			}
                ///线上支付总金额
                var onlineAmount=$("#onlineamount").val()*1;
                if(totalCost<onlineAmount){
                	$("#onlineamount").tips({
    					side:3,
    		            msg:'不能大于总运费',
    		            bg:'#00A2E9',
    		            time:4
    		       });
                	$("#onlineamount").val("0");
                }else if(totalCost==onlineAmount){
                	$("#coinamount").val("0");
                }else if(onlineAmount<0){
                	$("#onlineamount").tips({
    					side:3,
    		            msg:'不能小于0',
    		            bg:'#00A2E9',
    		            time:4
    		       });
                	$("#onlineamount").val("0");
                }
              
              
            	setmount("#onlineamount");
                
            });
          ///卓币
            $("input[name='payinfo.coinamount']").change(function(){
            	///总运费
                var totalCost=$("#totalCost").html()*1;
                
				//卓币支付
				var isnul = true;
				isnul = isnul && $("#coinamount").valid({
					methods : "decimal"
					});
				if(!isnul){
					$("#coinamount").val("0");
    			}
                //卓币支付金额
                var coinamount = $("#coinamount").val()*1;
                if(totalCost<coinamount){
                	$("#coinamount").tips({
    					side:3,
    		            msg:'不能大于总运费',
    		            bg:'#00A2E9',
    		            time:4
    		       });
                	$("#coinamount").val("0");
                }else if(totalCost==coinamount){
                	$("#onlineamount").val("0");
                }else if(coinamount<0){
                	$("#coinamount").tips({
    					side:3,
    		            msg:'线上支付卓币不能小于0',
    		            bg:'#00A2E9',
    		            time:4
    		       });
                	$("#coinamount").val("0");
                }
               	
            	setmount("#coinamount");
                
            });
            
            function setmount(type){
            	var isonline = $("input[name='ispaycoin']:checked").val();
                ///总运费
                var totalCost=$("#totalCost").html()*1;
                ///线上支付总金额
                var onlineAmount=$("#onlineamount").val()*1;
                //卓币支付金额
                var coinamount = $("#coinamount").val()*1;
                
                ///线下支付总金额
                var lineAmount=totalCost-onlineAmount-coinamount;
                lineAmount = xround(lineAmount,2);
                //$("#onlineamount").html(onlineAmount);
                $("#lineamount").html(lineAmount);
                if(lineAmount<0){
                	$(type).val("0");
                	$(type).tips({
    					side:3,
    		            msg:'线下支付不能小于0',
    		            bg:'#00A2E9',
    		            time:4
    		       });
                	///总运费
                    var totalCost=$("#totalCost").html()*1;
                    ///线上支付总金额
                    var onlineAmount=$("#onlineamount").val()*1;
                    //卓币支付金额
                    var coinamount = $("#coinamount").val()*1;
                    
                    ///线下支付总金额
                    var lineAmount=totalCost-onlineAmount-coinamount;
                    lineAmount = xround(lineAmount,2);
                    //$("#onlineamount").html(onlineAmount);
                    $("#lineamount").html(lineAmount);
                }
                
                var isprepay = $("input[name='isprepay']:checked").val();
                if (isprepay == 1) {
                	 //线上预支付比列
                    var preratio = $("input[name='payinfo.preraio']:checked").val();
                    //线上支付总运费
                    var onlineAmount=$("input[name='payinfo.onlineamount']").val()*1;
                    ///预支付总金额
                    var preAmount=xround(preratio*onlineAmount,2);
                    ///线下支付总金额
                    var onlineBalance=onlineAmount-preAmount;
                    $("#preamount").html(xround(preAmount,2));
                    $("#onlinebalance").html(xround(onlineBalance,2));
                } 
                var isprecoin = $("input[name='isprecoin']:checked").val();
                if(isprecoin == 1){
                	//线上预支付比列
                    var coinprepaio = $("input[name='payinfo.coinprepaio']:checked").val();
                    //线上支付总运费
                    var coinamount=$("input[name='payinfo.coinamount']").val()*1;
                    ///预支付总金额
                    var preAmount=xround(coinprepaio*coinamount,2);
                    ///线下支付总金额
                    var coinactualpay=coinamount-preAmount;
                    $("#coinpreamount").html(xround(preAmount,2));
                    $("#coinactualpay").html(xround(coinactualpay,2));
                }
            }

            ///线上预支付比列
            $("input[name='payinfo.preraio']").click(function(){	
                //线上预支付比列
                var preratio = $("input[name='payinfo.preraio']:checked").val();
                //线上支付总运费
                var onlineAmount=$("input[name='payinfo.onlineamount']").val()*1;
                ///预支付总金额
                var preAmount=xround(preratio*onlineAmount,2);
                ///线下支付总金额
                var onlineBalance=onlineAmount-preAmount;
                $("#preamount").html(xround(preAmount,2));
                $("#onlinebalance").html(xround(onlineBalance,2));

            });
            
          ///卓币预支付比列
            $("input[name='payinfo.coinprepaio']").click(function(){	
                //线上预支付比列
                var coinprepaio = $("input[name='payinfo.coinprepaio']:checked").val();
                //线上支付总运费
                var coinamount=$("input[name='payinfo.coinamount']").val()*1;
                ///预支付总金额
                var preAmount=xround(coinprepaio*coinamount,2);
                ///线下支付总金额
                var coinactualpay=coinamount-preAmount;
                $("#coinpreamount").html(xround(preAmount,2));
                $("#coinactualpay").html(xround(coinactualpay,2));

            });

        });
    </script>
    <style type="text/css">
    .loading_lock{
            display: none;
            width: 100%;
            height: 94%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 0px;
            text-align: center;
        }
        .loading_lock img{
            margin-top: 25%;
        }
    .regbt {
	width: 200px;
	height: 35px;
	border: solid 1px;
	border-radius: 0px;
    background-color:#FFC52F;
    border-color:#FFC52F;
	cursor: pointer;
	font-weight: bold;
	text-align: center;
	color: white;
    margin-top: 6px;
    font-size: 16px;
}
    </style>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
</head>
<body>
<div class="content_wrap" style="height:750px;">
    <p class="user_data">
    <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">生成</span><span class="title_orange">运单</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
    </p>
<form:form id="inputForm" modelAttribute="orderinfo" action="${wlpt}/wlpt/trade/createOrder" method="post" class="form-horizontal">
    <form:hidden path="id"/>
    <form:hidden path="quoteinfo.id"/>
    <form:hidden path="quoteinfo.car.carnumber"/>
    <div class="control-group" style="border-bottom: 0;">
        <label class="control-label" style="width: 200px;">货物信息：</label>
        <div class="controls">
                ${quoteinfo.goods.goodsname }&nbsp;<br>
            货运量:${quoteinfo.goods.freightvolume}${quoteinfo.goods.freightunit}&nbsp;剩余:${quoteinfo.goods.residualvolume}${quoteinfo.goods.freightunit}

        </div>
    </div>
    <div class="control-group" style="border-bottom: 0;">
        <label class="control-label" style="width: 200px;">发货信息：</label>
        <div class="controls">
            <c:choose>
                <c:when test="${not empty quoteinfo.goods.id}">
                    ${quoteinfo.goods.shipAddress.province}${quoteinfo.goods.shipAddress.city}${quoteinfo.goods.shipAddress.district}
                    &nbsp;${quoteinfo.goods.shipAddress.linkman}
                    &nbsp;${quoteinfo.goods.shipAddress.linkmobile}
                    &nbsp;${quoteinfo.goods.shipAddress.linkcompany}
                    &nbsp;${quoteinfo.goods.shipAddress.linktelphone}
                    &nbsp;${quoteinfo.goods.shipAddress.linkemail}
                </c:when>
            </c:choose>
        </div>
    </div>
    <div class="control-group" style="border-bottom: 0;">
        <label class="control-label" style="width: 200px;">收货信息：</label>
        <div class="controls">
            <c:choose>
                <c:when test="${not empty quoteinfo.goods.id}">
                    ${quoteinfo.goods.consignAddress.province}${quoteinfo.goods.consignAddress.city}${quoteinfo.goods.consignAddress.district}
                    &nbsp;${quoteinfo.goods.consignAddress.linkman}
                    &nbsp;${quoteinfo.goods.consignAddress.linkmobile}
                    &nbsp;${quoteinfo.goods.consignAddress.linkcompany}
                    &nbsp;${quoteinfo.goods.consignAddress.linktelphone}
                    &nbsp;${quoteinfo.goods.consignAddress.linkemail}
                </c:when>
            </c:choose>
        </div>
    </div>
    <div class="control-group" style="border-bottom: 0;">
        <label class="control-label" style="width: 200px;">司机信息：</label>
        <div class="controls">
            <c:choose>
                <c:when test="${not empty quoteinfo.driver}">
                    ${quoteinfo.driver.name}
                    &nbsp;${quoteinfo.driver.phone}
                    <br>
                </c:when>
            </c:choose>
    </div>
    </div>
    <div class="control-group" style="border-bottom: 0;">
        <label class="control-label" style="width: 200px;">报价车辆：</label>
        <div class="controls">
            <c:choose>
                <c:when test="${not empty quoteinfo.car}">
                <input id="carnumber" value="${quoteinfo.car.carnumber}" type="hidden"/>
                    ${quoteinfo.car.carnumber}
                    &nbsp;${quoteinfo.car.cartype}
                    &nbsp;${quoteinfo.car.carlength}米
                    &nbsp;${quoteinfo.car.loadweight}吨
                    <br>
                </c:when>
            </c:choose>
        </div>
    </div>
    <div class="control-group" style="border-bottom: 0;">
        <label class="control-label" style="width: 200px;">报价：</label>
        <div class="controls">
            报价金额:${quoteinfo.ooferprice}元
            报价吨位:${quoteinfo.oddloadweight}${quoteinfo.goods.freightunit}
        </div>
    </div>
    <div class="control-group" style="border-bottom: 0;">
        <label class="control-label" style="width: 200px;">总运费：</label>
        <div class="controls">
   <%-- <input id="total" value="${quoteinfo.ooferprice*quoteinfo.oddloadweight}" type="hidden"/>  --%>    
            <label class="numbers" id="totalCost">0.00</label> 元
        </div>
    </div>
    <div class="control-group" style="border-bottom: 0;">
        <label class="control-label" style="width: 200px;">是否线上支付：</label>
        <div class="controls">

            <form:radiobuttons id="isonlinepay" path="isonlinepay" items="${fns:getDictList('order_isonlinepay')}"
                               itemLabel="label" itemValue="value" htmlEscape="false"/>

        </div>
    </div>
    <div id="onlinepay" hidden="hidden">
    	<div style="height: 170px;">
    	<!-- 余额支付 -->
	    <div style="width: 49%;float: left;">
	        <div class="control-group" style="border-bottom: 0;">
	            <label class="control-label" style="width: 200px;">支付方式：</label>
	            <div class="controls">
	            <label class="lbl ">余额支付</label>
	            <label class="lbl ">卓币支付 <input type="checkbox" id="ispaycoin" name="ispaycoin" value="1"/></label>
	             
	            </div>
	        </div>
	       
	        <div class="control-group" style="border-bottom: 0;">
	            <label class="control-label" style="width: 200px;">线上支付金额：</label>
	            <div class="controls" id="online">
	                <form:input type="number" min="0" max="${quoteinfo.ooferprice*quoteinfo.oddloadweight}" id="onlineamount" path="payinfo.onlineamount" style="width:50%;"   htmlEscape="false" class="input-xlarge "/>元
	            </div>
	        </div>
	        <div class="control-group" style="border-bottom: 0;">
	            <label class="control-label" style="width: 200px;">线下支付金额：</label>
	            <div class="controls">
	                <label id="lineamount">0.00</label>元
	            </div>
	        </div>
	        <div class="control-group" style="border-bottom: 0;">
	            <label class="control-label" style="width: 200px;">是否预支付：</label>
	            <div class="controls">
	                <form:radiobuttons id="isprepay" path="isprepay" items="${fns:getDictList('order_isprepay')}"
	                                   itemLabel="label" itemValue="value" htmlEscape="false"/>
	
	            </div>
	        </div>
	     </div>
	     <!-- 卓币支付 -->
	    <div style="width: 49%;float: left;" hidden="hidden" id="paycoin">
	        <div class="control-group" style="border-bottom: 0;">
	            <label class="control-label" style="width: 200px;">支付方式：</label>
	            <div class="controls">
	            <label class="lbl ">卓币支付</label>
	             
	            </div>
	        </div>
	       
	        <div class="control-group" style="border-bottom: 0;">
	            <label class="control-label" style="width: 200px;">线上支付卓币：</label>
	            <div class="controls" id="online">
	                <form:input type="number" min="0" max="${quoteinfo.ooferprice*quoteinfo.oddloadweight}" id="coinamount" path="payinfo.coinamount" style="width:80%;" htmlEscape="false" class="input-xlarge "/>币
	            </div>
	        </div>
	        <div class="control-group" style="border-bottom: 0;">
	            <label class="control-label" style="width: 200px;"></label>
	            <div class="controls">
	                <label id="lineamount" class="lbl"></label>
	            </div>
	        </div>
	        <div class="control-group" style="border-bottom: 0;">
	            <label class="control-label" style="width: 200px;">是否预支付：</label>
	            <div class="controls">
	                <form:radiobuttons id="isprecoin" path="isprecoin" items="${fns:getDictList('order_isprepay')}"
	                                   itemLabel="label" itemValue="value" htmlEscape="false"/>
	
	            </div>
	        </div>
	     </div>
	     </div>
        <div id="prepaydiv" style="width:100%;">
        	 <!-- 余额预支付 -->
        	 <div style="width: 49%;float: left;height: 121px;">
            <div  hidden="hidden" id="prepay">
	            <div class="control-group" style="border-bottom: 0;">
	                <label class="control-label" style="width: 200px;">预支付比例：</label>
	                <div class="controls"  id="pre">
	                    <form:radiobuttons id="preraio" path="payinfo.preraio" items="${fns:getDictList('order_preratio')}" itemLabel="label" itemValue="value" htmlEscape="false" class="input-xlarge "/>
	                </div>
	            </div>
	            <div class="control-group" style="border-bottom: 0;">
	                <label class="control-label" style="width: 200px;">线上预支付金额：</label>
	                <div class="controls">
	                    <label id="preamount">0.00</label>元
	                </div>
	            </div>
	            <div class="control-group" style="border-bottom: 0;">
	                <label class="control-label" style="width: 200px;">线上支付余款：</label>
	                <div class="controls">
	                    <label id="onlinebalance">0.00</label>元
	                </div>
	            </div>
	        </div>	
	        </div>
	         <!-- 卓币预支付 -->
	         <div style="width: 49%;float: left;height: 121px;">
	        <div  hidden="hidden" id="precoin">
	            <div class="control-group" style="border-bottom: 0;">
	                <label class="control-label" style="width: 200px;">预支付比例：</label>
	                <div class="controls"  id="coin">
	                    <form:radiobuttons id="coinprepaio" path="payinfo.coinprepaio" items="${fns:getDictList('order_preratio')}" itemLabel="label" itemValue="value" htmlEscape="false" class="input-xlarge "/>
	                </div>
	            </div>
	            <div class="control-group" style="border-bottom: 0;">
	                <label class="control-label" style="width: 200px;">线上预支付卓币：</label>
	                <div class="controls">
	                    <label id="coinpreamount">0.00</label>币
	                </div>
	            </div>
	            <div class="control-group" style="border-bottom: 0;">
	                <label class="control-label" style="width: 200px;">线上支付卓币：</label>
	                <div class="controls">
	                    <label id="coinactualpay">0.00</label>币
	                </div>
	            </div>
	        </div>	
	        </div>
        </div>
    </div>
<div class="loading_lock" style="width: 100%;"><img src="${ctxStatic }/images/loading.gif"><p>等待中</p></div>
    <div >
        <input id="btnSubmit" class="regbt" style="width: 100px;" type="button" value="保 存"/>
    </div>

</form:form>
</div>

<script type="text/javascript">
$("#btnSubmit").click(function() {
	        var isnul = true;
	        var totalCost = $("#totalCost").html()*1;
			if($("input[name='isonlinepay']:checked").val()==1){
				isnul = isnul && $("#onlineamount").valid({
					methods : "required|decimal"
					});
				//卓币支付
				if($("input[name='ispaycoin']:checked").val()==1){
					isnul = isnul && $("#coinamount").valid({
						methods : "required|decimal"
						});
				}
				if($("#onlineamount").val()*1<0){
					$("#onlineamount").tips({
						side:3,
			            msg:'请填写正确的线上支付金额',
			            bg:'#00A2E9',
			            time:4
			       });
	        		return false;
				}
			}
			
			if(!isnul){
				return false;
			}
			
			var totalmount = ($("#coinamount").val()*1)+($("#onlineamount").val()*1)
			if(totalCost<totalmount){
				$("#btnSubmit").tips({
					side:3,
		            msg:'请填写正确的线上支付运费',
		            bg:'#00A2E9',
		            time:4
		       });
        		return false;
			}
			
			var totalonline="${not empty user.userPurse.availablebalance ? user.userPurse.availablebalance:'0.00'}"
	    	if($("#onlineamount").val()*1>totalonline*1){
	    		$("#onlineamount").tips({
	                side: 3,
	                msg: '可用余额不足',
	                bg: '#00A2E9',
	                time: 4
	            });
	            return false;
	    	}
			
            if(($("input[name='isprepay']:checked").val())==1){
           	var pre= $("input[name='payinfo.preraio']:checked").val();
           	if(pre == undefined){
           		$("#pre").tips({
						side:3,
			            msg:'请选择预支付比例',
			            bg:'#00A2E9',
			            time:4
			       });
            		return false;
            	}
           	
           	
            }
            var isonline = $("input[name='ispaycoin']:checked").val();
            if (isonline == 1) {
            	if($("#coinamount").val()*1<=0){
    				$("#coinamount").tips({
    					side:3,
    		            msg:'线上支付卓币必须大于0',
    		            bg:'#00A2E9',
    		            time:4
    		       });
            		return false;
    			}
	            var total="${not empty user.userPurse.availablecoin ? user.userPurse.availablecoin:'0.00'}"
            	if($("#coinamount").val()*1>total*1){
            		$("#coinamount").tips({
                        side: 3,
                        msg: '可用卓币不足',
                        bg: '#00A2E9',
                        time: 4
                    });
                    return false;
            	}
            }
            if(($("input[name='isprecoin']:checked").val())==1){
               	var coin= $("input[name='payinfo.coinprepaio']:checked").val();
               	if(coin == undefined){
               		$("#coin").tips({
    						side:3,
    			            msg:'请选择卓币预支付比例',
    			            bg:'#00A2E9',
    			            time:4
    			       });
                		return false;
                	}
                }
            
            $(".loading_lock").show();
            $.ajax({
                url: "${wlpt}/wlpt/trade/createOrder?"+$("#inputForm").serialize(),
                dataType: 'json',
                cache: false,
                success: function (data) {
                    if (data.value==1) {
                    	window.location.href = '${wlpt}/wlpt/trade/trade_list?searchinfo='+$("#carnumber").val();  
                    }else if(data.value==5){
                    	$("#btnSubmit").tips({
    						side:3,
    			            msg:'账户余额或卓币不足',
    			            bg:'#00A2E9',
    			            time:4
    			       });
                    	$(".loading_lock").hide();
                    }else if(data.value==3){
                    	$("#online").tips({
    						side:3,
    			            msg:'该报价已过期！',
    			            bg:'#00A2E9',
    			            time:4
    			       });
                    	$(".loading_lock").hide();
                    }else{
                    	$("#btnSubmit").tips({
    						side:3,
    			            msg:'信息缺失！！',
    			            bg:'#00A2E9',
    			            time:4
    			       });
                    	$(".loading_lock").hide();
                    }
                }
            });
			
	 });
</script>
</body>
</html>