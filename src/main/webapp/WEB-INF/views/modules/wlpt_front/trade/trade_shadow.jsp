<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
<%--
    <meta name="decorator" content="site_personal_basic"/>
--%>

    <title>运单跟踪</title>



    <link rel="stylesheet" type="text/css" href="/static/modules/wlpt/front/css/base.css">

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

        .tab_left .tab_nav {
            width: 100%;
            margin-top: -2px;
            padding: 0px;
        }

        .tab_nav li {
            float: left;
            width: 20%;
            text-align: center;

        }

        .cb_val div {
            float: left;
            word-wrap: break-word;
        }

        .ct_lf div {
            float: left;
            margin-right: 5px;
            line-height: 30px;
            display: table-cell;
            vertical-align: middle;
            display: table-cell;
            font-size: 16px;
            text-align: left;
        }

        .img_text {
            font-size: 1em;
            width: 60px;
            text-align: center;
            background-image: url(./static/images/weixin/pic_bg_normal.png);
            height: 60px;
            background-repeat: no-repeat;
            line-height: 35px;
            background-size: 60px;
            margin: 5%;
            float: left;
            cursor: pointer;
            position: relative;
            clear: both;
        }

        .img_text img {
            width: 60px;
            height: 60px;
        }

        .img_t {
            color: rgba(37, 35, 35, 0.57);
            position: absolute;
            bottom: 0px;
            width: 60px;
            height: 35px;
        }

        .upimg {
            width: 60px;
            height: 60px;
        }

        .ct_lf {
            width: 100%;
            height: 30px;
            margin-top: 10px;
            display: table;
        }

        .ct_lf div {
            float: left;
            margin-right: 5px;
            line-height: 30px;
            display: table-cell;
            vertical-align: middle;
            display: table-cell;
            font-size: 16px;
        }

        .ic_img {
            height: 25px;
            display: table;
            margin: 0px;
        }

        .ic_img img {
            width: 25px;
            display: table-cell;
            vertical-align: middle;
            display: table-cell;
        }

        .cb_tle {
            width: 15%;
            text-align: right;
            float: left;
        }

        .cb_val {
            width: 80%;
            float: left;
            display: block;
            word-wrap: break-word;
        }

        .cb_val div {
            float: left;
            word-wrap: break-word;
            text-align: left;
        }

        .ratings li {
            height: 40px;
            line-height: 40px;
        }

        .lift li {
            float: left;
            margin-right: 15px;
        }

        .timeline-content {
            width: 95%;
            padding-bottom: 0px;
        }

        .timeline-content p {
            width: 100%;
            border-top: 1px solid #CCC;
            padding-top: 5px;
            text-align: left;
        }

        h2 {
            font-size: 18px;
        }

        #timeline .timeline-item .timeline-content h2 {
            padding: 10px;
        }
    </style>
