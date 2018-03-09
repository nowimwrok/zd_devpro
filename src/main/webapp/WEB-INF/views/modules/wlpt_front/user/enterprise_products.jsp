<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>企业信息</title>
    <style type="text/css">
        body{
        padding: 0;
        margin: 0;
        width: 100%;
        margin: 0 auto;
        text-align: center;
        border: 1px solid #D6D3CE;
        font-family: "微软雅黑"；
    }

        ul p span a input td {
            font-family: "微软雅黑";
        }

        .qiye_infor_right img {
            width: 100px;
            height: 100px;
        }

        .photo_type > ol li {
            width: 110px;
            height: 106px;
            display: block;
            float: left;
            margin-left: 5px;
            position: relative;
        }

        .photo_type > ol li img {
            border: none;
            margin: 0px auto;
        }
     .qiye_infor_center {
     	height:50px;
     	line-height:50px;
	    width: 33%;
	    text-align: left;
	}
    </style>


</head>

<body>
<%@ include file="/WEB-INF/views/modules/wlpt_front/user/enterprise_head.jsp" %>

<!-- 公司产品服务 -->
<div id="info5" >
    <form:form id="inputForm5" modelAttribute="userCompany" action="${wlpt}/wlpt/company/save" method="post"
               class="form-horizontal">
    <form:hidden path="id"/>
    <form:hidden path="user.id"/>
    <form:hidden path="usercompanypicture.id"/>
    <input type="hidden" value="enterprise_products" name="url"/>
    <p class="user_data">
        <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">产品</span><span
            class="title_orange">服务</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
    </p>
    <div class="qiye_intro_wrap">
        <div class="editor" style="height: 520px;border:0px;">
            <form:textarea id="productserver" path="productserver" htmlEscape="false" rows="40" maxlength="4000"
                           class="input-xxlarge "/>
            <sys:ckeditor replace="productserver" uploadPath="/usercompany"/>
        </div>

        <button class="btn btn-warning btn-warnings5" id="btn-warning">保存</button>
    </div>
</form:form>
</div>

<script>
	$(".qiye_menu li").removeClass("qiye_menu_1")
    $(".qiye_menu li").eq(4).addClass("qiye_menu_1");
       
    var msg = '${msg}';
    if (msg != '') {
        $.MsgBox.Alert("保存提示",'${msg}');
    }


    $(".qiye_menu li").on("click", function () {
        $(".qiye_menu li").removeClass("qiye_menu_1");
        $(this).addClass("qiye_menu_1");
    });

    loads();
    function loads() {

        var height = $("html").innerHeight();
        var myFrameheight = height + 100;
        top.$("#rightFrame").height(0); //清空父级iframe高度
        $("#rightFrame", parent.document).height(myFrameheight < 600 ? 600 : myFrameheight);//重新设置父级iframe高度
        $(".container").height(myFrameheight < 600 ? 600 : myFrameheight);//重新设置container高度

    }

    $(function () {
       
        //保存产品服务
        $(".btn-warnings5").click(function () {
            savecompanyinfo(5);
        });
        //提交
        function savecompanyinfo(type) {
            $('#inputForm' + type).submit();
        }

    });

</script>
</body>
</html>