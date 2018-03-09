<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_default_basic"/>

    <title>招标大厅-竞价</title>

    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/top_menu.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">

    <style>
        em {
            font-style: normal;
            font-weight: 700;
            font-family: 微软雅黑;
        }

        .container {
            height: auto;
            border: none;
            display: block;
            font-size: 13px;
        }

        .page-title2 {
            border-left: solid 2px #FF0000;
            width: 200px;
            height: 1.5em;
            font-size: 16px;
            font-weight: bold;
            line-height: 24px;
            padding-left: 10px;
            color: #555;
            margin: 20px;
            text-align: left;
        }

        .tables tr {
            line-height: 21px;
        }

        .table {
            font-size: 12px;
        }

        .table td {
            height: 30px;
            border: none;
        }

        .td_title {
            font-size: 14px;
            font-family: 微软雅黑;
            margin-top: 15px;
        }

        .user_data {
            text-align: center;;
        }

        .btn-warning {
            width: 300px;
            background-color: #FFC52F;
            border-color: #FFC52F;
            margin-top: 22.5px;
        }
    </style>

</head>
<body>


<div class="container" style="width:100%;">
    <p class="user_data">
        <img src="${ctxStatic }/images/wlptfront/line-left.png">
        <span class="title_blue">我要</span>
        <span class="title_orange">竞价</span>
        <img src="${ctxStatic }/images/wlptfront/line-right.png">
    </p>

    <div style="width: 100%; height: 380px;" ng-app="bidding" ng-controller="biddingCtrl">
        <div style="width: 42%; height: 380px; float: left; padding-left: 40px">
            <div class="page-title2" style="margin: 40px 28px 15px;">竞价信息</div>
            <div style="padding-left: 40px;">
                <table class="table">
                    <tr>
                        <td style="text-align: right;" class='td_title'>拦标价：</td>
                        <td class='td_title'><span id="unitprice" style="font-size:16px;"></span>
                            <c:choose>
                                <c:when test='${not empty bidinfo.expectedprice}'>
                                    ${bidinfo.expectedprice} 元/吨
                                </c:when>
                                <c:otherwise>暂未限制</c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right;" class='td_title'>我的出价：</td>
                        <td class='td_title'>
                            <input id="biddingprice" ng-model="biddingprice" type="text" name="biddingprice"
                                   oninput="priceCount()" style="width: 100px;font-size:15px;" maxlength="6"/>
                            元/吨
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right;" class='td_title'>总&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;价：
                        </td>
                        <td class='td_title'><span id="totalprices" style="color: #FF3300; ">{{freightvolume*biddingprice | number : 2}}</span>元
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="text-align: left" class='td_title'>
                            <input id="chkCondition" type="checkbox"/>
                            <span style="font-size:12px;">我已阅读</span>
                            <a target="_blank" onclick="openagreement('biddings');" target="_Blank">
                                <span style="color:blue;">《竞价协议》</span>
                            </a>
                        </td>
                    </tr>
                </table>
            </div>

            <div id="submit_data" style="text-align: center;">
                <button class="btn btn-warning" id="saveBtn" style="width: 120px;" ng-click="saveBtn()">
                    <span>提 交 竞 价</span>
                </button>
            </div>
            <input type="hidden" id="isreach" name="ISREACH">
            <div class="loading"><img src="/static/images/loading.gif"><p>加载中</p></div>
        </div>
        <div style="width: 1px; float: left; height: 280px; color: blue; border-right: 1px dashed gray; margin-top: 60px;"></div>
        <div style="width: 42%; height: 380px; float: left; padding-left: 100px">
            <div class="page-title2" style="margin: 40px 28px 15px;">招标信息</div>
            <div style="padding-left: 50px;">
                <table class="tables" width="300px">
                    <tr>
                        <td style="text-align: right;width:72px;" class='td_title'>截止时间：</td>
                        <td class='td_title'>
                            <c:if test="${bidinfo.bidstatus!='已截标'}">
                                <span style="font-size:21px;font-weight:bold;" id="endtimes" ></span>
                            </c:if>
                            <c:if test="${bidinfo.bidstatus=='已截标'}">
                                <span style="font-size:21px;font-weight:bold;" id="endtimes"> 0 + "天" + 0 + "时" + 0 + "分" + 0 + "秒"</span>
                            </c:if>
                            <input type="hidden" name="ENDTIME" id="endtime" value="${bidinfo.endtimeFM}"/>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right;" class='td_title'>货物名称：</td>
                        <td class='td_title'>${bidinfo.goods.goodsname}</td>
                    </tr>
                    <tr>
                        <td style="text-align: right;" class='td_title'>数量：</td>
                        <td class='td_title'><span
                                id="loadweight">${bidinfo.goods.freightvolume}</span>${bidinfo.goods.freightunit}
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right;" class='td_title'>始发地：</td>
                        <td class='td_title'>
                            ${bidinfo.goods.shipAddress.province}
                            ${bidinfo.goods.shipAddress.city}
                            ${bidinfo.goods.shipAddress.district}
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right;" class='td_title'>目的地：</td>
                        <td class='td_title'>
                            ${bidinfo.goods.consignAddress.province}
                            ${bidinfo.goods.consignAddress.city}
                            ${bidinfo.goods.consignAddress.district}
                        </td>
                    </tr>

                    <tr>
                        <td style="text-align: right;" class='td_title'>发布时间：</td>
                        <td class='td_title'>
                            <span id="sendtime">
                            <fmt:formatDate value="${bidinfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                            </span>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="page-title2" style="margin: 23px 28px 15px;">托运方信息</div>
            <div style="padding-left: 65px;">
                <table class="table">
                    <tr>
                        <td style="text-align: right;" class='td_title'>用户名：</td>
                        <td class='td_title'>${bidinfo.biduser.loginName}
                            <c:choose>
                                <c:when test="${bidinfo.biduser.userinfo.status==2}">
                                    <a class="user_checked" style="width: 36px;">已认证</a>
                                </c:when>
                                <c:otherwise>
                                    <!-- <a class="user-unchecked" style="width:36px;">未认证</a> -->
                                </c:otherwise>
                            </c:choose>
                            <a>
                                <img src="${ctxStatic}/images/wlptfront/pointlevel/point_level_${bidinfo.biduser.userinfo.pointlevle!=null?bidinfo.biduser.userinfo.pointlevle:0}.gif">&nbsp;
                            </a>
                        </td>
                    </tr>
                    <td style="text-align: right;" class='td_title'>电话：</td>
                    <td class='td_title'>${bidinfo.biduser.phone}</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
    <div style="height:1050px; width: 100%;padding-left: 40px;padding-right:30px">
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png">
            <span class="title_blue">竞标</span>
            <span class="title_orange">须知</span>
            <img src="${ctxStatic }/images/wlptfront/line-right.png">
        </p>

        <div class="data_bottom" style="padding-left:40px;magin:0px 28px 15px">
             <div style="font-size:16px;">本标要求</div>
            <div style="line-height:15px;font-size:14px;">
                <p>${bidinfo.remarks}</p>
            </div>
            <div style="line-height:15px;font-size:14px;">
                <!-- <p style="font-size:15px;padding-bottom:5px;">1、参与招投标的用户必须为平台认证会员。</p>
                <p style="font-size:15px;padding-bottom:5px;">2、单次竞价投标，需缴纳1000元/标投标保证金。账户余额不足，无法参与投标。</p>
                <p style="font-size:15px;padding-bottom:5px;">3、竞价投标提交后，同一标的不可进行二次投标。</p>
                <p style="font-size:15px;padding-bottom:5px;">4、投标结束后，中标者保证金由平台暂时扣除，未中标的会员全额退还保证金。</p> -->
                <p style="color:#555;font-size:13px;line-height:20px;padding-right:127px">
                    <span style="font-weight:bold">1.投标准入</span><br>
                    1.1 招标人准入资格<br>
                    （1）、合法经营的企业<br>
                    （2）、注册卓大物流平台账号并提交真实姓名、手机号、身份证号、营业执照照片进行认证，获得平台认证通过<br>
                    1.2 投标人准入资格<br>
                    （1）、拥有足够承担物流货运运输能力的车辆<br>
                    （2）、注册卓大物流平台账号并提交真实姓名、手机号、身份证号、营业执照照片进行认证，获得平台认证通过<br>
                    （3）、在平台缴纳${fns:getDictValue('投标保证金','bid_bond','')}元以上的招标保证金<br>
                    <span style="font-weight:bold">2.定标管理</span><br>
                    2.1 定标权限<br>
                    （1）、招标方拥有对所有投标人员的定标管理权限，可以自行选定中标方<br>
                    （2）、当投标人员不超过2人时，招标方可以进行废标处理，另行安排招标或自行安排运输<br>
                    （3）、当投标价格均超过拦标价是，招标方可进行废标处理，另行安排招标或自行安排运输<br>
                    2.2 定标影响因素<br>
                    招标方根据如下因素进行选标：<br>
                    （1）、投标价格<br>
                    （2）、平台信誉<br>
                    （3）、平台押金数额<br>
                    （4）、平台交易流水<br>
                    <span style="font-weight:bold">3.保证金说明</span><br>
                    （1）、为了维护投标方的权益，招标方需在平台缴纳${fns:getDictValue('投标保证金','bid_bond','')}元的保证金，当招标信息正常完成后，平台全额退回保证金；当招标信息被随意废标时，由平台扣除保证金。<br>
                    （2）、为了保证招标方的权益，投标方需在平台缴纳${fns:getDictValue('投标保证金','bid_bond','')}元保证金。出现如下情况，招投标结束后平台退还保证金：a.中标 b.不中标。出现如下情况，平台扣除保证金：a.中标后未按照要求及时签约
                    b.中标后货物未能按照要求运送到目的地<br>
                    <span style="font-weight:bold">4.押金说明</span><br>
                    为了保证招标方货物运输安全，参与投标的物流企业需在平台缴纳押金，根据运输能力的大小以及招标方要求，缴纳的押金数量不同。当投标方确认不需要在平台进行投标时，可申请退还押金。<br>
                    <span style="font-weight:bold">5.废标管理</span><br>
                    5.1 什么时候出现废标<br>
                    （1）、投标人数少于两人<br>
                    （2）、投标价均高于拦标价<br>
                    5.2 出现废标情况时如何处理<br>
                    （1）、当投标人数少于两人或投标价均低于拦标价两种情况出现其中一种情况时，招标人均有权选择废标处理。<br>
                    （2）、废标时短信通知投标方<br>
                    （3）、废标通知在平台公告栏展示<br>
                    5.3 废标后如何安排<br>
                    （1）、废标处理后，招标方可另行安排招标，若二次招标依然不满足要求，则自行安排运输<br>
                    （2）、招标方不进行二次招标直接安排运输<br>
                    <span style="font-weight:bold">6.平台充值与提现管理</span><br>
                    6.1 平台充值<br>
                    用户可在个人中心页面进行账户管理，当需要进行充值时，点击账户充值即可。<br>
                    6.2 平台提现<br>
                    用户可在个人中心页面进行账户管理，当需要提现时，提交提现申请，平台会在提交申请后的三个工作日内返还账户资金。提现账户必须与绑定账户一致。</p>
            </div>
        </div>
    </div>
