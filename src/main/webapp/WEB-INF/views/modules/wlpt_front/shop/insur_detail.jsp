<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/modules/cms/front/include/taglib.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="decorator" content="site_web_basic"/>
    <title>${insurlist.insurCompanyname }保险详情</title>
    <style>


    </style>
</head>
<body>
<div class="content insureDetail">
    <div class="container" id="default_content_index">
        <div class="banner-centn">
            <div class="banner-wrap">
                <div class="ban-pur tm-clear">
                    <div class="banner-img pull-left">
                        <img alt=""
                             onerror="this.onerror=null;this.src='/static/images/wlptfront/shop_img/insur_logo.jpg'"
                             src="${insurlist.insurLogo }">
                    </div>
                    <div class="purchase pull-left">
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
                        <p class="cD-price" style="height: auto;">卓大直购价:&nbsp;<em>￥</em><span id="price">${insurlist.insurAmount }</span></p>
                        <button class="btn-blue text-center" style="color: #FFF;" onclick="showBg1();">立即购买</button>
                        <div id="fullbg" style="height: 2078px; width: 1349px; display: none;"></div>
                        <div id="dialog" style="display: none;">
                            <p class="close">
                                <a href="#" onclick="closeBg();">X</a>
                            </p>
                            <div class="dialog-content">
                                <img src="/static/images/wlptfront/shop_img/alert.png"><br>
                                <p>本产品暂不支持线上购买</p>
                                <p>请拨打客服电话<span>0310-5522261</span>了解详情</p>
                                <p class="close_content"><a href="#" onclick="closeBg1();">知道了</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="detail-tab col-sm-12">
                <div class="ui-tab">
                    <ul class="ui-tab-items" id="sku_tabs">
                        <li class="ui-tab-nav"><a href="#cpxq">产品详情</a></li>
                        <li class="ui-tab-nav marl-4"><a href="#lpfu">理赔服务</a></li>
                        <li class="ui-tab-nav marl-4"><a href="#gmxz">购买需知</a></li>
                    </ul>
                </div>
                <div class="tab-img">
                    <img alt="" alt=""
                         onerror="this.onerror=null;this.src='/static/images/wlptfront/shop_img/insur.jpg'"
                         src="${insurlist.insurImg }">
                </div>
                <div class="tab-body col-sm-12" id="cpxq">
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
                            <td style="padding:4px;">${insurlist.insurRange }</td>
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
                    <div class="tab-body buy_box col-sm-12" id="lpfu">
                        <h3 calss="tab-body-t"><span class="tab-body-title">理赔服务</span></h3>
                        <p class="detail_intro">提供7×24小时报案理赔电话，更可全国通赔。发生保险事故后，请参照下流程办理理赔。</p>
                        <div class="tab-body-main col-sm-12 clearfix">
                            <c:forEach items="${fn:split(insurlist.claimService,'|')}" var="val" varStatus="i">
                                <div class="tab-body-tip  col-sm-4" style="${i.index==0?'margin-left:70px;':'' }">
                                    <span class="tab-sz">${i.index + 1}</span>
                                    <p class="tab-wz">${val}</p>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
                <c:if test="${not empty insurlist.claimNotice }">
                    <div class="tab-body  buy_box col-sm-12" id="gmxz">
                        <h3 calss="tab-body-t"><span class="tab-body-title">购买需知</span></h3>
                        <p class="detail_intro">网上投保方便快捷，只需三步走帮你买到想要的保险。</p>
                        <div class="tab-body-main col-sm-12">
                            <c:forEach items="${fn:split(insurlist.claimNotice,'|')}" var="val" varStatus="i">
                                <div class="tab-body-tip  col-sm-4" style="${i.index==0?'margin-left:70px;':'' }">
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
<%--<div class="banner-centn">
    <div class="banner-wrap">
        <div class="ban-pur tm-clear">
            <div class="banner-img">
                <img alt="" onerror="this.onerror=null;this.src='/static/images/wlptfront/shop_img/insur_logo.jpg'"
                     src="${insurlist.insurLogo }">
            </div>
            <div class="purchase">
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

                <button class="btn-blue" id="purchase-alert" onclick="showBg1();"><a href="#">立即购买</a></button>
                <div id="fullbg" style="height: 2078px; width: 1349px; display: none;"></div>
                <div id="dialog" style="display: none;">
                    <p class="close">
                        <a href="#" onclick="closeBg();">X</a>
                    </p>
                    <div class="dialog-content">
                        <img src="/static/images/wlptfront/shop_img/alert.png"><br>
                        <p>本产品暂不支持线上购买</p>
                        <p>请拨打客服电话<span>0310-5522261</span>了解详情</p>
                        <p class="close_content"><a href="#" onclick="closeBg1();">知道了</a></p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="detail-tab">
        <div class="ui-tab">
            <ul class="ui-tab-items" id="sku_tabs">
                <li class="ui-tab-nav"><a href="#cpxq">产品详情</a></li>
                <li class="ui-tab-nav marl-4"><a href="#lpfu">理赔服务</a></li>
                <li class="ui-tab-nav marl-4"><a href="#gmxz">购买需知</a></li>

            </ul>
        </div>
        <div class="tab-img">
            <img alt="" onerror="this.onerror=null;this.src='/static/images/wlptfront/shop_img/insur.jpg'"
                 src="${insurlist.insurImg }">
            <!-- <p>注意:保险责任请参考<a target="_blank"  onclick="openagreement('insurclause');">《保险适用条款》</a>,并敬请特别留意条款中的“责任免除”部分。</p> -->
        </div>
        <div class="tab-body" id="cpxq">
            <h3 calss="tab-body-t"><span class="tab-body-title">产品详情</span></h3>
            <table>
                <tbody>
                <tr style="height:40px;background-color:#f7fbf1">
                    <th width="25%">保障项目</th>
                    <th width="20%">保障金额</th>
                    <th width="55%">保障范围</th>
                </tr>
                <tr>
                    <td style="text-align:center">${insurlist.insurProject }</td>
                    <td style="text-align:center">${insurlist.minAmount }-${insurlist.maxAmount }元</td>
                    <td>${insurlist.insurRange }</td>
                </tr>
                <tr style="height:40px;background-color:#f7fbf1">
                    <td colspan="3">注意：保险责任请参考<a target="_blank" onclick="openagreement('${insurlist.clauseCode }');">《保险适用条款》</a>，并敬请特别留意条款中的“责任免除”部分。
                    </td>
                </tr>
                <!-- <tr style="height:40px;background-color:#f7fbf1">
                    <td colspan="3">特别提醒:本保险不承保由地震、海啸造成的房屋损失。</td>
                </tr> -->
                </tbody>
            </table>
        </div>
        <c:if test="${not empty insurlist.claimService }">
            <div class="tab-body" id="lpfu">
                <h3 calss="tab-body-t"><span class="tab-body-title">理赔服务</span></h3>
                <p style="margin:15px 70px">提供7×24小时报案理赔电话，更可全国通赔。发生保险事故后，请参照下流程办理理赔。</p>
                <div class="tab-body-main tm-clear">
                    <c:forEach items="${fn:split(insurlist.claimService,'|')}" var="val" varStatus="i">
                        <div class="tab-body-tip" style="${i.index==0?'margin-left:70px;':'' }">
                            <span class="tab-sz">${i.index + 1}</span>
                            <p class="tab-wz" style="padding:34px">${val}</p>
                        </div>
                    </c:forEach>
                        &lt;%&ndash; <div class="tab-body-tip">
                            <span class="tab-sz">2</span>
                            <p class="tab-wz " style="padding:25px">配合理赔勘查、准备相关材料、证明(勘查人员会通知)</p>
                        </div>
                        <div class="tab-body-tip">
                            <span class="tab-sz">3</span>
                            <p class="tab-wz" style="padding:25px">邮寄理赔材料(邮寄费用由${insurlist.insurCompanyname }承担)</p>
                        </div>
                        <div class="tab-body-tip">
                            <span class="tab-sz">4</span>
                            <p class="tab-wz" style="padding:25px">确属保险责任范围、在赔付协议达成后${insurlist.claimPeriod }赔付</p>
                        </div> &ndash;%&gt;
                </div>
            </div>
        </c:if>
        <c:if test="${not empty insurlist.claimNotice }">
            <div class="tab-body" id="gmxz">
                <h3 calss="tab-body-t"><span class="tab-body-title">购买需知</span></h3>
                <p style="margin:15px 70px">网上投保方便快捷，只需三步走帮你买到想要的保险。</p>
                <div class="tab-body-main tm-clear">

                    <c:forEach items="${fn:split(insurlist.claimNotice,'|')}" var="val" varStatus="i">


                        <div class="tab-body-tip" style="${i.index==0?'margin-left:70px;':'' }">
                            <span class="tab-sz">${i.index + 1}</span>
                            <p class="tab-wz" style="padding:34px">${val}<p>
                        </div>
                    </c:forEach>

                    <!-- <div class="tab-body-tip">
                        <span class="tab-sz">2</span>
                        <p class="tab-wz " style="padding:34px">确认信息和金额</p>
                    </div>
                    <div class="tab-body-tip">
                        <span class="tab-sz">3</span>
                        <p class="tab-wz" style="padding:34px">在线支付</p>
                    </div> -->

                </div>
            </div>
        </c:if>
    </div>
</div>--%>
<script src="${ctxStatic}/modules/wlpt/front/js/msgbox.js" type="text/javascript"></script>
<script type="text/javascript" src="/static/common/global.js"></script>
<script type="text/javascript">
    function showBg1() {
        var status = "${user.userinfo.status}";
        /*if ('${insurlist.ismeasure}' == '1') {
            $.MsgBox.Alert("温馨提示", "请拨打客服电话（0310-3188756）购买");
            return;
        }*/
        if (status == '2') {
            window.location.href = "${wlpt}/wlpt/shop/toinsur?id=${insurlist.id}&index=2";
        } else if ("${user.userinfo}" == "" || "${user.userinfo}" == "null") {
            $.MsgBox.Alert("温馨提示", "您还未登录，请先登录");
        } else {
            $.MsgBox.Alert("温馨提示", "认证用户才可购买");
        }

    }
</script>
</body>
</html>