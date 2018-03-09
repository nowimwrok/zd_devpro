/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.web.goods;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Attach;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Goods;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.service.car.AttachService;
import com.thinkgem.jeesite.modules.wlpt.service.car.CarService;
import com.thinkgem.jeesite.modules.wlpt.service.goods.GoodsService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Quoteinfo;
import com.thinkgem.jeesite.modules.wlpt.service.goods.QuoteinfoService;

import java.util.List;

/**
 * 货源报价管理Controller
 *
 * @author 饶江龙
 * @version 2016-07-25
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/goods/quoteinfo")
public class QuoteinfoController extends BaseController {

    @Autowired
    private QuoteinfoService quoteinfoService;

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private AttachService attachService;

    @Autowired
    private CarService carService;

    @Autowired
    private SystemService systemService;

    @ModelAttribute
    public Quoteinfo get(@RequestParam(required = false) String id) {
        Quoteinfo entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = quoteinfoService.get(id);
        }
        if (entity == null) {
            entity = new Quoteinfo();
        }
        return entity;
    }


    /***
     * 货源报价列表信息
     *
     * @param goods    货源ID
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequestMapping(value = {"quoteList", ""})
    public String quoteList(Goods goods, HttpServletRequest request, HttpServletResponse response, Model model) {
        //quoteinfo.setUser(UserUtils.getUser());
        Quoteinfo quoteinfo = new Quoteinfo();
        quoteinfo.setGoods(goods);
        Page<Quoteinfo> page = quoteinfoService.findPage(new Page<Quoteinfo>(request, response), quoteinfo);
        model.addAttribute("page", page);
        return "modules/wlpt/goods/quoteinfoList";
    }

    /***
     * 去报价生成运单信息
     *
     * @param quoteinfo
     * @param model
     * @return
     */

    @RequestMapping(value = "quoteOrder")
    public String quoteOrder(Quoteinfo quoteinfo, Model model) {
        //quoteinfo.getOddloadweight();
        quoteinfo = quoteinfoService.get(quoteinfo.getId());
        if (quoteinfo != null) {
            Goods goods = goodsService.get(quoteinfo.getGoods().getId());
            quoteinfo.setGoods(goods);
            Orderinfo orderinfo = new Orderinfo();
            orderinfo.setQuoteinfo(quoteinfo);
            model.addAttribute("quoteinfo", quoteinfo);
            model.addAttribute("orderinfo", orderinfo);
        }

        model.addAttribute("quoteinfo", quoteinfo);
        return "modules/wlpt/goods/orderPayinfo";
    }

    /**
     * 验证当前用户是否已报价
     *
     * @param goodsid 货源ID
     * @return status:-1货源信息有误,0:用户请先登录1:正常可以报价2:内部信息3:已报价4:已运输完
     */
    @ResponseBody
    @RequestMapping(value = "validQuote")
    public Integer validQuote(String goodsid) {
        Integer status = 1;
        Quoteinfo quoteinfo = new Quoteinfo();
        ///获取货源信息
        Goods goods = goodsService.get(goodsid);
        if (goods == null) {
            return -1;
        }
        ///是否已报价完
        if (DataDic.GDS_FULLQUOTE.equals(goods.getTradestatus())){
            return 4;
        }
        if (UserUtils.getUser() == null) {
            return 0;
        }

        String gdsuid = goods.getUser().getId();
        quoteinfo.setGoods(goods);
        quoteinfo.setUser(UserUtils.getUser());
        ////是否是内部货源
        if (gdsuid.equals(UserUtils.getUser().getId())) {
            status = 2;
        }
        ///是否已报价
        List<Quoteinfo> result = quoteinfoService.findList(quoteinfo);
        if (result != null && result.size() > 0) {
            status = 3;
        }

        return status;
    }

    /**
     * 去报价页面
     *
     * @param id    获取货物ID
     * @param model
     * @return
     */
    @RequestMapping(value = {"goodsQuote", ""})
    public String goodsQuote(String id, Model model) {
        Goods goods = goodsService.get(id);
        Attach attach = new Attach();
        attach.setUser(UserUtils.getUser());
        attach.setIsagree(DataDic.ATTACH_AGGREE);
        List<Attach> list = attachService.findList(attach);
        ///更新浏览次数
        goodsService.updatePageViews(goods);
        model.addAttribute("goods", goods);
        ///司机
        model.addAttribute("driver", list);

        //获取用户车辆
        model.addAttribute("car", carService.getMyCar());

        return "modules/wlpt/goods/goodsQuote";
    }


    @RequiresPermissions("wlpt:goods:quoteinfo:view")
    @RequestMapping(value = {"list", ""})
    public String list(Quoteinfo quoteinfo, HttpServletRequest request, HttpServletResponse response, Model model) {
        quoteinfo.setUser(UserUtils.getUser());
        Page<Quoteinfo> page = quoteinfoService.findPage(new Page<Quoteinfo>(request, response), quoteinfo);
        model.addAttribute("page", page);
        return "modules/wlpt/goods/quoteinfoList";
    }

    @RequiresPermissions("wlpt:goods:quoteinfo:view")
    @RequestMapping(value = "form")
    public String form(Quoteinfo quoteinfo, Model model) {
        model.addAttribute("quoteinfo", quoteinfo);
        return "modules/wlpt/goods/goodsQuote";
    }

    @RequiresPermissions("wlpt:goods:quoteinfo:edit")
    @RequestMapping(value = "save")
    @Transactional(readOnly = false)
    public String save(Quoteinfo quoteinfo, Model model, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, quoteinfo)) {
            return goodsQuote(quoteinfo.getGoods().getId(), model);
        }
        ///当前用户是报价用户
        quoteinfo.setUser(UserUtils.getUser());
        int vaiStatus = validQuote(quoteinfo.getGoods().getId());
        if (vaiStatus != 1) {
            String message = "报价信息有误";
            switch (vaiStatus) {
                case -1:
                    message = "货源信息有误";
                    break;
                case 0:
                    message = "请登录后报价";
                    break;
                case 2:
                    message = "内部货源信息,无法报价";
                    break;
                case 3:
                    message = "已报价,请勿重复报价";
                    break;
                case 4:
                    message = "货物已运完";
                    break;
            }
            model.addAttribute("message", message);
            return goodsQuote(quoteinfo.getGoods().getId(), model);
        }
        float oodweight = StringUtils.toFloat(quoteinfo.getOddloadweight());
        Goods goods = goodsService.get(quoteinfo.getGoods().getId());
        float reweight = StringUtils.toFloat(goods.getResidualvolume());
        if (oodweight - reweight > 0) {
            model.containsAttribute("报价吨位不足");
            return goodsQuote(quoteinfo.getGoods().getId(), model);
        }
        ///货源报价中
        goods.setTradestatus(DataDic.GDS_QUOTING);
        goodsService.save(goods);
        ///更新货源报价次数
        goodsService.updateQuoteCount(goods);
        quoteinfoService.save(quoteinfo);
        addMessage(redirectAttributes, "保存报价成功");
        return "redirect:" + Global.getAdminPath() + "/wlpt/goods/quoteinfo/list?repage";
    }

    @RequiresPermissions("wlpt:goods:quoteinfo:edit")
    @RequestMapping(value = "delete")
    public String delete(Quoteinfo quoteinfo, RedirectAttributes redirectAttributes) {

        quoteinfoService.delete(quoteinfo);
        addMessage(redirectAttributes, "删除报价成功");
        return "redirect:" + Global.getAdminPath() + "/wlpt/goods/quoteinfo/?repage";
    }

}