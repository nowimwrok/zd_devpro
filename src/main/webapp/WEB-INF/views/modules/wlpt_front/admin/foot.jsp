<%@ page contentType="text/html;charset=UTF-8" %>
<link rel="stylesheet" type="text/css" href="${ctxStatic }/modules/wlpt/front/css/foot.css">
<style>
    .company-list li {
        font-size: 12px;
        line-height: 20px;;
    }

    .company-list li a {
        font-size: 12px;
    }
    hr{
        margin: 0px;
    }
</style>
<footer>
    <div class="foot-wrap">
        <%--  <div class="foot-col1">
            <div class="col1-left">
             <img src="${ctxStatic }/images/wlptfront/phone_img.png"><span>${fns:getConst('LINK_TEL')}</span>
            </div>
             <span class="col1-right">地址：${fns:getConst('LINK_ADDRESS')}</span>

         </div> --%>
        <div class="company-ul">
            <ul class="company-list">
                <li><a href="${wlpt}/wlpt/agreement/wlptToolInfo?code=wlptAboutUs">关于我们</a></li>
                <li><a href="${wlpt}/wlpt/agreement/wlptToolInfo?code=serviceitem">服务协议</a></li>
                <li><a href="${wlpt}/wlpt/agreement/wlptToolInfo?code=wlptContactUs">联系我们</a></li>
                <li><a href="${wlpt}/wlpt/agreement/wlptToolInfo?code=wlptLegalStatement">法律声明</a></li>
            </ul>
        </div>
        <div class="company-ul">
            <ul class="company-list" style="margin: 0px auto;">
                <li>友情链接：</li>
                <li><a href="http://www.cntr56.cn">广东天润物流市场</a></li>
                |
                <li><a href="http://www.hbistc.com">河钢云商</a></li>
                |
                <li><a href="http://www.chinawuliu.com.cn">中国物流采购网</a></li>
                |
                <li><a href="http://www.ouyeel.cn">欧冶云商</a></li>
                |
                <li><a href="http://www.zhaogang.com">找钢网</a></li>
                |
                <li><a href="http://www.steelcn.cn">中钢网</a></li>
                |
                <li><a href="http://www.baosteel.com">大宗钢铁电子交易</a></li>
                |
                <li><a href="http://www.hbzydq.com">河北卓越电气有限责任公司</a></li>
                |
                <li><a href="http://wfcg.hgfq.cn">河北邯钢附企公司</a></li>
            </ul>
        </div>

        <div class="copyright">
            <span> Copyright&nbsp;©&nbsp;2015&nbsp;邯郸市众翔信息科技有限公司&nbsp;版权所有&nbsp;&nbsp;&nbsp;&nbsp;<img
                    src="${ctxStatic }/images/wlptfront/police_bar.png" width="2%">京ICP备&nbsp;14028454号</span>
        </div>
    </div>

</footer>