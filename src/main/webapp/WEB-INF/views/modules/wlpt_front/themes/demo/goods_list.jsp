<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_personal_basic"/>
    <title>个人中心</title>
    <style type="text/css">

    </style>
</head>
<body style="background: #f5f5f5;">

<div>
    <div class="row">
        <div class="col-sm-12">
            <div class="panel">
                <div class="form_container">
                    <h4 class="panel-heading ">货源管理</h4>
                </div>
                <div class="panel-body">
                    <div class="col-lg-12 search_wrap">
                        <div class="col-sm-2">
                            <input class="form-control" placeholder="出发地">
                        </div>
                        <div class="col-sm-2">
                            <input class="form-control" placeholder="目的地">
                        </div>
                        <div class="col-sm-2">
                            <select class="form-control">
                                <option>全部</option>
                                <option>已报价</option>
                                <option>未报价</option>
                            </select>
                        </div>
                        <div class="col-sm-2 btn-search-wrap">
                            <button class="btn btn-primary" style="width: 128px;"><i class="fa fa-search white"></i> 搜索
                            </button>
                        </div>
                        <div class="col-sm-2">
                            <a class="btn btn-success" href="${wlpt}/goods_add">
                                <i class="fa fa-plus-square white"> </i> 发布货源</a>
                        </div>
                    </div>
                    <table class="table" id="goods_list">
                        <thead>
                        <tr>
                            <th>货物名称</th>
                            <th>重量/体积</th>
                            <th>始发地-目的地</th>
                            <th>发货日期</th>
                            <th>报价信息</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>内贸卷</td>
                            <td>96.803吨<span class="vertical-line">|</span> 剩余:87.803吨</td>
                            <td>邯郸市复兴区→天津市塘沽区</td>
                            <td>2017-04-14</td>
                            <td>1人报价</td>
                            <td>
                                <a href="per_goods_det.html" class="see oprate">详情</a>
                                <a href="${wlpt}/goods_quotelist" class="green oprate">查看报价</a>
                                <a href="add_quote.html" class="orange oprate">添加报价</a>
                            </td>
                        </tr>
                        <tr>
                            <td>内贸卷</td>
                            <td>92.3吨<span class="vertical-line">|</span> 剩余:17.803吨</td>
                            <td>邯郸市复兴区→天津市塘沽区</td>
                            <td>2017-03-10</td>
                            <td>2人报价</td>
                            <td>
                                <a href="per_goods_det.html" class="see oprate">详情</a>
                                <a href="${wlpt}/goods_quotelist" class="green oprate">查看报价</a>
                                <a href="add_quote.html" class="orange oprate">添加报价</a>
                            </td>
                        </tr>
                        <tr>
                            <td>外贸卷</td>
                            <td>32.003吨<span class="vertical-line">|</span> 剩余:0.000吨</td>
                            <td>邯郸市复兴区→天津市塘沽区</td>
                            <td>2016-10-21</td>
                            <td>1人报价</td>
                            <td>
                                <a href="per_goods_det.html" class="see oprate">详情</a>
                                <a href="${wlpt}/goods_quotelist" class="green oprate">查看报价</a>
                                <a href="add_quote.html" class="orange oprate">添加报价</a>
                            </td>
                        </tr>
                        <tr>
                            <td>内贸卷</td>
                            <td>92.803吨<span class="vertical-line">|</span> 剩余:21.803吨</td>
                            <td>邯郸市复兴区→天津市塘沽区</td>
                            <td>2016-10-14</td>
                            <td>1人报价</td>
                            <td>
                                <a href="per_goods_det.html" class="see oprate">详情</a>
                                <a href="view_quote.html" class="green oprate">查看报价</a>
                            </td>
                        </tr>
                        <tr>
                            <td>内贸卷</td>
                            <td>98.621吨<span class="vertical-line">|</span> 剩余:09.435吨</td>
                            <td>邯郸市复兴区→天津市塘沽区</td>
                            <td>2016-10-14</td>
                            <td>1人报价</td>
                            <td>
                                <a href="per_goods_det.html" class="see oprate">详情</a>
                                <a href="view_quote.html" class="green oprate">查看报价</a>
                            </td>
                        </tr>
                        <tr>
                            <td>内贸卷</td>
                            <td>96.803吨<span class="vertical-line">|</span> 剩余:87.803吨</td>
                            <td>邯郸市复兴区→天津市塘沽区</td>
                            <td>2016-10-14</td>
                            <td>1人报价</td>
                            <td>
                                <a href="per_goods_det.html" class="see oprate">详情</a>
                                <a href="view_quote.html" class="green oprate">查看报价</a>
                            </td>
                        </tr>
                        <tr>
                            <td>内贸卷</td>
                            <td>109.803吨<span class="vertical-line">|</span> 剩余:27.803吨</td>
                            <td>邯郸市复兴区→天津市塘沽区</td>
                            <td>2016-10-14</td>
                            <td>1人报价</td>
                            <td>
                                <a href="per_goods_det.html" class="see oprate">详情</a>
                                <a href="view_quote.html" class="green oprate">查看报价</a>
                                <a href="add_quote.html" class="orange oprate">添加报价</a>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6" class="text-center">
                                <img src="${ctxStatic }/front/img/nodata.png" style="width: 100px;height: 100px;">
                            </td>
                        </tr>
                        </tbody>
                    </table>

                </div>
            </div>
        </div>
    </div>
</div>


<script>

    $("#goods_list").bootstrapTable({
        pagination:true,
        pageSize:5
    });
</script>
</body>
</html>
