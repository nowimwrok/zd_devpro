<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
<title>竞价</title>
<link rel="stylesheet" href="${ctxStatic}/front/css/flipclock.css">
<style type="text/css">
	/*删除ie自带的删除功能*/
	.error::-ms-clear{display:none;}
   	.clock{width:100%;padding:0;height:30px;width:323px;position:absolute;top:0;left:0;}
   	.flip-clock-wrapper{margin:0;}
   	.flip-clock-divider .flip-clock-label{display:none}
   	.flip-clock-wrapper ul{width:30px;height:32px;font-size:16px;margin:2px;}
   	.flip-clock-divider.hours,.flip-clock-divider.seconds,.flip-clock-divider.minutes{width:10px;height:38px;}
   	.flip-clock-dot{width:7px;height:7px;left:0;top:9px;}
   	.flip-clock-dot.top{top:19px;}
   	.flip-clock-wrapper ul li a div div.inn{font-size:26px;background-color:#eb3b50;color:#fff;}
   	.flip-clock-wrapper ul li{line-height:32px;}
   	.flip-clock-wrapper ul li a div.up:after{top:15px;}
   	/*显示天*/
   	.flip-clock-divider.days .flip-clock-label{display:block;top:5px;right:-93px;font-size:20px;}
   	.flip-clock-divider.hours .flip-clock-dot.bottom,.flip-clock-divider.hours .flip-clock-dot.top{display: none;}
   	.flip-clock-divider.hours{margin-left:20px;}
</style>
</head>
<body style="background: #f5f5f5;">
	<div class="row">
        <div class="col-lg-12" style="padding-bottom:50px;">
        	<div class="col-sm-12 clearfix offer bid" style="background-color:#fff;">
        		<ul class="list-group clearfix flow">
        			<li class="list-group-item pull-left text-center">
        				<div class="flow_content">
        					<p><img src="${ctxStatic}/front/img/offer_bid_sure.png" alt="" /></p>
        					<div class="text active">竞标</div>
        					<div class="flow_line"></div>
        				</div>
        			</li>
        			<li class="list-group-item pull-left text-center">
        				<p><img src="${ctxStatic}/front/img/offer_zb.png" alt="" /></p>
        				<div class="text">中标</div>
        				<div class="flow_line"></div>
        			</li>
        			<li class="list-group-item pull-left text-center">
        				<p><img src="${ctxStatic}/front/img/offer_ht.png" alt="" /></p>
        				<div class="text">签订合同</div>
        				<div class="flow_line"></div>
        			</li>
        			<li class="list-group-item pull-left text-center">
        				<p><img src="${ctxStatic}/front/img/offer_car.png" alt="" /></p>
        				<div class="text">运输</div>
        				<div class="flow_line"></div>
        			</li>
        			<li class="list-group-item pull-left text-center">
        				<p><img src="${ctxStatic}/front/img/offer_account.png" alt="" /></p>
        				<div class="text">结算</div>
        			</li>
        		</ul>
        		
        	</div>
        	<div class="col-sm-12 offer_detail" style="padding:0;" ng-app="bidding" ng-controller="biddingCtrl">
        		<div class="form_container">
                	<!--第三个面板-->
                	<div class="col-sm-6 offer_detail_l" style="padding-left:0;">
                		<div class="panel clearfix">
	                		<h4 class="panel-heading">
	                			竞价信息
	                		</h4>
	                		<div class="col-sm-10 form-horizontal form-addr">
	                			<div class="form-group col-sm-12 has-unit">
	                				<div class="col-sm-5 control-label text-right">
	                					拦标价：
	                				</div>
	                				<div class="col-sm-7 control-label" style="text-align:left;">
	                					<c:choose>
			                                <c:when test='${not empty bidinfo.expectedprice}'>
			                                    <span style="color:#EB3B50;padding-right:20px;" class="money_n">${bidinfo.expectedprice}</span>元/吨
			                                </c:when>
			                                <c:otherwise>暂未限制</c:otherwise>
			                            </c:choose>
	                					
	                				</div>
	                			</div>
	                			<div class="form-group col-sm-12 has-unit">
	                				<div class="col-sm-5 control-label text-right">
	                					我的竞价：
	                				</div>
	                				<div class="col-sm-6 text-left">
	                					<input type="text" class="form-control" id="biddingprice" ng-model="biddingprice" 
	                					name="biddingprice" oninput="priceCount()" />
	                					<i class="unit">元/吨</i>
	                				</div>
	                			</div>
	                			<div class="form-group col-sm-12">
	                				<div class="col-sm-5 control-label text-right">
	                					总价：
	                				</div>
	                				<div class="col-sm-6 text-left  " style="padding-top:7px;" >
	                					<span id="totalprices" style="padding-right:20px;"  class="text-primary money_n">0</span><i class="unit">元</i>
	                					
	                				</div>
	                			</div>
	                			<div class="col-sm-12 checkbox text-center">
									<label for="checkbox1">
										<input type="checkbox" id="chkCondition" checked="checked"/>请仔细阅读
										<span class="text text-primary" style="font-size:15px;" onclick="openagreement('biddings');" >《竞价协议》</span>
									</label>
								</div>
	                			<div class="col-sm-3"></div>
	                			<div class="col-sm-7">
	                				<button class="btn btn-block btn-primary" id="saveBtn" style="letter-spacing:1px;margin-top:20px;" ng-click="saveBtn()">提交并同意《竞价协议》</button>
	                			</div>
	                		</div>
                		</div>
                	</div>
                	<!---->
                	<div class="col-sm-6 offer_detail_r" style="padding-right:0;">
                		<div class="panel clearfix">
	                		<h4 class="panel-heading">
	                			货源信息
	                		</h4>
	                		<div class="col-sm-10 form-horizontal form-addr">
	                			<div class="form-group col-sm-12">
	                				<div class="col-sm-5 control-label text-right">
	                					倒计时：
	                				</div>
	                				
	                				<div class="col-sm-7">
	                					<div class="col-sm-12 clock">
	                					</div>
				                        <%-- <c:if test="${bidinfo.bidstatus!='已截标'}">
			                                <span style="font-size:21px;font-weight:bold;" id="endtimes" ></span>
			                            </c:if>
			                            <c:if test="${bidinfo.bidstatus=='已截标'}">
			                                <span style="font-size:21px;font-weight:bold;" id="endtimes"> 0 + "天" + 0 + "时" + 0 + "分" + 0 + "秒"</span>
			                            </c:if> --%>
	                					<input type="hidden" name="ENDTIME" id="endtime" value="${bidinfo.endtimeFM}"/>
	                				</div>
	                			</div>
	                			<!-- <div class="form-group col-sm-12">
	                				<div class="col-sm-5 control-label text-right">
	                					招标文号：
	                				</div>
	                				<div class="col-sm-7 control-label" style="text-align:left;">
	                					ZB2017080798840001
	                				</div>
	                			</div> -->
	                			<div class="form-group col-sm-12">
	                				<div class="col-sm-5 control-label text-right">
	                					货物名称：
	                				</div>
	                				<div class="col-sm-7 control-label" style="text-align:left;">
	                					${bidinfo.goods.goodsname}
	                				</div>
	                			</div>
	                			<div class="form-group col-sm-12">
	                				<div class="col-sm-5 control-label text-right">
	                					招标量：
	                				</div>
	                				<div class="col-sm-7 control-label" style="text-align:left;">
	                					<span id="loadweight">${bidinfo.goods.freightvolume}</span>${bidinfo.goods.freightunit}
	                				</div>
	                			</div>
	                			<div class="form-group col-sm-12">
	                				<div class="col-sm-5 control-label text-right">
	                					<i class="offer_addr offer_addr_b"></i>
	                				</div>
	                				<div class="col-sm-7 control-label" style="text-align:left;">
	                					${bidinfo.goods.shipAddress.province} ${bidinfo.goods.shipAddress.city} ${bidinfo.goods.shipAddress.district}
	                				</div>
	                			</div>
	                			<div class="form-group col-sm-12">
	                				<div class="col-sm-5 control-label text-right">
	                					<i class="offer_addr offer_addr_r"></i>
	                				</div>
	                				<div class="col-sm-7 control-label" style="text-align:left;">
	                					${bidinfo.goods.consignAddress.province} ${bidinfo.goods.consignAddress.city} ${bidinfo.goods.consignAddress.district}
	                				</div>
	                			</div>
	                			<div class="form-group col-sm-12">
	                				<div class="col-sm-5 control-label text-right">
	                					发布时间：
	                				</div>
	                				<div class="col-sm-7 control-label" style="text-align:left;">
	                					<span id="sendtime">
			                            <fmt:formatDate value="${bidinfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
			                            </span>
	                				</div>
	                			</div>
	                			<div class="form-group col-sm-12 tuoyun">
	                				<div class="col-sm-5 control-label text-right">
	                					招标方：
	                				</div>
	                				<div class="col-sm-7 control-label" style="text-align:left;">
	                					${bidinfo.biduser.loginName}<em></em>
	                					<i></i>
	                					<span></span>
	                				</div>
	                			</div>
	                		</div>
                		</div>
                	</div>
                	<!--竞价须知-->
                	<div class="col-sm-12 bid_notice" style="padding:0;">
                		<div class="panel clearfix" style="margin-bottom:10px;">
	                		<h4 class="panel-heading">
	                			竞价须知
	                		</h4>
	                		<div class="col-sm-12" style="padding-bottom:15px;">
	                			<h4 class="col-sm-12">本标要求</h4>
	                			<h5 class="col-sm-12">1.投标准入</h5>
	                			<p class="col-sm-12">1.1招标人准入资格</p>
	                			<p class="col-sm-12">&nbsp;（1）、合法经营的企业</p>
	                			<p class="col-sm-12">&nbsp;（2）、注册卓大物流平台账号并提交真实姓名、手机号、身份证号、营业执照照片进行认证，获得平台认证通过</p>
	                			<p class="col-sm-12">1.2投标人准入资格</p>
	                			<p class="col-sm-12">&nbsp;（1）、拥有足够承担物流货运运输能力的车辆</p>
	                			<p class="col-sm-12">&nbsp;（2）、注册卓大物流平台账号并提交真实姓名、手机号、身份证号、营业执照照片进行认证，获得平台认证通过</p>
	                			<p class="col-sm-12">&nbsp;（3）、在平台缴纳10元以上的竟标保证金</p>
	                			<h4 class="col-sm-12">2.定标管理</h4>
	                			<h5 class="col-sm-12">2.1定标权限</h5>
	                			<p class="col-sm-12">&nbsp;（1）、招标方拥有对所有投标人员的定标管理权限，可以自行选定中标方</p>
	                			<p class="col-sm-12">&nbsp;（2）、当投标人员不超过2人时，招标方可以进行废标处理，另行安排招标或自行安排运输</p>
	                			<p class="col-sm-12">&nbsp;（3）、当投标价格均超过拦标价时，招标方可进行废标处理，另行安排招标或自行安排运输</p>
	                			<h5 class="col-sm-12">2.2定标影响因素</h5>
	                			<p class="col-sm-12">招标方根据如下因素进行选标：</p>
	                			<p class="col-sm-12">&nbsp;（1）、投标价格</p>
	                			<p class="col-sm-12">&nbsp;（2）、平台信誉</p>
	                			<p class="col-sm-12">&nbsp;（3）、平台押金数额</p>
	                			<p class="col-sm-12">&nbsp;（4）、平台交易流水</p>
	                		</div>
                		</div>
                	</div>
                	<!---->
                </div>
        	</div>
        </div>
	</div>
<script src="${ctxStatic}/front/js/flipclock.js?id=1" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/common/global.js"></script>
<script>
$(document).ready(function(){
	$("#maskloading", parent.document).hide();//code
});

var app = angular.module('bidding', []);
var isDerate=false;
app.controller('biddingCtrl', function ($scope, $http) {
    $scope.freightvolume =${bidinfo.goods.freightvolume};
    $scope.biddingprice = 0;

    $http({
        url: "${wlpt}/wlpt/bid/isDerate",
        method: 'post',
        params: {}
    }).success(function (data) {
        if (data) {
        	isDerate=true;
        }
    });
    
    ///招标ID
    var bidinfo_id = "${bidinfo.id}";
    ///拦标价
    var expectedprice = "${bidinfo.expectedprice}";
	var isderate="0";

    $scope.saveBtn = function () {
        if (!priceCount()) {
            return;
        }
        if($("#maskloading", parent.document).is(':hidden')){
        	
        }else{
            return false;
        }
        if(isDerate){
            $.MsgBox.Confirm("交易提示","您有减免保证金的资格,是否使用?",function(){
            	$("#maskloading", parent.document).show();
            	isderate="1";
                settotl();
                saveBidding();
            },function(){
            	saveBidding();
            },"是","否");
        }else{
        	$("#maskloading", parent.document).show();
        	saveBidding();
        }
        

    };
    window.saveBidding=function (){
        $http({
            url: "${wlpt}/wlpt/bid/saveBidding",
            method: 'post',
            params: {biddingprice: $("#biddingprice").val(), "bidinfo.id": bidinfo_id,isderate : isderate}
        }).success(function (data) {
        	$("#maskloading", parent.document).hide();
            $.MsgBox.Alert("保存提示", data.message);
            if (data.state == 1) {
            	window.location.href = "${wlpt}/wlpt/personal/home_index";
            } else {
                $scope.biddingprice = 0;
            }
        });
    };
    ///计算价格
    window.priceCount = function () {
        var price = $("#biddingprice").val();
		
        if (!$("#chkCondition").is(':checked')) {
        	self_fun("#chkCondition",'请勾选竞价协议',true);
            return false;
        }else{
        	self_fun("#chkCondition",'',false);
        }


        var loadweight = $("#loadweight").html();
        if (price != '' && isNum($("#biddingprice"))) {
        	self_fun("#biddingprice",'',false);
            var ex = /^\d+$/;

            if (parseFloat(price) > parseFloat(expectedprice)) {
                self_fun("#biddingprice",'您的价格已高于拦标价',true);
                return false;
            } else if (!checkPrice(price)) {
                self_fun("#biddingprice",'请输入正确的价格',true);
                return false;
            } else {
                var temp = parseFloat(price) * parseFloat(loadweight) + '';
                var totalConst = "";
                if (temp.indexOf(".") != -1
                        && temp.split(".")[1].length > 2) {
                    totalConst += temp.split(".")[0] + "."
                            + temp.split(".")[1].substring(0, 2);
                } else {
                    totalConst += temp;
                }
                $("#totalprices").html(totalConst);
                self_fun("#biddingprice",'',false);
                return true;
            }
        } else {
            self_fun("#biddingprice",'请输入正确信息',true);
            return false;
        }
    };
    priceCount();

    window.settotl= function (){

        var price = $("#biddingprice").val()*1;
        var loadweight = $("#loadweight").html()*1;
        var temp = parseFloat(price) * parseFloat(loadweight) + '';
        var totalConst = "";
        if (temp.indexOf(".") != -1
                && temp.split(".")[1].length > 2) {
            totalConst += temp.split(".")[0] + "."
                    + temp.split(".")[1].substring(0, 2);
        } else {
            totalConst += temp;
        }
        $("#totalprices").html(totalConst);
    };

     //倒计时
	var clock;
	$(document).ready(function() {
		var EndTime = new Date($("#endtime").val());
        var NowTime = new Date();
        var t = EndTime.getTime() - NowTime.getTime();
        var d = 0;
        var h = 0;
        var m = 0;
        var s = 0;
        var timetext=0;
        if (t >= 0) {
            d = Math.floor(t / 1000 / 60 / 60 / 24);
            h = Math.floor(t / 1000 / 60 / 60 % 24);
            m = Math.floor(t / 1000 / 60 % 60);
            s = Math.floor(t / 1000 % 60);
            timetext = d+""+h+""+m+""+s;
        }
		var clock;
		clock = $('.clock').FlipClock({
			clockFace: 'DailyCounter',
			autoStart: false,
			callbacks: {
			    //回调函数
			}
		});    
		clock.setTime(t/1000);
		clock.setCountdown(true);//true为倒计时 false为计时
		clock.start();
	});
	 
/* 
    function GetRTime() {
        var EndTime = new Date($("#endtime").val());
        var NowTime = new Date();
        var t = EndTime.getTime() - NowTime.getTime();
        var d = 0;
        var h = 0;
        var m = 0;
        var s = 0;
        if (t >= 0) {
            d = Math.floor(t / 1000 / 60 / 60 / 24);
            h = Math.floor(t / 1000 / 60 / 60 % 24);
            m = Math.floor(t / 1000 / 60 % 60);
            s = Math.floor(t / 1000 % 60);
        }

        $("#endtimes").html(d + "天" + h + "时" + m + "分" + s + "秒");

    }

    setInterval(GetRTime,0); */

    //格式化时间
    function FormatDate(strTime) {
        var str = strTime.split(":");
        return str[0] + ":" + str[1];
    }

    //校验数字
    function isNum(obj) {
        var n = $(obj).val();
        if (n != '' && (isNaN(n) || parseInt(n) == 0 || parseInt(n) < 0)) {
            
            self_fun(obj,'请输入正数',true);
            $(obj).val('');
            return false;
        }else{
        	self_fun(obj,'',false);
        }
        
        return true;
    }

    //格式数字后面的0
    function geShi(num) {
        if (num != null && num != "") {
            return parseFloat(num);
        } else {
            return "--";
        }
    }


    function checkPrice(price) {
        return (/^(([1-9]\d*)|\d)(\.\d{1,2})?$/).test(price.toString());
    }

    $("#loadweight").html(geShi($("#loadweight").html()));
    //格式化数量

    
    function self_fun(id,msg,status){
		//input 绑定监听
			var length=$(id).parent().find('span').length;
			if(status==true){
				$(id).next().find('span').remove();
				var error_span='<span style="color:#a94442;font-size:13px;display:inline-block;margin-top:10px;">'+msg+'</span>';
				var icon_remove='';
				
				if(length==0){
					$(id).parent().append(icon_remove);
					$(id).parent().append(error_span);
				}
				$(id).css('border-color','#e94c3c').css('box-shadow','0 0 10px rgba(233,76,60,.3)').css('-webkit-box-shadow','0 0 10px rgba(233,76,60,.3)').css('-moz-box-shadow','0 0 10px rgba(233,76,60,.3)').css('-o-box-shadow','0 0 10px rgba(233,76,60,.3)');
				//删除ie自带删除图标
				$(id).addClass('error');
			}
			else if(status==false){
				$(id).parent().find('span').remove();
				//删除ie自带删除图标
				$(id).addClass('error');
				if(length==0){
					var icon_ok='';
					$(id).parent().append(icon_ok);
				}
			}
	}

});
	
	
	var w = document.documentElement.clientWidth;
    if(w<1010){
    	$('.row').css('width','1010px').css('background-color','#fff').css('overflow-x','hidden').css('overflow-y','hidden');
    	$('.data-model').css('height','55px').find('.col-sm-2').css('margin-right','1%');
    }
    //去掉 input 聚焦时 有阴影
    $('input').focus(function(){
    	$(this).css('box-shadow','none').css('border-bottom-color','#9b9b9b');
    });
    //报价信息和货源信息高度
    var r_h=$('.offer_detail_r').height();
    $('.offer_detail_l .panel').height(r_h+'px');
    $('.money_n').each(function(){
		var s=$(this).text();
		n=2;  
		s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + "";   
		var l=s.split(".")[0].split("").reverse(),   
		r=s.split(".")[1];   
		t="";   
		for(i=0;i<l.length;i ++ )   
		{t+=l[i]+((i + 1)%3==0&&(i+1)!=l.length ? "," : "");}
	    var num=t.split("").reverse().join("") + "." + r;//整个数字
	    $(this).text(num);
	});
</script>
</body>
</html>