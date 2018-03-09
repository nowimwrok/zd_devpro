<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>添加联系人</title>
    <link rel="stylesheet" href="${ctxStatic}/front/css/add.css" />
    <style type="text/css">
        .regbt {
            width: 200px;
            height: 35px;
            border: solid 1px;
            border-radius: 0px;
            background-color: #FFC52F;
            border-color: #FFC52F;
            cursor: pointer;
            font-weight: bold;
            text-align: center;
            color: white;
            margin-top: 6px;
            font-size: 16px;
        }
        
        .goods_details .form-group{
            margin-left:2.5%;
            margin-right:2.5%;
        }
         .loading{
            width: 100%;
            height: 94%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 0px;
            text-align: center;
        }
        .loading img{
            margin-top: 25%;
        }
    </style>
</head>
<body style="background: #f5f5f5;">
<div style="background: #f5f5f5;">
	<div class="row">
        <div class="col-lg-12">
            	<i class="line"></i>
            	
            	<div class="form_container">
            		<div class="panel clearfix">
            			<h4 class="panel-heading">添加联系人</h4>
            			<div class="col-sm-6 form-horizontal" style="margin-top:25px;">
             			<div class="col-sm-12 form-group">
             				<div class="col-sm-3 text-right control-label">
             					用户名/电话
             				</div>
             				<div class="col-sm-7 text-left">
             					<input id="searchinfo" name="searchinfo" class="form-control" placeholder="用户名/电话"/>
             				</div>
             			</div>
             			<div class="col-sm-12 form-group">
             				<div class="col-sm-3 text-right control-label">
             					搜索说明
             				</div>
             				<div class="col-sm-7 text-left" >
             					<p class="search_e" id="addinfo">请输入会员的完整用户名或手机号，然后添加即可！</p>
             				</div>
             			</div>
             			<div class="col-sm-12">
             				<div class="col-sm-2"></div>
             					<button class="col-sm-8 btn  btn-primary driver_btn" onclick="search();">查询</button>
             				</div>
            			</div>
            			<div class="col-sm-1"></div>
            			<div class="col-sm-4  form-horizontal" >
            				<!--没有搜索时的-->
            				<img src="${ctxStatic }/front/img/headPic.jpg" alt=""  class="search_img" id="search_img"/>
            				<div class="col-sm-12 search_content" id="info" hidden="hidden">
            				<form:form id="inputForm" modelAttribute="user" action="${wlpt}/wlpt/contacts/saveContacts" method="post">
	            				<input id="userid" name="target.id" type="hidden"/>
            					<input id="role" type="hidden"/>
            					<div class=" clearfix col-sm-12 content_list">
		              				<div class="col-sm-5 label-control text-right">
		              					登录名：
		              				</div>
		              				<div class="col-sm-5 text-left list_c" id="login">
		              					
		              				</div>
            					</div>
            					<div class="clearfix col-sm-12 content_list">
            						<div class="col-sm-5 label-control text-right">
            							真实姓名：
            						</div>
		              				<div class="col-sm-5 text-left list_c" id="name">
		              					
		              				</div>
            					</div>
            					<div class=" clearfix col-sm-12 content_list">
		              				<div class="col-sm-5 label-control text-right">
		              					手机号码：
		              				</div>
		              				<div class="col-sm-5 text-left list_c" id="phone">
		              					
		              				</div>
            					</div>
            					<div class="clearfix col-sm-12 content_list">
		              				<div class="col-sm-5 label-control text-right" >
		              					认证：
		              				</div>
		              				<div class="col-sm-5 text-left list_c" id="status">
		              					
		              				</div>
            					</div>
            					<div class="col-sm-12 clearfix">
            						<input type="button" class="btn col-sm-6 col-sm-offset-3 btn-danger" id="btnSubmit" style="margin-top:3px;" value="添  加">
            					</div>
            					</form:form>
            				</div>
            			</div>
            		</div>
            	
            	<!-- <div class="loading">
			        <img src="/static/images/loading.gif">
			        <p>加载中</p>
			    </div> -->
            	
            	</div>
	        </div>
		</div>
</div>

<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script type="text/javascript">

    function search() {
        var isnul = true;
        isnul = isnul && $("#searchinfo").valid({
                    methods: "required"
                });
        if (isnul) {
            var searchinfo = $("#searchinfo").val();
            $.ajax({
                url: "${wlpt}/wlpt/personal/searchInfo",
                dataType: 'json',
                data: {searchinfo: searchinfo},
                cache: false,
                success: function (data) {
                    if (data) {
                        if (data.value == '未查到指定用户') {
                            $("#info").hide();
                            $("#search_img").show();
                            $("#addinfo").html("未查到指定用户!请确认用户是否已注册");
                            $("#addinfo").show();
                        } else {
                            if (data.value.user.id) {
                                $("#userid").val(data.value.user.id);
                            }
                            if (data.value.role.enname) {
                                $("#role").val(data.value.role.enname);
                            }
                            if (data.value.user.id) {
                                $("#userid").val(data.value.user.id);
                            }
                            if (data.value.user.loginName) {
                                $("#login").html( data.value.user.loginName);
                            }
                            if (data.value.user.name) {
                                $("#name").html(data.value.user.name);
                            }
                            if (data.value.user.phone) {
                                $("#phone").html(data.value.user.phone);
                            }
                            /* if (data.value.user.email) {
                                $("#email").html("邮箱：" + data.value.user.email);
                            }
                            if (data.value.info.sex) {
                                if (data.value.info.sex == '1') {
                                    $("#sex").html("性别：" + '男');
                                }
                                if (data.value.info.sex == '0') {
                                    $("#sex").html("性别：" + '女');
                                }
                            } */
                            if (data.value.info.status) {
                                if (data.value.info.status == '2') {
                                    $("#status").html('认证通过');
                                } else {
                                    $("#status").html('未通过');
                                }

                            }
                            $(".search_img").hide();
                            $("#addinfo").html("请输入会员的完整用户名或手机号，然后添加即可！");
                            $("#info").show();
                        }
                    }
                }
            });
        }
    }
    $("#btnSubmit").click(function () {
        if ($("#status").html() == "认证：未通过") {
            $.MsgBox.Alert("温馨提示","用户未认证，不可添加！");
            return false;
        }
        if ($("#role").val() != "enterprise" && $("#role").val() != "carowner" && $("#role").val() != "goodsowner") {
            $.MsgBox.Alert("温馨提示","添加的联系人只能是车主、货主或物流企业！");
            return false;
        }

        if ($("#maskloading" , parent.document).is(':hidden')) {
        	$("#maskloading" , parent.document).show();
        } else {
            return false;
        }
        $.ajax({
            url: "${wlpt}/wlpt/contacts/saveContacts?" + $("#inputForm").serialize(),
            dataType: 'json',
            type: "post",
            success: function (data) {
            	$("#maskloading" , parent.document).hide();
                if (data.value.state == 1) {
                    window.location.href = '${wlpt}/wlpt/contacts/contacts_list';
                } else {
                    $.MsgBox.Alert("保存提示", data.value.message);
                }
            }
        });

    });
</script>
</body>
</html>