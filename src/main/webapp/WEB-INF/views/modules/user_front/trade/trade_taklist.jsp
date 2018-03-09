<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<%@ page import="java.io.*" %> 
<%@ page import="com.thinkgem.jeesite.common.config.Global" %>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<%--
    <meta name="decorator" content="site_personal_basic"/>
--%>

    <title>运输回执单</title>
<link href="/static/front/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
<link href="${ctxStatic}/front/css/per_global.css" type="text/css" rel="stylesheet"/>
    <style type="text/css">
        em {
            font-style: normal;
            font-weight: 700;
            font-family: sans-serif;
        }

        .sub-reListOrder {
            width: 100%;
            margin: 0 auto;
            text-align: center;
        }

        h2 {
            font-size: 18px;
        }

        #timeline .timeline-item .timeline-content h2 {
            padding: 10px;
        }

        .sub-reListOrder table {
            width: 100%;
            border: 1px solid #000;
            font-size: 12px;
            margin: 20px auto;
        }

        .sub-reListOrder table td {
            width: 9%;
            border: 1px solid #000;
            text-align: center;
            height: 20px;
            color: #000;
            font-size: 18px;
        }

        .sub-reListOrder table td div {
            color: #000;
            font-size: 14px;
        }

        @media screen {
            .printhide {
                display: block;
                font-size: 20px;
            }
        }

        @media print {
            .printhide {
                display: none;
            }

            #btn-warning {
                display: none;
            }
            #listPrint{
                width: 85%;
                margin: 0px;
                margin-top: 10px;
                font-size: 18px;
            }
        }

        .datainit {
            display: none;
        }
    </style>
    <style media="print">
		.container{padding:0;margin:0 auto;width:100%;margin:0;}
		.sub-reListOrder table td{height:22px;line-height:22px;}
		#QRCodeimg{padding:3px;}
	</style>
