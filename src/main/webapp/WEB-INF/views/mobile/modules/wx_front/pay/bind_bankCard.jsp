<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>

<title>${fns:getConst('SYSTEMTITLE')}--绑定银行卡</title>

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

<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/errorpage.js"></script>
<script>
	var _hmt = _hmt || [];
	(function() {
		var hm = document.createElement("script");
		hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
		var s = document.getElementsByTagName("script")[0];
		s.parentNode.insertBefore(hm, s);
	})();
</script>
<link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/ionic.min.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic }/ionic/css/ionicons.min.css">
<link href="${ctxStatic }/weixin/css/global.css" rel="stylesheet" type="text/css">
<style type="text/css">
/*整体div -top布局*/
.data_top,.data_bottom {
	width: 100%;
	display: block;
	z-index: 2;
	position: fixed;
	background-color: #FFF;
}

.data_top div {
	float: left;
	height: 50px;
	line-height: 50px;
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
	width: 24.5%;
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
	border-bottom: 1px solid #ccc;
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
	background-image: url(./static/images/weixin/pic_bg_normal.png);
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
	font-size: 18px;
	line-height: 25px;
	height: 30px;
	display: -webkit-inline-box;
}

</style>
</head>

<body ng-app="banklist" ng-controller="banklistCtrl">
	<div class="data_box data_box0" id="data_bankinfo">
		<div class="data_title">银行卡信息</div>
		<div class="data_cent">
		   <%-- <div class="ct_lf">
				 <div class="cb_tle">
					持卡人：
				</div>
				<div class="cb_val red" style="font-size:20;font-weight:bold;">
                    <input type="text" style="height:45px;" id="bindname" name="bindname" value="${loginUser.name}" readonly >
				</div> 
			</div>--%>
			<input type="hidden" style="height:45px;" id="bindname" name="bindname" value="${loginUser.name}" readonly >
			<div class="ct_lf">
				<div class="cb_tle">
					账号名：
				</div>
				<div class="cb_val red" style="font-size:20;font-weight:bold;">
					<input id="accountName" name="accountName" type="text"
						style="height:45px;" placeholder="请输入银行卡账号名" />
				</div>
				<!--cb_val end  -->
			</div>
			<div class="ct_lf">
				<div class="cb_tle">
					绑定卡号：
				</div>
				<div class="cb_val red" style="font-size:20;font-weight:bold;">
					<input id="bankcard" name="bankcard" type="text"
						style="height:45px;" placeholder="请输入银行卡号"/>
				</div>
				<!--cb_val end  -->
			</div>
			
			<div class="ct_lf">
				<div class="cb_tle">
					手机号：
				</div>
				<div class="cb_val red" style="font-size:20;font-weight:bold;">
					<input type="text" id="bindphone" style="height:45px;" placeholder="请输入预留手机号"/>
				</div>
			</div>
			<div class="ct_lf" style="padding-top:2px;">
				<div class="cb_tle">所属银行：</div>
				<div class="cb_val"
					style="font-size:20;font-weight:bold;padding-top:3px;">
					<input type="text" id=banktype style="height:45px;" placeholder="选择银行" readonly="readonly"/>
					<span ng-click="showBg1();"><img src='${ctxStatic }/images/weixin/more.png' style="height: 20px;"></span>
				</div>
			</div>
			<div class="ct_lf" style="padding-top:2px;">
				<div class="cb_tle">支行名称：</div>
				<div class="cb_val red"
					style="font-size:20;font-weight:bold;padding-top:3px;">
					<input type="hidden" class="form-control" id="unionpayNo" name="unionpayNo" >
					<input type="text" class="form-control" id="bankname" name="bankname" style="height:45px;" placeholder="选择支行"  readonly="readonly"/>
					<span ng-click="showBg2();"><img src='${ctxStatic }/images/weixin/more.png' style="height: 20px;"></span>
				</div>
			</div>
		
			<div class="ct_lf">
				<div class="cb_tle">提现密码：</div>
				<div class="cb_val red">
					<input type="password" id="password" name="password"
						style="height:45px;width:98%;" placeholder="请输入账户提现密码" />

				</div>
			</div>
			<%-- <c:if test="${userbankinfo.id!=null}">
				<div class="ct_lf">
					<div class="cb_tle">验证码：</div>
					<div class="cb_val red" style="">
						<input type="text" id="txtSmsCode" name="txtSmsCode"
							style="height:45px;" placeholder="" value='' />

					</div>
				</div>
				<div class="ct_lf" style="border-bottom:0px;">
					<div class="cb_tle">&nbsp;</div>
					<div class="cb_val red"
						style="font-size:20;font-weight:bold;padding-top:1px;">
						<input type="button" id="getphCode" value="获取短信验证码">
					</div>
				</div>
			</c:if> --%>
			<!--ct_lf end  -->
		</div>
		<!--data_cent end  -->
		<div id='loading'
			style='width:100%;vertical-align: middle;text-align:center;height:45px'>
			<div>
				<img src='${ctxStatic }/images/weixin/loading-30x30.gif'>
			</div>
			<div style="font-size:14px;font-weight:bold;" id="loadtext">小卓正在努力加载，请稍等!</div>
		</div>
		<!--data_cent end  -->
		<div class="sub_btn" id="bindBtn"
			style="background:rgba(32, 162, 226, 0.87);-moz-border-radius:6px;-webkit-border-radius:6px;border-radius:6px;">绑定</div>
		<div class="data_cent">
			<div style="font-size:20px;margin-top:10px;">绑定须知</div>
			<div class="linediv" style="line-height:15px;font-size:14px;">
				<p>1、一个账户绑定一张银行卡。</p>
				<p>2、确认账户的卡号是否正确。</p>
				<p>3、如有问题，请及时与平台服务联系。</p>
				<p>客户热线：0310-3188756。</p>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="${ctxStatic }/weixin/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/config.js"></script> 
