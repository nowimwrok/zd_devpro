/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.web.car;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
import com.thinkgem.jeesite.modules.wlpt.entity.car.Attach;
import com.thinkgem.jeesite.modules.wlpt.service.car.AttachService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 司机账户绑定Controller
 *
 * @author 饶江龙
 * @version 2016-07-26
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/car/attach")
public class AttachController extends BaseController {

    @Autowired
    private AttachService attachService;

    @ModelAttribute
    public Attach get(@RequestParam(required = false) String id) {
        Attach entity = null;
        if (StringUtils.isNotBlank(id)) {
            entity = attachService.get(id);
        }
        if (entity == null) {
            entity = new Attach();
        }
        return entity;
    }

    @ResponseBody
    @RequestMapping(value = "getAttachlist")
    public Object getAttachlist(Model model) {
        Map<String,Object> map =new HashMap<>();
        Attach attach = new Attach();
        attach.setUser(UserUtils.getUser());
        attach.setIsagree(DataDic.ATTACH_AGGREE);
        List<Attach> list = attachService.findList(attach);
        map.put("varlist",list);
        return model.addAllAttributes(map);
    }

    @RequiresPermissions("wlpt:car:attach:view")
    @RequestMapping(value = {"list", ""})
    public String list(Attach attach, HttpServletRequest request, HttpServletResponse response, Model model) {
        ////获取当前登录用户的管理司机信息
        attach.setUser(UserUtils.getUser());
        Page<Attach> page = attachService.findPage(new Page<Attach>(request, response), attach);
        model.addAttribute("page", page);
        return "modules/wlpt/car/attachList";
    }

    @RequiresPermissions("wlpt:car:attach:view")
    @RequestMapping(value = "form")
    public String form(Attach attach, Model model) {
        model.addAttribute("attach", attach);
        return "modules/wlpt/car/attachForm";
    }

    @RequiresPermissions("wlpt:car:attach:edit")
    @RequestMapping(value = "save")
    public String save(Attach attach, Model model, RedirectAttributes redirectAttributes) {
        if (!beanValidator(model, attach)) {
            return form(attach, model);
        }
        attachService.save(attach);
        addMessage(redirectAttributes, "保存绑定司机成功");
        return "redirect:" + Global.getAdminPath() + "/wlpt/car/attach/?repage";
    }

    @RequiresPermissions("wlpt:car:attach:edit")
    @RequestMapping(value = "delete")
    public String delete(Attach attach, RedirectAttributes redirectAttributes) {
        attachService.delete(attach);
        addMessage(redirectAttributes, "删除绑定司机成功");
        return "redirect:" + Global.getAdminPath() + "/wlpt/car/attach/?repage";
    }

}