</head>
<body scroll="no" style=" width: 90%;margin: 0 auto;">
<div class="container" style="text-align: center" ng-app="dataHall" ng-controller="dataHallCtrl"   >

    <div id="listPrint" class="sub-reListOrder" >
        <table id="printtable" class="print" style="font-size:16px;margin-bottom:20px;"
               cellpadding="0" cellspacing="0">
            <tr>
                <td colspan="8"
                    style="font-size:20px;height:50px;font-weight: bold;"><h1
                        style="font-size:24px;font-weight:bold;">河北邯郸巨恒物流公司运输回执单(卓大物流)</h1></td>
            </tr>
            <tr>
                <td colspan="1">发布方:</td>
                <td colspan="3">${orderinfo.seller.loginName}</td>
                <td colspan="1">承运方:</td>
                <td colspan="3">${orderinfo.buyer.loginName}</td>
            </tr>
            <tr>
                <td colspan="3">订单号:${orderinfo.orderno }</td>
                <td colspan="2">司机:${orderinfo.quoteinfo.driver.loginName}</td>
                <td colspan="3">司机电话:${orderinfo.quoteinfo.driver.phone }</td>
            </tr>
            <tr>
                <td colspan="2">货运车号:${orderinfo.quoteinfo.car.carnumber}</td>
                <td colspan="2">货物名称:${orderinfo.quoteinfo.goods.goodsname}</td>
                <td colspan="4">发车日期:${orderinfo.quoteinfo.goods.ymdDate }</td>
            </tr>
            <tr id="table_head">
                <td>合同号</td>
                <td>批号</td>
                <td>材质</td>
                <td>规格</td>
                <td>宽度</td>
                <td>重量</td>
                <td style="width:100px;">卸货地址</td>
                <td>备注</td>
            </tr>
            <div class="datainit">
                <tr ng-repeat="x in data">
                    <td>{{x.contractno}}</td>
                    <td>{{x.batch}}</td>
                    <td>{{x.namematerials}}</td>
                    <td>{{x.standard}}</td>
                    <td>{{x.width}}</td>
                    <td>{{x.quantity}}</td>
                    <td style="width:100px;">{{x.address}}</td>
                    <td>{{x.remarks}}</td>
                </tr>
            </div>
            <tr>
                <td colspan="8"></td>
            </tr>
            <tr>
                <td colspan="8"></td>
            </tr>
            <tr>
                <td>合计</td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>

                <td><c:if test="${orderinfo.quoteinfo.isreload!=1 }">
                    ${orderinfo.quoteinfo.oddloadweight}${orderinfo.quoteinfo.goods.freightunit}
                </c:if>
                    <c:if test="${orderinfo.quoteinfo.isreload==1 }">
                        ${orderinfo.quoteinfo.actload}${orderinfo.quoteinfo.goods.freightunit}
                    </c:if>
                </td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td colspan="8"></td>
            </tr>
            <tr>
                <td colspan="7" style="text-align:left;">
                    送货地址:${orderinfo.quoteinfo.goods.consignAddress.province}
                    ${orderinfo.quoteinfo.goods.consignAddress.city}
                    ${orderinfo.quoteinfo.goods.consignAddress.district}
                    ${orderinfo.quoteinfo.goods.consignAddress.address}
                </td>
                <td rowspan="4" id="QRCodeimg">
                    <img class="hovspan" 
                         alt="" onerror="this.onerror=null;this.src='/static/images/wlptfront/QRCode_logo.png'"
                         style="width:110px"
                         src="/static/images/wlptfront/QRCode_logo.png">
					<img class="hovspan2" style="width:110px;display: none;" src="/userfiles/code/${orderinfo.orderno}.jpg">
                </td>
            </tr>
            <tr>
                <td colspan="7" style="text-align:left;">
                    <div
                            style="float:left;margin-right:20px;">
                        联系人:${orderinfo.quoteinfo.goods.consignAddress.linkman }</div>
                    <div style="float:left;">电话:${orderinfo.quoteinfo.goods.consignAddress.linkmobile }</div>
                </td>
            </tr>
            <tr>
                <td colspan="7" style="text-align:left;">
                    <div
                            style="float:left;width:50%;">质保书、票据按客户要求由我处邮寄或自取
                    </div>
                    <div style="width:30%;float:right;text-align:left;">随货通行签字(盖章)</div>
                </td>
            </tr>
            <tr>
                <td colspan="7" style="text-align:left">收货日期:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
            </tr>
        </table>
        

    </div>
	<div id="printdiv" style="text-align: left;"><span id="printcount"></span></div>
    <c:if test="${ orderinfo.isBuyer eq false and orderinfo.orderstatus ne 0 and orderinfo.orderstatus ne 2}">
    
    	<div class="printhide" id="printtype">打印方式:&nbsp;<input type="radio" name="printtype"
					 style="margin-left: 5px" value="0"  checked="checked"/>一页一单 <input type="radio"
						name="printtype" style="margin-left: 5px" value="1" />一页两单</div>
		<div class="printhide col-sm-12">
			<div class="col-sm-4"></div>
			<div class="col-sm-4">
           		<span  class="btn btn-primary col-sm-12 printhide" id="btn-warning">打印</span>
           	</div>
			
		</div>
        

        
    </c:if>
    <c:if test="${ orderinfo.isBuyer eq true and orderinfo.orderstatus ne 0 and orderinfo.orderstatus ne 2}">
    	<c:if test="${ ((orderinfo.payinfo.onlineamount+orderinfo.payinfo.coinamount)*1 > fns:getDictValue('限额', 'printPay','2000') * 1) or orderinfo.isprint eq 1}">
    	<div class="printhide" id="printtype">打印方式:&nbsp;<input type="radio" name="printtype"
					 style="margin-left: 5px" value="0"  checked="checked"/>一页一单 <input type="radio"
						name="printtype" style="margin-left: 5px" value="1" />一页两单</div>
        <div class="btn btn-defalut btn-warning printhide" id="btn-warning"
             style="margin:0 auto;width: 130px;">打印

        </div>
        </c:if>
    </c:if>
</div>

<script type="text/javascript" src="/static/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="jquery.PrintArea.js"></script> 
<script src="/static/flash/zoom.min.js" type="text/javascript"></script>
<script src="/static/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script src="/static/modules/wlpt/front/js/angular/angular.min.js"></script>

