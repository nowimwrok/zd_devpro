<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>转账</title>
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
           line-height: 28px;
            width: 55px;
            height: 28px;
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
<%@ include file="/WEB-INF/views/modules/wlpt_front/contacts/contacts_info.jsp" %>
<style type="text/css">
#dialog {
    top: 45%;
}
</style>
        <div class="withdraw_cash_wrap">
        <p class="user_data">
            <img src="/static/images/wlptfront/line-left.png"><span class="title_blue">账户</span><span class="title_orange">转账</span><img src="/static/images/wlptfront/line-right.png">
        </p>
            <table>
                <tr>
                    <td class="left_title" style="width:20%;">转账账号：</td>
                    <td class="right_con right_con_1" style="width:25%;font-size: 16px;">
                        <input type="text" id="searchinfo" placeholder="请输入用户名/手机号">
                    </td>
                    <td style="width:25%;"><input type="button" onclick="search();" class="regbt" value="搜索"/><span onclick="showBg1();"><a href="#">常用联系人</a></span></td>
                    <td style="width:25%;"></td>
                </tr>
                <tr id="info" class="detail-row">
                   <td colspan="4">
				   <table class="table_border" cellpadding="0" cellspacing="0" style=" margin-left: 80px;">
				   <tr>
                    <td id="login">登录名：</td>
                    <td id="name">真实姓名：</td>
                    <td id="phone">电话：</td>
                   </tr>
                   <tr>
                    <td id="email">邮箱：</td>
                    <td id="sex">性别：</td>
                    <td id="status">认证：</td>
                   </tr>
				   </table>
                </tr>
                <tr>
                    <td class="left_title">转账金额：</td>
                    <td class="right_con" colspan=3><input type="text" id="num" value="" style="height: 28px;line-height: 28px;">&nbsp;元&nbsp;&nbsp;&nbsp;<span class="count_state">可用余额：</span>
                    <span id="available" class="count_green">${not empty user.userPurse.availablebalance ? user.userPurse.availablebalance:'0.00'}</span>
                    <c:if test="${user.memberId!=null&&user.memberId!=''}"><span style="padding-left: 25px;"><input type="checkbox" id="isAccount" style="height: 13px;width: 20px;" name="isAccount" value="1"/>银行卡账户</span></c:if>
                    </td>
                </tr>
                <tr>
                    <td class="left_title">支付密码：</td>
                    <td colspan="3">
                      <input id="password"  value="" type="password" style="height: 28px;line-height: 28px;"/>
                    </td>
                </tr>
                <tr>
                    <td class="left_title"></td>
                    <td class="right_con please_note" colspan=3>请注意：向账户转账，金额从账户余额扣减，转账金额大于0并且小于账户余额，如有问题，请致电卓大客服办理</td>
                </tr>
                <tr>
                    <td class="left_title"></td>
                    <td class="right_con cash_type_list cash_type_list1" colspan=3>
                        <p class="custom_service">客服电话：0310-3188756&nbsp;&nbsp;服务时间：周一至周日9：00-17:30</p>
                    </td>
                </tr>
                <tr>
                    <td class="right_con cash_type_list" colspan=4>
                        <a class="btn btn-default bg_blue_btn" id="btnSubmit">转账</a>
                    </td>
                </tr>
            </table>
            <!-- <div class="loading">
            <img src="/static/images/loading.gif">
            <p>加载中</p>
            </div> -->
            <div class="loading_lock" style="width: 100%;"><img src="${ctxStatic }/images/loading.gif"><p>等待中</p></div>
            <div class="kind_reminder">
                <h5>温馨提示：</h5>
                 <p>1、转账支付金额确认支付后不可修改，请熟知</p>
                 <p>2、转账完成后，在充值中心可以查看转账操作记录</p>
            </div>
        </div>

<script src="${ctxStatic}/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script>
$(".loading_lock").hide();

var amount=0.00;
var avail="${not empty user.userPurse.availablebalance ? user.userPurse.availablebalance:'0.00'}";
var consumeway="0";
var memberId="${user.memberId}";
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

$("#searchinfo").change(function(){
	search();
});

