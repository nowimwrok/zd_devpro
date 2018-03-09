<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_web_basic"/>
    <title>卓大商城-团购</title>
    <link href="${ctxStatic}/bootstrap/2.3.1/css_3.2cerulean/bootstrap.min.css" type="text/css" rel="stylesheet"/>

</head>

<body>
<link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/shoplist-detail.css">
<style>
    * {
        margin: 0px;
        padding: 0px;
    }

    body {
        font-family: "微软雅黑";
        font-size: 15px;
    }

    a {
        text-decoration: none;
    }
</style>
<div class="banner-wrap">
    <div class="ban-pur">
        <img src="${ctxStatic }/images/wlptfront/shop_img/shop_log.jpg" class="banner-img">
        <div class="purchase">
            <p class="ban-title">机动车辆商业险</p>
            <div class="countDown">
                <p class="countDown-l"><span class="count">团购活动火热进行中</span><a>相同保障，更多优惠</a></p>
                <p class="countDown-r" id="colockbox1">
                    <a>距离结束:</a>
                    <span class="day">1</span>
                    <a>天</a>
                    <span class="hour">23</span>
                    <a>小时</a>
                    <span class="minute">56</span>
                    <a>分</a>
                    <span class="second">23</span>
                    <a>秒</a>
                </p>
            </div>
            <p class="cD-price">促销价：<span id="price">￥299</span></p>
            <p class="cD-price">促销：30万以下车型享此优惠（奔驰、宝马、沃尔沃）</p>
            <%--<p class="cD-price redwat">团购红包:</p>--%>
            <button class="btn-blue" id="purchase-alert" onclick="showBg1();"><a href="#">立即购买</a></button>
            <div id="fullbg"></div>
            <div id="dialog">
                <p class="close">
                    <a href="#" onclick="closeBg();">X</a>
                </p>
                <div class="dialog-content">
                    <img src="${ctxStatic }/images/wlptfront/shop_img/alert.png"><br/>
                    <p>本产品暂不支持线上购买</p>
                    <p>请拨打客服电话<span>0310-3188756</span>了解详情</p>
                    <p class="close_content"><a href="#" onclick="closeBg1();">知道了</a></p>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="list-detail">
    <p style="padding: 0; margin: 0;"><span class="list-title">产品详情</span></p>
    <p class="p-all">
        一、承包VIP：
        <div class="vip-de de-all">
    <p>1、单保交强险依上年出险情况，享受最低折扣。</p>
    <p>2、加保商业险，上年0-1次出险客户可享受直销保费的5.95折优惠。</p>
    <p>3、保证足额投保，不缩减任何险种的保额，提供最佳险种组合方案，让您以最少的保费获得最大的保障。</p>
    <p>4、车价30万以下的非进口车辆投保车损险免费赠送4S店专修（除外车型标明）。</p>
    <p>5、上门收款、上门送单。</p>
</div>
</p>


<p class="p-all">
    二、费用政策：
<div class="expense-de de-all">
    <table border="0" cellspacing="0">
        <thead>
        <tr>
            <th style="width:14%;">车型</th>
            <th style="width:14%;">业务类型</th>
            <th style="width:14%;">出险次数</th>
            <th style="width:14%;">保险下限</th>
            <th style="width:14%;">保险上限</th>
            <th style="width:15%;">一重好礼</th>
            <th style="width:14%;">说明</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td rowspan="17" class="td_bold">30万以下</td>
            <td>单保交强险</td>
            <td>—</td>
            <td>—</td>
            <td>—</td>
            <td>300元红包</td>
            <td rowspan="19" style="width:80px">1、30万以上车辆（承保车损险）只享受系统正常折扣优惠，不再享有好礼红包。<br>2、奔驰、宝马、沃尔沃品牌不承保车损险</td>
        </tr>
        <tr>
            <td rowspan="4">新车</td>
            <td rowspan="4">—</td>
            <td>800</td>
            <td>1800</td>
            <td>450元红包</td>
        </tr>
        <tr>
            <td>1800</td>
            <td>2800</td>
            <td>600元红包</td>
        </tr>
        <tr>
            <td>2800</td>
            <td>3800</td>
            <td>750元红包</td>
        </tr>
        <tr>
            <td>3800</td>
            <td>—</td>
            <td>900元红包</td>
        </tr>


        <tr>
            <td rowspan="12">旧车</td>
            <td rowspan="4">0.0</td>
            <td>500</td>
            <td>1500</td>
            <td>450元红包</td>
        </tr>
        <tr>
            <td>1500</td>
            <td>2500</td>
            <td>700元红包</td>
        </tr>
        <tr>
            <td>2500</td>
            <td>—</td>
            <td>900元红包</td>
        </tr>
        <tr>
            <td>3500</td>
            <td>3500</td>
            <td>1150元红包</td>
        </tr>

        <tr>
            <td rowspan="4">1.1</td>
            <td>500</td>
            <td>1500</td>
            <td>400元红包</td>
        </tr>
        <tr>
            <td>1500</td>
            <td>2500</td>
            <td>600元红包</td>
        </tr>
        <tr>
            <td>2500</td>
            <td>3500</td>
            <td>800元红包</td>
        </tr>
        <tr>
            <td>3500</td>
            <td>—</td>
            <td>1000元红包</td>
        </tr>

        <tr>
            <td rowspan="4">2.2</td>
            <td>500</td>
            <td>1500</td>
            <td>300元红包</td>
        </tr>
        <tr>
            <td>1500</td>
            <td>2500</td>
            <td>600元红包</td>
        </tr>
        <tr>
            <td>2500</td>
            <td>3500</td>
            <td>800元红包</td>
        </tr>
        <tr>
            <td>3500</td>
            <td>—</td>
            <td>1000元红包</td>
        </tr>


        <tr>
            <td class="td_bold">30万以上</td>
            <td>单保交强险</td>
            <td>—</td>
            <td>—</td>
            <td>—</td>
            <td>300元红包</td>
        </tr>
        </tbody>
    </table>
