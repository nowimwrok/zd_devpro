<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<html>
<head>
    <title>${fns:getConst('SYSTEMTITLE')}--价格指数</title>

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

    <link href="${ctxStatic }/weixin/css/carsource.css" rel="stylesheet"
          type="text/css">
    <link href="${ctxStatic }/weixin/css/global.css" rel="stylesheet"
	type="text/css">
    <style type="text/css">
        .search_top, .result_bottom {
            width: 100%;
            display: block;
            border-bottom: 1px dashed #999;
            z-index: 2;
            position: fixed;
            background-color: #fff;
        }

        .search_top {
            /* height: 35px; */
            width: 100%;
            line-height: 35px;
            border-bottom: 1px solid #EBEBEB;
         
            margin: 0px auto;
            margin-top: 2px;
        }

        .result_bottom {
		    height: 40px;
		    border: none;
		    text-align: center;
		    line-height: 24px;
		    bottom: 0px;
		}

        .top {
            top: 0px;
        }

        .bottom {
            bottom: 0px;
        }

        #data_box, #data_add {
            width: 98%;
            margin: 0 auto;
            margin-top: 13%;
            margin-bottom: 30px;
        }

        #search {
            cursor: pointer;
            width: 100%;
            line-height: 35px;
            text-align: center;
            background-color: rgba(10, 94, 206, 0.71);
            color: #FFFFFF;
        }

        #search a {
            text-decoration: none;
        }

        .hedImg {
            width: 40px;
            height: 40px;
            margin: 2px auto;
            border-radius: 40px;
            border: 1px solid #CCC;
        }

        .hededImg {
            width: 40px;
            height: 40px;
            margin: 2px auto;
            border-radius: 40px;
            border: 1px solid #CCC;
        }

        .hedImg img {
            width: 40px;
            height: 40px;
            border-radius: 40px;
        }

        .data_tab_left {
            width: 49%;
        }

        .data_tab_right {
            width: 50%;
        }

        .address_div {
            clear: both;
            width: 100%;
            margin: 0 auto
        }

        .search_ul {
            width: 100%;
            height: 35px;
            list-style: none;
            margin: 5px auto;
            background-color: #FFF;
        }

        .li_txt {
            width: 42%;
            text-align: left;
            float: left;
            padding-left: 10px;
            height: 35px;
        }

        table {
            border: solid rgb(185,185,185) 1px;
            border-collapse: collapse; /* 边框合并属性  */
        }

        table tr td {
            text-align: center;
            border: solid rgb(185,185,185) 1px;
        }
        table tr th {
            text-align: center;
            border: solid rgb(185,185,185) 1px;
            height: 40px;
        }
        .title_th {
		    width: 98%;
		    display: block;
		    z-index: 2;
		    position: fixed;
		    background-color: #fff;
		}
		.paging a{
		margin-left: 2px;
		}
		/* 弹出层 */
		#fullbg {
		    background-color: gray;
		    left: 0;
		    opacity: 0.5;
		    position: absolute;
		    top: 0;
		    z-index: 3;
		    filter: alpha(opacity=50);
		    -moz-opacity: 0.5;
		    -khtml-opacity: 0.5;
		}
		#dialog {
		    background-color: #fff;
		    border: none;
		    height: 28%;
		    margin: -200px 0 0 -200px;
		    padding: 0px;
		    position: fixed !important;
		    position: absolute;
		    top: 50%;
		    right:0;
		    width: 100%;
		    z-index: 5;
		    border-radius: 5px;
		    display: none;
		}
		#dialog p.close {
		    text-align: right;
		    padding-right: 10px;
		}
		
		#dialog p {
		    margin: 0 0 12px;
		    height: 24px;
		    line-height: 24px;
		}
		.close {
		    float: right;
		    font-size: 21px;
		    font-weight: 700;
		    line-height: 1;
		    color: #000;
		    text-shadow: 0 1px 0 #fff;
		    filter: alpha(opacity=20);
		    opacity: .2;
		}
		#dialog p.close a {
		    text-decoration: none;
		}
		.dialog-content {
		    padding: 5px;
		    text-align: center;
		}
		.div_txt {
		    width: 30%;
		    border-bottom: 1px solid #ccc;
		    height: 25px;
		}
	</style>
