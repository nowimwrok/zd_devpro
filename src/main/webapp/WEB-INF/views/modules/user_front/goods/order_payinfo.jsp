<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html lang="zh-cn" >
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>运单生成</title>
    <link rel="stylesheet" href="${ctxStatic}/common/jeesite.css">
    <link href="//cdn.bootcss.com/angular-ui-grid/3.2.6/ui-grid.css" rel="stylesheet">

    <style type="text/css">
		.loading{
			text-align: center;
		}
		.loading_lock{
			text-align: center;
		}
		.form-control{
			border: 1px solid #ccc !important;
		}
		.ui-grid-header-cell-wrapper {
		    position: relative;
		    display: table;
		    box-sizing: border-box;
		    height: 60px;;
		}
		.ui-grid-icon-ok:before {
	        content: '\c362';
	        color: #ffffff!important;
	        background-color: rgba(17, 222, 33, 0.82)!important;
	    }
    </style>


</head>
<body style="background: #f5f5f5;">
<div ng-app="oPublishApp" ng-controller="oPublishCtrl">
<form:form id="inputForm" modelAttribute="orderinfo" action="${wlpt}/wlpt/trade/createOrder" method="post"
           class="form-horizontal">
        <form:hidden path="id"/>
        <form:hidden path="quoteinfo.id"/>
        <form:hidden path="quoteinfo.car.carnumber"/>
	<div class="row">
		<div class="col-lg-12">
			<!-- begin 基本信息 -->
            <div class="panel clearfix">
                <div class="form_container">
                    <h4 class="panel-heading">
                        基本信息
                    </h4>
                    <div class="col-sm-12 form-horizontal goods_details">
                    	<div class="col-sm-12 form-horizontal">
                        <div class="form-group col-sm-6">
                            <div class="col-sm-2 control-label text-right">货物信息</div>
                            <div class="col-sm-10 text-left">
                                <div class="form-control noborder-form-control">
                                    ${quoteinfo.goods.goodsname }<span class="vertical-line">|</span>货运量:${quoteinfo.goods.freightvolume}${quoteinfo.goods.freightunit}<span class="vertical-line">|</span>剩余:${quoteinfo.goods.residualvolume}${quoteinfo.goods.freightunit}
                                    <c:if test="${not empty quoteinfo.goods.isinsur and quoteinfo.goods.isinsur eq 1 }">
					                &nbsp;<br>
					                	是否投保:${fns:getDictLabel(quoteinfo.goods.isinsur,'yes_no','')}&nbsp;&nbsp;&nbsp;保单支付方:${fns:getDictLabel(quoteinfo.goods.paypeople,'insur_paypeople','')}
									</c:if>
                                </div>
                            </div>
                        </div>
                        <c:choose>
           					<c:when test="${not empty quoteinfo.driver}">
		                        <div class="form-group col-sm-6">
		                            <div class="col-sm-2 control-label text-right">司机信息</div>
		                            <div class="col-sm-10 text-left">
		                                <div class="form-control noborder-form-control">
		                                    ${quoteinfo.driver.name}&nbsp;${quoteinfo.driver.phone}
		                                </div>
		                            </div>
		                        </div>
                        	</c:when>
        				</c:choose>
        				</div>
        				<div class="col-sm-12 form-horizontal">
        				
                        <div class="form-group col-sm-6">
                            <div class="col-sm-2 control-label text-right">发货信息</div>
                            <div class="col-sm-10 text-left">
                                <div class="form-control noborder-form-control" style="overflow: hidden;">
                                <c:choose>
				                    <c:when test="${not empty quoteinfo.goods.id}">
				                        ${quoteinfo.goods.shipAddress.province}${quoteinfo.goods.shipAddress.city}${quoteinfo.goods.shipAddress.district}
				                    </c:when>
				                </c:choose>
                                </div>
                                <div class="form-control noborder-form-control">
                                <c:choose>
				                    <c:when test="${not empty quoteinfo.goods.id}">
				                        ${quoteinfo.goods.shipAddress.linkman}&nbsp;${quoteinfo.goods.shipAddress.linkmobile}
				                    </c:when>
				                </c:choose>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-sm-6">
                            <div class="col-sm-2 control-label text-right">收货信息</div>
                            <div class="col-sm-10 text-left">
                                <div class="form-control noborder-form-control" style="overflow: hidden;">
                                <c:choose>
                                	<c:when test="${not empty quoteinfo.goods.id}">
                                    ${quoteinfo.goods.consignAddress.province}${quoteinfo.goods.consignAddress.city}${quoteinfo.goods.consignAddress.district}
                                	</c:when>
                                </c:choose>
                                </div>
                                <div class="form-control noborder-form-control">
                                <c:choose>
                                	<c:when test="${not empty quoteinfo.goods.id}">
                                    ${quoteinfo.goods.consignAddress.linkman}&nbsp;${quoteinfo.goods.consignAddress.linkmobile}
                                	</c:when>
                                </c:choose>
                                </div>
                            </div>
                        </div>
                        </div>
                        
						<c:choose>
              				<c:when test="${not empty quoteinfo.car and not empty quoteinfo.car.id}">
              					<div class="col-sm-12 form-horizontal">
		                        <div class="form-group col-sm-6">
		                            <div class="col-sm-2 control-label text-left">报价车辆</div>
		                            <div class="col-sm-10 text-left">
		                                <div class="form-control noborder-form-control">
		                                    <input id="carnumber" value="${quoteinfo.car.carnumber}" type="hidden"/>
                        					${quoteinfo.car.carnumber} 
                        					<span class="vertical-line">|</span>${quoteinfo.car.cartype}
                        					<span class="vertical-line">|</span>${quoteinfo.car.carlength}米
                        					<span class="vertical-line">|</span>${quoteinfo.car.loadweight}吨
		                                </div>
		                            </div>
		                        </div>
		                        </div>
                        	</c:when>
        				</c:choose>
        				
        				<div class="col-sm-12 form-horizontal">
                        <div class="form-group col-sm-6">
                            <div class="col-sm-2 control-label text-left">报价金额</div>
                            <div class="col-sm-10 text-left">
                                <div class="form-control noborder-form-control">
                                    ${quoteinfo.ooferprice}元
                                </div>
                            </div>
                        </div>
                        <div class="form-group has-unit col-sm-6">
                            <div class="col-sm-2 control-label text-left">报价吨位</div>
                            <div class="col-sm-10 text-left ">
                                
                                <form:hidden path="quoteinfo.blinfoList"/>
                                <input type="number"  min="0" max="${quoteinfo.goods.residualvolume}"
		                       readonly="true" id="actload" value="${quoteinfo.oddloadweight}" ng-model="actload"
		                       name="quoteinfo.actload" class="form-control noborder-form-control" /><span class="unit">${quoteinfo.goods.freightunit}</span>
                                
                            </div>
                        </div>
                        </div>
                        <div class="col-sm-12 form-horizontal">
                        <div class="form-group col-sm-6">
                            <div class="col-sm-2 control-label text-left">总运费</div>
                            <div class="col-sm-10 text-left">
                                <div class="form-control noborder-form-control">
                                <input id="total" value="${quoteinfo.ooferprice*quoteinfo.oddloadweight}" type="hidden"/>
                               	<label id="totalCost">0.00</label>元
                               	</div>
                            </div>
                        </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
		<!-- end 基本信息 -->
		
		
		
		<!-- begin 货单信息 -->
		<div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="modal" class="modal">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                        <h4 class="modal-title">货物信息</h4>
                    </div>
                    <div class="modal-body modal-body-h form-horizontal">
                        <div class="form-group">
                            <div class="col-sm-2 control-label text-left">货物吨位</div>
                            <div class="col-sm-9 text-left">
                            	 <c:if test="${quoteinfo.goods.gsoddtype==1}">
						            <input type="text" class="form-control" id="freightvolume" ng-model="freightvolume" readonly
						                   name="freightvolume" style="width: 25%;"/>
						        </c:if>
                            </div>
                        </div>
                        <!-- <div class="loading"><img src="/static/images/loading.gif">
            				<p>加载中</p>
            			</div> -->
                        <div style="overflow-x:auto;">
                            <div ng-if="${quoteinfo.goods.gsoddtype==1}">

					            <div id="grid1" ui-grid="gridOptions" ui-grid-auto-resize ui-grid-selection ui-grid-resize-columns
					                 class="grid"></div>
					        </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
		<!-- end 货单信息 -->
		
	</div>
	<div class="row">
		<!-- begin 支付信息 -->
			<div class="col-lg-12">
            <div class="panel clearfix">
                <div class="form_container">
                    <h4 class="panel-heading">
                        支付信息
                    </h4>
                    <div class="col-sm-12 form-horizontal goods_details">
                        <div class="form-group col-sm-6">
                            <div class="col-sm-3 control-label text-left">重新配载</div>
                            <div class="col-sm-9 text-left">
                                <div class="radios">
                                    <form:radiobuttons id="isreload" path="quoteinfo.isreload" items="${fns:getDictList('order_isprepay')}"
                                   itemLabel="label" itemValue="value" htmlEscape="false"/>
                                    
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-sm-6">
                            <div class="col-sm-3 control-label text-left">是否线上支付</div>
                            <div class="col-sm-9 text-left">
                                <div class="radios" id="online-pay">
                                    <form:radiobuttons id="isonlinepay" path="isonlinepay" items="${fns:getDictList('order_isonlinepay')}"
                                   itemLabel="label" itemValue="value" htmlEscape="false"/>
                                </div>
                            </div>
                        </div>
                        
						<c:if test="${not empty quoteinfo.car.carnumber}">
                        <div class="form-group col-sm-6">
                            <div class="col-sm-3 control-label text-left">是否开通定位服务</div>
                            <div class="col-sm-9 text-left">
                                <div class="radios" id="online-pay">
                                    <form:radiobuttons id="locationFlag" path="locationFlag" items="${fns:getDictList('locationFlag')}"
                                   itemLabel="label" itemValue="value" htmlEscape="false"/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group col-sm-6">
                            <div class="col-sm-3 control-label text-left">是否开通围栏服务</div>
                            <div class="col-sm-9 text-left">
                                <div class="radios" id="online-pay">
                                    <form:radiobuttons id="railFlag" path="railFlag" items="${fns:getDictList('railFlag')}"
                                   itemLabel="label" itemValue="value" htmlEscape="false"/>
                                </div>
                            </div>
                        </div>
                        </c:if>

                        <!--折叠内容-->
                        <div class="clearfix pay_hide_box" id="onlinepay" hidden="hidden">
                            <div class="form-group col-sm-6">
                                <div class="col-sm-3 control-label text-left">支付方式</div>
                                <div class="col-sm-9 text-left">
                                    <div class="radios">
                                        <c:choose>
				                        <c:when test="${user.memberId!=null&&user.memberId!=''}">
				                        <form:radiobuttons id="payway" path="payway"
				                                               items="${fns:getDictList('payway')}"
				                                               itemLabel="label" itemValue="value" htmlEscape="false"/>
				                            
				                        </c:when>
				                        <c:otherwise>
				                        <label class="lbl ">余额支付</label>
				                        
				                        </c:otherwise>
				                        </c:choose>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- bgein 余额支付 -->
                            <div class="form-group has-unit col-sm-6">
                                <div class="col-sm-3 control-label text-left">线上支付金额</div>
                                <div class="col-sm-9 text-left">
                                	<form:input type="number" min="0" max="${quoteinfo.ooferprice*quoteinfo.oddloadweight}"
                                        id="onlineamount" path="payinfo.onlineamount" 
                                        htmlEscape="false" class="form-control"  style="border:none;border-bottom:1px solid #ddd;outline: none;border-radius:none;"/>
                                    <span class="unit">元</span>
                                </div>
                            </div>
                            
                            <div class="form-group col-sm-6">
                                <div class="col-sm-3 control-label text-left">是否预支付</div>
                                <div class="col-sm-9 text-left">
                                    <form:radiobuttons id="isprepay" path="isprepay"
                                               items="${fns:getDictList('order_isprepay')}"
                                               itemLabel="label" itemValue="value" htmlEscape="false"/>
                                </div>
                            </div>
							<div class="form-group col-sm-6">
                                <div class="col-sm-3 control-label text-left">线下支付金额</div>
                                <div class="col-sm-9 text-left has-unit">
                                    <label id="lineamount">0.00</label><i class="unit">元</i>
                                </div>
                            </div>
                            <div class="clearfix payPre_hide_box" hidden="hidden" id="prepay">
                                <div class="form-group col-lg-12">
                                    <div class="col-sm-1 control-label text-left" style="width:12.2%;">预支付比例</div>
                                    <div class="col-sm-9 text-left" id="pre">
                                        <div class="radios" >
                                            <form:radiobuttons id="preraio" path="payinfo.preraio"
                                                   items="${fns:getDictList('order_preratio')}" itemLabel="label"
                                                   itemValue="value" htmlEscape="false" class="input-xlarge "/>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-3 control-label text-left">线上预支付金额</div>
                                    <div class="col-sm-9 text-left">
                                        <label id="preamount">0.00</label><i class="unit">元</i>
                                    </div>
                                </div>
                                <div class="form-group col-sm-6">
                                    <div class="col-sm-3 control-label text-left">线上支付余款</div>
                                    <div class="col-sm-9 text-left">
                                        <label id="onlinebalance">0.00</label><i class="unit">元</i>
                                    </div>
                                </div>
                                
                            </div>
                            <!-- end 余额支付 -->
                            
                            <!-- bgein 卓币支付 -->
                            <div class="form-group col-sm-6">
                                <div class="col-sm-3 control-label text-left">支付方式</div>
                                <div class="col-sm-9 text-left">
                                    <div class="radios">
                                        
				                        <label class="lbl "><input type="checkbox" id="ispaycoin" name="ispaycoin" value="1"/>卓币支付</label>
				                       
                                    </div>
                                </div>
                            </div>
                            
                            <div class="clearfix" hidden="hidden" id="paycoin">
	                            <div class="form-group has-unit col-sm-6">
	                                <div class="col-sm-3 control-label text-left">线上支付卓币</div>
	                                <div class="col-sm-9 text-left" id="online">
	                                	<form:input type="number" min="0" max="${quoteinfo.ooferprice*quoteinfo.oddloadweight}"
                                        id="coinamount" path="payinfo.coinamount" htmlEscape="false"
                                        class="form-control"  style="border:none;border-bottom:1px solid #ddd;outline: none;border-radius:none;"/>
	                                    <span class="unit">币</span>
	                                </div>
	                            </div>
	                            <div class="form-group col-sm-6">
	                                <div class="col-sm-3 control-label text-left">是否预支付</div>
	                                <div class="col-sm-9 text-left" >
	                                    <form:radiobuttons id="isprecoin" path="isprecoin"
                                               items="${fns:getDictList('order_isprepay')}"
                                               itemLabel="label" itemValue="value" htmlEscape="false"/>
	                                </div>
	                            </div>
	                            <div class="clearfix " hidden="hidden" id="precoin">
	                                <div class="form-group col-lg-12">
	                                    <div class="col-sm-1 control-label text-left" style="width:12.2%;">预支付比例</div>
	                                    <div class="col-sm-9 text-left" id="coin">
	                                        <div class="radios" >
	                                            <form:radiobuttons id="coinprepaio" path="payinfo.coinprepaio"
                                                   items="${fns:getDictList('order_preratio')}" itemLabel="label"
                                                   itemValue="value" htmlEscape="false" class="input-xlarge "/>
	                                        </div>
	                                    </div>
	                                </div>
	                                <div class="form-group col-sm-6">
	                                    <div class="col-sm-3 control-label text-left">线上预支付金额</div>
	                                    <div class="col-sm-9 text-left">
	                                        <label id="coinpreamount">0.00</label><i class="unit">币</i>
	                                    </div>
	                                </div>
	                                <div class="form-group col-sm-6">
	                                    <div class="col-sm-3 control-label text-left">线上支付余款</div>
	                                    <div class="col-sm-9 text-left">
	                                        <label id="coinactualpay">0.00</label><i class="unit">币</i>
	                                    </div>
	                                </div>
	                                
	                            </div>
                            </div>
                            <!-- end 卓币支付 -->
                            
                            
                            
							<div class="form-group col-sm-9">
                                 <div class="col-sm-2 control-label text-left">支付密码</div>
                                 <div class="col-sm-6 text-left">
                                     <input class="form-control" id="password" type="password" style="border-bottom:1px solid #ddd;outline: none;"  value="" placeholder="支付密码">
                                 </div>
                             </div>
                        </div>
                    </div>
                </div>
            </div>
            
        
        	<div>
            <div class="form-group" style="margin-bottom: 105px;">
                <div class="col-sm-4 control-label text-left"></div>
                <div class="col-sm-8 text-left">
                    <button type="button" class="btn btn-primary col-sm-4" id="btnSubmit" ng-click="submit()">提  交</button>
                </div>
            </div>
            <c:if test="${not empty quoteinfo.goods.isinsur and quoteinfo.goods.isinsur eq 1 and quoteinfo.goods.paypeople ne 1}">
	        <div style="margin-top: 20px;">
	        	温馨提示：本次除运单费用外，另扣取<span style="color: red;font-weight: bold;">40</span>元保单费用！
	        </div>
	        </c:if>
        </div>
		<!-- end 支付信息 -->
	</div>
	</div>
	</form:form>
