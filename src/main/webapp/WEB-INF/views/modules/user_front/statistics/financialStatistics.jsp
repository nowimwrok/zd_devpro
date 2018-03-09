<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp" %>
    <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <link rel="stylesheet"
          href="${ctxStatic}/modules/wlpt/front/css/analysis/global.css"/>
    <title>卓大物流平台</title>
</head>
<body style="background: #f5f5f5;">
    <div class="row" style="background-color:#fff;" ng-app="dataHall" ng-controller="dataHallCtrl">
        <div class="col-lg-12" style="background-color:#fff;">
        	<div class="col-sm-12 clearfix data_fx">
        		<!--支出分析-->
        		<div class="col-sm-6">
        			<div class="col-sm-12">
        				<h4 class="title">支出分析</h4>
        				<h5>支出业务报表分析</h5>
        				<!--折线图-->
	        			<div class="col-sm-12 data_pay" style="">
	        				<div class="col-sm-12" id="data_pay" style="height:300px;padding:0;"></div>
	        			</div>
        				<!--统计-->
	        			<div class="col-sm-12 count">
	        				<div class="col-sm-4 text-center">
	        					<h3 id= "pay_totalmoney">￥0.00</h3>
	        					<h5>共支出</h5>
	        				</div>
	        				<div class="col-sm-7">
	        					<div class="col-sm-12 clearfix count_r">
	        						<h2 class="text-left pull-left" id="print_count">0</h2>
	        						<div class="pull-right">
	        							<h4 style="margin-top:15px;">打印单据</h4>
	        							<h5>（单）</h5>
	        						</div>
	        					</div>
	        					<div class="col-sm-12 clearfix count_r">
	        						<h2 class="text-left pull-left"  id="print_mony">0.00</h2>
	        						<div class="pull-right">
	        							<h4>打印费用</h4>
	        							<h5>（元）</h5>
	        						</div>
	        					</div>
	        				</div>
	        			</div>
        			</div>
        		</div>
        		
        		<!--收入分析-->
        		<div class="col-sm-6 income_data parent_line">
        			<div class="col-sm-12" style="padding:0;">
        				<h4 class="title">收入分析</h4>
        				<h5>收入业务报表分析</h5>
        				<div class="col-sm-12 income_line"></div>
        				<!--进度条统计-->
        				<!--1-->
        				<div class="col-sm-12 income_fc" id="recharge">
        					<div class="col-sm-12 clearfix">
        						<p class="pull-left"><span>0%</span>账户充值</p>
        						<p class="pull-right text-primary">￥0.00</p>
        					</div>
        					<div class="col-sm-12">
        						<div class="progress ">
        							<div class="progress-bar progress-bar-striped active"></div>
    							</div>
        					</div>
        				</div>
        				<!--2-->
        				<div class="col-sm-12 income_fc" id = "orderpay">
        					<div class="col-sm-12 clearfix">
        						<p class="pull-left"><span>0%</span>运费结算</p>
        						<p class="pull-right text-success">￥0.00</p>
        					</div>
        					<div class="col-sm-12">
        						<div class="progress ">
        							<div class="progress-bar progress-bar-striped active progress-bar-success"></div>
    							</div>
        					</div>
        				</div>
        				<!--3-->
        				<div class="col-sm-12 income_fc" id = "orderback">
        					<div class="col-sm-12 clearfix">
        						<p class="pull-left"><span>0%</span>运费返款</p>
        						<p class="pull-right" style="color:#f0ad4e;">￥0.00</p>
        					</div>
        					<div class="col-sm-12">
	        					<div class="progress ">
        							<div class="progress-bar progress-bar-striped active progress-bar-warning"></div>
    							</div>
        					</div>
        				</div>
        				<!--4-->
        				<div class="col-sm-12 income_fc" id = "accounttransfer">
        					<div class="col-sm-12 clearfix">
        						<p class="pull-left"><span>0%</span>收到转账</p>
        						<p class="pull-right text-danger">￥0.00</p>
        					</div>
        					<div class="col-sm-12">
        						<div class="progress ">
        							<div class="progress-bar progress-bar-striped active progress-bar-danger"></div>
    							</div>
        					</div>
        				</div>
        				<!--统计-->
	        			<div class="col-sm-12 count">
	        				<div class="col-sm-4 text-center">
	        					<h3 id = "income_totalmoney">￥0.00</h3>
	        					<h5>共收入</h5>
	        				</div>
	        				<div class="col-sm-1"></div>
	        				<div class="col-sm-7 income_count">
	        					<div class="col-sm-12">
	        						<h4>竞标押金</h4>
	        						<div class="col-sm-12 clearfix">
	        							<h2 class="text-left pull-left" id="bid_mony">0.00</h2><h5 class="pull-left">（元）</h5>
	        						</div>
	        					</div>
	        				</div>
	        			</div>
        			</div>
        		</div>
        		<!--财务概览-->
        		<div class="col-sm-6 finance parent_line">
        			<div class="col-sm-12" style="padding:0;">
        				<h4 class="title">财务概览</h4>
        				<h5>财务报表分析</h5>
        				<div class="col-sm-12 income_line"></div>
        				<!--环形图-->
	        			<div class="col-sm-12 data_finance" style="">
	        				<div class="col-sm-7" style="padding:0;height:300px;" id="data_finance"></div>
	        				<div class="col-sm-5" style="padding:0;">
	        					<ul class="col-sm-12 clearfix finance_list" id="data_ul">
	        						<li class="clearfix data_list">
	        							<p class="pull-left"><span></span>运费支出</p>
	        							<div class="pull-right">￥0.00</div>
	        						</li>
	        						
	        					</ul>
	        				</div>
	        			</div>
	        			<!--线-->
	        			<div class="col-sm-12">
	        				<div class="col-sm-12 income_line"></div>
	        			</div>
        				<!--统计-->
        				<div class="col-sm-12">
        					<div class="col-sm-6 clearfix finance_count">
        						<div class="pull-left">
        							<h4>入账</h4>
        							<h5 id="income_data_mony">￥0.00</h5>
        						</div>
        						<div class="pull-right">
        							<img src="${ctxStatic}/front/img/column_blue.png" alt=""/>
        						</div>
        					</div>
        					<div class="col-sm-6 clearfix finance_count">
        						<div class="pull-left">
        							<h4>出账</h4>
        							<h5 id="pay_data_mony">￥0.00</h5>
        						</div>
        						<div class="pull-right">
        							<img src="${ctxStatic}/front/img/column_red.png" alt=""/>
        						</div>
        					</div>
        				</div>
        			</div>
        		</div>
        		
        		<!--应收-->
        		<div class="col-sm-6 parent_line receive">
        			<div class="col-sm-12" style="padding:0;">
        				<div class="col-sm-12 clearfix" style="padding:0;">
        					<div class="pull-left">
        						<h4 class="title">应收</h4>
        						<h5>运单业务未结算业务数据</h5>
        					</div>
        					<div class="pull-right">
        						<p ng-cloak class="list_num text-center"><span class="text-success">{{bOrderNum}}</span>单</p>
        					</div>
        				</div>
        				<!--统计-->
        				<div class="col-sm-12 list_parent_all">
        					<div>
	        					<div class="col-sm-12 list_parent" ng-repeat="x in data">
		        					<div class="col-sm-12 list_all">
		        						<ul class="col-sm-12">
		        							<li class="pull-left">
		        								<img src="${ctxStatic}/front/img/data_file.png" alt="" class="data_file_img"/>
		        							</li>
		        							<li class="pull-left">
		        								<h4 ng-cloak>{{x.username!=null?x.username:x.phone}}
													<img ng-cloak src="${ctxStatic}/front/img/per_phone.png" title="手机号码：{{x.phone}}" class="phone_hover"/>
													<div class="per_warning">
														<span>手机号码：{{x.phone}}</span>
														<p><a href="" class="text text-primary">管理</a></p>
													</div>
												</h4>
		        								<h5>待结算运单<span ng-cloak class="text-danger">{{x.evercout}}</span>单</h5>
		        							</li>
		        							<li class="pull-right">
		        								<span ng-cloak>￥{{x.alltradmy | number : 2}}</span>
		        							</li>
		        						</ul>
		        					</div>
	        					</div>
        					</div>
        					
        					<div id="noneData" style="display:none;text-align: center;width: 100%;line-height: 25px;">
	                        	<img src="${ctxStatic }/front/img/nodata.png" style="width: 100px;height: 100px;">
		                    </div>
		                    <!--分页-->
		                    <div>
	           					<tm-pagination conf="paginationConf"></tm-pagination>
	           				</div>
        					
        				</div>
        				
        				
        				
	            				
        			</div>
        			<!--合计 定位-->
        			<div class="col-sm-12 total_num bg-danger">
        				<p class="pull-left">合计：</p>
        				<p ng-cloak class="pull-right">￥{{bOrderMony | number : 2}}</p>
        			</div>
        		</div>
        		
        		<!--应付-->
        		<div class="col-sm-6 parent_line receive">
        			<div class="col-sm-12" style="padding:0;">
        				<div class="col-sm-12 clearfix" style="padding:0;">
        					<div class="pull-left">
        						<h4 class="title">应付</h4>
        						<h5>运单业务未结算业务数据</h5>
        					</div>
        					<div class="pull-right">
        						<p class="list_num text-center"><span ng-cloak class="text-success">{{sOrderNum}}</span>单</p>
        					</div>
        				</div>
        				<!--统计-->
        				<div class="col-sm-12 list_parent_all">
        					<div>
	        					<div class="col-sm-12 list_parent" ng-repeat="x2 in data2">
		        					<div class="col-sm-12 list_all">
		        						<ul class="col-sm-12" >
		        							<li class="pull-left">
		        								<img src="${ctxStatic}/front/img/data_file.png" alt="" class="data_file_img"/>
		        							</li>
		        							<li class="pull-left">
		        								<h4 ng-cloak>{{x2.username!=null?x2.username:x2.phone}}
													<img ng-cloak src="${ctxStatic}/front/img/per_phone.png" title="手机号码：{{x2.phone}}" class="phone_hover"/>
													<div class="per_warning">
														<span ng-cloak>手机号码：{{x2.phone}}</span>
													</div>
												</h4>
		        								<h5>待结算运单<span ng-cloak class="text-danger">{{x2.evercout}}</span>单</h5>
		        							</li>
		        							<li class="pull-right">
		        								<span ng-cloak>￥{{x2.alltradmy | number : 2}}</span>
		        							</li>
		        						</ul>
		        					</div>
	        					</div>
        					</div>
        					
        					<div id="noneData1" style="display:none;text-align: center;width: 100%;line-height: 25px;">
	                        	<img src="${ctxStatic }/front/img/nodata.png" style="width: 100px;height: 100px;">
		                    </div>
		                    <div>
		                    	<!--分页-->
	           					<tm-pagination conf="paginationConf2"></tm-pagination>
	           				</div>
        				</div>
        				
       					
	            				
        			</div>
        			<!--合计 定位-->
        			<div class="col-sm-12 total_num" style="background-color:#33ccff">
        				<p class="pull-left">合计：</p>
        				<p ng-cloak class="pull-right">￥{{sOrderMony | number : 2}}</p>
        			</div>
        		</div>
        	</div>
        </div>
	</div>
