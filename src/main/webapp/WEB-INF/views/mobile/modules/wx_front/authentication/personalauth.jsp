<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">

    <title>个人认证</title>

    <meta name="viewport"
          content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">

    <script type="text/javascript" src="static/js/weixin/errorpage.js"></script>
    <link href="static/css/weixin/personalcertificate.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
    <script>
        var _hmt = _hmt || [];
        (function() {
            var hm = document.createElement("script");
            hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>


    <script type="text/javascript">
        var userID = '<%=request.getParameter("userID")%>';
        window.onload = function () {
            if ("" != userID) {
                $.ajax({
                    type: "POST",
                    url: 'weixin/getJSSign',
                    data: {Url: encodeURIComponent(location.href.split('#')[0])},
                    dataType: 'json',
                    cache: false,
                    success: function (data) {
                        var appID = data.appId;
                        var nonceStr = data.nonceStr;
                        var timestamp = data.timestamp;
                        var signature = data.signature;
                        wx.config({
                            debug: false,
                            appId: appID,
                            timestamp: timestamp,
                            nonceStr: nonceStr,
                            signature: signature,
                            jsApiList: ['checkJsApi', 'chooseImage', 'uploadImage', 'downloadImage']
                        });
                    }
                });
            }
            var idCardPic = '${pd.idCardPic}';
            if ("" != idCardPic) {    /* 显示图片 */
                $(".photo_identify").show();
            }
        }
    </script>
</head>

<body>
<div class="for_title"><img class="backhost" src="static/images/weixin/back_history.png"/><span
        class="title">个人认证</span></div>
<div class="divbox">
    <div class="b_border com_height"><span>真实姓名</span>
        <input type="text" id="name" name="NAME" value="${pd.name}" placeholder="请输入您的姓名" maxlength="18"/>
        <input type="hidden" id="userID" value="${pd.userID}"/>
    </div>
    <div class="b_border com_height"><span>手机号</span><input type="text" id="phone" name="PHONE" value="${pd.phone}"
                                                            readonly="readonly" placeholder="请输入您的手机号" maxlength="11"/>
    </div>
    <div class="b_border com_height"><span>身份证号码</span><input type="text" id="identfy" name="IDENTIFY"
                                                              value="${pd.idCardNum}" placeholder="请输入您的身份证号码"
                                                              maxlength="18"/></div>
    <div class="b_border upload_pic"><span>上传身份证/驾驶证图片</span>
        <div id="for_img" class="for_img" title="请上传身份证号/驾驶证号"></div>
    </div>
    <div class="photo_identify">
        <img class="photo_img" src="./upload/${pd.idCardPic}"/>
        <input type="hidden" id="idCardID" value="${pd.idCardID}"/>
    </div>
    <div class="last_div">
        <p class="fortreaty">
            <span class="side">✔</span> 同意 <a
                href="${pageContext.request.contextPath}/wlpt/agreement/AgreementInfo.do?AGREEMENT_ID=${pd.agreementID}"
                target="_blank" class="treaty">${pd.agreementName}</a></p>
        <p class="forprompt"><span class="prompt">认证通过后，发布信息可以优先展示到平台</span></p>
        <p id="submit" style="background-color:rgba(32, 134, 226,1)">申请认证</p>
    </div>
</div>
<div id="erro"><p style="text-align: center;margin-top: 250px;color:#FFF;">请输入正确的身份证号码</p></div>
<script type="text/javascript" src="static/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.tips.js"></script>
<script type="text/javascript">
    /* 选择图片 */
    var images = {localId: [], serverId: []};
    $(".for_img").click(function () {
        wx.chooseImage({
            count: 1,
            success: function (res) {
                images.localId = res.localIds; // 返回选定照片的本地ID列表，localId可以作为img标签的src属性显示图片
                $(".photo_identify").show();
                $(".photo_img").attr("src", images.localId[0]);
            }
        });
    });

    /*上传图片*/
    var imageInfo = "";
    function uploadImg() {
        if (images.localId.length == 0) {
            $("#for_img").tips({
                side: 3,
                msg: "请选择图片！",
                bg: '#FF5080',
                time: 3
            });
            return;
        }
        var i = 0, length = images.localId.length;

        function upload() {
            wx.uploadImage({
                localId: images.localId[i],
                success: function (res) {
                    images.serverId.push(res.serverId);
                    $.ajax({
                        type: "POST",
                        url: 'weixin/downloadImg',
                        data: {ServerID: images.serverId[i]},
                        dataType: 'json',
                        cache: false,
                        success: function (data) {
                            if (data) {
                                if (length == images.serverId.length) {
                                    imageInfo = images.serverId[0] + ".jpg";
                                    submit();
                                }
                            } else {
                                $("#for_img").tips({
                                    side: 3,
                                    msg: "上传证件失败！",
                                    bg: '#FF5080',
                                    time: 3
                                });
                            }
                        }
                    });
                    i++;
                    if (i < length) {
                        upload();
                    }
                },
                fail: function (res) {
                    $("#for_img").tips({
                        side: 3,
                        msg: "上传证件失败！",
                        bg: '#FF5080',
                        time: 3
                    });
                }
            });
        }

        upload();
    }
    $(function () {
        //bool判断是否同意协议
        var bool = true;

        $(".side").toggle(function () {
            $(this).text("").css({background: "#fff", border: "1px solid #ccc"});
            bool = false;
        }, function () {
            $(this).text("✔").css({background: "#FF9001", border: "1px solid #FF9001"});
            bool = true;
        });
        //返回上一页
        $(".backhost").click(function () {
            window.history.go(-1);
        });

        //提交表单
        $("#submit").click(function () {
            if (bool) {
                if (check()) {
                    var ph = $("#phone").val().trim();
                    var icard = $("#identfy").val().trim();
                    var reg = /^(((13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9]))+\d{8})$/;
                    var ireg = /^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{4}$/;
                    if (reg.test(ph) && ireg.test(icard)) {
                        if (images.localId.length == 1) {
                            uploadImg();
                        } else {
                            $("#for_img").tips({
                                side: 3,
                                msg: "请选择图片！",
                                bg: '#FF5080',
                                time: 3
                            });
                        }
                    } else {
                        $("#erro").show();
                        setTimeout(function () {
                            $("#erro").fadeOut(3000);
                        }, 1000);
                    }
                }
            }
        });
    });

    /* 提交数据 */
    function submit() {
        var p = $("#phone").val().trim();
        var i = $("#identfy").val().trim();
        var n = $("#name").val().trim();
        var id = $("#userID").val().trim();
        var idCardID = $("#idCardID").val().trim();
        $.ajax({
            type: "POST",
            url: 'weixin/applyPersonalAuth',
            data: {
                USER_ID: id,
                NAME: n,
                PHONE: p,
                IdentityCard: i,
                SLOCALPHOTO: imageInfo,
                idCardID: idCardID
            },
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data.msg == "ok") {
                    /* window.location.href="weixin/personalinfo?openID=" + data.openID;  */
                    window.location.href = "${wx}/weixin/user/userHome";
                }
            }
        });
    }

    function check() {
        var isnul = true;
        $("input[type='text']").each(function () {
            if (isnul) {
                if (!$(this).val()) {
                    var msg = $(this).attr("placeholder");
                    $(this).focus().tips({
                        side: 3,
                        msg: msg,
                        bg: '#FF5080',
                        time: 3
                    });
                    isnul = false;
                }
            }
        });
        return isnul;
    }
</script>
</body>
</html>