</div>

<script src="http://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular.min.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular-touch.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular-animate.js"></script>

<script type="text/javascript" src="${ctxStatic }/common/global.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>

<script src="${ctxStatic }/ui-grid/js/csv.js"></script>
<script src="${ctxStatic }/ui-grid/js/ui-grid.js"></script>
<script type="text/javascript">
$("#maskloading" , parent.document).hide();
    $(document).ready(function () {
        var price = '${quoteinfo.ooferprice}';
        var odweig = '${quoteinfo.oddloadweight}'
        var total = (price * 1) * (odweig * 1);
        total = xround(total, 2);
        $("#totalCost").html(total);

        ////重新配载
        
        $(".close").click(function () {
        	$("#modal").slideUp();
        })
        $("input[name='quoteinfo.isreload']").click(function () {
            var isreload = $("input[name='quoteinfo.isreload']:checked").val();
            if (isreload == 1) {
                <c:if test="${quoteinfo.goods.gsoddtype==2 or bidinfo.isupbl==0}">
                $("#actload").removeAttr("readonly");
                $("#actload").val('${quoteinfo.oddloadweight}');
                </c:if>
                <c:if test="${quoteinfo.goods.gsoddtype==1}">
                $("#modal").slideDown("slow");
                $("#actload").val($("#freightvolume").val());
                <c:if test="${quoteinfo.goods.datasource==0}">
                if ($("#freightvolume").val() * 1 != 0) {
                    $("#actload").attr("readonly", "true");
                } else {
                    $("#actload").removeAttr("readonly");
                }
                </c:if>

                <c:if test="${quoteinfo.goods.datasource!=0}">
                $("#actload").attr("readonly", "true");
                </c:if>
                </c:if>

            } else {
                $("#modal").slideUp();
                $("#actload").val('${quoteinfo.oddloadweight}');
                $("#actload").attr("readonly", "true");

            }
            $("#total").val(($("#actload").val() * 1) * '${quoteinfo.ooferprice}' * 1);
            total = $("#total").val() * 1;
            total = xround(total, 2);
            $("#totalCost").html(total);
            
            var isonline = $("input[name='isonlinepay']:checked").val();
            if (isonline == 1) {
                
            	setmount("#coinamount");
            } else {
                $("#onlinepay").slideUp();
                $("#lineamount").html("0.00");
                $("#onlineamount").val("");
                $("input[name='isprecoin']").attr("checked", false);
                $("input[name='payinfo.coinprepaio']").attr("checked", false);
                $("#coinpreamount").html("0.00");
                $("#coinactualpay").html("0.00");
                $("#prepay").hide();
                //卓币
                $("input[name='ispaycoin']").attr("checked", false);
                $("#paycoin").slideUp();
                $("#coinamount").val("");
                $("input[name='isprepay']").attr("checked", false);
                $("input[name='payinfo.preraio']").attr("checked", false);
                $("#preamount").html("0.00");
                $("#onlinebalance").html("0.00");
                $("#precoin").hide();
            }
            
        });

        ///报价吨位
        $("input[name='quoteinfo.actload']").change(function () {
            var residualvolume = '${quoteinfo.goods.residualvolume}' * 1;
            var actload = $("#actload").val() * 1;

            if (residualvolume*1 < actload*1) {
                self_fun("#actload",'不能大于剩余载重',true);
                
                $("#actload").val('${quoteinfo.oddloadweight}');
                return false;
            } else if (actload * 1 <= 0) {
                self_fun("#actload",'必须大于0',true);
                $("#actload").val('${quoteinfo.oddloadweight}');
                return false;
            }else{
            	self_fun("#actload",'',false);
            }
            actload = $("#actload").val() * 1;
            //重置运费
            $("#total").val((actload * 1) * ('${quoteinfo.ooferprice}' * 1));
            totalCost = $("#total").val() * 1;
            totalCost = xround(totalCost, 2);

            $("#totalCost").html(totalCost);
            self_fun("#onlineamount",'',false);
            if (!/^-?\d+(\.\d{1,2})?$/.test($("#onlineamount").val())) {
            	$("#onlineamount").val("0");
            	self_fun("#onlineamount",'请填写正确的数字或小数且小数点后不能超过2位',true);
            } 
            ///线上支付总金额
            var onlineAmount = $("#onlineamount").val() * 1;
            
            if (totalCost < onlineAmount) {
                self_fun("#onlineamount",'不能大于总运费',true);
                $("#onlineamount").val("0");
            } else if (totalCost == onlineAmount) {
                $("#coinamount").val("0");
            } else if (onlineAmount < 0) {
                self_fun("#onlineamount",'不能小于0',true);
                $("#onlineamount").val("0");
            }

			
            setmount("#onlineamount");

        });

        ///单选按钮第一个值选择
        //$('input:radio:first').attr('checked', 'checked');
        $("input[name='isonlinepay']:first").attr('checked', 'checked');
        $("input[name='payway']:first").attr('checked', 'checked');
        ///单选按钮第一个值选择
        $("input[name='quoteinfo.isreload']:last").attr('checked', 'checked');
        $("input[name='railFlag']:first").attr('checked', 'checked');
        $("input[name='locationFlag']:first").attr('checked', 'checked');
        ////是否线上支付
        $("input[name='isonlinepay']").click(function () {
            var isonline = $("input[name='isonlinepay']:checked").val();
            if (isonline == 1) {
            	///线上支付总金额
                $("#onlineamount").val(total);
                $("#coinamount").val("");
                setmount("#onlineamount");
                $("#onlinepay").show();
                $('.pay_hide_box').show();
            } else {
            	$("input[name='payway']").attr("checked", false);
                $("#onlinepay").hide();
                $("#lineamount").html("0.00");
                $("#onlineamount").val("");
                $("input[name='isprecoin']").attr("checked", false);
                $("input[name='payinfo.coinprepaio']").attr("checked", false);
                $("#coinpreamount").html("0.00");
                $("#coinactualpay").html("0.00");
                $("#prepay").hide();
                $('.pay_hide_box').hide();
                //卓币
                $("input[name='ispaycoin']").attr("checked", false);
                $("#paycoin").slideUp();
                $("#coinamount").val("");
                $("input[name='isprepay']").attr("checked", false);
                $("input[name='payinfo.preraio']").attr("checked", false);
                $("#preamount").html("0.00");
                $("#onlinebalance").html("0.00");
                $("#precoin").hide();
            }
        });
        
        ////卓币支付
        $("input[name='ispaycoin']").click(function () {
            var isonline = $("input[name='ispaycoin']:checked").val();
            if (isonline == 1) {
                $("#paycoin").show();
            } else {
                $("#paycoin").hide();
                $("#coinamount").val("");
                $("input[name='isprecoin']").attr("checked", false);
                $("input[name='payinfo.coinprepaio']").attr("checked", false);
                $("#coinpreamount").html("0.00");
                $("#coinactualpay").html("0.00");
                $("#precoin").hide();
                setmount("#coinamount");
            }
        });

        ///余额是否预支付
        $("input[name='isprepay']").click(function () {
            var isprepay = $("input[name='isprepay']:checked").val();
            if (isprepay == 1) {
                // $("#prepaydiv").slideDown("slow");
                $("#prepay").show();
                /* $("input[name='payinfo.preraio']:radio:first").attr('checked', 'checked'); */
            } else {
                //$("#prepaydiv").slideUp();
                $("#prepay").hide();
                $("input[name='payinfo.preraio']").attr("checked", false);
                $("#preamount").html("0.00");
                $("#onlinebalance").html("0.00");
            }
        });

        ///卓币是否预支付
        $("input[name='isprecoin']").click(function () {
            var isprecoin = $("input[name='isprecoin']:checked").val();
            if (isprecoin == 1) {
                //$("#prepaydiv").slideDown("slow");
                $("#precoin").show();
                /* $("input[name='payinfo.coinprepaio']:radio:first").attr('checked', 'checked'); */
            } else {
                //$("#prepaydiv").slideUp();
                $("#precoin").hide();
                $("input[name='payinfo.coinprepaio']").attr("checked", false);
                $("#coinpreamount").html("0.00");
                $("#coinactualpay").html("0.00");
            }
        });

        ///线上支付
        $("input[name='payinfo.onlineamount']").change(function () {
            ///总运费
            var totalCost = $("#totalCost").html() * 1;
            self_fun("#onlineamount",'',false);
            if (!/^-?\d+(\.\d{1,2})?$/.test($("#onlineamount").val())) {
            	$("#onlineamount").val("0");
            	self_fun("#onlineamount",'请填写正确的数字或小数且小数点后不能超过2位',true);
            } 
            ///线上支付总金额
            var onlineAmount = $("#onlineamount").val() * 1;
            
            if (totalCost < onlineAmount) {
                self_fun("#onlineamount",'不能大于总运费',true);
                $("#onlineamount").val("0");
            } else if (totalCost == onlineAmount) {
                $("#coinamount").val("0");
            } else if (onlineAmount < 0) {
                self_fun("#onlineamount",'不能小于0',true);
                $("#onlineamount").val("0");
            }
			

            setmount("#onlineamount");

        });
        ///卓币
        $("input[name='payinfo.coinamount']").change(function () {
        	 var isonline = $("input[name='ispaycoin']:checked").val();
             if (isonline != 1) {
            	 return false;
             }
            ///总运费
            var totalCost = $("#totalCost").html() * 1;

            //卓币支付
            self_fun("#coinamount",'',false);
            if (!/^-?\d+(\.\d{1,2})?$/.test($("#coinamount").val())) {
            	$("#coinamount").val("0");
            	self_fun("#coinamount",'请填写正确的数字或小数且小数点后不能超过2位',true);
            } 
            //卓币支付金额
            var coinamount = $("#coinamount").val() * 1;
            if (totalCost < coinamount) {
                self_fun("#coinamount",'不能大于总运费',true);
                $("#coinamount").val("0");
            } else if (totalCost == coinamount) {
                $("#onlineamount").val("0");
            } else if (coinamount < 0) {
                self_fun("#coinamount",'线上支付卓币不能小于0',true);
                $("#coinamount").val("0");
            }

            setmount("#coinamount");

        });

        function setmount(type) {
            var isonline = $("input[name='ispaycoin']:checked").val();
            ///总运费
            var totalCost = $("#totalCost").html() * 1;
            ///线上支付总金额
            var onlineAmount = $("#onlineamount").val() * 1;
            //卓币支付金额
            var coinamount = $("#coinamount").val() * 1;

            ///线下支付总金额
            var lineAmount = totalCost - onlineAmount - coinamount;
            lineAmount = xround(lineAmount, 2);
            //$("#onlineamount").html(onlineAmount);
            $("#lineamount").html(lineAmount);
            if (lineAmount*1 < 0) {
                $(type).val("0");
                self_fun(type,'线下支付不能为'+lineAmount,true);
                ///总运费
                var totalCost = $("#totalCost").html() * 1;
                ///线上支付总金额
                var onlineAmount = $("#onlineamount").val() * 1;
                //卓币支付金额
                var coinamount = $("#coinamount").val() * 1;

                ///线下支付总金额
                var lineAmount = totalCost - onlineAmount - coinamount;
                lineAmount = xround(lineAmount, 2);
                //$("#onlineamount").html(onlineAmount);
                $("#lineamount").html(lineAmount);
            }else{
            	self_fun(type,'',false);
            }

            var isprepay = $("input[name='isprepay']:checked").val();
            if (isprepay == 1) {
                //线上预支付比列
                var preratio = $("input[name='payinfo.preraio']:checked").val();
                //线上支付总运费
                var onlineAmount = $("input[name='payinfo.onlineamount']").val() * 1;
                ///预支付总金额
                var preAmount = xround(preratio * onlineAmount, 2);
                ///线下支付总金额
                var onlineBalance = onlineAmount - preAmount;
                $("#preamount").html(xround(preAmount, 2));
                $("#onlinebalance").html(xround(onlineBalance, 2));
            }
            var isprecoin = $("input[name='isprecoin']:checked").val();
            if (isprecoin == 1) {
                //线上预支付比列
                var coinprepaio = $("input[name='payinfo.coinprepaio']:checked").val();
                //线上支付总运费
                var coinamount = $("input[name='payinfo.coinamount']").val() * 1;
                ///预支付总金额
                var preAmount = xround(coinprepaio * coinamount, 2);
                ///线下支付总金额
                var coinactualpay = coinamount - preAmount;
                $("#coinpreamount").html(xround(preAmount, 2));
                $("#coinactualpay").html(xround(coinactualpay, 2));
            }
        }

        ///线上预支付比列
        $("input[name='payinfo.preraio']").click(function () {
            //线上预支付比列
            var preratio = $("input[name='payinfo.preraio']:checked").val();
            //线上支付总运费
            var onlineAmount = $("input[name='payinfo.onlineamount']").val() * 1;
            ///预支付总金额
            var preAmount = xround(preratio * onlineAmount, 2);
            ///线下支付总金额
            var onlineBalance = onlineAmount - preAmount;
            $("#preamount").html(xround(preAmount, 2));
            $("#onlinebalance").html(xround(onlineBalance, 2));
            self_fun("#pre",'',false,1);
        });

        ///卓币预支付比列
        $("input[name='payinfo.coinprepaio']").click(function () {
            //线上预支付比列
            var coinprepaio = $("input[name='payinfo.coinprepaio']:checked").val();
            //线上支付总运费
            var coinamount = $("input[name='payinfo.coinamount']").val() * 1;
            ///预支付总金额
            var preAmount = xround(coinprepaio * coinamount, 2);
            ///线下支付总金额
            var coinactualpay = coinamount - preAmount;
            $("#coinpreamount").html(xround(preAmount, 2));
            $("#coinactualpay").html(xround(coinactualpay, 2));
            self_fun("#coin",'',false,1);

        });

    });