</head>

<body  ng-app="dataHall" ng-controller="dataHallCtrl" style="background: #fff;">
<div class="search_top top">
    <div style="text-indent: 15px;">
        <h3 style="text-align: center;">
            <span id="nowYear"></span>年${fns:getConst('SYSTEMTITLE')}平台<span style="color: red;" id="type"></span>运价指数
        </h3>
    </div>
    <div ></div>
</div>

<div id="data_box">
    <!-- 	<div style="text-indent: 30px;">卓大物流平台内物流企业近千家，每天进出大型货车超过3000台，
        货运量每年约3000万吨，安置就业人数10000多名。 价格表是在近千家物流企业中，选择36家代表性企业，每周按照
        运营线路实际发生的平均价格，再加上卓大信息交易中心交易得 到的周平均价格，经过卓大管理中心审核后，实时上传，该价格
        具真实性、代表性、权威性</div> -->
    <div class="div_tb">
		
        <table style="margin-bottom:20px;">
	    	<tr style="font-size: 12px;color: rgb(51,51,90);height: 40px; font-weight: bolder;">
	            <th width="18%" scope="col">始发地</th>
	            <th width="18%" scope="col">目的地</th>
	            <th width="10%" scope="col">指导价</th>
	            <th width="18%" scope="col">日期</th>
	        </tr>
	        
            <tr style="font-size: 12px;height: 40px;"  ng-repeat="x in data">
                <td width="18%" >{{x.startaddress }}</td>
                <td width="18%">{{x.endaddress }}</td>
                <td width="10%" >{{ x.priceinfo.newprice | number:2}}</td>
                <td width="18%">{{ x.updatetime }}</td>
            </tr>
        </table>
        <%-- <table style="margin-bottom:20px;">
            <tr>
                <td colspan="6" style="color:#FFFFFF;background-color:blue;">原材料</td>
            </tr>
            <tr style="font-size: 12px;color: blue; font-weight: bolder;">
                <th width="18%" scope="col">始发地</th>
                <th width="18%" scope="col">备注</th>
                <th width="18%" scope="col">目的地</th>
                <th width="18%" scope="col">备注</th>
                <th width="10%" scope="col">指导价</th>
                <th width="18%" scope="col">日期</th>
            </tr>
            <c:if test="${not empty Linelist.data.varlist }">
                <c:forEach items="${Linelist.data.varlist}" var="var"
                           varStatus="vs">
                    <c:if test="${var.GOODSTYPE eq 1 }">
                        <tr style="font-size: 12px;">
                            <td>${var.STARTADDRESS}</td>
                            <td>${var.STARTAREMARKS}</td>
                            <td>${var.ENDADDRESS}</td>
                            <td>${var.ENDREMARKS}</td>
                            <td>${var.NEWPRICE!=null?var.NEWPRICE:'暂无'}</td>
                            <td>${var.NEWTIME}</td>
                        </tr>
                    </c:if>
                </c:forEach>
            </c:if>
        </table>
 --%>
    </div>
</div>
<div id='loading'
		style='width:100%;display:none;vertical-align: middle;text-align:center;height:45px'>
		<div>
			<img src='${ctxStatic }/images/weixin/loading-30x30.gif'>
		</div>
		<div style="font-size:14px;font-weight:bold;" id="loadtext">加载中……</div>
</div>
<div id="pages" >
	
