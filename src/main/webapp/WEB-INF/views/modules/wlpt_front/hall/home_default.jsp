<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_personal_basic"/>
    <title>卓大物流平台</title>
    <link
            href="//netdna.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css"
            rel="stylesheet">
    <style type="text/css">
        /*.loading {
                    width: 100%;
                    height: 94%;
                    z-index: 999;
                    position: fixed;
                    background-color: rgba(165, 160, 154, 0.34);
                    top: 0px;
                    text-align: center;
                }

                .loading img {
                    margin-top: 25%;
                }*/
        .loading {
            text-align: center;
        }

        #marquee p {
            cursor: pointer;
            height: 30px;
            line-height: 30px;
            margin: 0
        }
    </style>
</head>
<body style="background: #f5f5f5;">

<div>
    <div class="col-lg-12" style="padding: 0; margin-bottom: 10px;">
        <div class="col-lg-12 notice_bar">
            <div class="notice_l clearfix pull-left">
                <span class="glyphicon glyphicon-home"></span> <a href=""
                                                                  class="text" id="notic_pro">首页</a> <span
                    id="notic_nav"></span>
            </div>
            <div class="notice_r clearfix pull-right" style="height:30px;overflow:hidden;">
					<span class="pull-left">
	            		<i class="glyphicon glyphicon-volume-up" style="margin-right:5px;"></i>
	            		公告:
	            	</span>
                <div class=" pull-left clearfix" id="marquee">

                    <p class="clearfix notice_r_l">
                        <c:forEach items="${fnc:getArticleList(site_id, tpl_id, 2, '')}"
                                   var="article" varStatus="i" end="2">
                            <c:if test="${i.index==0 }">
	            					<span class="notice_time" style="margin-left:5px;">[<fmt:formatDate
                                            value="${article.updateDate}" pattern="MM.dd"/>]</span>
                                <a target="_blank" style="font-size:12px;">${fns:abbr(article.title,200)}</a>
                            </c:if>
                            <c:if test="${i.index!=0 }">
	            					<span class="notice_time" style="margin-left:5px;">[<fmt:formatDate
                                            value="${article.updateDate}" pattern="MM.dd"/>]
									</span>
                                <a target="_blank"
                                   <%--href="${ctx}/view-${article.category.id}-${article.id}${urlSuffix}"--%>
                                   style="font-size: 12px;">${fns:abbr(article.title,200)}</a>
                            </c:if>
                        </c:forEach>
                    </p>

                </div>
            </div>
        </div>
    </div>
    <iframe id="sitbody_iframe" name="sitbody_iframe"
            src="${wlpt}/wlpt/personal/home_index" style="overflow: visible;"
            scrolling="auto" frameborder="no" width="100%" height="600"></iframe>
</div>
</body>
</html>