</script>

<script>

    /* $(".loading_lock").hide(); */


    $.fn.serializeObject = function () {
        var o = {};
        var a = this.serializeArray();
        $.each(a, function () {
            if (o[this.name]) {
                if (!o[this.name].push) {
                    o[this.name] = [o[this.name]];
                }
                o[this.name].push(this.value || '');
            } else {
                o[this.name] = this.value || '';
            }
        });
        return o;
    };

    var app = angular.module('oPublishApp', ['ui.grid', 'ui.grid.selection', 'ui.grid.grouping', 'ui.grid.pagination', 'ui.grid.resizeColumns', 'ui.grid.autoResize']);
    app.controller('oPublishCtrl', ['$scope', 'i18nService', '$http', '$timeout', '$interval', 'uiGridConstants', 'uiGridGroupingConstants',
        function ($scope, i18nService, $http, $timeout, $interval, uiGridConstants, uiGridGroupingConstants) {
            $scope.actload = ${quoteinfo.oddloadweight};


            <c:if test="${quoteinfo.goods.gsoddtype==1 or bidinfo.isupbl==1}">

            // 国际化；
            i18nService.setCurrentLang("zh-cn");
            $scope.myData = [];
            $scope.gridOptions = {
                enableFiltering: true,
                data: 'myData'
            };
            $scope.freightvolume = 0;


            $scope.gridOptions.onRegisterApi = function (grid, newObjects) {
                $scope.bgrid = grid;
                //行选中事件
                $scope.bgrid.selection.on.rowSelectionChanged($scope, function (row, event) {
                    <c:if test="${quoteinfo.goods.datasource==0}">
                    if ($scope.bgrid.selection.getSelectedCount() == 0) {
                        $("#actload").removeAttr("readonly");
                    } else {
                        $("#actload").attr("readonly", "true");
                    }
                    </c:if>
                    if (row.isSelected) {
                        var num = accAdd($scope.freightvolume, Number(row.entity.quantity));
                        $scope.freightvolume = num;
                        /* $scope.actload = num; */
                        $("#actload").val(num);
                        //重新计算运费
                        $("#total").val(num * ('${quoteinfo.ooferprice}' * 1));
                        total = $("#total").val() * 1;
                        total = xround(total, 2);
                        $("#totalCost").html(total);
                    } else {
                        var num = accSub($scope.freightvolume, Number(row.entity.quantity));
                        $scope.freightvolume = num;
                        /* $scope.actload = num; */
                        $("#actload").val(num);
                        //重新计算运费
                        $("#total").val(num * ('${quoteinfo.ooferprice}' * 1));
                        total = $("#total").val() * 1;
                        total = xround(total, 2);
                        $("#totalCost").html(total);
                    }

                });
                $scope.bgrid.selection.on.rowSelectionChangedBatch($scope, function (row) {
                    if (!$scope.bgrid.selection.getSelectAllState()) {
                        row.forEach(function (r) {
                            var num = accAdd($scope.freightvolume, Number(r.entity.quantity));

                            $scope.freightvolume = num;
                            /* $scope.actload = num; */
                            $("#actload").val(num);
                            //重新计算运费
                            $("#total").val(num * ('${quoteinfo.ooferprice}' * 1));
                            total = $("#total").val() * 1;
                            total = xround(total, 2);
                            $("#totalCost").html(total);
                            <c:if test="${quoteinfo.goods.datasource==0}">
                            $("#actload").attr("readonly", "true");
                            </c:if>
                        });
                    } else {

                        $scope.freightvolume = 0;
                        $scope.actload = 0;
                        //重新计算运费
                        $("#total").val(0);
                        total = $("#total").val() * 1;
                        total = xround(total, 2);
                        $("#totalCost").html(total);
                        <c:if test="${quoteinfo.goods.datasource==0}">
                        $("#actload").removeAttr("readonly");
                        </c:if>
                    }
                });
            };

            $scope.gridOptions.rowIdentity = function (row) {
                return row.id;
            };

            $scope.gridOptions.getRowIdentity = function (row) {
                return row.id;
            };


            $scope.gridOptions.importerDataAddCallback = function (grid, newObjects) {
                if (newObjects) {
                    $scope.callsPending--;
                    newObjects.forEach(function (row) {
                        row.registered = new Date(row.registered);
                        $scope.myData.push(row);
                    });
                }
            };


            $scope.gridOptions.columnDefs = [
//                { name:'id',displayName:'提货单ID', width:200 },
                {name: 'contractno', displayName: '提货单号'},
                {name: 'batch', displayName: '批号'},
                {name: 'namematerials', displayName: '品名材质'},
                {name: 'standard', displayName: '规格'},
                {name: 'width', displayName: '定尺\\板宽'},
                {
                    name: 'quantity',
                    displayName: '数量\\吨'
                },
                {name: 'address', displayName: '卸货地址'},
                {name: 'remarks', displayName: '备注'}
            ];

            $scope.callsPending = 0;

            $scope.refreshData = function () {
            	$("#maskloading" , parent.document).show();
                $scope.myData = [];
                var datas = [];
                if ('${quoteinfo.goods.datasource}' * 1 == 0) {
                    datas = {
                        'searchinfo': '${user.id}',
                        'tradestatus': '0'
                    }
                } else {
                    datas = {
                        'goods.id': '${quoteinfo.goods.id}',
                        'tradestatus': '1'
                    }
                }
                var sec = $interval(function () {
                    $scope.callsPending++;
                    $http({
                        url: '${wlpt}/wlpt/bid/getblList',
                        method: 'post',
                        params: datas
                    }).success(function (data) {
                    	$("#maskloading" , parent.document).hide();
                        $scope.callsPending--;
                        data.value.forEach(function (row) {
                            row.registered = new Date(row.registered);
                            $scope.myData.push(row);
                        });
                       
                    });
                }, 200, 1);

                var timeout = $timeout(function () {
                    $interval.cancel(sec);
                    $scope.left = '';
                }, 2000);

                $scope.$on('$destroy', function () {
                    $timeout.cancel(timeout);
                    $interval.cancel(sec);
                });
            };
            $scope.refreshData();
            </c:if>

            $scope.submit = function () {
                var totalCost = $("#totalCost").html() * 1;
                var isreload = $("input[name='quoteinfo.isreload']:checked").val();
                //

                var residualvolume = '${quoteinfo.goods.residualvolume}' * 1;
                var actload = $("#actload").val() * 1;

                if (residualvolume < actload) {
                    self_fun("#actload",'不能大于剩余载重',true);
                    return false;
                } else if (actload * 1 <= 0) {
                    self_fun("#actload",'必须大于0',true);
                    return false;
                }else{
                	self_fun("#actload",'',false);
                }
               if ($("input[name='quoteinfo.isreload']:checked").val() == 1) {
                    <c:if test="${quoteinfo.goods.gsoddtype==1 or bidinfo.isupbl==1}">
                    if ('${quoteinfo.goods.datasource}' * 1 != 0) {
                        if ($scope.bgrid.selection.getSelectedRows().length <= 0) {
                            $.MsgBox.Alert("提示", "提货单条数不能小于1条");
                            return false;
                        }
                    }
                    </c:if>
                }
                if ($("input[name='isonlinepay']:checked").val() == 1) {
                	var onlineamountval= $("#onlineamount").val();
                	if(onlineamountval!="" && onlineamountval!=''&&onlineamountval!=undefined){
                		self_fun("#onlineamount",'',false);
                		if (!/^-?\d+(\.\d{1,2})?$/.test($("#onlineamount").val())) {
                        	self_fun("#onlineamount",'请填写正确的数字或小数且小数点后不能超过2位',true);
                        	return false;
                        } 
                	}else{
                		self_fun("#onlineamount",'不能为空',true);
                		return false;
                	}
                	
                    //卓币支付
                    if ($("input[name='ispaycoin']:checked").val() == 1) {
                    	var coinamountval = $("#coinamount").val();
                    	if(coinamountval!="" && coinamountval!=''&&coinamountval!=undefined){
                    		self_fun("#coinamount",'',false);
                    		if (!/^-?\d+(\.\d{1,2})?$/.test($("#coinamount").val())) {
                            	self_fun("#coinamount",'请填写正确的数字或小数且小数点后不能超过2位',true);
                            	return false;
                            } 
                    	}else{
                    		self_fun("#coinamount",'不能为空',true);
                    		return false;
                    	}
                    }else{
                    	self_fun("#coinamount",'',false);
                    }
                    if ($("#onlineamount").val() * 1 <= 0) {
                        self_fun("#onlineamount",'请填写正确的线上支付金额',true);
                        return false;
                    }else{
                    	self_fun("#onlineamount",'',false);
                    }
                }else{
                	self_fun("#coinamount",'',false);
                	self_fun("#onlineamount",'',false);
                	$("#coinamount").val("0");
                	$("#onlineamount").val("0");
                }
                
                var isonline = $("input[name='isonlinepay']:checked").val();
                if (isonline == 1) {
                	var pwd = $("#password").val();
                	if(pwd!="" && pwd!=''&&pwd!=undefined){
                		self_fun("#password",'',false);
                	}else{
                		self_fun("#password",'不能为空',true);
                		return false;
                	}
                }else{
                	self_fun("#password",'',false);
                }
                
                var totalmount = ($("#coinamount").val() * 1) + ($("#onlineamount").val() * 1)
                if (totalCost < totalmount){
                    $.MsgBox.Alert("提示", "线上支付运费必须大于0！");
                    return false;
                }

                var totalonline = "${not empty user.userPurse.availablebalance ? user.userPurse.availablebalance:'0.00'}";

                
                var isAccount = $("input[name='payway']:checked").val();
                if (isAccount == 0) {
                    //$("#precoin").slideDown("show");
                    totalonline="${not empty user.userPurse.availablebalance ? user.userPurse.availablebalance:'0.00'}";
                } else {
                		var memberId="${user.memberId}";
                	    $.ajax({
                	            url: "${wlpt}/wlpt/consume/virtAcctList",
                	            dataType: 'json',
                	            data:{"memberId":memberId,"status":'1'},
                	            type: "post",
                	            async : false, ///同步请求传递
                	            success: function (data) {
                	               if(data.status==200){
                	            	   var slaveAccounts=data.body.records[0].slaveAccounts;
                	            	   for(i=0;i<slaveAccounts.length;i++){
                	            		   if(slaveAccounts[i].accountType==4){
                	            			   totalonline=slaveAccounts[i].availableBalance;
                	            		   }
                	            	   }
                	            	   
                	               }
                	            }
                	    });
                   }
                
                <c:if test="${not empty quoteinfo.goods.isinsur and quoteinfo.goods.isinsur eq 1 and quoteinfo.goods.paypeople ne 1}">
                	totalonline=totalonline*1-40;
                </c:if>
                if ($("#onlineamount").val() * 1 > totalonline * 1) {
                    self_fun("#onlineamount",'可用余额不足',true);
                    return false;
                }else{
                	self_fun("#onlineamount",'',false);
                }

                if (($("input[name='isprepay']:checked").val()) == 1) {
                    var pre = $("input[name='payinfo.preraio']:checked").val();
                    if (pre == undefined) {
                        self_fun("#pre",'请选择预支付比例',true,1);
                        return false;
                    }else{
                    	self_fun("#pre",'',false,1);
                    }
                }else{
                	self_fun("#pre",'',false,1);
                }
                var isonline = $("input[name='ispaycoin']:checked").val();
                if (isonline == 1) {
                    if ($("#coinamount").val() * 1 <= 0) {
                        self_fun("#coinamount",'线上支付卓币必须大于0',true);
                        return false;
                    }else{
                    	self_fun("#coinamount",'',false);
                    }
                    var total = "${not empty user.userPurse.availablecoin ? user.userPurse.availablecoin:'0.00'}"
                    if ($("#coinamount").val() * 1 > total * 1) {
                        self_fun("#coinamount",'可用卓币不足',true);
                        return false;
                        
                    }else{
                    	self_fun("#coinamount",'',false);
                    }
                }else{
                	self_fun("#coinamount",'',false);
                }
                if (($("input[name='isprecoin']:checked").val()) == 1) {
                    var coin = $("input[name='payinfo.coinprepaio']:checked").val();
                    if (coin == undefined) {
                        self_fun("#coin",'请选择卓币预支付比例',true,1);
                        return false;
                    }else{
                    	self_fun("#coin",'',false,1);
                    }
                }else{
                	self_fun("#coin",'',false,1);
                }

                var istrue =true;
                var isonline = $("input[name='isonlinepay']:checked").val();
                if (isonline == 1) {
                	//同步验证--验证提现密码是否正确
        			$.ajax({
        				url : "${ctx}/wlpt/user/vadChildCashPwd",
        				type : "POST",
        				data : {"cashPwd":$("#password").val(),"isSave":false},
        				async : false, ///同步请求传递
        				success : function(data) {
        					istrue = data;
        					if(!data){
        						self_fun("#password",'支付密码错误或未设置!',true);
        					}else{
        						self_fun("#password",'',false);
        					}
        				}
        			}); 
                }else{
                	self_fun("#password",'',false);
                }
    			
    			if (!istrue) {
    				return false;
    			}
    			$("#maskloading" , parent.document).show();
                var inputForm = $("#inputForm").serializeObject();
                if ($("input[name='quoteinfo.isreload']:checked").val() == 1) {
                    <c:if test="${quoteinfo.goods.gsoddtype==1 or bidinfo.isupbl==1}">
                    inputForm.blinfoList = angular.toJson($scope.bgrid.selection.getSelectedRows());
                    </c:if>
                }
                $.ajax({
                    url: "${wlpt}/wlpt/trade/createOrder",
                    dataType: 'json',
                    method: 'post',
                    data: inputForm,
                    cache: false,
                    success: function (data) {
                    	$("#maskloading" , parent.document).hide();
                        if (data.value == 1) {
                        	top.$("#rightFrame").parent().prev().children("#accordion").children().eq(3).children(".submenu").css("display","none").children().removeClass("menuSelect");
                        	top.$("#rightFrame").parent().prev().children("#accordion").children().removeClass("open").eq(2).addClass("open").children(".submenu").css("display","block").children().addClass("menuSelect");
                            top.$("#rightFrame").prev().children(".top_left").children("#tabmu").html("/运单中心/我的运单");
                            var searchinfo = $("#carnumber").val();
                            if(searchinfo==undefined){ 
                            	searchinfo = "";
                            }
                            window.location.href = '${wlpt}/wlpt/trade/trade_list?searchinfo=' + searchinfo;              
                        } else if (data.value == 5) {
                            $.MsgBox.Alert("提示", "账户余额或卓币不足！");
                        } else if (data.value == 19) {
                            $.MsgBox.Alert("提示", "应用正在日结中，等银行结算完毕再开放使用，结算时间为1-2小时");
                        } else if (data.value == 3) {
                            $.MsgBox.Alert("提示", "该报价已过期！");
                        } else {
                            $.MsgBox.Alert("提示", "信息缺失！！");
                            
                        }
                    }
                });
            };

        }]);

