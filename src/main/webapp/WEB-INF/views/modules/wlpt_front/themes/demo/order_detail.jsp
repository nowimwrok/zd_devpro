<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_personal_basic"/>
    <title>个人中心</title>
    <style type="text/css">

    </style>
</head>
<body style="background: #f5f5f5;">

<div>

    <!--两列-->
    <div class="row">
        <div class="col-lg-12">
            <div class="panel">
                <div class="panel-heading tab-panel-heading" style="margin-top: -1px;">
                    <ul class="nav nav-tabs tab-nav-tabs">
                        <li class="active"><a href="#waybill_track" data-toggle="tab">运单跟踪</a></li>
                        <li><a href="#trans_trail" data-toggle="tab">运输轨迹</a></li>
                        <li><a href="#trans_voucher" data-toggle="tab">运输凭证</a></li>
                        <li><a href="#receipt" data-toggle="tab">回执单</a></li>
                        <li><a href="#voucher" data-toggle="tab">评价</a></li>
                    </ul>
                </div>
                <div class="panel-body">
                    <div class="tab-content">
                        <div class="tab-pane fade in active" id="waybill_track">
                            <div class="timeline">
                                <div class="timeline-item">
                                    <div class="timeline-desk">
                                        <div class="panel">
                                            <div class="panel-body">
                                                <span class="arrow"></span>
                                                <span class="timeline-icon red"></span>
                                                <span class="timeline-date">2017-05-26<br/>09:00</span>
                                                <h1 class="red">发布货源</h1>
                                                <p>

                                                    <i class="fa fa-cube"></i>内贸卷 <span class="vertical-line">|</span>98.87吨
                                                    <br>
                                                    <i class="fa fa-map-marker"></i>广东省广州市天河区天河区元岗横路310号智慧PARk创意园B座505
                                                    <br>
                                                    <i class="fa fa-map-marker"></i>广东省广州市天河区天河区元岗横路310号智慧PARk创意园B座505
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="timeline-item alt">
                                    <div class="timeline-desk">
                                        <div class="panel">
                                            <div class="panel-body">
                                                <span class="arrow-alt"></span>
                                                <span class="timeline-icon green"></span>
                                                <span class="timeline-date">2016-10-26<br/>08:57:37</span>
                                                <h1 class="green">车主抢单</h1>
                                                <p>

                                                    <i class="fa fa-truck"></i>冀DP6413 <span
                                                        class="vertical-line">|</span>高栏车14.00米
                                                    <span class="vertical-line">|</span>报吨:9吨<span
                                                        class="vertical-line">|</span>报价:10.00元/吨
                                                    <span class="vertical-line">|</span>总运价:90.00元
                                                    <br/>

                                                    <i class="fa fa-user"></i>广东省广州市天河区天河区元岗横路310号智慧PARk创意园B座505

                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="timeline-item">
                                    <div class="timeline-desk">
                                        <div class="panel">
                                            <div class="panel-body">
                                                <span class="arrow"></span>
                                                <span class="timeline-icon blue"></span>
                                                <span class="timeline-date">2017-05-18<br/>14:30:35</span>
                                                <h1 class="blue">新运单</h1>
                                                <p>
                                                    <i class="fa  fa-users"></i>供货方：肥乡县 同意报价成功
                                                </p>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="timeline-item alt">
                                    <div class="timeline-desk">
                                        <div class="panel">
                                            <div class="panel-body">
                                                <span class="arrow-alt"></span>
                                                <span class="timeline-icon purple"></span>
                                                <span class="timeline-date">2017-05-18<br/>14:30:35</span>
                                                <h1 class="purple">已确认</h1>
                                                <p>
                                                    <i class="fa  fa-users"></i>运输方:昕晟车队同意运输
                                                </p>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="timeline-item">
                                    <div class="timeline-desk">
                                        <div class="panel">
                                            <div class="panel-body">
                                                <span class="arrow"></span>
                                                <span class="timeline-icon light-green"></span>
                                                <span class="timeline-date">2017-05-18<br/>14:30:35</span>
                                                <h1 class="light-green">已提货</h1>
                                                <p><i class="fa  fa-users"></i>运输方:昕晟车队同意运输</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="timeline-item alt">
                                    <div class="timeline-desk">
                                        <div class="panel">
                                            <div class="panel-body">
                                                <span class="arrow-alt"></span>
                                                <span class="timeline-icon light-yellow"></span>
                                                <span class="timeline-date">2017-05-18<br/>14:30:35</span>
                                                <h1 class="light-yellow">已回单</h1>
                                                <p>
                                                    <i class="fa  fa-users"></i>运输方:昕晟车队同意运输
                                                </p>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="timeline-item">
                                    <div class="timeline-desk">
                                        <div class="panel">
                                            <div class="panel-body">
                                                <span class="arrow-alt"></span>
                                                <span class="timeline-icon orange"></span>
                                                <span class="timeline-date">2017-05-18<br/>14:30:35</span>
                                                <h1 class="orange">已回单</h1>
                                                <p>
                                                    <i class="fa  fa-users"></i>运输方:昕晟车队同意运输
                                                </p>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="trans_trail" style="height: 500px;">

                        </div>
                        <div class="tab-pane fade" id="trans_voucher">
                            <div class="panel">
                                <div class="form_container">
                                    <h4 class="panel-heading ">提货单</h4>
                                </div>
                                <div class="panel-body">
                                    <div class="col-sm-6 form-horizontal">
                                        <div class="form-group">
                                            <div class="col-sm-2 control-label" style="padding-right: 0;">上传提货单</div>
                                            <div class="col-sm-10 text-left">
                                                <a class="form-control click_upimg"> 点击上传</a>
                                                <p class="upimg-tips red" style="font-size: 12px;margin: 8px 0 15px;">
                                                    图片大小不超过2M，限上传1张，支持JPG、JPEG、PNG格式!</p>
                                            </div>
                                            <ul class="upimg-list clearfix">
                                                <li class="col-sm-2">
                                                    <img class="upimg" src="img/upimg.png">
                                                    <i class="fa fa-times-circle red"></i>
                                                </li>
                                                <li class="col-sm-2">
                                                    <img class="upimg" src="img/upimg.png">
                                                    <i class="fa fa-times-circle red"></i></li>
                                                <li class="col-sm-2">
                                                    <img class="upimg" src="img/upimg.png">
                                                    <i class="fa fa-times-circle red"></i></li>
                                                <li class="col-sm-2">
                                                    <img class="upimg" src="img/upimg.png">
                                                    <i class="fa fa-times-circle red"></i>
                                                </li>
                                                <li class="col-sm-2">
                                                    <img class="upimg" src="img/upimg.png">
                                                    <i class="fa fa-times-circle red"></i>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-sm-6"
                                         style="border-left: 1px solid #eff2f7;width: 49%;margin-left: 1%;">
                                        <p>1、提货、出库证明是司机装车的凭据，也是开始记录运单运输轨迹的开始时间。 </p>
                                        <p>2、为了货主以及收货人能及时了解运单状况，请务必要及时上传装车证明照片。 </p>
                                        <p>3、提货、出库证明由司机上传。</p>
                                        <p>4、图片大小不超过3M，限上传1张，支持JPG、JPEG、PNG格式</p>
                                        <p>5、提货单上传后可以更改，包括第一次上传一共可以上传<strong class="red">5</strong>次，剩余上传次数<strong
                                                class="red">4</strong></p>
                                    </div>
                                </div>
                            </div>

                            <div class="panel">
                                <div class="form_container">
                                    <h4 class="panel-heading ">提货单</h4>
                                </div>
                                <div class="panel-body">
                                    <div class="col-sm-6 form-horizontal">
                                        <div class="form-group">
                                            <div class="col-sm-2 control-label" style="padding-right: 0;">上传提货单</div>
                                            <div class="col-sm-10 text-left">
                                                <a class="form-control click_upimg"> 点击上传</a>
                                                <p class="upimg-tips red" style="font-size: 12px;margin: 8px 0 15px;">
                                                    图片大小不超过2M，限上传1张，支持JPG、JPEG、PNG格式!</p>
                                            </div>
                                            <ul class="upimg-list clearfix">
                                                <li class="col-sm-2">
                                                    <img class="upimg" src=${ctxStatic}/front/img/upimg.png">
                                                    <i class="fa fa-times-circle red"></i>
                                                </li>
                                                <li class="col-sm-2">
                                                    <img class="upimg" src="${ctxStatic}/front/img/upimg.png">
                                                    <i class="fa fa-times-circle red"></i></li>
                                                <li class="col-sm-2">
                                                    <img class="upimg" src="${ctxStatic}/front/img/upimg.png">
                                                    <i class="fa fa-times-circle red"></i></li>
                                                <li class="col-sm-2">
                                                    <img class="upimg" src="${ctxStatic}/front/img/upimg.png">
                                                    <i class="fa fa-times-circle red"></i>
                                                </li>
                                                <li class="col-sm-2">
                                                    <img class="upimg" src="${ctxStatic}/front/img/upimg.png">
                                                    <i class="fa fa-times-circle red"></i>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-sm-6"
                                         style="border-left: 1px solid #eff2f7;width: 49%;margin-left: 1%;">
                                        <p>1、提货、出库证明是司机装车的凭据，也是开始记录运单运输轨迹的开始时间。 </p>
                                        <p>2、为了货主以及收货人能及时了解运单状况，请务必要及时上传装车证明照片。 </p>
                                        <p>3、提货、出库证明由司机上传。</p>
                                        <p>4、图片大小不超过3M，限上传1张，支持JPG、JPEG、PNG格式</p>
                                        <p>5、提货单上传后可以更改，包括第一次上传一共可以上传<strong class="red">5</strong>次，剩余上传次数<strong
                                                class="red">4</strong></p>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="tab-pane fade" id="receipt">
                            <div class="form_container">
                                <h4 class="panel-heading ">回执单</h4>
                            </div>
                            <div class="panel-body">
                                <table id="printtable" class="print table table-bordered" style="margin-bottom:20px;"
                                       cellpadding="0" cellspacing="0">
                                    <tbody>
                                    <tr>
                                        <td colspan="8"><h1 style="font-size:24px;font-weight:bold;"
                                                            class="text-center">河北邯郸巨恒物流公司运输回执单(卓大物流)</h1></td>
                                    </tr>
                                    <tr>
                                        <td colspan="1">发布方:</td>
                                        <td colspan="3">肥乡县益鑫运输队</td>
                                        <td colspan="1">承运方:</td>
                                        <td colspan="3">昕晟车队</td>
                                    </tr>
                                    <tr>
                                        <td colspan="3">订单号:YD2017051876270001</td>
                                        <td colspan="2">司机:昕晟车队</td>
                                        <td colspan="3">司机电话:15511010541</td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">货运车号:冀DP6413</td>
                                        <td colspan="2">货物名称:内贸卷</td>
                                        <td colspan="4">发车日期:2016-10-14</td>
                                    </tr>
                                    <tr id="table_head">
                                        <td>合同号</td>
                                        <td>批号</td>
                                        <td>材质</td>
                                        <td>规格</td>
                                        <td>宽度</td>
                                        <td>重量</td>
                                        <td style="width:100px;">卸货地址</td>
                                        <td>备注</td>
                                    </tr>
                                    <!-- ngRepeat: x in data -->
                                    <tr ng-repeat="x in data" class="ng-scope">
                                        <td class="ng-binding">60221918</td>
                                        <td class="ng-binding">257381S06</td>
                                        <td class="ng-binding">汽车结构用酸洗钢带SAPH440</td>
                                        <td class="ng-binding">2.00</td>
                                        <td class="ng-binding">1500.00</td>
                                        <td class="ng-binding">11.3200</td>
                                        <td style="width:100px;" class="ng-binding">淞沪港</td>
                                        <td class="ng-binding"></td>
                                    </tr><!-- end ngRepeat: x in data -->
                                    <tr ng-repeat="x in data" class="ng-scope">
                                        <td class="ng-binding">60221918</td>
                                        <td class="ng-binding">257611S06</td>
                                        <td class="ng-binding">汽车结构用酸洗钢带SAPH440</td>
                                        <td class="ng-binding">2.00</td>
                                        <td class="ng-binding">1500.00</td>
                                        <td class="ng-binding">10.4400</td>
                                        <td style="width:100px;" class="ng-binding">淞沪港</td>
                                        <td class="ng-binding"></td>
                                    </tr><!-- end ngRepeat: x in data -->
                                    <tr ng-repeat="x in data" class="ng-scope">
                                        <td class="ng-binding">60219726</td>
                                        <td class="ng-binding">257501S06</td>
                                        <td class="ng-binding">热轧酸洗卷板HRLC</td>
                                        <td class="ng-binding">2.00</td>
                                        <td class="ng-binding">1500.00</td>
                                        <td class="ng-binding">11.5800</td>
                                        <td style="width:100px;" class="ng-binding">淞沪港</td>
                                        <td class="ng-binding"></td>
                                    </tr><!-- end ngRepeat: x in data -->
                                    <tr ng-repeat="x in data" class="ng-scope">
                                        <td class="ng-binding">60222114</td>
                                        <td class="ng-binding">243972F1P6</td>
                                        <td class="ng-binding">SPCC</td>
                                        <td class="ng-binding">1.2</td>
                                        <td class="ng-binding">1250.00</td>
                                        <td class="ng-binding">7.4500</td>
                                        <td style="width:100px;" class="ng-binding"></td>
                                        <td class="ng-binding"></td>
                                    </tr><!-- end ngRepeat: x in data -->
                                    <tr ng-repeat="x in data" class="ng-scope">
                                        <td class="ng-binding">60222114</td>
                                        <td class="ng-binding">244262F1P6</td>
                                        <td class="ng-binding">SPCC</td>
                                        <td class="ng-binding">1.4</td>
                                        <td class="ng-binding">1250.00</td>
                                        <td class="ng-binding">7.5530</td>
                                        <td style="width:100px;" class="ng-binding"></td>
                                        <td class="ng-binding"></td>
                                    </tr><!-- end ngRepeat: x in data -->
                                    <tr ng-repeat="x in data" class="ng-scope">
                                        <td class="ng-binding">60221918</td>
                                        <td class="ng-binding">257591S06</td>
                                        <td class="ng-binding">汽车结构用酸洗钢带SAPH440</td>
                                        <td class="ng-binding">2.00</td>
                                        <td class="ng-binding">1500.00</td>
                                        <td class="ng-binding">11.1600</td>
                                        <td style="width:100px;" class="ng-binding">淞沪港</td>
                                        <td class="ng-binding"></td>
                                    </tr><!-- end ngRepeat: x in data -->
                                    <tr ng-repeat="x in data" class="ng-scope">
                                        <td class="ng-binding">60221918</td>
                                        <td class="ng-binding">257382S06</td>
                                        <td class="ng-binding">汽车结构用酸洗钢带SAPH440</td>
                                        <td class="ng-binding">2.00</td>
                                        <td class="ng-binding">1500.00</td>
                                        <td class="ng-binding">11.2600</td>
                                        <td style="width:100px;" class="ng-binding">淞沪港</td>
                                        <td class="ng-binding"></td>
                                    </tr><!-- end ngRepeat: x in data -->
                                    <tr ng-repeat="x in data" class="ng-scope">
                                        <td class="ng-binding">L601850</td>
                                        <td class="ng-binding">L21603533802</td>
                                        <td class="ng-binding">SPCC</td>
                                        <td class="ng-binding">1</td>
                                        <td class="ng-binding">1250.00</td>
                                        <td class="ng-binding">7.3400</td>
                                        <td style="width:100px;" class="ng-binding"></td>
                                        <td class="ng-binding"></td>
                                    </tr><!-- end ngRepeat: x in data -->
                                    <tr ng-repeat="x in data" class="ng-scope">
                                        <td class="ng-binding">60222114</td>
                                        <td class="ng-binding">244021F1P6</td>
                                        <td class="ng-binding">SPCC</td>
                                        <td class="ng-binding">1.2</td>
                                        <td class="ng-binding">1250.00</td>
                                        <td class="ng-binding">7.2800</td>
                                        <td style="width:100px;" class="ng-binding"></td>
                                        <td class="ng-binding"></td>
                                    </tr><!-- end ngRepeat: x in data -->
                                    <tr ng-repeat="x in data" class="ng-scope">
                                        <td class="ng-binding">60219963</td>
                                        <td class="ng-binding">257411S06</td>
                                        <td class="ng-binding">热轧酸洗卷板HRLC</td>
                                        <td class="ng-binding">2.00</td>
                                        <td class="ng-binding">1500.00</td>
                                        <td class="ng-binding">11.4200</td>
                                        <td style="width:100px;" class="ng-binding">淞沪港</td>
                                        <td class="ng-binding"></td>
                                    </tr><!-- end ngRepeat: x in data -->

                                    <tr>
                                        <td colspan="8"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="8"></td>
                                    </tr>
                                    <tr>
                                        <td>合计</td>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td></td>

                                        <td>
                                            9吨


                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td colspan="8"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="7" style="text-align:left;">
                                            送货地址:天津市
                                            天津市
                                            塘沽区
                                            南港码头
                                        </td>
                                        <td rowspan="4" id="QRCodeimg">
                                            <img class="hovspan" alt=""
                                                 onerror="this.onerror=null;this.src='/static/images/wlptfront/QRCode_logo.png'"
                                                 style="width:110px" src="/static/images/wlptfront/QRCode_logo.png">
                                            <img class="hovspan2" style="width:110px;display: none;"
                                                 src="/userfiles/code/YD2017051876270001.jpg">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="7" style="text-align:left;">
                                            <div style="float:left;margin-right:20px;">
                                                联系人:张魏
                                            </div>
                                            <div style="float:left;">电话:18202659612</div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="7" style="text-align:left;">
                                            <div style="float:left;width:50%;">质保书、票据按客户要求由我处邮寄或自取
                                            </div>
                                            <div style="width:30%;float:right;text-align:left;">随货通行签字(盖章)</div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="7" style="text-align:left">收货日期:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                    </tr>
                                    </tbody>
                                </table>
                                <div class="col-sm-12 text-center">
                                    <button class="btn btn-success"> 打 印</button>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade" id="voucher">
                            <div class="form_container">
                                <h4 class="panel-heading ">评价</h4>
                            </div>
                            <div class="panel-body">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&amp;ak=80f73f31cfbb40be26acda67af03da43"></script>