<script type="text/javascript" src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script type="text/javascript">
	$(function() {
		$("#loading").hide();

		/* $("#bankcard").change(function () {
			var bankcard=$("#bankcard").val();
			$.ajax({
		        url: "${wx}/weixin/userbankinfo/getNameByCard",
		        dataType: 'json',
		        type: "post",
		        data : {"cardNo":bankcard},
		        success: function (data) {
		        	if (data.state == 1) {
		        		$("#banktype").val(data.message);
		        	}else{
		        		$("#banktype").val("");
		        	}
		        }
		    });
		}); */

		$("#bindBtn").click(function() {
			var status='${loginUser.userinfo.status}';
			if(status==null||status==''||status==undefined||status!='2'){
				$("#bindBtn").tips({
		            side: 3,
		            msg: '请先完成认证',
		            bg: '#00A2E9',
		            time: 4
		        });
		        return false;
			}
			var istrue = true;
			istrue = istrue && $("#accountName").valid({
		        methods: "required"
		    });
			istrue = istrue && $("#bankcard").valid({
		        methods: "required|isBankAccountNumber"
		    });
			istrue = istrue && $("#bindphone").valid({
		    	methods: "required|isPhone"  
		    });
			istrue = istrue && $("#bankname").valid({
		    	methods: "required"
		    });
			istrue = istrue && $("#banktype").valid({
		    	methods: "required"
		    });
			istrue = istrue && $("#password").valid({
		    	methods: "required"  
		    });
			if (istrue) {
				/* if (banknum != null && banknum != "") {
					istrue = $("#txtSmsCode").valid({
						methods : "required",
						tipSide : "3"
					});
					//同步验证--验证短信验证码是否正确
					$.ajax({
						url : "${wlpt}/wlpt/personal/checkRegCode",
						type : "POST",
						data : {phone:$("#bindphone").val(),regcode:$("#txtSmsCode").val()},
						async : false, ///同步请求传递
						success : function(data) {
							istrue = data;
							if(!data){
								$("#txtSmsCode").tips({
									side : 3,
									msg : '验证码错误或已过期!',
									bg : '#AE81FF',
									time : 3
								});
							}
						}
					}); */
					
					
					//同步验证--验证提现密码是否正确
					$.ajax({
						url : "${wx}/weixin/userbankinfo/checkCashPwd",
						type : "POST",
						data : {cashpassword:$("#password").val()},
						async : false, ///同步请求传递
						success : function(data) {
							istrue = data;
							if(!data){
								$("#password").tips({
									side : 3,
									msg : '提现密码错误!',
									bg : '#AE81FF',
									time : 3
								});
							}
						}
					});
				
			}
			if (!istrue) {
				return;
			} else {
				//var status = '${fns:getUser().userinfo.status}';
				/* $.ajax({
						url : "${pageContext.request.contextPath}/weixin/user/islogined",
						type : "GET",
						data : {},
						async : false, ///同步请求传递
						success : function(data) {
							status = data.status;
						}
					}); */
				//验证是否认证
				/* if (status != $.myConfig.certificateStatus.status) {
					//没有认证
					$("#bindphone").tips({
						side : 3,
						msg : '请先完成认证!',
						bg : '#AE81FF',
						time : 3
					});
					setTimeout(function() {
						window.location.href = "${wx}/weixin/authentication/toAuthentication";
					}, 3000);
				} else { */
					//已认证即绑定银行卡
					$("#loading").show();
					
					$.ajax({
							type : "POST",
							url : "${wx}/weixin/userbankinfo/bankBind",
							data : {
								bankcard : $("#bankcard").val(),
								bindname : $("#bindname").val(),
								bindphone : $("#bindphone").val(),
								bankname : $("#bankname").val(),
								unionpayNo : $("#unionpayNo").val(),
								banktype : $("#banktype").val(),
								accountName :$("#accountName").val(),
								password : $("#password").val()},
							dataType : "json",
							success : function(data) {
								/* if (data.state == '1') {
									$("#loading").hide();
									$("#bindBtn").html("绑定成功");
									$("#bindBtn").unbind();
									$("#bindBtn").css("background","rgba(181, 175, 173, 0.98)");
									window.setTimeout(locationjsp,"3000");
								}  else {
									$("#loadtext").html(data.message);
								}
								window.setTimeout(altmesg,"1000"); */
								if (data.value.state == 1) {
                                    window.location.href = '${wx}/weixin/userbankinfo/toBankList';
                               } else {
                            	   $("#loading").hide();
                            	   $.MsgBox.Alert("保存提示", data.value.message);
                               }
							}
						});
				}
			//}
		});
		window.altmesg = function() {
			$("#bindBtn").show();
			$("#loading").hide();
			$("#loadtext").html("加载中，请稍等！");
		};
		window.locationjsp = function() {
			window.location.href = "${wx}/weixin/user/userHome";
		};

	});
	//===========================================发送短信验证码========================================
	var InterValObj; // timer变量，控制时间
	var count = 60; // 间隔函数，1秒执行
	var curCount;// 当前剩余秒数

	function sendMessage() {
		curCount = count;
		// 设置button效果，开始计时
		$("#getphCode").attr("disabled", "true");
		$("#getphCode").val(curCount + "秒");
		InterValObj = window.setInterval(SetRemainTime, 1000); // 启动计时器，1秒执行一次
	}

	//timer处理函数
	function SetRemainTime() {
		if (curCount == 0) {
			flag = true;
			window.clearInterval(InterValObj);// 停止计时器
			$("#getphCode").removeAttr("disabled");// 启用按钮
			$("#getphCode").val("重新发送验证码");
		} else {
			curCount--;
			$("#getphCode").val(curCount + "秒");
		}
	}

	var ck = true;
	$("#getphCode").click(function() {
		var bindphone = $("#bindphone").val();
		var CODE = "registerSMS";
		ck = ($("#bindphone").valid({
			methods : "required|isPhone"
		}));
		if (ck) {
			$.ajax({
				type : "POST",
				url : '${wlpt}/wlpt/personal/sendRegCode',
				dataType : 'json',
				cache : false,
				async : false,
				data : {
					phone : bindphone
				},
				success : function(data) {
					if (data) {
						$("#phoncode").val(data.tempSmsCode);
						$("#txtSmsCode").tips({
							side : 3,
							msg : "短信验证码已经发送到您的手机！",
							bg : '#AE81FF',
							time : 3
						});
						ck = true;
						sendMessage();
					} else {

						$("#phonecode").val("获取验证码");
						$("#phonecode").tips({
							side : 3,
							msg : '获取验证码！',
							bg : '#AE81FF',
							time : 2
						});

						ck = false;
					}
				}
			});
		}
	});
