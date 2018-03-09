<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<meta charset="utf-8" />
<title></title>
<meta name="description" content="overview & stats" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link href="static/css/bootstrap.min.css" rel="stylesheet" />
<link href="static/css/bootstrap-responsive.min.css" rel="stylesheet" />
<link rel="stylesheet" href="static/modules/sys/css/font-awesome.min.css" />
<!-- 下拉框 -->
<link rel="stylesheet" href="static/modules/sys/css/chosen.css" />

<link rel="stylesheet" href="static/modules/sys/css/ace.min.css" />
<link rel="stylesheet" href="static/modules/sys/css/ace-responsive.min.css" />
<link rel="stylesheet" href="static/modules/sys/css/ace-skins.min.css" />

<link rel="stylesheet" href="static/modules/sys/css/datepicker.css" />
<!-- 日期框 -->
<script type="text/javascript" src="static/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="static/modules/sys/js/jquery.tips.js"></script>
<style type="text/css">
@media screen {
	.printhide {
		display: block
	}
}

@media print {
	.printhide {
		display: none
	}
	.btns{
	    display: none
	}
}
.div_box {
	width: 100%;
	padding-top: 60px;
	clear:both;
}

.print_title,.data_div {
	width: 95%;
	margin: 0 auto;
	font-family: "微软雅黑";
}

.print_title {
	text-align: center;
	width: 100%;
	height: 110px;
	line-height: 50px;
}

.data_div {
	font-size: 20px;
	marign-top: 20px;
}

.data_cent {
	width: 100%;
}

.data_cent div {
	float: left;
	margin-right: 10px;
	height: 24px;
	line-height: 20px;
}

.data_val {
	width: 260px;
	border-bottom: 1px solid #000;
}

table {
	width: 100%;
	margin-top: 32px;
	margin-bottom: 20px;
	border: 1px solid #000;
}

thead tr td {
	font-size: 20px;
	font-weight: bold;
	height: 40px;
	line-height: 40px;
	text-align:center;
}

table tr td {
	text-align: center;
	border-left: 1px solid #000;
	border-bottom: 1px solid #000;
	height: 40px;
	line-height: 40px;
}

.data_right_botom {
	float: right;
	width: 35%;
	text-align: left;
	margin-top: 35px;
}

.data_right_botom div {
	height: 50px;
	line-height: 30px;
}

.txt-indent {
	text-indent: 32px;
	line-height:35px;
}

