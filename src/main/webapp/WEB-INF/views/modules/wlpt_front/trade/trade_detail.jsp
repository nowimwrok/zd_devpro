<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_personal_basic"/>

    <title>运单详情</title>


    <link rel="stylesheet" type="text/css" href="${ctxStatic}/modules/wlpt/front/css/personal.css">

    <style type="text/css">
        body {
            padding: 0;
            margin: 0;
            width: 100%;
            margin: 0 auto;
            text-align: center;
            border: 1px solid #D6D3CE;
            font-family: "微软雅黑";
        }

        ul p span a input td {
            font-family: "微软雅黑";
        }

        .tab_div {
            width: 95%;
            height: 35px;
            margin-top: 5px;
            float: right;
            clear: both;
            border-bottom: solid 1px #CCC;
            line-height: 35px;
            margin-bottom: 20px;
        }

        .tab_left {
            width: 60%;
            float: left;
        }

        .tab_right {
            width: 30%;
            float: right;
            text-align: right;
            border: none;
        }

        .tab_left .tab_nav {
            width: 100%;
            margin-top: -2px;
            padding: 0px;
        }

        .tab_nav li {
            float: left;
            width: 20%;
            text-align: center;
            cursor: pointer;
        }
        .tab_nav li:hover {
            border-bottom: 3px solid #00a2e9;
        }
        .liselect {
            border-bottom: 3px solid #00a2e9;
        }


        .cb_val div {
            float: left;
            word-wrap: break-word;
        }

        .ct_lf div {
            float: left;
            margin-right: 5px;
            line-height: 30px;
            display: table-cell;
            vertical-align: middle;
            display: table-cell;
            font-size: 16px;
            text-align: left;
        }

        .img_text img {
            width: 60px;
            height: 60px;
        }

        .ct_lf div {
            float: left;
            margin-right: 5px;
            line-height: 30px;
            display: table-cell;
            vertical-align: middle;
            display: table-cell;
            font-size: 16px;
        }

        .ic_img img {
            width: 25px;
            display: table-cell;
            vertical-align: middle;
            display: table-cell;
        }

        .cb_val div {
            float: left;
            word-wrap: break-word;
            text-align: left;
        }

        .ratings li {
            height: 40px;
            line-height: 40px;
        }

        .lift li {
            float: left;
            margin-right: 15px;
        }

        .timeline-content p {
            width: 100%;
            border-top: 1px solid #CCC;
            padding-top: 5px;
            text-align: left;
        }

        h2 {
            font-size: 18px;
        }

        #timeline .timeline-item .timeline-content h2 {
            padding: 10px;
        }
    </style>
</head>
<body scroll="no">
<div class="table_2" style="background: #FFF;height: 100%;border: none;margin-top:0px;">
    <p class="user_data">
        <img src="${ctxStatic }/images/wlptfront/line-left.png"><span class="title_blue">运单</span><span class="title_orange">详情</span><img
            src="${ctxStatic }/images/wlptfront/line-right.png">
    </p>
    <div class="tab_div">
        <div class="tab_left">
            <ul class="tab_nav">
                <li id="trade_shadow" class="${empty urltype or urltype=='trade_shadow'?'liselect':'' }">运单跟踪</li>
                <li id="trade_track" class="${urltype=='trade_track'?'liselect':'' }">运输轨迹</li>
                <li id="trade_receipt" class="${urltype=='trade_receipt'?'liselect':'' }">运输凭证</li>
                <li id="trade_taklist" class="${urltype=='trade_taklist'?'liselect':'' }">回执单</li>
                <li id="to_ordercomment" class="${urltype=='to_ordercomment'?'liselect':'' }">评价</li>
            </ul>
        </div>
        <div class="tab_right">
            <p>运单号：${orderinfo.orderno}</p>
        </div>
    </div>

    <div class="sub-track printhide" style="display:block;height: 96%;">
        <iframe id="myFrame" src="${wlpt}/wlpt/trade/${empty urltype?'trade_shadow':urltype }?id=${orderinfo.id}" width="100%" scrolling="no" height="450px" frameborder="0"
                name="order_content" ></iframe>
    </div>
</div>

<script src="${ctxStatic}/jquery/jquery-1.9.1.min.js" type="text/javascript"></script>

<script>

    $(function () {
        var orderid="${orderinfo.id}";
        
        $(".tab_nav li").click(function () {
            $(".tab_nav li").removeClass("liselect");
            $(this).addClass("liselect");
            $("#myFrame").attr("src", "${wlpt}/wlpt/trade/"+$(this).attr("id")+"?id="+orderid);
        });
        $("#myFrame").load(function() {
    	  $(this).height(0); //用于每次刷新时控制IFRAME高度初始化
          var height = $(this).contents().height() + 10;
          $(this).height( height < 500 ? 500 : height );
          
          
          top.$("#rightFrame").height(0); //用于每次刷新时控制IFRAME高度初始化
          var heights =  $("#myFrame").height() + 210;
          top.$("#rightFrame").height( heights < 500 ? 500 : heights );
        }) 
       
    });
</script>
</body>
</html>
