<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>车源详情</title>
    <link rel="stylesheet" href="${ctxStatic}/front/css/add.css"/>
    <style>
        .goods_details .form-group {
            margin-left: 2.5%;
            margin-right: 2.5%;
        }

        .load {
            width: 100%;
            height: 94%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 0px;
            text-align: center;
        }

        .load img {
            margin-top: 25%;
        }

        .form-control {
            border: 1px solid #ccc !important;
        }

        .car_addr {
            height: 34px;
            padding: 6px 12px;
            font-size: 14px;
            line-height: 1.42857143;
            color: #555;
            background-color: #fff;
            background-image: none;
            border: 1px solid #ccc;
            border-radius: 4px;
            /* -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075); */
            /* box-shadow: inset 0 1px 1px rgba(0,0,0,.075); */
            -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
            -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
            transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
            box-shadow: none;
        }

        .car_addr[readonly], fieldset[disabled] .car_addr {
            opacity: 1;
            background: #fff;
            box-shadow: none;
        }
        .text-value-left{
        	text-align: left !important;
        }
    </style>

</head>
<body style="background: #f5f5f5;">
<div style="background: #f5f5f5;">
    <div class="row">
        <div class="col-lg-12">
            <div class="form_container">
                <!--第一个面板-->
                <div class="panel clearfix">
                    <h4 class="panel-heading">
                        车辆详细信息
                    </h4>
                    <div class="col-sm-12 form-horizontal">
                        <div class="form-group col-sm-4">
                            <div class="col-sm-5 control-label text-right">
                                车牌号码
                            </div>
                            <div class="col-sm-7  control-label text-value-left">
                                ${carsource.car.carnumber }

                            </div>
                        </div>

                        <div class="col-sm-4 form-group">
                            <div class="col-sm-5 control-label text-left">
                                车辆类型
                            </div>
                            <div class="col-sm-7 control-label text-value-left">
                                ${carsource.car.cartype}
                            </div>
                        </div>

                        <div class="col-sm-4 form-group  has-unit">
                            <div class="col-sm-5 control-label text-left">
                                车辆载重
                            </div>
                            <div class="col-sm-7 control-label text-value-left">
                                ${carsource.car.loadweight}吨
                            </div>
                        </div>
                    </div>
                </div>
                <!--第4个面板-->
                <div class="panel clearfix">
                    <h4 class="panel-heading">车源信息</h4>
                    <div class="col-sm-12 form-horizontal">
                        <div class="col-sm-4 form-group has-unit">
                            <div class="col-sm-5 control-label text-left">
                                发车时间
                            </div>
                            <div class="col-sm-7 control-label text-value-left">
                                <fmt:formatDate value="${carsource.departuretime}" pattern="yyyy-MM-dd"/>
                            </div>
                        </div>
                        <div class="col-sm-6 form-group">
                            <div class="col-sm-3 control-label text-left">
                                主营路线
                            </div>
                            <div class="col-sm-8 control-label text-value-left">
                                ${carsource.mainroad}
                            </div>
                        </div>

                    </div>
                </div>
                <!--第3个面板-->
                <div class="panel clearfix">
                    <h4 class="panel-heading">联系信息</h4>
                    <div class="col-sm-12 form-horizontal">
                        <div class="col-sm-4 form-group">
                            <div class="col-sm-5 control-label text-left">
                                联系人
                            </div>
                            <div class="col-sm-7 control-label text-value-left">
                                ${carsource.contactname }
                            </div>
                        </div>
                        <div class="col-sm-4 form-group has-unit">
                            <div class="col-sm-5 control-label text-left">
                                手机号
                            </div>
                            <div class="col-sm-7 control-label text-value-left">
                                ${carsource.contactmobile }
                            </div>
                        </div>
                    </div>
                </div>


                <!--第6个面板-->
                <div class="col-sm-12">
                    <div class="form-group" style="margin-bottom: 80px;">
                        <div class="col-sm-4 control-label text-left"></div>

                        <div class="col-sm-4">
                            <button class="btn btn-warning col-lg-12" onclick="history.go(-1)">返  回</button>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>


</body>
</html>