</script>


<script>


    //加法函数，用来得到精确的加法结果
    //说明：javascript的加法结果会有误差，在两个浮点数相加的时候会比较明显。这个函数返回较为精确的加法结果。
    //调用：accAdd(arg1,arg2)
    //返回值：arg1加上arg2的精确结果
    function accAdd(arg1, arg2) {
        var r1, r2, m, n;
        try {
            r1 = arg1.toString().split(".")[1].length
        } catch (e) {
            r1 = 0
        }
        try {
            r2 = arg2.toString().split(".")[1].length
        } catch (e) {
            r2 = 0
        }
        m = Math.pow(10, Math.max(r1, r2));
        n = (r1 >= r2) ? r1 : r2;
        return ((arg1 * m + arg2 * m) / m).toFixed(n);
    }


    function accSub(arg1, arg2) {
        var r1, r2, m, n;
        try {
            r1 = arg1.toString().split(".")[1].length
        } catch (e) {
            r1 = 0
        }
        try {
            r2 = arg2.toString().split(".")[1].length
        } catch (e) {
            r2 = 0
        }
        m = Math.pow(10, Math.max(r1, r2));
//last modify by deeka
//动态控制精度长度
        n = (r1 >= r2) ? r1 : r2;
        return ((arg1 * m - arg2 * m) / m).toFixed(n);
    }

    function self_fun(id,msg,status,type){
		//input 绑定监听
			if(type==1){
				var length=$(id).children('span').length;
				if(status==true){
					$(id).children('span').remove();
					var error_span='<span style="color:#a94442;font-size:12px;display:inline-block;margin-top:10px;">'+msg+'</span>';
					var icon_remove='';
					
					if(length==0){
						$(id).append(icon_remove);
						$(id).append(error_span);
					}
					//删除ie自带删除图标
					$(id).addClass('error');
				}
				else if(status==false){
					$(id).children('span').remove();
					//删除ie自带删除图标
					$(id).addClass('error');
					
				}
			}else{
				var length=$(id).parent().find('span').length;
				if(status==true){
					$(id).next().find('span').remove();
					var error_span='<span style="color:#a94442;font-size:12px;display:inline-block;margin-top:10px;">'+msg+'</span>';
					var icon_remove='';
					
					if(length==0){
						$(id).parent().append(icon_remove);
						$(id).parent().append(error_span);
					}
					$(id).css('border-color','#e94c3c').css('box-shadow','0 0 10px rgba(233,76,60,.3)').css('-webkit-box-shadow','0 0 10px rgba(233,76,60,.3)').css('-moz-box-shadow','0 0 10px rgba(233,76,60,.3)').css('-o-box-shadow','0 0 10px rgba(233,76,60,.3)');
					//删除ie自带删除图标
					$(id).addClass('error');
				}
				else if(status==false){
					$(id).parent().find('span').remove();
					//删除ie自带删除图标
					$(id).addClass('error');
					if(length==0){
						var icon_ok='';
						$(id).parent().append(icon_ok);
					}
				}
			}
	}
    var bheight = document.documentElement.clientHeight;
	var bwidth = document.documentElement.clientWidth;
  	//弹框
    $('#modal').css('width','100%');
    $(".modal-dialog").css('width','80%');
    $(".modal-content").css('width','100%');
</script>

</body>
</html>