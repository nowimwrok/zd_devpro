<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>运输监控</title>

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
    </style>

</head>
<body style="background: #f5f5f5;">
<div ng-app="dataHall" ng-controller="dataHallCtrl">
    <div class="row">
        <div class="col-lg-12">
            <div class="panel">
                <div class="form_container">
                    <h4 class="panel-heading ">车辆监控</h4>
                </div>
                <div class="panel-body">
                    <div class="col-lg-12 search_wrap">
                        <div id="locationmap" style="width: 100%;height: 420px;"></div>
                    </div>
                    <div style="overflow: auto;width: 100%;">
                        <table class="table">
                            <thead>
                            <tr>
                                <th>运单号</th>
                                <th>运输／托运方</th>
                                <th>司机</th>
                                <th>手机号</th>
                                <th>车牌号</th>
                                <th>货物</th>
                                <th>运量</th>
                                <th>路线</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody class="datainit">
                            <tr ng-repeat="x in data">
                                <td ng-cloak>{{x.orderno}}</td>
                                <td ng-cloak><!--判断当前用户是否是买家-->
                                    <span ng-if="x.isBuyer">{{x.seller.loginName}}</span>
                                    <span ng-if="x.isBuyer==false">{{x.buyer.loginName}}</span>
                                </td>
                                <td ng-cloak>{{x.quoteinfo.driver.loginName}}</td>
                                <td ng-cloak>{{x.quoteinfo.driver.phone}}</td>
                                <td ng-cloak>{{x.quoteinfo.car.carnumber}}</td>
                                <td ng-cloak>{{x.quoteinfo.goods.goodsname}}</td>
                                <td ng-cloak>{{x.quoteinfo.oddloadweight}}{{x.quoteinfo.goods.freightunit}}</td>
                                <td ng-cloak>
                                    {{x.quoteinfo.goods.shipAddress.city}}{{x.quoteinfo.goods.shipAddress.district.substr(0,4)+'...'}}
                                    -
                                    {{x.quoteinfo.goods.consignAddress.city}}{{x.quoteinfo.goods.consignAddress.district.substr(0,4)+'...'}}
                                </td>
                                <td ng-cloak><span class="green">{{x.statusStr}}</span></td>
                                <td ng-cloak>
                                    <a class="oprate orange"  ng-if="x.quoteinfo.car.gpsCarInfo.cid.length==0">未开通定位</a>
                                    <a ng-show="x.islocated==0 && x.orderstatus!=2"
                                       ng-click="loadMap(x.createDate,x.payDate,x.quoteinfo.car.gpsCarInfo.cid,x.quoteinfo.car.gpsCarInfo.ckey)"
                                       class="oprate green">GPS轨迹回放</a>
                                    <a ng-show="x.islocated==1" ng-click="searchLocation(x.orderno)"
                                       class="oprate orange">LBS轨迹回放</a>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div id="noneData" style="display:none;text-align: center;width: 100%;line-height: 25px;">
                        <img src="${ctxStatic }/front/img/nodata.png" style="width: 100px;height: 100px;">
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
</div>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>

<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=YYnbCRSKd9CGoqfP6PcM5wNo"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/LuShu/1.2/src/LuShu_min.js"></script>

