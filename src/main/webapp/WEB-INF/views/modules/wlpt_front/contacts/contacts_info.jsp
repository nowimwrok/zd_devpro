<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>

</head>


    
<style>
    * {
        margin: 0px;
        padding: 0px;
    }

    /* body {
        font-family: "微软雅黑";
        font-size: 15px;
    } */

    a {
        text-decoration: none;
    }
    
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

        .goods-manage td, .goods-manage th {
            text-align: center;
        }

        .goods-manage td p {
            text-align: center;
            margin: 10px 0px;
        }

        .car_search {
            height: 35px;
            width: 15%;
        }

        .goods-manage td a {
            padding: 3px 12px;
            width: 95px;
            border-radius: 0px;
            background-color: #FFC52F;
            border-color: #FFC52F;
        }

        .loading_lock {
            display: none;
            width: 100%;
            height: 100%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 0px;
            text-align: center;
        }

        .loading_lock img {
            margin-top: 25%;
        }

        .datainit {
            display: none;
        }
        #dialog {
		    background-color: rgb(255, 255, 255);
		    /* height: 400px; */
		    height: initial;
		    top: 25%;
		    left: 35%;
		    width: 600px;
		    z-index: 5;
		    display: none;
		    position: fixed;
		    border-width: initial;
		    border-style: none;
		    border-color: initial;
		    border-image: initial;
		    margin: -200px 0px 0px -200px;
		    padding: 0px;
		    border-radius: 5px;
		}
		.select_title {
		    width: 100%;
		    height: 40px;
		    line-height: 40px;
		    margin-top: 5px;
		}
		.goods-manage {
		    width: 100%;
		    margin-top: 5px;
		    margin-bottom: 0px;
		}
		.pager li > a, .pager li > span {
		    display: inline-block;
		    padding: 2px 9px;
		    background-color: #fff;
		    border: 1px solid #ddd;
		    border-radius: 15px;
		    cursor: pointer;
		}
		.dialog-content {
		    padding: 5px;
		    text-align: center;
		}
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
		#dialog p {
		    margin: 0 0 12px;
		    height: 24px;
		    line-height: 24px;
		}
		#dialog p.close {
		    text-align: right;
		    padding-right: 10px;
		}
</style>
<body ng-app="dataHall" ng-controller="dataHallCtrl">

<div id="fullbg"></div>
<div id="dialog">
    <p class="close">
        <a href="#" onclick="closeBg();">X</a>
    </p>
    <div class="dialog-content">
        <br/>
        
        <div class="select_title">
		    <form action="" method="get" class="search-bar" style="text-align: center">
		        <input id="searchinfoname" type="text" class="car_search car_phone_search" style="width: 250px;height: 30px;" ng-model="searchData.searchinfoname"
		               placeholder="登录名/手机号码"/>
		        
		        <button type="button" name="search-btn" id="search-btn"
		                style="width:80px;border-radius:0px;border-color:#FFC52F;background-color:#FFC52F;padding: 3px 5px;"
		                class="btn btn-warning" ng-click="onSelectPage(1)">
		            <span class="glyphicon glyphicon-search"></span><span class="goods_search_btn">搜索</span>
		        </button>
		        
		    </form>
		</div>
		<table class="goods-manage">
		    <thead>
		    <tr class="goods_col_1" style="border:none; border: solid 1px #d1c5c5;">
		        <td style="width:20%; border: solid 1px #d1c5c5;">登录名</td>
		        <td style="width:15%; border: solid 1px #d1c5c5;">真实姓名</td>
		        <td style="width:20%; border: solid 1px #d1c5c5;">手机号码</td>
		        <td style="width:15%; border: solid 1px #d1c5c5;">添加时间</td>
		        <td style="width:20%; border: solid 1px #d1c5c5;">操作</td>
		    </tr>
		    </thead>
		    <tbody class="datainit">
		    <tr ng-repeat="x in data" style="height: 40px;">
		        <td style=" border: solid 1px #d1c5c5;">
		            {{x.target.loginName}}
		        </td>
		        <td style=" border: solid 1px #d1c5c5;">
		            {{x.target.name}}
		        </td>
		        <td style=" border: solid 1px #d1c5c5;">
		            {{x.target.phone}}
		        </td>
		        <td style=" border: solid 1px #d1c5c5;">
		            {{x.createDate}}
		        </td>
		        <td style=" border: solid 1px #d1c5c5;">
		           
		            <a href="javascript:;" ng-click="clickcontcts(x.id,x.target.loginName)" target="content" style="background: #fff;">选择</a>
		        </td>
		    </tr>
		    
		    </tbody>
		</table>
		<div class="loadings"><img src="/static/images/loading.gif">
		    <p>加载中</p></div>
		<div class="loading_lock"><img src="${ctxStatic }/images/loading.gif">
		    <p>等待中</p></div>
		<div id="noneData" style="display:none;text-align: center;width: 100%;line-height: 25px;">暂无数据</div>
		<div class="paging" id="paging">
		    <ul class="pagination pager" id="pagination" on-select-page="selectPage(page)">
		        <li ng-class="{active: isActive(page)}"><a ng-click="selectPage(1)">第一页</a></li>
		        <li ng-class="{disabled: noPrevious()}"><a ng-click="selectPrevious()">上一页</a></li>
		        <li ng-repeat="page in pages" ng-class="{active: isActive(page)}">
		            <a ng-click="selectPage(page)">{{page}}</a>
		        </li>
		        <li ng-class="{disabled: noNext()}"><a ng-click="selectNext()">下一页</a></li>
		        <li ng-class="{active: isActive(page)}"><a ng-click="selectPage(numPages)">最后一页</a></li>
		    </ul>
		</div>
        
        <!-- <p class="close_content"><a href="#" onclick="closeBg1();">知道了</a></p> -->
    </div>
