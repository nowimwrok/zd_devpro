<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_default_basic"/>
    <title>货源详情</title>
    <style type="text/css">
    body{
        padding: 0;
        margin: 0;
        width: 100%;
        margin: 0 auto;
        text-align: center;
        border: 1px solid #D6D3CE;
        font-family: "微软雅黑"
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
        .td-left{
            width: 22%;
            height:30px;
            text-align: right;
        }
        .input{
            height:30px;
        }
    </style>
<link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
<link href="${ctxStatic}/bootstrap/2.3.1/css_3.2cerulean/bootstrap.min.css" type="text/css" rel="stylesheet"/>
<link href="${ctxStatic }/bootstrap/2.3.1/awesome/font-awesome.min.css" type="text/css" rel="stylesheet">
 <script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
</head>
<body>
    <div class="content-2 baojia-list" style="width: 68%;border-bottom: 0 solid #ccc;">
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">货物</span><span class="title_orange">详情</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
        </p>
        <p class="list_two">
        <table class="table_border" cellpadding="0" cellspacing="0">
        <input id="gsid"  value="${goods.id}" type="hidden"/>
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
                <td class="cols_2">${goods.freightvolume }吨</td>
                <td class="cols_3">货物类型：</td>
                <td class="cols_4">${goods.goodstype}</td>
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
                <td class="cols_1">货主出价：</td>
                <td class="cols_2">${goods.expectedprice }元/吨</td>
                <td class="cols_3">货物类别：</td>
                <td class="cols_4">${goods.gsoddtype}</td>
            </tr>
            <tr>
                <td class="cols_1">运输方式：</td>
                <td class="cols_2">${goods.transportway }</td>
                <td class="cols_3">货物价值：</td>
                <td class="cols_4">${goods.worth }元</td>
            </tr>
            <tr>
                <td class="cols_1">车型要求：</td>
                <td class="cols_2">${goods.cartype }</td>
                <td class="cols_3">车长要求：</td>
                <td class="cols_4">${goods.carlength }米</td>
            </tr>
            <tr>
                <td class="cols_1">用户名：</td>
                <td class="cols_2" colspan=3>${goods.user.name }
                <c:if test="${goods.user.userinfo.status == '2' }">
                <span class="list_one_2 bg_light_green">已认证</span></c:if>
                <c:if test="${goods.user.userinfo.status != '2' }">
                <span class="list_one_2 bg_light_green">未认证</span></c:if>
                </td>
            </tr>
            <tr>
                <td class="cols_1">信用等级：</td>
                <td class="cols_2"><img src="${ctxStatic}/images/wlptfront/pointlevel/point_level_${goods.user.userinfo.pointlevle!=null?goods.user.userinfo.pointlevle:0}.gif"></td>
                <td class="cols_3">担保金额：</td>
                <td class="cols_4"><span class="orange_bold">${goods.user.userPurse.guaranteemone}</span>元</td>
            </tr>

            <tr>
                <td class="cols_1">联系人姓名：</td>
                <td class="cols_2">${goods.shipAddress.linkman }</td>
                <td class="cols_3">联系电话：</td>
                <td class="cols_4">${goods.shipAddress.linkmobile }</td>
            </tr>

            <tr>
                <td class="cols_1">发货时间：</td>
                <td class="cols_2">${sendtime}</td>
                <td class="cols_3">有效天数：</td>
                <td class="cols_4">${goods.effectdays }</td>
            </tr>

            <tr>
                <td class="cols_1">补充说明：</td>
                <td class="cols_2" colspan=3>${goods.remarks }</td>
            </tr>

            <tr class="tr-last">
                <td class="cols_1" style="border-right:none;"></td>
                <td class="cols_2" colspan=3 style="border-left:none;padding-top: 20px;">
                    <div class="cols_last">
                        <a href="javascript:;" onclick="updatePraiseNumber();"><img src="${ctxStatic }/images/wlptfront/zan.png">
                        <p>赞一下</p></a>
                    </div>
                    <div class="cols_last">
                        <div class="right_orange cols_orange"><span id="num">${goods.praisenumber }</span></div>
                        <p>点击量</p>
                    </div>
                </td>
            </tr>
            <tr style="line-height: 70px;">
            <td colspan=4>
            <input id="btnCancel" class="btn btn-warning" type="button" value="返 回" onclick="history.go(-1)"/>
            </td>
            </tr>
     </table>
     </p>
  </div>
  <script>
  function updatePraiseNumber(){
	  var gdsid=$("#gsid").val();
	  var num=${goods.praisenumber};
	  var newnum=$("#num").html();
	  if((num*1)<(newnum*1)){
		  return;
	  }
	  $.ajax({
			type : "POST",
			url : '${wlpt}/wlpt/goods/updatePraiseNumber',
			dataType : 'json',
			data : {
				'id' : gdsid
			},
			cache : false,
			success : function(data) {
				
				$("#num").html(num+1); 
			}
		});
  }
  </script>
</body>
</html>
