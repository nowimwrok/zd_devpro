<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<head> 
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>账户充值</title>
<link rel="stylesheet" type="text/css"
	href="/static/modules/wlpt/front/css/personal/count.css">
<style type="text/css">
body {
	padding: 0;
	margin: 0;
	width: 100%;
	margin: 0 auto;
	text-align: center;
	border: 1px solid #D6D3CE;
	font-family: "微软雅黑";
}

ul p span a input td {
	font-family: "微软雅黑";
}

table td {
	text-align: center;
}

table td p {
	line-height: 25px;
}

.icon_blue {
	font-size: 30px;
	font-weight: normal;
	color: #00A2E9;
	font-size: 23px;
	vertical-align: middle;
	display: inline-block;
	cursor: pointer;
	background-color: transparent;
	border: none;
}

.datainit {
	display: none;
}

.count_price {
	padding-left: 0px;
}
.regbt {
            width: 40%;
            height: 85%;
            border: solid 1px;
            border-radius: 0px;
            background-color: #FFC52F;
            border-color: #FFC52F;
            cursor: pointer;
            font-weight: bold;
            text-align: center;
            color: white;
            margin-top: 6px;
            font-size: 12px;
        }
.div1_line1 {
    width: 75%;
    margin: 0 auto;
    text-align: center;
    overflow: hidden;
}
</style>

<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">

<link rel="stylesheet" type="text/css"
	href="${ctxStatic }/modules/wlpt/front/css/personal.css">
<script type="text/javascript">
        $(function () {
            $("#btnExport").click(function () {

                $("#searchForm").attr("action", "${wlpt}/wlpt/consume/export");
                $("#searchForm").submit();
                $("#searchForm").attr("action", "${wlpt}/wlpt/consume/toPurse");

                top.$('.jbox-body .jbox-icon').css('top', '55px');
            });
        });
    </script>

</head>
<body style="height: 1300px;" ng-app="dataHall"
	ng-controller="dataHallCtrl">
	<%--<ul class="count_menu">
    <li class="count_menu_1"><a href="账户充值.html">账户充值</a></li>
    <li><a href="#">担保金充值</a></li>
    <li><a href="授信额度.html">授信额度</a></li>
