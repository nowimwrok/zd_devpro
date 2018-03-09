<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>卓大物流平台</title>
    <meta name="decorator" content="site_default_basic"/>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">


</head>
<body>


<%-- <%@ include file="/WEB-INF/views/modules/wlpt_front/admin/top.jsp" %> --%>


<%-- <link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/top_menu.css">--%>
<link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/personal.css">
<link rel="stylesheet" type="text/css" href="/static/modules/wlpt/front/css/analysis/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="/static/modules/wlpt/front/css/analysis/style.css">
<script src="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>

<style type="text/css">
    * {
        margin: 0px;
        padding: 0px;
    }

    body {
        font-size: 1.4rem;
        line-height: 1.42857143;
        color: #333;
        background-color: #fff;
        font-family: "微软雅黑";
    }

    .per_theme {
        width: 85%;
        margin: 0 auto;
        text-align: center;
    }

    a {
        text-decoration: none;
    }

    a:hover, a:active {
        text-decoration: none;
    }

    .sidebar_list {
        padding: 0;
        margin: 0;
        font-family: "微软雅黑";
        font-size: 14px;
    }

    .first_level > ul {
        display: inline-block;
        margin: 0;
        padding: 0;
        margin-left: 5px;
        background: #fff;
        margin-left: -1px;
        width: 100%;
        display: none;
    }

    .first_level > a {
        color: #fff;
        display: block;
        padding-bottom: 5px;
    }

    .first_level {
        background: #00A2E9;
        text-align: center;
    }

    .second_level li a {
        color: #000;
    }

    .second_level li {
        padding-bottom: 5px;
    }

    .second_level li a:hover, .second_level li a:active {
        color: #00A2E9;
    }

    .sidebar_list li {
        padding-top: 5px;
    }

    .second_level {
        background: #fff;
    }

    .first_level > ul {
        color: #ccc;
        font-size: 12px;
        margin-left: 0px;
    }

    .fa {
        display: inline-block;
        font: normal normal normal 14px/1 FontAwesome;
        font-size: inherit;
        text-rendering: auto;
        -webkit-font-smoothing: antialiased;
        -moz-osx-font-smoothing: grayscale;
    }

    .menuSelect {
        background: rgba(133, 214, 235, 0.5);
        color: #fff;
    }

    .per_top {
        width: 100%;
        line-height: 38px;
        height: 30px;
        text-indent: 2%;
    }

    .second_level {
        color: rgba(76, 69, 69, 0.7);
        font-size: 13px;
        margin-left: 8px;
    }
    .accordion li.open i.fa-chevron-down {
        -webkit-transform: rotate(89deg);
        content: "";
        position: absolute;
        top: 35px;
    }
    .fa-chevron-down:before{
        width: 12px;
        height: 12px;
        border: 0px solid rgba(0, 0, 0, 0);
        border-top: 5px solid #f5f4f4;
        border-left: 5px solid #f5f4f3;
        transform: rotate(135deg);
        -webkit-transform: rotate(135deg);
        content: "";
        position: absolute;
        top: 3px;
        right: 5px;
    }
