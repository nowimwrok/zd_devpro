<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">


	<title>运单lbs定位</title>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <link rel="stylesheet" type="text/css" href="/static/modules/wlpt/front/css/personal/count.css">
    <style type="text/css">
    body{
        padding: 0;
        margin: 0;
        width: 100%;
        margin: 0 auto;
        text-align: center;
        border: 1px solid #D6D3CE;
        font-family: "微软雅黑";
    }
    ul p span a input td{
        font-family: "微软雅黑";
    }
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
            width: 55px;
            height: 35px;
            border: solid 1px;
            border-radius: 0px;
            background-color: #FFC52F;
            border-color: #FFC52F;
            cursor: pointer;
            font-weight: bold;
            text-align: center;
            color: white;
            margin-top: 0px;
            font-size: 16px;
        }
        .detail-row{
	     display: none;
	   }
	   .withdraw_cash_wrap table tr {
		    line-height: 40px;
		}
		input[type=radio]{
		    height: 20px;
		    line-height: 20px;
		    width: 20px;
		    vertical-align: middle;
		}
		input[type="text"] {
		    padding-left: 5px;
		    line-height: 30px;
		}
		
		input[type="text"],select{
		    height: 30px;
		    line-height: 30px;
		    
		    
		}
		.bg_blue_btn1 {
		    width: 200px;
		    background: #00B0D9;
		    border: none;
		    color: #FFf;
		    line-height: 40px;
		    font-size: 20px;
		    display: block;
		    margin: auto;
		    /* margin-left: 0%; */
		    margin-top: 40px;
		    margin-bottom: 60px;
		    text-align: center;
		    /* margin: auto; */
		}
    </style>
    
   
</head>
<body>

        <div class="withdraw_cash_wrap">
            <table>
                <tr>
                    <td class="left_title" style="width:20%;">运单编号：</td>
                    <td class="right_con right_con_1" style="width:25%;font-size: 16px;" id="lbsOrderNo">
                        ${orderinfo.orderno }
                    </td>
						<div style="display:none;" id="replaymsg">检测到运单承运车辆定位手机号未授权定位功能，请通知司机短信回复Y授权定位。</div></td>
                </tr>
                
                <tr>
                    <td class="left_title">始发地：</td>
                    <td class="right_con" colspan=3>
                    	${orderinfo.quoteinfo.goods.shipAddress.province}
                        ${orderinfo.quoteinfo.goods.shipAddress.city}
                        ${orderinfo.quoteinfo.goods.shipAddress.district}
                    </td>
                </tr>
                <tr>
                    <td class="left_title">目的地：</td>
                    <td class="right_con" colspan=3>
                    	${orderinfo.quoteinfo.goods.consignAddress.province}
                        ${orderinfo.quoteinfo.goods.consignAddress.city}
                        ${orderinfo.quoteinfo.goods.consignAddress.district}
                    </td>
                </tr>
                <tr>
                    <td class="left_title">车牌号码：</td>
                    <td class="right_con" colspan=3>
                    	<span id="carNum">${orderinfo.quoteinfo.car.carnumber}</span>
                    </td>
                </tr>
                <tr>
                    <td class="left_title">定位手机号：</td>
                    <td  colspan=3><input type="text"  value="${orderinfo.locationmobile}" name="LOCATIONMOBILE" id="LOCATIONMOBILE" placeholder="请输入定位手机号" maxlength="11" >
                    	<span id="locamsg" style="margin-left: 10px;color:#F74000"><span id="getlocation">立即定位</span></span>
                    	
                    </td>
                </tr>
                 <tr>
                    <td class="left_title">定位频率：</td>
                    <td colspan="3">
                    	<input type="text" class="numbertext" id="frequency" maxlength="10" value="10" ><select id="frequencyval" style="margin-right: 7px;">
								<option value="1">分钟</option>
								<option value="2">小时</option>
							</select>
							<span id="frequencymsg" style="margin-left: 10px;">即每隔<span id="freqval">10</span><span id="freunit">分钟</span>系统自动定位一次</span>
                    </td>
                </tr>
                
                
                <tr>
                    <td class="left_title">支付方式：</td>
                    <td class="right_con" colspan=3>
                    	<input type="radio" class="paytyperadio" checked="checked"
					name="payway" value="0"/><span>账户余额</span>&nbsp;&nbsp;
					
					<input type="radio" class="paytyperadio" 
					name="payway" value="1"/><span>卓币</span>
                    </td>
                </tr>
                
               
                <tr>
                    <td class="right_con cash_type_list" colspan=4>
	                    <input type="hidden" id="loctionmobile" value="${orderinfo.locationmobile }"/>
						<input type="hidden" id="isreplay" value="${orderinfo.isreply }"/>
                        <a class="btn btn-default bg_blue_btn1" id="subtn">开通定位</a>
                    </td>
                </tr>
                
            </table>
           <!--  <div class="loading">
            <img src="/static/images/loading.gif">
            <p>加载中</p>
            </div> -->
            <div class="kind_reminder">
                <h5>温馨提示：</h5>
                <p>1、货物在途定位功能，让您实时掌握车辆与货物位置，并减少货主咨询次数，给客户更好的体验。</p>
					<p>2、当运单上传提货凭证后，开启定位；当运单上传回单后，将停止定位。</p>
					<!-- <p>3、停止定位后，剩余费用将返还到您的账户余额中。</p> -->
					<p>4、货物定位使用LBS定位，需要向通信运营商缴纳0.15元/每次定位费。</p>
            </div>
            <div class="loading_lock" style="width: 100%;"><img src="${ctxStatic }/images/loading.gif"><p>等待中</p></div>
        </div>
