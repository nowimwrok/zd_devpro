<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>报价查看</title>
    <style type="text/css">
    body{
        padding: 0;
        margin: 0;
        width: 100%;
        margin: 0 auto;
        text-align: center;
        border: 1px solid #D6D3CE;
        font-family: "微软雅黑";
        height:1200px
    }
        ul p span a input td {
            font-family: "微软雅黑";
        }

        .goods-manage td, .goods-manage th {
            text-align: center;
        }
        .goods-manage td p {
            text-align: center;
            margin: 10px 0px;
        }
        .goods-manage td .last a{
            padding: 3px 12px;
            width: 95px;
            border-radius: 0px;
            background-color:#FFC52F;
            border-color:#FFC52F;
            margin-bottom: 5px;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/top_menu.css">
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
</head>
<body >
    <div class="content-2 baojia-list">
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">报价</span><span class="title_orange">信息</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
        </p>
        <p class="list_two">
            <table class="table_border" cellpadding="0" cellspacing="0">
			<tr>
                <td class="cols_1 center-tit" colspan=4><span class="orange_bold">${quoteinfo.driver.name!=null?quoteinfo.driver.name:quoteinfo.driver.loginName }</span></td>
            </tr>
           
            <tr>
                <td class="cols_1">手机号：</td>
                <td class="cols_2" colspan=3>${quoteinfo.driver.phone}
                </td>
            </tr>

            <tr>
                <td class="cols_1">报价吨位：</td>
                <td class="cols_2" colspan=3>${quoteinfo.oddloadweight}吨
                </td>
            </tr>
            <c:if test="${quoteinfo.isreload==1 }">
			 <tr>
                <td class="cols_1">实际配载：</td>
                <td class="cols_2" colspan=3>${quoteinfo.actload}吨
                </td>
            </tr>
            </c:if>
             <tr>
                <td class="cols_1">本次报价：</td>
                <td class="cols_2" colspan=3>${quoteinfo.ooferprice}元/吨</td>
            </tr>
            <tr>
                <td class="cols_1">状态：</td>
                <td class="cols_2" colspan=3><span class="list_one_2 bg_light_green">${fns:getDictLabel(quoteinfo.quotestatus, 'quotestatus', '')}</span></td>

            </tr>
            <tr>
                <td class="cols_1">报价时间：</td>
                <td class="cols_2"><fmt:formatDate value="${quoteinfo.beginCreateDate}" pattern="yyyy-MM-dd"/></td>
            </tr>
            </table>
        </p>
    </div>
        <div class="content-2 baojia-list">
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">车辆</span><span class="title_orange">信息</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
        </p>
        <p class="list_two">
            <table class="table_border" cellpadding="0" cellspacing="0">

            <tr>
                <td class="cols_1">车牌号码：</td>
                <td class="cols_2" colspan=3>${quoteinfo.car.carnumber}
                </td>
            </tr>

            <tr>
                <td class="cols_1">车型：</td>
                <td class="cols_2" colspan=3>${quoteinfo.car.cartype}
                </td>
            </tr>

            <tr>
                <td class="cols_1">车长：</td>
                <td class="cols_2" colspan=3>${quoteinfo.car.carlength}米
                </td>
            </tr>

             <tr>
                <td class="cols_1">载重：</td>
                <td class="cols_2" colspan=3>${quoteinfo.car.loadweight}${quoteinfo.car.weightunit!=null?quoteinfo.car.weightunit:"吨"}</td>
            </tr>
            </table>
        </p>
    </div>
    <div class="content-2 baojia-list">
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">货物</span><span class="title_orange">信息</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
        </p>
        <p class="list_two">
        <input id="gsid" name="id"  value="${goods.id}" type="hidden"/>
            <table class="table_border" cellpadding="0" cellspacing="0">
            <tr>
                <td class="cols_1 center-tit" colspan=4><span class="orange_bold">${goods.goodsname}</span></td>
            </tr>

            <tr>
                <td class="cols_1">始发地：</td>
                <td class="cols_2" colspan=3>${goods.shipAddress.city}${goods.shipAddress.district}
                </td>
            </tr>

            <tr>
                <td class="cols_1">详细地址：</td>
                <td class="cols_2" colspan=3>${goods.shipAddress.address }
                </td>
            </tr>

            <tr>
                <td class="cols_1">目的地：</td>
                <td class="cols_2" colspan=3>${goods.consignAddress.city }${goods.consignAddress.district }
                </td>
            </tr>

             <tr>
                <td class="cols_1">详细地址：</td>
                <td class="cols_2" colspan=3>${goods.consignAddress.address }</td>
            </tr>
            <tr>
                <td class="cols_1">货物重量：</td>
                <td class="cols_2" colspan=3>${goods.freightvolume }吨</td>

            </tr>
            <tr>
                <td class="cols_1">车型要求：</td>
                <td class="cols_2">${goods.cartype }</td>
                <td class="cols_3">车长要求：</td>
                <td class="cols_4">${goods.carlength }米</td>
            </tr>
            <tr>
                <td class="cols_1">用户名：</td>
                <td class="cols_2" colspan=3><span class="per_car">${goods.user.name }</span>
                <c:if test="${goods.user.userinfo.status == '2' }">
                <span class="list_one_2 bg_light_green">已认证</span></c:if>
                <c:if test="${goods.user.userinfo.status != '2' }">
                <span class="list_one_2 bg_light_green">未认证</span></c:if></td>
            </tr>

            <tr>
                <td class="cols_1">信誉等级：</td>
                <td class="cols_2"><img src="${ctxStatic}/images/wlptfront/pointlevel/point_level_${goods.user.userinfo.pointlevle!=null?goods.user.userinfo.pointlevle:0}.gif"></td>
                <td class="cols_3">担保金额:</td>
                <td class="cols_4"><span class="orange_bold">${not empty goods.user.userPurse.guaranteemone?goods.user.userPurse.guaranteemone:""}</span>${not empty goods.user.userPurse.guaranteemone?"元":""}</td>
            </tr>
            <tr>
                <td class="cols_1">发货时间：</td>
                <td class="cols_2" colspan=3>${sendtime}</td>

            </tr>
            <tr>
                <td class="cols_1">补充说明：</td>
                <td class="cols_2" colspan=3>${goods.remarks }</td>

            </tr>
            </table>
        </p>
    </div>

   <script src="${ctxStatic }/jquery/jquery-1.9.1.js"></script>
   <script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js"></script>
   <script src="http://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
   <script src="http://cdn.bootcss.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>


</body>
</html>
