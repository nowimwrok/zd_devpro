/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.interfacelog;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz.InterfaceLogBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.InterfaceLog;
import com.thinkgem.jeesite.modules.wlpt.service.interfacelog.InterfaceLogService;

/**
 * 接口调用日志信息Controller
 * 
 * @author W
 * @version 2017-10-16
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/interfacelog/interfaceLog")
public class InterfaceLogController extends BaseController {

	@Autowired
	private InterfaceLogService interfaceLogService;
	@Autowired
	private InterfaceLogBiz interfaceLogBiz;

	@ModelAttribute
	public InterfaceLog get(@RequestParam(required = false) String id) {
		InterfaceLog entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = interfaceLogService.get(id);
		}
		if (entity == null) {
			entity = new InterfaceLog();
		}
		return entity;
	}

	@RequestMapping(value = { "list", "" })
	public String list(InterfaceLog interfaceLog, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		Page<InterfaceLog> page = interfaceLogService.findPage(new Page<InterfaceLog>(request, response), interfaceLog);
		model.addAttribute("page", page);
		List<InterfaceLog> inter = interfaceLogBiz.statistical();
		model.addAttribute("page1", inter);
		return "modules/user_front/interfacelog/interfaceLogList";
	}

	public String form(InterfaceLog interfaceLog, Model model) {
		model.addAttribute("interfaceLog", interfaceLog);
		return "modules/user_front/interfacelog/interfaceLogForm";
	}

	public String save(InterfaceLog interfaceLog, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, interfaceLog)) {
			return form(interfaceLog, model);
		}
		interfaceLogService.save(interfaceLog);
		addMessage(redirectAttributes, "保存接口调用日志信息成功");
		return "redirect:" + Global.getAdminPath() + "/wlpt/interfacelog/interfaceLog/?repage";
	}

	public String delete(InterfaceLog interfaceLog, RedirectAttributes redirectAttributes) {
		interfaceLogService.delete(interfaceLog);
		addMessage(redirectAttributes, "删除接口调用日志信息成功");
		return "redirect:" + Global.getAdminPath() + "/wlpt/interfacelog/interfaceLog/?repage";
	}

}