<script type="text/javascript"
        src="${ctxStatic}/echarts/echarts.min.js"></script>
<script type="text/javascript"
        src="${ctxStatic}/echarts/echarts-all.js"></script>
<script>
    $('.phone_hover').hover(function(){
        $(this).next('.per_warning').toggle();
    });
	var w = document.documentElement.clientWidth;
    if(w<1010){
    	$('.row').css('width','1010px').css('background-color','#fff').css('overflow-x','hidden').css('overflow-y','hidden');
    	$('.data-model').css('height','55px').find('.col-sm-2').css('margin-right','1%');
    }
    
    var app = angular.module('dataHall', ['tm.pagination']);
    app.controller('dataHallCtrl', ['$scope', '$http', function ($scope, $http) {
        //配置分页基本参数
        $scope.paginationConf = {
        	ishow: true,
        	pagesLength: 3,
            currentPage: 1,
            itemsPerPage: 4
        };
        //配置分页基本参数
        $scope.paginationConf2 = {
        	ishow: true,
        	pagesLength: 3,
            currentPage: 1,
            itemsPerPage: 4
        };
        $scope.sOrderNum = 0;
        $scope.bOrderNum = 0;
        $scope.sOrderMony = 0;
        $scope.bOrderMony = 0;
        
        ///查询参数初始化
        $scope.postData = {
        	type:'1',
        	orderBy:'',
            pageNo: $scope.paginationConf.currentPage,
            pageSize: $scope.paginationConf.itemsPerPage
        };
        $scope.postData2 = {
         	type:'1',
         	orderBy:'',
             pageNo: $scope.paginationConf2.currentPage,
             pageSize: $scope.paginationConf2.itemsPerPage
         };

        ////isloading ==1:加载数据2:查询不到数据3:查询到数据
        $scope.isloading = function (isloading) {
        	if (isloading == 1) {
                $("#maskloading", parent.document).show();
                $("#noneData").hide();
                $(".datainit").show();
            } else if (isloading == 2) {
                $("#maskloading", parent.document).hide();
                $("#noneData").show();
                $(".datainit").hide();
            } else {
                $("#maskloading", parent.document).hide();
                $("#noneData").hide();
                $(".datainit").show();
            }
        };
        $scope.isloading2 = function (isloading) {
        	if (isloading == 1) {
                $("#maskloading", parent.document).show();
                $("#noneData1").hide();
                $(".datainit").show();
            } else if (isloading == 2) {
                $("#maskloading", parent.document).hide();
                $("#noneData1").show();
                $(".datainit").hide();
            } else {
                $("#maskloading", parent.document).hide();
                $("#noneData1").hide();
                $(".datainit").show();
            }
        };


        var GetAllEmployee = function () {
            ///不同的tab不同的分页也可以放在上面的searchinfo处
            $scope.postData = {
                        pageNo:  $scope.paginationConf.currentPage,
                        pageSize: $scope.paginationConf.itemsPerPage
                    };
            	
            $http({
                url: '${wlpt}/wlpt/statistics/findBuyerOrderList',
                method: 'post',
                params: $scope.postData
            }).success(function (response) {
                
            	$scope.data = response.value.list;
                $scope.paginationConf.totalItems = response.value.count;
                if (!response.value.count) {
                    $scope.$apply(function () {
                    });
                    $scope.isloading(2);
                } else {
                    $scope.isloading(3);

                }
            });
        };
        
        var GetAllEmployee2 = function () {
            ///不同的tab不同的分页也可以放在上面的searchinfo处
             $scope.postData2 = {
	             pageNo: $scope.paginationConf2.currentPage,
	             pageSize: $scope.paginationConf2.itemsPerPage
	         };
            
            $http({
                url: '${wlpt}/wlpt/statistics/findSllerOrderList',
                method: 'post',
                params: $scope.postData2
            }).success(function (response) {
            	$scope.data2 = response.value.list;
                $scope.paginationConf2.totalItems = response.value.count;
                if (!response.value.count) {
                    $scope.$apply(function () {
                    });
                    $scope.isloading2(2);
                } else {
                    $scope.isloading2(3);

                }
            });
        };

        var GetStatusList = function () {
            $http.get("${wlpt}/wlpt/statistics/getOrdeList").success(function (response) {
                var sllerOrderCount = response.sllerOrderCount;
                var buyerOrderCount = response.buyerOrderCount;
                $scope.sOrderNum = sllerOrderCount.evercout;
                $scope.bOrderNum = buyerOrderCount.evercout;
                $scope.sOrderMony = sllerOrderCount.alltradmy;
                $scope.bOrderMony = buyerOrderCount.alltradmy;

                
            });
        }
        GetStatusList();
        /***************************************************************
         当页码和页面记录数发生变化时监控后台查询
         如果把currentPage和itemsPerPage分开监控的话则会触发两次后台事件。
         ***************************************************************/
        $scope.$watch('paginationConf.currentPage + paginationConf.itemsPerPage', GetAllEmployee);

        
        $scope.$watch('paginationConf2.currentPage + paginationConf2.itemsPerPage', GetAllEmployee2);
    }]);


    
    
    
    
    var title = [];
    var dataVar = [];
    var optiondata = [];
    var TOTALCOUNT = 0;//
    var type = 2;
    //支出分析  混合图
    
    var data_pay = echarts.init(document.getElementById('data_pay'));
    //财务概览  环形图
    var data_finance = echarts.init(document.getElementById('data_finance'));
    
    geroleCount()
    function geroleCount() {
        $.ajax({
            type: "POST",
            url: '${wlpt}/wlpt/statistics/getFinancialInfoData?tm='
            + new Date(),
            dataType: 'json',
            cache: false,
            data: {
                'searchType': 1
            },
            success: function (data) {
                title = [];
                dataVar = [];
                var pay_data = data.pay_data.data.varList;
                var income_data = data.income_data.data.varList;
                var financial_data = data.financial_data.data.varList;
                var order_data = data.order_data.data.varList;
                var mony_data = data.mony_data.data;
                var query_data=data.queryinfo_data;
                
                if (pay_data != null
                        && pay_data.length > 0) {
                    totalmoney = '';
                    for (var i = 0; i < pay_data.length; i++) {
                        var nowdata = pay_data[i];
                        var name = nowdata.name;
                        if(name == "招标结算支付"){
                        	name = "合同结算";
                        }else if(name == "余额转账"){
                        	name = "转账";
                        }else if(name == "余额提现"){
                        	name = "提现";
                        }else if(name == "余额购买油气"){
                        	name = "购买油气";
                        }else if(name == "卓币充值"){
                        	name = "购买卓币";
                        }
                        
                        title[i] = name;
                        dataVar[i] = {
                            value: nowdata.mony
                        };
                        totalmoney = totalmoney * 1 + nowdata.mony * 1;
                    }
                    $("#pay_totalmoney").html(totalmoney.toFixed(2));
                    setoption1();
                } 
                if (income_data != null
                        && income_data.length > 0) {
                	var totalmoney = '';

                    for (var j = 0; j < income_data.length; j++) {
                        var nowdata = income_data[j];
                        totalmoney = totalmoney * 1 + nowdata.mony * 1;
                    }

                    for (var i = 0; i < income_data.length; i++) {
                    	var data_div = $("#recharge");
                        var nowdata = income_data[i];
                        var name = nowdata.name;
                        var value_data = nowdata.mony;
                        var income_money = (((nowdata.mony * 1 / totalmoney * 1) * 100).toFixed(2))*1;
						var income_div =  '0 %';
						if(!isNaN(income_money)){
                            income_div = income_money +'%';
						}
						if(name=="余额充值"){
							
							data_div = $("#recharge");
						}else if(name=="运费收入"){
							
							data_div = $("#orderpay");
						}else if(name=="运费返款"){
							
							data_div = $("#orderback");
						}else if(name=="余额收到转账"){
							
							data_div = $("#accounttransfer");
						}
						
                        data_div.find(".clearfix span").html(income_div);
						data_div.find(".clearfix .pull-right").html("￥"+value_data);
                        
                    }
                    $("#income_totalmoney").html(totalmoney.toFixed(2));
                    live();
                }
                if (financial_data != null
                        && financial_data.length > 0) {
                	var totalmoney = '';

                    for (var j = 0; j < financial_data.length; j++) {
                        var nowdata = financial_data[j];
                        totalmoney = totalmoney * 1 + nowdata.mony * 1;
                        
                    }
					
                    $("#data_ul").html('');
                    for (var i = 0; i < financial_data.length; i++) {
                    	var data_div = $("#recharge");
                        var nowdata = financial_data[i];
                        var name = nowdata.name;
                        var value_data = nowdata.mony;
						if(name=="余额收到转账"){
							name = "收到转账";
						}
                        optiondata[i] = {
                                value: value_data,
                                name: name
                            };
						
						var html = '<li class="clearfix data_list">'
									+'<p class="pull-left"><span></span>'+name+'</p>'
									+'<div class="pull-right">￥'+value_data+'</div>'
									+'</li>';
									
						$("#data_ul").append(html);
                        
                    }
						
                    getoption2();
                    //小方块的各个颜色
                    var colorList=['#5693f3','#18b799','#dd4444','#fd9d34','#ffc940','#7891d4'];
                    var length=$('.finance_list li').length;
                    for(var i=0;i<length;i++){
                        $('.finance_list li').eq(i).find('span').css('background-color',colorList[i]);
                    }

                    if (order_data != null
                        && order_data.length > 0) {

                        for (var i = 0; i < order_data.length; i++) {
                            var data_div = $("#recharge");
                            var nowdata = income_data[i];
                            var name = nowdata.name;
                            var value_data = nowdata.mony;
                            if(name=="缴纳竞标保证金"){
								$("#bid_mony").html(value_data);
                            }else if(name=="打印提货单缴费"){
                                $("#print_mony").html(value_data);
                                $("#print_count").html(print_count);
                            }

                        }
                    }
                    if (mony_data != null) {
						if(mony_data.income_data!=null){
							$("#income_data_mony").html("￥"+mony_data.income_data.mony.toFixed(2));
						}
						if(mony_data.pay_data!=null){
							$("#pay_data_mony").html("￥"+mony_data.pay_data.mony.toFixed(2));
						}
                    }
                }
            }
        });
    }
    
    
    
    
    
    
    
