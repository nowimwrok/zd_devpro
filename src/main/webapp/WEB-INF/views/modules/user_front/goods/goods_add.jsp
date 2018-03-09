<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%@include  file="/WEB-INF/views/modules/wlpt_front/include/head_taget.jsp"%>
   <!--  <meta name="decorator" content="site_personal_basic"/> -->
    <title>货源发布</title>
    <style type="text/css">
        .loadings {
            text-align: center;
        }

        .loading {
            display: none;
            width: 100%;
            height: 94%;
            z-index: 999;
            position: fixed;
            background-color: rgba(165, 160, 154, 0.34);
            top: 0px;
            text-align: center;
        }

        .loading img {
            margin-top: 25%;
        }
        .delivery_tr td{
			padding-left: 10px !important;
		}
        .row{width:90%;margin:0 auto;margin-top:20px;padding-top:15px;box-shadow:0 0 15px rgba(0,0,0,.3);
        -webkit-box-shadow:0 0 15px rgba(0,0,0,.3);-moz-box-shadow:0 0 15px rgba(0,0,0,.3);-o-box-shadow:0 0 15px rgba(0,0,0,.3);}
    </style>

</head>
<body style="background: #f5f5f5;">

<div style="background: #f5f5f5;">
    <!--两列-->
    <div class="row edit-box">
        <form:form method="post" name="inputForm" id="inputForm" modelAttribute="goods">
            <div class="col-sm-12">
                <div class="panel clearfix">
                    <div class="form_container">
                        <h4 class="panel-heading">
                            基本信息 (<span class="red">*</span>为必填项)
                        </h4>
                        <div class="col-sm-12 form-horizontal">
                            <input type="hidden" value="${orderId}" name="orderId">
                            <input type="hidden" value="${goods.datasource}" name="datasource">
                            <input type="hidden" value="${goods.goodstype}" name="goodstype" id="goodstype">
                            <input name="id" value="${goods.id}" type="hidden">
                            <input id="freightunit" name="freightunit" value="${goods.freightunit}" type="hidden">
                            <div class="form-group col-sm-4">
                                <div class="col-sm-5 control-label text-right"><span class="red">*</span>货物名称</div>
                                <div class="col-sm-7 text-left">
                                    <input type="text" id="goodsname" name="goodsname" value="${goods.goodsname}"
                                           class="form-control" placeholder="输入货物名称">
                                </div>
                            </div>
                            <div class="form-group col-sm-4 has-unit">
                                <div class="col-sm-5 control-label text-right"><span class="red">*</span>货物重量</div>
                                <div class="col-sm-7 text-left">
                                    <input class="form-control" name="freightvolume" value="${goods.freightvolume}"
                                           <c:if test="${goods.id != null || (goods.datasource!='0' && not empty goods.datasource) }">readonly</c:if>
                                           type="text"
                                           id="freightvolume" onblur="checkfreight()" placeholder="输入货物重量" min="0">
                                    <span class="unit" id="a">吨</span>
                                </div>
                            </div>
                            <!--下拉框-->
                            <div class="form-group col-sm-4">
                                <div class="col-lg-5 control-label text-right">货物类别</div>

                                    <c:choose>
                                        <c:when test="${goods.id != null && goods.datasource!='0' }">
                                <div class="col-lg-7" style="text-align:left;margin-top: 3px;">
                                            ${fns:getDictLabel(goods.gsoddtype, 'gsoddtype', '')}
                                            <form:hidden path="gsoddtype"/>
                                        </c:when>
                                        <c:when test="${goods.datasource=='1' || goods.datasource=='4'}">
                                            <div class="col-lg-7" style="text-align:left;margin-top: 3px;">
                                            ${fns:getDictLabel(goods.gsoddtype, 'gsoddtype', '')}
                                            <form:hidden path="gsoddtype"/>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="col-lg-7" style="text-align:left;">
                                            <form:select id="gsoddtype" name="gsoddtype" class="form-control"
                                                         path="gsoddtype" onchange="change();">
                                                <form:options items="${fns:getDictList('gsoddtype')}" itemLabel="label"
                                                              itemValue="value"
                                                              htmlEscape="false"/>
                                            </form:select>
                                        </c:otherwise>
                                    </c:choose>
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
                                发货人
                            </h4>
                            <div class="col-sm-12 form-horizontal">
                                <div class="form-group">
                                    <div class="col-sm-3 control-label text-left"><span class="red">*</span>姓名
                                    </div>
                                    <div class="col-sm-9 text-left" style="width:72%;">
                                        <input id="shiplinkman" name="shipAddress.linkman"
                                         value="${not empty goods.id?goods.shipAddress.linkman:user.name}" 
                                         class="form-control col-sm-4" style="width: 40%;border-bottom-right-radius: 0;border-right: 0;border-top-right-radius: 0;"
                                         placeholder="请输入姓名">
                                        <input id="shiplinkmobile" name="shipAddress.linkmobile"  
                                         value="${not empty goods.id?goods.shipAddress.linkmobile:user.phone}" 
                                         class="form-control col-sm-8" style="width: 60%;border-bottom-left-radius: 0;border-top-left-radius: 0;" 
                                         placeholder="请输入11位手机号码">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="clearfix">
                                        <div class="col-sm-3 control-label text-left"><span
                                                class="red">*</span>提货地址
                                        </div>
                                        <div class="col-sm-8 text-left" style="margin-bottom:15px;">
                                            <input name="shipAddress.status" value="${goods.shipAddress.status}"
                                                   type="hidden"/>
                                            <input name="shipAddress.type" value="0" type="hidden">
                                            <input name="shipAddress.id" value="${goods.shipAddress.id}" type="hidden">
                                            <input id="fromprovince" name="shipAddress.province"
                                                   value="${goods.shipAddress.province}"
                                                   type="hidden">
                                            <input id="fromcity" name="shipAddress.city"
                                                   value="${goods.shipAddress.city}" type="hidden">
                                            <input id="fromdistrict" name="shipAddress.district"
                                                   value="${goods.shipAddress.district}"
                                                   type="hidden">
                                            <input type="text" name="fromAddress" id="fromAddress"
                                                   value="${goods.shipAddress.province}${goods.shipAddress.city}${goods.shipAddress.district}"
                                                   class="form-control" placeholder="选择出发地址" autocomplete="off"/>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <div class="col-sm-3 control-label text-left"></div>
                                        <div class="col-sm-9" style="width:72%;">
                                            <input class="form-control col-sm-8" id="shipAdd" name="shipAddress.address"
                                                   value="${goods.shipAddress.address}" type="text"
                                                   placeholder="详细地址"/>
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
                                收货人
                            </h4>
                            <div class="col-sm-12 form-horizontal">
                                <div class="form-group">
                                    <div class="col-sm-3 control-label text-left"><span class="red">*</span>姓名
                                    </div>
                                    <div class="col-sm-9 text-left" style="width:72%;">
                                        <input id="consignlinkman" name="consignAddress.linkman" 
                                               value="${goods.consignAddress.linkman}" type="text"
                                               class="form-control col-sm-4" style="width: 40%;border-bottom-right-radius: 0;border-right: 0;border-top-right-radius: 0;" 
                                               placeholder="请输入姓名"/>
                                        <input id="consignlinkmobile" name="consignAddress.linkmobile" 
                                        		value="${goods.consignAddress.linkmobile}" type="text" 
                                        		class="form-control col-sm-8" style="width: 60%;border-bottom-left-radius: 0;border-top-left-radius: 0;" 
                                        		placeholder="请输入11位手机号码">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="clearfix">
                                        <div class="col-sm-3 control-label text-left"><span
                                                class="red">*</span>卸货地址
                                        </div>
                                        <div class="col-sm-8 text-left" style="margin-bottom:15px;">
                                            <input name="consignAddress.status" value="${goods.consignAddress.status}"
                                                   type="hidden"/>
                                            <input name="consignAddress.type" value="1" type="hidden">
                                            <input name="consignAddress.id" value="${goods.consignAddress.id}"
                                                   type="hidden">
                                            <input id="toprovince" name="consignAddress.province"
                                                   value="${goods.consignAddress.province}"
                                                   type="hidden">
                                            <input id="tocity" name="consignAddress.city"
                                                   value="${goods.consignAddress.city}" type="hidden">
                                            <input id="todistrict" name="consignAddress.district"
                                                   value="${goods.consignAddress.district}"
                                                   type="hidden">
                                            <input type="text" id="toAddress" name="toAddress" class="form-control"
                                                   autocomplete="off"
                                                   value="${goods.consignAddress.province}${goods.consignAddress.city}${goods.consignAddress.district}"
                                                   placeholder="选择目的地"/>
                                        </div>
                                    </div>
                                    <div class="clearfix">
                                        <div class="col-sm-3 control-label text-left"></div>
                                        <div class="col-sm-9" style="width:72%"><input type="text" id="consignAdd"
                                                                     name="consignAddress.address"
                                                                     class="form-control col-sm-8"
                                                                     value="${goods.consignAddress.address}"
                                                                     placeholder="详细地址"/></div>
                                    </div>
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
                            货物信息
                        </h4>
                        <div class="col-sm-12 form-horizontal">
                            <div class="form-group has-unit col-sm-4">
                                <div class="col-sm-5 control-label text-right"><span class="red">*</span>装车时间</div>
                                <div class="col-sm-7 text-left">
                                    <input name="sendtime" id="sendtime" type="text" readonly="readonly" maxlength="20"
                                           class="Wdate form-control" placeholder="选择装车时间"
                                           value="<fmt:formatDate value="${goods.sendtime}" pattern="yyyy-MM-dd HH:mm"/>"
                                           onclick="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',minDate: '%y-%M-%d %H:%m'});"/>
                                    <i class="unit fa fa-calendar"></i>
                                </div>
                            </div>
                            <div class="form-group has-unit col-sm-4">
                                <div class="col-sm-5 control-label text-right">运输方式</div>
                                <div class="col-sm-7 text-left">
                                    <input id="transportway" name="transportway" value="${goods.transportway}"
                                           class="form-control" type="text"
                                           readonly="readonly" placeholder="选择运输方式"/>
                                </div>
                            </div>
                            <div class="form-group has-unit col-sm-4">
                                <div class="col-sm-5 control-label text-right">期望价格</div>
                                <div class="col-sm-7 text-left">
                                    <input class="form-control" id="expectedprice" name="expectedprice"
                                           value="${goods.expectedprice}" type="text" placeholder="输入期望价格" min="0"/>
                                    <span class="unit" id="b">元/吨</span>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12 form-horizontal">
                            <div class="form-group has-unit col-sm-4">
                                <div class="col-sm-5 control-label text-right">有效天数</div>
                                <div class="col-sm-7 text-left">
                                    <input id="effectdays" name="effectdays" value="${goods.effectdays}"
                                           maxlength="2" class="form-control" type="text" placeholder="输入有效天数" min="0"/>
                                    <span class="unit">天</span>
                                </div>
                            </div>
                            <div class="form-group has-unit col-sm-4">
                                <div class="col-sm-5 control-label text-right">货物价值</div>
                                <div class="col-sm-7 text-left">
                                    <input id="worth" name="worth" value="${goods.worth}" class="form-control"
                                           type="text" placeholder="输入货物价值" min="0"/>
                                    <span class="unit">元</span>
                                </div>
                            </div>
                            
                        </div>
                            <%-- <div class="form-group has-unit col-sm-4">
                                <div class="col-sm-5 control-label text-right">是否投保</div>
                                <div class="col-sm-7 text-left">
                                    <form:radiobuttons id="isinsur" path="isinsur" items="${fns:getDictList('yes_no')}"
                                               itemLabel="label" itemValue="value" htmlEscape="false" class="paytyperadio"/>

                                </div>
                            </div>
                            <div class="form-group has-unit col-sm-8" id="paydepositdiv">
                                <div class="col-sm-2 control-label text-right" style="width:20%">保单支付方</div>
                                <div class="col-sm-10 text-left" style="width:76%;">
                                    <form:radiobuttons id="paypeople" path="paypeople" items="${fns:getDictList('insur_paypeople')}"
                                          itemLabel="label" itemValue="value" htmlEscape="false" class="paytyperadio"/>
                                </div>
                            </div> --%>

                    </div>
                </div>
            </div>
            
            
            <div class="col-sm-12">
                <div class="panel clearfix">
                    <div class="form_container">
                        <h4 class="panel-heading">
                            需求车型
                        </h4>
                        <div class="col-sm-12 form-horizontal">
                            <div class="form-group col-sm-4">
                                <div class="col-sm-5 control-label text-right">车型</div>
                                <div class="col-sm-7 text-left">
                                    <input id="cartype" name="cartype" value="${goods.cartype}" readonly="readonly"
                                           class="form-control" type="text" placeholder="选择车型"/>
                                </div>
                            </div>
                            <div class="form-group has-unit col-sm-4">
                                <div class="col-sm-5 control-label text-right">车长</div>
                                <div class="col-sm-7 text-left">
                                    <input class="form-control" id="carlength" name="carlength"
                                           value="${goods.carlength}" type="text" placeholder="输入车长"/>
                                    <span class="unit">米</span>
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
                            派车方式
                        </h4>
                            <div class="col-sm-12 form-horizontal">
                                <div class="form-group col-sm-4">
                                    <div class="col-sm-5 control-label text-right">是否指派</div>
                                    <div class="col-sm-7 text-left">
                                        <div class="radios">
                                            <form:radiobuttons id="issend" path="issend"
                                                               items="${fns:getDictList('yes_no')}"
                                                               itemLabel="label" itemValue="value" htmlEscape="false"
                                                               class="paytyperadio"/>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group col-sm-8" id="contactsdiv" style="display: none;">
                                    <div class="col-sm-2 control-label text-right" style="width:20%">运输用户</div>
                                    <div class="col-sm-5 text-left " style="width:76%;">
                                        <div class="col-sm-7 text-left input-group"
                                             style="padding-left: 0;position: relative;float: left;">
                                            <input name="quoteuserid" value="" type="hidden" id="userid"/>
                                            <input name="searchinfo" value="" type="text" id="searchinfo"
                                                   placeholder="输入用户名/手机号" class="form-control"
                                                   onchange="search();"/>
                                            <input class="input-group-addon input-group-search" type="button"
                                                   style="height:30px;" onclick="search();" value="查询">
                                        </div>
                                        <div class="col-sm-5" style="line-height: 34px;">
                                            <a style="width: 100%;" data-toggle="modal"
                                               data-target="#myModal" onclick="search();" class="see oprate">常用联系人</a>
                                        </div>
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
                            备注信息
                        </h4>
                        <div class="col-sm-12 form-horizontal">
                            <div class="form-group has-unit col-sm-12">
                                <div class="col-sm-2 control-label text-right" style="width:13.3%;">备注</div>
                                <div class="col-sm-6 text-left">
                                    <form:textarea id="remarks" htmlEscape="false" path="remarks" rows="5"
                                                       style="padding:3px;text-indent:5px;height: 70px;line-height: 20px;" maxlength="100"
                                                       class="form-control"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            
            
            <div class="col-sm-12">
                <c:if test="${blinfoList!=null && blinfoList.size()>0}">
                    <div class="panel clearfix">
                        <div class="form_container">
                            <h4 class="panel-heading">
                                提货单
                            </h4>
                            <div class="col-sm-12 form-horizontal">
                                <table class="table" id="delivery_order">
                                    <thead>
                                    <tr>
                                        <th>提货单号</th>
                                        <th>品名材质</th>
                                        <th>规格</th>
                                        <th>定尺\板宽</th>
                                        <th>数量\吨</th>
                                        <th>批次号</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach var="item" items="${blinfoList}" varStatus="status"><%--
                                        <input type="hidden" name="blinfoList[${status.index}].blcode"
                                               value="${item.blcode}">
                                        <input type="hidden" name="blinfoList[${status.index}].namematerials"
                                               value="${item.namematerials}">
                                        <input type="hidden" name="blinfoList[${status.index}].standard"
                                               value="${item.standard}">
                                        <input type="hidden" name="blinfoList[${status.index}].width"
                                               value="${item.width}">
                                        <input type="hidden" name="blinfoList[${status.index}].quantity"
                                               value="${item.quantity}">
                                        <input type="hidden" name="blinfoList[${status.index}].batch"
                                               value="${item.batch}">--%>
                                        <input type="hidden" name="blinfoList[${status.index}].id" value="${item.id}">
                                        <tr class="delivery_tr">
                                            <td>${item.contractno}</td>
                                            <td>${item.namematerials}</td>
                                            <td>${item.standard}</td>
                                            <td>${item.width}</td>
                                            <td>${item.quantity}</td>
                                            <td>${item.batch}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
            <div class="col-sm-12">
                <div class="form-group" style="margin-bottom: 105px;">
                    <div class="col-sm-2 control-label text-left"></div>
                    <div class="col-sm-4">
                        <input type="button" id="btnSubmit" class="btn btn-primary col-sm-12" value="保  存">
                    </div>
                    <div class="col-sm-4">
                        <button class="btn btn-warning col-sm-12" onclick="history.go(-1)">返  回</button>
                    </div>
                </div>
                <!-- <div class="loading">
                    <img src="/static/images/loading.gif">
                    <p>加载中</p>
                </div> -->
            </div>

        </form:form>
    </div>
