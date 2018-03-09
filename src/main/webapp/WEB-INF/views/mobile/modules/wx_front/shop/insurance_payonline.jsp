<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<title>保单支付</title>
	<meta charset="utf-8">
	<meta name="viewport"
          content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/ionic.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/ionicons.min.css">
    
    <style type="text/css">
    body{
    	background-color: #dddddd;
    	
    }
    input[type=radio]{
	    width: 20px;
	    height: 20px;
	    -webkit-appearance: radio;
	}
	#btnSubmit {
	    font-size: 16px;
	    height: 43px;
	    line-height: 43px;
	}

	*{box-sizing:border-box;margin:0;padding:0;font-family:"Microsoft YaHei",Times New Roman,Georgia,Serif;font-size: 14px;}
	ul,ol{list-style: none;}
	a,a:hover,a:active,a:focus{text-decoration: none;}

	*{box-sizing:border-box;}
	.ticket i{font-style: normal;font-size:1em;}
	.text_center{text-align:center}
	.ticket{width:100%;margin-top:10px;}
	.ticket li{position:relative;width:75%;margin:0 auto;margin-bottom:20px;height:6em;background:url(${ctxStatic}/front/img/bg_quan3.png) no-repeat;background-size:100% 100%;}
	.ticket li.over{background:url(${ctxStatic}/front/img/quan_over.png) no-repeat;background-size:100% 100%;}
	.ticket li.over span,.ticket li.over h2,.ticket li.over p,.ticket li.over b{color:#f0f0f0;}
	.ticket li.over span{border-color:#f0f0f0;}
	.ticket li span,.ticket li h2,.ticket li p,.ticket li b,.ticket h3{color:#fff;letter-spacing: 2px;}
	.ticket li b{font-size:2em;}
	.quan_text{margin-top:1.5em}
	.ticket li h2{margin-top:0em;padding-left:0.8em;letter-spacing: 0px;}
	.ticket h3{font-size:1em;font-weight:200; margin-bottom: 5px;}
	.ticket li p{font-size:1em;}
	.ticket li span{position:absolute;top:7px;left:11px;display:none;width:24px;height:24px;line-height:24px;font-size:1.1em;text-align:center;border-radius:100%;border:1px solid #fff;}
	.ticket .h3_m{}
	.have{width:24px;height:20px;position:absolute;top:5px;right:6px;;display: none;}
	.lt{float:left;}
    </style>
</head>
<body>
<!-- 	<div class="bar bar-header bar-dark">
	<a href="javasrcipt:" class="button button-clear icon ion-android-arrow-back"></a>
	<h1 class="title">在线支付</h1>
</div> -->
	
	<form action="insurance_form_submit" method="post" accept-charset="utf-8">
			<div  class="list">
<!-- 				<div class="item item-button-right">
    支付方式：&nbsp;
    <span>余额支付</span>
    <a class="button icon-right  ion-chevron-right button-clear button-dark"></a>				      	
</div> -->
				<div class="item item-input">
				  	<span class="input-label">支付金额:</span>
				  	<sapn style="color:red">¥</sapn>
					
				 	<input type="text" class="" value="${not empty shop.total?shop.total:'0.00'}" disabled="disabled" style="background-color:white;color:red"> 

				</div>
				<div class="item item-input"  id="aw_way" style="display: none;">
					<span class="input-label">实付金额:</span>
					<sapn style="color:red">¥</sapn>
					<span style="color:red" id="sfmoney"></span>

				</div>
				<div class="item item-input">
				  	<span class="input-label">账户可用余额:</span>
				  	<sapn style="color:red">¥</sapn>
					
				 	<span style="color:red" id="available">${not empty user.userPurse.availablebalance?user.userPurse.availablebalance:'0.00'}</span>

				</div>
				
				<div class="item item-input">
				  	<span class="input-label">支付方式:</span>
				  		 <span class="radio" >
				   	<input type="radio" class="paytyperadio" checked="checked"
					    name="payway" value="0"/></span><span>账户余额</span>&nbsp;&nbsp;
					    
					    <%-- <c:if test="${user.memberId!=null&&user.memberId!=''}">
						<label class="radio" ><input type="radio" class="paytyperadio" 
						name="payway" value="10"/></label><span>银行卡账户</span></c:if> --%>
						
					<label class="radio" ><input type="radio" class="paytyperadio" 
					    name="payway" value="1"/></label><span>线下支付</span>
					<span></span>
				</div> 
				
				
				<div class="item item-input">
				  	<span class="input-label ">支付密码:</span>
				  	 <input  id="password"  type="password" placeholder="请输入你的支付密码"> 					
				</div>
			</div>
		<div class="bar bar-footer bar-calm">
			<h1 class="title">
				<button type="button" id="btnSubmit" class="itme item-button-center button button-calm">确定支付</button>
			</h1>
		</div>

		<c:if test="${not empty awlist }">
			<div class="ticket">
				<ul>
					<c:forEach  var="item" items="${awlist}" varStatus="status">
						<li onclick="clickaw('${status.index}','${not empty item.wxgift.giftworth ? item.wxgift.giftworth : "0"}','${item.awardno}')" id="aw${status.index}">
							<img src="${ctxStatic}/front/img/have.png" alt="" class="have"/>
							<span class="text_center quan">券</span>
							<h2 class="text_center h3_m lt"><i>￥</i><b><fmt:formatNumber type="number" value="${item.wxgift.giftworth }" pattern="0" maxFractionDigits="2"/></b></h2>
							<div class="lt quan_text">
								<h3>优惠券</h3>
								<p class="text_center">${fns:getDictLabel(item.wxgift.gifttype,'gifttype','')}</p>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>
		</c:if>
	</form>

<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/config.js"></script>
<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery.valid.js"></script>
<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery.tips.js"></script>
<script>
//$(".loading").hide();
var type="${shop.shotName}";
var awardno ="";
var worth=0;
var amount=0.00;
var avail="${not empty user.userPurse.availablebalance ? user.userPurse.availablebalance:'0.00'}";
var memberId="${user.memberId}"
if(memberId!=null&&memberId!=""){
    $.ajax({
            url: "${wlpt}/wlpt/consume/virtAcctList",
            dataType: 'json',
            data:{"memberId":memberId,"status":'1'},
            type: "post",
            success: function (data) {
               if(data.status==200){
            	   var slaveAccounts=data.body.records[0].slaveAccounts;
            	   for(i=0;i<slaveAccounts.length;i++){
            		   if(slaveAccounts[i].accountType==4){
            			   amount=slaveAccounts[i].availableBalance;
            		   }
            	   }
            	   
               }
            }
    });
}
$("input[name='payway']").click(function () {
	var paytype=$("input[name=payway]:checked").val();
	if(paytype*1==0){
		$("#available").html(avail);
	}
	if(paytype*1==10){
		$("#available").html(amount);
	}
});
function clickaw(li_id,giftworth,no) {
    $("#aw"+li_id).siblings().find('img').hide();
    $("#aw"+li_id).find('img').show();
    $("#aw_way").show();
    awardno=no;
    worth = giftworth*1;
    var total="${shop.total}";
    var money=total*1-worth;
    if(money<0){
        money=0;
    }
    $("#sfmoney").html(money+"元");
}
$("#btnSubmit").click(function () {
	var total="${shop.total}";
	var money=total*1;
	var shotName="${shop.shotName}";
	var paytype=$("input[name=payway]:checked").val();
	var available=$("#available").html();
	var insurid="${userInsurance.id}"
	if(money<0){
		$("#btnSubmit").tips({
            side: 3,
            msg: '消费金额不能小于0',
            bg: '#00A2E9',
            time: 4
        });
		return false;
	}
	if(paytype*1!=1){
		if(available*1<(money-worth)){
			$("#btnSubmit").tips({
	            side: 3,
	            msg: '账户余额不足',
	            bg: '#00A2E9',
	            time: 4
	        });
			return false;
		}
	}
	
	var pass=$("#password").val();
	if(pass==null||pass==""){
		$("#password").tips({
            side: 3,
            msg: '请输入支付密码',
            bg: '#00A2E9',
            time: 4
        });
		return false;
	}
	/* if ($(".loading").is(':hidden')) {
        $(".loading").show();
    } else {
        return false;
    } */
	if(pass!=null||pass!=""){
		$.MsgBox.Confirm("温馨提示", "确定支付保单？", function() {
		$.ajax({
            url: "${ctx}/wlpt/user/validateCashPwd",
            dataType: 'json',
            data:{"cashPwd":$("#password").val(),"isSave":false},
            type: "post",
            success: function (data) {
                if (data == false) {
                	$(".loading").hide();
                	$("#password").tips({
                        side: 3,
                        msg: '请输入正确支付密码',
                        bg: '#00A2E9',
                        time: 4
                    });
                }else{
                	
                	$.ajax({
                        url: "${wx}/weixin/shop/consumeType",
                        dataType: 'json',
                        data:{total:total,shotName:shotName,num:'${shop.num}',giftid:'${giftid}',paytype:paytype,insurid:insurid,awardno:awardno},
                        type: "post",
                        success: function (data) {
                            if (data.value == 6) {
                           	 $(".loading").hide();
                           	 $.MsgBox.Alert("支付提示", "购买金额错误，至少消费一元");
                            }
                            else if(data.value == 2){
                           	 	$.MsgBox.Alert("支付提示", "您还未登录");
                            	 window.location.href = "${wx}/weixin/shop/insur_detail";
                            }else if(data.value == 5){
                           	 //$(".loading").hide();
                           	 $.MsgBox.Alert("支付提示", "账户余额不足");
                            }else if(data.value == 1){
                            	//$(".loading").hide();
                            	$.MsgBox.Alert("支付提示", "购买成功");
                            	window.location.href = "${wx}/weixin/shop/insur_list";
                                $("#mone").show();
                                $("#sub").hide();
                            }else if(data.value == -1){
                            	//$(".loading").hide();
                            	$.MsgBox.Alert("支付提示", "购买失败");
                                $("#mone").show();
                                $("#sub").hide();
                            }else if(data.value == 8){
                            	//$(".loading").hide();
                            	$.MsgBox.Alert("支付提示", "金额大于单笔交易最高限额");
                                $("#mone").show();
                                $("#sub").hide();
                            }else if(data.value == 10){
                            	//$(".loading").hide();
                            	$.MsgBox.Alert("支付提示", "电子钱包最低留存额度");
                                $("#mone").show();
                                $("#sub").hide();
                            }else if(data.value == 11){
                            	//$(".loading").hide();
                            	$.MsgBox.Alert("支付提示", "单日交易最高限额");
                                $("#mone").show();
                                $("#sub").hide();
                            }else{
                            	//$(".loading").hide();
                            	$.MsgBox.Alert("支付提示", "支付失败");
                                $("#mone").show();
                                $("#sub").hide();
                            }
                        }
                    });
                }
	    }});
		}, function() {
        	// $(".load").hide();
		}, null, null, "确定", "取消");
	}
});
/* $("#btn").click(function () {
	top.location.href="${wlpt}/wlpt/personal/index?flag=zhzx"
}); */
</script>
</body>
</html>