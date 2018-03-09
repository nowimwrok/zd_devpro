<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_personal_basic"/>
    <title>个人中心</title>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" rel="stylesheet">
    <style type="text/css">

    </style>
</head>
<body style="background: #f5f5f5;">

        <div>
            <div class="col-lg-12 data-model">
                <div class="col-sm-2 bg_blue clearfix">
                    <img src="${ctxStatic}/front/img/tender01.png" class="pull-left data-icon">
                    <span class="pull-left data-title">招标</span>
                    <span class="pull-right data-num">4</span>
                </div>
                <div class="col-sm-2 bg_light_green clearfix">
                    <img src="${ctxStatic}/front/img/bid.png" class="pull-left data-icon">
                    <span class="pull-left data-title">竞标</span>
                    <span class="pull-right data-num">4</span>
                </div>
                <div class="col-sm-2 bg_deep_greeen clearfix">
                    <img src="${ctxStatic}/front/img/has_bid.png" class="pull-left data-icon">
                    <span class="pull-left data-title">报价</span>
                    <span class="pull-right data-num">4</span>
                </div>
                <div class="col-sm-2 bg_yellow clearfix">
                    <img src="${ctxStatic}/front/img/waybill.png" class="pull-left data-icon">
                    <span class="pull-left data-title">运单</span>
                    <span class="pull-right data-num">7</span>
                </div>
                <div class="col-sm-2 bg_orange clearfix">
                    <img src="${ctxStatic}/front/img/box.png" class="pull-left data-icon">
                    <span class="pull-left data-title">货源</span>
                    <span class="pull-right data-num">12</span>
                </div>
                <div class="col-sm-2 bg_red clearfix" style="margin-right: 0;">
                    <img src="${ctxStatic}/front/img/car.png" class="pull-left data-icon">
                    <span class="pull-left data-title">车辆</span>
                    <span class="pull-right data-num">12</span>
                </div>
            </div>
            <div class="col-lg-12" style="margin:20px 0;">
                <div class="btn-group pull-left tab_button nav nav-tabs" style="border:none;">
                    <button class="btn btn-default btn-nobg-radius btn-active" data-toggle="tab" data-target="#latest_waybill">最新运单</button>
                    <button class="btn btn-nobg-radius btn-default" data-toggle="tab" data-target="#latest_tender">最新招标</button>
                    <button class="btn btn-nobg-radius btn-default" data-toggle="tab" data-target="#latest_bid">最新竞标</button>
                </div>
                <a class="pull-right see" href="waybill_list.html">
                    查看全部运单
                </a>
            </div>
            <div class="col-lg-12 tab-content">
                <div class="clearfix tab-pane fade in active" id="latest_waybill">
                    <table class="table" id="latest_waybill_table">
                        <thead>
                        <tr>
                            <th>运单编号</th>
                            <th>操作</th>
                            <th>货物信息</th>
                            <th>路线</th>
                            <th>司机</th>
                            <th>车辆</th>
                            <th>运费（元）</th>
                            <th>时间</th>
                            <th>交易状态</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><a href="${wlpt}/order_det" class="tdFir">YD2017051876270001</a></td>
                            <td>
                                <a href="${wlpt}/order_det" class="see oprate">详情</a>
                                <a href="" class="red oprate">删除</a>
                            </td>
                            <td title="内贸卷/整车/9吨">
                                内贸卷<span class="vertical-line">|</span> 整车<span class="vertical-line">|</span> 9吨
                            </td>
                            <td title="邯郸市复兴区- 天津市塘沽区">邯郸市复兴区 - 天津市塘沽区</td>
                            <td>昕晟车队15511010541</td>
                            <td>冀DP6413</td>
                            <td>90.00</td>
                            <td>2017-05-18 14:30:29</td>
                            <td><span class="green">新运单</span></td>
                        </tr>
                        <tr>
                            <td><a href="${wlpt}/order_det" class="tdFir">YD2016092416000029</a></td>
                            <td>
                                <a href="${wlpt}/order_det" class="see oprate">详情</a>
                                <a href="" class="red oprate">删除</a>
                            </td>
                            <td title="内贸卷/整车/28.145吨">
                                内贸卷<span class="vertical-line">|</span> 整车<span class="vertical-line">|</span> 28.145吨
                            </td>
                            <td title="邯郸市复兴区- 天津市塘沽区">邯郸市复兴区 - 天津市塘沽区</td>
                            <td>昕晟车队15511010541</td>
                            <td>冀DZ3077</td>
                            <td>1547.97</td>
                            <td>2016-10-26 10:23:02</td>
                            <td><span class="orange">已支付</span></td>
                        </tr>
                        <tr>
                            <td><a href="${wlpt}/order_det" class="tdFir">YD2016102156370197</a></td>
                            <td>
                                <a href="${wlpt}/order_det" class="see oprate">详情</a>
                                <a href="" class="red oprate">删除</a>
                            </td>
                            <td title="内贸卷/整车/82.627吨">
                                内贸卷<span class="vertical-line">|</span> 整车<span class="vertical-line">|</span> 82.627吨
                            </td>
                            <td title="邯郸市复兴区- 天津市塘沽区">邯郸市复兴区 - 天津市塘沽区</td>
                            <td>昕晟车队15511010541</td>
                            <td>冀DZ3082</td>
                            <td>8262.70</td>
                            <td>2016-10-21 16:03:08</td>
                            <td><span class="green">新运单</span></td>
                        </tr>
                        <tr>
                            <td><a href="${wlpt}/order_det" class="tdFir">YD2016102188580187</a></td>
                            <td>
                                <a href="${wlpt}/order_det" class="see oprate">详情</a>
                                <a href="" class="red oprate">删除</a>
                            </td>
                            <td title="内贸卷/整车/32.135吨">
                                内贸卷<span class="vertical-line">|</span> 整车<span class="vertical-line">|</span> 32.135吨
                            </td>
                            <td title="邯郸市复兴区- 天津市塘沽区">邯郸市复兴区 - 天津市塘沽区</td>
                            <td>昕晟车队15511010541</td>
                            <td>冀DP3411</td>
                            <td>3213.50</td>
                            <td>2016-10-21 15:44:09</td>
                            <td><span class="green">新运单</span></td>
                        </tr>
                        <tr>
                            <td><a href="waybill_det.html" class="tdFir">YD2016102198230181</a></td>
                            <td>
                                <a href="waybill_det.html" class="see oprate">详情</a>
                                <a href="" class="red oprate">删除</a>
                            </td>
                            <td title="外贸卷/整车/96.33吨">
                                外贸卷<span class="vertical-line">|</span> 整车<span class="vertical-line">|</span>96.33吨
                            </td>
                            <td title="邯郸市复兴区- 天津市塘沽区">邯郸市复兴区 - 天津市塘沽区</td>
                            <td>昕晟车队15511010541</td>
                            <td>冀DP3635</td>
                            <td>9633.50</td>
                            <td>2016-10-21 15:38:56</td>
                            <td><span class="green">新运单</span></td>
                        </tr>
                        <tr>
                            <td><a href="waybill_det.html" class="tdFir">YD2016102198230181</a></td>
                            <td>
                                <a href="waybill_det.html" class="see oprate">详情</a>
                                <a href="" class="red oprate">删除</a>
                            </td>
                            <td title="外贸卷/整车/96.33吨">
                                外贸卷<span class="vertical-line">|</span> 整车<span class="vertical-line">|</span>96.33吨
                            </td>
                            <td title="邯郸市复兴区- 天津市塘沽区">邯郸市复兴区 - 天津市塘沽区</td>
                            <td>昕晟车队15511010541</td>
                            <td>冀DP3635</td>
                            <td>9633.50</td>
                            <td>2016-10-21 15:38:56</td>
                            <td><span class="green">新运单</span></td>
                        </tr>
                        <tr>
                            <td><a href="waybill_det.html" class="tdFir">YD2016102198230181</a></td>
                            <td>
                                <a href="waybill_det.html" class="see oprate">详情</a>
                                <a href="" class="red oprate">删除</a>
                            </td>
                            <td title="外贸卷/整车/96.33吨">
                                外贸卷<span class="vertical-line">|</span> 整车<span class="vertical-line">|</span>96.33吨
                            </td>
                            <td title="邯郸市复兴区- 天津市塘沽区">邯郸市复兴区 - 天津市塘沽区</td>
                            <td>昕晟车队15511010541</td>
                            <td>冀DP3635</td>
                            <td>9633.50</td>
                            <td>2016-10-21 15:38:56</td>
                            <td><span class="green">新运单</span></td>
                        </tr>

                        </tbody>
                        <!--<tfoot>-->
                        <!--<tr>-->
                        <!--<td colspan="15">-->
                        <!--<div class="paging btn-group clearfix">-->
                        <!--<div class="pull-left page_info">-->
                        <!--显示第 <span class="page_num">1</span> 至 <span class="page_num">4</span> 条结果，共 <span class="page_num">4</span> 条 (每页显示-->
                        <!--8 条)-->
                        <!--</div>-->
                        <!--<div class="btn-group pull-right">-->
                        <!--<button class="btn btn-default btn_page_normal">上一页</button>-->
                        <!--<button class="btn btn-default btn_page_normal btn_page_active">1</button>-->
                        <!--<button class="btn btn-default btn_page_normal">下一页</button>-->
                        <!--</div>-->
                        <!--</div>-->
                        <!--</td>-->
                        <!--</tr>-->
                        <!--</tfoot>-->
                    </table>
                </div>
                <div class="clearfix tab-pane fade" id="latest_tender">
                    <table class="table" id="latest_tender_table">
                        <thead>
                        <tr>
                            <th>招标文号</th>
                            <th>货物信息</th>
                            <th>路线</th>
                            <th>状态</th>
                            <th>招标时间</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><a href="" class="tdFir">ZB2016102163340001</a></td>
                            <td title="外贸卷/54.13吨">
                                外贸卷<span class="vertical-line">|</span> 54.13吨
                            </td>
                            <td title="邯郸市复兴区- 天津市塘沽区">邯郸市复兴区 - 天津市塘沽区</td>
                            <td><span class="green">中标</span></td>
                            <td>2017-05-18 14:30:29</td>
                            <td>
                                <a href="" class="see">详情</a>
                            </td>
                        </tr>
                        <tr>
                            <td><a href="" class="tdFir">ZB2016102145060001</a></td>
                            <td title="水路内贸/54.13吨">
                                水路内贸<span class="vertical-line">|</span> 360.78吨
                            </td>
                            <td title="邯郸市复兴区- 天津市塘沽区">邯郸市复兴区 - 天津市塘沽区</td>
                            <td><span class="green">中标</span></td>
                            <td>2017-05-18 14:30:29</td>
                            <td>
                                <a href="" class="see">详情</a>
                            </td>
                        </tr>
                        <tr>
                            <td><a href="" class="tdFir">ZB2016102093960001</a></td>
                            <td title="出口卷/22.83吨">
                                出口卷<span class="vertical-line">|</span> 22.83吨
                            </td>
                            <td title="邯郸市复兴区- 天津市塘沽区">邯郸市复兴区 - 天津市塘沽区</td>
                            <td><span class="red">已截标</span></td>
                            <td>2016-12-18 14:30:29</td>
                            <td>
                                <a href="" class="see">详情</a>
                            </td>
                        </tr>
                        <tr>
                            <td><a href="" class="tdFir">ZB2016102093960001</a></td>
                            <td title="出口卷/22.83吨">
                                出口卷<span class="vertical-line">|</span> 22.83吨
                            </td>
                            <td title="邯郸市复兴区- 天津市塘沽区">邯郸市复兴区 - 天津市塘沽区</td>
                            <td><span class="red">已截标</span></td>
                            <td>2016-12-18 14:30:29</td>
                            <td>
                                <a href="" class="see">详情</a>
                            </td>
                        </tr>

                        </tbody>
                    </table>
                </div>
                <div class="clearfix tab-pane fade" id="latest_bid">
                    <table class="table" id="latest_bid_table">
                        <thead>
                        <tr>
                            <th>招标文号</th>
                            <th>货物信息</th>
                            <th>路线</th>
                            <th>状态</th>
                            <th>竞标时间</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td><a href="" class="tdFir">ZB2016102163340001</a></td>
                            <td title="外贸卷/54.13吨">
                                外贸卷<span class="vertical-line">|</span> 54.13吨
                            </td>
                            <td title="邯郸市复兴区- 天津市塘沽区">邯郸市复兴区 - 天津市塘沽区</td>
                            <td><span class="green">中标</span></td>
                            <td>2017-05-18 14:30:29</td>
                            <td>
                                <a href="" class="see">详情</a>
                            </td>
                        </tr>
                        <tr>
                            <td><a href="" class="tdFir">ZB2016102145060001</a></td>
                            <td title="水路内贸/54.13吨">
                                水路内贸<span class="vertical-line">|</span> 360.78吨
                            </td>
                            <td title="邯郸市复兴区- 天津市塘沽区">邯郸市复兴区 - 天津市塘沽区</td>
                            <td><span class="green">中标</span></td>
                            <td>2017-05-18 14:30:29</td>
                            <td>
                                <a href="" class="see">详情</a>
                            </td>
                        </tr>
                        <tr>
                            <td><a href="" class="tdFir">ZB2016102093960001</a></td>
                            <td title="出口卷/22.83吨">
                                出口卷<span class="vertical-line">|</span> 22.83吨
                            </td>
                            <td title="邯郸市复兴区- 天津市塘沽区">邯郸市复兴区 - 天津市塘沽区</td>
                            <td><span class="red">已截标</span></td>
                            <td>2016-12-18 14:30:29</td>
                            <td>
                                <a href="" class="see">详情</a>
                            </td>
                        </tr>
                        <tr>
                            <td><a href="" class="tdFir">ZB2016102093960001</a></td>
                            <td title="出口卷/22.83吨">
                                出口卷<span class="vertical-line">|</span> 22.83吨
                            </td>
                            <td title="邯郸市复兴区- 天津市塘沽区">邯郸市复兴区 - 天津市塘沽区</td>
                            <td><span class="red">已截标</span></td>
                            <td>2016-12-18 14:30:29</td>
                            <td>
                                <a href="" class="see">详情</a>
                            </td>
                        </tr>

                        </tbody>
                    </table>
                </div>

            </div>
        </div>

<script>

    //    头部数据
    $(".data-model .col-sm-2").mouseover(function () {
        $(this).find(".data-icon").addClass("img_rotate");
    }).mouseleave(function () {
        $(this).find(".data-icon").removeClass("img_rotate");
    });

    $("#latest_waybill_table").bootstrapTable({
        fixedColumns:true,
        fixedNumber:2,
        pagination:false
//        showColumns:true,
//        search:true
    })
    $("#latest_tender_table").bootstrapTable({
        pagination:true,
        pageSize:5
    })
    $("#latest_bid_table").bootstrapTable({
        pagination:true,
        pageSize:5
    })
</script>
</body>
</html>
