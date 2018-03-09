<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>编辑地址</title>
    <link rel="stylesheet" type="text/css" href="/static/modules/wlpt/front/css/global_mainbody.css">
    <link rel="stylesheet" type="text/css" href="/static/modules/wlpt/front/css/personal.css">
    <link rel="stylesheet" type="text/css" href="/static/modules/wlpt/front/css/top_menu.css">
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/static/jquery-validation/1.11.0/jquery.validate.css">
    <style type="text/css">
        body {
            padding: 0;
            margin: 0;
            width: 100%;
            margin: 0 auto;
            text-align: center;
            border: 1px solid #D6D3CE;
            font-family: "微软雅黑"
        }

        input[type="text"] {
            width: 40%;
            text-indent: 5px;
            padding: 0px;
        }
        label.error {
            background: url("images/unchecked.gif") no-repeat 0px 10px;
            padding-left: 18px;
            padding-bottom: 2px;
            font-weight: bold;
            color: #EA5200;
            margin-left: 10px;
        }

    </style>


</head>
<body>
<p class="user_data">
    <img src="/static/images/wlptfront/line-left.png"><span class="title_blue">用户</span><span
        class="title_orange">资料</span><img src="${ctxStatic}/images/wlptfront/line-right.png">
</p>
<form:form id="inputForm" modelAttribute="address" method="post" action="${wlpt}/wlpt/address/save"
           class="form-horizontal">

    <form:hidden path="id"/>
    <sys:message content="${message}"/>
    <table class="user-infor">
        <tr>
            <td class="user_infor_left"><span class="star_red">*</span>地址类型:</td>
            <td class="user_infor_right">
                <form:radiobuttons path="type" items="${fns:getDictList('addressType')}" itemLabel="label"
                                   itemValue="value" htmlEscape="false" class=""/></td>
        </tr>

        <tr>
            <td class="user_infor_left"><span class="star_red">*</span>是否默认:</td>
            <td class="user_infor_right">
                <form:radiobuttons path="status" items="${fns:getDictList('addressStatus')}" itemLabel="label"
                                   itemValue="value" htmlEscape="false" class=""/>
            </td>
        </tr>
        <tr>
            <td class="user_infor_left"><span class="star_red">*</span>联系人:</td>
            <td class="user_infor_right">
                <form:input id="linkman" path="linkman" htmlEscape="false" value="${address.linkman!=null?address.linkman:user.name}"
                            maxlength="64" class="input-xlarge realName"/>

            </td>
        </tr>
        <tr>
            <td class="user_infor_left"><span class="star_red">*</span>公司名称:</td>
            <td class="user_infor_right">
                <form:input id="linkcompany" path="linkcompany" htmlEscape="false"
                            value="${address.linkcompany!=null?address.linkcompany:user.userinfo.companyname}"
                            maxlength="64" class="input-xlarge required"/>

            </td>
        </tr>
        <tr>
            <td class="user_infor_left"><span class="star_red">*</span>手机号码:</td>
            <td class="user_infor_right">
                <form:input id="linkmobile" path="linkmobile" htmlEscape="false"
                            value="${address.linkmobile!=null?address.linkmobile:user.phone}" maxlength="64"
                            class="input-xlarge mobile"/>

            </td>
        </tr>
        <tr>
            <td class="user_infor_left">固定电话:</td>
            <td class="user_infor_right">
                <form:input id="linktelphone" path="linktelphone" htmlEscape="false"
                            value="${address.linktelphone!=null?address.linktelphone:user.userinfo.telphone}"
                            maxlength="64" class="input-xlarge simplePhone"/>
            </td>
        </tr>
        <tr>
            <td class="user_infor_left">Email:</td>
            <td class="user_infor_right">
                    <form:input id="linkemail" path="linkemail" htmlEscape="false"
                                value="${address.linkemail!=null?address.linkemail:user.email}" maxlength="64"
                                class="input-xlarge email"/>
        </tr>
        <tr>
            <td class="user_infor_left"><span class="star_red">*</span>省市区:</td>
            <td class="user_infor_right">
                <input type="text" readonly="readonly" name="addressPCD" id="addressPCD"
                       value="${address.province}${address.city}${address.district}" htmlEscape="false" maxlength="64"
                       class="input-xlarge required "/>
                <form:hidden path="province" id="province" htmlEscape="false" maxlength="64" class="input-xlarge "/>
                <form:hidden path="city" id="city" htmlEscape="false" maxlength="64" class="input-xlarge "/>
                <form:hidden path="district" id="district" htmlEscape="false" maxlength="64" class="input-xlarge "/>
            </td>
        </tr>
        <tr>
            <td class="user_infor_left" style="vertical-align: text-top;"><span class="star_red">*</span>详细地址:</td>
            <td class="user_infor_right">
                <form:textarea id="address" path="address" cssStyle="margin-top: 5px" htmlEscape="false" cols="45" rows="4"
                               maxlength="255" class="input-xxlarge required"/>
            </td>
        </tr>

        <tr>
            <td colspan=2>
                <shiro:hasPermission name="wlpt:user:address:edit">
                    <button type="button" class="btn btn-defalut btn-warning" id="btn-warning">保存</button>
                </shiro:hasPermission>
            </td>
        </tr>
    </table>
