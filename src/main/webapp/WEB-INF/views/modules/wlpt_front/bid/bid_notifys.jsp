<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>中标通知</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/top_menu.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <style>
        @media screen {
            .printhide {
                display: block
            }
        }

        @media print {
            .printhide {
                display: none
            }
        }

        .carType {
            width: 100px;
        }

        .carLength {
            width: 80px;
        }

        .isSocialCar {
            width: 80px;
        }

        .btnSearch {
            line-height: 24px;
            width: 135px;
        }

        .control_ul {
            width: 75px;
        }

        .control_ul li {
            text-align: left;
        }

        .control_ul li a {
            margin: 5px;
            color: rgba(53, 24, 167, 0.64);
        }

        .td_first {
            text-align: left;
            padding-left: 12px;
        }

        .font_name {
            font-size: 16px;
            font-weight: bold;
            color: #938F8F;
        }

        .td_first span {
            margin: 0px 1px;
        }

        .data_table td {
            text-align: center;
        }

        .line-icon {
            background: url("static/images/wi-icon.png") no-repeat scroll 0 0 transparent;
            display: inline-block;
            font-size: 0;
            overflow: hidden;
            vertical-align: middle;
        }

        .line-arrow {
            background-position: -32px 0px;
            width: 13px;
            height: 16px;
        }

        .font_rd {
            font-size: 20px;
            color: #F74000;
            margin-top: -20px;
        }

        .didInfo_table {
            width: 650px;
        }

        .didInfo_table td {
            line-height: 35px;
        }

        .linkdiv {
            width: 82px;
            float: left;
        }

        .regbt {
            letter-spacing: 1px;
            width: 140px;
            height: 30px;
        }

        .page_title_small {
            border-left: solid 2px #FF0000;
            height: 1.2em;
            font-size: 16px;
            line-height: 20px;
            padding-left: 6px;
            margin: 20px;
        }

        .textright {
            border-top: 0px;
            border-left: 0px;
            border-right: 0px;
        }
    </style>
</head>


<body style="height:900px;">

<div id="cp_content">
    <div class="cp_contentdiv">

        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">招标</span><span
                class="title_orange">信息</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
        </p>
        <form action="${wlpt}/wlpt/bid/saveNotifys" name="Form" id="Form" method="post">
            <input name="id" value="${bidOrderinfo.id}" type="hidden">
            <table class="printhide" style="width: 780px">
                <colgroup>
                    <col width="14%">
                    <col width="15%">
                    <col width="12%">
                    <col width="60%">
                </colgroup>

                <tr>
                    <td colspan="4">
                        <div style="text-decoration: underline; width: 780px; text-indent: 25px">
								<textarea id="noticeinfo" name="noticeinfo" style="resize: none; width: 685px;height:100px; font-size:13px;" onblur="isNull(this)"></textarea>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <div style="padding-left:22px">
                            <span style="font-size:13px;font-family:serif;">(以上信息将以短信形式发送到对方注册手机上)</span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" style="padding: 10px 30px;">
                        <input id="fabu" type="button" class="regbt" value="发送中标通知" onclick="save()"/>
                        <input id="print" type="button" class="regbt" value="打印中标通知书"/> <br>
                        <span style="color: #F74000; height: 50px; line-height: 50px;display:none;">该招标属于平台担保类型，在确认中标信息后，请于15日内，将运费信息支付到平台哦。</span>
                    </td>
                </tr>
            </table>
        </form>
        <div class="print"
             style="width:100%;height:500px;padding-top:50px;margin-left: 23px;">
            <div style="width: 92%;height:50px;text-align:center;">
                <h1>
                    <span style="color: red;font-size:26px;">中标通知书</span>
                </h1>
            </div>
            <div style="font-size:20px;width: 92%;">
                <div style="font-size:20px;width:100%;/* padding-left:37px; */">
                    ${biddinginfo.biddinguser.loginName}: <br/>
                    <br/>
                    <div style="text-indent:32px; font-size:20px;">恭喜！你单位在卓大平台上招标文号为
                        ${biddinginfo.bidinfo.bidcode} 的招标项目中，经评委综合评审，你单位满足招标要求确定为此项目中标单位。请务必在
                        <span id="thistimes" style="text-indent:32px;font-size:20px"></span>日17:00前到邯钢钢材现货交易中心一楼101签订运输合同。过期废标！0310-3188756
                    </div>
                    <div style="text-indent:32px;font-size:20px">
                        <div style="float:left;font-size:20px;margin:0;">总价：</div>
                        <div id="price" style="margin:0;font-size:20px;float:left;">
                            <fmt:formatNumber value="${bidinfo.goods.freightvolume*biddinginfo.biddingprice}" type="Double"
                                              pattern="0.00"></fmt:formatNumber>
                        </div>
                         元（具体单价详见招标比价单）
                    </div>
                    <div style="text-indent:32px;font-size:20px">
                        <div style="float:left;font-size:20px;margin:0;">吨数：</div>
                        <div id="bidloadweight" style="margin:0;font-size:20px;float:left;">
                        ${bidinfo.goods.freightvolume}</div>
                        ${bidinfo.goods.freightunit}（具体重量详见招标比价单）
                    </div>
                    <div style="text-indent:32px;font-size:20px;">具体要求以招标文件和合同为准。</div>
                    <input type="hidden" id="loadweight" value="${pd.LOADWEIGHT}"/>
                        <input type="hidden" id="biddingprice" value="${pd.BIDDINGPRICE}"/>
                    <div
                            style="text-indent:32px;font-size:20px">特此通知。
                    </div>
                    <br/>
                </div>
                <div>
                    <div style="padding-top:100px;">
                        <span style="font-size:16px;padding-left:495px;padding-top: 20px;">代理单位：（盖章）</span>
                        <br/>
                        <span style="padding-left:494px;">日期：<span id="nowdates">2015</span></span>
                    </div>
                    <div style="margin-top:-121px;;padding-left:475px;" class="printhide">
							<span style="padding-bottom:10px;">
								<img alt="" src="${pageContext.request.contextPath}/static/images/zd2.png" style="width:180px;height:180px;">
							</span>
                    </div>
                </div>
            </div>
            <div></div>
        </div>
    </div>
