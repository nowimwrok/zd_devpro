<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp" %>
    <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <link rel="stylesheet"
          href="/static/modules/wlpt/front/css/analysis/global.css"/>
    <title>卓大物流平台</title>
    <style type="text/css">
        .bg_dark_blue {
            background: #236d9f;
        }

        .bg_dark_green {
            background: #31b368;
        }

        .bg_dark_greeen {
            background: #309783;
        }

        .bg_dark_yellow {
            background: #cca818;
        }

        .search_btn {
            width: 80px;
            background-color: #073190;
            color: white;
            border: 1px solid #073190;
        }

        .fontDate {
            font-size: 14px;
            color: black;
            font-family: Microsoft YaHei;
        }

        .licss {
            padding: 2px 0;
        }

        .echart-content {
            width: 60%;
            height: 400px;
            float: left;
        }

        .pull-right {
            float: right;
        }

        .content-wrap {
            background-color: white;
            padding: 1em;
        }

        ul {
            list-style: none !important;
        }

        .finance_title {
            width: 100%;
            margin-top: 1em;
        }

        .finance_title .title_left, .finance_title .title_right {
            width: 49%;
            background: rgb(245, 243, 249);
            border-radius: 4px;
            padding: 1em 1.5em;
        }

        .date_con {
            background: rgb(245, 243, 249);
            border-top-left-radius: 4px;
            border-top-right-radius: 4px;
            padding: 1em;
        }

        .rencent {
            border: 1px solid #e5e5e5;
            overflow: hidden;
            padding: 1em;
            border-bottom-left-radius: 4px;
            border-bottom-right-radius: 4px;
            border-top-left-radius: 4px;
            border-top-right-radius: 4px;
        }

        .recent_charts {
            width: 100%;
            height: 20em;
            border-top: 1px solid #e5e5e5;
        }

        .income_expense {
            width: 100%;
        }

        .expense-title > .orange {
            color: rgb(232, 107, 49) !important;
        }

        .expense-title > .large {
            padding: 0 0.5em !important;
        }

        .expense-title > .small {
            font-size: 1.2em !important;
            font-weight: normal !important;
            padding: 0 0.5em !important;
        }

        a.small {
            font-size: 1.2em !important;
            font-weight: normal !important;
            padding: 0 0.5em !important;
            color: rgb(5, 142, 202) !important;
            font-size: 1.2em !important;
        }

        .charts_expense {
            width: 60%;
            height: 20em;
            border: none;
        }

        .charts_det ul li {
            line-height: 45px;
            height: 45px;
            margin-bottom: .1em;
            border-bottom: 1px solid #e5e5e5;
        }

        .li_active {
            /*box-shadow:-1px 0 1px #ccc, !*左边阴影*!*/
            /*1px 0 1px #ccc, !*右边阴影*!*/
            /*0 0px 0px #ccc, !*顶部阴影*!*/
            /*0 3px 3px #ccc; !*底边阴影*!*/
        }

        /* span.leftIcon{
            width: 10px;
            height: 10px;
            vertical-align: middle;
            position: relative;
            top: 12.5px;
            display: block;
            float: left;
            
            background: #34bd21;
        } */
        span.leftIcon {
            line-height: 35px;
            text-align: center;
            width: 35px;
            height: 35px;
            vertical-align: middle;
            position: relative;
            top: 5px;
            display: block;
            float: left;
            /* border: 1px solid #ccc; */
            background: #34bd21;
        }

        h4.expense-title {
            border-bottom: 1px solid #e5e5e5;
            padding-bottom: .5em;
            font-weight: bold !important;
        }

        .expense_wrap {
            border: 1px solid #e5e5e5;
            margin-top: 2em;
            border-radius: 4px;
        }

        .income_wrap {
            width: 100%;
            border: 1px solid #e5e5e5;
            margin-top: 2em;
            border-radius: 4px;
        }

        #data_ul li {
            cursor: pointer;
        }
        .form-control {
            border-bottom: 1px solid #ccc !important;
        }
    </style>
