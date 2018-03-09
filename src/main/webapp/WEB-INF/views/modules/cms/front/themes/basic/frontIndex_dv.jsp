<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>首页</title>
    <meta name="decorator" content="cms_default_${site.theme}"/>
    <meta name="description" content="${site.description}"/>
    <meta name="keywords" content="${site.keywords}"/>
    <style>
        .htilimg {
            width: 22%;
            position: relative;
            z-index: 1;
            height: 100%;
            float: left;
            border: 1px solid #CCC;
            border-radius: 5px;
            margin-right: 15px;
        }

        .htimg {
            width: 22%;
            position: relative;
            z-index: 1;
            height: 100px;
            float: left;
            border: 1px solid #CCC;
            border-radius: 5px;
            margin-right: 15px;
        }

        .fonli {
            margin-left: 15px;
            list-style: none;
            clear: both;
        }

        .fonli li {
            list-style: none;
            height: 110px;
            clear: both;
            margin-bottom: 5px;
        }

        .fonli li img, .fonli li a, .fonli li p {
            float: left;
        }

        .fonli li p {
            font-size: 12px;
            width: 60%;
            float: left;
            text-indent: 16px;
        }

        .fonli li a {
            width: 70%;
        }

        .span4 {
            width: 100%;
        }
    </style>
</head>
<body>
<div class="hero-unit" style="padding-bottom:35px;margin:10px 0;">
    <c:set var="article" value="${fnc:getArticle('1')}"/>
    <img class="htilimg" onerror="this.onerror=null;this.src='${ctxStatic }/images/wlptfront/logo.png'"
         src="${fns:abbr(article.imageSrc,400)}">
    <h3>${fns:abbr(article.title,28)}</h3>
    <p></p>
    <p style="font-size: 14px;">${fns:abbr(fns:replaceHtml(article.articleData.content),260)}……</p>
    <p style="clear:both;"><a href="${article.url}" style="text-decoration: none;color: #83CA9A;">
        &nbsp;&nbsp;&nbsp;查看详情 &raquo;&nbsp;&nbsp;&nbsp;</a></p>
</div>
<div class="row" style="clear:both;">
    <div class="span4">
        <h4>
            <small><a style="margin-top: 3px;" href="${ctx}/list-2${urlSuffix}" class="pull-right">更多&gt;&gt;</a>
            </small>
            资讯中心
        </h4>
        <ul class="fonli"><c:forEach items="${fnc:getArticleList(site.id, 2, 8, '')}" var="article">
            <%--
                        <li><span class="pull-right"><fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd"/></span><a href="${article.url}" style="color:${article.color}">${fns:abbr(article.title,28)}</a></li>
            --%>
            <li>
                <img onerror="this.onerror=null;this.src='${ctxStatic }/images/wlptfront/logo.png'"
                     class="htimg" src="${article.imageSrc}">
                <a href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}"
                   style="color:${article.color}">${fns:abbr(article.title,200)}</a>
                <p style="font-size: 12px;">${fns:abbr(fns:replaceHtml(article.articleData.content),200)}……</p>
                        <span class="pull-right"><fmt:formatDate value="${article.updateDate}"
                                                                 pattern="yyyy-MM-dd"/></span>
            </li>
        </c:forEach></ul>
    </div>
    <div class="span4">
        <h4>
            <small><a style="margin-top: 3px;" href="${ctx}/list-e7ac31ccf1b04e229874fcdaa18d5205${urlSuffix}"
                      class="pull-right">更多&gt;&gt;</a></small>
            政策公告
        </h4>
        <ul class="fonli"><c:forEach items="${fnc:getArticleList(site.id, 'e7ac31ccf1b04e229874fcdaa18d5205', 8, '')}"
                                     var="article">
            <%--
                        <li><span class="pull-right"><fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd"/></span><a href="${article.url}" style="color:${article.color}">${fns:abbr(article.title,28)}</a></li>
            --%>
            <li>
                <img onerror="this.onerror=null;this.src='${ctxStatic }/images/wlptfront/logo.png'"
                     class="htimg" src="${article.imageSrc}">
                <a href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}"
                   style="color:${article.color}">${fns:abbr(article.title,200)}</a>
                <p style="font-size: 12px;">${fns:abbr(fns:replaceHtml(article.articleData.content),200)}……</p>
                        <span class="pull-right"><fmt:formatDate value="${article.updateDate}"
                                                                 pattern="yyyy-MM-dd"/></span>
            </li>
        </c:forEach></ul>
    </div>
    <div class="span4">
        <h4>
            <small><a style="margin-top: 3px;" href="${ctx}/list-32d165b6a8d04a72a73cc006c97f6861${urlSuffix}"
                      class="pull-right">更多&gt;&gt;</a></small>
            物流诚信
        </h4>
        <ul class="fonli"><c:forEach items="${fnc:getArticleList(site.id, 'e7ac31ccf1b04e229874fcdaa18d5205', 8, '')}"
                                     var="article">
            <%--
                        <li><span class="pull-right"><fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd"/></span><a href="${article.url}" style="color:${article.color}">${fns:abbr(article.title,28)}</a></li>
            --%>
            <li>
                <img onerror="this.onerror=null;this.src='${ctxStatic }/images/wlptfront/logo.png'"
                     class="htimg" src="${article.imageSrc}">
                <a href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}"
                   style="color:${article.color}">${fns:abbr(article.title,200)}</a>
                <p style="font-size: 12px;">${fns:abbr(fns:replaceHtml(article.articleData.content),200)}……</p>
                        <span class="pull-right"><fmt:formatDate value="${article.updateDate}"
                                                                 pattern="yyyy-MM-dd"/></span>
            </li>
        </c:forEach></ul>
    </div>
</div>
</body>
</html>