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
            width: 35%;
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
            width: 60%;
        }

        .span4 {
            width: 47%;
        }
        .span4 h4 {
            padding: 5px;
            margin: 10px 0 5px;
            border: none;
            border-bottom: 1px solid #000;
            color: #000;
            background: transparent;
        }
        h5 {
            padding: 3px;
            margin: 10px 0 5px;
            border: none;
            background: none;
        }
        #gdbanner{
            height: 100px;
            width: 100%;
            clear: both;
            border: 2px solid #CCC;
            margin-top: 10px;
        }
    </style>
</head>
<body>
<%--<div class="hero-unit" style="padding-bottom:35px;margin:10px 0;">
    <c:set var="article" value="${fnc:getArticle('1')}"/>
    <img class="htilimg" onerror="this.onerror=null;this.src='${ctxStatic }/images/wlptfront/logo.png'"
         src="${fns:abbr(article.imageSrc,400)}">
    <h3>${fns:abbr(article.title,28)}</h3>
    <p></p>
    <p style="font-size: 14px;">${fns:abbr(fns:replaceHtml(article.articleData.content),260)}……</p>
    <p style="clear:both;"><a href="${article.url}" style="text-decoration: none;color: #83CA9A;">
        &nbsp;&nbsp;&nbsp;查看详情 &raquo;&nbsp;&nbsp;&nbsp;</a></p>
</div>--%>
<div class="row" style="clear:both;">
    <div class="span4" style="width: 100%">
        <h4>
            <small><a style="margin-top: 3px;" href="${ctx}/list-3${urlSuffix}" class="pull-right">更多&gt;&gt;</a>
            </small>
            最新头条
        </h4>
        <ul class="fonli" style="width: 77%;float:left;"><c:forEach items="${fnc:getArticleList(site.id, 3, 7, '')}" var="article" varStatus="arindex">
            <c:if test="${arindex.index == 0}">
                <li>
                    <img onerror="this.onerror=null;this.src='${ctxStatic }/images/wlptfront/logo.png'" style=" position: absolute; width: 24%;height: 220px;"
                         class="htimg" src="${article.imageSrc}">
                    <a href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}"
                       style="padding-left: 43%;width: 55%;color:${article.color};">${fns:abbr(article.title,60)}</a>
                    <p style="font-size: 12px;padding-left: 43%;width: 56%;">${fns:abbr(fns:replaceHtml(article.articleData.content),100)}……
                        &nbsp;&nbsp; <fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd"/>
                    </p>
                </li>
            </c:if>
            <c:if test="${arindex.index != 0}">
                <li style="line-height: 25px;padding-left: 43%;"><span class="pull-right"><fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd"/></span><a
                        href="${article.url}" style="width: 80%;color:${article.color}">${fns:abbr(article.title,50)}</a></li>

            </c:if>
        </c:forEach>
        </ul>
        <div class="span3" style="float:right;width: 20%;margin-left: 5px;">
            <h5>
                <%--<small><a style="margin-top: 3px;" href="${ctx}/list-b5a16cb4c6884646ab51023e20cbb401${urlSuffix}"
                          class="pull-right">更多&gt;&gt;</a></small>--%>
                推荐阅读
            </h5>
            <ul class="fonli">
                <cms:frontArticleHitsTop category="${category}"/>
                <%--<c:forEach items="${fnc:getArticleList(site.id, 'b5a16cb4c6884646ab51023e20cbb401', 8, '')}"
                           var="article" varStatus="arindex">

                    <c:if test="${arindex.index == 0}">
                        <li>
                            <img onerror="this.onerror=null;this.src='${ctxStatic }/images/wlptfront/logo.png'"
                                 class="htimg" src="${article.imageSrc}">
                            <a href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}"
                               style="color:${article.color}">${fns:abbr(article.title,60)}</a>
                            <p style="font-size: 12px;">${fns:abbr(fns:replaceHtml(article.articleData.content),100)}……
                                &nbsp;&nbsp; <fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd"/>
                            </p>
                        </li>

                    </c:if>
                    <c:if test="${arindex.index != 0}">
                        <li style="line-height: 25px;"><span class="pull-right"><fmt:formatDate value="${article.updateDate}"
                                                                                                pattern="yyyy-MM-dd"/></span><a
                                href="${article.url}" style="width: 80%;color:${article.color}">${fns:abbr(article.title,50)}</a></li>

                    </c:if>

                </c:forEach></ul>--%>
        </div>
    </div>
