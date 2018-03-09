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
	input {
		margin-left:5px;
		padding: 5px;
		height: 37px;
	    padding-left: 5px;
	    line-height: 25px;
	}
	
	.table2_con td input {
	    height: 37px;
	}
	.Wdate{
		margin-left:5px;
		padding: 5px;
		    height: 37px;
	    padding-left: 5px;
	    line-height: 25px;
	}
    </style>
</head>

<body>
<%@ include file="/WEB-INF/views/modules/wlpt_front/user/enterprise_head.jsp" %>

<!-- 公司简介 -->
<div id="info3" >
    <form:form id="inputForm3" modelAttribute="userCompany" action="${wlpt}/wlpt/company/save" method="post"
               class="form-horizontal">
        <form:hidden path="id"/>
        <form:hidden path="user.id"/>
        <form:hidden path="usercompanypicture.id"/>
        <input type="hidden" value="enterprise_culture" name="url"/>
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">形象</span><span
                class="title_orange">展示</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
        </p>
        <div class="qiye_intro_wrap">
            <p>每张图片大小不超过3M，限上传4张，支持JPG、JPEG、PNG格式</p>
            <div class="photo_list">
                <p class="photo_title_1">企业文化：</p>
                <div class="photo_type">
                    <form:hidden id="comanycultureimg" path="usercompanypicture.comanycultureimg" htmlEscape="false"
                                 maxlength="255"
                                 class="input-xlarge"/>
                    <sys:ckfinder input="comanycultureimg" type="images" uploadPath="/userpicture" selectMultiple="true"
                                  maxWidth="100"
                                  maxHeight="100" maxnumber="4"/>
                    <p>此信息将在企业展示中展示，请上传四张图片</p>
                </div>
            </div>
            </div>
 <div class="qiye_intro_wrap">
            <div class="editor_wrap">
                <p class="user_data">
                    <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">企业</span><span
                        class="title_orange">简介</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
                </p>
                <div class="editor" style="height: 520px;border:0px;">
                    <form:textarea id="content" path="companysummary" htmlEscape="false" rows="10" cols="50"
                                   maxlength="500" placeholder="支持500字" class="input-xxlarge "/>
                    <sys:ckeditor replace="content" uploadPath="/usercompany"/>
                </div>

            </div>
</div>
            <button class="btn btn-warning btn-warnings3" id="btn-warning">保存</button>
        
    </form:form>
</div>
<script>
	$(".qiye_menu li").removeClass("qiye_menu_1")
    $(".qiye_menu li").eq(2).addClass("qiye_menu_1");
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
        // 资质保存
        $(".btn-warnings2").click(function () {
            savecompanyinfo(2);
        });
        
        //提交
        function savecompanyinfo(type) {
            $('#inputForm' + type).submit();
        }

    });
</script>
</body>
</html>