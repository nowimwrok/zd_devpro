<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>招标详情</title>

    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/top_menu.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <style type="text/css">
        body {
            padding: 0;
            margin: 0;
            width: 100%;
            margin: 0 auto;
            text-align: center;
            border: 1px solid #D6D3CE;
            font-family: "微软雅黑";
        }

        ul p span a input td {
            font-family: "微软雅黑";
        }

        .user_infor_left {
            width: 25%;
        }

        .fabu_infor_right {
            width: 33%;
        }

        .col2_left {
            width: 10%;
        }

        .cols_right {
            width: 32%;
            text-align: left;
            padding-left: 5px;
        }

    </style>
</head>
<body>
<div class="table_2">
    <p class="user_data">
        <img src="${ctxStatic }/images/wlptfront/line-left.png">
        <span class="title_blue">招标</span>
        <span class="title_orange">详情</span>
        <img src="${ctxStatic }/images/wlptfront/line-right.png">
    </p>
    <table class="user-infor">
        <tr>
            <td class="user_infor_left">发布人：</td>
            <td class="fabu_infor_right">
                ${bidinfo.biduser.loginName}
            </td>
            <td class="col2_left">招标状态：</td>
            <td class="cols_right">
                <strong class="red_num">${bidstatus=='发布'?'竞标中':bidstatus}</strong>
            </td>
        </tr>

        <tr>
            <td class="user_infor_left">招标文号：</td>
            <td class="fabu_infor_right">
                ${bidinfo.bidcode}
            </td>
            <td class="col2_left">应标次数：</td>
            <td class="cols_right">${bidinfo.biddingcount}次</td>
        </tr>

        <tr>
            <td class="user_infor_left">招标货物：</td>
            <td class="fabu_infor_right">
                ${bidinfo.goods.goodsname}
            </td>
            <td class="col2_left">货物数量：</td>
            <td class="cols_right">${bidinfo.goods.freightvolume} ${bidinfo.goods.freightunit}</td>
        </tr>

        <tr>
            <td class="user_infor_left">发布时间：</td>
            <td class="fabu_infor_right">
                ${bidinfo.publishtimeFM}
            </td>
            <td class="col2_left">截止时间：</td>
            <td class="cols_right">${bidinfo.endtimeFM}</td>
        </tr>

        <tr>
            <td class="user_infor_left">结算类型：</td>
            <td class="fabu_infor_right">
                ${fns:getDictLabel(bidinfo.settlementtype, 'settlement_type', '')}
            </td>
            <td class="col2_left">栏标价格：</td>
            <td class="cols_right">${bidinfo.expectedprice}元/${bidinfo.goods.freightunit}</td>
        </tr>

        <tr>
            <td class="user_infor_left">需求车型：</td>
            <td class="fabu_infor_right">
                ${bidinfo.goods.cartype}
            </td>
            <td class="col2_left">车长要求：</td>
            <td class="cols_right">${bidinfo.goods.carlength} ${bidinfo.goods.lengthunit}</td>
        </tr>

        <tr>
            <td class="user_infor_left">始发地：</td>
            <td class="fabu_infor_right">
                ${bidinfo.goods.shipAddress.province} ${bidinfo.goods.shipAddress.city} ${bidinfo.goods.shipAddress.district}
            </td>
           <c:if test="${param.biddingprice!=null}">
              <td class="col2_left">我的竞标：</td>
            <td class="cols_right">${param.biddingprice}元/${bidinfo.goods.freightunit}</td>
        </tr>
             </c:if>
        <tr>
            <td class="user_infor_left">目的地：</td>
            <td class="fabu_infor_right">
                ${bidinfo.goods.consignAddress.province} ${bidinfo.goods.consignAddress.city} ${bidinfo.goods.consignAddress.district}
            </td>
            <td class="col2_left"></td>
            <td class="cols_right"></td>
        </tr>

        <tr>
            <td class="user_infor_left" style="vertical-align: text-top">备注：</td>
            <td class="fabu_infor_right">
                ${bidinfo.remarks}
            </td>
            <td class="col2_left"></td>
            <td class="cols_right"></td>
        </tr>



    </table>

    <c:if test="${blinfoList!=null && blinfoList.size()>0}">
        <div class="tab-thre tab-all" style="margin: 0 auto">
            <p class="user_data">
                <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue"></span><span
                    class="title_orange">提货单</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
            </p>
            <center>
                <table class="table table-condensed table-bordered" style="width:80%">

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


</body>
</html>
