<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>提现</title>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
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
    </style>
</head>
<body>
        <div class="withdraw_cash_wrap">
        <p class="user_data">
            <img src="/static/images/wlptfront/line-left.png"><span class="title_blue">账户</span><span class="title_orange">提现</span><img src="/static/images/wlptfront/line-right.png">
        </p>
        <div style="padding-left: 252px;">
            <table>
                <tr>
                    <td class="left_title">银行卡号：</td>
                    <td>
                    <c:choose>
                    <c:when test="${not empty userBankList}">
                        <select name="bankid" id="bankid" style="border:0;">
                            <c:forEach items="${userBankList}" var="dr" varStatus="i">
                                <option value="${dr.id}">
                                        ${dr.bankcard}&nbsp;${dr.banktype}
                                </option>
                            </c:forEach>
                        </select>
                    </c:when>
                    <c:otherwise><input id="bankid" value="" type="hidden"/><span id="info" style="margin-right: 24%;">您没有绑定银行卡，不可提现！</span></c:otherwise>
                    </c:choose>
                    </td>
                </tr>
                <tr>
                    <td class="left_title">提现金额：</td>
                    <td><input type="text" id="num" style="height: 28px;line-height: 28px;width: 160px;">&nbsp;元&nbsp;&nbsp;&nbsp;<span class="count_state">可用余额：</span>
		                <span id="available" class="count_green">${not empty user.userPurse.availablebalance ? user.userPurse.availablebalance:'0.00'}</span>
                        <c:if test="${user.memberId!=null&&user.memberId!=''}"><span style="padding-left: 15px;"><input type="checkbox" id="isAccount" name="isAccount" value="1"/>银行卡账户</span></c:if>
                    </td>
                </tr>
                <tr>
                    <td class="left_title">提现密码：</td>
                    <td><input id="password"  type="password" style="height: 28px;width: 160px;line-height: 28px;"/></td>
                </tr>
                <tr>
                    <td class="right_con cash_type_list" colspan=2 style="padding-top: 30px;">
                        <input id="btnSubmit" class="regbt" type="button" value="提现"/>
                        <input class="regbt" type="button" value="返回" onclick="history.go(-1)"/>
                    </td>
                </tr>
            </table>
            </div>
            <div class="loading_lock" style="width: 100%;"><img src="${ctxStatic }/images/loading.gif"><p>等待中</p></div>
            <div class="kind_reminder">
                <h5>温馨提示：</h5>
                <p>1、确认账户卡号是否正确，提现金额是否与无误</p>
				<p>2、如有问题，请及时与平台服务联系。</p>
				<p>客户热线：0310-3188756。</p>
                 
            </div>
        </div>
        <script src="${ctxStatic}/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
        <script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
        <script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
        <script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
        <script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
        <script type="text/javascript">
        $(".loading_lock").hide();
        var amount=0.00;
        var avail="${not empty user.userPurse.availablebalance ? user.userPurse.availablebalance:'0.00'}";
        var consumeway="0";
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
        $("input[name='isAccount']").click(function () {
            var isAccount = $("input[name='isAccount']:checked").val();
            if (isAccount == 1) {
                $("#available").html(amount);
                consumeway="10";
            } else {
            	$("#available").html(avail);
            	consumeway="0";
            }
        });
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
            var isnul = true;
            if ($("#bankid").val() == null || $("#bankid").val() == "") {
                $("#info").tips({
                    side: 3,
                    msg: '请先绑定银行卡！',
                    bg: '#00A2E9',
                    time: 2
                });
                return false;
            }
            isnul = isnul && $("#num").valid({
                methods: "required|decimalTwo"
            });
            isnul = isnul && $("#password").valid({
            	methods: "required"  
            });
            if (isnul) {
            	var num = $("#num").val();
            	var total=$("#available").html();
            	if(num*1>total*1||num*1<=0){
            		$("#num").tips({
                        side: 3,
                        msg: '提现金额必须大于0并且小于可用金额',
                        bg: '#00A2E9',
                        time: 4
                    });
                    return false;
            	}
            	
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
        	     	            url: "${wlpt}/wlpt/consume/accountCash",
        	     	            dataType: 'json',
        	     	            data:{"bankid":$("#bankid").val(),"passWord":$("#password").val(),"cashMoney":$("#num").val(),"payway":consumeway},
        	     	            type: "post",
        	     	            success: function (data) {
        	     	                if(data.state==1){
        	     	                	$.MsgBox.Alert("提现提示", "申请提现成功");
        	     	                	$(".loading_lock").hide();
        	     	                	window.location.href = '${wlpt}/wlpt/consume/toPurse';
        	     	                }else{
        	     	                	$.MsgBox.Alert("提现提示", data.message);
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