</div>
<div class="paging search_top result_bottom bottom" id="paging" on-select-page="selectPage(page)">
	<span id="firstPage" ng-class="{active: isActive(page)}"><a ng-click="selectPage(1)">首页</a></span>
	<span ng-class="{disabled: noPrevious()}"><a ng-click="selectPrevious()">上一页</a></span>
	<span ng-class="{disabled: noNext()}"><a ng-click="selectNext()">下一页</a></span> 
	<span ng-class="{active: isActive(page)}" id="lastPage"><a ng-click="selectPage(numPages)">尾页</a></span>
	<span id="pageInfo" ><span>第</span><b id="curPage" style="color: #ff7400;">1</b><span>页/共</span><b
		id="pageCount" style="color: #ff7400;">1</b><span>页</span> </span>
	<b onclick="showBg1();"><img alt=""  src="${ctxStatic }/images/weixin/sc.png" style="vertical-align: bottom;"></b> 
</div>

<div id="fullbg"></div> 
<div id="dialog">
   <!--  <p class="close">
        <a href="#" onclick="closeBg();">X</a>
    </p> -->
    
    <div class="dialog-content" >
    	<div style="width:100%;height: 77%;border-bottom: solid rgb(185,185,185) 1px; ">
	    	 <div style="text-indent: 15px; height: 22%;">
		        <h3 style="text-align: center;">
		            	查询运价指数
		        </h3>
		     </div>
		     <div style="height:65%;text-align: left;padding: 3%;line-height: 45px;">
		     	<div><span>运输线路：</span><input class="div_txt" type="text" id="fromAddress"readonly="readonly" ng-model="STARTADDRESS"/>至
		     		<input class="div_txt" type="text" id="toAddress" readonly="readonly"  ng-model="ENDADDRESS"/></div>
		     	<div><span>货物类型：</span><span><input style="vertical-align: middle;" id="goodstype1" type="checkbox" value="0"  ng-model="GOODSTYPE" /></span><span >成品</span>&nbsp;&nbsp;&nbsp;&nbsp;
                             <span><input style="vertical-align: middle;" id=goodstype2 type="checkbox" value="1" ng-model="GOODSTYPES"/></span><span>原材料</span>
		     </div>
    	</div>
    	<div style="width:100%;height: 22%;line-height: 40px;">
    		<div style="width:49%;height: 99%;border-right: solid rgb(185,185,185) 1px;float: left;line-height: 30px;" onclick="closeBg()">取消</div>
    		<div style="width:49%;height: 99%;color: rgb(9,187,7);float: left;line-height: 30px;" onclick="closeBg1();" ><span ng-click="onSelectPage(1)">查询</span></div>
    	</div>
    </div>