<script src="${ctxStatic}/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script type="text/javascript">
$(function(){
		//payfn();	
		$("#loading_lock").show();
		comt();
		if($("#loctionmobile").val()!=""){
			$("#locationmsg").css("display","none");
			//填写了定位手机号，判断是否同意定位
			if($("#isreplay").val()=="Y"){
				$("#replaymsg").css("display","none");
			}else{
				$("#replaymsg").css("display","block");
			}
		}else{
			$("#locationmsg").css("display","block");
		}
		/* if($("#isreplay").val()=="Y"){
			$("#replaymsg").css("display","none");
		}else{
			$("#replaymsg").css("display","block");
		} */
		$("#frequencyval").change(function(){
			var frenval=$(this).val();
			//var fretime=
			var bl=$("#frequency").valid({
				methods : "isNum"
			});		
			if(!bl){
				return;
			}
			if(frenval==1){
				$("#freqval").html($("#frequency").val()*1);
				$("#freunit").html("分钟");
			}
			if(frenval==2){
				$("#freqval").html($("#frequency").val()*1);
				$("#freunit").html("小时");
			}
			//payfn();
		});
		$("#frequency").blur(function(){
			if($(this).val()<=0){
				$("#frequency").tips({
	                   msg: "定位频率必须是大于0的整数",
	                   side: 2,
	                   bg: "#00A2E9"
	               });
				$(this).focus();
				return;
			}
			var bl=$("#frequency").valid({
				methods : "isNum"
			});
			if(!bl){
				$(this).focus();
				return;
			}
			//payfn();
			$("#freqval").html($("#frequency").val());
			comt();
		});

	$("#subtn").click(function(){
		$("#loading_lock").show();
		var isnul=true;
		comt();
		
		isnul = isnul && $("#LOCATIONMOBILE").valid({
			methods : "required|isPhone"
		});
		isnul = isnul && $("#frequency").valid({
			methods : "required|isNum"
		});
		isnul=comt();
		if(!isnul){
			$("#loading_lock").hide();
			return;
		}
		/*  */
		if(checkOpenLocation()||$("#isreplay").val()!="Y"){
			$.MsgBox.Alert("定位提示","你的手机号码还未开通定位，如您已收到短信并回复'y',请重新点击'立即定位'按钮");
			//$("#replaymsg").css({"display":"block","color":"#F74000"});
			$("#loading_lock").hide();
			return;
		}
		
	
		
		if(isnul){
			
			$.MsgBox.Confirm("温馨提示", "确定为该运单开通LBS定位吗?", function() {
				var paytype=$("input[name=payway]:checked").val();
			var datainfo={
					locationRate:$("#frequency").val()*1,
					locationRateType:$("#frequencyval").val(),
					locationmobile:$("#LOCATIONMOBILE").val(),
					locationpayway:paytype,
					orderno:'${orderinfo.orderno}',
					id:'${orderinfo.id}'
			};
				$.ajax({
						url : "${wlpt}/wlpt/orderlbs/subinfo",
						data :datainfo,
						dataType : 'json',
						cache : false,
						success : function(data) {
							$("#loading_lock").hide();
							if(data.state=='1'){
								$.MsgBox.Alert("定位开通提示", data.message);
							}else{
								$.MsgBox.Alert("定位开通提示", data.message);
							}
							
						}
					});
			}, function() {
				$("#loading_lock").hide();
			}, null, null, "确定", "取消");
		}
	});
		
	//验证定位频率
	function comt(){
		
		var freqtype=$("#frequencyval").val();
		var freq=$("#frequency").val()*1;//定位频率的值
		
		if(freqtype==1){
			if(freq<10){
				$("#frequency").tips({
	                msg: "定位频率必须是大于10的整数",
	                side: 2,
	                bg: "#00A2E9"
	            });
				$(this).focus();
				return false;
			}
		}
		/* if($("#LOCATIONMOBILE").val()==""){
			$("#locationmsg").css("display","block");
			return false;
		} */
		return true;
	} 
	
	

function checkOpenLocation(){
	var LOCATIONMOBILE=$("#LOCATIONMOBILE").val();
	var carNum =$("#carNum").html();
	$.ajax({
		url : "${wlpt}/wlpt/lbsinfo/SendList",
		data :{mobile:LOCATIONMOBILE,carnumber:carNum},
		dataType : 'json',
		async:false,
		cache : false,
		success : function(data) {
			if(data!='1'){
				return false;
			}else{
				return true;
			}
		}
	});
}

$("#LOCATIONMOBILE").blur(function(){
	sendlocation();
});
$("#getlocation").click(function(){
	sendlocation();
});
function sendlocation(){
	$("#loading_lock").show();
	var isnul=true;
	isnul = isnul && $("#LOCATIONMOBILE").valid({
		methods : "required|isPhone"
	});
	if(!isnul){
		return;
	}
	/* if(checkOpenLocation()){
		$.MsgBox.Alert("定位提示","你的手机号码还未开通定位，如您已收到短信并回复'y',请重新点击'立即定位'按钮");
		return;
	} */
	var LOCATIONMOBILE=$("#LOCATIONMOBILE").val();
	var carNum =$("#carNum").html();
	var orderId = '${orderinfo.id }';
	$.ajax({
		url:"${wlpt}/wlpt/lbsinfo/sendLocation",
		data :{mobile:LOCATIONMOBILE,carnumber:carNum,orderId:orderId},
		dataType : 'json',
		cache:false,
		async:false,
		success:function(data){
			if(data.state==2){
				 $("#isreplay").val('Y');
				$("#loading_lock").hide();
				$("#locamsg").hide();
			}else{
				$("#isreplay").val('');
				$("#locamsg").show();
				$.MsgBox.Alert("定位提示", data.message);
			}
		}
	});
	
}
});
</script>
</body>
</html>