</head>
<body>
<div ng-app="dataHall" ng-controller="dataHallCtrl">
    <div class="col-lg-12 data-model waybill-modal">
        <div class="col-sm-3 col-md-3 col-lg-3 mb-10 clearfix">
            <div class="col-lg-12 data-class bg_blue clearfix">
                <p class="data-title text-left">余额(元)</p>
                <h2 class="data-num text-center">${ empty user.userPurse.webbalance ?'0.00':user.userPurse.webbalance}</h2>
            </div>
        </div>
        <div class="col-sm-3 col-md-3 col-lg-3 mb-10 clearfix">
            <div class="col-lg-12 data-class bg_light_green clearfix">
                <p class="data-title text-left">可用余额(元)</p>
                <h2 class="data-num text-center">${empty user.userPurse.availablebalance ?'0.00':user.userPurse.availablebalance}</h2>
            </div>
        </div>
        <div class="col-sm-3 col-md-3 col-lg-3 mb-10 clearfix">
            <div class="col-lg-12 data-class bg_deep_greeen clearfix">
                <p class="data-title text-left">应收(元)</p>
                <h2 class="data-num text-center" id='CREATETOTALCOST'>0.00</h2>
            </div>
        </div>
        <div class="col-sm-3 col-md-3 col-lg-3 mb-10 clearfix">
            <div class="col-lg-12 data-class bg_yellow clearfix">
                <p class="data-title text-left">应付(元)</p>
                <h2 class="data-num text-center" id='STAYPAYTOTALCOST'>0.00</h2>
            </div>
        </div>
        <div class="col-sm-3 col-md-3 col-lg-3 mb-10 clearfix">
            <div class="col-lg-12 data-class bg_orange clearfix">
                <p class="data-title text-left">卓币(元)</p>
                <h2 class="data-num text-center">${ empty user.userPurse.webcoin ?'0.00':user.userPurse.webcoin }</h2>
            </div>
        </div>
        <div class="col-sm-3 col-md-3 col-lg-3 mb-10 clearfix">
            <div class="col-lg-12 data-class bg_red clearfix">
                <p class="data-title text-left">可用卓币(元)</p>
                <h2 class="data-num text-center">${empty user.userPurse.availablecoin ?'0.00':user.userPurse.availablecoin }</h2>
            </div>
        </div>
        <div class="col-sm-3 col-md-3 col-lg-3 mb-10 clearfix">
            <div class="col-lg-12 data-class bg_dark_green clearfix">
                <p class="data-title text-left">油气(元)</p>
                <h2 class="data-num text-center">${empty user.userPurse.petrolbalance ?'0.00':user.userPurse.petrolbalance }</h2>
            </div>
        </div>
        <div class="col-sm-3 col-md-3 col-lg-3 mb-10 clearfix">
            <div class="col-lg-12 data-class bg_dark_yellow clearfix">
                <p class="data-title text-left">保证金(元)</p>
                <h2 class="data-num text-center">${empty user.userPurse.guaranteemone ?'0.00': user.userPurse.guaranteemone}</h2>
            </div>
        </div>

    </div>

    <div class="portlet">
        <div class="portlet-title">
            <div class="caption">
                <i class="fa fa-line-chart"></i>平台运单统计表
            </div>
            <div class="actions">
                <div class="btn-group" data-toggle="buttons">
                    <label class="btn btn-default btn-sm active" onclick="changeType(2)">
                        <input type="radio" name="options" class="toggle">支出统计 </label>
                    <label class="btn btn-default btn-sm" onclick="changeType(1)">
                        <input type="radio" name="options" class="toggle">收入统计
                    </label>

                </div>
            </div>
        </div>
        <div class="portlet-body clearfix">
            <div class="col-lg-6 pull-right clearfix mt-10 mb-10">
                <div class="col-lg-4 col-sm-4 col-md-4 col-xs-12">
                    <input type="text" readonly="readonly" class="border-bot form-control"
                           name="beginCreateDate" id="beginCreateDate" style="border-bottom: 1px solid #5c5c5c"
                           placeholder="选择开始时间"
                           onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                </div>
                <div class="col-lg-4 col-sm-4 col-md-4 col-xs-12">
                    <input type="text" readonly="readonly" class="border-bot form-control"
                           name="endCreateDate" id="endCreateDate" style="border-bottom: 1px solid #5c5c5c"
                           placeholder="选择结束时间"
                           onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
                </div>
                <div class="col-lg-4 col-sm-4 col-md-4 col-xs-12">
                    <input type="button" class="btn btn-primary" value="搜 索"
                           onclick="search()"/>
                </div>
            </div>

            <div class="col-lg-12" style="height: 400px;">
                <div style="width: 100%; height: 100%;">
                    <div id="moduleTypediv" class="echart-content" style=""></div>

                    <div class="charts_det pull-right" style="width: 40%;">
                        <ul id="data_ul" style="padding-right: 2em;">
                        </ul>
                        <!--                         <ul ng-repeat="x in incomeSumArr" style="padding-right: 2em;">
                                                    <li class="clearfix li_active">
                                                        <div class="pull-left">
                                                            <span class="fa fa-cart-plus leftIcon">
                                                            </span>
                                                            <span>{{x.name}}</span>
                                                            <span style="color: #999;" ng-if="income!=''" ng-cloak>{{x.value/income*100 | number:2}}%</span>
                                                            <span style="color: #999;" ng-if="income==''" ng-cloak>0%</span>
                                                        </div>
                                                        <div class="pull-right">
                                                            <span>{{x.value}}</span>
                                                            <span style="color: #999;">&nbsp; </span>
                                                        </div>
                                                    </li>
                                                </ul> -->
                    </div>
                </div>
            </div>
        </div>
    </div>