</form:form>
</div>
<script src="${ctxStatic }/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script src="${ctxStatic }/bootstrap/2.3.1/js/bootstrap.min.js"></script>
<script src="/static/jquery-validation/1.11.0/jquery.validate.min.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.tips.js"></script>
<script type="text/javascript" src="${ctxStatic }/modules/wlpt/front/js/jquery.valid.js"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script type="text/javascript">
    $(function () {
        //$("#name").focus();
       // $("#inputForm").validate({
         //   submitHandler: function (form) {
         //       loading('正在提交，请稍等...');
         //       form.submit();
          //  },
           // errorContainer: "#messageBox",
           // errorPlacement: function (error, element) {
          //      $("#messageBox").text("输入有误，请先更正。");
          //      if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
          //          error.appendTo(element.parent().parent());
          //      } else {
           //         error.insertAfter(element);
           //     }
           // }
        //});
       $("#btn-warning").click(function() {
    	   var isnul = true;
			isnul = isnul && $("#linkman").valid(																		{
				methods : "required"
				});
			isnul = isnul && $("#linkcompany").valid(																		{
				methods : "required"
				});
			isnul = isnul && $("#linkmobile").valid(																		{
				methods : "required|isPhone"
				});
			if($("#linktelphone").val()!="" && $("#linktelphone").val()!=null){
			isnul = isnul && $("#linktelphone").valid(																		{
				methods : "isTel"
				});
			}
			if($("#linkemail").val()!="" && $("#linkemail").val()!=null){
			isnul = isnul && $("#linkemail").valid(																		{
				methods : "isEmail"
				});
			}
			isnul = isnul && $("#addressPCD").valid(																		{
				methods : "required"
				});
			isnul = isnul && $("#address").valid(																		{
				methods : "required"
				});
			if(isnul){
				$("#btn-warning").attr('disabled','disabled');
				$("#inputForm").submit();
			}
       });
 
        ///单选按钮第一个值选择
        $('input:radio').attr('checked', 'checked');
        function  save(){
            $.ajax({
                cache: true,
                type: "POST",
                url: "${wlpt}/wlpt/address/save",
                data: $('#inputForm').serialize(),// 你的formid
                async: false,
                error: function (request) {
                	$.MsgBox.Alert("系统提示","Connection error");
                },
                success: function (data) {
                	$.MsgBox.Alert("保存提示",data.message);
                    if (data.state == 1) {
                        window.location.href = "${wlpt}/wlpt/address/address_list"
                    }
                }
            });
        }




        $("#addressPCD").PCC({
            hasCounty: true,
            width: 360,
            height: 220,
            url: "${ctx}/wlpt/base/chinaarea/getArea",
            closeIcon: "/static/images/close_hover.png",
            complete: function (data) {
                var str = "";
                if (data.province) {
                    str += data.province.NAME + "";
                    $("#province").val(data.province.NAME);
                    $("#addressPCD").val(str);
                }
                if (data.city) {
                    str += data.city.NAME + "";
                    $("#city").val(data.city.NAME);
                    $("#addressPCD").val(str);
                }
                if (data.county) {
                    str += data.county.NAME;
                    $("#district").val(data.county.NAME);
                    $("#addressPCD").val(str);
                }
                if (str != "") {
                    $("#addressPCD").val(str);
                } else {
                    $("#addressPCD").val("");
                }

            }
        });

    });
</script>
</body>
</html>