<script type="text/javascript" src="http://api.map.baidu.com/getscript?v=2.0&amp;ak=80f73f31cfbb40be26acda67af03da43&amp;services=&amp;t=20170517145936"></script>


<script>

    // 百度地图API功能
    var map = new BMap.Map("trans_trail");          // 创建地图实例
    map.enableScrollWheelZoom();
    map.addControl(new BMap.NavigationControl());  //添加默认缩放平移控件
    map.addControl(new BMap.GeolocationControl());  //定位控件
    map.centerAndZoom("邯郸", 12);
    var point = new BMap.Point(114.555007,36.633539);  // 创建点坐标
    map.centerAndZoom(point, 15);                 // 初始化地图，设置中心点坐标和地图级别
    //    var geolocation = new BMap.Geolocation();
    //    geolocation.getCurrentPosition(function(r){
    //        if(this.getStatus() == BMAP_STATUS_SUCCESS){
    //            var mk = new BMap.Marker(r.point);
    //            var label = new BMap.Label("当前位置", {
    //                offset : new BMap.Size(20, -10)
    //            });
    //            mk.setLabel(label);
    //            map.addOverlay(mk);
    //            map.panTo(r.point);
    //            map.centerAndZoom(r.point, 12);
    //        }
    //        else {
    //            alert('failed'+this.getStatus());
    //        }
    //    },{enableHighAccuracy: true});
    var myIcon = new BMap.Icon("img/car_blue.png", new BMap.Size(30,50));
    var customLayer=new BMap.CustomLayer({geotableId:'151513',ak:'eM13QwFEWbih6NGPXHpZzDMeMpYjMTgz'});
    map.addTileLayer(customLayer);
    customLayer.addEventListener('hotspotclick',callback);

    map.addEventListener("dragstart", function(e){
        //alert(e);
        map.centerAndZoom(new BMap.Point(e.point.lng,e.point.lat), 12);
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

        var content = '<p style="width:300px;margin:0;line-height:20px;text-indent: 15px;">联系方式：'+ contentPoi.mobile +' <br/><span style="padding-left: 15px;"> 车辆状态：</span>'+contentPoi.state +' <br/><span style="padding-left: 15px;">地址：</span><span style="text-indent: 15px;">' + address +'</span><br/> <span style="padding-left: 15px;">最后定位时间：</span>'+gpstime+' </p>';

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
    $('#searchBtn').click(function () {
        keyword = $('#keyword').val();
        if(keyword){
            searchAction(keyword);
        }else{
            map.clearOverlays();
            customLayer=new BMap.CustomLayer({geotableId:'151513',ak:'eM13QwFEWbih6NGPXHpZzDMeMpYjMTgz'});
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
            'geotable_id': 151513,
            'ak': 'eM13QwFEWbih6NGPXHpZzDMeMpYjMTgz'  //用户ak
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
            bootbox.alert("未找到查找的车辆");
            return;
        }
        map.removeTileLayer(customLayer);
        var myIcon = new BMap.Icon("img/car_blue.png", new BMap.Size(30,50));

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

                var content = '<p style="width:300px;margin:0;line-height:20px;text-indent: 15px;">联系方式：' + item.mobile + ' <br/><span style="padding-left: 15px;"> 车辆状态：</span>' + item.state + ' <br/><span style="padding-left: 15px;">地址：</span><span style="text-indent: 15px;">' + address + '</span><br/> <span style="padding-left: 15px;">最后定位时间：</span>' + gpstime + ' </p>';

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
</body>
</html>