</div>

<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/include/zDialog/zDialog.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/include/zDialog/zDrag.js"></script>
<script type="text/javascript">
    $("#print").click(function () {
        window.print();
    });
    //提交
    function save() {
        if (isNull($("#noticeinfo"))) {
            $("#fabu").attr('disabled', 'disabled');
            $("#Form").submit();
        }
    }
    //非空判断，为空返回false，不为空返回true
    function isNull(obj) {
        var content = jQuery.trim($(obj).val());
        if (content == null || content == '') {
            $(obj).tips({
                side: 3,
                msg: '不能为空',
                bg: '#FF7300',
                time: 3
            });
            return false;
        }
        return true;
    }

    var myDate = new Date();
    $("#nowdates").html(myDate.toLocaleDateString());
    myDate.setDate(myDate.getDate() + 2);
    var thedate = myDate.getDate() < 10 ? "0" + myDate.getDate() : myDate
            .getDate(); //获取当前几号，不足10补0
    var thetimes = (myDate.getMonth() + 1) + "月"
            + thedate;
    $("#thistimes").html(thetimes);
    $("#noticeinfo").val("恭喜您在卓大物流网竞价的钢材运输项目已中标，请务必在" + thetimes + "日17:00前到邯钢钢材现货交易中心一楼101签订运输合同。过期废标！0310-3188756");

    var loadweight = $("#loadweight").val();
    var biddingprice = $("#biddingprice").val();

    if (loadweight != "" && biddingprice != null) {
        $("#price").html(((loadweight * 1) * (biddingprice * 1)).toFixed(2));
        $("#bidtotal").val(((loadweight * 1) * (biddingprice * 1)).toFixed(2));
    }

    //是否已经生成运输合同
    $(function () {
        var BIDINFO_ID = $("#BIDINFOID").val();
        if (BIDINFO_ID != null && BIDINFO_ID != "") {
            $.ajax({
                url: "${pageContext.request.contextPath}/wlpt/orders/isBidOrder",
                dataType: 'json',
                data: {BIDINFOID: BIDINFO_ID},
                type: 'post',
                cache: false,
                async: false,
                success: function (data) {
                    if (data.count > 0) {
                        $("#fabu").attr("disabled", true);
                        $("#fabu").val("已发送中标通知");
                        $("#nowdates").html('${pd.NOTICETIME}');

                        var myDates = new Date('${pd.NOTICETIME}');
                        myDates.setDate(myDates.getDate() + 2);
                        var thedates = myDates.getDate() < 10 ? "0" + myDates.getDate() : myDates
                                .getDate(); //获取当前几号，不足10补0
                        var thetimess = (myDates.getMonth() + 1) + "月"
                                + thedates;
                        $("#thistimes").html(thetimess);
                        $("#noticeinfo").val(
                                "恭喜您在卓大物流网竞价的钢材运输项目已中标，请务必在" + thetimess + "日17:00前到邯钢钢材现货交易中心一楼101签订运输合同。过期废标！0310-3188756");
                    }
                }


            });
        }
    });

    //格式数字后面的0
    function geShi(num) {
        if (num != null && num != "") {
            return parseFloat(num);
        } else {
            return "--";
        }
    }
    $("#price").html(geShi($("#price").html()));
    $("#bidloadweight").html(geShi($("#bidloadweight").html()));
</script>


</body>
</html>
