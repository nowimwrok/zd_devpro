<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>诚信档案</title>
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">

    <style type="text/css">
        /*公共样式*/
        * {
            margin: 0px;
            padding: 0px;
            font-family: "微软雅黑";
            font-size: 15px;
        }

        a {
            text-decoration: none;
        }

        li {
            list-style: none;
        }

        .body-wrap {
            padding-bottom: 40px;
            color: #5a5a5a;
            width: 1024px;
            margin: 0 auto;
        }

        /*头部样式*/
        .platform-info {
            width: 100%;
            border: 1px solid #ccc;
            border-top: none;
            margin-bottom: 20px;
        }

        .weixin {
            position: absolute;
            left: 835px;
            top: 70px;
        }

        .banner {
            position: relative;
        }

        .logo {
            font-size: 30px;
            font-weight: bold;
            color: #fff;
            position: absolute;
            left: 10%;
            top: 50px;
        }

        .disall {
            color: red;
        }

        .menu-detail {
            position: absolute;
            left: 80px;
            top: 147px;
        }

        .menu-detail li {
            float: left;
            width: 100px;
            height: 40px;
            line-height: 40px;
            text-align: center;
            background: rgba(255, 255, 255, 0.32);
            margin-left: 5px;
        }

        .disnone {
            display: none;
        }

        .menu-detail li a {
            color: #fff;
            font-size: 18px;
            font-family: "宋体"
        }

        .menu-detail li a:hover {
            text-decoration: none;
        }

        .abs-left {
            width: 466px;
            min-height: 100px;
            float: left;
            padding-right: 20px;
            margin-right: 20px;
            border-right: 1px #ccc dashed;
        }

        .abs-left img {
            width: 436px !important;
        }

        .abs-right {
            margin-left: 20px;
        }

        .abs-right img {
            margin-right: 10px;
        }

        .abs {
            overflow: hidden;
            padding: 10px 22px;
            margin-top: 20px;
        }

        /*  */
        .panel-body table {
            width: 100%;
        }

        .panel-body tbody td {
            text-align: center;
            border-right: 1px dashed #ccc;
        }

        .panel-body tbody tr {
            border-bottom: 1px dashed #ccc;
        }

        .bargin-amount {
            font-size: 24px;
        }

        .needred {
            color: red;
        }

        .needgreen {
            color: green;
        }

        .td_last {
            border-right: none;
        }

        .honesty-table .honesty-table td {
            border: none;
        }

        .honesty-table tr {
            border: none;
        }

        .honesty-table td {
            border: none;
        }

        .con img {
            cursor: pointer;
        }

        .con {
            text-align: center;
            float: left;
            margin-right: 180px;
        }

        .images-dis1 {
            width: 1023px;
            overflow: hidden;
            margin: 20px 35px 60px 80px;
        }

        .images-dis2 {
            width: 1023px;
            overflow: hidden;
            margin: 5px 35px 10px 80px;
        }

        .contactus {
            margin-left: 30px;
            margin-top: 20px;
        }

        .ruixiang {
            color: #251d42;
            font-weight: bold;
        }

        .panel-default > .panel-heading {
            color: #333;
            border-color: #ddd;
            background-color: #fff;
        }

        .panel-footer {
            padding: 10px 15px;
            height: 46px;
            border-top: 1px solid #ddd;
            border-bottom-right-radius: 3px;
            border-bottom-left-radius: 3px;
        }

        .panel {
            margin-bottom: 20px;
            background-color: #fff;
            border-radius: 0;
            border: 1px solid rgba(0, 0, 0, 0.22);
        }

        .btn-default {
            color: #333;
            background-color: #fff;
            border-color: #ccc;
            font-size: 12px;
            width: 104px;
        }

        .honesty-table tr {
            border-bottom: 1px dashed #ccc;
        }

        .panel-body {
            padding: 0px;
        }

        .honesty-table tbody tr td {
            padding: 5px;
            border: none;
        }

        .product-server {
            padding-left: 20px;
            padding-top: 20px;
            line-height: 25px;
        }

        #active {
            background-color: #990066;
        }

        .active {
            background-color: #D2322D;
            color: white !important;
        }

        .rating {
            color: #a9a9a9;
            margin: 0;
            padding: 0;
        }

        ul.rating {
            display: inline-block;
        }

        .rating li {
            list-style-type: none;
            display: inline-block;
            padding: 1px;
            text-align: center;
            font-weight: bold;
            cursor: pointer;
            font-size: 20px;

        }

        .rating .filled {
            color: #F55400;
        }


    </style>