function setoption1() {
var option_1 = {
     grid: {
     	x:90,
     	y:40,
     	x2:70,
     	y2:65,
    },
    tooltip : {trigger: 'item',formatter: function(params){
        var value_data =  params.name+"：￥"+ params.value;
        return value_data;
    } },
    toolbox: {
        show : true,
        feature : {
            //mark : {show: true},
            //dataView : {show: true, readOnly: false},
            magicType: {show:false, type: ['line', 'bar']},
            //restore : {show: true},
            //saveAsImage : {show: true}
        }
    },
    calculable : true,
    xAxis : [
        {
            type : 'category',
            position:'bottom',
            boundaryGap:true,
            axisLine:{//x轴线的样式
            	show:false,
            	lineStyle:{
            		color:'#56a3e5',
            		type:'solid',
            		width:'2'
            	},
            },
            axisTick:{//x轴的多出来的消失
            	show:true,
            	length:0,
            	lineStyle:{
            		color:'#000',
            		type:'solid',
            		width:'0'
            	}
            },
            axisLabel:{
            	show:true,
            	rotate:-65,
            	textStyle:{
            		color:'#fff',
            		fontSize:'16px',
            		fontWeight:'bold'
            	},
            },
            splitLine:{//网格样式
            	show:true,
            	lineStyle:{
            		color:'#76b2e5',
            		type:'solid',
            		width:1
            	},
            },
            splitArea:{
            	show:true,
            	areaStyle:{
            		color:"#53a3e8"
            	},
            },
            data : title
        },
    ],
    yAxis : [
        {
            type : 'value',
            splitLine:{//网格样式
            	show:true,
            	lineStyle:{
            		color:'#76b2e5',
            		type:'solid',
            		width:1
            	},
            },
            axisLine:{//x轴线的样式
            	show:false,
            	lineStyle:{
            		color:'#56a3e5',
            		type:'solid',
            		width:'0'
            	},
            },
            axisLabel : {
                formatter: '{value}',
                show:true,
            	textStyle:{
            		color:'#fff',
            		fontSize:'16px',
            		fontWeight:'bold'
            	},
            }
        }
    ],
    series : [

        {
            name:'金额',
            type:'bar',
            barWidth:'30',
            data:dataVar,
            itemStyle:{
            	normal:{
            		color:function(params){
            			var colorList=['#c1232b','#b5c334','#fcce10','#e87c25','#27727b','#fe8463','#9bca63','#7891d4'];
            			return colorList[params.dataIndex]
            		}
            	},
            },
        },
        {
            name:'金额',
            type:'line',
            symbolSize:4,
            itemStyle:{
            	normal:{
            		color:'#fff',
            		lineStyle:{
            			color:'#fff'
            		},
            	}
            },
            data:dataVar
        }
    ]
};
    data_pay.setOption(option_1);
}
   
   
   
   
function getoption2(){
  
    var option = {
            tooltip : { //提示框组件
                trigger: 'item', //触发类型(饼状图片就是用这个)
                formatter: "{a} <br/>{b} : {c} ({d}%)" //提示框浮层内容格式器
            },
            color:['#5693f3','#18b799','#dd4444','#fd9d34','#ffc940','#7891d4'],  //手动设置每个图例的颜色
            /*legend: {  //图例组件
                //right:100,  //图例组件离右边的距离
                orient : 'vertical',  //布局  纵向布局 图例标记居文字的左边 vertical则反之
                width:40,      //图行例组件的宽度,默认自适应
                x : '80%',   //图例显示在右边
                y: '20%',   //图例在垂直方向上面显示居中
                itemWidth:20,  //图例标记的图形宽度
                itemHeight:20, //图例标记的图形高度
                //icon:'force',
                data:['运费支出','运费收入','账户充值','账户提现','油气消费'],
                textStyle:{    //图例文字的样式
                    color:'#c3c3c3',  //文字颜色
                    fontSize:14,//文字大小
                    fontWeight:100,
                }
            },*/
            series : [ //系列列表
                {
                    name:'随访次数',  //系列名称
                    type:'pie',   //类型 pie表示饼图
                    center:['45%','40%'], //设置饼的原心坐标 不设置就会默认在中心的位置
                    radius : ['30%', '50%'],  //饼图的半径,第一项是内半径,第二项是外半径,内半径为0就是真的饼,不是环形
                    funnelAlign: 'left',
                    itemStyle : {  //图形样式
                        normal : { //normal 是图形在默认状态下的样式；emphasis 是图形在高亮状态下的样式，比如在鼠标悬浮或者图例联动高亮时。
                            label : {  //饼图图形上的文本标签
                                show :true  //平常不显示
                            },
                            labelLine : {     //标签的视觉引导线样式
                                show :true  //平常不显示
                            }
                        },
                        emphasis : {   //normal 是图形在默认状态下的样式；emphasis 是图形在高亮状态下的样式，比如在鼠标悬浮或者图例联动高亮时。
                            label : {  //饼图图形上的文本标签
                                show : true,
                                position : 'center',
                                textStyle : {
                                    fontSize : '20',
                                    fontWeight : 'bold'
                                }
                            }
                        }
                    },
                    data:optiondata
                }
            ]
        }
		data_finance.setOption(option);
}
		//
		var hh=518-100;
	$('.list_parent_all').height(hh+'px');
	$('.total_num').width($('.list_parent').width()+'px');
	
	
	//进度条动画
	function reset( ) {
        $(".progress-bar").css("width","0%");
    }
	reset();
	var timer;
	function live(){
		var str=$('.income_fc .pull-left').length;
		for(var i=0;i<str;i++){
			var w=$('.income_fc .pull-left').eq(i).find('span').text();
			$('.income_fc .progress-bar').eq(i).css('width',w);
		}
	}

</script>
</body>
</html>