</div>
</body>
<script src="${ctxStatic }/jquery/jquery-1.9.1.js"></script>
<script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/angular/angular.min.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script>

    var app = angular.module("dataHall", []);
    app.controller('dataHallCtrl', function ($scope, $http) {
        $scope.currentPage = 1;
        $scope.pageSize = 5;
        $scope.pages = [];
        ///初始化搜索条件
        $scope.searchData = {
            drivername: '', driverphone: '', isagree: ''
        };
        
        ////isloadings ==1:加载数据2:查询不到数据3:查询到数据
        $scope.isloadings = function (isloadings) {
            if (isloadings == 1) {
                $(".loadings").show();
                $("#noneData").hide();
            } else if (isloadings == 2) {
                $(".loadings").hide();
                $("#noneData").show();
            } else {
                $(".loadings").hide();
                $("#noneData").hide();
                $(".datainit").show();
            }
        };
        
        
        $scope.clickcontcts = function(id,username) {
        	$("#userid").val(id);
        	$("#searchinfo").val(username);
            $("#fullbg,#dialog").hide();      //关闭弹出款  通过 hide（） 方法
            search();
        }
        //get first page
        $http({
            url: '${wlpt}/wlpt/contacts/getContactsList',
            method: 'post',
            params: {
                'pageNo': $scope.currentPage,
                'pageSize': $scope.pageSize
            }
        }).success(function (response) {
        	if (!response.value || !response.value.list) {
                $scope.isloadings(2);
            } else {
                $scope.isloadings(3);
            }
            $scope.data = response.value.list;
            
            $scope.numPages = Math.ceil(response.value.count / response.value.pageSize);

            //分页要repeat的数组
            $scope.newPages = $scope.numPages > 5 ? 5 : $scope.numPages;
            for (var i = 0; i < $scope.newPages; i++) {
                $scope.pages.push(i + 1);
            }

        });

        $scope.onSelectPage = function (page) {
            //replace your real data
            $scope.isloadings(1);
            $http({
                url: '${wlpt}/wlpt/contacts/getContactsList',
                method: 'post',
                params: {
                    'pageNo': $scope.currentPage,
                    'pageSize': $scope.pageSize,
                    'searchinfo': $("#searchinfoname").val()
                }
            }).success(function (response) {
            	if (!response.value.list || !response.value.list) {
                    $scope.isloadings(2);
                } else {
                    $scope.isloadings(3);
                }
                $scope.data = response.value.list;
                $scope.pages = [];
                
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
                $("#datainit").show();
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


                    if (!scope.isActive(page)) {
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

</script>

<script>


    function showBg1() {                    //定义 showBg1 函数
        var bh = $("body").height();       //获得整个body（浏览器窗口）的高度 并 赋值给 bh 
        var bw = $("body").width();      //获得整个body（浏览器窗口）的宽度 并 赋值给 bw
        $("#fullbg").css({             // 通过 JQ 的css（） 事件，给选中的节点 （“#fullbg”）添加属性
            height: bh,
            width: bw,
            display: "block"
        });
        $("#dialog").show();          //并且让 节点（“dialog”） show（）出来
    }

    function closeBg() {
        $("#fullbg,#dialog").hide();      //关闭弹出款  通过 hide（） 方法
    }
    


</script>

</html>