.txt_title {
    font-weight: bold;
    font-size: 18px;
    line-height: 50px;
}
</style>
</head>
<body>
	<div class="div_box print">
		<div class="print_title">
			<h1>公证单</h1>
		</div>
		<div class="data_div" style="height:30px;">
			<div class="data_cent">
				<div>运单编号:</div>
				<div class="data_val" id="orderNo">${result.orderno }</div>
			</div>
		</div>
		<!-- data_div end -->
		<div class="data_div" style="height:480px;">
			<table>
				<thead>
					<tr>
						<td style="width:20%">货物名称</td>
						<td style="width:20%">载重(吨/方)</td>
						<td style="width:40%">线路</td>
						<td style="width:20%">时间要求</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>${result.quoteinfo.goods.goodsname}</td>
						<td>${result.quoteinfo.oddloadweight }</td>
						<td></td>
						<td><fmt:formatDate value="${result.updateDate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					</tr>
					<tr>
						<td>运费总计(元)</td>
						<td colspan="3" style="text-align:left;">${result.totalcost }</td>
					</tr>
				</tbody>
			</table>
			<!-- table1 -->
			<table style="margin-top:50px;">
				<thead>
					<tr>
						<td colspan="2">托运方</td>
						<td colspan="2">承运方</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width:25%">名称</td>
						<td style="width:25%">${result.buyer.company }</td>
						<td style="width:25%">姓名</td>
						<td style="width:25%">${result.buyer.name!=null?result.buyer.name:result.buyer.company }</td>
					</tr>
					<tr>
						<td>联系人</td>
						<td>${result.seller.company!=null?result.seller.company:result.seller.name }</td>
						<td>车牌号</td>
						<td>${result.quoteinfo.car.carnumber }</td>
					</tr>
					<tr>
						<td>联系电话</td>
						<td>${result.buyer.phone }</td>
						<td>联系电话</td>
						<td>${result.seller.phone }</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- data_div end -->
		<div class="data_div" style="height:30px;">
			<div class="data_cent">
				<div style="width:40%;float:left;">
					<div style="float:left;">打印人签名:</div>
					<div class="data_val" style="width:100px;float:left;"></div>
				</div>
				<div style="width:40%;float:left;">
					<div style="float:left;">平台经办人:</div>
					<div class="data_val" style="width:100px;float:left;"></div>
				</div>

			</div>
		</div>
		<!-- data_div end -->
		<div class="data_div"
			style="height: 46px;line-height: 45px;">
			地址：309国道巨恒物流园一楼101</div>
		<!-- data_div end -->
		<div class="data_div"
			style="height: 46px;line-height: 45px;">
			联系电话：0310-3188756</div>
		<!-- data_div end -->
		<div class="data_div data_right_botom">
			<div>公证单位：（盖章）</div>
			<div id="nowTime">时 间：2015年11月24日 12:00</div>
		</div>
	</div>
	<!-- div_box end  -->
	<div class="div_box print" style="margin-top:40px;">
		<div class="print_title">
			<h1>卓大平台公证制度</h1>
		</div>
		<div class="data_div txt-indent">
			公证单是卓大物流平台作为中间担保方，为物流企业与司机之间的交易提供担保的一种交易担保制度。参与公证制度的双方需在平台进行交易，对于不在平台的交易业务，卓大平台不做公证担保。
		</div>
		<!-- data_div end txt_title-->
		<div class="data_div txt_title">1.服务对象以及要求</div>
		<!-- data_div end-->
		<div class="data_div txt-indent">1）物流企业：须为平台VIP认证会员，缴纳相应的平台押金</div>
		<div class="data_div txt-indent">2）司机：须为平台VIP认证会员，缴纳相应的平台押金</div>
		<!-- data_div end-->
		<div class="data_div txt_title">2.对物流企业的保障内容</div>
		<!-- data_div end-->
		<div class="data_div txt-indent">1）对通过平台交易的车辆，平台保证证件齐全，安全可信</div>
		<div class="data_div txt-indent">
			2）当司机毁约或不能及时运输相关的货物而导致物流企业承受损失时，平台通过扣除押金、撤销VIP会员等方式对对方进行处罚并为物流企业追索赔偿。
		</div>
		<!-- data_div end-->
		<div class="data_div txt_title">3.对司机的保障内容</div>
		<!-- data_div end-->
		<div class="data_div txt-indent">1）对通过平台获取的货源，平台保证货源真实，物流企业证件齐全
		</div>
		<div class="data_div txt-indent">
			2）当出现以下情况时：A、实际货物信息与平台发布信息不一致，导致自身利益受到损害
			B、物流企业运费未能按时支付，平台将对物流企业进行处罚，并为司机追索相应赔偿。</div>
		<!-- data_div end-->
		<div class="data_div txt_title">4.首赔原则</div>
		<!-- data_div end-->
		<div class="data_div txt-indent">
			平台作为担保方，当物流企业或司机任何一方的利益受到损害时，平台将按损失第一时间按照比例先行赔付，再核实相关情况后为对方挽回损失。</div>
		<!-- data_div end-->
		<div class="data_div txt_title">5.服务费用</div>
		<!-- data_div end-->
		<div class="data_div txt-indent">
			平台为交易双方提供公证担保，不断完善物流交易市场，提高物流诚信指数。同时，平台收取物流企业的服务费用50元/单。</div>
		<!-- data_div end-->
		<div class="data_div txt_title">6.提货单管理</div>
		<!-- data_div end-->
		<div class="data_div txt-indent">
			由巨恒物流园309库发的货，提货单由巨恒物流园进行派发；万红库发的货源信息，提货单由万红库进行管理。物流企业须打印了公证单后，才能领取提货单。
		</div>
		<!-- data_div end-->
	</div>
	<li class="btns" style="width:200px;margin:0px auto;list-style-type:none;"><input id="print"
				class="btn btn-primary" style="border-radius:25% !important;" type="button" value="打印" /><a
				 class="btn btn-primary" style="margin-left:30px;border-radius:25% !important;text-decoration: none;" href="${ctx}/wlpt/user/userTradeOrder/list">返回</a></li>

<script type="text/javascript">
$(function(){
	$("#print").click(function() {
		window.print();
		printOrder();
	});
	function printOrder(){
		$.ajax({
			url: "${ctx}/wlpt/user/userTradeOrder/printEdit",
			data:{ORDERNO:$("#orderNo").html()},
			type:'post',
			dataType:'json',
			cache : false,
			success:function(data){	
				       location.href="${ctx}/wlpt/user/userTradeOrder/list";
					
			}
		});
	}
	function nowtime(){
   var mydate = new Date();
   var str = "" + mydate.getFullYear() + "年";
   str += (mydate.getMonth()+1) + "月";
   str += mydate.getDate() + "日";
   str +=mydate.getHours()+":"+mydate.getMinutes();
   return str;
	}
	$("#nowTime").html(nowtime);
	
});
</script>
</body>
</html>