/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.web.car;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Motorcade;
import com.thinkgem.jeesite.modules.wlpt.service.car.MotorcadeService;
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
 * 车队Controller
 *
 * @author liangweishen
 * @version 2017-08-04
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/motorcade")
public class MotorcadeController extends BaseController {

    @Autowired
    private MotorcadeService motorcadeService;

    @ModelAttribute
    public Motorcade get(@RequestParam(required = false) String id) {
        Motorcade entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = motorcadeService.get(id);
        }
        if (entity == null) {
            entity = new Motorcade();
        }
        return entity;
    }

    @RequiresPermissions("wlpt:motorcade:view")
    @RequestMapping(value = {"list", ""})
    public String list(Motorcade motorcade, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Motorcade> page = motorcadeService.findPage(new Page<Motorcade>(request, response), motorcade);
        model.addAttribute("page", page);
        return "modules/wlpt/motorcadeList";
    }

    @RequiresPermissions("wlpt:motorcade:view")
    @RequestMapping(value = "form")
    public String form(Motorcade motorcade, Model model) {
        model.addAttribute("motorcade", motorcade);
        return "modules/wlpt/motorcadeForm";
    }

    @RequiresPermissions("wlpt:motorcade:edit")
    @RequestMapping(value = "save")
    public String save(Motorcade motorcade, Model model, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, motorcade)) {
            return form(motorcade, model);
        }
        motorcadeService.save(motorcade);
        addMessage(redirectAttributes, "保存车队成功");
        return "redirect:" + Global.getAdminPath() + "/wlpt/motorcade/?repage";
    }

    @RequiresPermissions("wlpt:motorcade:edit")
    @RequestMapping(value = "delete")
    public String delete(Motorcade motorcade, RedirectAttributes redirectAttributes) {
        motorcadeService.delete(motorcade);
        addMessage(redirectAttributes, "删除车队成功");
        return "redirect:" + Global.getAdminPath() + "/wlpt/motorcade/?repage";
    }

}