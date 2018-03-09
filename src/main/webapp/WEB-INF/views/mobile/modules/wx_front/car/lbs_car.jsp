<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no"/>
    <style type="text/css">
        body, html {
            width: 100%;
            height: 100%;
            margin: 0;
            font-family: "微软雅黑";
            font-size: 14px;
        }

        #l-map {
            width: 100%;
            height: 500px;
            overflow: hidden;
        }

        #result {
            width: 100%;
        }

        li {
            line-height: 28px;
        }

        .cityList {
            height: 320px;
            width: 372px;
            overflow-y: auto;
        }

        .sel_container {
            z-index: 9999;
            font-size: 12px;
            position: absolute;
            right: 0px;
            top: 0px;
            width: 140px;
            background: rgba(255, 255, 255, 0.8);
            height: 30px;
            line-height: 30px;
            padding: 5px;
        }

        .map_popup {
            position: absolute;
            z-index: 200000;
            width: 382px;
            height: 344px;
            right: 0px;
            top: 40px;
        }

        .map_popup .popup_main {
            background: #fff;
            border: 1px solid #8BA4D8;
            height: 100%;
            overflow: hidden;
            position: absolute;
            width: 100%;
            z-index: 2;
        }

        .map_popup .title {
            background: url("http://map.baidu.com/img/popup_title.gif") repeat scroll 0 0 transparent;
            color: #6688CC;
            font-weight: bold;
            height: 24px;
            line-height: 25px;
            padding-left: 7px;
        }

        .map_popup button {
            background: url("http://map.baidu.com/img/popup_close.gif") no-repeat scroll 0 0 transparent;
            cursor: pointer;
            height: 12px;
            position: absolute;
            right: 4px;
            top: 6px;
            width: 12px;
        }
    </style>
    <script type="text/javascript" src="${ctxStatic }/weixin/js/jquery-1.7.2.js"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=3.0&ak=80f73f31cfbb40be26acda67af03da43"></script>
    <!-- 加载百度地图样式信息窗口 -->
    <script type="text/javascript" src="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.js"></script>

    <link rel="stylesheet" href="http://api.map.baidu.com/library/SearchInfoWindow/1.5/src/SearchInfoWindow_min.css"/>
    <link href="${ctxStatic}/bootstrap/2.3.1/css_cerulean/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <title>平台车辆展示</title>
</head>
<body>
<div id="pageMiddle" style="width:97%;margin:0 auto;height: 40px; padding-top: 10px">
        <div id="toolsBar" class="clearfix">
            <div class="pull-left">
                <input type="search" id="keyword" class="input-large search-query" placeholder="输入检索关键字">
                <span class="btn btn-primary" id="searchBtn">搜索</span>
            </div>
        </div>
</div>

<div id="l-map" style="height:100%;width:97%;margin:0 auto;"></div>