</ul>--%>
	<ul class="qiye_menu">
		<li data-type="1" class="qiye_menu_1"><a href="${wlpt }/wlpt/consume/toPurse" target="content" style="color: #000;">账户余额</a></li>
		<li data-type="2" ><a href="${wlpt}/wlpt/consume/toTransferCoin" target="content" style="color: #000;">卓币转账</a></li>
		<li data-type="3" ><a href="${wlpt}/wlpt/consume/toTransferPetro" target="content" style="color: #000;">油气转账</a></li>
    <%-- <li data-type="3" ><a href="${wlpt}/wlpt/consume/toPetroRecharge" target="content" style="color: #000;">油气充值</a></li> --%>
		<li data-type="4"><a href="${wlpt}/wlpt/consume/toGueanRecharge" target="content" style="color: #000;">保证金充值</a></li>
	</ul>
	<p class="user_data">
		<img src="/static/images/wlptfront/line-left.png"><span
			class="title_blue">账户</span><span class="title_orange">余额</span><img
			src="/static/images/wlptfront/line-right.png">
	</p>

	<div class="count_div1">
		<c:choose>
		<c:when test="${user.memberId!=null&&user.memberId!=''}">
		<div style="width: 100%;padding-left: 85px;">
		<table cellpadding="0" cellspacing="0" style="margin: auto;width: 60%;margin-bottom: 30px;">
		<tr><td style="text-align: left;"><span class="now_count">平台余额：</span><span id="count_price" class="count_price" style="padding-left: 0px;">￥${not empty user.userPurse.webbalance ? user.userPurse.webbalance:'0.00'}</span>元</td>
		<td style="text-align: left;"><span class="count_state">可用余额：</span><span id="count_green" class="count_green">￥${not empty user.userPurse.availablebalance ? user.userPurse.availablebalance:'0.00'}</span>元</td></tr>
		</table>
		</div>
		<div style="width: 100%;padding-left: 85px;">
		<table cellpadding="0" cellspacing="0" style="margin: auto;width: 80%;margin-bottom: 40px;">
		    <tr>
		    <td style="width: 7%;font-size:14px">电子钱包</td>
		    <td style="text-align: left;width: 12%;"><span class="now_count" style="font-size:14px">账户余额：</span><span id="AwebBalance" class="count_price" style="font-size:10px;padding-left: 0px;"></span></td>
		    <td style="text-align: left;width: 12%;"><span class="count_state" style="font-size:14px">可用余额：</span><span id="AavailableBalance" class="count_green" style="font-size:10px"></span></td>
		    <td style="text-align: left;width: 12%;"><span class="count_state" style="font-size:14px">冻结余额：</span><span id="AfreezeBalance" class="count_green" style="font-size:10px"></span></td>
		    <td style="text-align: left;width: 12%;"><span class="count_state" style="font-size:14px">锁定余额：</span><span id="AlockBalance" class="count_green" style="font-size:10px"></span></td>
		    <!-- <td style="width: 7%;"><input id="flush" class="regbt" type="button" value="刷新"/></td> -->
		    </tr>
		    <tr>
		    <td style="line-height: 40px;font-size:14px">还款户</td>
		    <td style="text-align: left;width: 12%;"><span class="now_count" style="font-size:14px">账户余额：</span><span id="BwebBalance" style="font-size:10px;padding-left: 0px;" class="count_price"></span></td>
		    <td style="text-align: left;width: 12%;"><span class="count_state" style="font-size:14px">可用余额：</span><span id="BavailableBalance" style="font-size:10px" class="count_green"></span></td>
		    <td style="text-align: left;width: 12%;"><span class="count_state" style="font-size:14px">冻结余额：</span><span id="BfreezeBalance" class="count_green" style="font-size:10px"></span></td>
		    <td style="text-align: left;width: 12%;"><span class="count_state" style="font-size:14px">锁定余额：</span><span id="BlockBalance" class="count_green" style="font-size:10px"></span></td>
		    <!-- <td></td> -->
		    </tr>
		    <tr>
		    <td style="font-size:14px">借款户</td>
		    <td style="text-align: left;width: 12%;"><span class="now_count" style="font-size:14px">账户余额：</span><span id="CwebBalance" style="font-size:10px;padding-left: 0px;" class="count_price"></span></td>
		    <td style="text-align: left;width: 12%;"><span class="count_state" style="font-size:14px">可用余额：</span><span id="CavailableBalance" style="font-size:10px" class="count_green"></span></td>
		    <td style="text-align: left;width: 12%;"><span class="count_state" style="font-size:14px">冻结余额：</span><span id="CfreezeBalance" class="count_green" style="font-size:10px"></span></td>
		    <td style="text-align: left;width: 12%;"><span class="count_state" style="font-size:14px">锁定余额：</span><span id="ClockBalance" class="count_green" style="font-size:10px"></span></td>
		    <!-- <td></td> -->
		    </tr>
		</table>
		</div>
		</c:when>
		<c:otherwise>
		<div class="div1_line1">
			<p>
				<span class="now_count">当前账户余额：</span><span class="count_price">￥${not empty user.userPurse.webbalance ? user.userPurse.webbalance:'0.00'}</span>元
			</p>

			<p>
				<span class="count_state">可用余额：</span><span class="count_green">￥${not empty user.userPurse.availablebalance ? user.userPurse.availablebalance:'0.00'}</span>元
			</p>
			<%-- <p>
            <span class="count_state">冻结余额：</span><span class="count_price">${not empty user.userPurse.freezemoney ? user.userPurse.freezemoney:'0.00'}</span>
        </p>--%>
		</div>
		</c:otherwise>
		</c:choose>
		
		
		<p class="div1_line2">
			为了保护你的账户余额安全，请认真阅读《<a target="_blank"
				onclick="openagreement('prepaidAgreement');" class="agreement">卓大物流平台充值服务协议</a>》，如需提现，请致电客服进行申请和审核
		</p>
		<p class="div1_line3">
			<a href="${wlpt}/wlpt/consume/toTransfer"
				class="btn btn-warning bg_blue">转账</a>
			<a href="${wlpt}/wlpt/consume/toCash"
				class="btn btn-warning bg_blue">提现</a>	
			<c:if test="${user.memberId!=null&&user.memberId!=''}">
			<a href="${wlpt}/wlpt/consume/toAccountRecharge"
				class="btn btn-warning bg_blue">充值</a>
		    </c:if>	
		</p>
	</div>
	<p class="user_data">
		<img src="/static/images/wlptfront/line-left.png"><span
			class="title_blue">交易</span><span class="title_orange">记录</span><img
			src="/static/images/wlptfront/line-right.png">
	</p>
	<form:form id="searchForm" modelAttribute="consumerecod"
		action="${wlpt}/wlpt/consume/export" method="post"
		class="breadcrumb form-search " cssStyle="padding: 30px 15px">
		<div class="select_title" style="margin: 0px; padding: 0px;">
			<input type="text" readonly="readonly" class="car_phone_search"
				style="width: 23%" name="beginCreateDate" id="beginCreateDate"
				placeholder="选择开始时间"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"> —— <input
				type="text" readonly="readonly" class="car_phone_search"
				style="width: 23%" name="endCreateDate" id="endCreateDate"
				placeholder="选择结束时间"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"> <select
				id="trademodel" ng-model="trademodel" name="trademodel"
				class="input-medium car_search car_phone_search">
				<option value="" label="全部">全部</option>
				<option value="0">充值</option>
				<option value="1">运单交易</option>
				<option value="2">结算账户</option>
				<option value="3">竞标</option>
				<option value="4">提现</option>
				<option value="5">转账</option>
				<option value="6">卓币</option>
				<option value="7">油气</option>
				<option value="8">保证金</option>
				<option value="9">保险</option>
			</select>
			<button type="button" class="btn btn-warning btn-search"
				ng-click="selectPage(1)">
				<span class="glyphicon glyphicon-search"></span><span
					class="goods_search_btn">搜索</span>
			</button>
			<button class="icon_blue" style="margin: 0px;" id="btnExport">
				<span class="glyphicon glyphicon-open " id="fubu"></span><span
					class="fabu">导出</span>
			</button>
		</div>
	</form:form>

	<table class="goods-manage">
		<thead>
			<tr class="goods_col_1" style="border: none;">
				<td style="width: 11%">标题</td>
				<td style="width: 11%">金额</td>
				<td style="width: 36%; text-align: center">交易描述</td>
				<td style="width: 11%; text-align: center">交易方式</td>
				<td style="width: 11%">状态</td>
				<td style="width: 20%">交易时间</td>
			</tr>
		</thead>
		<tbody class="datainit">
			<tr ng-repeat="x in data">
				<td>{{x.consumetype}}</td>
				<td><span ng-if="x.aftermony-x.beforemony<0"
					style="color: red; font-weight: bold;">-</span> <span
					ng-if="x.aftermony-x.beforemony>0"
					style="color: green; font-weight: bold;">+</span> {{x.consumemony}}
				</td>
				<td style="text-align: left">
					<p>流水:{{x.consumecode}}</p>
					<p>{{x.consumewaydesp}}</p>
				</td>
				<td>{{x.consumeway}}</td>
				<td>{{x.consumestatus}}</td>
				<td>{{x.createDate}}</td>
			</tr>

		</tbody>
	</table>
	<div class="loading">
		<img src="/static/images/loading.gif">
		<p>加载中</p>
	</div>

	<div id="noneData"
		style="display: none; text-align: center; width: 100%; line-height: 25px;">暂无数据</div>

	<div class="paging" id="paging">
		<ul class="pagination pager" id="pagination"
			on-select-page="selectPage(page)">
			<li ng-class="{active: isActive(page)}"><a
				ng-click="selectPage(1)">第一页</a></li>
			<li ng-class="{disabled: noPrevious()}"><a
				ng-click="selectPrevious()">上一页</a></li>
			<li ng-repeat="page in pages" ng-class="{active: isActive(page)}">
				<a ng-click="selectPage(page)">{{page}}</a>
			</li>
			<li ng-class="{disabled: noNext()}"><a ng-click="selectNext()">下一页</a></li>
			<li ng-class="{active: isActive(page)}"><a
				ng-click="selectPage(numPages)">最后一页</a></li>
		</ul>
	</div>
	</div>
	</div>

	<script type="text/javascript" src="/static/jquery/jquery-1.8.3.js"></script>
	<script type="text/javascript" src="${ctxStatic }/common/global.js"></script>
	<script type="text/javascript"
		src="/static/modules/wlpt/front/js/angular/angular.min.js"></script>
	<script
		src="/static/modules/wlpt/front/js/My97DatePicker/WdatePicker.js"></script>
	<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
	<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"
		type="text/javascript"></script>
	<script>
