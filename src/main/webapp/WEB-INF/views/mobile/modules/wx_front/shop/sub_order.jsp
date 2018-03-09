<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<html lang="zh-cmn-Hans">
<head>
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
    <link href="${ctxStatic}/weixin/css/global.css" rel="stylesheet">
    <link href="${ctxStatic}/weixin/css/shop.css" rel="stylesheet">
    <title>提交订单</title>
    <style>
        .allr_wrap .content_wrap {
            width: 90%;
            margin: 0 auto;
            padding: 0px;
        }

        .content_wrap .order_list {
            line-height: 45px;
            width: 98%;
            padding: 0px;
            border-bottom: 1px dashed #000;
        }

        .allr_wrap button {
            width: 100%;
            border-radius: 5px;
            height: 45px;
            line-height: 40px;
            font-weight: normal;
            letter-spacing: 0px;
        }

        input[type="password"] {
            width: 50%;
            height: 25px;
            border: 1px solid #CCC;
            border-radius: 5px;
            letter-spacing: 10px;
        }
        .buy_knows>p {
            line-height: 25px;
            font-size: 0.8rem;
        }
input {
    border: none;
    font-size: 0.9em;
    height: 35px;
    line-height: 35px;
    text-align: center;
}
input[type='text']{
    border: none;
    font-size: 0.9em;
    height: 35px;
    line-height: 35px;
    text-align: left;
}
.buy_knows {
    color: #a4a4a4;
    /* height: 25px; */
    /* line-height: 25px; */
    margin-top: 30px;
}
.paytyperadio{
    height: 15px;
    width: 15px;
}
        *{box-sizing:border-box;margin:0;padding:0;font-family:"Microsoft YaHei",Times New Roman,Georgia,Serif;font-size: 14px;}
        ul,ol{list-style: none;}
        a,a:hover,a:active,a:focus{text-decoration: none;}

        *{box-sizing:border-box;}
        .ticket i{font-style: normal;font-size:2em;}
        .text_center{text-align:center}
        .ticket{width:100%;margin-top:10px;}
        .ticket li{position:relative;width:75%;margin:0 auto;margin-bottom:20px;height:6em;background:url(${ctxStatic}/front/img/bg_quan3.png) no-repeat;background-size:100% 100%;}
        .ticket li.over{background:url(${ctxStatic}/front/img/quan_over.png) no-repeat;background-size:100% 100%;}
        .ticket li.over span,.ticket li.over h2,.ticket li.over p,.ticket li.over b{color:#f0f0f0;}
        .ticket li.over span{border-color:#f0f0f0;}
        .ticket li span,.ticket li h2,.ticket li p,.ticket li b,.ticket h3{color:#fff;letter-spacing: 2px;}
        .ticket li b{font-size:3em;}
        .quan_text{margin-top:1.5em}
        .ticket li h2{margin-top:1em;padding-left:1em;}
        .ticket h3{font-size:1em;font-weight:200;}
        .ticket li p{font-size:1em;}
        .ticket li span{position:absolute;top:7px;left:11px;display:none;width:24px;height:24px;line-height:24px;font-size:1.1em;text-align:center;border-radius:100%;border:1px solid #fff;}
        .ticket .h3_m{}
        .have{width:24px;height:20px;position:absolute;top:5px;right:6px;;display: none;}
        .lt{float:left;}
    </style>
</head>
<body>
<!--主体内容-->
<section class="allr_wrap">

    <div class="content_wrap">
        <ul class="order_list clearfix">
        	<input type="hidden" name="name" id="name" value="${shopVO.name }"/>
            <input type="hidden" name="shotName" id="shotName" value="${shopVO.shotName }"/>
            <input type="hidden" name="price" id="price" value="${shopVO.price }"/>
            <input type="hidden" name="available" id ="available" 
            		value='${not empty user.userPurse.availablebalance?user.userPurse.availablebalance:'0.00'}' />
            <input type="hidden" name="availablecoin" id ="availablecoin" 
            		value='${not empty user.userPurse.availablecoin?user.userPurse.availablecoin:'0.00'}' />
            <li class="clearfix">
                <span class="flt_left title right">商品：</span>
                <span class="frt">${shopVO.name }</span>
            </li>
            <li class="clearfix">
                <span class="flt_left title right">单价：</span>
                <span class="frt">￥<span>${shopVO.price }</span></span>
            </li>
            <li class="clearfix">
                <span class="flt_left title right">数量：</span>
                <span class="frt"><span>&nbsp;</span>
                <input id="num" name="num" type="text" value="1" min="1" 
                style="height: 22px;line-height:22px;width: 100px;text-align: center;border: 1px solid #CCC;"/></span>
            </li>

            <li class="clearfix">
                <span class="flt_left title right">支付方式：</span>
                <span class="frt">
					<c:if test="${shopVO.shotName=='zd_coin'}">
					    <input type="radio" class="paytyperadio" checked="checked"
					    name="payway" value="0"/><span>账户余额</span>&nbsp;&nbsp;
					    <c:if test="${user.memberId!=null&&user.memberId!=''}">
						<input type="radio" class="paytyperadio" 
						name="payway" value="10"/><span>银行卡账户</span></c:if>
					</c:if>
					<c:if test="${shopVO.shotName=='you_qi'}">
					    <input type="radio" class="paytyperadio" checked="checked"
					    name="payway" value="0"/><span>账户余额</span>&nbsp;&nbsp;
					    <c:if test="${user.memberId!=null&&user.memberId!=''}">
						<input type="radio" class="paytyperadio" 
						name="payway" value="10"/><span>银行卡账户</span>&nbsp;&nbsp;</c:if>
						<input type="radio" class="paytyperadio" 
						name="payway" value="1"/><span>卓币</span>
					</c:if>
            </li>

            <%-- <li class="clearfix">
                 <span class="flt_left title right"></span>
                 <span class="frt">YJIUH</span>
             </li>--%>
        </ul>
        <p class="clearfix total_price">总价：<span class="red" id="total"></span>
        <span class="clearfix total_price" style="margin-left: 20px;display: none;" id="aw_way" >实付：<span class="red" id="sfmoney"></span></span>
        </p>

        <p>支付密码：<span><input type="password" id="cashpassword" style="width: 50%; height: 25px; border: 1px solid #CCC;
            border-radius: 5px;
            letter-spacing: 10px;line-height: 25px;" placeholder="请输入支付密码"/></span></p>

        <div id='loading'
			style='width:100%;vertical-align: middle;text-align:center;height:45px'>
			<div>
				<img src='${ctxStatic}/images/loading-30x30.gif'>
			</div>
			<div style="font-size:14px;font-weight:bold;" id="loadtext">小卓正在努力加载，请稍等!</div>
		</div>

		 <button class="btn_bg_color sub_btn no-border" id="btnSubmit" style="margin-top: 30px;">
            	提交订单
        </button>
        <c:if test="${not empty awlist }">
        <div class="ticket">
            <ul>
                <c:forEach  var="item" items="${awlist}" varStatus="status">
                <li onclick="clickaw('${status.index}','${not empty item.wxgift.giftworth ? item.wxgift.giftworth : "0"}','${item.awardno}')" id="aw${status.index}">
                    <img src="${ctxStatic}/front/img/have.png" alt="" class="have"/>
                    <span class="text_center quan">券</span>
                    <h2 class="text_center h3_m lt"><i>￥</i><b><fmt:formatNumber type="number" value="${item.wxgift.giftworth }" pattern="0" maxFractionDigits="2"/> </b></h2>
                    <div class="lt quan_text">
                        <h3>优惠券</h3>
                        <p class="text_center">${fns:getDictLabel(item.wxgift.gifttype,'gifttype','')}</p>
                    </div>
                </li>
                </c:forEach>
            </ul>
        </div>
        </c:if>
        <c:if test="${not empty wxgift }">
        	 <div class="buy_knows" >
        	<h3>好消息:</h3>
        		<p>
                	活动名称：${wxgift.giftname }
            	</p>
            	<p>
                	活动内容：${wxgift.giftcontent }
            	</p>
            	<input type="hidden" id="giftid" name ="giftid" value="${wxgift.id }"/>
        	</div>
        </c:if>
        <div class="buy_knows">
            <h3>购买须知：</h3>
            <c:if test="${shopVO.shotName=='zd_coin'}">
            <p>
                <span>卓币</span>
                        <span class="know_details">
            <p>1、本产品仅在卓大物流平台进行使用、消费；</p>
            <p> 2、本产品购买后可在账户中心查看购买记录。</p>
            </span>
            </p>
           	</c:if>
           	<c:if test="${shopVO.shotName=='you_qi'}">
            <p><span>油气</span><span class="know_details">
            <p>1、本产品内含100元的油气费用；</p>
            <p> 2、本产品购买后可在油气账户查看，通过一卡通在加油站进行油气消费。</p>
            </span></p>
            </c:if>
            <%--
                                <p><span>3、限每天加油总金额：</span><span class="know_details">根据客户管理需求根据客</span></p>
            --%>
        </div>
        
    </div>


</section>
<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery-1.7.2.js"></script>
<script type="text/javascript"
	src="${ctxStatic}/weixin/js/jquery.valid.js"></script>
<script type="text/javascript"
	src="${ctxStatic}/weixin/js/jquery.tips.js"></script>
    <script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
    <script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
    <script type="text/javascript">
    $("#loading").hide();
    var awardno ="";
    var worth=0;
    var price=$("#price").val()*1;
    var num=$("#num").val()*1;
    var total=price*num;
    $("#total").html(total);
    
    window.altmesg = function() {
		$("#btnSubmit").show();
		$("#loading").hide();
		$("#loadtext").html("加载中，请稍等！");
	};
    function clickaw(li_id,giftworth,no) {
        $("#aw"+li_id).siblings().find('img').hide();
        $("#aw"+li_id).find('img').show();
        $("#aw_way").show();
        awardno=no;
        worth = giftworth*1;
        var totals=price*num;
        var money=totals*1-worth;
        if(money<0){
            money=0;
        }
        $("#sfmoney").html(money+"元");
    }
    //自动计算金额
    $("#num").change(function(){
    	var num=$("#num").val()*1;
    	var isnul = true;
        isnul = isnul && $("#num").valid({
                    methods: "required|isNum"
                });
       if(!isnul){
    	   num=1;
    	   $("#num").val(1);
       }
    	if(num<1){
    		num=1;
    		$("#num").val(1);
    	}
    	
    	var total=price*num;
        $("#total").html("￥"+ total);
;
        var money=total*1-worth;
        if(money<0){
            money=0;
        }
        $("#sfmoney").html(money+"元");
    });
    
    var amount=0.0;
    var memberId="${user.memberId}";
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
    
    //提交
    $("#btnSubmit").click(function () {
    	var status='${user.userinfo.status}';
    	if(status==null||status==''||status==undefined||status!='2'){
    		$("#btnSubmit").tips({
                side: 3,
                msg: '请先完成认证',
                bg: '#00A2E9',
                time: 4
            });
            return false;
    	}
    	$("#loading").show();
		$("#btnSubmit").hide();
		var paytype=$("input[name=payway]:checked").val();
		var title = "余额";
		
		var cashpassword = $("#cashpassword").val();
    	 var isnul = true;
         isnul = isnul && $("#num").valid({
                     methods: "required|isNum"
                 });
        if(!isnul){
        	altmesg();
        	return false;
        }
    	var num=$("#num").val()*1;
        var total=price*num;
    	var money=total*1;
    	var shotName="${shopVO.shotName}";
    	var available=$("#available").val();
		if(paytype*1==1){
			title = "卓币";
			available=$("#availablecoin").val();
		}else if(paytype*1==10){
			
			available=amount;
		}
        if(num*1<=0||total*1<=0){
        	$("#num").tips({
				side : 3,
				msg : '请至少购买1数量的商品！',
				bg : '#00A2E9',
				time : 2
			});
        	altmesg();
        	return false;
        }
        if(available*1<(money-worth)){
    		$("#total").tips({
                side: 3,
                msg: '账户'+title+'不足(当前账户'+title+'为：'+available+')',
                bg: '#00A2E9',
                time: 4
            });
    		altmesg();
    		return false;
    	}
       	if (cashpassword == '' || cashpassword == null) {
			$("#cashpassword").tips({
				side : 3,
				msg : '请输入支付密码！',
				bg : '#00A2E9',
				time : 2
			});
			altmesg();
			return false;
		} else {
			var istrue =true;
			//同步验证--验证提现密码是否正确
			$.ajax({
				url : "${wx}/weixin/user/checkCashPwdbyCash",
				type : "POST",
				data : {cashpassword:$("#cashpassword").val()},
				async : false, ///同步请求传递
				success : function(data) {
					istrue = data;
					if(!data){
						$("#cashpassword").tips({
							side : 3,
							msg : '提现支付错误或未设置!',
							bg : '#00A2E9',
							time : 3
						});
					}
				}
			});
			
			if (istrue) {
				$.ajax({
                    url: "${wx}/weixin/shop/consumeType",
                    dataType: 'json',
                    data:{total:total,shotName:shotName,num:$("#num").val(),giftid:$("#giftid").val(),paytype:paytype,awardno:awardno},
                    type: "post",
                    success: function (data) {
                        if (data.value == 6) {
                        	window.setTimeout(altmesg, "1000");
                       	    $.MsgBox.Alert("支付提示", "购买金额错误，至少消费一卓币");
                        }else if(data.value == 2){
                       	    window.setTimeout(altmesg, "1000");
                       		$.MsgBox.Alert("支付提示", "您还未登录，请先登录");
                        }else if(data.value == 5){
                        	window.setTimeout(altmesg, "1000");
                       	 	$.MsgBox.Alert("支付提示", "账户余额不足");
                        }else if(data.value == 1){
                        	$("#btnSubmit").show();
							 $("#btnSubmit").html("购买成功");
							 $("#btnSubmit").unbind(); 
                             window.location.href = '${wx}/weixin/shop/finish';
                        }else if(data.value == -1){
                        	window.setTimeout(altmesg, "1000");
                        	$.MsgBox.Alert("支付提示", "购买失败");
                        }else if(data.value == 8){
                        	window.setTimeout(altmesg, "1000");
                        	$.MsgBox.Alert("支付提示", "金额大于单笔交易最高限额");
                        }else if(data.value == 10){
                        	window.setTimeout(altmesg, "1000");
                        	$.MsgBox.Alert("支付提示", "电子钱包最低留存额度");
                        }else if(data.value == 11){
                        	window.setTimeout(altmesg, "1000");
                        	$.MsgBox.Alert("支付提示", "单日交易最高限额");
                        }else{
                        	window.setTimeout(altmesg, "1000");
                        	$.MsgBox.Alert("支付提示", "支付失败");
                        }
                    }
                });
				
			}else{
				altmesg();
			}
		}
    });
    </script>
</body>
</html>