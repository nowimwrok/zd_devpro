<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>运输监控</title>


<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="/static/modules/wlpt/front/css/top_menu.css">

<link rel="stylesheet" type="text/css"
	href="/static/modules/wlpt/front/css/personal.css">

<style type="text/css">
em {
	font-style: normal;
	font-weight: 700;
	font-family: sans-serif;
}

.goods-manage td, .goods-manage th {
	text-align: center;
}

.white_grey_table td {
	text-align: center;
}

.white_grey_table td .whi-grey-btn a {
	padding: 3px 12px;
	display: block;
	width: 60%;
	margin: 0 auto;
}

.datainit {
	display: none;
}
</style>
</head>
<body scroll="no"
	style="width: 100%; height: 1000px; margin: 0 auto; text-align: center;"
	ng-app="dataHall" ng-controller="dataHallCtrl">
	<p class="user_data">
		<img src="${ctxStatic }/images/wlptfront/line-left.png"> <span
			class="title_blue">运输</span> <span class="title_orange">监控</span> <img
			src="${ctxStatic }/images/wlptfront/line-right.png">
	</p>
	<div style="width: 100%; height: 400px;" id="locationmap"></div>
	<table class="goods-manage tender_table">
		<tr class="goods_col_1" style="border: none;">
			<td style="width: 30%">货物信息</td>
			<td style="width: 30%">运输信息</td>
			<td style="width: 20%">状态</td>
			<td style="width: 20%">操作</td>
		</tr>

	</table>

	<div class="datainit">
		<sys:message content="${message}" />
		<table class="white_grey_table" ng-repeat="x in data">
			<tr></tr>
			<tr class="bg_grey">
				<td style="width: 28.5%; text-indent: 10px;">运单：{{x.orderno}}</td>
				<td style="width: 33%;">
					<!--判断当前用户是否是买家--> <span ng-if="x.isBuyer">托运方:{{x.seller.loginName}}</span>
					<span ng-if="x.isBuyer==false">运输方:{{x.buyer.loginName}}</span>
				</td>
				<td style="width: 18.5%; text-align: center"></td>
				<td style="width: 20%; text-indent: 10px;" class="whi-grey-last">{{x.updateDate}}</td>
			</tr>
			<tr>
				<td><h5>{{x.quoteinfo.goods.goodsname}}</h5>
					<p>{{x.quoteinfo.oddloadweight}}{{x.quoteinfo.goods.freightunit}}|{{x.quoteinfo.car.carnumber}}</p></td>
				<td>
					<p>
						{{x.quoteinfo.goods.shipAddress.city}}{{x.quoteinfo.goods.shipAddress.district.substr(0,4)+'...'}}
						<span class="glyphicon glyphicon-transfer icon_blue"></span>
						{{x.quoteinfo.goods.consignAddress.city}}{{x.quoteinfo.goods.consignAddress.district.substr(0,4)+'...'}}
					</p>
					<p>{{x.quoteinfo.driver.loginName}}&nbsp;{{x.quoteinfo.driver.phone}}</p>
				</td>
				<td>{{x.statusStr}}</td>
				<td class="whi-grey-last">
					<!--ng-if 判断状态是否为新运单状态-->
					<p class="whi-grey-btn"
						ng-if="x.quoteinfo.car.gpsCarInfo.cid.length<=0">
						<a style="background-color: #3C3C3C; color: #FFFACD"
							class="btn btn-warning">未开通定位</a>
					</p>
					<p class="whi-grey-btn"
						ng-if="x.islocated==0 && x.quoteinfo.car.gpsCarInfo.cid.length>0 &&x.orderstatus!=2">
						<a
							ng-click="loadMap(x.createDate,x.payDate,x.quoteinfo.car.gpsCarInfo.cid,x.quoteinfo.car.gpsCarInfo.ckey)"
							class="btn btn-warning">GPS轨迹回放</a>
					</p>
					<p class="whi-grey-btn" ng-if="x.islocated==1">
						<a ng-click="searchLocation(x.orderno)" class="btn btn-warning">LBS轨迹回放</a>
					</p>
				</td>
			</tr>
		</table>
	</div>
	<div class="loading">
		<img src="${ctxStatic }/images/loading.gif">
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
	<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js"
		type="text/javascript"></script>

	<script type="text/javascript"
		src="http://api.map.baidu.com/api?v=2.0&ak=YYnbCRSKd9CGoqfP6PcM5wNo"></script>
	<script type="text/javascript"
		src="http://api.map.baidu.com/library/LuShu/1.2/src/LuShu_min.js"></script>
	<script src="${ctxStatic}/modules/wlpt/front/js/angular/angular.min.js"></script>

	<script>
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

    ///定义module
    var app = angular.module("dataHall", []);
    ///控制方法
    app.controller('dataHallCtrl', function ($scope, $http) {
        $scope.currentPage = 1;
        $scope.pageSize = 4;
        $scope.bidorder_id = "${bidOrderinfo.id}";
        $scope.pages = [];
        $scope.searchLocation = function (orderno){
    		$.MsgBox.Confirm("系统提示", "平台运输轨迹包含收费服务，使用将收取服务费用${fns:getMsgLabel("zjxl006","zjxl_port","")}元，请仔细阅读<a target='_blank' onclick='openagreement(&quot;LocationService&quot;)' style='line-height: 30px;text-decoration: none;'>《平台定位增值服务协议》</a>，是否使用？", function () {	
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
                
		        }, function () {
		       	 $("#maskloading", parent.document).hide();
		        }, "是", "否");     
        }
        $scope.loadMap = function (btime,etime, vid, vKey) {
        	$.MsgBox.Confirm("系统提示", "平台运输轨迹包含收费服务，使用将收取服务费用${fns:getMsgLabel("zjxl009","zjxl_port","")}元，请仔细阅读<a target='_blank' onclick='openagreement(&quot;LocationService&quot;)' style='line-height: 30px;text-decoration: none;'>《平台定位增值服务协议》</a>，是否使用？", function () {	
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
                        ;

                    }else{
                    	$("#maskloading" , parent.document).hide();
                        $.MsgBox.Alert("查看提示","暂无定位");
                    }

                }
            });
        	}, function () {
		       	 $("#maskloading", parent.document).hide();
		    }, "是", "否");    
        };
        ////isloading ==1:加载数据2:查询不到数据3:查询到数据
        $scope.isloading = function (isloading) {
            if (isloading == 1) {
                $(".loading").show();
                $("#noneData").hide();
            } else if (isloading == 2) {
                $(".loading").hide();
                $("#noneData").show();
            } else {
                $(".loading").hide();
                $("#noneData").hide();
                $(".datainit").show();
            }
        };
        //get first page
        $http({
            url: '${wlpt}/wlpt/trade/getBidTradeList',
            method: 'post',
            params: {
                'id': $scope.bidorder_id,
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
            isReturn = true;
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
        ////分页查询
        $scope.onSelectPage = function (page) {
            //replace your real data
            $scope.isloading(1);
            $http({
                url: '${wlpt}/wlpt/trade/getBidTradeList',
                method: 'post',
                params: {
                    'id': $scope.bidorder_id,
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
    ///分页
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
    /* function loads(height) {


     var myFrameheight = height + 10;
     top.$("#myFrame").height(0); //清空父级iframe高度
     $("#myFrame", parent.document).height(myFrameheight < 500 ? 500 : myFrameheight);//重新设置父级iframe高度
     $(".container").height(myFrameheight < 500 ? 500 : myFrameheight);//重新设置container高度
     //
     top.top.$("#rightFrame").height(0); //用于每次刷新时控制IFRAME高度初始化
     var heights = height + 210;
     top.top.$("#rightFrame").height(heights < 500 ? 500 : heights);//重新设置父级的父级iframe高度

     }
     $(function () {
     var t = setInterval(function () {

     if (isReturn == true) {
     //重置页面高度
     loads($(".container").height());
     clearInterval(t);
     }
     }, 500)
     });*/
</script>
</body>
</html>
