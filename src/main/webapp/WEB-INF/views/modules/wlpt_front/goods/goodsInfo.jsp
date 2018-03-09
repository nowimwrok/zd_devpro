<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>货源查看</title>
    <style type="text/css">
        body {
            padding: 0;
            margin: 0;
            width: 100%;
            margin: 0 auto;
            text-align: center;
            font-family: "微软雅黑";
        }

    </style>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
</head>
<body>
<div class="content_wrap">
    <p class="user_data">
        <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue"></span><span
            class="title_orange">查看</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
    </p>
    <table class="table_border" cellpadding="0" cellspacing="0">
        <tr>
            <td class="cols_1 center-tit" colspan=4><span class="orange_bold">${goods.goodsname}</span></td>
        </tr>

        <tr>
            <td class="cols_1">始发地:</td>
            <td class="cols_2" colspan=3>${goods.shipAddress.city}${goods.shipAddress.district}
            </td>
        </tr>

        <tr>
            <td class="cols_1">详细地址:</td>
            <td class="cols_2" colspan=3>${goods.shipAddress.address }
            </td>
        </tr>

        <tr>
            <td class="cols_1">目的地:</td>
            <td class="cols_2" colspan=3>${goods.consignAddress.city }${goods.consignAddress.district }
            </td>
        </tr>

        <tr>
            <td class="cols_1">详细地址:</td>
            <td class="cols_2" colspan=3>${goods.consignAddress.address }</td>
        </tr>

        <tr>
            <td class="cols_1">货物重量:</td>
            <td class="cols_2">${goods.freightvolume }${goods.freightunit }</td>
            <td class="cols_3">货物类型:</td>
            <td class="cols_4"><c:if test="${goods.goodstype == '0'}">轻货</c:if><c:if
                    test="${goods.goodstype == '1'}">重货</c:if></td>
        </tr>
        <c:if test="${not empty goods.isinsur and goods.isinsur eq 1 }">
        <tr>
            <td class="cols_1">是否投保:</td>
            <td class="cols_2">${fns:getDictLabel(goods.isinsur,'yes_no','')}</td>
            <td class="cols_3">保单支付方:</td>
            <td class="cols_4">${fns:getDictLabel(goods.paypeople,'insur_paypeople','')}</td>
        </tr>
        </c:if>
        

        <tr>
            <td class="cols_1">货主出价:</td>
            <td class="cols_2">${goods.expectedprice }元/${goods.freightunit }</td>
            <td class="cols_3">货物类别:</td>
            <td class="cols_4"><c:if test="${goods.gsoddtype == '1'}">成品</c:if><c:if
                    test="${goods.gsoddtype == '2'}">原料</c:if></td>
        </tr>
        <tr>
            <td class="cols_1">运输方式:</td>
            <td class="cols_2">${goods.transportway }</td>
            <td class="cols_3">货物价值:</td>
            <td class="cols_4">${goods.worth!='0.00'?goods.worth:""}${goods.worth!='0.00'?"元":""}</td>
        </tr>
        <tr>
            <td class="cols_1">车型要求:</td>
            <td class="cols_2">${goods.cartype}</td>
            <td class="cols_3">车长要求:</td>
            <td class="cols_4">${not empty goods.carlength?goods.carlength:"不限"}${not empty goods.carlength?"米":""}</td>
        </tr>
        <tr>
            <td class="cols_1">用户名:</td>
            <td class="cols_2" colspan=3>${goods.user.name }
                <c:if test="${goods.user.userinfo.status == '2' }">
                    <span class="list_one_2 bg_light_green">已认证</span></c:if>
                <c:if test="${goods.user.userinfo.status != '2' }">
                    <span class="list_one_2 bg_light_green">未认证</span></c:if>
            </td>
        </tr>
        <tr>
            <td class="cols_1">信用等级</td>
            <td class="cols_2"><img src="${ctxStatic}/images/wlptfront/pointlevel/point_level_${goods.user.userinfo.pointlevle!=null?goods.user.userinfo.pointlevle:0}.gif"></td>
            <td class="cols_3">担保金额:</td>
            <td class="cols_4"><span class="orange_bold">${not empty goods.user.userPurse.guaranteemone?goods.user.userPurse.guaranteemone:""}</span>${not empty goods.user.userPurse.guaranteemone?"元":""}</td>
        </tr>

        <tr>
            <td class="cols_1">联系人姓名：</td>
            <td class="cols_2">${goods.shipAddress.linkman }</td>
            <td class="cols_3">联系电话:</td>
            <td class="cols_4">${goods.shipAddress.linkmobile }</td>
        </tr>

        <tr>
            <td class="cols_1">发货时间：</td>
            <td class="cols_2">${sendtime}</td>
            <td class="cols_3">有效天数:</td>
            <td class="cols_4">${goods.effectdays }</td>
        </tr>

        <tr>
            <td class="cols_1">补充说明:</td>
            <td class="cols_2" colspan=3>${goods.remarks }</td>
        </tr>

    </table>

    <c:if test="${blinfoList!=null && blinfoList.size()>0}">
        <div class="tab-thre tab-all" style="margin: 0 auto">
            <p class="user_data">
                <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue"></span><span
                    class="title_orange">提货单</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
            </p>
            <center>
                <table class="table table-condensed table-bordered" style="width:100%">

                    <tbody>
                    <tr>
                        <th>提货单号</th>
                        <th>品名材质</th>
                        <th>规格</th>
                        <th>定尺\板宽</th>
                        <th>数量\吨</th>
                        <th>批次号</th>
                    </tr>
                    <tr id="content-mark" style="display:none"></tr>
                    <c:forEach var="item" items="${blinfoList}" varStatus="status">
                        <input type="hidden" name="blinfoList[${status.index}].blcode" value="${item.blcode}">
                        <input type="hidden" name="blinfoList[${status.index}].namematerials"
                               value="${item.namematerials}">
                        <input type="hidden" name="blinfoList[${status.index}].standard" value="${item.standard}">
                        <input type="hidden" name="blinfoList[${status.index}].width" value="${item.width}">
                        <input type="hidden" name="blinfoList[${status.index}].quantity" value="${item.quantity}">
                        <input type="hidden" name="blinfoList[${status.index}].batch" value="${item.batch}">
                        <input type="hidden" name="blinfoList[${status.index}].id" value="${item.id}">
                        <tr>
                            <td>${item.contractno}</td>
                            <td>${item.namematerials}</td>
                            <td>${item.standard}</td>
                            <td>${item.width}</td>
                            <td>${item.quantity}</td>
                            <td>${item.batch}</td>
                        </tr>
                    </c:forEach>

                    </tbody>
                </table>
            </center>
        </div>
    </c:if>


    <div style="margin: 10px auto">
        <a class="btn btn-warning" href="#" onClick="javascript :history.back(-1);">返 回</a>
    </div>


</div>


<script src="http://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script src="http://cdn.bootcss.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
<script>


</script>
</body>
</html>