</div>
</p>
<p class="p-all">
    三、增值服务：凡投保商业险车辆均可享受以下十一项免费服务：
    <div class="de-all">
<p>1、派送燃料服务。
    2、更换轮胎服务。
    3、困境托吊服务。
    4、电瓶充电服务。
    5、平板拖车服务。
    6、医疗救援服务。
    7、自驾游救援后续服务。
    8、故障现场快修服务。
    9、在线故障排除指导服务。
    10、加水服务。
    11、代办车辆年检、年审服务
</p>
</div>
</p>

<p class="p-all">
    四、理赔VIP：
    <div class="de-all">
<p>1、全国统一客户服务热线95500，提供365*24小时接报案、咨询、查询等服务。</p>
<p>2、接到车险客户报案后，查勘员15分钟内主动与客户联系，确认事故车辆确切位置或地址，约定查勘时间，并在双方约定的时间内完成查勘服务。</p>
<p>3、运用3G快速理赔新技术，车险小额案件实现当日出险，当日赔付。对5000元以下不涉及保证足额投保，不缩减任何险种的保额，提供最佳险种组合方案，让您以最少的保费获得最大的保障。</p>
<p>4、提供上门理赔，当场赔付的服务。车价30万以下的非进口车辆投保车损险免费赠送4S店专修（除外车型标明）。</p>
<p>5、运用3G快速理赔新技术，车险小额案件实现当日出险，当日赔付。对5000元以下不涉及保证足额投保，不缩减任何险种的保额上门收款、上门送单。</p>
<p>6、为客户提供透明的全险种承保理赔信息自主查询服务。对于车险客户，在“报案受理、人上特别提醒</p>
<p>7、为客户提供透明的全险种承保理赔信息自主查询服务。对于车险客户，在“报案受理、人上特别提醒</p>
<p>8、为客户提供透明的全险种承保理赔信息自主查询服务。对于车险客户，在“报案受理、人上特别提醒</p>
</div>
</p>
<p class="p-all">
    五、本活动期限为一年。到期后无异议可顺延。
</p>
<p class="p-all">
    六、本活动解释权归太平洋保险公司邯郸中心支公司。
</p>
</div>
<script src="${ctxStatic }/jquery/jquery-1.9.1.js"></script>
<script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.js"></script>
<script>

    //倒计时
    $(function () {
        countDown("2017/09/10 18:00:00", "#colockbox1");
    });
    function countDown(time, id) {
        var day_elem = $(id).find('.day');
        var hour_elem = $(id).find('.hour');
        var minute_elem = $(id).find('.minute');
        var second_elem = $(id).find('.second');
        var end_time = new Date(time).getTime(),//月份是实际月份-1
                sys_second = (end_time - new Date().getTime()) / 1000;
        var timer = setInterval(function () {
            if (sys_second > 1) {
                sys_second -= 1;
                var day = Math.floor((sys_second / 3600) / 24);
                var hour = Math.floor((sys_second / 3600) % 24);
                var minute = Math.floor((sys_second / 60) % 60);
                var second = Math.floor(sys_second % 60);
                day_elem && $(day_elem).text(day);//计算天
                $(hour_elem).text(hour < 10 ? "0" + hour : hour);//计算小时
                $(minute_elem).text(minute < 10 ? "0" + minute : minute);//计算分钟
                $(second_elem).text(second < 10 ? "0" + second : second);//计算秒杀
            } else {
                clearInterval(timer);
            }
        }, 1000);
    }

    function showBg1() {                    //定义 showBg1 函数
        var bh = $("body").height();       //获得整个body（浏览器窗口）的高度 并 赋值给 bh 
        var bw = $("body").width();      //获得整个body（浏览器窗口）的宽度 并 赋值给 bw
        $("#fullbg").css({             // 通过 JQ 的css（） 事件，给选中的节点 （“#fullbg”）添加属性
            height: bh,
            width: bw,
            display: "block"
        });
        $("#dialog").show();          //并且让 节点（“dialog”） show（）出来
    }

    function closeBg() {
        $("#fullbg,#dialog").hide();      //关闭弹出款  通过 hide（） 方法
    }
    function closeBg1() {
        $("#fullbg,#dialog").hide();      //关闭弹出款  通过 hide（） 方法
    }


</script>
</body>
</html>