</body>
</html>
<script type="text/javascript">
    // 百度地图API功能
    var map = new BMap.Map("l-map");          // 创建地图实例
    map.enableScrollWheelZoom();
    map.addControl(new BMap.NavigationControl());  //添加默认缩放平移控件
    map.addControl(new BMap.GeolocationControl());  //定位控件
    map.centerAndZoom("邯郸", 12);
    var geolocation = new BMap.Geolocation();
    geolocation.getCurrentPosition(function(r){
        if(this.getStatus() == BMAP_STATUS_SUCCESS){
            var mk = new BMap.Marker(r.point);
            var label = new BMap.Label("当前位置", {
                offset : new BMap.Size(20, -10)
            });
            mk.setLabel(label);
            map.addOverlay(mk);
            map.panTo(r.point);
            map.centerAndZoom(r.point, 12);
        }
        else {
            alert('failed'+this.getStatus());
        }
    },{enableHighAccuracy: true});

    var customLayer=new BMap.CustomLayer({geotableId:'141452',ak:'80f73f31cfbb40be26acda67af03da43'});
    map.addTileLayer(customLayer);
    customLayer.addEventListener('hotspotclick',callback);

    map.addEventListener("dragstart", function(e){
    	   //alert(e);
    	map.centerAndZoom(new BMap.Point(e.point.lng,e.point.lat),map.getZoom());
    	});
    
    function callback(e)//单击热点图层
    {
        var customPoi = e.customPoi;//poi的默认字段
        var contentPoi=e.content;//poi的自定义字段
        var gpstime;
        var address;
        if(contentPoi.gpstime){
            gpstime=contentPoi.gpstime;
        }else {
            gpstime='无定位时间';
        }
        if(contentPoi.address){
            address=contentPoi.address;
        }else {
            address='当前无定位';
        }

        var content = '<p style="width:280px;margin:0;line-height:20px;">联系方式：'+ contentPoi.mobile +' <br/> 车辆状态：'+contentPoi.state +' <br/>地址：' + address +'<br/> 最后定位时间：'+gpstime+' </p>';

        var searchInfoWindow = new BMapLib.SearchInfoWindow(map, content, {
            title: customPoi.title, //标题
            width: 350, //宽度
            height: 120, //高度
            panel : "panel", //检索结果面板
            enableAutoPan : false, //自动平移
            enableSendToPhone: false, //是否显示发送到手机按钮
            searchTypes :[
            ]
        });
        var point = new BMap.Point(customPoi.point.lng, customPoi.point.lat);
        searchInfoWindow.open(point);
    }
    //绑定检索按钮事件
    $('#searchBtn').bind('click', function () {
        keyword = $('#keyword').val();
        if(keyword){
            searchAction(keyword);
        }else{
            map.clearOverlays();
            customLayer=new BMap.CustomLayer({geotableId:'141452',ak:'80f73f31cfbb40be26acda67af03da43'});
            map.addTileLayer(customLayer);
            customLayer.addEventListener('hotspotclick',callback);
        }
    });

    /**
     * 进行检索操作
     * @param 关键词
     * @param 当前页码
     */
    function searchAction(keyword) {
        var url = "http://api.map.baidu.com/geosearch/v2/local?callback=?";
        $.getJSON(url, {
            'q': keyword, //检索关键字
            'geotable_id': 141452,
            'ak': '80f73f31cfbb40be26acda67af03da43'  //用户ak
        }, function (e) {
            renderMap(e);
        });
    }


    /**
     * 渲染地图模式
     * @param result
     * @param page
     */
    function renderMap(res) {
        var content = res.contents;
        map.clearOverlays();

        if (content.length == 0) {
            alert("未找到查找的车辆");
            return;
        }
        map.removeTileLayer(customLayer);
        var myIcon = new BMap.Icon("${ctxStatic }/images/weixin/hctb.png", new BMap.Size(30,50));

        $.each(content, function (i, item) {
            var point = new BMap.Point(item.location[0], item.location[1]), marker = new BMap.Marker(point,{icon:myIcon});
            marker.addEventListener('click', showInfo);
            function showInfo() {
                var gpstime;
                var address;
                if(item.gpstime){
                    gpstime=item.gpstime;
                }else {
                    gpstime='无定位时间';
                }
                if(item.address){
                    address=item.address;
                }else {
                    address='当前无定位';
                }

                var content = '<p style="width:280px;margin:0;line-height:20px;">联系方式：' + item.mobile + ' <br/> 车辆状态：' + item.state + ' <br/>地址：' + address + '<br/> 最后定位时间：' + gpstime + ' </p>';

                //创建检索信息窗口对象
                var searchInfoWindow = new BMapLib.SearchInfoWindow(map, content, {
                    title: item.title, //标题
                    width: 350, //宽度
                    height: 120, //高度
                    panel: "panel", //检索结果面板
                    enableAutoPan: false, //自动平移
                    enableSendToPhone: false, //是否显示发送到手机按钮
                    searchTypes: []
                });
                searchInfoWindow.open(marker);
            }
            map.addOverlay(marker);
        });
    };


</script>