var reuserenname;
var rememberId=null;
var flag;
var targetstatus=null;
function search() {
    var isnul = true;
    isnul = isnul && $("#searchinfo").valid({
                methods: "required"
            });
    if (isnul) {
        var searchinfo = $("#searchinfo").val();
        $.ajax({
            url: "${wlpt}/wlpt/personal/searchInfo",
            dataType: 'json',
            data: {searchinfo: searchinfo},
            cache: false,
            success: function (data) {
                if (data) {
                    if (data.value == '未查到指定用户') {
                        $("#info").addClass("detail-row");
                        flag="false";
                        $("#searchinfo").tips({
                            side: 3,
                            msg: '未找到指定用户',
                            bg: '#00A2E9',
                            time: 4
                        });
                    } else {
                    	flag="true";
                    	if(data.value.user.memberId){
                    		rememberId=data.value.user.memberId;
                    	}
                        if (data.value.role.enname) {
                        	reuserenname=data.value.role.enname;
                        }
                        if (data.value.user.loginName) {
                            $("#login").html("登录名：" + data.value.user.loginName);
                        }
                        if (data.value.user.name) {
                            $("#name").html("真实姓名：" + data.value.user.name);
                        }
                        if (data.value.user.phone) {
                            $("#phone").html("电话：" + data.value.user.phone);
                        }
                        if (data.value.user.email) {
                            $("#email").html("邮箱：" + data.value.user.email);
                        }
                        if (data.value.info.sex) {
                            if (data.value.info.sex == '1') {
                                $("#sex").html("性别：" + '男');
                            }
                            if (data.value.info.sex == '0') {
                                $("#sex").html("性别：" + '女');
                            }
                        }
                        if (data.value.info.status) {
                        	targetstatus=data.value.info.status;
                            if (data.value.info.status == '2') {
                                $("#status").html("认证：" + '认证通过');
                            } else {
                                $("#status").html("认证：" + '未通过');
                            }

                        }
                        $("#info").removeClass("detail-row");
                    }
                }
            }
        });
    }
}
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
	var nul = true;
	nul = nul && $("#searchinfo").valid({
        methods: "required"
    });
    nul = nul && $("#num").valid({
        methods: "required"
    });
    nul = nul && $("#num").valid({
        methods: "decimalTwo"
    });
    nul = nul && $("#password").valid({
    	methods: "required"  
    });
    if(flag=="false"){
    	$("#searchinfo").tips({
            side: 3,
            msg: '请输入正确用户',
            bg: '#00A2E9',
            time: 4
        });
    	return false;
    }
    if (nul) {
    	var phone="${user.phone}";
        var name="${user.name}";
        var search=$("#searchinfo").val();
        if(search==phone||search==name){
        	$("#searchinfo").tips({
                side: 3,
                msg: '不能给自己转账',
                bg: '#00A2E9',
                time: 4
            });
        	return false;
        }
        
    	var num = $("#num").val();
    	var total=$("#available").html();
    	if(num*1>total*1||num*1<=0){
    		$("#num").tips({
                side: 3,
                msg: '转账金额必须大于0并且小于可用金额',
                bg: '#00A2E9',
                time: 4
            });
            return false;
    	}/* else if(nul == false){
    		$("#num").tips({
                side: 3,
                msg: '只能为数字或小数且小数点后不能超过两位',
                bg: '#00A2E9',
                time: 4
            });
    	} */
    	var userenname = "${user.role.enname}";
    	if(reuserenname=="enterprise"&&userenname=="carowner"){
    		$("#searchinfo").tips({
                side: 3,
                msg: '车主不能转账给企业',
                bg: '#00A2E9',
                time: 4
            });
            return false;
    	}
    	if(reuserenname == "U_financial" || reuserenname == "U_salesman") {
            $("#searchinfo").tips({
                side: 3,
                msg: '抱歉，不能转账给子账户',
                bg: '#00A2E9',
                time: 4
            });
            return false;
        }
    	if(targetstatus!='2'){
    		$("#searchinfo").tips({
                side: 3,
                msg: '目标用户未完成认证，不可转账',
                bg: '#00A2E9',
                time: 4
            });
            return false;
    	}
    	if(consumeway=="10"){
    		if(((rememberId==null||rememberId=="")&&(memberId!=null&&memberId!=""))||((rememberId!=null&&rememberId!="")&&(memberId==null||memberId==""))){
        		$("#searchinfo").tips({
                    side: 3,
                    msg: '抱歉，暂不支持对体系外的账号转账',
                    bg: '#00A2E9',
                    time: 4
                });
                return false;
        	}
    	}
    	
    	/* if((reuserenname=="carowner"||reuserenname=="goodsowner")&&userenname=="enterprise"){
    		$("#searchinfo").tips({
                side: 3,
                msg: '暂不支持企业和个人间的转账',
                bg: '#00A2E9',
                time: 4
            });
            return false;
    	}
    	if(reuserenname=="enterprise"&&userenname=="goodsowner"){
    		$("#searchinfo").tips({
                side: 3,
                msg: '暂不支持企业和个人间的转账',
                bg: '#00A2E9',
                time: 4
            });
            return false;
    	}
    	if ($(".loading").is(':hidden')) {
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
	     	            url: "${wlpt}/wlpt/consume/transfer",
	     	            dataType: 'json',
	     	            data:{"target.searchinfo":$("#searchinfo").val(),"consumemony":num,"payway":consumeway},
	     	            type: "post",
	     	            success: function (data) {
	     	                if (data.value == 1) {
	     	                	window.location.href = '${wlpt}/wlpt/consume/toPurse';
	     	                }else if(data.value == 5){
	     	                	$.MsgBox.Alert("转账提示", "可用余额不足");
	     	                	$(".loading_lock").hide();
	     	                }else if(data.value == 2){
	     	                	$.MsgBox.Alert("转账提示", "用户不存在");
	     	                	$(".loading_lock").hide();
	     	                }else if(data.value == 3){
	     	                	$.MsgBox.Alert("转账提示", "只有货主、车主或者企业才可以转账");
	     	                	$(".loading_lock").hide();
	     	                }else if(data.value == 8){
	     	                	$.MsgBox.Alert("转账提示", "转账金额大于单笔交易最高限额");
	     	                	$(".loading_lock").hide();
	     	                }else if(data.value == 10){
	     	                	$.MsgBox.Alert("转账提示", "电子钱包最低留存额度不足");
	     	                	$(".loading_lock").hide();
	     	                }else if(data.value == 11){
	     	                	$.MsgBox.Alert("转账提示", "转账金额大于单日交易最高限额");
	     	                	$(".loading_lock").hide();
	     	                }
	     	                else {
	     	                    $.MsgBox.Alert("转账提示", "转账失败");
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
