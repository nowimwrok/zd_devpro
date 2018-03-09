<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>

<title>${fns:getConst('SYSTEMTITLE')}--申请提现</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="format-detection" content="telephone=no">
<script type="text/javascript" src="${ctxStatic}/weixin/js/weixin/errorpage.js"></script>
<script>
	var _hmt = _hmt || [];
	(function() {
		var hm = document.createElement("script");
		hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
		var s = document.getElementsByTagName("script")[0];
		s.parentNode.insertBefore(hm, s);
	})();
</script>

<link href="${ctxStatic}/weixin/css/global.css" rel="stylesheet"
	type="text/css">
<style type="text/css">
/*整体div -top布局*/
.data_top,.result_bottom {
	width: 100%;
	display: block;
	z-index: 2;
	position: fixed;
	background-color: #FFF;
}

.result_bottom {
	height: 30px;
	border: none;
	text-align: center;
	line-height: 30px;
	bottom: 0px;
}

.data_top div {
	float: left;
	height: 50px;
	line-height: 50px;
	background-color: rgba(32, 162, 226, 1);
}

.dt_top,.data_tab {
	clear: both;
	width: 100%;
}

.dt_top {
	height: 40px;
	line-height: 40px;
}

.dt_top div {
	
}

.data_tab div {
	width: 50%;
	text-align: center;
}

.data_tab {
	border-bottom: 1px solid rgb(369, 218, 463);
}

.bord_rt {
	border-right: 1px solid #CCC;
}

/* 数据中部信息 */
.data_box {
	width: 97%;
	margin: 0 auto;
	padding-top: 50px;
	margin-bottom: 50px;
}

.data_title {
	clear: both;
	font-size: 14px;
	background: #EBEBEB;
	height: 40px;
	line-height: 40px;
	width: 100%;
	text-indent: 10px;
}

.data_cent {
	width: 96%;
	padding: 5px 0px;
	padding-left: 4%;
}

.ct_lf {
	width: 100%;
	height: 35px;
	display: table;
}

.ct_lf div {
	float: left;
	margin-right: 5px;
	line-height: 45px;
	display: table-cell;
	vertical-align: middle;
	display: table-cell
}

.ic_img {
	height: 35px;
	display: table;
}

.ic_img img {
	width: 30px;
	margin-top: 7px;
	display: table-cell;
	vertical-align: middle;
	display: table-cell;
}

.cb_tle {
	width: 25%;
	text-align: right;
	float: left;
}

.cb_val {
	width: 70%;
	float: left;
}

.val_info {
	width: 30%;
}

.disnone {
	display: none;
}

.img_text {
	font-size: 1em;
	width: 60px;
	text-align: center;
	background-image: url(${ctxStatic}/images/weixin/pic_bg_normal.png);
	height: 60px;
	background-repeat: no-repeat;
	line-height: 35px;
	background-size: 60px;
	margin: 5%;
	float: left;
	cursor: pointer;
	position: relative;
	clear: both;
}

.img_text img {
	width: 60px;
	height: 60px;
}

.img_t {
	color: rgba(37, 35, 35, 0.57);
	position: absolute;
	bottom: 0px;
	width: 60px;
	height: 35px;
}

.upimg {
	width: 60px;
	height: 60px;
}

#imgCredit {
	margin-top: 15px;
}

.up_ct {
	clear: both;
	width: 100%;
	margin-top: 10px;
	height: 50px;
}

.data_bottom {
	bottom: 0px;
	height: 40px;
	line-height: 40px;
	text-align: right;
	background: rgba(241, 234, 234, 0.67);
}

input[type='text'] {
	border-bottom: 1px solid #ccc;
	font-size: 18px;
	line-height: 25px;
	height: 30px;
}

.data_div {
	width: 98%;
	background-color: #EBEBEB;
	clear: both;
	height: 62px;
	margin: 0 auto;
	margin-bottom: 5px;
}

.data_content {
	vertical-align: middle;
	display: table-cell;
}

.top_icon {
	width: 20px;
	height: 35px;
}

