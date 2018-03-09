<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Cache-Control" content="no-cache, must-revalidate"> 
		<meta http-equiv="expires" content="0">
		<meta http-equiv="Pragma" content="no-cache" />
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>我的招标</title>
    <style type="text/css">
        .loading {
            text-align: center;
        }

        .form-control {
            border: 1px solid #ccc !important;
        }

        .table > tbody > tr > td, .table > tbody > tr > th, .table > tfoot > tr > td, .table > tfoot > tr > th,
        .table > thead > tr > td, .table > thead > tr > th {
            padding: 10px;
            line-height: 1.42857143;
            border-bottom: 1px solid #ddd;
            font-size: 13px;
            vertical-align: bottom;
            white-space: nowrap;
            box-sizing: border-box;
        }

        .table-bordered > tbody > tr > td {
            border: 1px solid #000;
            color: #000;
        }

        #modal td {
            line-height: 40px;
            padding: 0;
        }
        #modal .td_br{
            border: none!important;
            border-right: 1px solid #000000!important;
        }
        #modal .td_br_none{
            border-right: none!important;
        }
        #modal .col-sm-4, #modal .col-sm-2, #modal .col-sm-3, #modal .col-sm-6 {
            border-right: 1px solid #000;
        }

    </style>

</head>
<body style="background: #f5f5f5;overflow-x:hidden">
<div ng-app="bid" ng-controller="bidCtrl">
    <input type="hidden" id="loginUser" value="${loginUser.id}">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel">
                <div class="form_container">
                    <h4 class="panel-heading ">我的招标</h4>
                </div>
                <div class="panel-body" style="margin-bottom:40px;">
                    <div class="col-lg-12 search_wrap">
                        <form action="" method="get" class="search-bar"
                              style="text-align: center">
                            <div class="col-sm-2">
                                <input class="form-control" placeholder="招标文号"
                                       ng-model="bidcode" id="bidcode">
                            </div>
                            <div class="col-sm-2">
                                <input class="form-control" placeholder="货物名称"
                                       ng-model="goodsName" id="goodsName">
                            </div>
                            <div class="col-sm-2">
                                <input id="fromprovince" type="hidden" class="tender_search"
                                       ng-model="fromprovince"/> <input id="fromcity" type="hidden"
                                                                        class="tender_search"
                                                                        ng-model="fromcity"/><input
                                    type="text" readonly="readonly" class="form-control"
                                    id="addressStart" placeholder="出发地">
                            </div>
                            <div class="col-sm-2">
                                <input id="toprovince" type="hidden" class="tender_search"
                                       ng-model="toprovince"/> <input id="tocity" type="hidden"
                                                                      class="tender_search" ng-model="tocity"/><input
                                    type="text"
                                    readonly="readonly" id="addressEnd" class="form-control"
                                    placeholder="目的地">
                            </div>
                            <div class="col-sm-4 text-left">
                                <button type="button" name="search-btn" id="search-btn"
                                        ng-click="searchInfo()" class="btn btn-primary">
                                    <i class="fa fa-search white"></i> 搜索
                                </button>
                                <a class="btn btn-success" id="fabu" ng-click="check('${wlpt}/wlpt/bid/publshBid');">
                                    <i class="fa fa-plus-square white"> </i> 发布
                                </a>
                            </div>
                            <div class="col-sm-1">

                            </div>
                        </form>
                    </div>
                    <div style="overflow: auto;width: 100%;">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>招标文号</th>
                                <th>货品名称</th>
                                <th>运量</th>
                                <th>运输信息</th>
                                <th>状态</th>
                                <th>发布时间</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody class="datainit">
                            <tr ng-repeat="x in data">
                                <td><a class="see" ng-click="getObjDetail(x.id)" data-toggle="modal"
                                       data-target="#modal">{{x.bidcode}}</a></td>

                                <td title="" ng-cloak>{{x.goods.goodsname}}
                                </td>
                                <td>{{x.goods.freightvolume| number : 3}}{{x.goods.freightunit}}
                                </td>
                                <td title="" ng-cloak>{{x.goods.shipAddress.city}} -
                                    {{x.goods.consignAddress.city}}
                                </td>
                                <td>
                                    <span ng-cloak ng-if="(x.bidstatus=='草稿')" class="deep_greeen">{{x.bidstatus}}</span>
                                    <span ng-cloak ng-if="(x.bidstatus=='发布')" class="green">竞标中</span>
                                    <span ng-cloak ng-if="(x.bidstatus=='正在交易中')" class="blue">{{x.bidstatus}}</span>
                                    <span ng-cloak ng-if="(x.bidstatus=='废标')" class="red">{{x.bidstatus}}</span>
                                    <span ng-cloak ng-if="(x.bidstatus=='已截标')" class="dark_yellow">{{x.bidstatus}}</span>
                                    <span ng-cloak ng-if="(x.bidstatus=='交易完成')" class="orange">{{x.bidstatus}}</span>
                                </td>
                                <td ng-cloak>{{x.publishtime.substr(0,16)}}</td>
                                <td ng-cloak>
                                    <!-- <a class="see oprate" ng-click="getObjDetail(x.id)" data-toggle="modal"
                                       data-target="#modal">
                                        详情</a> -->
                                    
                                    <a class="green oprate" href="${wlpt}/wlpt/bid/goSelectBid?bidinfoId={{x.id}}"
                                       ng-if="x.bidstatus!='废标'&& x.bidstatus!='草稿'">选标结果({{x.biddingcount}})
                                    </a>
                                    <a class="red oprate" ng-if="x.bidstatus=='已截标'" href="javascript:void(0)"
                                       ng-click="repealBid(x.id)">废标
                                    </a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div id="noneData"
                         style="display: none; text-align: center; width: 100%; line-height: 25px;">
                        <img src="${ctxStatic }/front/img/nodata.png"
                             style="width: 100px; height: 100px;">
                    </div>
                    <!-- <div class="loading">
                        <img src="/static/images/loading.gif">
                        <p>加载中</p>
                    </div> -->

                    <!--分页-->
                    <tm-pagination conf="paginationConf"></tm-pagination>
                </div>
            </div>

        </div>
    </div>

    <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="modal" class="modal"
         style="margin:auto;overflow-y:hidden;">
        <div>
            <div class="modal-content">
                <div class="modal-header">
                    <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×</button>
                    <h4 class="modal-title">招标详情</h4>
                </div>
                <div class="modal-body modal-body-h" style="overflow:scroll;">
                    <div class="col-sm-12">
                        <table class="table table-bordered">
                            <div class="form_container">
                                <h4 class="panel-heading">
                                    招标信息
                                </h4>
                            </div>
                            <tr>
                                <td class="text-center" rowspan="3" style="vertical-align: middle;">
                                    <div class="col-sm-12 control-label">招标货物</div>
                                </td>
                                <td>
                                    <div class="col-sm-4">
                                        招标文号
                                    </div>
                                    <div class="col-sm-8" ng-cloak>
                                        {{detal.bidinfo.bidcode}}
                                    </div>
                                </td>
                                <td>
                                    <div class="col-sm-4">
                                        招标状态
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.bidstatus}}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="col-sm-4">
                                        拦标价
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.bidinfo.expectedprice}}元/{{detal.bidinfo.goods.freightunit}}
                                    </div>
                                </td>
                                <td>
                                    <div class="col-sm-4">
                                        应标次数
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.bidinfo.biddingcount}}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="col-sm-4">发布时间</div>
                                    <div class="col-sm-8"> {{detal.bidinfo.publishtimeFM}}</div>
                                </td>
                                <td>
                                    <div class="col-sm-4">截止时间</div>
                                    <div class="col-sm-8" id="endtime">{{detal.bidinfo.endtimeFM}}</div>
                                </td>
                            </tr>
                            <!-- <tr>
                                <td class="td_br_none">
                                    <div class="col-sm-4">倒计时</div>
                                    <div class="col-sm-8">
                                        <span id="endtimes">0天0时0分0秒</span>
                                    </div>
                                </td>
                                <td class="td_br"></td>
                            </tr> -->
                            <tr>
                                <td class="text-center" rowspan="2" style="vertical-align: middle;">
                                    <div class="col-sm-12 control-label">货物信息</div>
                                </td>
                                <td>
                                    <div class="col-sm-4">
                                        招标货物
                                    </div>
                                    <div class="col-sm-8" ng-cloak>
                                        {{detal.bidinfo.goods.goodsname}}
                                    </div>
                                </td>
                                <td>
                                    <div class="col-sm-4">
                                        货物数量
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.bidinfo.goods.freightvolume}} {{detal.bidinfo.goods.freightunit}}
                                    </div>
                                </td>

                            </tr>
                            <tr>
                                <td class="td_br_none">
                                    <div class="col-sm-4">
                                        货物类别
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.bidinfo.goods.gsoddtype}}
                                    </div>
                                </td>
                                <td class="td_br"></td>
                            </tr>
                            <tr>
                                <td class="text-center" rowspan="2" style="vertical-align: middle;">
                                    <div class="col-sm-12 control-label">运输信息</div>
                                </td>
                                <td>
                                    <div class="col-sm-4">
                                        始发地
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.bidinfo.goods.shipAddress.province}}
                                        {{detal.bidinfo.goods.shipAddress.city}}
                                        {{d.bidinfo.goods.shipAddress.district}}
                                    </div>
                                </td>
                                <td>
                                    <div class="col-sm-4">
                                        详细地址
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.bidinfo.goods.shipAddress.address}}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="col-sm-4">
                                        目的地
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.bidinfo.goods.consignAddress.province}}
                                        {{detal.bidinfo.goods.consignAddress.city}}
                                        {{detal.bidinfo.goods.consignAddress.district}}
                                    </div>
                                </td>
                                <td>
                                    <div class="col-sm-4">
                                        详细地址
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.bidinfo.goods.consignAddress.address}}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="text-center" rowspan="3" style="vertical-align: middle;">
                                    <div class="col-sm-12 control-label">其他信息</div>
                                </td>
                                <td>
                                    <div class="col-sm-4">
                                        整标价
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.bidinfo.expectedprice*detal.bidinfo.goods.freightvolume | number : 2}}元
                                    </div>
                                </td>
                                <td>
                                    <div class="col-sm-4">
                                        是否开发票
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.bidinfo.isbill==1?'是':'否'}}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="col-sm-4">
                                        车型要求
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.bidinfo.goods.cartype}}
                                    </div>
                                </td>
                                <td>
                                    <div class="col-sm-4">
                                        车长要求
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.bidinfo.goods.carlength}}米
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td colspan='2'>


                                    <div class="col-sm-8">
                                       备注: {{detal.bidinfo.remarks}}
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-body" style="overflow-y:hidden;"  ng-if="detal.blinfoList.length>0">
                        <div class="panel clearfix">
                            <div class="form_container">
                                <h4 class="panel-heading">
                                    提货单
                                </h4>
                                <div class="col-sm-12 form-horizontal">
                                    <table class="table" id="delivery_order">
                                        <thead>
                                        <tr>
                                            <th>提货单号</th>
                                            <th>品名材质</th>
                                            <th>规格</th>
                                            <th>定尺\板宽</th>
                                            <th>数量\吨</th>
                                            <th>批次号</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <tr data-ng-repeat="d in detal.blinfoList">
                                            <td>{{d.contractno}}</td>
                                            <td>{{d.namematerials}}</td>
                                            <td>{{d.standard}}</td>
                                            <td>{{d.width}}</td>
                                            <td>{{d.quantity}}</td>
                                            <td>{{d.batch}}</td>
                                        </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<script src="${ctxStatic }/jquery-plugin/jquery.cookie.js"></script>