</head>
<body>


<!--顶部banner图加导航块-->
<div class="body-wrap" ng-app="companyApp">
    <div class="platform-info">
        <div class="banner">
        <div class="logo">${user.name}</div>
            <img src="${ctxStatic}/images/wlptfront/banner.png" width="1022px" height="187px">
            <div class="abs">
                <div class="abs-left">
                   <p>姓名： ${not empty user.name?user.name:user.loginName}</p>
                   <p>电话： ${not empty user.phone?user.phone:"暂无"}</p>
                   <p>邮箱： ${not empty user.email?user.email:"暂无"}</p>
                </div>
                <div class="abs-right">
                	<p>注册时间：<fmt:formatDate value="${user.createDate }" pattern="yyyy-MM-dd"/></p>
                    <p>用户类型：${user.role.name }</p>
                    <p>认证状态：
                        <c:choose>
                            <c:when test="${user.userinfo.status==2}">已认证</c:when>
                            <c:otherwise>未认证</c:otherwise>
                        </c:choose>
                    </p>
                    <img src="${ctxStatic}/images/wlptfront/icon-1.png" width="36px" height="38px"/>
                    <c:if test="${enterprise.status==2}">
                        <img src="${ctxStatic}/images/wlptfront/icon-2.png" width="36px"
                             height="38px"/>
                    </c:if>
                    <img src="${ctxStatic}/images/wlptfront/V${user.userinfo.pointlevle!=null?user.userinfo.pointlevle:0}.png" width="30px"
                         height="30px"/>
                </div>
            </div>
        </div>
    </div>

    <!-- 诚信交易记录-->
    <div class="transction clerify" ng-controller="honestyCtrl">
        <input type="hidden" id="userid" value="${user.id}">
        <div class="panel panel-default">
            <div class="panel-heading"><a name="honesty"></a>
                <img src="${ctxStatic}/images/wlptfront/icon-10.png"><span>&nbsp;&nbsp;诚信交易记录</span>
            </div>
            <div class="panel-body">
                <table>
                    <tbody>
                    <tr>
                       <td>
                            <span class="bargin-wo">累计成交数（笔）<br></span>
                            <span class="bargin-amount">
                                 <c:choose>
                                     <c:when test="${not empty userStatistics.successtrade}">
                                         ${userStatistics.successtrade}
                                     </c:when>
                                     <c:otherwise>
                                         0
                                     </c:otherwise>
                                 </c:choose>
                            </span>
                        </td>
                        <td>
                            <span>接单总数（笔）<br></span>
                            <span class="bargin-amount">
                                <c:choose>
                                    <c:when test="${not empty userStatistics.tradeordercount}">
                                        ${userStatistics.tradeordercount}
                                    </c:when>
                                    <c:otherwise>
                                        0
                                    </c:otherwise>
                                </c:choose>
                            </span>
                        </td>
                        <td>
                            <span>纠纷记录（次）<br></span>
                            <span class="bargin-amount">
                                 ${complainttimes}
                            </span>
                        </td>
                        <td>
                            <span>服务态度<br>(${ratingscale.serviceattitudetotallnumber!=null?ratingscale.serviceattitudetotallnumber:0}人评价)<br><br></span>
                            <span class="needred bargin-amount">${ratingscale.serviceattitudepoint!=null?ratingscale.serviceattitudepoint:0}</span>
                        </td>
                        <td>
                            <span>运输费用<br>(${ratingscale.transportationcosttotalnumber!=null?ratingscale.transportationcosttotalnumber:0 }人评价)<br><br></span>
                            <span class="needred bargin-amount">${ratingscale.transportationcostpoint!=null?ratingscale.transportationcostpoint:0 }</span>
                        </td>
                        <td>
                            <span>运输时效<br>(${ratingscale.transportlimitationtotalnumber!=null?ratingscale.transportlimitationtotalnumber:0 }人评价)<br><br></span>
                            <span class="needred bargin-amount">${ratingscale.transportlimitationpoint!=null?ratingscale.transportlimitationpoint:0 }</span>
                        </td>
                        <td class="td_last" style="border:none">
                            <span>货物安全<br>(${ratingscale.goodssafetytotalnumber!=null?ratingscale.goodssafetytotalnumber:0}人评价)<br><br></span>
                            <span class="needred bargin-amount">${ratingscale.goodssafetypoint!=null?ratingscale.goodssafetypoint:0 }</span>
                        </td>
                    </tr>
                    </tbody>
                </table>

                <table class="honesty-table">
                    <tbody>
                    <tr>
                        <td style="width:15%">
                                                                                                 评价
                        </td>
                        <td style="width:45%">
                                                                                                  评论内容
                        </td>
                        <td style="width:20%">评价方</td>
                        <td style="width:20%">时间</td>
                    </tr>
                     <tr ng-repeat="x in items">
                        <td>
                            <div star rating-value="x.sellercommentlv" max="max" on-hover="onHover" on-leave="onLeave"
                                 readonly="{{readonly}}"></div>
                        </td> 
                        <td>{{x.sellercomment.substr(0, 25)}}...</td>
                        <td>{{x.user.name}}</td>
                        <td>{{x.sellercommenttime.substr(0,25)}}...</td>
                    </tr>
                    </tbody>
                </table>
            </div>
            <div id="noneData" style="display:none;text-align: center;width: 100%;line-height: 25px;">暂无数据</div>
            <div class="panel-footer">
                <div style="float:right">
                    <button class="btn btn-sm" type="button" ng-click="Previous()">上一页</button>
                    <button style="margin: 0 3px" class="btn btn-sm" ng-repeat="page in pageList" type="button"
                            ng-click="selectPage(page)" ng-class="{active:isActivePage(page)}">{{ page }}
                    </button>
                    <button class="btn btn-sm" type="button" ng-click="Next()">下一页</button>
                </div>
            </div>
        </div>
    </div>
    <!-- 所获荣誉-->
    <div class="transction clerify" ng-controller="honorCtrl">
        <div class="panel panel-default">
            <div class="panel-heading head-cl"><a name="honor"></a>
                <img src="${ctxStatic}/images/wlptfront/icon-10.png"><span>&nbsp;&nbsp;诚信照片</span>
            </div>
            <div class="panel-body">
                <div class="row" style="padding: 10px;">

                        <div class="thumbnail" ng-repeat="x in honors" style="width:30%;float:left;margin-left:2.5%;">
                            <img src="{{x.Img}}"
                                 style="width: 100%;height: 180px;">
                            <div class="caption text-center">
                                <h5>{{x.ImgTitle}}</h5>
                            </div>
                        </div>
                </div>
                <div id="pic" style="display:none;text-align: center;width: 100%;line-height: 25px;">暂无认证</div>
            </div>
        </div>
    </div>
    </div>