.top_text {
	width: 43%;
	height: 40px;
	line-height: 40px;
}

.top_icon img {
	width: 20px;
	margin-top: 5px;
}

.icon {
	width: 25px;
}

.ic_img {
	width: 30px;
}

.data_row {
	width: 100%;
	border-bottom: 1px solid #EBEBEB;
	clear: both;
	height: 40px;
}

.data_row div {
	font-size: 16px;
}

.mag_right {
	margin-right: 4%;
}

.flt {
	float: left;
	text-align: left;
}

.frt {
	float: right;
	text-align: right;
}

.data_btm {
	width: 98%;
	padding-left: 6px;
	height: 25px;
	padding-top: 5px;
}

.data_btm div {
	float: left;
	margin-right: 3%;
	line-height: 25px;
}
.selected {
    color:#FFBB66;
    border-bottom: 2px solid #FFBB66;
    background-color:rgba(32, 162, 226, 1);
}
</style>
</head>

<body>
	<div class="data_top data_tab" style="width:100%;padding:0px;color: white;">
		<div class="selected data_tab_left">申请提现</div>
		<div class="data_tab_right">提现记录</div>
	</div>
	<div class="data_box data_box0">
		<div class="data_title">账户信息</div>
		<div class="data_cent">
			<div class="ct_lf">
				<div class="cb_tle">账号：</div>
				<div class="cb_val">
					<div><span id="usernameval">${user.loginName!=null?user.loginName:user.phone}</span></div>
					<div>
						<c:choose>
							<c:when test="${user.userinfo.status eq '2' }">
								<span class="authened" style="-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px;">已认证</span>
							</c:when>
							<c:otherwise>
								<span class="unauthen" style="-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px;">未认证</span>
							</c:otherwise>
						</c:choose>
					</div>
					<div>
						<img id="imgCredit"
							src="${ctxStatic}/images/wlptfront/pointlevel/point_level_1.gif" />
					</div>
				</div>
				<!--cb_val end  -->
				<div class="cb_tle">可用余额：</div>
				<div class="cb_val"><span id="available">${user.userPurse.availablebalance!=null?user.userPurse.availablebalance:'0.00' }</span>
				<c:if test="${user.memberId!=null&&user.memberId!=''}"><span style="padding-left: 15px;"><input type="checkbox" id="isAccount" style="height:12px;" name="isAccount" value="1"/>银行账户</span></c:if>
				</div>
			</div>
			<!--ct_lf end  -->
		</div>
		<!--data_cent end  -->
		<div class="data_title">提现信息</div>
		<div class="data_cent">
		    <div class="ct_lf">
				<div class="cb_tle">账户名称：</div>
				<div class="cb_val " style="font-size:20;font-weight:bold;" id="name" > 
					<%-- <c:if test="${user.bankinfo.bindname eq null or user.bankinfo.bindname eq ''}">
						<input type="text" id="name" style="height:45px;"
							placeholder="请输入真实姓名" value="" maxlength="6" />
					</c:if>
					<c:if test="${user.bankinfo.bindname ne null and user.bankinfo.bindname ne ''}"> --%>
						<input type="hidden" value="${user.bankinfo.accountName}" />${user.bankinfo.accountName}
					<%-- </c:if> --%>
				</div>
			</div>
			<div class="ct_lf">
				<div class="cb_tle">银行卡号：</div>
				<div class="cb_val " style="font-size:20;font-weight:bold;" id="bankCard" >
					<%-- <c:if test="${user.bankinfo.bankcard eq null or user.bankinfo.bankcard eq ''}">
						<input type="text" id="bankCard" style="height:45px;"
							placeholder="请输入银行卡号" value="" />
					</c:if>
					<c:if test="${user.bankinfo.bankcard ne null and user.bankinfo.bankcard ne ''}"> --%>
						<input type="hidden" value="${user.bankinfo.bankcard }" />${user.bankinfo.card}
					<%-- </c:if> --%>
				</div>
			</div>
			<div class="ct_lf">
				<div class="cb_tle">所属银行：</div>
				<div class="cb_val "
					style="font-size:20;font-weight:bold;padding-top:3px;" id="bank">
					<%-- <c:if test="${user.bankinfo.bankname eq null or user.bankinfo.bankname eq ''}">
						<input type="text" id="bank" style="height:45px;"
							placeholder="请输入所属银行" value="" maxlength="12" />
					</c:if> 
					<c:if test="${user.bankinfo.bankname ne null and user.bankinfo.bankname ne ''}">--%>
						<input type="hidden"  value="${user.bankinfo.banktype}" />${user.bankinfo.banktype}
					<%-- </c:if> --%>
				</div>
			</div>
			<div class="ct_lf">
				<div class="cb_tle">支行信息：</div>
				<div class="cb_val "
					style="font-size:20;font-weight:bold;padding-top:3px;" id="zh">
					<input type="hidden"  value="${user.bankinfo.bankname}" />${user.bankinfo.bankname}
				</div>
			</div>
			<div class="ct_lf">
				<div class="cb_tle">提现金额：</div>
				<div class="cb_val red" style="font-size:20;font-weight:bold;">
					<div style="float:left;width:10%;">￥</div>
					<div style="float:left;width:85%;padding-top:10px;">
						<input type="text" id="cashMoney" value="0.01" style="width:100%;" />
					</div>
				</div>
			</div>
			<div class="ct_lf">
				<div class="cb_tle">提现密码：</div>
				<div class="cb_val red">
					<input type="password" id="cashpassword" value=""
						style="height:45px;border-bottom:1px solid #ccc;width:98%;"
						placeholder="请输入账户提现密码" />
				</div>
			</div>
		</div>
		<div id='loading'
			style='width:100%;vertical-align: middle;text-align:center;height:45px'>
			<div>
				<img src='${ctxStatic}/images/loading-30x30.gif'>
			</div>
			<div style="font-size:14px;font-weight:bold;" id="loadtext">小卓正在努力加载，请稍等!</div>
		</div>
		<!--data_cent end  -->
		<div class="sub_btn" id="callCash" onclick="cashSave()"
			style="background:rgba(32, 162, 226, 0.87);-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px;">申请提现</div>
		<div class="data_cent">
			<div style="font-size:20px;margin-top:10px;">提现须知</div>
			<div class="linediv" style="line-height:15px;font-size:14px;">
				<p>1、确认账户卡号是否正确。</p>
				<p>2、提现金额是否与无误。</p>
				<p>3、如有问题，请及时与平台服务联系。</p>
				<p>客户热线：0310-3188756。</p>
			</div>
		</div>
	</div>
	<div class="data_box data_box1" style="display:none;">
		<div id="data_box" style="padding-top:5px;">
			<!-- <div id="data_div" class="data_div" >
				<div class="data_row data_btm">
					<div class="flt">交易单号:{{ORDERNO}}</div>
					<div class="frt" style="float:right;"><span class="authened">处理中</span></div>
				</div>
				<div class="data_row data_btm" style="border:none">
					<div>交易金额：￥{{FREIGHT}}元</div>
					<div class="frt" style="float:right;">
						2013-12-12
					</div>
				</div>
			</div> -->
		</div>
		<div id="pages" style="display:none;">
			<span id="firstPage"><a>首页</a></span> <span id="previewPage"><a>上一页</a></span>
			<span id="nextPage"><a>下一页</a></span> <span id="lastPage"><a>尾页</a></span>
			<span id="pageInfo"><span>第</span><b id="curPage">1</b><span>页/共</span><b
				id="pageCount">1</b><span>页</span> </span>
		</div>
		<div class="search_top result_bottom bottom">
			共<b id="totalCount">0</b>条信息
		</div>
	</div>