<script>
    var isReturn = false;
    var printcount = "${orderinfo.printcount}";//打印次数
    var goods_id = "${orderinfo.quoteinfo.goods.id}";
    var goods_type = "${orderinfo.quoteinfo.goods.gsoddtype}";///货物类型
    var isOnline = "${orderinfo.isonlinepay}";
    var isreload = "${orderinfo.quoteinfo.isreload}";////是否重新配载
    var onlinePay = "${not empty orderinfo.payinfo.onlineamount? orderinfo.payinfo.onlineamount : '0.00'}";
    var coinamount = "${not empty orderinfo.payinfo.coinamount? orderinfo.payinfo.coinamount : '0.00'}";
    ////基础价格
    var baseMoney = "${fns:getDictValue('限额', 'printPay','2000')}";///限额
    var payMoney = "${fns:getDictValue('打单交费', 'printPay','20')}";
    var isgtype_1="${fns:getDictValue('原材料扣费', 'printpay_gtype_1','0')}";
    var order_id = "${orderinfo.id}"; ///运单ID
    var isprint = "${orderinfo.isprint}";///是否打印
    var blData = {'goods.id': goods_id};///提货单查询条件
    var blhref = "getblList";
    ///重新配载查询
    if (isreload == 1) {
        blData = {'quote.id': '${orderinfo.quoteinfo.id}'};
        blhref = "getblListByQuote";
    }
    var app = angular.module("dataHall", []);
    ///控制方法
    app.controller('dataHallCtrl', function ($scope, $http) {
        //get first page
        $http({
            url: '${wlpt}/wlpt/bid/' + blhref,
            method: 'post',
            params: blData
        }).success(function (response) {
            $scope.data = response.value;
            $(".datainit").show();
            isReturn = true;
        });

    });
    $("#btn-yulan").click(function () {
    	document.all.WebBrowser.ExecWB(7,1);
    });
    $("#btn-warning").click(function () {
        var hg = $("#printtable").height();
        var printtype = $("input[name='printtype']:checked").val();
        if (printtype*1 == 1) {
        	if (hg < 800) {
        		
                $("#listPrint").append($("#listPrint").html());
                
            }else{
            	 $.MsgBox.Alert("打印提示", "当前回执单过长，无法实现一页两单的打印模式");
            	 return false;
            }
        }
        
        /* if (hg < 700) {
            $("#listPrint").append($("#listPrint").html());
        } */
        if (isprint * 1 == 1  ||(goods_type * 1==2 && isgtype_1 * 1 == 1)) {
        	//$("#QRCodeimg").html('<img class="hovspan" style="width:110px" src="/userfiles/code/${orderinfo.orderno}.jpg">');
        	$(".hovspan2").show();
        	$(".hovspan").hide();
        	updatePrintcount();
        	var count = printcount*1+1;
        	$("#printcount").html("第"+count+"次");
            window.print();
        } else {
            ///如果是线上支付，资金不足1000元则扣费，或者如果是线下支付并且货物不是原材料的则扣费
            var totalmoney = (onlinePay * 1) + (coinamount * 1);
            if ((totalmoney*1 < baseMoney * 1 || isOnline != 1) && isprint * 1 == 0) {
                $("#btn-warning").hide();
                
                //   alert("true");
                $.MsgBox.Confirm("打印提示", "本次交易将收取" + payMoney + "元服务费用,是否继续操作?", function () {
                    $.ajax({
                        url: "${wlpt}/wlpt/trade/printOrder",
                        data: {id: order_id},
                        type: 'post',
                        dataType: 'json',
                        cache: false,
                        success: function (data) {
                            if (data.state == 1) {
                            	$(".hovspan2").show();
                            	$(".hovspan").hide();
                            	updatePrintcount();
                            	var count = printcount*1+1;
                            	$("#printcount").html("第"+count+"次");
                                window.print();
                            } else {
                            	$("#btn-warning").show();
                            	$(".hovspan2").hide();
                            	$(".hovspan").show();
                                $.MsgBox.Alert("打印提示", data.message);
                            }

                        }
                    });
                }, function () {
                    $(".loading_lock").show();
                    $("#btn-warning").show();
                });
            }
            else {
            	$(".hovspan2").show();
            	$(".hovspan").hide();
            	updatePrintcount();
            	var count = printcount*1+1;
            	$("#printcount").html("第"+count+"次");
                window.print();
            }
        }
        
        if ($("#listPrint .print").length > 1) {
            $("#listPrint .print:last").remove();
        }
        if ($("#printdiv #printcount").length > 1) {
			$("#printdiv #printcount:last").remove();
		}
    });
    
    function updatePrintcount(){
    	$.ajax({
            url: "${wlpt}/wlpt/trade/updatePrintcount",
            data: {id: order_id},
            type: 'post',
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data == 1) {
                	printcount=printcount*1+1;
                }

            }
        });
    }
    function loads(height) {


        var myFrameheight = height + 20;
        top.$("#myFrame").height(0); //清空父级iframe高度
        $("#myFrame", parent.document).height(myFrameheight < 500 ? 500 : myFrameheight);//重新设置父级iframe高度
        $(".container").height(myFrameheight < 500 ? 500 : myFrameheight);//重新设置container高度
        //
        top.top.$("#rightFrame").height(0); //用于每次刷新时控制IFRAME高度初始化
        var heights = height + 210;
        top.top.$("#rightFrame").height(heights < 500 ? 500 : heights);//重新设置父级的父级iframe高度

    }
    $(function () {
        var t = setInterval(function () {

            if (isReturn == true) {
                //重置页面高度
                loads($(".container").height());
                clearInterval(t);
            }
        }, 500)
    })

</script>
</body>
</html>