</div>
<!-- jQuery文件。务必在bootstrap.min.js 之前引入 -->
<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

<script src="http://apps.bdimg.com/libs/angular.js/1.4.6/angular.min.js"></script>


<script>

    var app = angular.module("companyApp", []);
    app.controller('honestyCtrl', function ($scope, $http) {
        $scope.max = 3;
        $scope.ratingVal = 2;
        $scope.readonly = true;
        $scope.onHover = function (val) {
            $scope.hoverVal = val;
        };
        $scope.onLeave = function () {
            $scope.hoverVal = null;
        };
        $scope.onChange = function (val) {
            $scope.ratingVal = val;
        };
        $http({
            url: '${wlpt}/wlpt/credit/getComment',
            method: 'GET',
            params: {
                'id': $('#userid').val()
            }
        }).success(function (response) {
            $scope.datas = response.value.commentlist;
            pages();
            if(response.value.commentlist.length==0){
            	$("#noneData").show();
            }
        });

        function pages() {
            //分页总数
            $scope.pageSize = 10;
            $scope.pages = Math.ceil($scope.datas.length / $scope.pageSize); //分页数
            $scope.newPages = $scope.pages > 5 ? 5 : $scope.pages;
            $scope.pageList = [];
            $scope.selPage = 1;
            //设置表格数据源(分页)
            $scope.setData = function () {
                $scope.items = $scope.datas.slice(($scope.pageSize * ($scope.selPage - 1)), ($scope.selPage * $scope.pageSize));//通过当前页数筛选出表格当前显示数据
            };
            $scope.items = $scope.datas.slice(0, $scope.pageSize);
            //分页要repeat的数组
            for (var i = 0; i < $scope.newPages; i++) {
                $scope.pageList.push(i + 1);
            }
            //打印当前选中页索引
            $scope.selectPage = function (page) {
                //不能小于1大于最大
                if (page < 1 || page > $scope.pages) return;
                //最多显示分页数5
                if (page > 2) {
                    //因为只显示5个页数，大于2页开始分页转换
                    var newpageList = [];
                    for (var i = (page - 3); i < ((page + 2) > $scope.pages ? $scope.pages : (page + 2)); i++) {
                        newpageList.push(i + 1);
                    }
                    $scope.pageList = newpageList;
                }
                $scope.selPage = page;
                $scope.setData();
                $scope.isActivePage(page);
            };
            //设置当前选中页样式
            $scope.isActivePage = function (page) {
                return $scope.selPage == page;
            };
            //上一页
            $scope.Previous = function () {
                $scope.selectPage($scope.selPage - 1);
            };
            //下一页
            $scope.Next = function () {
                $scope.selectPage($scope.selPage + 1);
            };
        }

    });
    app.controller('honorCtrl', function ($scope, $http) {
        $http({
            url: '${wlpt}/wlpt/credit/getCarOwner',
            method: 'GET',
            params: {
                'user.id': $('#userid').val()
            }
        }).success(function (response) {
            $scope.honors = response.value.honors;
            if(response.value.honors.length==0){
            	$("#pic").show();
            }
        });

    });

    app.directive('star', function () {
        return {
            template: '<ul class="rating" ng-mouseleave="leave()">' +
            '<li ng-repeat="star in stars" ng-class="star" ng-click="click($index + 1)" ng-mouseover="over($index + 1)">' +
            '\u2605' +
            '</li>' +
            '</ul>',
            scope: {
                ratingValue: '=',
                max: '=',
                readonly: '@',
                onHover: '=',
                onLeave: '='
            },
            controller: function ($scope) {
                $scope.ratingValue = $scope.ratingValue || 0;
                $scope.max = $scope.max || 5;
                $scope.click = function (val) {
                    if ($scope.readonly && $scope.readonly === 'true') {
                        return;
                    }
                    $scope.ratingValue = val;
                };
                $scope.over = function (val) {
                    $scope.onHover(val);
                };
                $scope.leave = function () {
                    $scope.onLeave();
                }
            },
            link: function (scope, elem, attrs) {
                elem.css("text-align", "center");
                var updateStars = function () {
                    scope.stars = [];
                    for (var i = 0; i < scope.max; i++) {
                        scope.stars.push({
                            filled: i < scope.ratingValue
                        });
                    }
                };
                updateStars();

                scope.$watch('ratingValue', function (oldVal, newVal) {
                    if (newVal) {
                        updateStars();
                    }
                });
                scope.$watch('max', function (oldVal, newVal) {
                    if (newVal) {
                        updateStars();
                    }
                });
            }
        };
    });
</script>
</body>
</html>
