<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no"/>
    <title></title>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="${ctxStatic }/front/css/bootstrap.min.css" rel="stylesheet">
    <link href="${ctxStatic }/front/css/per_global.css" rel="stylesheet">
    <link href="${ctxStatic }/front/css/personal.css" rel="stylesheet">
    <link rel="stylesheet" href="${ctxStatic }/front/css/add.css"/>
</head>
<body>
<div class="insureDetail">
    <div id="default_content_index">
        <div class="banner-centn">
            <div class="banner-wrap">
                <div class="ban-pur tm-clear">
                    <div class="banner-img pull-left">
                        <img alt=""
                             onerror="this.onerror=null;this.src='/static/images/wlptfront/shop_img/insur_logo.jpg'"
                             src="${insurlist.insurLogo }">
                    </div>
                    <div class=" purchase pull-left">
                        <h1 class="ban-title">${insurlist.insurName }</h1>
                        <div class="countDown">
                            <dl>
                                <dt>适合人群:</dt>
                                <dd>${insurlist.suitableCrowd }</dd>
                            </dl>
                            <dl>
                                <dt>保障期限:</dt>
                                <dd>${insurlist.validityTerm }</dd>
                            </dl>
                            <dl>
                                <dt>产品特点:</dt>
                                <dd>${insurlist.productFeatures }</dd>
                            </dl>
                            <dl>
                                <dt>最高保额:</dt>
                                <dd><span style="color: red;font-weight: bold;">${insurlist.maxAmount }</span></dd>
                            </dl>
                            <dl>
                                <dt>支付方式:</dt>
                                <dd>${insurlist.payType }</dd>
                            </dl>
                        </div>
                        <p class="cD-price">卓大直购价:&nbsp;<em>￥</em><span id="price">${insurlist.insurAmount }</span></p>
                        <button onclick="showBg1();" class="btn-blue text-center"><a>立即购买</a></button>
                    </div>
                </div>
            </div>
            <div class="detail-tab ">
                <div class="ui-tab">
                    <ul class="ui-tab-items" id="sku_tabs">
                        <li class="ui-tab-nav"><a href="javascript:void(0)" class="cpxq">产品详情</a></li>
                        <li class="ui-tab-nav marl-4"><a class="lpfw" href="javascript:void(0)">理赔服务</a></li>
                        <li class="ui-tab-nav marl-4"><a class="gmxz" href="javascript:void(0)">购买需知</a></li>
                    </ul>
                </div>
                <div class="tab-img">
                    <img alt="" onerror="this.onerror=null;this.src='/static/images/wlptfront/shop_img/insur.jpg'"
                         src="${insurlist.insurImg }">
                </div>
                <div class="tab-body " id="cpxq">
                    <h3 calss="tab-body-t"><span class="tab-body-title">产品详情</span></h3>
                    <table class="cDetail">
                        <tbody>
                        <tr class="cDetail_title">
                            <th>保障项目</th>
                            <th>保障金额</th>
                            <th>保障范围</th>
                        </tr>
                        <tr>
                            <td class="text-center">${insurlist.insurProject }</td>
                            <td class="text-center">${insurlist.minAmount }-${insurlist.maxAmount }元</td>
                            <td style="padding:4px;">
                                ${insurlist.insurRange }
                            </td>
                        </tr>
                        <tr class="cDetail_title">
                            <td colspan="3" style="padding-left:15px;">注意：保险责任请参考<a
                                    onclick="openagreement('${insurlist.clauseCode }');" target="_blank">《保险适用条款》</a>，并敬请特别留意条款中的“责任免除”部分。
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <c:if test="${not empty insurlist.claimService }">
                    <div class="tab-body buy_box " id="lpfu">
                        <h3 calss="tab-body-t"><span class="tab-body-title">理赔服务</span></h3>
                        <p class="detail_intro">提供7×24小时报案理赔电话，更可全国通赔。发生保险事故后，请参照下流程办理理赔。</p>
                        <div class="tab-body-main  clearfix">
                            <c:forEach items="${fn:split(insurlist.claimService,'|')}" var="val" varStatus="i">
                                <div class="tab-body-tip  pull-left">
                                    <span class="tab-sz">${i.index + 1}</span>
                                    <p class="tab-wz">${val}</p>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
                <c:if test="${not empty insurlist.claimNotice }">
                    <div class="tab-body  buy_box " id="gmxz">
                        <h3 calss="tab-body-t"><span class="tab-body-title">购买需知</span></h3>
                        <p class="detail_intro">网上投保方便快捷，只需三步走帮你买到想要的保险。</p>
                        <div class="tab-body-main clearfix">
                            <c:forEach items="${fn:split(insurlist.claimNotice,'|')}" var="val" varStatus="i">
                                <div class="tab-body-tip  pull-left">
                                    <span class="tab-sz">${i.index + 1}</span>
                                    <p class="tab-wz">${val}<p>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>
<script src="${ctxStatic }/jquery/jquery-1.8.3.min.js"></script>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script type="text/javascript" src="/static/common/global.js"></script>


<script>
    //点击页面下移
    $('.lpfw').click(function (e) {
        e.preventDefault();
        $('html,body').animate({scrollTop: 800}, 500);
    });
    $('.gmxz').click(function (e) {
        e.preventDefault();
        $('html,body').animate({scrollTop: 900}, 500);
    });
    $(".cpxq").click(function (e) {
        e.preventDefault();
        $('html,body').animate({scrollTop: 800}, 500);
    });

    window.showBg1 = function () {
        var status = "${user.userinfo.status}";
        if (status == '2') {
            window.location.href = "${wlpt}/wlpt/shop/toinsurance?id=${insurlist.id}&index=2";
        } else if ("${user.userinfo}" == "" || "${user.userinfo}" == "null") {
            $.MsgBox.Alert("温馨提示", "您还未登录，请先登录");
        } else {
            $.MsgBox.Alert("温馨提示", "认证用户才可购买");
        }

    }
</script>
</body>
</html>
