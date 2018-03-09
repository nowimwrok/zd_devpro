<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>企业信息</title>
<style>
        .goods_details .form-group{
            margin-left:2.5%;
            margin-right:2.5%;
        }
         .load{
            width: 100%;
            height: 94%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 0px;
            text-align: center;
        }
        .load img{
            margin-top: 25%;
        }
        ol li{
      		float:left;
      	}
      	.form-control{
			border: 1px solid #ccc !important;
		}
		
    </style>
</head>
<!-- 公司简介 -->
<body style="background: #f5f5f5;">
<%@ include file="/WEB-INF/views/modules/user_front/user/enterprise_head.jsp" %>
<div style="background: #f5f5f5;">
	<div class="row">
	<form:form id="inputForm3" modelAttribute="userCompany" action="${wlpt}/wlpt/company/save" method="post">
        <form:hidden path="id"/>
        <form:hidden path="user.id"/>
        <form:hidden path="usercompanypicture.id"/>
        <input type="hidden" value="enterprise_culture" name="url"/>
		<div class="col-lg-12">
            <div class="panel" style="border:0;">
                <div class="panel-body">
                    <div class="tab-content">
                    	<div class="tab-pane fade in active" id="basic">
                            <div class="form_container">
                                <h4 class="panel-heading ">形象展示<span class="red">（每张图片大小不超过3M，限上传4张，支持JPG、JPEG、PNG格式）</span></h4>
                            </div>
                            <div class="panel-body">
                                <div class="form-group col-sm-10">
                                    <div class="col-sm-4 control-label text-right">上传头像：</div>
                                    <div class="col-sm-8 text-left">
                                        <div class="text-left">
                                            <!-- <a class="form-control click_upimg"> 点击上传</a> -->
                                            <p class="upimg-tips red" style="font-size: 12px;margin: 8px 0 15px;">图片大小不超过2M，限上传1张，支持JPG、JPEG、PNG格式!</p>
                                        </div>
                                        <ul class="upimg-list clearfix">
                                            <form:hidden id="comanycultureimg" path="usercompanypicture.comanycultureimg" htmlEscape="false"
						                                 maxlength="255"
						                                 class="input-xlarge"/>
						                    <sys:ckfinder input="comanycultureimg" type="images" uploadPath="/userpicture" selectMultiple="true"
						                                  maxWidth="100"
						                                  maxHeight="100" maxnumber="4"/>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="form_container">
                                <h4 class="panel-heading ">企业简介</h4>
                            </div>
                            <div class="panel-body">
                            	<div class="editor" style="height: 520px;border:0px;">
	                                <form:textarea id="content" path="companysummary" htmlEscape="false" rows="10" cols="50"
	                                   maxlength="500" placeholder="支持500字" class="input-xxlarge "/>
                    				<sys:ckeditor replace="content" uploadPath="/usercompany"/>
                    			</div>
                            </div>
                            <div class="col-lg-12 mb-80">
                                <div class="form-group mb-80 mt-40">
                                    <div class="col-sm-2 control-label text-left"></div>
                                    <div class="col-sm-4">
                                    	<input type="button" id="btn-warning" class="btn btn-primary col-lg-12" value="保  存">
                                    </div>
                                    <div class="col-sm-4">
				                        <button class="btn btn-warning col-lg-12" onclick="history.go(-1)">返  回</button>
				                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </form:form>
	</div>
        
</div>

<script>
	$(".qiye_menu li").removeClass("active")
    $(".qiye_menu li").eq(2).addClass("active");
    var msg = '${msg}';
    if (msg != '') {
        $.MsgBox.Alert("保存提示",'${msg}');
    }


    $(".qiye_menu li").on("click", function () {
        $(".qiye_menu li").removeClass("active");
        $(this).addClass("active");
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
        $("#btn-warning").click(function () {
            savecompanyinfo(3);
        });
        
        //提交
        function savecompanyinfo(type) {
            $('#inputForm' + type).submit();
        }

    });
</script>
</body>
</html>