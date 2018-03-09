<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<%@ taglib prefix="sitemesh" uri="http://www.opensymphony.com/sitemesh/decorator" %>
<!DOCTYPE html>
<html>
<head>
    <title><sitemesh:title default="欢迎光临"/> - ${site.title} - Powered By zhuoda56</title>
    <%@include file="/WEB-INF/views/modules/cms/front/include/head.jsp" %>
    <sitemesh:head/>
    <style>
        .gdflimg, .gdrtimg {
            width: 100px;
            height: 360px;
            position: fixed;
            background-color: dimgrey;
            top: 170px;
        }

        .gdflimg img, .gdrtimg img {
            width: 100%;
            height: 100%;
            display: block;
        }

        #navprdv {
            width: 100%;
            height: 60px;
            background-color: #44ADE9;
        }

        #navprdv ul li a {
            line-height: 37px;
            color: rgba(0, 0, 0, 0.2);
            font-size: 16px;
            font-weight: 100;
        }

        #navprdv ul li a:hover {
            color: rgba(0, 0, 0, 0.2);
            text-decoration: none;
            background-color: transparent;
            border-bottom: 2px solid #EC900C;
        }

        .active {
            background-color: transparent;
        }

        .navbar .nav > .active > a, .navbar .nav > .active > a:hover, .navbar .nav > .active > a:focus {
            color: #fefefe;
            text-decoration: none;
            background-color: transparent;
            border-bottom: 2px solid #EC900C;

        }

        .active a {
            background-color: transparent;
            border-bottom: 2px solid #EC900C;
        }
    </style>
</head>
<body>
<div class="navbar navbar-fixed-top" style="position:static;margin-bottom:10px;">
    <div class="navbar-inner" style="border:  none">
        <div class="container" style="padding-top: 10px">
            <c:choose>
                <c:when test="${not empty site.logo}">
                    <img style="width:150px;margin:5px 12px 10px 0px;float: left;" alt="${site.title}"
                         src="${site.logo}"
                         class="container" onclick="location='${ctx}/index-${site.id}${fns:getUrlSuffix()}'">
                    <h3 style="float: left; margin-top: 8px;">卓大物流资讯云平台</h3>
                    <form style="margin-top: 18px;" class="navbar-form pull-right" action="${ctx}/search" method="get">
                        <input type="text" name="q" maxlength="20" style="width:180px;margin-top: -8px;"
                               placeholder="全站搜索..."
                               value="${q}">
                    </form>
                </c:when>
                <c:otherwise><a class="brand" href="${ctx}/index-${site.id}${fns:getUrlSuffix()}">${site.title}</a>
                </c:otherwise>
            </c:choose>
        </div>
        <div id="navprdv">
            <div class="container">
                <div class="nav-collapse" style="clear: both;">
                    <ul id="main_nav" class="nav nav-pills">
                        <li class="${not empty isIndex && isIndex ? 'active' : ''}">
                            <a href="${ctx}/index-1${fns:getUrlSuffix()}"><span>${site.id eq '1'?'首　 页':'返回主站'}</span></a>
                        </li>
                        <c:forEach items="${fnc:getMainNavList(site.id)}" var="category" varStatus="status"><c:if
                                test="${status.index lt 6}">
                            <c:set var="menuCategoryId" value=",${category.id},"/>
                            <li class="${requestScope.category.id eq category.id||fn:indexOf(requestScope.category.parentIds,menuCategoryId) ge 1?'active':''}">
                                <a href="${category.url}" target="${category.target}"><span>${category.name}</span></a>
                            </li>
                        </c:if></c:forEach>
                        <%--<li id="siteSwitch" class="dropdown">
                               <a class="dropdown-toggle" data-toggle="dropdown" href="#" title="站点"><i class="icon-retweet"></i></a>
                            <ul class="dropdown-menu">
                              <c:forEach items="${fnc:getSiteList()}" var="site"><li><a href="#" onclick="location='${ctx}/index-${site.id}${urlSuffix}'">${site.title}</a></li></c:forEach>
                            </ul>
                        </li>
                        <li id="themeSwitch" class="dropdown">
                               <a class="dropdown-toggle" data-toggle="dropdown" href="#" title="主题切换"><i class="icon-th-large"></i></a>
                            <ul class="dropdown-menu">
                              <c:forEach items="${fns:getDictList('theme')}" var="dict"><li><a href="#" onclick="location='${pageContext.request.contextPath}/theme/${dict.value}?url='+location.href">${dict.label}</a></li></c:forEach>
                            </ul>
                            <!--[if lte IE 6]><script type="text/javascript">$('#themeSwitch').hide();</script><![endif]-->
                        </li>--%>
                    </ul>

                </div><!--/.nav-collapse -->
            </div>
        </div>
    </div>
</div>
<div class="container">
    <div class="content">
        <sitemesh:body/>
    </div>
    <hr style="margin:20px 0 10px;">
    <footer>
        <div class="footer_nav"><a href="${ctx}/guestbook" target="_blank">公共留言</a> | <a href="${ctx}/search"
                                                                                         target="_blank">全站搜索</a> | <a
                href="${ctx}/map-${site.id}${fns:getUrlSuffix()}" target="_blank">站点地图</a> | <a href="mailto:">技术支持</a>
            | <a href="${pageContext.request.contextPath}${fns:getAdminPath()}" target="_blank">卓大物流平台</a> | <a
                    href="${pageContext.request.contextPath}${fns:getFrontPath()}/register" target="_blank">我要注册</a>
        </div>
        <div class="pull-right">${fns:getDate('yyyy年MM月dd日 E')}</div>
        <div class="copyright">${site.copyright}</div>
    </footer>
</div> <!-- /container -->
<%--<div class="gdflimg">--%>
<%--<img src="/static/images/wlptfront/banner.png">--%>
<%--</div>--%>
<%--<div class="gdrtimg">--%>
<%--<img src="/static/images/wlptfront/yuncang.png">--%>
<%--</div>--%>
</body>
</html>