</div>

<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js"
        type="text/javascript"></script>
<script src="${ctxStatic }/jquery-plugin/jquery.cookie.js"></script>
<script type="text/javascript"
        src="${ctxStatic}/echarts/echarts.min.js"></script>
<script type="text/javascript"
        src="${ctxStatic}/echarts/echarts-all.js"></script>
<script
        src="${ctxStatic}/modules/wlpt/front/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">

    $.ajax({
        type: "POST",
        url: '${wlpt}/wlpt/personal/getOrderinfoSum',
        dataType: 'json',
        data: {},
        cache: false,
        success: function (data) {
            if (data.state == 1) {
                $("#STAYPAYTOTALCOST").html(
                        data.nopaymentOrder.sumtotalcost);
                fomatNum();
            }
        }
    });

    $.ajax({
        type: "POST",
        url: '${wlpt}/wlpt/personal/getBidOrderinfoSum',
        dataType: 'json',
        data: {},
        cache: false,
        success: function (data) {
            if (data.state == 1) {
                $("#CREATETOTALCOST")
                        .html(data.bidOrderNo.sumcontracttotal);
                fomatNum();
            }
        }
    });

    function fomatFloat(src, pos) {
        return Math.round(src * Math.pow(10, pos)) / Math.pow(10, pos);

    }
    function fomatPrice(price) {
        if (price * 1 >= 100000) {
            var p = price / 10000;
            p = p.toString();
            var index = p.indexOf(".", 0);
            index = index >= 0 ? index : p.length;
            index += 2;
            index = index < p.length ? index : p.length;
            price = "" + p.substring(0, index) + "万";
        } else {
            price = fomatFloat(price, 4);
        }
        return price;
    }

    function fomatNum() {
        var CREATETOTALCOST = $("#CREATETOTALCOST").html();
        var STAYPAYTOTALCOST = $("#STAYPAYTOTALCOST").html();
        $("#CREATETOTALCOST").html(
                fomatPrice(CREATETOTALCOST > 0 ? CREATETOTALCOST : "0"));
        $("#STAYPAYTOTALCOST").html(
                fomatPrice(STAYPAYTOTALCOST > 0 ? STAYPAYTOTALCOST : "0"));
        if (STAYPAYTOTALCOST == '0') {
            $("#CREATETOTALCOST").html("0.0");
        }
        if (STAYPAYTOTALCOST == '0') {
            $("#STAYPAYTOTALCOST").html("0.0");
        }
    }