</style>
<div class="per_theme_wrap">
    <div class="per_theme" style="width: 100%">

        <%-- <iframe id="left" src="${wlpt}/wlpt/personal/side_bar" name="side_bar" width="10%" height="100%"
                 scrolling="no" frameborder="0" ></iframe>--%>
        <div style="width: 14%;float: left; height: 600px;margin-right: 1%;margin-top: 3%">
            <%--  <jsp:include page="side_bar.jsp"></jsp:include> --%>
            <ul id="accordion" class="accordion">
                <c:set var="menuList" value="${fns:getWlptPersonalnMenu()}"/>
                <c:forEach items="${menuList}" var="menu" varStatus="idxStatus">
                    <c:if test="${menu.parent.id eq fns:getConst('MUNE_PERSONAL_ID') && menu.isShow eq '1'}">
                        <li>
                            <div class="link"><span>${menu.name}</span><i class="fa fa-chevron-down"></i></div>
                            <ul class="submenu">
                                <c:forEach items="${menuList}" var="menu2">
                                    <c:if test="${menu2.parent.id eq menu.id&&menu2.isShow eq '1'}">
                                        <li>
                                            <a href="${fn:indexOf(menu2.href, '://') eq -1 ? wlpt : ''}${not empty menu2.href ? menu2.href : '/404'}"
                                               target="content">${menu2.name}</a>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
        </div>
        <div style="float: left; width:85%">
            <div class="per_top">
                <p class="top_left" style="margin: 0px">
                    <span class="icon icon-friends">卓大物流平台</span>
                    <span class="second_level" id="tabmu">/个人首页</span></p>
                <p class="top_right"><span></span></p>
            </div>
            <c:choose>
            <c:when test="${flag!=null&&flag=='trade_list'}">
            <iframe id="rightFrame" src="${wlpt}/wlpt/trade/trade_list" width="100%" suzcrolling="no" scrolling="no"
                    frameborder="0"
                    name="content"></iframe>
            </c:when>
            <c:when test="${flag!=null&&flag=='zhzx'}">
            <iframe id="rightFrame" src="${wlpt}/wlpt/consume/toPurse" width="100%" suzcrolling="no" scrolling="no"
                    frameborder="0"
                    name="content"></iframe>
            </c:when>
            <c:otherwise>
            <iframe id="rightFrame" src="${wlpt}/wlpt/personal/persional_index" width="100%" suzcrolling="no" scrolling="no"
                    frameborder="0"
                    name="content"></iframe>
            </c:otherwise>
            </c:choose>
            
        </div>

    </div>
</div>
<%-- <%@ include file="/WEB-INF/views/modules/wlpt_front/admin/foot.jsp" %> --%>
<%-- <script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js"></script> --%>
<script>
    var handle;//事件柄
    function startTimer() {
        handle = setInterval("timer()", 100);
    }
    function timer() {
        $("#rightFrame").height(0);
        var height = $("#rightFrame").contents().height() + 50;
        $("#rightFrame").height(height < 700 ? 700 : height);
        $(".per_theme").height(height < 700 ? 700 + 50 : height + 50);
        
    }
    setTimeout("startTimer()", 100);
    function LoginListener(){
    	$.ajax({
            type: "POST",
            url: '${wlpt}/wlpt/personal/listener',
            dataType: 'json',
            cache: false,
            success: function (data) {
                var message = data;
                if (message) {
                } else {
                    location.href="${wlpt}";
                }

            }
        });
    }
    window.setInterval("LoginListener()", 12000);
    $(function () {
      
        var Accordion = function (el, multiple) {
            this.el = el || {};
            this.multiple = multiple || false;
            // Variables privadas
            var links = this.el.find('.link');
            // Evento
            links.on('click', {el: this.el, multiple: this.multiple}, this.dropdown)
        };
        Accordion.prototype.dropdown = function (e) {
            var $el = e.data.el;
            $this = $(this),
                    $next = $this.next();
            $next.slideToggle();
            $this.parent().toggleClass('open');
            if (!e.data.multiple) {
                $el.find('.submenu').not($next).slideUp().parent().removeClass('open');
            }

        };
        var accordion = new Accordion($('#accordion'), false);
        $(".submenu").eq(0).slideDown().parent().addClass('open');
        $(".submenu li").click(function () {
            $(".submenu li").removeClass("menuSelect")
            $(this).addClass("menuSelect");
            $("#tabmu").html("/" + $(this).parent("ul").prev().children("span").html() + "/" + $(this).children("a").html());
        });
        /*$("#rightFrame").load(function () {
         $("#left").height = $(this).height();
         $(this).height = 365 + "px";
         this.style.height = Math.max(this.contentWindow.document.body.scrollHeight, this.contentWindow.document.documentElement.scrollHeight, 20) + "px";
         });*/
    });

</script>

</body>
</html>
