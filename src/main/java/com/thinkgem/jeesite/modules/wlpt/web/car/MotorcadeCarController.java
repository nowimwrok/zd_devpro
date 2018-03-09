/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.web.car;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.entity.car.MotorcadeCar;
import com.thinkgem.jeesite.modules.wlpt.service.car.MotorcadeCarService;
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
 * 车队与车辆关联Controller
 *
 * @author liangweishen
 * @version 2017-08-04
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/motorcadeCar")
public class MotorcadeCarController extends BaseController {

    @Autowired
    private MotorcadeCarService motorcadeCarService;

    @ModelAttribute
    public MotorcadeCar get(@RequestParam(required = false) String id) {
        MotorcadeCar entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = motorcadeCarService.get(id);
        }
        if (entity == null) {
            entity = new MotorcadeCar();
        }
        return entity;
    }

    @RequiresPermissions("wlpt:motorcadeCar:view")
    @RequestMapping(value = {"list", ""})
    public String list(MotorcadeCar motorcadeCar, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<MotorcadeCar> page = motorcadeCarService.findPage(new Page<MotorcadeCar>(request, response), motorcadeCar);
        model.addAttribute("page", page);
        return "modules/wlpt/motorcadeCarList";
    }

    @RequiresPermissions("wlpt:motorcadeCar:view")
    @RequestMapping(value = "form")
    public String form(MotorcadeCar motorcadeCar, Model model) {
        model.addAttribute("motorcadeCar", motorcadeCar);
        return "modules/wlpt/motorcadeCarForm";
    }

    @RequiresPermissions("wlpt:motorcadeCar:edit")
    @RequestMapping(value = "save")
    public String save(MotorcadeCar motorcadeCar, Model model, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, motorcadeCar)) {
            return form(motorcadeCar, model);
        }
        motorcadeCarService.save(motorcadeCar);
        addMessage(redirectAttributes, "保存车队与车辆关联成功");
        return "redirect:" + Global.getAdminPath() + "/wlpt/motorcadeCar/?repage";
    }

    @RequiresPermissions("wlpt:motorcadeCar:edit")
    @RequestMapping(value = "delete")
    public String delete(MotorcadeCar motorcadeCar, RedirectAttributes redirectAttributes) {
        motorcadeCarService.delete(motorcadeCar);
        addMessage(redirectAttributes, "删除车队与车辆关联成功");
        return "redirect:" + Global.getAdminPath() + "/wlpt/motorcadeCar/?repage";
    }

}