</div>
<%@ include file="/WEB-INF/views/modules/user_front/contacts/contacts_info.jsp" %>

<script src="${ctxStatic }/jquery-select2/3.4/select2.min.js" type="text/javascript"></script>
<script src="${ctxStatic }/common/mustache.min.js" type="text/javascript"></script>
<script type="text/javascript" src="${ctxStatic }/common/global.js"></script>

<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.pcc.js"></script>
<script type="text/javascript" src="${ctxStatic}/modules/wlpt/front/js/jquery.gridSelector.js"></script>
<script src="${ctxStatic }/modules/wlpt/front/js/My97DatePicker/WdatePicker.js" type="text/javascript"></script>
<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js?id=1" type="text/javascript"></script>
<script>
$("#maskloading" , parent.document).hide();
$(".deliver_perfect_info").click(function () {
    $('.deliver_hide_box').toggle();
})
$(".recipt_perfect_info").click(function () {
    $('.recipt_hide_box').toggle();
})
$(".car_perfect_info").click(function () {
    $('.car_hide_box').show();
    $(this).hide();
    $(".car_perfect_info_up").show();
})
$(".car_perfect_info_up").click(function () {
    $('.car_hide_box').hide();
    $(this).hide();
    $('.car_perfect_info').show();
})


</script>
<script type="text/javascript">
    /* $(".loading").hide(); */

    $("#issend2").attr('checked','checked');//默认选中否

    $("input[name='issend']").click(function () {
        var key = $(this).val();
        if (key == "1") {
            $("#contactsdiv").show();
            $("#btnSubmit").val("下一步,生成运单");
        } else {
            $("#contactsdiv").hide();
            $("#btnSubmit").val("保 存");
        }
    });

    $('#inputForm').bootstrapValidator({
        message: '信息有误',
        
        live: 'enabled',
        fields: {
            goodsname: {
                message: '货物名称无效',
                validators: {
                    notEmpty: {
                        message: '货物名称不能为空'
                    }
                }
            },
            "freightvolume": {
                message: '运量无效',
                validators: {
                    notEmpty: {
                        message: '运量不能为空'
                    }, decimalFour: {
                        message: '只能为小数或数字且小数点后不能超过4位'
                    },
                    between: {
                        min: 0.001,
                        max:100000000,
                        message: '运量不能小于等于0'
                    }
                }
            },
            fromAddress: {
                message: '请选择出发地',
                trigger:"change",
                validators: {
                    notEmpty: {
                        message: '出发地不能为空'
                    }
                }
            },
            "shipAddress.linkman": {
                validators: {
                    notEmpty: {
                        message: '收货人不能为空'
                    }
                }
            },
            "shipAddress.address": {
                message: '请填写详细地址',
                validators: {
                    notEmpty: {
                        message: '请填写详细地址'
                    }
                }
            },
            "shipAddress.linkmobile": {
                message: '请填写手机号码',
                validators: {
                    notEmpty: {
                        message: '手机号码不能为空'
                    },integer: {
                        message: "请填写正确的手机号码"
                    },regexp: {
                        regexp: /^(((13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9]))+\d{8})$/,
                        message: '请填写正确的手机号码'
                    }
                }
            },
            
            toAddress: {
                message: '请选择目的地',
                trigger:"change",
                validators: {
                    notEmpty: {
                        message: '目的地不能为空'
                    }
                }
            },
            "consignAddress.linkman": {
                validators: {
                    notEmpty: {
                        message: '收货人不能为空'
                    }
                }
            }, "consignAddress.address": {
                message: '请填写详细地址',
                validators: {
                    notEmpty: {
                        message: '请填写详细地址'
                    }
                }
            }, "consignAddress.linkmobile": {
                message: '请填写手机号码',
                validators: {
                    notEmpty: {
                        message: '手机号码不能为空'
                    },integer: {
                        message: "请填写正确的手机号码"
                    },regexp: {
                        regexp: /^(((13[0-9]|14[0-9]|15[0-9]|17[0-9]|18[0-9]))+\d{8})$/,
                        message: '请填写正确的手机号码'
                    }
                }
            },
            sendtime: {
                message: '请选择装车时间',
                trigger: "focus blur keyup change",
                validators: {
                    notEmpty: {
                        message: '请选择装车时间'
                    }
                }
            }, carlength: {
                message: '车长无效',
                validators: {
                    decimalTwo: {
                        message: '车长只能为小数或数字'
                    },
                    between: {
                        min: 0.001,
                        max:100000000,
                        message: '车长不能小于等于0'
                    }
                }
            },
            worth: {
                message: '货物价值无效',
                validators: {
                    decimalTwo: {
                        message: '货物价值只能为小数或数字'
                    }
                }
            },
            expectedprice: {
                message: '期望价格无效',
                validators: {
                    decimalTwo: {
                        message: '期望价格只能为小数或数字'
                    },
                    between: {
                        min: 0.01,
                        max:100000000,
                        message: '期望价格不能小于等于0'
                    }
                }
            }, effectdays: {
                message: '有效天数无效',
                validators: {
                    numeric: {
                        message: '有效天数只能为数字'
                    },
                    between: {
                        min: 1,
                        max:100000000,
                        message: '有效天数不能小于等于0'
                    }
                }
            }
        }

    });

    function search() {
    	var searchinfo = $("#searchinfo").val();
        if (searchinfo!='' || searchinfo!="" || searchinfo!=undefined) {
        	$("#maskloading" , parent.document).show();
            if (!searchinfo) {
                $.MsgBox.Alert("系统提示", '请填写指派用户信息');
                $("#maskloading" , parent.document).hide();
                return false;
            }
            $.ajax({
                url: "${wlpt}/wlpt/goods/searchInfo",
                dataType: 'json',
                data: {searchinfo: searchinfo},
                cache: false,
                success: function (data) {
                    $("#userid").val("");
                    $("#maskloading" , parent.document).hide();
                    if (data) {
                        if (data.value == '未查到指定用户') {
                            $.MsgBox.Alert("系统提示", '未查到指定用户!请确认用户是否已注册');
                        } else if (data.value == '该用户无车辆信息') {
                            $.MsgBox.Alert("系统提示", '该用户无车辆信息,不可指派');
                        } else if (data.value == '该用户无司机信息') {
                            $.MsgBox.Alert("系统提示", '该用户无司机信息,不可指派');
                        }else if (data.value == '不能指派给自己') {
                            $.MsgBox.Alert("系统提示", '不能指派给自己');
                        } else {
                            if (data.value.role.enname != "carowner" && data.value.role.enname != "enterprise") {

                                $.MsgBox.Alert("系统提示", '只能指派给物流企业或车主');
                            } else {
                                if (data.value.user.id) {
                                    if (data.value.user.id == "${user.id}") {
                                        $.MsgBox.Alert("系统提示", '不可指派给自己，请重新选择');
                                    } else {
                                        $.MsgBox.Alert("系统提示", '可指派');
                                        $("#userid").val(data.value.user.id);
                                    }

                                }
                            }

                        }
                    }
                }
            });

        }else{
        	$.MsgBox.Alert("系统提示", '请填写指派用户信息');
        }
    }


    change();
    getCarType();
    getTransportWay();
    function change() {
        var gsoddtype = $("#gsoddtype").val();
        var result1;
        var result2;
        if (gsoddtype == '0') {
            result1 = '方';
            result2 = '元/方';
            $("#goodstype").val("0");
        } else {
            result1 = '吨';
            result2 = '元/吨';
            $("#goodstype").val("1");
        }
        $("#a").html(result1);
        $("#b").html(result2);
        $("#freightunit").val(result1);
    }
    function getTransportWay() {
        $.ajax({
            url: "${wlpt}/getDictListJson?type=transportway",
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data) {
                    var adds = data;
                    $("#transportway").gridSelector({
                        idKey: "value",
                        textKey: "label",
                        cellWidth: 50,
                        cellHeight: 28,
                        data: adds,
                        colNum: 7,
                        multiSelect: false,
                        complete: function (data) {
                            if (data) {
                                $("#transportway").val(data.value);
                            }
                        }
                    });
                }
            }
        });
    }
    function getCarType() {
        $.ajax({
            url: "${wlpt}/getDictListJson?type=car_type",
            dataType: 'json',
            cache: false,
            success: function (data) {
                if (data) {
                    var adds = data;
                    $("#cartype").gridSelector({
                        idKey: "value",
                        textKey: "label",
                        cellWidth: 50,
                        cellHeight: 28,
                        data: adds,
                        colNum: 7,
                        multiSelect: false,
                        complete: function (data) {
                            if (data) {
                                $("#cartype").val(data.value);
                            }
                        }
                    });
                }
            }
        });
    }
    $("#fromAddress").PCC({
        hasCounty: true,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        //closeIcon: "static/images/pic12.gif",
        complete: function (data) {
            var str = "";
            var fromcounty = "";
            if (data.province) {
                str += data.province.NAME;
                //searchConditions.fromProvince = data.province.NAME;
                $("#fromprovince").val(data.province.NAME);
                // $("#fromcity").val("");
                //$("#fromdistrict").val("");
            }
            if (data.city) {
                str += data.city.NAME;
                $("#fromcity").val(data.city.NAME);
                //  $("#fromdistrict").val("");
                //searchConditions.fromCity = data.city.NAME;
            }
            if (data.county) {
                str += data.county.NAME;
                fromcounty = data.county.NAME;
                $("#fromdistrict").val(data.county.NAME);
            }
            if (fromcounty == "") {
                str = "";
            }
            $("#fromAddress").val(str).change();
        }
    });

    $("#toAddress").PCC({
        hasCounty: true,
        width: 360,
        height: 220,
        url: "${wlpt}/wlpt/chinaarea/getArea",
        //closeIcon: "static/images/pic12.gif",
        complete: function (data) {
            var str = "";
            var tocounty = "";
            if (data.province) {
                str += data.province.NAME;
                //searchConditions.fromProvince = data.province.NAME;
                $("#toprovince").val(data.province.NAME);
                //  $("#tocity").val("");
                //   $("#todistrict").val("");
            }
            if (data.city) {
                str += data.city.NAME;
                $("#tocity").val(data.city.NAME);
                //  $("#todistrict").val("");
                //searchConditions.fromCity = data.city.NAME;
            }
            if (data.county) {
                str += data.county.NAME;
                tocounty = data.county.NAME;
                $("#todistrict").val(data.county.NAME);
            }
            if (tocounty == "") {
                str = "";
            }
            $("#toAddress").val(str).change();
        }
    });
    $("#btnSubmit").click(function () {

        var issend = $("input[name=issend]:checked").val();
        if (issend == 1) {

            var expectprice = $("input[name=expectedprice]").val();
            if (!expectprice) {
                $.MsgBox.Alert("系统提示", '指派请填写期望价格');
                return false;
            }
            var userid = $("#userid").val();
            if (userid == "" || userid == undefined) {
                $.MsgBox.Alert("系统提示", '该用户不可指派，请重新选择');
                return false;
            } else if (userid == "${user.id}") {
                $.MsgBox.Alert("系统提示", '不可指派给自己，请重新选择择');
                return false;
            }

        }


        var bootstrapValidator = $("#inputForm").data('bootstrapValidator');
        bootstrapValidator.validate();
        if (bootstrapValidator.isValid()) {
            $.MsgBox.Confirm("系统提示", "确定提交吗？", function () {
            	$("#maskloading" , parent.document).show();
                $.ajax({
                    url: "${wlpt}/wlpt/goods/save?" + $("#inputForm").serialize(),
                    dataType: 'json',
                    type: "post",
                    success: function (data) {

                        if (data.value.state == 1) {
                            if (issend == 1 && data.value.data != null && data.value.data.id != "") {
                                window.location.href = '${wlpt}/wlpt/goods/quoteOrder?id=' + data.value.data.id;
                            } else {
                                window.location.href = '${wlpt}/wlpt/goods/goods_list?isRedrect=true';
                            }
                            $("#maskloading" , parent.document).hide();
                        } else {
                            $("#maskloading" , parent.document).hide();
                            $.MsgBox.Alert("保存提示", data.value.message);
                        }

                    }
                });
            });
        }
    });
</script>
</body>
</html>