</div>

<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/common/global.js"></script>
<script src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/angular/angular.min.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $(".loading").hide();//code
    });

    var app = angular.module('bidding', []);
    var isDerate=false;
    app.controller('biddingCtrl', function ($scope, $http) {
        $scope.freightvolume =${bidinfo.goods.freightvolume};
        $scope.biddingprice = 0;

        $http({
            url: "${wlpt}/wlpt/bid/isDerate",
            method: 'post',
            params: {}
        }).success(function (data) {
            if (data) {
            	isDerate=true;
            }
        });
        
        ///招标ID
        var bidinfo_id = "${bidinfo.id}";
        ///拦标价
        var expectedprice = "${bidinfo.expectedprice}";
		var isderate="0";

        $scope.saveBtn = function () {
            if (!priceCount()) {
                return;
            }
            if($(".loading").is(':hidden')){
                $(".loading").show();
            }else{
                return false;
            }
            if(isDerate){
                $.MsgBox.Confirm("交易提示","您有减免保证金的资格,是否使用?",function(){
                	isderate="1";
                    settotl();
                    saveBidding();
                },function(){
                	saveBidding();
                },"是","否");
            }else{
            	saveBidding();
            }
            

        };
        window.saveBidding=function (){
            $http({
                url: "${wlpt}/wlpt/bid/saveBidding",
                method: 'post',
                params: {biddingprice: $("#biddingprice").val(), "bidinfo.id": bidinfo_id,isderate : isderate}
            }).success(function (data) {
                $(".loading").hide();
                $.MsgBox.Alert("保存提示", data.message);
                if (data.state == 1) {
                    window.location.href = '${wlpt}/wlpt/hall/bids';
                } else {
                    $scope.biddingprice = 0;
                }
            });
        };
        ///计算价格
        window.priceCount = function () {
            var price = $("#biddingprice").val();

            if (!$("#chkCondition").is(':checked')) {
                $("#chkCondition").tips({
                    side: 3,
                    msg: '请勾选竞价协议',
                    bg: '#FF7300',
                    time: 3
                });
                return false;
            }


            var loadweight = $("#loadweight").html();
            if (price != '' && isNum($("#biddingprice"))) {

                var ex = /^\d+$/;

                if (parseFloat(price) > parseFloat(expectedprice)) {
                    $("#biddingprice").tips({
                        side: 3,
                        msg: '您的价格已高于拦标价',
                        bg: '#FF7300',
                        time: 3
                    });
                    return false;
                } else if (!checkPrice(price)) {
                    $("#biddingprice").tips({
                        side: 3,
                        msg: '请输入正确的价格',
                        bg: '#FF7300',
                        time: 3
                    });
                    return false;
                } else {
                    var temp = parseFloat(price) * parseFloat(loadweight) + '';
                    var totalConst = "";
                    if (temp.indexOf(".") != -1
                            && temp.split(".")[1].length > 2) {
                        totalConst += temp.split(".")[0] + "."
                                + temp.split(".")[1].substring(0, 2);
                    } else {
                        totalConst += temp;
                    }
                    $("#totalprices").html(totalConst);
                    return true;
                }
            } else {
                $("#biddingprice").tips({
                    side: 3,
                    msg: '请输入正确信息',
                    bg: '#FF7300',
                    time: 3
                });
                return false;
            }
        };
        priceCount();

        window.settotl= function (){

            var price = $("#biddingprice").val()*1;
            var loadweight = $("#loadweight").html()*1;
            var temp = parseFloat(price) * parseFloat(loadweight) + '';
            var totalConst = "";
            if (temp.indexOf(".") != -1
                    && temp.split(".")[1].length > 2) {
                totalConst += temp.split(".")[0] + "."
                        + temp.split(".")[1].substring(0, 2);
            } else {
                totalConst += temp;
            }
            $("#totalprices").html(totalConst);
        };



        function GetRTime() {
            var EndTime = new Date($("#endtime").val());
            var NowTime = new Date();
            var t = EndTime.getTime() - NowTime.getTime();
            var d = 0;
            var h = 0;
            var m = 0;
            var s = 0;
            if (t >= 0) {
                d = Math.floor(t / 1000 / 60 / 60 / 24);
                h = Math.floor(t / 1000 / 60 / 60 % 24);
                m = Math.floor(t / 1000 / 60 % 60);
                s = Math.floor(t / 1000 % 60);
            }

            $("#endtimes").html(d + "天" + h + "时" + m + "分" + s + "秒");

        }

        setInterval(GetRTime,0);

        //格式化时间
        function FormatDate(strTime) {
            var str = strTime.split(":");
            return str[0] + ":" + str[1];
        }

        //校验数字
        function isNum(obj) {
            var n = $(obj).val();
            if (n != '' && (isNaN(n) || parseInt(n) == 0 || parseInt(n) < 0)) {
                $(obj).tips({
                    side: 3,
                    msg: '请输入正数',
                    bg: '#FF7300',
                    time: 3
                });
                $(obj).val('');
                return false;
            }
            return true;
        }

        //格式数字后面的0
        function geShi(num) {
            if (num != null && num != "") {
                return parseFloat(num);
            } else {
                return "--";
            }
        }


        function checkPrice(price) {
            return (/^(([1-9]\d*)|\d)(\.\d{1,2})?$/).test(price.toString());
        }

        $("#loadweight").html(geShi($("#loadweight").html()));
        //格式化数量


    });


</script>
</body>
</html>