</body>
<script type="text/javascript" src="${ctxStatic}/weixin/js/jquery-1.7.2.js"></script>
<script type="text/javascript"
	src="${ctxStatic}/weixin/js/jquery.valid.js"></script>
<script type="text/javascript"
	src="${ctxStatic}/weixin/js/jquery.tips.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"
	type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		
		$("#loading").show();
		$.ajax({
			type : "POST",
			url : "${wx}/weixin/user/isBindingBankCard",
			data : {}, //参数自己根据业务定义
			dataType : "json",
			success : function(data) {
				$("#loading").hide();
				if (!data.result) {
					$.MsgBox.Alert("温馨提示", "请先去绑定银行卡,3秒后自动跳转...");
					window.setTimeout(gobindbank, "3000");
				}
			}
		});
		window.gobindbank = function() {
			window.location.href = "${wx}/weixin/userbankinfo/toBindBankCard";
		}
		
		var usernameval = $.trim($("#usernameval").html());
		if (usernameval != null && usernameval != ''
				&& usernameval.length > 8) {
			usernameval = usernameval.substring(0, 7) + "…";
			$("#usernameval").html(usernameval);
		}
		
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
        
		window.cashSave=function() {
			var status='${user.userinfo.status}';
			if(status==null||status==''||status==undefined||status!='2'){
				$("#callCash").tips({
		            side: 3,
		            msg: '请先完成认证',
		            bg: '#00A2E9',
		            time: 4
		        });
		        return false;
			}
			$("#loading").show();
			$("#callCash").hide();
			var cashMoney = $("#cashMoney").val() * 1;
			var cashpassword = $("#cashpassword").val();
			///银行卡信息
			var bankcard ='${user.bankinfo.bankcard}';
			var name ='${user.bankinfo.accountName}';
			var bank ='${user.bankinfo.banktype}';
			var zhihang ='${user.bankinfo.bankname}';
			var bankid = '${user.bankinfo.id}';
			if (bankcard == '' || bankcard  == 'null') {
				$("#bankCard").tips({    
					side : 3,
					msg : '请绑定银行卡！',
					bg : '#AE81FF',
					time : 2
				});
				altmesg();
				return false;
			} 
			if (name == '' || name == 'null') {
				$("#name").tips({
					side : 3,
					msg : '银行卡信息不全，请重新绑定默认银行卡！',
					bg : '#AE81FF',
					time : 2
				});
				altmesg();
				return false;
			} 
			if (bank == '' || bank == 'null') {
				$("#bank").tips({
					side : 3,
					msg : '银行卡信息不全，请重新绑定默认银行卡！',
					bg : '#AE81FF',
					time : 2
				});
				altmesg();
				return false;
			} 
			if (zhihang == '' || zhihang == 'null') {
				$("#zh").tips({
					side : 3,
					msg : '支行信息不全，请重新绑定默认银行卡！',
					bg : '#AE81FF',
					time : 2
				});
				altmesg();
				return false;
			} 
			var totalonline=$("#available").html();
			if (cashMoney <= 0) {
				$("#cashMoney").tips({
					side : 3,
					msg : '提现金额必须大于0元！',
					bg : '#AE81FF',
					time : 2
				});
				altmesg();
				return false;
			}
			if(cashMoney*1>totalonline*1){
	    		$("#cashMoney").tips({
	                side: 3,
	                msg: '可用余额不足',
	                bg: '#00A2E9',
	                time: 4
	            });
	    		altmesg();
	            return false;
	    	}
			
			if (cashpassword == '' || cashpassword == null) {
				$("#cashpassword").tips({
					side : 3,
					msg : '请输入提现密码！',
					bg : '#AE81FF',
					time : 2
				});
				altmesg();
				return false;
			} else {
				var istrue =true;
				/* var istrue = $("#bankCard").valid({
					methods : "required|isBankAccountNumberRe",
					tipSide : "3"
				}); */
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
								msg : '提现密码错误或未设置!',
								bg : '#AE81FF',
								time : 3
							});
						}
					}
				});
				
				if (istrue) {
					
					$.ajax({
						type : "POST",
						url : "${wx}/weixin/user/accountCash",
						data : {
							bankid:bankid,
							payway:consumeway,
							cashMoney : cashMoney,
							passWord : cashpassword
						}, //参数自己根据业务定义
						dataType : "json",
						success : function(data) {
							if (data.state == 1) {
								$("#callCash").show();
								$("#callCash").html("提现成功");
								$("#callCash").unbind();
								window.location.href = "${wx}/weixin/user/toAccountBalance";
							} else {
								$.MsgBox.Alert("温馨提示", data.message);
							}
							window.setTimeout(altmesg, "1000");
						}
					});
				}else{
					altmesg();
				}
					
			}
		};
		window.altmesg = function() {
			$("#callCash").show();
			$("#loading").hide();
			$("#loadtext").html("加载中，请稍等！");
		};

		$(".data_tab div").click(function() {
			var i = $(this).index();
			$(this).addClass("selected");
			$(".data_tab div").not(this).removeClass("selected");
			if (i == 0) {
				$(".data_box0").show();
				$(".data_box1").hide();
			} else {
				$(".data_box1").show();
				$(".data_box0").hide();
			}
		});
		var searchConditions = {};
		searchConditions.pageSize = 10;
		searchConditions.pageNo = 1;
		 searchData(1); 
		var nowpage = 1; ///当前页数
		var nowcount = 1;
		$(window).scroll(
				function() {
					var pageCount = $("#pageCount").html();
					//下面这句主要是获取网页的总高度，主要是考虑兼容性所以把Ie支持的documentElement也写了，这个方法至少支持IE8  
					var htmlHeight = document.body.scrollHeight
							|| document.documentElement.scrollHeight;
					//clientHeight是网页在浏览器中的可视高度，  
					var clientHeight = document.body.clientHeight
							|| document.documentElement.clientHeight;
					//scrollTop是浏览器滚动条的top位置，  
					var scrollTop = document.body.scrollTop
							|| document.documentElement.scrollTop;
					//通过判断滚动条的top位置与可视网页之和与整个网页的高度是否相等来决定是否加载内容；  
					if (scrollTop + clientHeight == htmlHeight) {
						nowpage += 1;
						if (nowpage <= parseInt(pageCount)) {
							searchData(nowpage);
						}

					}
				});
		//查询数据ajax
		function searchData(currentPage) {
			$("#loading").show();
			searchConditions.pageNo = currentPage;
			$
					.ajax({
						type : "POST",
						url : '${wx}/weixin/user/getCashList',
						data : searchConditions,
						dataType : 'json',
						cache : false,
						success : function(data) {
							if (data.value.list!=null) {
								if (data.value.list.length <= 0) {
									$("#data_box")
											.show()
											.append(
													'<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
								} else {
									nowcount = data.value.count;
									$("#pageCount").html(
											Math.ceil(data.value.count
													/ data.value.pageSize));
									$("#curPage").html(searchConditions.pageNo);
									$("#totalCount").html(nowcount);
									var fillDatas = "";
									for ( var i = 0; i < data.value.list.length; i++) {
										fillDatas += fillDataOne(data.value.list[i]);
									}
									$("#data_box").append(fillDatas);
								}
							} else {
								$("#data_box").html("");
								$("#data_box")
										.show()
										.append(
												'<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
								$("#loading").hide();
							}
							$("#loading").css('display', 'none');
							$("#loading").hide();
						}
					});
		}
		function fillDataOne(data) {
			var state = data.consumestatus;
			if (state == 1) {
				state = "提现成功";
			} else if (state == 0||state=='-1'||state==3) {
				state = "处理中";
			} else {
				state = "提现失败";
			}
			var code = data.consumecode != null ? data.consumecode : "----";
			var html = '<div id="data_div" class="data_div" >'
					+ '<div class="data_row data_btm">'
					+ '<div class="flt">流水:'
					+ code
					+ '</div>'
					+ '<div class="frt" style="float:right;"><span class="authened">'
					+ state + '</span></div>' + '</div>'
					+ '<div class="data_row data_btm" style="border:none">'
					+ '<div>金额：￥' + data.consumemony + '元</div>'
					+ '<div class="frt" style="float:right;">'
					+ data.updateDate + '</div>' + '</div></div>';
			return html;
		}
	});
</script>

</html>
