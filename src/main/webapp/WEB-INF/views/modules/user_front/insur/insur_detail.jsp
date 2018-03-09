<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>保单详情</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <style type="text/css">
        body {
            padding: 0;
            margin: 0;
            margin: 0 auto;
            height: 700px;
            text-align: center;
            border: 1px solid #D6D3CE;
            font-family: "微软雅黑"
            font-size: 14px;
        }

        * {
            font-family: "微软雅黑";
            margin: 0;
            font-size: 14px;
        }

        .godsName {
            width: 179px;
            height: 200px;
            -webkit-border-radius: 4px;
            border: solid 1px #CCC;
            display: none;
            z-index: 2;
            background: rgba(255, 255, 255, 0.8) none repeat scroll 0 0 !important;
            position: absolute;
            min-height: 200px;
            overflow-y: auto;
            max-height: 200px;
            margin-top: 30px;
        }

        .inputtext {
            width: 100px;
        }

        /* 车牌号码 */
        .cgs-key-text {
            font-size: 14px;
            font-weight: bold;
            color: #3499D4;
        }

        /* 车辆的车主信息 */
        .carforcompany {
            font-size: 14px;
            font-weight: bold;
            color: #3499D4;
        }

        .regbt {
            width: 100px;
            height: 35px;
            border: solid 1px;
            border-radius: 0px;
            background-color: #FFC52F;
            border-color: #FFC52F;
            cursor: pointer;
            font-weight: bold;
            text-align: center;
            color: white;
            margin-top: 6px;
            font-size: 16px;
        }
		.tab-all {
            width: 100%;
            padding-top: 20px;
            border: none;
        }
        .godsName ul {
            width: 100%;
        }

        .godsName ul li {
            height: 20px;
            line-height: 20px;
            cursor: pointer;
            over-flowt: scoller;
            width: 100%;
        }

        .godsName ul li:HOVER {
            background-color: #DDDDDD;
        }

        .page-title {
            border-left: solid 4px #FF0000;
            width: 200px;
            height: 1.5em;
            font-size: 14px;
            font-weight: bold;
            line-height: 24px;
            padding-left: 10px;
            color: #555;
            margin: 20px;
            text-align: left;
        }

        input[type='button'] {
            display: inline-block;
            font-size: 14px;
        }

        .xiao_td {
            height: 37px;
            line-height: 37px;
            color: #333;
            font-size: 14px;
            font-family: "微软雅黑";
        }

        .cy_left_td {
            width: 30%;
            text-align: right;
        }

        .cy_center_td {
            width: 30%;
        }
        
        .cy_right_td {
            width: 15%;
            text-align: right;
        }

        .xinghao {
            color: #F00;
        }
        ol li{
      		float:left;
      	}
        .loading{
            display: none;
            width: 100%;
            height: 94%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 0px;
            text-align: center;
        }
        .loading img{
            margin-top: 25%;
        }
    </style>
    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
    <link href="${ctxStatic}/bootstrap/2.3.1/css_3.2cerulean/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="${ctxStatic }/common/jeesite.css" type="text/css" rel="stylesheet">
    <script src="${ctxStatic }/common/jeesite.js" type="text/javascript"></script>
    <script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js" type="text/javascript"></script>
    <script src="${ctxStatic }/common/mustache.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctxStatic }/common/global.js"></script>
    <script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
    <script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>