</script>
	
	
	
	
    <script src="${ctxStatic}/ionic/js/ionic.bundle.min.js"></script>
	<div style="display: none;" id="account_banklist">
		<ion-content >
	   <ion-refresher pulling-text="下拉刷新" on-refresh="doRefresh()"></ion-refresher>
	   <div style="height: 50px;line-height: 50px;">
	   <span style="font-size: 30px;width: 50px;color: #0600ff;padding-left: 5px;padding-right:20px;font-weight: bold;line-height: 30px;height: 30px;" onclick="closeBg();">←</span>
	   <input type="text" placeholder="输入关键字" style="font-size: 15px;line-height: 35px;height: 35px;margin-bottom: 0px;width: 70%;border-bottom: 1px #201e1e solid;" id="searchinfoname" ><b ><img alt="" ng-click="doRefresh()"  src="${ctxStatic }/images/weixin/sc.png" style="vertical-align:middle;"></b> 
	   </div>
		
		<div ng-repeat="x in data">
			<div class="list">
				<div class="item item-header" style="height:45px;">
					<span ng-click="confrimname(x.name)">{{x.name}}</span>
		            <span ng-click="confrimfullname(x.fullName,x.lineNo)">{{x.fullName}}</span>
				</div>
	
			</div>
		</div>	
			<input class = "item" ng-model="pageNo" type="hidden">
			<input class = "item" ng-model="pageSize" type="hidden">  
			<input class = "item" ng-model="pagecount" type="hidden"> 
 		<ion-infinite-scroll ng-if="hasNext()" on-infinite="loadMore()" distance="10%" ></ion-infinite-scroll>
	</ion-content>
	</div>


