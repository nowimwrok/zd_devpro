<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="">
    <title>--车源大厅</title>

    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">

    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/weixin/errorpage.js"></script>
    <script>
        var _hmt = _hmt || [];
        (function () {
            var hm = document.createElement("script");
            hm.src = "//hm.baidu.com/hm.js?5965b730f48f9552ac03adf379e97aa1";
            var s = document.getElementsByTagName("script")[0];
            s.parentNode.insertBefore(hm, s);
        })();
    </script>

    <link href="${pageContext.request.contextPath}/static/css/weixin/global.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/static/css/weixin/infoHall.css" rel="stylesheet" type="text/css">
    <style type="text/css">

        .search_top {
            height: 82px;
        }

        .result_bottom {
            height: 30px;
        }

        .address_input {
            width: 100%;
        }

        #searchInfo {
            border-radius: 5px;
            margin-top: 10px;
            text-align: center;
        }

        #search{
            margin-top: 3px;
        }

        .data_box {
            margin-top: 90px;
        }

        .hot_play span.qiang {
            background: url("${pageContext.request.contextPath}/static/img/qiang.gif") no-repeat;
            background-size: 100%;
        }

        .hot_play span.pai {
            background: url("${pageContext.request.contextPath}/static/img/pai.gif") no-repeat;
            background-size: 100%;
        }
#data_box,#data_add {
	width: 100%;
	margin:0 auto;
	margin-top: 84px;
	margin-bottom: 10px;
	background-color: #EBEBEB;
}
.search_ul{
	background-color:#EBEBEB;
}
.li_txt {
	width:40%;
}
.goods_icons {
	margin: 5px 0;
}

.icons {
	margin: 5px 0;
}
    </style>
</head>

<body style="background-color:#EBEBEB;">
	<div class="search_top top">
		<div class="search_ul" style="width:100%;margin:0px auto;">
<input type="hidden" id="loginPhone" value="${sessionScope.USERPD.PHONE}"/>
			<div style="width:100%;height:100%;">
			<div style="width:75%;height:100%;float:left;">
			<div style="width:96%;height:100%;float:left;">
				<input class="li_txt" type="text" id="fromAddress"
					readonly="readonly" placeholder="请选择省市" /> <img
					style="float:left; margin-top:2px;width:30px;"
					src="${pageContext.request.contextPath}/static/images/commom/wlpt/imgs/switch_btn.png" /><input
					class="li_txt" type="text" id="toAddress" readonly="readonly"
					placeholder="请选择省市" />
			</div>
					
			</div>
			<div style="width:25%;height:100%;float:left;">
			<div id="search" style="height:30px;text-align:center;line-height:30px;float:left;width:90%;">搜索</div>
			</div>
			</div>
			<div style="width:100%;background-color:white;">
				<input type="text" id="searchInfo" placeholder="车牌号/手机号码"
					style="width:66%;float:left;margin:7px 18%;height:26px;line-height:26px;border:1px solid #EBEBEB;" />
				<div style="width:34%;float:left">
					
					<input id="Fpro" type="hidden" value="" /><input id="FCity"
						type="hidden" value="" /> <input id="Tpro" type="hidden" value="" /><input
						id="TCity" type="hidden" value="" />
				</div>
<%-- 				<div style="width:21.5%;float:right">
				<div id="search2"
						style="height:35px;text-align:center;line-height:35px;"><a style="display:block;width:100%;" href="${pageContext.request.contextPath}/weixin/carSource/carSource_adds"><span style="color:#FFFFFF;">发布</span></a></div>
				</div> --%>
			</div>
		</div>
	</div>
<div id="data_box" class="data_box">
</div>
<div id="data_add" style="display:none;margin-top:50px;background:#FFF;">
</div>
<div id='loading'
     style='width:100%;display:none;vertical-align: middle;text-align:center;height:45px'>
    <div>
        <img src='static/images/loading-30x30.gif'>
    </div>
    <div style="font-size:14px;font-weight:bold;" id="loadtext">加载中……</div>
</div>
<div id="pages" style="display:none;">
    <span id="firstPage"><a>首页</a></span> <span id="previewPage"><a>上一页</a></span>
    <span id="nextPage"><a>下一页</a></span> <span id="lastPage"><a>尾页</a></span>
		<span id="pageInfo"><span>第</span><b id="curPage">1</b><span>页/共</span><b
                id="pageCount">1</b><span>页</span> </span>
</div>
<div class="search_top result_bottom bottom">
    共<b id="totalCount">0</b>条信息
