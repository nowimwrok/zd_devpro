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
<!-- 公司基本信息 -->
<div id="info1">
    <p class="user_data">
        <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">完善</span><span
            class="title_orange">基本资料</span><img src="${ctxStatic}/images/wlptfront/line-right.png">
    </p>
    <form:form id="inputForm1" modelAttribute="userCompany" action="${wlpt}/wlpt/company/save" method="post"
               class="form-horizontal">
        <form:hidden path="id"/>
        <form:hidden path="user.id"/>
        <input type="hidden" value="0" name="type"/>
        <input type="hidden" value="enterprise_info" name="url"/>
        <table class="qiye-infor">
            <tr>
                <td class="qiye_infor_left"><span class="star_red">*</span>公司名称:</td>
                <td class="qiye_infor_center"> 
                   <form:input path="companyname" id="companyname" htmlEscape="false" maxlength="50"
                                cssClass="required"/>
                                </td>
                <td class="qiye_infor_right"><span>公司logo</span>
                    <form:hidden id="logoname" path="logoname" htmlEscape="false" maxlength="255"
                                 class="input-xlarge"/>
                    <sys:ckfinder input="logoname" type="images" uploadPath="/usercompany" selectMultiple="false"
                                  maxWidth="100"
                                  maxHeight="100"/>
                </td>
            </tr>
            <tr>
                <td class="qiye_infor_left"><span class="star_red">*</span>企业法人:</td>
                
                <td class="qiye_infor_center">
                  <form:input path="legalperson" id="legalperson" htmlEscape="false"
                            maxlength="50" cssClass="required"/></td>
                <td class="qiye_infor_right"><span class="photo-word">图片大小不超过3M，限上传1张，支持JPG、JPEG、PNG格式</span>
                </td>
            </tr>
            <tr>
                <td class="qiye_infor_left"><span class="star_red">*</span>法人身份证号码:</td>
                <td class="qiye_infor_center"><form:input path="legalidcardnum" id="legalidcardnum" htmlEscape="false"
                                                          maxlength="50" cssClass="required"/></td>
                <td class="qiye_infor_right"></span>
                </td>
            </tr>
            <tr class="center-id">
                <td class="qiye_infor_left"></td>
                <td class="qiye_infor_center">法人身份证号属于保密信息，不对外展示</td>
                <td class="qiye_infor_right"></span>
                </td>
            </tr>

            <tr>
                <td class="qiye_infor_left"><span class="star_red">*</span>公司成立时间:</td>
                <td class="qiye_infor_center">
                    <input name="setuptime" id="setuptime" type="text" readonly="readonly" maxlength="20"
                           style="height: 37px;" class="Wdate "
                           value="<fmt:formatDate value="${userCompany.setuptime}" pattern="yyyy-MM-dd"/>"
                           onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false,maxDate:new Date()});"/>
                </td>
                <td class="qiye_infor_right"></span>
                </td>
            </tr>

            <tr>
                <td class="qiye_infor_left"><span class="star_red">*</span>公司地址:</td>
                <td class="qiye_infor_center">
                          <form:input path="provinceCityDistrict" id="provinceCityDistrict"
                            htmlEscape="false" maxlength="50" cssClass="required"
                            onmouseover="this.title=this.value"/></td>
                <td class="qiye_infor_right"></span>
                </td>
            </tr>
            <tr>
                <td class="qiye_infor_left"><span class="star_red">*</span>详细地址:</td>
                <td class="qiye_infor_center"><form:input path="companyaddress" id="companyaddress" htmlEscape="false"
                                                          maxlength="50"/></td>
                <td class="qiye_infor_right"></span>
                </td>
            </tr>
            <tr>
                <td class="qiye_infor_left">公司网址:</td>
                <td class="qiye_infor_center"><form:input path="homepageurl" id="homepageurl" htmlEscape="false"
                                                          maxlength="150"/></td>
                <td class="qiye_infor_right"></span>
                </td>
            </tr>

            <tr>
                <td class="qiye_infor_left">优势资源:</td>
                <td class="qiye_infor_center"><form:input path="advantagesresources" htmlEscape="false"
                                                          maxlength="50"/></td>
                <td class="qiye_infor_right"></span>
                </td>
            </tr>
            <tr>
                <td class="qiye_infor_left">主营业务:</td>
                <td class="qiye_infor_center"><form:input path="mainbusiness" htmlEscape="false" maxlength="50"/></td>
                <td class="qiye_infor_right"></span>
                </td>
            </tr>

            <tr class="mainline0">
                <td class="qiye_infor_left">主营路线1:</td>
                <td class="qiye_infor_center" colspan=2>
                    <form:hidden path="mainline"/>
                    <input type="text" name="frommainline" id="frommainline1" maxlength="50"><span
                        class="center-zhi">至</span><input type="text" name="tomainline" id="tomainline1" maxlength="50">
                    <button class="btn btn-default delete" type="button">删除</button>
                </td>
            </tr>
            <tr class="mainline1" style="display: none;">
                <td class="qiye_infor_left">主营路线2:</td>
                <td class="qiye_infor_center" colspan=2>
                    <input type="text" name="frommainline" id="frommainline2" maxlength="50"><span
                        class="center-zhi">至</span><input type="text" name="tomainline" id="tomainline2" maxlength="50">
                    <button class="btn btn-default delete" type="button">删除</button>
                </td>
            </tr>
            <tr class="mainline2" style="display: none;">
                <td class="qiye_infor_left">主营路线3:</td>
                <td class="qiye_infor_center" colspan=2>
                    <input type="text" name="frommainline" id="frommainline3" maxlength="50"><span
                        class="center-zhi">至</span><input type="text" name="tomainline" id="tomainline3" maxlength="50">
                    <button class="btn btn-default delete" type="button">删除</button>
                </td>
            </tr>
            <tr class="addMainline">
                <td class="qiye_infor_left"></td>
                <td class="qiye_infor_center" colspan=2>
                    <button class="btn btn-default" id="addMainline" type="button">添加主营路线</button>
                </td>
            </tr>
        </table>
        <div class="table_2">
            <p class="user_data break-up">
                <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">联系</span><span
                    class="title_orange">方式</span><img src="${ctxStatic }/images/wlptfront/line-right.png">
            </p>
            <table class="table2_con">
                <tr>
                    <td class="table_2_left">
                        <p class="ta">公司电话:</p>
                        <form:input path="headertel" id="headertel" htmlEscape="false" maxlength="50"
                                    cssClass="required" class="table_2_left_input"/>
                    </td>
                    <td class="table_2_right">
                        <p>公司传真:</p>
                        <form:input path="companyfax" id="companyfax" htmlEscape="false" maxlength="50" class="table_2_left_input"/>
                    </td>
                </tr>
                <tr>
                    <td class="table_2_left">
                        <p><span class="star_red">*</span>联系人手机:</p>
                        <form:input path="companytel" id="companytel" htmlEscape="false" maxlength="50"
                                    cssClass="required" class="table_2_left_input"/>
                    </td>
                    <td class="table_2_right">
                        <p>联系QQ:</p>
                        <form:input path="companyqq" id="companyqq" htmlEscape="false" maxlength="50" class="table_2_left_input"/>
                    </td>
                </tr>
                <tr>
                    <td colspan=2 style="text-align: center;">
                        <button class="btn btn-warning btn-warnings1" type="button" id="btn-warning">保存</button>
                    </td>
                </tr>
            </table>
        </div>
    </form:form>
