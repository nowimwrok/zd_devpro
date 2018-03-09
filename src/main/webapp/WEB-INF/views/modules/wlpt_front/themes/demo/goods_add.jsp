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

<div style="background: #f5f5f5;">

    <!--两列-->
    <div class="row edit-box">
        <div class="col-sm-12">
            <div class="panel clearfix">
                <div class="form_container">
                    <h4 class="panel-heading">
                        货源信息 (<span class="red">*</span>为必填项)
                    </h4>
                    <div class="col-sm-12 form-horizontal">
                        <div class="form-group col-sm-4">
                            <div class="col-sm-5 control-label text-right"><span class="red">*</span>货物名称</div>
                            <div class="col-sm-7 text-left">
                                <input class="form-control" placeholder="请输入货物名称">
                            </div>
                        </div>
                        <div class="form-group col-sm-4 has-unit">
                            <div class="col-sm-5 control-label text-right"><span class="red">*</span>货物重量</div>
                            <div class="col-sm-7 text-left">
                                <input class="form-control" value="">
                                <i class="unit">吨</i>
                            </div>
                        </div>
                        <!--下拉框-->
                        <div class="form-group col-sm-4">
                            <div class="col-lg-5 control-label text-right">货物类别</div>
                            <div class="col-lg-7 text-left">
                                <select class="form-control">
                                    <option>成品</option>
                                    <option>原材料</option>
                                    <option>轻货</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-sm-12">
            <div class="panel clearfix">
                <div class="form_container">
                    <h4 class="panel-heading">
                        补充说明
                    </h4>
                    <div class="col-sm-12 form-horizontal">
                        <div class="form-group has-unit col-sm-4">
                            <div class="col-sm-5 control-label text-right"><span class="red">*</span>装车时间</div>
                            <div class="col-sm-7 text-left">
                                <input class="form-control" value="">
                                <i class="unit fa fa-calendar"></i>
                            </div>
                        </div>
                        <div class="form-group has-unit col-sm-4">
                            <div class="col-sm-5 control-label text-right">车长要求</div>
                            <div class="col-sm-7 text-left">
                                <input class="form-control" value="">
                                <i class="unit">米</i>
                            </div>
                        </div>
                        <div class="form-group col-sm-4 text-center">
                            <a class="perfect_info car_perfect_info">完善信息<i class="fa fa-chevron-circle-down"></i> </a>
                        </div>

                        <div class="clearfix car_hide_box">
                            <div class="form-group col-sm-4">
                                <div class="col-sm-5 control-label text-right">车型要求</div>
                                <div class="col-sm-7 text-left">
                                    <input class="form-control" value="">
                                </div>
                            </div>
                            <div class="form-group has-unit col-sm-4">
                                <div class="col-sm-5 control-label text-right">货物价值</div>
                                <div class="col-sm-7 text-left">
                                    <input class="form-control" value="">
                                    <i class="unit">元</i>
                                </div>
                            </div>
                            <div class="form-group has-unit col-sm-4">
                                <div class="col-sm-5 control-label text-right">运输方式</div>
                                <div class="col-sm-7 text-left">
                                    <select class="form-control">
                                        <option value="">整车</option>
                                        <option value="">零担</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group has-unit col-sm-4">
                                <div class="col-sm-5 control-label text-right">有效天数</div>
                                <div class="col-sm-7 text-left">
                                    <input class="form-control" value="">
                                    <i class="unit">天</i>
                                </div>
                            </div>
                            <div class="form-group has-unit col-sm-8">
                                <div class="col-sm-2 control-label text-right" style="width:20%;">补充说明</div>
                                <div class="col-sm-10 text-left" style="width:76%;">
                                            <textarea placeholder="补充说明" class="form-control" rows="2"
                                                      style="padding:3px;text-indent:5px;"></textarea>
                                </div>
                            </div>
                            <div class="form-group col-sm-4">
                                <div class="col-sm-5 control-label text-right">是否指派</div>
                                <div class="col-sm-7 text-left">
                                    <div class="radios">
                                        <label class="label_radio r_on" for="radio-01">
                                            <input name="sample-radio" id="radio-01" value="1" type="radio"
                                                   checked="">是
                                        </label>
                                        <label class="label_radio r_off" for="radio-02">
                                            <input name="sample-radio" id="radio-02" value="1" type="radio"> 否
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group col-sm-8">
                                <div class="col-sm-2 control-label text-right" style="width:20%">运输用户</div>
                                <div class="col-sm-5 text-left " style="width:76%;">
                                    <div class="col-sm-7 text-left input-group"
                                         style="padding-left: 0;position: relative;float: left;">
                                        <input placeholder="输入用户名/手机号" class="form-control" value="" name="">
                                        <input class="input-group-addon input-group-search" type="button"
                                               style="height:30px;" value="搜索">
                                    </div>
                                    <div class="col-sm-5" style="line-height: 34px;">
                                        <a style="width: 100%;" data-toggle="modal"
                                           data-target="#myModal">常用联系人</a>
                                    </div>
                                </div>
                            </div>

                            <div class="clearfix contact_hide_box">

                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="col-sm-12">
            <div class="col-sm-6" style="padding-left:0;">
                <div class="panel clearfix">
                    <div class="form_container">
                        <h4 class="panel-heading">
                            发货人信息
                        </h4>
                        <div class="col-sm-12 form-horizontal">
                            <div class="form-group">
                                <div class="col-sm-3 control-label text-left"><span class="red">*</span>发货人
                                </div>
                                <div class="col-sm-6 text-left">
                                    <input class="form-control" value="">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="clearfix">
                                    <div class="col-sm-3 control-label text-left"><span
                                            class="red">*</span>发货地址
                                    </div>
                                    <div class="col-sm-6 text-left" style="margin-bottom:15px;">
                                        <input class="form-control" placeholder="请选择出发地址">
                                    </div>
                                </div>
                                <div class="clearfix">
                                    <div class="col-sm-3 control-label text-left"></div>
                                    <div class="col-sm-6"><input class="form-control col-sm-8"
                                                                 placeholder="输入详细地址"></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-3 control-label text-left"><span class="red">*</span>手机号码
                                </div>
                                <div class="col-sm-6 text-left">
                                    <input class="form-control" value="" placeholder="输入手机11位手机号码">
                                </div>
                                <div class="col-sm-3 text-left">
                                    <a class="perfect_info deliver_perfect_info">完善信息<i
                                            class="fa fa-chevron-circle-down"></i></a>
                                </div>
                            </div>
                            <div class="deliver_hide_box">
                                <div class="form-group">
                                    <div class="col-sm-3 control-label text-left">固定电话</div>
                                    <div class="col-sm-6 text-left">
                                        <input class="form-control" value="" placeholder="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-3 control-label text-left">公司名称</div>
                                    <div class="col-sm-6 text-left">
                                        <input class="form-control" value="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-sm-6" style="padding-right:0;">
                <div class="panel clearfix">
                    <div class="form_container">
                        <h4 class="panel-heading">
                            收货人信息
                        </h4>
                        <div class="col-sm-12 form-horizontal">
                            <div class="form-group">
                                <div class="col-sm-3 control-label text-left"><span class="red">*</span>收货人
                                </div>
                                <div class="col-sm-6 text-left">
                                    <input class="form-control" value="">
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="clearfix">
                                    <div class="col-sm-3 control-label text-left"><span
                                            class="red">*</span>发货地址
                                    </div>
                                    <div class="col-sm-6 text-left" style="margin-bottom:15px;">
                                        <input class="form-control" placeholder="请选择出发地址">
                                    </div>
                                </div>
                                <div class="clearfix">
                                    <div class="col-sm-3 control-label text-left"></div>
                                    <div class="col-sm-6"><input class="form-control col-sm-8"
                                                                 placeholder="输入详细地址"></div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-3 control-label text-left"><span class="red">*</span>手机号码
                                </div>
                                <div class="col-sm-6 text-left">
                                    <input class="form-control" value="" placeholder="输入手机11位手机号码">
                                </div>
                                <div class="col-sm-3 text-left">
                                    <a class="perfect_info recipt_perfect_info">完善信息<i
                                            class="fa fa-chevron-circle-down"></i></a>
                                </div>
                            </div>
                            <div class="recipt_hide_box">
                                <div class="form-group">
                                    <div class="col-sm-3 control-label text-left">固定电话</div>
                                    <div class="col-sm-6 text-left">
                                        <input class="form-control" value="" placeholder="">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-sm-3 control-label text-left">公司名称</div>
                                    <div class="col-sm-6 text-left">
                                        <input class="form-control" value="">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-sm-12">
            <div class="form-group" style="margin-bottom: 80px;">
                <div class="col-sm-2 control-label text-left"></div>
                <div class="col-sm-4">
                    <button class="btn btn-primary col-sm-12">提交</button>
                </div>
                <div class="col-sm-4">
                    <button class="btn btn-warning col-sm-12">返回</button>
                </div>
            </div>

        </div>


        <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal"
             class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button aria-hidden="true" data-dismiss="modal" class="close" type="button">×
                        </button>
                        <h4 class="modal-title">常用联系人</h4>
                    </div>
                    <div class="modal-body">
                        <table class="table" id="contact_table" data-toolbar="#toolbar"
                               data-search="true">
                            <thead>
                            <tr>
                                <th>登录名</th>
                                <th>真实姓名</th>
                                <th>手机号码</th>
                                <th>创建时间</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>我也母鸡叫什么</td>
                                <td>欧阳黄黄</td>
                                <td>1762008907</td>
                                <td>2016-12-13 09:45</td>
                                <td>查看</td>
                            </tr>
                            <tr>
                                <td>我也母鸡叫什么</td>
                                <td>欧阳黄黄</td>
                                <td>1762008907</td>
                                <td>2016-12-13 09:45</td>
                                <td>查看</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

    $(".deliver_perfect_info").click(function () {
        $('.deliver_hide_box').toggle();
    })
    $(".recipt_perfect_info").click(function () {
        $('.recipt_hide_box').toggle();
    })
    $(".car_perfect_info").click(function () {
        $('.car_hide_box').toggle();
    })
</script>
</body>
</html>