</head>
<body style="height: 1000px;">
<div class="tab_fir tab-all" style="height: 940px;">
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"/><span class="title_blue">投保</span>
            <span class="title_orange">信息</span><img src="${ctxStatic }/images/wlptfront/line-right.png"/>
        </p>
        <table width="80%" border="0" style="margin: 0px auto;margin-top:10px;">
        	<c:if test="${not empty insurance.insuranceNO }">
	        	<tr>
	                <td class="cy_left_td xiao_td">保单号：</td>
	                <td class="cy_center_td xiao_td">
	                ${insurance.insuranceNO}
	                </td>
	                <td class="cy_right_td xiao_td"></td>
                <td class="cy_center_td xiao_td"></td>
	            </tr>
            </c:if>
            
            
            <c:if test="${not empty insurance.orderno }">
	        	<tr>
	                <td class="cy_left_td xiao_td">关联运单号：</td>
	                <td class="cy_center_td xiao_td">
	                ${insurance.orderno}
	                </td>
	                <td class="cy_right_td xiao_td"></td>
                <td class="cy_center_td xiao_td"></td>
	            </tr>
            </c:if>
            <tr>
                <td class="cy_left_td xiao_td">投保人：</td>
                <td class="cy_center_td xiao_td">
                ${insurance.applicant}    
                </td>
                <td class="cy_right_td xiao_td">联系电话：</td>
                <td class="cy_center_td xiao_td">${insurance.applicantAddress.linkmobile}</td>
            </tr>
            <!-- 商业险 -->
            <c:if test="${insurance.insurlist.insuranceway eq 1 }">
            	<tr>
	                <td class="cy_left_td xiao_td">证件号：</td>
	                <td class="cy_center_td xiao_td">
	                	${insurance.cardNo}
	                </td>
	                
	            </tr>
            </c:if>
            
            
            <!-- 货物险 -->
            <c:if test="${insurance.insurlist.insuranceway eq 0 }">
            <tr>
                <td class="cy_left_td xiao_td">被保货物：</td>
                <td class="cy_center_td xiao_td">
                ${insurance.goodsname}
                </td>
                <td class="cy_right_td xiao_td">货物价值：</td>
                <td class="cy_center_td xiao_td">
                ${insurance.worth} 元
                </td>
            </tr>
            <tr>
                <td class="cy_left_td xiao_td">货物类型：</td>
                <td class="cy_center_td xiao_td">
                ${insurance.goodstype}
                </td>
                <td class="cy_right_td xiao_td"></td>
                <td class="cy_center_td xiao_td">
                </td>
            </tr>
            </c:if>
            
            <tr>
                <td class="cy_left_td xiao_td">联系地址：</td>
                <td class="cy_center_td xiao_td">
                ${insurance.applicantAddress.province}${insurance.applicantAddress.city}${insurance.applicantAddress.district}
                </td>
                <td class="cy_right_td xiao_td">详细地址：</td>
                <td class="cy_center_td xiao_td">
                ${insurance.applicantAddress.address}
                </td>
            </tr>
            
           
         
            <c:if test="${not empty insurance.voucherimg}">
            <tr>
                <td class="cy_left_td xiao_td">保单照片：</td>
                <td>
                <input type="hidden" id="voucherimg" name="voucherimg" value="${insurance.voucherimg }" />
                <sys:ckfinder input="voucherimg" type="images"
								uploadPath="/insurance" selectMultiple="true" maxWidth="100"
								maxHeight="100"  readonly="true"/></td>
            </tr>
            </c:if>
        </table>
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"/><span class="title_blue">车辆</span>
            <span class="title_orange">信息</span><img src="${ctxStatic }/images/wlptfront/line-right.png"/>
        </p>
         <table width="80%" border="0" style="margin: 0px auto;margin-top:10px;">
            <tr>
                <td class="cy_left_td xiao_td">车牌号码：</td>
                <td class="cy_center_td xiao_td">
                ${insurance.carnumber}
                </td>
                <td class="cy_right_td xiao_td"></td>
                <td class="cy_center_td xiao_td">
                </td>
            </tr>
            <tr>
                <td class="cy_left_td xiao_td">厂牌型号：</td>
                <td class="cy_center_td xiao_td">
                ${insurance.carmodel}
                </td>
                <td class="cy_right_td xiao_td">机动车类型：</td>
                <td class="cy_center_td xiao_td">
                ${insurance.cartype}
                </td>
            </tr>
            <tr>
                <td class="cy_left_td xiao_td">总质量：</td>
                <td class="cy_center_td xiao_td">
                ${insurance.totalweight}吨
                </td>
                <td class="cy_right_td xiao_td">核定载质量：</td>
                <td class="cy_center_td xiao_td">
                ${insurance.carweight}吨
                </td>
            </tr>
            <!-- 商业险 -->
            <c:if test="${insurance.insurlist.insuranceway eq 1 }">
            	<tr>
	                <td class="cy_left_td xiao_td">核定载客：</td>
	                <td class="cy_center_td xiao_td">
	                ${insurance.passengersnum}人
	                </td>
	                <td class="cy_right_td xiao_td">使用性质：</td>
	                <td class="cy_center_td xiao_td">
	                ${insurance.usecharacter}
	                </td>
	            </tr>
	            <tr>
	                <td class="cy_left_td xiao_td">识别代码：</td>
	                <td class="cy_center_td xiao_td">
	                ${insurance.vin}
	                </td>
	                <td class="cy_right_td xiao_td">发动机号码：</td>
	                <td class="cy_center_td xiao_td">
	                ${insurance.engineNo}
	                </td>
	            </tr>
	            <tr>
	                <td class="cy_left_td xiao_td">登记日期：</td>
	                <td class="cy_center_td xiao_td">
	                <fmt:formatDate value="${insurance.sendtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
	                </td>
	                
	            </tr>
            </c:if>
            
        </table>
        <!-- 货物险 -->
        <c:if test="${insurance.insurlist.insuranceway eq 0 }">
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"/><span class="title_blue">运输</span>
            <span class="title_orange">信息</span><img src="${ctxStatic }/images/wlptfront/line-right.png"/>
        </p>
         <table width="80%" border="0" style="margin: 0px auto;margin-top:10px;">
            <tr>
                <td class="cy_left_td xiao_td">始发地：</td>
                <td class="cy_center_td xiao_td">
                ${insurance.shipAddress.province}${insurance.shipAddress.city}${insurance.shipAddress.district}
                </td>
                <td class="cy_right_td xiao_td">详细地址：</td>
                <td class="cy_center_td xiao_td">
                ${insurance.shipAddress.address}
                </td>
            </tr>
            <tr>
                <td class="cy_left_td xiao_td">目的地：</td>
                <td class="cy_center_td xiao_td">
                ${insurance.consignAddress.province}${insurance.consignAddress.city}${insurance.consignAddress.district}
                </td>
                <td class="cy_right_td xiao_td">详细地址：</td>
                <td class="cy_center_td xiao_td">
                ${insurance.consignAddress.address}
                </td>
            </tr>
           
        
        </table>
        </c:if>
        
         <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"/><span class="title_blue">承保</span>
            <span class="title_orange">信息</span><img src="${ctxStatic }/images/wlptfront/line-right.png"/>
        </p>
         <table width="80%" border="0" style="margin: 0px auto;margin-top:10px;">
         	<!-- 货物险 -->
            <c:if test="${insurance.insurlist.insuranceway eq 0 }">
            <tr>
                <td class="cy_left_td xiao_td">承保险种：</td>
                <td class="cy_center_td xiao_td">
                ${insurance.insurancetype}
                </td>
            </tr>
            <tr>
                <td class="cy_left_td xiao_td">理赔保险金额：</td>
                <td class="cy_center_td xiao_td">
                	最高${insurance.insuranceamount}元
                </td>
                <td class="cy_right_td xiao_td">保险费合计(元)：</td>
                <td class="cy_center_td xiao_td">
                ${insurance.insurancefeel}元
                </td>
            </tr>
            </c:if>
            <!-- 商业险 -->
            <c:if test="${insurance.insurlist.insuranceway eq 1 }">
            <tr>
                <td class="cy_left_td xiao_td">承保险种：</td>
                <td class="cy_center_td xiao_td">
                ${insurance.insurancetype}
                </td>
                <td class="cy_right_td xiao_td">保险费合计(元)：</td>
                <td class="cy_center_td xiao_td">
                ${insurance.insurancefeel}元
                </td>
            </tr>
            <c:if test="${not empty insurance.subtype }">
	            <tr>
	                <td class="cy_left_td xiao_td">本次购选保险：</td>
	                <td class="cy_center_td xiao_td" colspan="3">
	                	<c:forEach items="${fn:split(insurance.subtype,'|')}" var="val" varStatus="i" >
							<span style="margin-left: 10px;">${val}</span>
						</c:forEach>
	                </td>
	                
	            </tr>
            </c:if>
            </c:if>
        </table>
        <div class="tab-thre tab-all"><input id="btnSubmit" class="btn btn-warning" type="button" value="返  回" onclick="history.go(-1)"/></div>
        
</div>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>

</body>
</html>
