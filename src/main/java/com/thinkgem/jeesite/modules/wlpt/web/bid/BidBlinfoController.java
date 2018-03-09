/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.web.bid;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolationException;

import com.thinkgem.jeesite.common.beanvalidator.BeanValidators;
import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.utils.excel.ImportExcel;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidBlinfo;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidBlinfoService;

import java.util.List;

/**
 * 提货单Controller
 *
 * @author 刘欣
 * @version 2016-08-02
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/bid")
public class BidBlinfoController extends BaseController {

    @Autowired
    private BidBlinfoService bidBlinfoService;

    @ModelAttribute
    public BidBlinfo get(@RequestParam(required = false) String id) {
        BidBlinfo entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = bidBlinfoService.get(id);
        }
        if (entity == null) {
            entity = new BidBlinfo();
        }
        return entity;
    }

    /*@RequiresPermissions("wlpt:bid:bidBlinfo:view")*/
    @RequestMapping(value = {"blList", ""})
    public String list(BidBlinfo bidBlinfo, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<BidBlinfo> page = bidBlinfoService.findPage(new Page<BidBlinfo>(request, response), bidBlinfo);
        model.addAttribute("page", page);
        return "modules/wlpt/bid/bidBlinfoList";
    }



    @RequiresPermissions("wlpt:bid:bidBlinfo:view")
    @RequestMapping(value = "form")
    public String form(BidBlinfo bidBlinfo, Model model) {
        model.addAttribute("bidBlinfo", bidBlinfo);
        return "modules/wlpt/bid/bidBlinfoForm";
    }

    @RequiresPermissions("wlpt:bidBiz:bidBlinfo:edit")
    @RequestMapping(value = "save")
    public String save(BidBlinfo bidBlinfo, Model model, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, bidBlinfo)) {
            return form(bidBlinfo, model);
        }
        bidBlinfoService.save(bidBlinfo);
        addMessage(redirectAttributes, "保存提货单成功");
        return "redirect:" + Global.getAdminPath() + "/wlpt/bidBiz/bidBlinfo/?repage";
    }

    @RequiresPermissions("wlpt:bidBiz:bidBlinfo:edit")
    @RequestMapping(value = "delete")
    public String delete(BidBlinfo bidBlinfo, RedirectAttributes redirectAttributes) {
        bidBlinfoService.delete(bidBlinfo);
        addMessage(redirectAttributes, "删除提货单成功");
        return "redirect:" + Global.getAdminPath() + "/wlpt/bidBiz/bidBlinfo/?repage";
    }

}