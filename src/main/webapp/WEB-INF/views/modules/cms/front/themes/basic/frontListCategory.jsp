<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <title>${category.name}</title>
    <meta name="decorator" content="cms_default_${site.theme}"/>
    <meta name="description" content="${category.description}"/>
    <meta name="keywords" content="${category.keywords}"/>
    <style>
        .htilimg {
            width: 22%;
            position: relative;
            z-index: 1;
            height: 100px;
            float: left;
            border: 1px solid #CCC;
            border-radius: 5px;
            margin-right: 15px;
        }
        .span5 ul{
            margin-left: 15px;
        }
        .span5 ul li {
            list-style: none;
            height: 110px;
        }

        .span5 ul li img, .span5 ul li a, .span5 ul li p {
            float: left;
        }

        .span5 ul li p {
            font-size: 12px;
            width: 60%;
            float: left;
            text-indent: 16px;
        }

        .span5 ul li a {
            width: 70%;
        }

        .lanav ol li {
            list-style: none;
            border: 1px solid #CCC;
            width: 96%;
            text-align: center;
            border-left: 5px solid #57a1a8;
            margin-bottom: 5px;
        }
        .lanav ol {
            margin: 0 0 10px 5px;
        }
        .lanav ol li:hover {
            background-color: #00A1E8;
            color: #fbfbfb;
            border-left: 5px solid red;
        }
        /*.lanav > ol li {
            list-style: none;
            border: 1px solid #CCC;
            width: 96%;
            text-align: center;
            border-left: 5px solid #73a839;
        }*/
        .lanav > ol li {
            list-style: none;
            border: 1px solid #CCC;
            width: 96%;
            text-align: center;
            border-left: 5px solid #73a839;
            height: 32px;
            line-height: 32px;
            color: #FFFFFF;
        }
        .fonli li{
            clear: both;
        }
    </style>
</head>
<body>
<div class="row">
    <div class="span2 lanav">
        <h4>栏目列表</h4>
        <ol>
            <cms:frontCategoryList categoryList="${categoryList}"/>
        </ol>
        <h4>推荐阅读</h4>
        <ol>
            <cms:frontArticleHitsTop category="${category}"/>
        </ol>
    </div>
    <div class="span10">
        <ul class="breadcrumb">
            <cms:frontCurrentPosition category="${category}"/>
        </ul>
    </div>
    <div class="span10">
        <c:set var="index" value="1"/>
        <c:forEach items="${categoryList}" var="tpl">
            <c:if test="${tpl.inList eq '1' && tpl.module ne ''}">
                <c:set var="index" value="${index+1}"/>
                ${index % 2 eq 0 ? '<div class="row">':''}
                <div class="span5" style="width: 97.5%">
                    <h4>
                        <small><a href="${ctx}/list-${tpl.id}${urlSuffix}" class="pull-right">更多&gt;&gt;</a></small>
                            ${tpl.name}</h4>
                    <c:if test="${tpl.module eq 'article'}">
                        <ul class="fonli"><c:forEach items="${fnc:getArticleList(site.id, tpl.id, 5, '')}" var="article">
                            <li>
                                <img onerror="this.onerror=null;this.src='${ctxStatic }/images/wlptfront/logo.png'"
                                     class="htilimg" src="${article.imageSrc}">
                                <a href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}"
                                   style="color:${article.color}">${fns:abbr(article.title,200)}</a>
                                <p style="font-size: 12px;">${fns:abbr(fns:replaceHtml(article.articleData.content),200)}……</p>
                                <span class="pull-right"><fmt:formatDate value="${article.updateDate}"
                                                                         pattern="yyyy-MM-dd"/></span>
                            </li>
                        </c:forEach></ul>
                    </c:if>
                    <c:if test="${tpl.module eq 'link'}">
                        <ul><c:forEach items="${fnc:getLinkList(site.id, tpl.id, 5, '')}" var="link">
                            <li><span class="pull-right"><fmt:formatDate value="${link.updateDate}"
                                                                         pattern="yyyy-MM-dd"/></span><a target="_blank"
                                                                                                         href="${link.href}"
                                                                                                         style="color:${link.color}">${fns:abbr(link.title,40)}</a>
                            </li>
                        </c:forEach></ul>
                    </c:if>
                </div>
                ${index % 2 ne 0 ? '</div>':''}
            </c:if>
        </c:forEach>
    </div>
</div>
</body>
</html>