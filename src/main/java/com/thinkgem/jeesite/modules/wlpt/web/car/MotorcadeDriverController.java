/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.web.car;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.entity.car.MotorcadeDriver;
import com.thinkgem.jeesite.modules.wlpt.service.car.MotorcadeDriverService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 车队与司机关联Controller
 *
 * @author liangweishen
 * @version 2017-08-04
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/motorcadeDriver")
public class MotorcadeDriverController extends BaseController {

    @Autowired
    private MotorcadeDriverService motorcadeDriverService;

    @ModelAttribute
    public MotorcadeDriver get(@RequestParam(required = false) String id) {
        MotorcadeDriver entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = motorcadeDriverService.get(id);
        }
        if (entity == null) {
            entity = new MotorcadeDriver();
        }
        return entity;
    }

    @RequiresPermissions("wlpt:motorcadeDriver:view")
    @RequestMapping(value = {"list", ""})
    public String list(MotorcadeDriver motorcadeDriver, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<MotorcadeDriver> page = motorcadeDriverService.findPage(new Page<MotorcadeDriver>(request, response), motorcadeDriver);
        model.addAttribute("page", page);
        return "modules/wlpt/motorcadeDriverList";
    }

    @RequiresPermissions("wlpt:motorcadeDriver:view")
    @RequestMapping(value = "form")
    public String form(MotorcadeDriver motorcadeDriver, Model model) {
        model.addAttribute("motorcadeDriver", motorcadeDriver);
        return "modules/wlpt/motorcadeDriverForm";
    }

    @RequiresPermissions("wlpt:motorcadeDriver:edit")
    @RequestMapping(value = "save")
    public String save(MotorcadeDriver motorcadeDriver, Model model, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, motorcadeDriver)) {
            return form(motorcadeDriver, model);
        }
        motorcadeDriverService.save(motorcadeDriver);
        addMessage(redirectAttributes, "保存车队与司机关联成功");
        return "redirect:" + Global.getAdminPath() + "/wlpt/motorcadeDriver/?repage";
    }

    @RequiresPermissions("wlpt:motorcadeDriver:edit")
    @RequestMapping(value = "delete")
    public String delete(MotorcadeDriver motorcadeDriver, RedirectAttributes redirectAttributes) {
        motorcadeDriverService.delete(motorcadeDriver);
        addMessage(redirectAttributes, "删除车队与司机关联成功");
        return "redirect:" + Global.getAdminPath() + "/wlpt/motorcadeDriver/?repage";
    }

}