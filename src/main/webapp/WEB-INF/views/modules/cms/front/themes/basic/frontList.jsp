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
        .fonli{
            margin-left: 15px;
            clear: both;
        }
        .fonli  li {
            list-style: none;
            height: 110px;
            clear: both;
        }

        .fonli li img, .fonli  li a, .fonli  li p {
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

        .lanav ol {
            margin: 0 0 10px 5px;
        }
        .lanav ol li {
            list-style: none;
            border: 1px solid #CCC;
            width: 96%;
            text-align: center;
            border-left: 5px solid #57a1a8;
            margin-bottom: 5px;
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
        <h4>${category.name}</h4>
        <c:if test="${category.module eq 'article'}">
            <ul class="fonli">
                <c:forEach items="${page.list}" var="article">
                    <%--<li>
                        <span class="pull-right"><fmt:formatDate value="${article.updateDate}" pattern="yyyy-MM-dd"/></span>
                        <a href="${article.url}" style="color:${article.color}">${fns:abbr(article.title,96)}</a>
                    </li>--%>
                    <li>
                        <img onerror="this.onerror=null;this.src='${ctxStatic }/images/wlptfront/logo.png'"
                             class="htilimg" src="${article.imageSrc}">
                        <a href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}"
                           style="color:${article.color}">${fns:abbr(article.title,200)}</a>
                        <p style="font-size: 12px;">${fns:abbr(fns:replaceHtml(article.articleData.content),200)}……</p>
                        <span class="pull-right"><fmt:formatDate value="${article.updateDate}"
                                                                 pattern="yyyy-MM-dd"/></span>
                    </li>
                </c:forEach>
            </ul>
            <div class="pagination" style="clear: both;margin-top: 10px;">${page}</div>
            <script type="text/javascript">
                function page(n, s) {
                    location = "${ctx}/list-${category.id}${urlSuffix}?pageNo=" + n + "&pageSize=" + s;
                }
            </script>
        </c:if>
        <c:if test="${category.module eq 'link'}">
            <ul>
                <c:forEach items="${page.list}" var="link">
                    <li><a href="${link.href}" target="_blank" style="color:${link.color}"><c:out
                            value="${link.title}"/></a></li>
                </c:forEach>
            </ul>
        </c:if>
    </div>
</div>
</body>
</html>