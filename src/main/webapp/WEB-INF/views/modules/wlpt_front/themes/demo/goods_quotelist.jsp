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

<div  style="background: #f5f5f5;">

    <div class="row">
        <div class="col-sm-12">
            <div class="panel clearfix">
                <div class="form_container">
                    <h4 class="panel-heading">
                        司机报价
                    </h4>
                    <div class="panel-body">
                        <table class="table" id="driver_quote">
                            <thead>
                            <tr>
                                <th>司机信息</th>
                                <th>车辆</th>
                                <th>报价</th>
                                <th>诚信</th>
                                <th>发布日期</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>李志波15511010541 <span class="bg_blue_label">担保金</span><img src="${ctxStatic}/front/img/has_auth.png" class="auth_img"> </td>
                                <td>冀DP9422<span class="vertical-line">|</span>栏板式<span class="vertical-line">|</span>85.00吨<span class="vertical-line">|</span>13.00米</td>
                                <td>50.00元/吨 <span class="vertical-line">|</span>25.925吨</td>
                                <td><img src="${ctxStatic}/front/img/level_01.png" class="level"></td>
                                <td>2016-09-06</td>
                                <td>
                                    <a href="${wlpt}/create_order" class="green oprate">生成运单</a>
                                    <a href="" class="red oprate">拒绝报价</a>
                                </td>
                            </tr>

                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="row">
        <div class="col-sm-12">
            <div class="panel clearfix">
                <div class="form_container">
                    <h4 class="panel-heading">
                        运单规则
                    </h4>
                    <div class="col-sm-12 form-horizontal">
                        <p>1.司机报价为运输单价。</p>
                        <p>2.当您生成了运单，系统将自动从您的账户上扣除运费。</p>
                        <p>3.运单结束后，运费从平台支付给司机。</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-sm-12">
            <div class="panel clearfix">
                <div class="form_container">
                    <h4 class="panel-heading">
                        货物详情
                    </h4>
                    <div class="col-sm-12 form-horizontal">
                        <div class="row">
                            <div class="col-sm-2 text-right"><strong>地址信息</strong></div>
                            <div class="col-sm-10  goods_details">
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">始发地</div>
                                    <div class="col-sm-9 text-left detList_con">邯郸市复兴区</div>
                                </div>
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">详细地址</div>
                                    <div class="col-sm-9 text-left detList_con">邯郸市复兴区</div>
                                </div>
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">目的地</div>
                                    <div class="col-sm-9 text-left detList_con">邯郸市复兴区</div>
                                </div>
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">详细地址</div>
                                    <div class="col-sm-9 text-left detList_con">邯郸市复兴区</div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-2 text-right"><strong>货物基本信息</strong></div>
                            <div class="col-sm-10  goods_details">
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">名称</div>
                                    <div class="col-sm-9 text-left detList_con">内毛圈</div>
                                </div>
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">重量</div>
                                    <div class="col-sm-9 text-left detList_con">26636.000吨</div>
                                </div>
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">类型</div>
                                    <div class="col-sm-9 text-left detList_con">重货</div>
                                </div>
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">类别</div>
                                    <div class="col-sm-9 text-left detList_con">重货</div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-2 text-right"><strong>发货人信息</strong></div>
                            <div class="col-sm-10  goods_details">
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">姓名</div>
                                    <div class="col-sm-9 text-left detList_con">黄忠厚</div>
                                </div>
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">电话</div>
                                    <div class="col-sm-9 text-left detList_con">13520206785</div>
                                </div>
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">固定电话</div>
                                    <div class="col-sm-9 text-left detList_con">020-785643</div>
                                </div>
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">公司名称</div>
                                    <div class="col-sm-9 text-left detList_con">广州众翔物流信息科技有限公司</div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-sm-2 text-right"><strong>收货人信息</strong></div>
                            <div class="col-sm-10  goods_details">
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">姓名</div>
                                    <div class="col-sm-9 text-left detList_con">李志波</div>
                                </div>
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">电话</div>
                                    <div class="col-sm-9 text-left detList_con">18567864563</div>
                                </div>
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">固定电话</div>
                                    <div class="col-sm-9 text-left detList_con">020-253421</div>
                                </div>
                                <div class="col-sm-5 goods_detList">
                                    <div class="col-sm-3 text-right detList_tt">公司名称</div>
                                    <div class="col-sm-9 text-left detList_con">广州众翔物流信息科技有限公司</div>
                                </div>
                            </div>
                        </div>

                        <a class="col-sm-11 text-right learn_more_goods" id="learn_more">查看更多信息<i class="fa fa-chevron-circle-down"></i></a>

                        <div class="col-sm-12 goods_add_det">
                            <div class="row">
                                <div class="col-sm-2 text-right"><strong>货物补充信息</strong></div>
                                <div class="col-sm-10  goods_details">
                                    <div class="col-sm-5 goods_detList">
                                        <div class="col-sm-3 text-right detList_tt">发货时间</div>
                                        <div class="col-sm-9 text-left detList_con">2017-03-12 09:00</div>
                                    </div>
                                    <div class="col-sm-5 goods_detList">
                                        <div class="col-sm-3 text-right detList_tt">有效天数</div>
                                        <div class="col-sm-9 text-left detList_con">1天</div>
                                    </div>
                                    <div class="col-sm-5 goods_detList">
                                        <div class="col-sm-3 text-right detList_tt">货主出价</div>
                                        <div class="col-sm-9 text-left detList_con">23.00元/吨</div>
                                    </div>
                                    <div class="col-sm-5 goods_detList">
                                        <div class="col-sm-3 text-right detList_tt">货物价值</div>
                                        <div class="col-sm-9 text-left detList_con">16356.00元</div>
                                    </div>
                                    <div class="col-sm-5 goods_detList">
                                        <div class="col-sm-3 text-right detList_tt">运输方式</div>
                                        <div class="col-sm-9 text-left detList_con">整车</div>
                                    </div>
                                    <div class="col-sm-5 goods_detList">
                                        <div class="col-sm-3 text-right detList_tt">是否指派</div>
                                        <div class="col-sm-9 text-left detList_con">整车</div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-2 text-right"><strong>车辆要求</strong></div>
                                <div class="col-sm-10  goods_details">
                                    <div class="col-sm-5 goods_detList">
                                        <div class="col-sm-3 text-right detList_tt">车型要求</div>
                                        <div class="col-sm-9 text-left detList_con">不限</div>
                                    </div>
                                    <div class="col-sm-5 goods_detList">
                                        <div class="col-sm-3 text-right detList_tt">车长要求</div>
                                        <div class="col-sm-9 text-left detList_con">不限</div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-2 text-right"><strong>补充说明</strong></div>
                                <div class="col-sm-10  goods_details">
                                    对于一个司机来说，货物重于一切。对于一个司机来说，货物重于一切。对于一个司机来说，货物重于一切。
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

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
                                <th>数量/吨</th>
                                <th>批次/号</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>60221918</td>
                                <td>汽车结构用酸洗钢带SAPH440</td>
                                <td>2.00</td>
                                <td>1500.00</td>
                                <td>11.3200</td>
                                <td>257381S06</td>
                            </tr>
                            <tr>
                                <td>60221918</td>
                                <td>汽车结构用酸洗钢带SAPH440</td>
                                <td>2.00</td>
                                <td>1500.00</td>
                                <td>11.3200</td>
                                <td>257381S06</td>
                            </tr>
                            <tr>
                                <td>60219726</td>
                                <td>热轧酸洗卷板HRLC</td>
                                <td>2.00</td>
                                <td>1500.00</td>
                                <td>11.5800</td>
                                <td>257381S06</td>
                            </tr>
                            <tr>
                                <td>60222114</td>
                                <td>SPCC</td>
                                <td>1.2</td>
                                <td>1250.00</td>
                                <td>7.4500</td>
                                <td>243972F1P6</td>
                            </tr>
                            <tr>
                                <td>60222114</td>
                                <td>SPCC</td>
                                <td>1.4</td>
                                <td>1250.00</td>
                                <td>7.4500</td>
                                <td>243972F1P6</td>
                            </tr>
                            <tr>
                                <td>60222114</td>
                                <td>SPCC</td>
                                <td>1.4</td>
                                <td>1250.00</td>
                                <td>7.4500</td>
                                <td>243972F1P6</td>
                            </tr>
                            <tr>
                                <td>60221918</td>
                                <td>汽车结构用酸洗钢带SAPH440</td>
                                <td>2.00</td>
                                <td>1250.00</td>
                                <td>7.4500</td>
                                <td>243972F1P6</td>
                            </tr>
                            <tr>
                                <td>60221918</td>
                                <td>汽车结构用酸洗钢带SAPH440</td>
                                <td>2.00</td>
                                <td>1250.00</td>
                                <td>7.4500</td>
                                <td>243972F1P6</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<script>

    $('#driver_quote').bootstrapTable({
        pagination:true,//设置为 true 会在表格底部显示分页条
        pagesize:5
    });
</script>
</body>
</html>
