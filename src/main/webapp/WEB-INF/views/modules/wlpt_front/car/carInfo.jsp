<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>添加车辆</title>
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
            width: 39%;
            text-align: right;
        }

        .cy_center_td {
            width: 45%;
        }

        .cy_right_td {
            width: 40%;
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
            <img src="${ctxStatic }/images/wlptfront/line-left.png"/><span class="title_blue">车辆</span>
            <span class="title_orange">信息</span><img src="${ctxStatic }/images/wlptfront/line-right.png"/>
        </p>
        <form:form action="#" name="Form" id="Form" modelAttribute="car" method="post">
        <table width="100%" border="0" style="margin-top:10px;">
            <tr>
                <td class="cy_left_td xiao_td">车牌号码：</td>
                <td class="cy_center_td xiao_td">
                ${car.carnumber}
                </td>
            </tr>
            <tr>
                <td class="cy_left_td xiao_td">车辆性质：</td>
                <td class="cy_center_td xiao_td">
                ${car.issocialcar}
                </td>
            </tr>
            <tr>
                <td class="cy_left_td xiao_td">车辆类型：</td>
                <td class="cy_center_td xiao_td">
                ${car.cartype}
                </td>
            </tr>
            <tr>
                <td class="cy_left_td xiao_td">车辆长度：</td>
                <td class="cy_center_td xiao_td">
                ${car.carlength}米
                </td>
            </tr>
            <tr>
                <td class="cy_left_td xiao_td">车辆载重：</td>
                <td class="cy_center_td xiao_td">
                ${car.loadweight}吨
                </td>
            </tr>
            <tr>
                <td class="cy_left_td xiao_td">主营路线：</td>
                <td class="cy_center_td xiao_td">
                ${car.mainroad}
                </td>
            </tr>
            <c:if test="${not empty car.locationmobile}">
            <tr>
                <td class="cy_left_td xiao_td">定位手机号：</td>
                <td class="cy_center_td xiao_td">${car.locationmobile }</td>
            </tr>
            </c:if>
            <c:if test="${not empty car.oftenparkedposition}">
            <tr>
                <td class="cy_left_td xiao_td">常停放位置：</td>
                <td class="cy_center_td xiao_td">${car.oftenparkedposition }</td>
            </tr>
            </c:if>
            <c:if test="${not empty car.ownername}">
            <tr>
                <td class="cy_left_td xiao_td">车主姓名：</td>
                <td class="cy_center_td xiao_td">${car.ownername }</td>
            </tr>
            </c:if>
            <c:if test="${not empty car.ownermobile}">
            <tr>
                <td class="cy_left_td xiao_td">车主手机号：</td>
                <td class="cy_center_td xiao_td">${car.ownermobile }</td>
            </tr>
            </c:if>
            <c:if test="${not empty car.travellicimg}">
            <tr>
                <td class="cy_left_td xiao_td">行驶证照片：</td>
                <td><form:hidden id="travellicimg" path="travellicimg" htmlEscape="false" maxlength="256"/>
                    <sys:ckfinder input="travellicimg" type="images" uploadPath="/car" readonly="true" selectMultiple="false"
                                  maxWidth="100" maxHeight="100"/></td>
            </tr>
            </c:if>
            <c:if test="${not empty car.carsurfaceimg}">
            <tr>
                <td class="cy_left_td xiao_td">车辆外观照片：</td>
                <td><form:hidden id="carsurfaceimg" path="carsurfaceimg" htmlEscape="false" maxlength="256"/>
                    <sys:ckfinder input="carsurfaceimg" type="images" uploadPath="/car" readonly="true" selectMultiple="true"
                                  maxWidth="100" maxHeight="100"/></td>
            </tr>
            </c:if>
        </table>
        <div class="loading">
            <img src="/static/images/loading.gif">
            <p>加载中</p>
        </div>
        <div class="form-actions" style="padding: 30px;">
            <c:if test="${car.status=='0'||car.status=='3'}"><input id="renzheng" class="regbt" type="button" value="申请认证"/>&nbsp;</c:if>
            <input id="btnSubmit" class="regbt" type="button" value="返回" onclick="history.go(-1)"/>
        </div>
        </form:form>
</div>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script type="text/javascript">
$(".loading").hide();
$("#renzheng").click(function() {
	var id="${car.id}";
	$(".loading").show();
	$.ajax({
		url : "${wlpt}/wlpt/authentication/car_authentication?id="+id,
		dataType : 'json',
		type:"post",
		success : function(data) {
			if (data.message=="申请认证成功") {
				window.location.href = '${wlpt}/wlpt/car/car_list'; 
			}else{
				$(".loading").hide();
				$.MsgBox.Alert("认证提示",data.message);
			}
		}
	});
	
});
</script>
</body>
</html>
