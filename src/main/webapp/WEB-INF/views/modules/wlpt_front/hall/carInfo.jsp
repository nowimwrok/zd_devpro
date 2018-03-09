<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_default_basic"/>
    <link rel="stylesheet" media="screen" type="text/css" href="${ctxStatic }/zoomimage/css/zoomimage.css" />
    <script src='${ctxStatic }/zoomimage/js/jquery.js' type="text/javascript"></script>
    <script src='${ctxStatic }/zoomimage/js/eye.js' type="text/javascript"></script>
    <script src='${ctxStatic }/zoomimage/js/utils.js' type="text/javascript"></script>
    <script src='${ctxStatic }/zoomimage/js/zoomimage.js' type="text/javascript"></script>
   <title>车辆信息</title>
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
        .panel-body table {
            width: 100%;
        }
    </style>
<link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">
</head>

<body>
    <div class="content-2 baojia-list" style="width: 68%;border-bottom: 0 solid #ccc;">
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">车辆</span><span class="title_orange">信息</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
        </p>
        <p class="list_two">
        <table class="table_border" cellpadding="0" cellspacing="0">
            <tr>
                <td class="cols_1 center-tit" colspan=4><span class="orange_bold">${car.carnumber}</span></td>
            </tr>

            <tr>
                <td class="cols_1">车辆性质：</td>
                <td class="cols_2">${car.issocialcar}</td>
                <td class="cols_3">车辆类型：</td>
                <td class="cols_4">${car.cartype}</td>
            </tr>

            <tr>
                <td class="cols_1">车长：</td>
                <td class="cols_2">${car.carlength}${car.lengthunit}</td>
                <td class="cols_3">载重：</td>
                <td class="cols_4">${car.loadweight}${car.weightunit}</td>
            </tr>
            <tr>
                <td class="cols_1">主营路线：</td>
                <td class="cols_2" colspan=3>${car.mainroad }</td>
            </tr>
            <tr>
                <td class="cols_1">车主姓名：</td>
                <td class="cols_2">${not empty car.user.loginName?car.user.loginName:"保密"}&nbsp;<img src="${ctxStatic}/images/wlptfront/pointlevel/point_level_${car.user.userinfo.pointlevle!=null?car.user.userinfo.pointlevle:0}.gif"></td>
                <td class="cols_3">车主电话：</td>
                <td class="cols_4">${not empty car.user.phone?car.user.phone:"保密"}</td>
            </tr>
            <c:if test="${not empty car.carsourceid}">
            	<tr>
	                <td class="cols_1">车源状态：</td>
	                <td class="cols_2">${car.carsourcestatus }</td>
	                <td class="cols_3">发车时间：</td>
	                <td class="cols_4"><fmt:formatDate value="${car.departuretime}" pattern="yyyy-MM-dd"/></td>
	            </tr>
	            <tr>
	                <td class="cols_1">联系人：</td>
	                <td class="cols_2">${car.contactname }</td>
	                <td class="cols_3">联系人号码：</td>
	                <td class="cols_4">${car.contactmobile }</td>
	            </tr>
            </c:if>
            
            
     </table>
     </p>
  </div>
  <div class="content-2 baojia-list" style="width: 68%;border-bottom: 0 solid #ccc;">
    <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">车辆</span><span class="title_orange">外观</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
    </p>
    <!-- 车辆外观-->
    <div class="transction clerify" ng-controller="honorCtrl">
            <div class="panel-body">
                <div class="row" style="padding: 10px;">
                        <c:choose>
                        <c:when test="${not empty list}">
                        <c:forEach items="${list}" var="pic">
                        <div class="thumbnail" style="width:30%;float:left;margin-left:2.5%;">
                        	<a id='carimg' href='${pic }'>
                            <img  src="${pic}" style="width: 100%;height: 180px;">
                            </a>
                            <div class="caption text-center">
                                <span>车辆外观</a></span>
                            </div>
                        </div>
                        </c:forEach>
                        </c:when>
                        <c:otherwise>
                                                                                     车主尚未上传车辆照片
                        </c:otherwise>
                        </c:choose>
                </div>
           </div> 
  </div>
  <div>
  <input id="btnCancel" class="btn btn-warning" type="button" value="返 回" onclick="back();"/>
  </div>
  <script type="text/javascript">
  function back(){
	  window.location.href="${wlpt}/wlpt/hall/car"
  }
 
 $(function(){
	  $("#carimg").zoomimage({
		  centered:true
	  });
  });
  </script>
</body>
</html>
