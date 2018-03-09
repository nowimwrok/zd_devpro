<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/banner.css">
<style type="text/css">

        footer {
		    width: 100%;
		    /* margin-top: 80px; */
		    clear: both;
		    background-color: #363E41;
		    padding-bottom: 2%;
		}
</style>
<!-- 图片轮播 -->
<div class="index-banner">
    <div class="wrap">
        <div class="wmuSlider example1">
        <c:set var="list" value="${fns:getWlptBanner()}"/>
        	<c:choose>
	            <c:when test="${not empty list}">
	                <c:forEach items="${list}" var="ad" varStatus="vs">
	                	
	                	<article style="position: absolute; width: 100%; opacity: 0;">
			                <div class="banner-wrap">
			                    <div class="cont span_2_of_3">
			                        <c:choose>
				                    	<c:when test="${vs.index == 0 }">
				                        	<h1>一键找货找车</h1>
				                        </c:when>
				                        <c:when test="${vs.index == 1 }">
				                        	<h1>简单便捷，找车拉货不用愁</h1>
				                        </c:when>
				                        <c:otherwise>
				                        	<h1>&nbsp;</h1>
				                        </c:otherwise>
			                        </c:choose>
			                    </div>
			                    <c:if test="${fns:getUser().loginName==null or fns:getUser().loginName eq ''}">
			                    <div class="rsidebar span_1_of_3">
			                        <div class="btn"><a href="${wlpt }/login?login=login" style="color: #fff;">注册/登录</a></div>
			                    </div>
			                    </c:if>
			                    <div class="clear"></div>
			                </div>
			                <div class="banner"> <a href="javascript:void(0);"><img src="${ad.picture}" alt=""/></a> </div><!-- 在herf加上javascript:void()是为了修复点击之后会刷新页面的bug -->
			            </article>
	                 </c:forEach>
	            </c:when>
	            <c:otherwise>
		            <article style="position: absolute; width: 100%; opacity: 0;">
		                <div class="banner-wrap">
		                    <div class="cont span_2_of_3">
		                        <h1>一键找货找车</h1>
		                    </div>
		                    <div class="rsidebar span_1_of_3">
		                        <div class="btn"><a href="" style="color: #fff;">注册/登录</a></div>
		                    </div>
		                    <div class="clear"></div>
		                </div>
		                <div class="banner"> <img src="${ctxStatic }/images/wlptfront/mac.png" alt=""/> </div>
		            </article>
		            <article style="position: relative; width: 100%; opacity: 1;">
		                <div class="banner-wrap">
		                    <div class="cont span_2_of_3">
		                        <h1>简单便捷，找车拉货不用愁</h1>
		                    </div>
		                    <div class="rsidebar span_1_of_3">
		                        <div class="btn"><a href="" style="color: #fff;">注册/登录</a></div>
		                    </div>
		                    <div class="clear"></div>
		                </div>
		                <div class="banner"> <img src="${ctxStatic }/images/wlptfront/mac1.png" alt=""/> </div>
		            </article>
	            </c:otherwise>
	        </c:choose>
            
            
            
            <!--<article style="position: absolute; width: 100%; opacity: 0;">-->
            <!--<div class="banner-wrap">-->
            <!--<div class="cont span_2_of_3">-->
            <!--<h1>云货源</h1>-->
            <!--</div>-->
            <!--<div class="rsidebar span_1_of_3">-->
            <!--<div class="btn"><a href="works.html">了解更多</a></div>-->
            <!--</div>-->
            <!--<div class="clear"></div>-->
            <!--</div>-->
            <!--<div class="banner"> <img src="images/mac.png" alt=""/> </div>-->
            <!--</article>-->
            <!--<article style="position: absolute; width: 100%; opacity: 0;">-->
            <!--<div class="banner-wrap">-->
            <!--<div class="cont span_2_of_3">-->
            <!--<h1>货运跟踪定位</h1>-->
            <!--</div>-->
            <!--<div class="rsidebar span_1_of_3">-->
            <!--<div class="btn"><a href="works.html">了解更多</a></div>-->
            <!--</div>-->
            <!--<div class="clear"></div>-->
            <!--</div>-->
            <!--<div class="banner"> <img src="images/mac1.png" alt=""/> </div>-->
            <!--</article>-->
            <!--<article style="position: absolute; width: 100%; opacity: 0;">-->
            <!--<div class="banner-wrap">-->
            <!--<div class="cont span_2_of_3">-->
            <!--<h1>物流竞价交易</h1>-->
            <!--</div>-->
            <!--<div class="rsidebar span_1_of_3">-->
            <!--<div class="btn"><a href="works.html">了解更多</a></div>-->
            <!--</div>-->
            <!--<div class="clear"></div>-->
            <!--</div>-->
            <!--<div class="banner"> <img src="images/mac.png" alt=""/> </div>-->
            <!--</article>-->
        </div>
    </div>

</div>

<%--
 <!-- 图片轮播 -->
<div id="slidershow" class="carousel slide">
<!-- 设置图片轮播的顺序 -->
<ol class="carousel-indicators">
    <li class="active" data-target="#slidershow" data-slide-to="0"></li>
    <li data-target="#slidershow" data-slide-to="1"></li>
    <li data-target="#slidershow" data-slide-to="2"></li>
</ol>
<!-- 设置轮播图片 -->
<div class="carousel-inner">
    <div class="item active">
        <a href="##"><img src="${ctxStatic }/images/wlptfront/index_banner.png" alt=""></a>
        <div class="carousel-caption">
        </div>
    </div>
    <div class="item">
        <a href="##"><img src="${ctxStatic }/images/wlptfront/index_banner.png" alt=""></a>
        <div class="carousel-caption">
            <h3></h3>
            <p></p>
        </div>
    </div>
    <div class="item">
        <a href="##"><img src="images/index_img/index_banner.png" alt=""></a>
        <div class="carousel-caption">
            <h3></h3>
            <p></p>
        </div>
    </div>
    </div>
    <a class="left carousel-control" href="#slidershow" role="button">
        <span class="glyphicon glyphicon-chevron-left"></span>
    </a>
    <a class="right carousel-control" href="#slidershow" role="button">
        <span class="glyphicon glyphicon-chevron-right"></span>
    </a>
</div> --%>

<script src="${ctxStatic}/modules/wlpt/front/js/jquery.magnific-popup.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/jquery.hoverdir.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.flexisel.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/jquery.wmuSlider.js"></script>
<script type="text/javascript">
    


</script>