</div>
<input type="hidden" id="loginPhone" value="${sessionScope.USERPD.PHONE}"/>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery-1.7.2.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/weixin/jquery.pcc.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/weixin/jquery.touchSwipe.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/include/jqthumb.min.js"></script>
<script type="text/javascript">
    $("#loading").show();
    $(function () {
        //条件
        var tab_i = 0;
        var searchConditions = {};
        searchConditions.SHOWCOUNT = 10;
        searchConditions.CURRENTPAGE = 1;
        searchData(1);
        var nowpage = 1; ///当前页数
        var nowcount = 1;
        //------------------------------------------------
        $(".data_tab div").click(function () {
            tab_i = $(this).index();
            $(this).addClass("selected");
            $(".data_tab div").not(this).removeClass("selected");
            if (tab_i == 0) {
                $("#data_add").hide();
                $("#data_box").show();
                $(".result_bottom").show();
            } else {
                $("#data_add").show();
                $("#data_box").hide();
                $(".result_bottom").hide();
                window.href = "${pageContext.request.contextPath}/weixin/carSource/carSource_adds";
            }
        });
        //按地址条件查询
        $("#search").click(
                function () {
                    /* 						searchConditions.FROMADDRESS = $("#fromAddress").val()
                     .replace(" ", "");
                     searchConditions.TOADDRESS = $("#toAddress").val()
                     .replace(" ", "");
                     ; */
                    searchConditions.fromCity = $("#FCity").val();
                    searchConditions.fromProvince = $("#Fpro").val();
                    searchConditions.toCity = $("#TCity").val();
                    searchConditions.toProvince = $("#Tpro").val();
                    searchConditions.carNumberOrMobile = $("#searchInfo").val();
                    $("#data_box").html("");
                    searchData(1);
                });
        /* $("body").scroll(function(){
         alert("---");
         var winPos = $(ducument).scrollTop();
         }); */
        $(window).scroll(function () {
            if (tab_i == 1) {
                return;
            }
            var curPageNo = $("#curPage").html();
            var pageCount = $("#pageCount").html();
            //下面这句主要是获取网页的总高度，主要是考虑兼容性所以把Ie支持的documentElement也写了，这个方法至少支持IE8
            var htmlHeight = document.body.scrollHeight
                    || document.documentElement.scrollHeight;
            //clientHeight是网页在浏览器中的可视高度，
            var clientHeight = document.body.clientHeight
                    || document.documentElement.clientHeight;
            //scrollTop是浏览器滚动条的top位置，
            var scrollTop = document.body.scrollTop
                    || document.documentElement.scrollTop;
            //通过判断滚动条的top位置与可视网页之和与整个网页的高度是否相等来决定是否加载内容；
            if (scrollTop + clientHeight == htmlHeight) {
                nowpage += 1;
                if (nowpage <= parseInt(pageCount)) {
                    searchData(nowpage);
                }

            }
        });
        //类型查询
        $(".contype_per .contype").first().css("color", "#3592E2");
        $(".contype_per .contype").click(function () {
            $(this).css("color", "#3592E2");
            var type = $(this).index() / 2;
            searchConditions.BIDDINGSTATUS = type;
            if (type <= 0) {
                searchConditions = {};
                searchConditions.SHOWCOUNT = 10;
                searchConditions.CURRENTPAGE = 1;
            }
            $(".contype_per .contype").not(this).css("color", "#000");
            $("#data_box").html("");
            searchData(1);
        });
        //查询数据ajax
        function searchData(currentPage) {
            $("#loading").show();
            $("#page").hide();
            //$("#data_box").html("");
            searchConditions.CURRENTPAGE = currentPage;
            /* searchConditions.RE="trues"; */
            $.ajax({
                type: "POST",
                url: '${pageContext.request.contextPath}/weixin/car/getCarlist',
                data: searchConditions,
                dataType: 'json',
                cache: false,
                success: function (data) {
                    if (data.state == "1") {
                        if (data.data.LIST.length <= 0) {
                            $("#data_box").show().append('<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
                        } else {
                            $("#page").show();
                            nowcount = data.data.TOTALCOUNT;
                            $("#pageCount").html(
                                    data.data.PAGECOUNT);
                            //$("#allCount").html(data.data.ALLCOUNT);
                            $("#curPage").html(
                                    searchConditions.CURRENTPAGE);
                            $("#totalCount").html(nowcount);
                            var fillDatas = "";
                            for (var i = 0; i < data.data.LIST.length; i++) {
                                fillDatas += fillDataOne(data.data.LIST[i]);
                            }
                            /* $("#data_box").html(""); */
                            $("#data_box").append(fillDatas);
                            $('.hedImg img').jqthumb({
                                width: 40,
                                height: 40,
                                after: function (imgObj) {
                                    imgObj.css('opacity', 0).animate({opacity: 1}, 1000);
                                }
                            });
                            $(".hedImg").removeClass("hedImg");
                        }
                    } else {
                        $("#data_box").html("");
                        $("#data_box").show().append('<p style="text-align: center;height: 30px;font-size: 1.1em;color: #F26522;padding-top:100px">暂无数据...</p>');
                    }
                    $("#loading").css('display', 'none');
                    $("#loading").hide();
                }
            });
        }

        /***************填充到页面的数据***************/
        function fillDataOne(data) {
            var from = (data.FROMPROVINCE != null ? data.FROMPROVINCE : "") + (data.FROMCITY != null ? data.FROMCITY : "") + (data.FROMDISTRICT != null ? data.FROMDISTRICT : "");
            var to = (data.TOPROVINCE != null ? data.TOPROVINCE : "") + (data.TOCITY != null ? data.TOCITY : "") + (data.TODISTRICT != null ? data.TODISTRICT : "");
            var name = ((data.CONTACTNAME) != null ? (data.CONTACTNAME) : (data.NAME != null ? data.NAME : data.COMPANYNAME));
            if (name.length >= 5) {
                name = name.substr(0, 5) + "..";
            }
            var headurl = '<div class="hot_play"><ul><li><img class="car_icons goods_icons" alt="货主"	src="${pageContext.request.contextPath}/static/images/weixin/icon_personal.png"/></li></ul><</div>';
            if (data.HEADPHOTOURL != null && data.HEADPHOTOURL != "") {
                headurl = '<div class="hot_play"><ul><li><img class="car_icons goods_icons" alt="货主"	src="${pageContext.request.contextPath}/upload/' + data.HEADPHOTOURL + '"/></li></ul></div>';
            } else {
                headurl = '<div class="hot_play"><ul><li><img class="car_icons goods_icons" alt="货主"	src="${pageContext.request.contextPath}/static/images/weixin/ic_user.png"/></li></ul></div>';
            }
            var html = '<div class="data_div" style="margin-top: 10px;" onclick="datasEdit(' + "'"
                    + data.CARID
                    + "'"
                    + ')">'
                    + '<div class="data_rows car_rows">'
                    + '<div class="drw_left">'
                    + headurl
                    + '</div><!-- drw_left end -->'
                    + '<div class="drw_middle">'
                    + '<div class="dm_top">'
                    + '<div class="font_weight font15">' + name + " " + '(' + (data.CARNUMBER != null ? data.CARNUMBER : "") + ')' + '</div>'
                    + '</div><!-- dm_top -->'
                    + '<div class="dm_middle">'
                    + '<div class=" font14 ">' + (data.MAINROAD != null ? data.MAINROAD : "暂无") + '</div>'
                    + '</div>'
                    + '<div class="dm_bottom font12">'
                    + data.CARLENGTH + '米' + '&nbsp;&nbsp;' + data.CARTYPE + '&nbsp;&nbsp;' + data.LOADWEIGHT
                    + '吨</div><!-- dm_bottom -->'
                    + '</div><!-- drw_middle end -->'
                    + '<div class="drw_right">'
                    + '<a href="javascript:callPhone(' + data.PHONE + ')"><img class="icons" alt="电话" src="${pageContext.request.contextPath}/static/img/call.png"></a>'
                    + '</div><!-- drw_right end -->'
                    + '</div><!-- data_rows end -->'
                    + '</div>';

            return html;
        }

        window.callPhone = function (phone) {
            if ($("#loginPhone").val() != null && $("#loginPhone").val() != "") {
                window.location.href = "tel:" + phone;
            }
        };
        window.datasEdit = function (id) {
            if ($("#loginPhone").val() != null && $("#loginPhone").val() != "") {
                window.location.href = "/weixin/car/car_detail?CARID=" + id;
            } else {
                alert("请先绑定或注册新的账号");
            }
        };


        //---------------------------------地址数据
        $("#fromAddress").PCC({
            hasCounty: false,
            width: "94%",
            height: 320,
            url: "${pageContext.request.contextPath}/wlpt/area/getarea",
            closeIcon: "static/images/pic12.gif",
            complete: function (data) {
                var str = "";
                searchConditions.FROMADDRESS = '';
                searchConditions.fromCity = '';
                searchConditions.fromProvince = '';
                if (data.province) {
                    str += data.province.NAME + " ";
                    searchConditions.fromProvince = data.province.NAME;
                    $("#Fpro").val(data.province.NAME);
                }
                if (data.city) {
                    if (data.city.NAME != data.province.NAME) {
                        str += data.city.NAME;
                        searchConditions.fromCity = data.city.NAME;
                        $("#FCity").val(data.city.NAME);
                    }
                }
                if (str != " ") {
                    $("#fromAddress").val(str);
                } else {
                    $("#fromAddress").val("");
                }
            }
        });

        $("#toAddress").PCC({
            hasCounty: false,
            width: "94%",
            height: 320,
            url: "${pageContext.request.contextPath}/wlpt/area/getarea",
            closeIcon: "static/images/pic12.gif",
            location: "left",
            ismiddle: true,
            complete: function (data) {
                var str = "";
                searchConditions.TOADDRESS = '';
                searchConditions.toCity = '';
                searchConditions.toProvince = '';
                if (data.province) {
                    str += data.province.NAME + " ";
                    searchConditions.toProvince = data.province.NAME;
                    $("#Tpro").val(data.province.NAME);
                }
                if (data.city) {

                    if (data.city.NAME != data.province.NAME) {
                        str += data.city.NAME;
                        searchConditions.toCity = data.city.NAME;
                        $("#TCity").val(data.city.NAME);
                    }
                }
                if (str != " ") {
                    $("#toAddress").val(str);
                } else {
                    $("#toAddress").val("");
                }
                /* searchGoods(1); */
            }
        });
    });
</script>
</body>
</html>
