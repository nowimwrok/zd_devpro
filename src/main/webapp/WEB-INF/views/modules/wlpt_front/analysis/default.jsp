<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="stylesheet" href="/static/modules/wlpt/front/css/analysis/global.css"/>
</head>
<body>

<div class="container-fluid" id="main-container">
    <div id="page-content" class="clearfix content" style="background-color: #eee;">
        <div class="box-top">卓大物流平台数据分析中心</div>
        <div class="box">
            <div class="data-block">
                <div class="bgcolr-white block-bx" style=" margin: 0px 2% 0px 0px;"><!--每日信息-->
                    <dl>
                        <dt>[今日运单:<span id="nowDayNO">100</span>单]</dt>
                        <dd><span id="nowDayMY">32902</span>元</dd>
                    </dl>
                </div>
                <div class="bgcolr-white  block-bx">
                    <dl>
                        <dt>[昨日运单:<span id="yesteDayNO">100</span>单]</dt>
                        <dd><span id="yesteDayMY"></span>元</dd>
                    </dl>
                </div>
                <div class="bgcolr-white  block-bx">
                    <dl>
                        <dt>[较上一日日运单]</dt>
                        <dd style="color: red;"><i id="addPid">+31</i>%</dd>
                    </dl>
                </div>
                <div class="bgcolr-white"
                     style="margin: 0px 0px 0px 2%;background-color: #24C1C1;padding-top: 15px;height: 85px;">
                    <iframe width="200" scrolling="no" height="55" frameborder="0" allowtransparency="true"
                            src="http://i.tianqi.com/index.php?c=code&id=35&icon=1&num=3"
                    ></iframe>
                </div>
            </div><!--data-block end  数据块-->
            <div class="split-title">平台用户趋势分析</div><!--分隔标题-->
            <div class="data-echart bgcolr-white">
                <iframe name="mainFrame" id="userFrame" frameborder="0"
                        src="${wlpt}/wlpt/dataCenter/user_trend"
                        style="margin:0 auto;width:100%;height:100%;" scrolling="no"></iframe>
            </div>
            <div class="split-title">平台业务趋势分析</div><!--分隔标题-->
            <div class="data-echart bgcolr-white">
                <iframe name="mainFrame" id="orderFrame" frameborder="0"
                        src="${wlpt}/wlpt/dataCenter/order_trend"
                        style="margin:0 auto;width:100%;height:100%;" scrolling="no"></iframe>
            </div>
            <div class="split-title">平台招标趋势分析</div><!--分隔标题-->
            <div class="data-echart bgcolr-white">
                <iframe name="mainFrame" frameborder="0" src="${wlpt}/wlpt/dataCenter/bid_trend"
                        style="margin:0 auto;width:100%;height:100%;" scrolling="no"></iframe>

            </div>

        </div>

    </div><!--/#page-content-->
</div><!--/.fluid-container#main-container-->

<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="/static/echarts/echarts.min.js"></script>

</body>
</html>