</head>
<body scroll="no"  style="background:none;border:none;" >
<div class="container" style="display:block;background-color: transparent;width: 90%;" ng-app="dataHall" ng-controller="dataHallCtrl">

    <div id="timeline" style="display:block;background-color: transparent">
        <div class="timeline-item">
            <div class="timeline-icon">
                <img src="/static/images/weixin/goods_owner.png"
                        alt="货主">
            </div>
            <div class="timeline-content left">
                <h2>发布货源</h2>
                <div class="ct_lf">
                    <div class="cb_tle">
                        <div class="ic_img">
                            <img alt="货物"
                                 src="/static/images/weixin/ic_goods.png">
                        </div>
                    </div>
                    <div class="cb_val">
                        <div>${orderinfo.quoteinfo.goods.goodsname }</div>
                        <div>${orderinfo.quoteinfo.goods.freightvolume }${orderinfo.quoteinfo.goods.freightunit}</div>
                    </div>
                </div>
                <div class="ct_lf">
                    <div class="cb_tle">
                        <div class="ic_img">
                            <img alt="始发地" style="width:20px;margin-right:4px;"
                                 src="/static/images/weixin/ic_start.png">
                        </div>
                        <!--ic_img end  -->
                    </div>
                    <div class="cb_val" id="fromAddress">
                        ${orderinfo.quoteinfo.goods.shipAddress.province}
                        ${orderinfo.quoteinfo.goods.shipAddress.city}
                        ${orderinfo.quoteinfo.goods.shipAddress.district}
                    </div>
                </div>
                <!--ct_lf end  -->
                <div class="ct_lf">
                    <div class="cb_tle">
                        <div class="ic_img">
                            <img alt="目的地" style="width:20px;margin-right:4px;"
                                 src="/static/images/weixin/ic_end.png">
                        </div>
                        <!--ic_img end  -->
                    </div>
                    <div class="cb_val" id="toAddress">
                        ${orderinfo.quoteinfo.goods.consignAddress.province}
                        ${orderinfo.quoteinfo.goods.consignAddress.city}
                        ${orderinfo.quoteinfo.goods.consignAddress.district}
                    </div>
                </div>
                <p>
                    <fmt:formatDate value="${orderinfo.quoteinfo.goods.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>

                <%--<fmt:formatDate value="${orderinfo.quoteinfo.goods.createDate}" type="both" dateStyle="time"/>--%>
                </p>
            </div>
        </div>

        <div class="timeline-item">
            <div class="timeline-icon">
                <img
                        src="/static/images/weixin/car_owner.png"
                        alt="司机">
            </div>
            <div class="timeline-content right">
                <h2>车主抢单</h2>
                <div class="ct_lf">
                    <div class="cb_tle">
                        <div class="ic_img">
                            <img alt="车辆"
                                 src="/static/images/weixin/home_mycars_img.png">
                        </div>
                    </div>
                    <div class="cb_val">
                        <div>${orderinfo.quoteinfo.car.carnumber}</div>
                        <div>${orderinfo.quoteinfo.car.cartype}</div>
                        <div>${orderinfo.quoteinfo.car.carlength}米</div>
                        <div>报吨:${orderinfo.quoteinfo.oddloadweight}吨</div>
                        <c:if test="${orderinfo.quoteinfo.isreload==1 }">
                        	<div>实配:${orderinfo.quoteinfo.actload}吨</div>
                        </c:if>
                        <div>报价:${orderinfo.quoteinfo.ooferprice}元/吨</div><br>
                        <div>总运价:${orderinfo.totalcost}元</div>
                    </div>
                </div>
                <!--ct_lf end  -->
                <div class="ct_lf">
                    <div class="cb_tle">
                        <div class="ic_img">
                            <img alt="司机"
                                 src="/static/images/weixin/icon_finddriver.png">
                        </div>
                    </div>
                    <div class="cb_val">
                        <div>${orderinfo.quoteinfo.driver.loginName}</div>
                        <div>${orderinfo.quoteinfo.driver.phone}</div>

                    </div>
                </div>
                <!--ct_lf end  -->
               <p><fmt:formatDate value="${orderinfo.quoteinfo.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
            </div>
        </div>
        <div class="timeline-item" ng-repeat="x in data">
            <div class="timeline-icon">
                <img
                        src="/static/images/weixin/goods_owner.png"
                        alt="货主">
            </div>
            <div class="timeline-content {{$index%2==0? 'left':'right'}}">
                <h2>{{x.status}}</h2>
                <div class="ct_lf">
                    <div class="cb_tle">
                        <div class="ic_img">
                            <img alt="运单"
                                 src="/static/images/weixin/icon_bidding.png">
                        </div>
                    </div>
                    <div class="cb_val">
                        <div>{{x.content}}</div>
                    </div>
                </div>
                <!--ct_lf end  -->
                <%--<div class="ct_lf">
                    <div class="cb_tle">
                        <div class="ic_img">
                            <img alt="操作人"
                                 src="/static/images/weixin/user_head.png">
                        </div>
                    </div>
                    <div class="cb_val">
                        <div>{{x.createBy.loginName}}</div>
                    </div>
                </div>--%>
                <!--ct_lf end  -->
                <p>{{x.createDate}}</p>
            </div>
        </div>

    </div>
</div>
<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>
<script src="/static/modules/wlpt/front/js/angular/angular.min.js"></script>
<script>
var isReturn = false;
    var app = angular.module("dataHall", []);
    app.controller('dataHallCtrl', function ($scope, $http) {
        $scope.currentPage = 1;
        $scope.pageSize = 10;
        $scope.pages = [];
        $scope.id = '${orderinfo.id}';
        //get first page
        $http({
            url: '${wlpt}/wlpt/trade/getTraceList',
            method: 'post',
            params: {
                'id': $scope.id,
                'pageNo': $scope.currentPage,
                'pageSize': $scope.pageSize
            }
        }).success(function (response) {
            $scope.data = response.data;
            isReturn = true;
        });
        
    });
    function loads(height){
   	 
    	
    	var myFrameheight = height +10;
    	top.$("#myFrame").height(0); //清空父级iframe高度
        $("#myFrame",parent.document).height( myFrameheight < 500 ? 500 : myFrameheight);//重新设置父级iframe高度
        $(".container").height( myFrameheight < 500 ? 500 : myFrameheight );//重新设置container高度
        //
  		top.top.$("#rightFrame").height(0); //用于每次刷新时控制IFRAME高度初始化
        var heights =  height + 210;
        top.top.$("#rightFrame").height( heights < 500 ? 500 : heights );//重新设置父级的父级iframe高度
        
    }
    $(function(){
        var t = setInterval(function(){
            
      	  if(isReturn == true){
      	   	//重置页面高度
       		loads($(".container").height());
       		clearInterval(t);
      	}
      	},500)
    })


</script>
</body>
</html>