var flag="${flag}";
if(flag=='flag'){
	 $.MsgBox.Alert("转账提示", "只有货主、车主或者企业才可以转账");
}
    var app = angular.module("dataHall", []);
    app.controller('dataHallCtrl', function ($scope, $http) {
        $scope.currentPage = 1;
        $scope.pageSize = 5;
        $scope.pages = [];
        ////isloading ==1:加载数据2:查询不到数据3:查询到数据
        $scope.isloading = function (isloading) {
            if (isloading == 1) {
                $(".loading").show();
                $("#noneData").hide();
            } else if (isloading == 2) {
                $(".loading").hide();
                $("#noneData").show();
                $("#btnExport").hide().attr("disabled","true");
            } else {
                $(".loading").hide();
                $("#noneData").hide();
                $(".datainit").show();
            }
        };
        $scope.exportExcel = function () {
            $http({
                url: '${wlpt}/wlpt/consume/export',
                method: 'post',
                params: {
                    'beginCreateDate': $("#beginCreateDate").val(),
                    'endCreateDate': $("#endCreateDate").val(),
                    'trademodel': $("#trademodel").val(),
                    'pageNo': $scope.currentPage,
                    'pageSize': $scope.pageSize
                }
            }).success(function (response) {

            });
        };
        //get first page
        $http({
            url: '${wlpt}/wlpt/consume/getRecodeList',
            method: 'post',
            params: {
                'beginCreateDate': $("#beginCreateDate").val(),
                'endCreateDate': $("#endCreateDate").val(),
                'trademodel': $("#trademodel").val(),
                'pageNo': $scope.currentPage,
                'pageSize': $scope.pageSize
            }
        }).success(function (response) {
            $scope.data = response.value.list;
            if (!$scope.data) {
                $scope.isloading(2);
            } else {
                $scope.isloading(3);
            }
            $scope.numPages = Math.ceil(response.value.count / response.value.pageSize);
            if ($scope.numPages == 0) {
                $scope.numPages = 1;
            }
            //分页要repeat的数组
            $scope.newPages = $scope.numPages > 5 ? 5 : $scope.numPages;

            for (var i = 0; i < $scope.newPages; i++) {
                $scope.pages.push(i + 1);
            }
        });

        $scope.onSelectPage = function (page) {
            $scope.isloading(1);
            //replace your real data
            $http({
                url: '${wlpt}/wlpt/consume/getRecodeList',
                method: 'post',
                params: {
                    'beginCreateDate': $("#beginCreateDate").val(),
                    'endCreateDate': $("#endCreateDate").val(),
                    'trademodel': $("#trademodel").val(),
                    'pageNo': $scope.currentPage,
                    'pageSize': $scope.pageSize
                }
            }).success(function (response) {
                $scope.data = response.value.list;
                $scope.pages = [];
                if (!$scope.data) {
                    $scope.isloading(2);
                } else {
                    $scope.isloading(3);
                }
                $scope.numPages = Math.ceil(response.value.count / response.value.pageSize);

                if ($scope.numPages == 0) {
                    $scope.numPages = 1;
                }
                $scope.newPages = $scope.numPages > 5 ? 5 : $scope.numPages;
                for (var i = 0; i < $scope.newPages; i++) {
                    var num = $scope.currentPage - 3;
                    if (num < 0) {
                        num = 0;
                    }
                    $scope.pages.push(num + 1);
                }
            });
        };
    });

    app.directive('paging', function () {
        return {
            restrict: 'AEC',
            //scope: {
            //    numPages: '=',
            //    currentPage: '=',
            //    onSelectPage: '&'
            //},
            template: '',
            replace: true,
            link: function (scope, element, attrs) {
                scope.$watch('numPages', function (value) {
                    if (scope.currentPage > value) {
                        scope.selectPage(value);
                    }
                });
                scope.isActive = function (page) {
                    return scope.currentPage === page;
                };
                scope.selectPage = function (page) {
                    //不能小于1大于最大
                    if (page < 1 || page > scope.numPages) return;
                    //最多显示分页数5
                    if (page > 2) {
                        //因为只显示5个页数，大于2页开始分页转换
                        var newpageList = [];
                        for (var i = (page - 3); i < ((page + 2) > scope.numPages ? scope.numPages : (page + 2)); i++) {
                            newpageList.push(i + 1);
                        }
                        scope.pages = newpageList;
                    }
                    if (page == 1) {
                        scope.pages = [];
                        for (var k = 0; k < scope.newPages; k++) {
                            scope.pages.push(k + 1);
                        }
                    }


                    if (!scope.isActive(page) || page == 1) {
                        scope.currentPage = page;
                        scope.onSelectPage(page);
                    }
                };
                scope.selectPrevious = function () {
                    if (!scope.noPrevious()) {
                        scope.selectPage(scope.currentPage - 1);
                    }
                };
                scope.selectNext = function () {
                    if (!scope.noNext()) {
                        scope.selectPage(scope.currentPage + 1);
                    }
                };
                scope.noPrevious = function () {
                    return scope.currentPage == 1;
                };
                scope.noNext = function () {
                    return scope.currentPage == scope.numPages;
                };

            }
        };


    });
    
    $("#flush").click(function () {
    	click();
    });
    var memberId="${user.memberId}"
    if(memberId!=null&&memberId!=""){
    	click();
    }
    function click(){
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
	            			   var webbalance=slaveAccounts[i].availableBalance+slaveAccounts[i].lockBalance+slaveAccounts[i].freezeBalance+slaveAccounts[i].undeterminedBalance;
	            			   webbalance = xround(webbalance, 2);
	            			   var availableBalance=slaveAccounts[i].availableBalance;
                               var freezemoney=slaveAccounts[i].freezeBalance;
	            			   $("#AwebBalance").html(webbalance);
			                   $("#AavailableBalance").html(availableBalance);
			                   $("#AfreezeBalance").html(freezemoney);
			                   var lockBalance=slaveAccounts[i].lockBalance;
			                   $("#AlockBalance").html(lockBalance);
			                   
			                  /*  $("#count_price").html(webbalance);
			                   $("#count_green").html(availableBalance); */
			                  /*  $.ajax({
			       	            url: "${wlpt}/wlpt/consume/flushWeb",
			       	            dataType: 'json',
			       	            data:{"webbalance":webbalance,"availablebalance":availableBalance,"freezemoney":freezemoney},
			       	            type: "post",
			       	            success: function (data) {
			       	            	
			       	            }
			                   }); */
	            		   }
	            		   if(slaveAccounts[i].accountType==1){
	            			   var BwebBalance=slaveAccounts[i].availableBalance+slaveAccounts[i].lockBalance+slaveAccounts[i].freezeBalance+slaveAccounts[i].undeterminedBalance;
	            			   BwebBalance=xround(BwebBalance, 2);
	            			   $("#BwebBalance").html(BwebBalance);
			                   $("#BavailableBalance").html(slaveAccounts[i].availableBalance); 
			                   $("#BfreezeBalance").html(slaveAccounts[i].freezeBalance);
			                   var lockBalance=slaveAccounts[i].lockBalance;
			                   $("#BlockBalance").html(lockBalance);
	            		   }
	            		   if(slaveAccounts[i].accountType==2){
	            			   var CwebBalance=slaveAccounts[i].availableBalance+slaveAccounts[i].lockBalance+slaveAccounts[i].freezeBalance+slaveAccounts[i].undeterminedBalance;
	            			   CwebBalance=xround(CwebBalance, 2);
	            			   $("#CwebBalance").html(CwebBalance);
			                   $("#CavailableBalance").html(slaveAccounts[i].availableBalance);
			                   $("#CfreezeBalance").html(slaveAccounts[i].freezeBalance);
			                   var lockBalance=slaveAccounts[i].lockBalance;
			                   $("#ClockBalance").html(lockBalance);
	            		   }
	            	   }
	            	   
	               }
	            }
	    });
    }
</script>
</body>
</html>