<script type="text/javascript"
        src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>

<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js"
        type="text/javascript"></script>


<script>

    if ('${isRedrect}' == 'true') {
        $("#fromprovince").val($.cookie("bid_fromprovince"));
        $("#fromcity").val($.cookie("bid_fromcity"));
        $("#addressStart").val($.cookie("bid_addressStart"));
        $("#toprovince").val($.cookie("bid_toprovince"));
        $("#tocity").val($.cookie("bid_tocity"));
        $("#addressEnd").val($.cookie("bid_addressEnd"));
        $("#bidcode").val($.cookie("bid_bidcode"));
        $("#goodsName").val($.cookie("bid_goodsName"));
    }
    $(".white_grey_table>tr td").eq(3).addClass("whi-grey-last");


    var app = angular.module('bid', ['tm.pagination']);
    app.controller('bidCtrl', ['$scope', '$http', function ($scope, $http) {
        //配置分页基本参数
        $scope.paginationConf = {
            currentPage: 1,
            itemsPerPage: 10
        };
        ////isloading ==1:加载数据2:查询不到数据3:查询到数据
        $scope.isloading = function (isloading) {
            if (isloading == 1) {
            	$("#maskloading" , parent.document).show();
                $("#noneData").hide();
                $(".datainit").show();
            } else if (isloading == 2) {
            	$("#maskloading" , parent.document).hide();
                $("#noneData").show();
                $(".datainit").hide();
            } else {
            	$("#maskloading" , parent.document).hide();
                $("#noneData").hide();
                $(".datainit").show();
            }
        };
        $scope.searchInfo = function () {
        	$("#maskloading" , parent.document).show();
            if ($scope.paginationConf.currentPage == 1) {
                $scope.paginationConf.currentPage = 0;
            } else {
                $scope.paginationConf.currentPage = 1;
            }
        };
        var GetAllEmployee = function () {
            var postData = {
                'bidcode': $scope.bidcode,
                'goods.goodsname': $scope.goodsName,
                'goods.shipAddress.province': $("#fromprovince").val(),
                'goods.shipAddress.city': $("#fromcity").val(),
                'goods.consignAddress.province': $("#toprovince").val(),
                'goods.consignAddress.city': $("#tocity").val(),
                'biduser.id': $("#loginUser").val(),
                pageNo: $scope.paginationConf.currentPage,
                pageSize: $scope.paginationConf.itemsPerPage
            };
            $http({
                url: '${wlpt}/wlpt/bid/getbidsList',
                method: 'post',
                params: postData
            }).success(function (response) {
                $scope.paginationConf.totalItems = response.value.count;
                $scope.data = response.value.list;
                if (!$scope.data) {
                    $scope.isloading(2);
                } else {
                    $scope.isloading(3);

                }
            });
        };

        $scope.getObjDetail = function (id) {
            $http.get("${wlpt}/wlpt/bid/getDetail?id=" + id).success(function (response) {
                $scope.detal = response.data;/// 招标详情
                $("#modal").show();
                GetRTime();
            });
        };
        $scope.repealBid = function (id) {
        	$.MsgBox.Confirm("系统提示", "确定废除该标吗？", function () {
	            $scope.isloading(1);
	            $http({
	                url: '${wlpt}/wlpt/bid/repealBid',
	                method: 'post',
	                params: {
	                    'id': id
	                }
	            }).success(function (data) {
	                $scope.isloading(3);
	                $.MsgBox.Alert("保存提示", data.message);
	                GetAllEmployee();
	            });
        	}, function () {
            	$("#maskloading" , parent.document).hide();
            });
        };
        $scope.check=function (url) {
        	var status = "${loginUser.userinfo.status}";
            if (status != '2') {
                $.MsgBox.Alert("温馨提示", "您还未认证");
            }else{
            	//window.location.href = url;
            	$('#sitbody_iframe', window.parent.document).attr("src",url);
            	//$("#sitbody_iframe").attr("src",url);
            }
        };
        /***************************************************************
         当页码和页面记录数发生变化时监控后台查询
         如果把currentPage和itemsPerPage分开监控的话则会触发两次后台事件。
         ***************************************************************/
        $scope.$watch('paginationConf.currentPage + paginationConf.itemsPerPage', GetAllEmployee);


    }]);

    $("#addressStart").PCC({
        hasCounty: false,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        //closeIcon: "static/images/pic12.gif",
        complete: function (data) {
            var str = "";
            if (data.province) {
                str += data.province.NAME;
                $("#fromprovince").val(data.province.NAME);
                //searchConditions.fromProvince = data.province.NAME;
            }
            if (data.city) {
                str += data.city.NAME;
                $("#fromcity").val(data.city.NAME);
                //searchConditions.fromCity = data.city.NAME;
            }
            $("#addressStart").val(str);
        }
    });

    $("#addressEnd").PCC({
        hasCounty: false,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        //closeIcon: "static/images/pic12.gif",
        complete: function (data) {
            var str = "";
            if (data.province) {
                str += data.province.NAME;
                $("#toprovince").val(data.province.NAME);
                //searchConditions.fromProvince = data.province.NAME;
            }
            if (data.city) {
                str += data.city.NAME;
                $("#tocity").val(data.city.NAME);
                //searchConditions.fromCity = data.city.NAME;
            }

            $("#addressEnd").val(str);
        }
    });
    
    /* function GetRTime() {
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

    setInterval(GetRTime, 0); */
    var bheight = document.documentElement.clientHeight;
	var bwidth = document.documentElement.clientWidth;
  //弹框
    $('#modal').css('width', bwidth*.76+'px').css('height',bheight*.8+ 'px');
    $('.modal-body-h').css('height', bheight*.8+ 'px');
</script>
</body>
</html>
