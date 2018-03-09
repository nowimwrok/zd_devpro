<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>货源管理</title>

    <style type="text/css">
        .loading {
            text-align: center;
        }

        .form-control {
            border: 1px solid #ccc !important;
        }

        .table > tbody > tr > td, .table > tbody > tr > th, .table > tfoot > tr > td, .table > tfoot > tr > th, .table > thead > tr > td, .table > thead > tr > th {
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
<body style="background: #f5f5f5;">
<div ng-app="dataHall" ng-controller="dataHallCtrl">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel" style="margin-bottom:40px;">
                <div class="form_container">
                    <h4 class="panel-heading ">货源管理</h4>
                </div>
                <div class="panel-body" style="margin-bottom:40px;">
                    <div class="col-lg-12 search_wrap">
                        <form action="" method="get" class="search-bar" style="text-align: center">
                            <div class="col-sm-2">
                                <input id="fromprovince" type="hidden" class="search-in"
                                       ng-model="searchData.fromprovince" name="search-in"/>
                                <input id="fromcity" type="hidden" class="search-in" ng-model="searchData.fromcity"
                                       name="search-in"/>
                                <input id="fromdistrict" type="hidden" class="search-in"
                                       ng-model="searchData.fromdistrict" name="search-in"/>
                                <input type="text" readonly="readonly" class="form-control" id="addressStart"
                                       placeholder="出发地">
                            </div>
                            <div class="col-sm-2">
                                <input id="toprovince" type="hidden" class="search-in" ng-model="searchData.toprovince"
                                       name="search-in"/>
                                <input id="tocity" type="hidden" class="search-in" ng-model="searchData.tocity"
                                       name="search-in"/>
                                <input id="todistrict" type="hidden" class="search-in" ng-model="searchData.todistrict"
                                       name="search-in"/>
                                <input type="text" readonly="readonly" id="addressEnd" class="form-control"
                                       placeholder="目的地">
                            </div>
                            <div class="col-sm-2">
                                <select id="tradestatus" class="form-control" ng-model="searchData.tradestatus">
                                    <option value="">报价状态</option>
                                    <option value="0">未报价</option>
                                    <option value="1">已报价</option>
                                    <option value="2">报价完成</option>
                                </select>
                            </div>
                            <div class="col-sm-4 text-left">
                                <button type="button" name="search-btn" id="search-btn" ng-click="searchInfo()"
                                        class="btn btn-primary"><i class="fa fa-search white"></i>
                                    查询
                                </button>
                                <a class="btn btn-success" id="fabu" 
                                   ng-click="check('${wlpt}/wlpt/goods/toSave');">
                                    <i class="fa fa-plus-square white"> </i> 发布货源
                                </a>
                            </div>
                        </form>
                    </div>
                    <div style="overflow: auto;width: 100%;">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>货物名称</th>
                                <th>运量</th>
                                <th>剩余量</th>
                                <th>始发地-目的地</th>
                                <th>发货日期</th>
                                <th>报价信息</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody class="datainit">
                            <tr ng-repeat="x in data">
                                <td ng-cloak>
                                    {{x.goodsname}}
                                    <span ng-show="x.isinsur == 1" style="color: red;font-size: 12px;">(投保)</span>
                                </td>
                                <td ng-cloak>{{x.freightvolume | number:3}}{{x.freightunit}}
                                </td>
                                <td ng-cloak>
                                    {{x.residualvolume | number:3}}{{x.freightunit}}
                                </td>
                                <td ng-cloak>
                                    {{x.shipAddress.city}}{{x.shipAddress.district}}→{{x.consignAddress.city}}{{x.consignAddress.district}}
                                </td>
                                <td ng-cloak>{{x.ymdDate}}</td>
                                <td ng-cloak>{{x.quotecount}}人报价</td>
                                <td>
                                    <!-- <a ng-click="getObjDetail(x.id)" class="see oprate" data-toggle="modal"
                                       data-target="#modal">详情</a> -->
                                    
                                    <a ng-show="x.tradestatus != 0"
                                       href="${wlpt}/wlpt/goods/toQuoteInfo?id={{x.id}}&topmenu=top-menu-goods"
                                       class="see oprate">查看报价</a>
                                    <a ng-show="x.residualvolume>0" href="${wlpt}/wlpt/goods/toAddQuote?id={{x.id}}"
                                       class="green oprate">添加报价</a>
                                    <a ng-show="x.tradestatus == 0" href="${wlpt}/wlpt/goods/toSave?id={{x.id}}"
                                       class="green oprate">编辑</a>
                                    <a ng-show="x.tradestatus == 0 && x.datasource == 0" href="javascript:"
                                       ng-click="isDelete(x.id)" class="orange oprate">删除</a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div id="noneData" style="display:none;text-align: center;width: 100%;line-height: 25px;">
                        <img src="${ctxStatic }/front/img/nodata.png" style="width: 100px;height: 100px;">
                    </div>
                    
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
                    <h4 class="modal-title">货源详情</h4>
                </div>
                <div class="modal-body  modal-body-h" style="overflow:scroll;">
                    <div class="col-sm-12">
                        <table class="table table-bordered">
                            <div class="form_container">
                                <h4 class="panel-heading">
                                    货源信息
                                </h4>
                            </div>
                            <tr>
                                <td class="text-center" rowspan="4" style="vertical-align: middle;">
                                    <div class="col-sm-12 control-label">货物信息</div>
                                </td>
                                <td>
                                    <div class="col-sm-4">
                                        货物名称
                                    </div>
                                    <div class="col-sm-8" ng-cloak>
                                        {{detal.goods.goodsname}}
                                    </div>
                                </td>
                                <td>
                                    <div class="col-sm-4">
                                        货物数量
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.goods.freightvolume}} {{detal.goods.freightunit}}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="col-sm-4">
                                        货物类别
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.goods.gsoddtype}}
                                    </div>
                                </td>
                                <td>
                                    <div class="col-sm-4">
                                        货物类型
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.goods.goodstype}}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_br_none">
                                    <div class="col-sm-4">
                                        装车时间
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.sendtime}}
                                    </div>
                                </td>
                                <td class="td_br"></td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="col-sm-4">
                                        报价次数
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.goods.quotecount}}
                                    </div>
                                </td>
                                <td>
                                    <div class="col-sm-4">
                                        交易状态
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.goods.tradestatus}}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="text-center" rowspan="4" style="vertical-align: middle;">
                                    <div class="col-sm-12 control-label">运输信息</div>
                                </td>
                                <td>
                                    <div class="col-sm-4">
                                        始发地
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.goods.shipAddress.province}}
                                        {{detal.goods.shipAddress.city}}
                                        {{d.goods.shipAddress.district}}
                                    </div>
                                </td>
                                <td>
                                    <div class="col-sm-4">
                                        详细地址
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.goods.shipAddress.address}}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_br_none">
                                    <div class="col-sm-4">
                                        发货人
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.goods.shipAddress.linkman}}\
                                        {{detal.goods.shipAddress.linkmobile}}
                                    </div>
                                </td>
                                <td class="td_br"></td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="col-sm-4">
                                        目的地
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.goods.consignAddress.province}}
                                        {{detal.goods.consignAddress.city}}
                                        {{detal.goods.consignAddress.district}}
                                    </div>
                                </td>
                                <td>
                                    <div class="col-sm-4">
                                        详细地址
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.goods.consignAddress.address}}
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_br_none">
                                    <div class="col-sm-4">
                                        收货人
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.goods.consignAddress.linkman}}\
                                        {{detal.goods.consignAddress.linkmobile}}
                                    </div>
                                </td>
                                <td class="td_br"></td>
                            </tr>
                            <tr>
                                <td class="text-center" rowspan="4" style="vertical-align: middle;">
                                    <div class="col-sm-12 control-label">其他信息</div>
                                </td>
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
                                        {{detal.bidinfo.goods.cartype}}米
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="td_br_none">
                                    <div class="col-sm-4">
                                        运输方式
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.goods.transportway}}
                                    </div>
                                </td>
                                <td class="td_br"></td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="col-sm-4">
                                        货物价值
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.goods.worth}}
                                    </div>
                                </td>
                                <td>
                                    <div class="col-sm-4">
                                        期望价格
                                    </div>
                                    <div class="col-sm-8">
                                        {{detal.goods.expectedprice}}
                                    </div>
                                </td>
                            </tr>

                            <tr>
                                <td colspan='2'>

                                    <div class="col-sm-8">
                                        备注： {{detal.bidinfo.remarks}}
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="modal-body" style="overflow:scroll;" ng-if="detal.blinfoList.length>0">
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
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>

