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


<!-- 公司资质 -->
<div id="info2">
    <form:form id="inputForm2" modelAttribute="userCompany" action="${wlpt}/wlpt/company/save" method="post"
               class="form-horizontal">
        <form:hidden path="id"/>
        <form:hidden path="user.id"/>
        <form:hidden path="usercompanypicture.id"/>
        <input type="hidden" value="enterprise_qualification" name="url"/>
        <p class="user_data">
            <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">上传</span><span
                class="title_orange">资质</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
        </p>
        <div class="qualification_wrap">
            <p>公司资质属于保密内容，不对外展示，请放心。每张图片大小不超过3M，支持JPG、JPEG、PNG格式</p>

            <div class="photo_list">
                <p class="photo_title_1">法人相片：</p>
                <div class="photo_type">
                    <form:hidden id="headerimg" path="usercompanypicture.headerimg" htmlEscape="false" maxlength="255"
                                 class="input-xlarge"/>
                    <sys:ckfinder input="headerimg" type="images" uploadPath="/userpicture" selectMultiple="true"
                                  maxWidth="100"
                                  maxHeight="100" maxnumber="4"/>
                </div>
            </div>

            <div class="photo_list">
                <p class="photo_title_1">手持身份证照：</p>
                <div class="photo_type">
                    <form:hidden id="idcardimg" path="usercompanypicture.idcardimg" htmlEscape="false" maxlength="255"
                                 class="input-xlarge"/>
                    <sys:ckfinder input="idcardimg" type="images" uploadPath="/userpicture" selectMultiple="true"
                                  maxWidth="100"
                                  maxHeight="100" maxnumber="4"/>
                </div>
            </div>
            <div class="photo_list">
                <p class="photo_title_1">道路运输许可证：</p>
                <div class="photo_type">
                    <form:hidden id="transportcardimg" path="usercompanypicture.transportcardimg" htmlEscape="false"
                                 maxlength="255"
                                 class="input-xlarge"/>
                    <sys:ckfinder input="transportcardimg" type="images" uploadPath="/userpicture" selectMultiple="true"
                                  maxWidth="100"
                                  maxHeight="100" maxnumber="4"/>
                </div>
            </div>
            <div class="photo_list">
                <p class="photo_title_1">税务登记许可证：</p>
                <div class="photo_type">
                    <form:hidden id="taximg" path="usercompanypicture.taximg" htmlEscape="false" maxlength="255"
                                 class="input-xlarge"/>
                    <sys:ckfinder input="taximg" type="images" uploadPath="/userpicture" selectMultiple="true"
                                  maxWidth="100"
                                  maxHeight="100" maxnumber="4"/>
                </div>
            </div>
            <button class="btn btn-warning btn-warnings2" id="btn-warning">保存</button>
        </div>
    </form:form>
</div>


<script>
	$(".qiye_menu li").removeClass("qiye_menu_1")
    $(".qiye_menu li").eq(1).addClass("qiye_menu_1");
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