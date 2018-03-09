<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>油气充值</title>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/static/modules/wlpt/front/css/personal/count.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/personal.css">
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
    </style>
    
    
</head>
<body>
<ul class="qiye_menu">
    <li data-type="1" ><a href="${wlpt }/wlpt/consume/toPurse" target="content" style="color: #000;">账户余额</a></li>
    <li data-type="2" ><a href="${wlpt}/wlpt/consume/toCoinRecharge" target="content" style="color: #000;">卓币充值</a></li>
    <li data-type="3" class="qiye_menu_1">油气充值</li>
    <li data-type="4" ><a href="${wlpt}/wlpt/consume/toGueanRecharge" target="content" style="color: #000;">保证金充值</a></li>
</ul>
        <div class="withdraw_cash_wrap">
        <p class="user_data">
            <img src="/static/images/wlptfront/line-left.png"><span class="title_blue">油气</span><span class="title_orange">充值</span><img src="/static/images/wlptfront/line-right.png">
        </p>
            <table>
            	<tr>
                    <td class="left_title" style="width:20%;">当前卓币：</td>
                    <td class="right_con right_con_1" style="width:25%;font-size: 16px;">
                        <span  id="coin"></span>&nbsp;币
                    </td>
                    <td style="width:25%;"></td>
                    <td style="width:25%;"></td>
                </tr>
                <tr>
                    <td class="left_title" style="width:20%;">当前油气余额：</td>
                    <td class="right_con right_con_1" style="width:25%;font-size: 16px;">
                        ${user.userPurse.petrolbalance }&nbsp;元
                    </td>
                    <td style="width:25%;"></td>
                    <td style="width:25%;"></td>
                </tr>
                
                <tr>
                    <td class="left_title">充值油气：</td>
                    <td class="right_con" colspan=3><input type="number" min="1" id="num" style="height: 28px;line-height: 28px;">&nbsp;&nbsp;币</td>
                </tr>
                <tr>
                    <td class="left_title">支付密码：</td>
                    <td colspan="3">
                      <input id="password" type="password" style="height: 28px;line-height: 28px;"/>
                    </td>
                </tr>
                <tr>
                    <td class="left_title"></td>
                    <td class="right_con please_note" colspan=3>请注意：仅支持卓币充值，在线支付成功后。充值金额会在一分钟内到账；如有疑问，请致电卓大物流客服办理</td>
                </tr>
                <tr>
                    <td class="left_title"></td>
                    <td class="right_con cash_type_list cash_type_list1" colspan=3>

                        <p class="custom_service">客服电话：0310-3188756&nbsp;&nbsp;服务时间：周一至周日9：00-17:30</p>

                    </td>
                </tr>
                
                <tr>
                    <td class="right_con cash_type_list" colspan=4>
                        <a class="btn btn-default bg_blue_btn" id="btnSubmit">充值</a>
                    </td>
                </tr>
            </table>
            <!-- <div class="loading">
            <img src="/static/images/loading.gif">
            <p>加载中</p> -->
            </div>
            <div class="kind_reminder">
                <h5>温馨提示：</h5>
                <p>1. 油气充值金额 确认支付后不可修改，请悉知</p>
                <p>2. 支付完成后，在钱包账户可以查看充值操作记录</p>
            </div>
            <div class="loading_lock" style="width: 100%;"><img src="${ctxStatic }/images/loading.gif"><p>等待中</p></div>
        </div>
<script src="${ctxStatic}/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script>
var coin = '${user.userPurse.availablecoin }';
if(coin!=''){
	$("#coin").html(parseInt(coin));
}else{
	$("#coin").html("0");
}
$(".loading_lock").hide();

var reuserenname;
var flag;

$("#btnSubmit").click(function () {
	var nul = true;
    nul = nul && $("#num").valid({
        methods: "required|isNum"
    });
    nul = nul && $("#password").valid({
    	methods: "required"  
    });
   
    if (nul) {
    	var num = $("#num").val();
    	if(num*1<1){
    		$("#num").tips({
                side: 3,
                msg: '至购买1币油气',
                bg: '#00A2E9',
                time: 4
            });
            return false;
    	}
    	var total="${not empty user.userPurse.availablecoin ? user.userPurse.availablecoin:'0.00'}"
    	if(num*1>total*1){
    		$("#num").tips({
                side: 3,
                msg: '可用卓币不足',
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
        $(".loading_lock").show();
    	if($("#password").val()!=""&&$("#password").val()!=null){
    		$.ajax({
	            url: "${ctx}/wlpt/user/validateCashPwd",
	            dataType: 'json',
	            data:{"cashPwd":$("#password").val(),"isSave":false},
	            type: "post",
	            success: function (data) {
	                if (data == false) {
	                	$("#password").tips({
	                        side: 3,
	                        msg: '支付密码错误或未设置支付密码',
	                        bg: '#00A2E9',
	                        time: 4
	                    });
	                	$(".loading_lock").hide();
	                }else{
	           		 $.ajax({
	     	            url: "${wlpt}/wlpt/consume/petroRecharge",
	     	            dataType: 'json',
	     	            data:{"consumemony":num,"coinnum":num},
	     	            type: "post",
	     	            success: function (data) {
	     	                if (data.value == 1) {
	     	                	window.location.href = '${wlpt}/wlpt/consume/toPurse';
	     	                }else if(data.value == 5){
	     	                	$("#num").tips({
	     	                       side: 3,
	     	                       msg: '可用卓币不足',
	     	                       bg: '#00A2E9',
	     	                       time: 4
	     	                   });
	     	                	$(".loading_lock").hide();
	     	                }else if(data.value == 6){
	     	                	$("#num").tips({
	     	                       side: 3,
	     	                       msg: '至购买1币油气',
	     	                       bg: '#00A2E9',
	     	                       time: 4
	     	                   });
	     	                	$(".loading_lock").hide();
	     	                }
	     	                else {
	     	                    $.MsgBox.Alert("充值提示", "充值失败");
	     	                   $(".loading_lock").hide();
	     	                }
	     	            }
	     	        });
	     	      }
	            }
	        });
    	}
    }
});
</script>
</body>
</html>