</div>
<script type="text/javascript" src="${ctxStatic }/weixin/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/config.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/jquery.pcc.js"></script>
<script type="text/javascript" src="${ctxStatic }/weixin/js/weixin/jquery.touchSwipe.min.js"></script>
<script type="text/javascript" src="${ctxStatic }/echarts/echarts.min.js"></script>
<script src="${ctxStatic }/modules/wlpt/front/js/angular/angular.min.js"></script>
<script type="text/javascript">
function showBg1() {                    //定义 showBg1 函数
    var bh = $("body").height();       //获得整个body（浏览器窗口）的高度 并 赋值给 bh 
    var bw = $("body").width();      //获得整个body（浏览器窗口）的宽度 并 赋值给 bw
      $("#fullbg").css({             // 通过 JQ 的css（） 事件，给选中的节点 （“#fullbg”）添加属性
      height:'100%',                     
      width:'100%', 
      display:"block" 
      }); 
      $("#dialog").show();          //并且让 节点（“dialog”） show（）出来
      }   

    function closeBg() { 
    $("#fullbg,#dialog").hide();      //关闭弹出款  通过 hide（） 方法
    }    
   

    $("#loading").hide();
    var app = angular.module("dataHall", []);
    	app.controller('dataHallCtrl', function ($scope, $http) {
    		$scope.GOODSTYPE ='';
    		$scope.GOODSTYPES=''
    		$scope.currentPage = 1;
            $scope.pageSize = 10;
            $scope.pages = [];
            var type ="";
            //get first page
            $http({
                url: '${wx}/weixin/freightrate/getPrices',
                method: 'post',
                params: {
                	'priceinfo.goodstype': $scope.GOODSTYPE,
                	'startaddress': $("#fromAddress").val(),
                    'endaddress': $("#toAddress").val(),
                    'pageNo': $scope.currentPage,
                    'pageSize': $scope.pageSize
                    
                }
            }).success(function (response) {
            	$scope.data = response.value.list;
            	//分页
            	$scope.numPages = Math.ceil(response.value.count / response.value.pageSize);
            	$("#pageCount").html($scope.numPages);
            	$("#curPage").html(
                		$scope.currentPage);
                if ($scope.numPages == 0) {
                    $scope.numPages = 1;
                }
                //分页要repeat的数组
                $scope.newPages = $scope.numPages > 5 ? 5 : $scope.numPages;

                for (var i = 0; i < $scope.newPages; i++) {
                    $scope.pages.push(i + 1);
                }
            });
        	////分页查询
            $scope.onSelectPage = function (page) {
        		var type1 = $("#goodstype1:checked").size();
        		var type2 = $("#goodstype2:checked").size();
        		if(type1==1&&type2==0){//选择成品
        			$scope.GOODSTYPE=0;
        			type = "成品";
        		}else if(type2==1&&type1==0){//选择原材料
        			$scope.GOODSTYPE=1;
        			type="原材料";
        		}else{
        			$scope.GOODSTYPE="";
        			type="";
        		}
        		$("#type").html(type);
                //replace your real data
                $http({
                    url: '${wx}/weixin/freightrate/getPrices',
                    method: 'post',
                    params: {
                    	'priceinfo.goodstype': $scope.GOODSTYPE,
                        'startaddress': $("#fromAddress").val(),
                        'endaddress': $("#toAddress").val(),
                        'pageNo': $scope.currentPage,
                        'pageSize': $scope.pageSize
                    }
                }).success(function (response) {

                    $scope.data = response.value.list;
                    $scope.pages=[];
                    //分页
                    $scope.numPages = Math.ceil(response.value.count / response.value.pageSize);
                    
                    $("#pageCount").html($scope.numPages);
                    $("#curPage").html(
                    		$scope.currentPage);
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
       		 }
            
       });
    
    	///分页
        app.directive('paging', function () {
        	
            return {
                restrict: 'AEC',
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

    
    //====================================================地址绑定=========================================================
    $(function () {
        var nowtime = new Date();
        var nowyear = nowtime.getFullYear();
        $("#nowYear").html(nowyear);
        $("#fromAddress").PCC({
            hasCounty: false,
            width: "94%",
            height: 320,
            url: "${wlpt}/wlpt/chinaarea/getArea",
            closeIcon: "/static/images/pic12.gif",
            complete: function (data) {
                var str = "";
                if (data.city) {
                    if (data.city.NAME != data.province.NAME) {
                        str += data.city.NAME;
                    }
                }
                if (str != " ") {
                    $("#fromAddress").val(str);
                } else {
                    $("#fromAddress").val("");
                }
            }
        });

        $("#toAddress").PCC({
            hasCounty: false,
            width: "94%",
            height: 320,
            url: "${wlpt}/wlpt/chinaarea/getArea",
            closeIcon: "/static/images/pic12.gif",
            location: "left",
            ismiddle: true,
            complete: function (data) {
                var str = "";
                if (data.city) {

                    if (data.city.NAME != data.province.NAME) {
                        str += data.city.NAME;
                    }
                }
                if (str != " ") {
                    $("#toAddress").val(str);
                } else {
                    $("#toAddress").val("");
                }
            }
        });
    });
</script>

</body>
</html>