</div>


<script src="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script>
	$(".qiye_menu li").removeClass("qiye_menu_1")
    $(".qiye_menu li").eq(0).addClass("qiye_menu_1");
    var msg = '${msg}';
    if (msg != '') {
        $.MsgBox.Alert("保存提示",'${msg}');
    }
    
    
    //页面加载路线数据
    if ('${userCompany.mainline}' != '') {
        var mainline = '${userCompany.mainline}';
        var array = mainline.split('|');//获取所有线路以|符号分割
        //判断分割后的路线是否为空
        if (array != null && array != '' && array != undefined) {
            //循环分割后的路线
            for (var i = 0; i < array.length; i++) {
                //获取每组路线信息
                var linearray = array[i].split(';');
                //判断当前获取的路线对象是否为空
                if (linearray != null && linearray != '' && linearray != undefined) {
                    //判断是否地是否为空
                    if (linearray[0] != '') {
                        $(".mainline" + i + "").find("input[name='frommainline']").val(linearray[0]);
                    }
                    //判断目的地是否为空
                    if (linearray[1] != '') {
                        $(".mainline" + i + "").find("input[name='tomainline']").val(linearray[1]);
                    }
                    $(".mainline" + i + "").show();//显示当前路线
                    //如果三条路线都已经添加隐藏添加路线按钮
                    if (i == 2) {
                        $(this).hide();
                        $(".addMainline").hide();
                    }
                }
            }
        } else {
            var linearray = mainline.split(';');
            //判断当前获取的路线对象是否为空
            if (linearray != null && linearray != '' && linearray != undefined) {
                //判断是否地是否为空
                if (linearray[0] != '') {
                    $(".mainline0").find("input[name='frommainline']").val(linearray[0]);
                }
                //判断目的地是否为空
                if (linearray[1] != '') {
                    $(".mainline0").find("input[name='tomainline']").val(linearray[1]);
                }
            }
        }

    }
    //删除主营路径
    $(".delete").click(function () {
        $(this).parent().children("input").val('');
        $(this).parents("tr").css("display", "none");
        $("#addMainline").show();
        $(".addMainline").show();
    });

    //企业基本信息保存时触发
    $(".btn-warnings1").click(function () {
        //线路集合
        var mainlinelist = "";
        //创建循环获取线路数据
        for (var i = 0; i < 3; i++) {
            //始发地
            var frommainline = "";
            //目的地
            var tomainline = "";
            //判断当前的线路是否是显示状态
            if ($(".mainline" + i + "").css("display") != "none") {
                frommainline = $(".mainline" + i + "").find("input[name='frommainline']").val();//获取始发地
                tomainline = $(".mainline" + i + "").find("input[name='tomainline']").val();//获取目的地
            }
            if (frommainline != '' || tomainline != "") {
                mainlinelist += frommainline + ";" + tomainline + "|";
            }
            if (i < 2) {
                mainlinelist + "|";
            }
        }
        $("#mainline").val(mainlinelist);
        //验证
        var isnul = true;
        isnul = isnul && $("#companyname").valid({
                    methods: "required"
                });
        isnul = isnul && $("#legalperson").valid({
                    methods: "required|ischinese"
                });
        isnul = isnul && $("#legalidcardnum").valid({
                    methods: "required|isIDCard"
                });
        isnul = isnul && $("#setuptime").valid({
                    methods: "required"
                });
        isnul = isnul && $("#provinceCityDistrict").valid({
                    methods: "required"
                });
        isnul = isnul && $("#companyaddress").valid({
                    methods: "required"
                });
        if ($("#homepageurl").val() != "" && $("#homepageurl").val() != null) {
            isnul = isnul && $("#homepageurl").valid({
                        methods: "isURL"
                    });
        }
        if($("#headertel").val()!=""&&$("#headertel").val()!=null){
        	isnul = isnul && $("#headertel").valid({
                methods: "isTel"
            });
        }
        

        isnul = isnul && $("#companytel").valid({
                    methods: "required|isPhone"
                });

        if ($("#companyqq").val() != "" && $("#companyqq").val() != null) {
            isnul = isnul && $("#companyqq").valid({
                        methods: "isQQ"
                    });
        }

        if (!isnul) {
            return false;
        }
        $(".btn-warnings1").attr('disabled', 'disabled');
        $("#inputForm1").submit();


    });

    $(".qiye_menu li").on("click", function () {
        $(".qiye_menu li").removeClass("qiye_menu_1")
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
    //判断是否是认证信息
    		var status = '${userCompany.status}';
			if (status == '1' || status == '2') {
				$("#companyname").attr("readonly", "true");
				$("#legalperson").attr("readonly", "true");
				$("#provinceCityDistrict").attr("disabled", "disabled");
				$("#companyaddress").attr("readonly", "true");
	
			}
    

    //添加主营路线
    $("#addMainline").click(function () {
        for (var i = 0; i < 3; i++) {
            if (i == 2) {
                $(this).hide();
                $(".addMainline").hide();
            }

            if ($(".mainline" + i + "").css("display") == "none") {
                $(".mainline" + i + "").show();
                //重新设置父级高度
                //top.$("#rightFrame").height(0); //用于每次刷新时控制IFRAME高度初始化
                var height = top.$("#rightFrame").contents().height() + 50;
                top.$("#rightFrame").height(height < 500 ? 500 : height);
                break;
            }

        }

    });

    //主营路线始发地与目的地加载地址控件
    initAddress("#frommainline1");
    initAddress("#frommainline2");
    initAddress("#frommainline3");
    initAddress("#tomainline1");
    initAddress("#tomainline2");
    initAddress("#tomainline3");
    //公司地址加载地址控件
    initAddress("#provinceCityDistrict");
    //設置地址插件
    function initAddress(id) {
        $(id).PCC({
            hasCounty: true,
            width: 360,
            height: 220,
            url: "${wlpt}/wlpt/chinaarea/getArea",
            closeIcon: "/static/images/close_hover.png",
            complete: function (data) {
                var str = "";
                if (data.province) {
                    str += data.province.NAME + "";
                    $(id).val(str);
                }
                if (data.city) {
                    str += data.city.NAME + "";
                    $(id).val(str);
                }
                if (data.county) {
                    str += data.county.NAME + "";
                    $(id).val(str);
                }
                if (str != "") {
                    $(id).val(str);
                } else {
                    $(id).val("");
                }

            }
        });
    }

</script>
</body>
</html>