</script>
<script type="text/javascript">
    $(function () {
        var dom = document.getElementById("moduleTypediv");
        var myChart = echarts.init(dom);
        var title = [];
        var dataVar = [];
        var TOTALCOUNT = 0;//
        var type = 2;

        window.changeType = function (thisType) {
            type = thisType;
            geroleCount();
        }

        window.search = function () {
            geroleCount();
        }

        geroleCount();
        function geroleCount() {
            $.ajax({
                type: "POST",
                url: '${wlpt}/wlpt/statistics/getFinancialData?tm='
                + new Date(),
                dataType: 'json',
                cache: false,
                data: {
                    'searchType': type,
                    'beginCreateDate': $("#beginCreateDate").val(),
                    'endCreateDate': $("#endCreateDate").val()
                },
                success: function (data) {
                    title = [];
                    dataVar = [];
                    if (data.data.varList != null
                            && data.data.varList.length > 0) {
                        $("#data_ul").html('');
                        var totalmoney = '';

                        for (var j = 0; j < data.data.varList.length; j++) {
                            var nowdata = data.data.varList[j];
                            totalmoney = totalmoney * 1 + nowdata.mony * 1;
                        }

                        for (var i = 0; i < data.data.varList.length; i++) {
                            var nowdata = data.data.varList[i];
                            title[i] = nowdata.name;
                            dataVar[i] = {
                                value: nowdata.mony,
                                name: nowdata.name
                            };

                            var html = '<li class="clearfix li_active" onclick="go(' + 1 + ')">'
                                    + '<div class="pull-left">'
                                    + '<span class="fa fa-cart-plus leftIcon">'
                                    + '</span>'
                                    + '<span style="padding-left:10px;">' + nowdata.name + '</span>'
                                    + '<span style="color: #999;padding-left:10px;" >' + ((nowdata.mony * 1 / totalmoney * 1) * 100).toFixed(2) + '%</span>'
                                    + '</div>'
                                    + '<div class="pull-right">'
                                    + ' <span>' + nowdata.mony + '</span>'
                                    + '<span style="color: #999;">&nbsp; </span>'
                                    + '</div>'
                                    + '</li>';
                            $("#data_ul").append(html);

                        }
                        setoption();
                    } else {
                        setEmptyOption();
                    }

                }
            });
        }

        function setoption() {
            myChart.clear();
            option = {
                /* title : {
                 text : '',
                 subtext : "",
                 x : 'center',
                 top : 10
                 }, */
                legend: {
                    top: 20,
                    orient: 'vertical',
                    x: 'left',
                    data: title,
                    padding: [30, 5, 5, 10]
                },
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                series: [{
                    name: "交易模块",
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '50%'],
                    data: dataVar,
                    label: {
                        normal: {
                            textStyle: {
                                color: 'rgba(255, 255, 255, 0.3)'
                            },
                            label: {
                                show: true
                            }
                        }
                    }

                }]
            };
            myChart.setOption(option);
        }

        function setEmptyOption() {
            myChart.clear();
            option = {
                /* title : {
                 text : '',
                 subtext : "",
                 x : 'center',
                 top : 10
                 }, */
                legend: {
                    top: 20,
                    orient: 'vertical',
                    x: 'left',
                    data: ["暂无数据"],
                    padding: [30, 5, 5, 10]
                },
                tooltip: {
                    trigger: 'item',
                    formatter: "{a} <br/>{b} : {c} ({d}%)"
                },
                series: [{
                    name: "交易模块",
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '50%'],
                    data: [{
                        value: 0,
                        name: "暂无数据"
                    }],
                    label: {
                        normal: {
                            textStyle: {
                                color: 'rgba(255, 255, 255, 0.3)'
                            },
                            label: {
                                show: true
                            }
                        }
                    }

                }]
            };
            myChart.setOption(option);
        }
    });

    window.go = function (args) {
        window.location.href = '${wlpt}/wlpt/statistics/toTransactionDetail?args=' + args;
    }

</script>
</body>
</html>