<script>
function closeBg() {
	 $("#searchinfoname").val("");
     
     $("#data_bankinfo").show();         
     $("#account_banklist").hide();
}
    angular.module("banklist", ['ionic'])
   	.controller('banklistCtrl',['$scope','$timeout','$http', function ($scope,$timeout, $http) {
   		var run = false;
   		var url = "getBankinfoList";
   		$scope.hasMore = true;
 		$scope.count = 0;
		$scope.pageNo= 0;
		$scope.pageSize= 30;
		$scope.data = [];
		
		$scope.showBg1 = function(){                    //定义 showBg1 函数
            var bh = $("body").height();       //获得整个body（浏览器窗口）的高度 并 赋值给 bh 
            var bw = $("body").width();      //获得整个body（浏览器窗口）的宽度 并 赋值给 bw
            $("#fullbg").css({             // 通过 JQ 的css（） 事件，给选中的节点 （“#fullbg”）添加属性
                height: bh,
                width: bw,
                display: "block"
            });
            $scope.data = null;
            $("#searchinfoname").val("");
            url = "getBankinfoList";
            $scope.doRefresh();
            $("#data_bankinfo").hide();         
            $("#account_banklist").show(); 
            
        }

        $scope.showBg2 = function(){                    //定义 showBg1 函数
        	if($("#banktype").val()==""){
        		$("#banktype").tips({
        			side : 3,
        			msg : '请先选择所属银行！',
        			bg : '#00A2E9',
        			time : 3
        		});
        		return false;
        	}
            var bh = $("body").height();       //获得整个body（浏览器窗口）的高度 并 赋值给 bh 
            var bw = $("body").width();      //获得整个body（浏览器窗口）的宽度 并 赋值给 bw
            $("#fullbg").css({             // 通过 JQ 的css（） 事件，给选中的节点 （“#fullbg”）添加属性
                height: bh,
                width: bw,
                display: "block"
            });
            $("#searchinfoname").val("");
            $scope.data = null;
            url = "getBranchBankinfoList";
            $scope.doRefresh();
            $("#data_bankinfo").hide();         
            $("#account_banklist").show(); 
           
        }

        $scope.confrimname = function(name) {
        	$("#banktype").val(name)
        	$("#searchinfoname").val("");
        	$("#bankname").val("");
        	$("#unionpayNo").val("");
        	
            $("#data_bankinfo").show();         
            $("#account_banklist").hide();
        }
        $scope.confrimfullname = function(name,unionpayNo) {
        	$("#bankname").val(name);
        	$("#unionpayNo").val(unionpayNo);
            $("#searchinfoname").val("");
            
            $("#data_bankinfo").show();         
            $("#account_banklist").hide(); 
            
        }
        
     	$http({
    		url:'${wx}/weixin/userbankinfo/'+url,
    		method:'get',
      		params:{
    			'pageSize':$scope.pageSize,
    			'pageNo':1,
    			'keyword':$("#searchinfoname").val(),
                'name':$("#banktype").val()
    		}
    	}).success(function(res){
    		$scope.data = res.list;
    		$scope.count = res.count;
    		$scope.pageNo= res.pageNo;
    		$scope.pageSize= res.pageSize;
    	});
    	
     	
        $scope.doRefresh = function() {            
            $http({
            	url:'${wx}/weixin/userbankinfo/'+url,
            	method:'get',
           		params:{
        			'pageSize':$scope.pageSize,
        			'pageNo':1,
        			'keyword':$("#searchinfoname").val(),
                    'name':$("#banktype").val()
        		}
            }).success(function(res){
            	$scope.data = res.list;
        		$scope.count = res.count;
        		$scope.pageNo= res.pageNo;
        		$scope.pageSize= res.pageSize;
            }).finally(function(){
            	$scope.$broadcast('scroll.refreshComplete');
            	
            });            
        }
        
 		$scope.hasNext = function(){
			$scope.pagecount = $scope.count / $scope.pageSize ;
			/* console.log($scope.pagecount); */
			if($scope.pageNo < $scope.pagecount){
				
				return true;
			}
			else{
				return false;
			}
				
		}  
        
   
         $scope.loadMore = function(){
        	
			if($scope.pageNo == 0){
				$scope.$broadcast('scroll.infiniteScrollComplete');
				return null;
			}
			
			
        	if(!run){
        	run = true	
        	$scope.pageNo++;
        	$http({
        		url:'${wx}/weixin/userbankinfo/'+url,
        		method:'get',
        		params:{
        			'pageNo':$scope.pageNo,
        			'pageSize':$scope.pageSize,
        			'keyword':$("#searchinfoname").val(),
                    'name':$("#banktype").val()
        		}
        	}).success(function(res){
        		run = false;
        		$scope.data = $scope.data.concat(res.list);
        	}).finally(function(){
    			$scope.$broadcast('scroll.infiniteScrollComplete');
        	});
        }
        	
        	

       }  
    }]);
</script>
</body>
</html>