</div>
<div class="row" style="clear:both;">
    <div class="span4">
        <h4>
            <small><a style="margin-top: 3px;" href="${ctx}/list-2${urlSuffix}" class="pull-right">更多&gt;&gt;</a>
            </small>
            资讯中心
        </h4>
        <ul class="fonli"><c:forEach items="${fnc:getArticleList(site.id, 2, 8, '')}" var="article" varStatus="arindex">
            <c:if test="${arindex.index == 0}">
                <li>
                    <img onerror="this.onerror=null;this.src='${ctxStatic }/images/wlptfront/logo.png'"
                         class="htimg" src="${article.imageSrc}">
                    <a href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}"
                       style="color:${article.color};">${fns:abbr(article.title,60)}</a>
                    <p style="font-size: 12px;">${fns:abbr(fns:replaceHtml(article.articleData.content),100)}……
                        &nbsp;&nbsp; <fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd"/>
                    </p>
                </li>
            </c:if>
            <c:if test="${arindex.index != 0}">
                <li style="line-height: 25px;"><span class="pull-right"><fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd"/></span><a
                        href="${article.url}" style="width: 80%;color:${article.color}">${fns:abbr(article.title,50)}</a></li>

            </c:if>
        </c:forEach></ul>
    </div>
    <div class="span4" style="float:right;">
        <h4>
            <small><a style="margin-top: 3px;" href="${ctx}/list-b5a16cb4c6884646ab51023e20cbb401${urlSuffix}"
                      class="pull-right">更多&gt;&gt;</a></small>
            园区公告
        </h4>
        <ul class="fonli">
            <c:forEach items="${fnc:getArticleList(site.id, 'b5a16cb4c6884646ab51023e20cbb401', 8, '')}"
                       var="article" varStatus="arindex">

                <c:if test="${arindex.index == 0}">
                    <li>
                        <img onerror="this.onerror=null;this.src='${ctxStatic }/images/wlptfront/logo.png'"
                             class="htimg" src="${article.imageSrc}">
                        <a href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}"
                           style="color:${article.color}">${fns:abbr(article.title,60)}</a>
                        <p style="font-size: 12px;">${fns:abbr(fns:replaceHtml(article.articleData.content),100)}……
                            &nbsp;&nbsp; <fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd"/>
                        </p>
                    </li>

                </c:if>
                <c:if test="${arindex.index != 0}">
                    <li style="line-height: 25px;"><span class="pull-right"><fmt:formatDate value="${article.updateDate}"
                                                                                            pattern="yyyy-MM-dd"/></span><a
                            href="${article.url}" style="width: 80%;color:${article.color}">${fns:abbr(article.title,50)}</a></li>

                </c:if>

            </c:forEach></ul>
    </div>
</div>
<div id="gdbanner" style="height: 100px;width: 100%;clear: both">
    <img src="/static/images/wlptfront/shop_img/bot_two.png"/>
</div>
<div class="row" style="clear:both;">

    <div class="span4">
        <h4>
            <small><a style="margin-top: 3px;" href="${ctx}/list-e7ac31ccf1b04e229874fcdaa18d5205${urlSuffix}"
                      class="pull-right">更多&gt;&gt;</a></small>
            政策公告
        </h4>
        <ul class="fonli">
            <c:forEach items="${fnc:getArticleList(site.id, 'e7ac31ccf1b04e229874fcdaa18d5205', 8, '')}"
                       var="article" varStatus="arindex">

                <c:if test="${arindex.index == 0}">
                    <li>
                        <img onerror="this.onerror=null;this.src='${ctxStatic }/images/wlptfront/logo.png'"
                             class="htimg" src="${article.imageSrc}">
                        <a href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}"
                           style="color:${article.color}">${fns:abbr(article.title,60)}</a>
                        <p style="font-size: 12px;">${fns:abbr(fns:replaceHtml(article.articleData.content),100)}……
                            &nbsp;&nbsp; <fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd"/>
                        </p>
                    </li>
                </c:if>
                <c:if test="${arindex.index != 0}">
                    <li style="line-height: 25px;"><span class="pull-right"><fmt:formatDate value="${article.updateDate}"
                                                                                            pattern="yyyy-MM-dd"/></span><a
                            href="${article.url}" style="width: 80%;color:${article.color}">${fns:abbr(article.title,50)}</a></li>

                </c:if>

            </c:forEach>
        </ul>
    </div>
    <div class="span4" style="float:right;">
        <h4>
            <small><a style="margin-top: 3px;" href="${ctx}/list-32d165b6a8d04a72a73cc006c97f6861${urlSuffix}"
                      class="pull-right">更多&gt;&gt;</a></small>
            物流诚信
        </h4>
        <ul class="fonli"><c:forEach items="${fnc:getArticleList(site.id, '32d165b6a8d04a72a73cc006c97f6861', 8, '')}"
                                     var="article" varStatus="arindex">
            <c:if test="${arindex.index == 0}">
                <li>
                    <img onerror="this.onerror=null;this.src='${ctxStatic }/images/wlptfront/logo.png'"
                         class="htimg" src="${article.imageSrc}">
                    <a href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}"
                       style="color:${article.color}">${fns:abbr(article.title,60)}</a>
                    <p style="font-size: 12px;">${fns:abbr(fns:replaceHtml(article.articleData.content),100)}……
                        &nbsp;&nbsp; <fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd"/>
                    </p>
                </li>
            </c:if>
            <c:if test="${arindex.index != 0}">
                <li style="line-height: 25px;"><span class="pull-right"><fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd"/></span><a
                        href="${article.url}" style="width: 80%;color:${article.color}">${fns:abbr(article.title,50)}</a></li>

            </c:if>
        </c:forEach></ul>
    </div>
</div>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/include/jqthumb.min.js"></script>
<script>
    $('#gdbanner img').jqthumb({
        width: $("#gdbanner").width(),
        height: 100,
        after: function (imgObj) {
            imgObj.css('opacity', 0).animate({
                opacity: 1
            }, 1000);
        }
    });
</script>
</body>
</html>