<script type="text/javascript">
    $("#maskloading" , parent.document).hide();
    var app = angular.module('dataHall', ['tm.pagination']);
    app.controller('dataHallCtrl', ['$scope', '$http', function ($scope, $http) {
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
            if( $scope.paginationConf.currentPage ==1){
                $scope.paginationConf.currentPage = 0;
            }else{
                $scope.paginationConf.currentPage = 1;
            }        };
        var GetAllEmployee = function () {
            var postData = {
                'shipAddress.province': $("#fromprovince").val(),
                'shipAddress.city': $("#fromcity").val(),
                'shipAddress.district': $("#fromdistrict").val(),
                'consignAddress.province': $("#toprovince").val(),
                'consignAddress.city': $("#tocity").val(),
                'consignAddress.district': $("#todistrict").val(),
                'tradestatus': $("#tradestatus").val(),
                pageNo: $scope.paginationConf.currentPage,
                pageSize: $scope.paginationConf.itemsPerPage
            };
            $http({
                url: '${wlpt}/wlpt/goods/getGoodsList',
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
            $http.get("${wlpt}/wlpt/goods/getDetail?id=" + id).success(function (response) {
                $scope.detal = response.data;/// 招标详情
            });
        };
        $scope.check=function (url) {
        	var status = "${user.userinfo.status}";
            if (status != '2') {
                $.MsgBox.Alert("温馨提示", "您还未认证");
            }else{
            	window.location.href = url;
            }
        };
        $scope.isDelete = function (id) {

            if (id == null || id == "") {
                return;
            }
           // $(".loading_lock").show();
            $.MsgBox.Confirm("删除提示","是否删除该货源?", function () {
            	$("#maskloading" , parent.document).show();
            	$.ajax({
                    url: "${wlpt}/wlpt/goods/deleteGoods",
                    data: {
                        id: id,
                    },
                    dataType: 'json',
                    cache: false,
                    success: function (data) {
                        $.MsgBox.Alert("删除提示",data.value);
                        GetAllEmployee();
                    }
                });
            }, function () {
            	$("#maskloading" , parent.document).hide();
            });
        };
        /***************************************************************
         当页码和页面记录数发生变化时监控后台查询
         如果把currentPage和itemsPerPage分开监控的话则会触发两次后台事件。
         ***************************************************************/
        $scope.$watch('paginationConf.currentPage + paginationConf.itemsPerPage', GetAllEmployee);
    }]);

</script>
<script>
    if ('${isRedrect}' == 'true') {
        $("#fromprovince").val($.cookie("goods_fromprovince"));
        $("#fromcity").val($.cookie("goods_fromcity"));
        $("#fromdistrict").val($.cookie("goods_fromdistrict"));
        $("#toprovince").val($.cookie("goods_toprovince"));
        $("#tocity").val($.cookie("goods_tocity"));
        $("#todistrict").val($.cookie("goods_todistrict"));
        $("#tradestatus").val($.cookie("goods_tradestatus"));
    }

    $("#addressStart").PCC({
        hasCounty: true,
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
            if (data.county) {
                str += data.county.NAME;
                $("#fromdistrict").val(data.county.NAME);
            }
            $("#addressStart").val(str);
        }
    });

    $("#addressEnd").PCC({
        hasCounty: true,
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
            if (data.county) {
                str += data.county.NAME;
                $("#todistrict").val(data.county.NAME);
            }
            $("#addressEnd").val(str);
        }
    });

    var bheight = document.documentElement.clientHeight;
	var bwidth = document.documentElement.clientWidth;
  //弹框
    $('#modal').css('width', bwidth*.76+'px').css('height',bheight*.8+ 'px');
    $('.modal-body-h').css('height', bheight*.8+ 'px');
</script>
</body>
</html>