<script type="text/javascript">
    var bidorder_id = "${bidOrderinfo.id}";


    var map = new BMap.Map("locationmap", {
        minZoom: 4,
        maxZoom: 20
    }); // 创建Map实例
    map.setCurrentCity("邯郸"); // 设置地图显示的城市 此项是必须设置的
    map.enableScrollWheelZoom(true); //开启鼠标滚轮缩放
    //map.centerAndZoom("邯郸",13);         ///当前地方与等级
    map.centerAndZoom("邯郸", 10);


    var myIcon = new BMap.Icon(
        "http://cdn-img.easyicon.net/png/11298/1129853.gif",
        new BMap.Size(25, 25));
    map.centerAndZoom("邯郸", 10); // 初始化地图,设置中心点坐标和地图级


    var isReturn = false;

    var app = angular.module('dataHall', ['tm.pagination']);
    app.controller('dataHallCtrl', ['$scope', '$http', function ($scope, $http) {
        //配置分页基本参数
        $scope.paginationConf = {
            currentPage: 1,
            itemsPerPage: 15
        };
        $scope.bidorder_id = bidorder_id;
        ////isloading ==1:加载数据2:查询不到数据3:查询到数据
        $scope.isloading = function (isloading) {
            if (isloading == 1) {
            	$("#maskloading" , parent.document).show();
                $("#noneData").hide();
                $(".no-items").html('');
            } else if (isloading == 2) {
            	$("#maskloading" , parent.document).hide();
                $("#noneData").show();
                $(".no-items").html('');
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
                'id': $scope.bidorder_id,
                pageNo: $scope.paginationConf.currentPage,
                pageSize: $scope.paginationConf.itemsPerPage
            };
            $http({
                url: '${wlpt}/wlpt/trade/getBidTradeList',
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

        /***************************************************************
         当页码和页面记录数发生变化时监控后台查询
         如果把currentPage和itemsPerPage分开监控的话则会触发两次后台事件。
         ***************************************************************/
        $scope.$watch('paginationConf.currentPage + paginationConf.itemsPerPage', GetAllEmployee);

        $scope.searchLocation = function (orderno){
            var p1;
            var p2;
            var poline = [];
            var datainfo = {
                orderNo: orderno
            };
            $.ajax({
                url: "${wlpt}/wlpt/lbsinfo/getlocation",
                type: "POST",
                data: datainfo,
                async: false,
                success: function (data) {
                    $("input[name=loctPhone]").val(data.localphone);
                    if (data.state==1) {
                        var list = data.data.list;
                        var html = "";
                        /* $("#licont").nextAll().remove(); */

                        for (var i = 0; i < list.length; i++) {
                            /* html += fillOneData(list[i]); */
                            ///定位的位置是有偏差的所以进行了移动
                            p2 = new BMap.Point(
                                list[list.length - 1].lng,
                                list[list.length - 1].lat);
                            p1 = new BMap.Point(list[0].lng,
                                list[0].lat);
                            var firstpoint = new BMap.Point(
                                list[list.length - 1].lng,
                                list[list.length - 1].lat);
                            map.centerAndZoom(firstpoint, 10); // 初始化地图,设置中心点坐标和地图级别
                            var point = new BMap.Point(
                                list[i].lng,
                                list[i].lat);
                            poline.push(new BMap.Point(
                                list[i].lng,
                                list[i].lat));//折线
                            addMarker(point,
                                list[i].createtime, i,
                                list.length);
                        }
                        //当没有数据的时候以邯郸为中心
                        if (list.length <= 0) {
                            map.centerAndZoom("邯郸", 10); // 初始化地图,设置中心点坐标和地图级别
                        }
                        /* $("#ltcont li").first().nextAll().remove();
                         $("#ltcont li").first().css("display", "none");
                         $("#licont").after(html);
                         $("#allcount").html(data.allcount);
                         $("#pageCount").html(data.pageCount);
                         $("#curPage").html(data.curPage); */
                    } else {
                        /* $("#ltcont li").first().css("display", "none"); */
                        map.centerAndZoom("邯郸", 10); // 初始化地图,设置中心点坐标和地图级别
                    }
                },
                error: function () {
                    map.centerAndZoom("邯郸", 10); // 初始化地图,设置中心点坐标和地图级别
                }
            });
            var polyline = new BMap.Polyline(poline, {
                strokeColor: "blue",
                strokeWeight: 2,
                strokeOpacity: 0.5
            }); //创建折线
            // 编写自定义函数,创建标注
            function addMarker(point, info, curindex, maxindex) {
                var marker = new BMap.Marker(point);
                var opts = {
                    position: point, // 指定文本标注所在的地理位置
                    offset: new BMap.Size(20, -20)
                    //设置文本偏移量
                };
                var label = new BMap.Label(info, opts); // 创建文本标注对象
                label.setStyle({
                    color: "blue",
                    fontSize: "12px",
                    height: "20px",
                    lineHeight: "20px",
                    fontFamily: "微软雅黑"
                });
                marker.setLabel(label);
                map.addOverlay(marker);
                /* if(curindex==0||curindex>=maxindex){
                 marker.setAnimation(BMAP_ANIMATION_BOUNCE); //跳动的动画
                 var marker2 = new BMap.Marker(point,{icon:myIcon});  // 创建标注
                 map.addOverlay(marker2);              // 将标注添加到地图中
                 //map.addOverlay(polyline);   //增加折线
                 } */
            }

            var driving = new BMap.DrivingRoute(map, {
                renderOptions: {
                    map: map,
                    autoViewport: true
                }
            });
            driving.search(p1, p2, {
                waypoints: poline
            });//waypoints表示途经点
        };
        $scope.loadMap = function (btime,etime, vid, vKey) {
            if (btime != "" && btime != null) {
                btime = btime.replace(new RegExp("-", "gm"), "/");
                btime=(new Date(btime)).getTime();
            } else {
                btime = (new Date()).getTime(); //得到毫秒数
            }
            //btime = (new Date(btime)).getTime(); //得到毫秒数
            if (etime!="" && etime!=null) {
                etime = etime.replace(new RegExp("-", "gm"), "/");
                etime = (new Date(etime)).getTime(); //得到毫秒数
            } else {
                etime = (new Date()).getTime(); //得到毫秒数
            }
            var datas = {};
            datas.version = 1;
            datas.method = 'loadHistory';
            datas.vid = vid;
            datas.vKey = vKey;
            datas.bTime = btime;
            datas.eTime = etime;
            $.ajax({
                type: "get",
                url: "http://219.148.85.56:89/gpsonline/GPSAPI",
                data: datas,
                dataType: "json",
                success: function (data) {
                    if (data.history && data.history.length > 0) {
                        //设置地图中心点
                        var lng = data.history[0].lng
                            + data.history[0].lng_xz;
                        var lat = data.history[0].lat
                            + data.history[0].lat_xz;

                        var arrPois = [];
                        for (var i = 0; i < data.history.length; i++) {
                            var x = data.history[i].lng
                                + data.history[i].lng_xz;
                            var y = data.history[i].lat
                                + data.history[i].lat_xz;
                            arrPois[i] = new BMap.Point(x, y);
                        }
                        map.clearOverlays();
                        map.addOverlay(new BMap.Polyline(arrPois, {
                            strokeColor: '#111'
                        }));
                        var arrStartEnd = [];
                        arrStartEnd[0] = arrPois[0];
                        arrStartEnd[1] = arrPois[1];
                        //map.setViewport(arrStartEnd);
                        map.centerAndZoom(new BMap.Point(lng, lat),
                            14);
                        var lushu = new BMapLib.LuShu(
                            map,
                            arrPois,
                            {
                                defaultContent: "",
                                autoView: true,
                                icon: new BMap.Icon(
                                    '${ctxStatic }/images/car.png',
                                    new BMap.Size(52, 26),
                                    {
                                        anchor: new BMap.Size(
                                            27, 13)
                                    }),
                                speed: 4500,
                                enableRotation: true,//是否设置marker随着道路的走向进行旋转
                                landmarkPois: []
                            });
                        lushu.start();
                        //lushu.pause();
                        /*$("btn-warning").onclick = function () {
                         lushu.start();
                         };*/
                        $("stop").onclick = function () {
                            lushu.stop();
                        };
                        $("pause").onclick = function () {
                            lushu.pause();
                        };
                        $("pause").hide();
                        $("hide").onclick = function () {
                            lushu.hideInfoWindow();
                        };
                        $("show").onclick = function () {
                            lushu.showInfoWindow();
                        };
                        $("show").hide();
                        function $(element) {
                            return document.getElementById(element);
                        }
                    }else{
                    	$("#maskloading" , parent.document).hide();
                        $.MsgBox.Alert("查看提示","暂无定位");
                    }

                }
            });
        };

    }]);

</script>
</body>
</html>
