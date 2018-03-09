<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head lang="en">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>提交订单</title>
    
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link href="${ctxStatic }/modules/wlpt/front/css/shop_new.css" rel="stylesheet" type="text/css">
    <style>
        /*主菜单样式*/
            .dropdown-menu {
                display: none;
                overflow: hidden;
                position: absolute;
                top: 100%;
                left: -30%;
                z-index: 1000;
                display: none;
                float: left;
                min-width: 160%;
                padding: 5px 0;
                margin: 2px 0 0;
                font-size: 14px;
                text-align: left;
                list-style: none;
                background-color: #fff;
                -webkit-background-clip: padding-box;
                background-clip: padding-box;
                border: 1px solid #ccc;
                border: 1px solid rgba(0,0,0,.15);
                border-radius: 4px;
                -webkit-box-shadow: 0 6px 12px rgba(0,0,0,.175);
                box-shadow: 0 6px 12px rgba(0,0,0,.175);
            }
            .dropdown-menu li {
                display: block;
                float: none;
                width: 100%;
                overflow: hidden;
                position: relative;
                padding: 0;
                display: block;
                background: #fff;
            }
            .dropdown-menu>li>a{
                padding: 10px 20px;
                color:#2676ac;
                text-shadow: 0px 0px 13px #fff;

            }
            .dropdown-menu>li>a:hover,.dropdown-menu>li>a:focus{
                background-color: rgba(39, 189, 184, 0.77);
                color: #fff;
            }
            /*调用定义动画，使得二级目录背景淡入淡出*/
            .fadeIn_a{
                -webkit-animation-name:fadeIn;
                -webkit-animation-duration:1000ms;
                -webkit-animation-iteration-count: 1;
                -webkit-animation-delay: 0s;
                background-color: rgba(39, 189, 184, 0.77);
                color:#2676ac;
            }
            /*定义淡入淡出动画*/
            @-webkit-keyframes fadeIn {
                0% {
                    color: #27bdb8;
                    opacity: 0; /*初始状态 透明度为0*/
                }
                100% {
                    opacity: 1; /*最终状态 透明度为1*/
                    color: #fff;
                }
            }
        /*End--主菜单样式*/
    </style>
</head>
<body>
    <!--提交订单--------------主要内容-->
    <div class="shop_content">
        <h4>提交订单</h4>
        <form:form method="post" name="Form" id="Form" modelAttribute="shopVO" action="${wlpt}/wlpt/shop/toPay">
        <table class="tab_bg">
            <tr style="line-height:50px;height: 50px;background: #fff;border-bottom: 1px solid #ccc;">
                <td class="td_1" style="width: 30%;">商品</td>
                <td class="td_2" style="width: 17.5%;">单价（${shopVO.shotName=='you_qi'?'元':'元'}）</td>
                <td class="td_3" style="width: 17.5%;">数量</td>
                <td class="td_4" style="width: 17.5%;">小计（${shopVO.shotName=='you_qi'?'元':'元'}）</td>
            </tr>
            <form:hidden path="name"/>
            <form:hidden path="shotName"/>
            <form:hidden path="price"/>
            <input id="money" name="total" type="hidden"/>
            <tr>
                <td><img src="${ctxStatic }/images/wlptfront/shop_img/${shopVO.shotName}.png" class="shoptype_img"><b class="tr_b">${shopVO.name}</b></td>
                <td>${shopVO.price}</td>
                <td><input id="num" name="num" type="number" value="1" min="1" style="height: 22px;width: 100px;text-align: center;border: none;line-height: 22px;"/></td>
                <td><span id="total"></span></td>

            </tr>
            <tr style="background: #fff;">
                <td colspan="4" class="btn_td" style="text-align: right;line-height: 50px;height: 50px;padding-right: 20px;">
                <input id="btnSubmit" type="button" class="btn_blue" value="立即支付"/>
                </td>
            </tr>
        </table><!--End---提交订单列表--table-->
        
        <c:if test="${not empty wxgift }">
        	<div class="pur_notice">
        	<h5>好消息:</h5>
        		<p>
                	活动名称：${wxgift.giftname }
            	</p>
            	<p>
                	活动内容：${wxgift.giftcontent }
            	</p>
            	<input type="hidden" id="giftid" name ="giftid" value="${wxgift.id }"/>
        	</div>
        </c:if>
        </form:form>
        <c:if test="${shopVO.shotName=='you_qi'}">
        <div class="pur_notice">
        <h5>油气购买须知:</h5>
            <p>
                1、本产品内含100元的油气费用；
            </p>
            <p>
                2、本产品购买后可在油气账户查看，通过一卡通在加油站进行油气消费。
            </p>
        </div>
        </c:if>
        <c:if test="${shopVO.shotName=='zd_coin'}">
        <div class="pur_notice">
        <h5>卓币购买须知:</h5>
            <p>
                1、本产品仅在卓大物流平台进行使用、消费；
            </p>
            <p>
                2、本产品购买后可在账户中心查看购买记录。
            </p>
        </div>
        </c:if>
    </div>
    <script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
    <script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
    <script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
    <script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
    <script type="text/javascript">
    var price=$("#price").val()*1;
    var num=$("#num").val()*1;
    var total=price*num;
    $("#total").html(total);
    $("#num").change(function(){
    	var num=$("#num").val()*1;
    	if(num<1){
    		$("#num").val(1);
    		return false;
    	}
    	var total=price*num;
        $("#total").html(total);
    });
    $("#btnSubmit").click(function () {
    	 var isnul = true;
         isnul = isnul && $("#num").valid({
                     methods: "required|isNum"
                 });
        if(!isnul){
        	return false;
        }
    	var num=$("#num").val()*1;
        var total=price*num;
        if(num*1>0&&total*1>0){
        	$("#money").val(total);
        	$("#Form").submit();
        }else{
        	$.MsgBox.Alert("支付提示", "请至少购买1数量的商品");
        	return false;
        }
    	
    });
    </script>
</body>
</html>