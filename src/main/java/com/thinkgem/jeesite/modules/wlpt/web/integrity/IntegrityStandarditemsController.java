/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.integrity;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityStandard;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityStandarditems;
import com.thinkgem.jeesite.modules.wlpt.service.integrity.IntegrityStandardService;
import com.thinkgem.jeesite.modules.wlpt.service.integrity.IntegrityStandarditemsService;

/**
 * 诚信标准评分项Controller
 * @author 刘欣
 * @version 2016-09-13
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/integrity/integrityStandarditems")
public class IntegrityStandarditemsController extends BaseController {

	@Autowired
	private IntegrityStandardService integrityStandardService;
	
	@Autowired
	private IntegrityStandarditemsService integrityStandarditemsService;
	
	@ModelAttribute
	public IntegrityStandarditems get(@RequestParam(required=false) String id) {
		IntegrityStandarditems entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = integrityStandarditemsService.get(id);
		}
		if (entity == null){
			entity = new IntegrityStandarditems();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:integrity:integrityStandarditems:view")
	@RequestMapping(value = {"list", ""})
	public String list(IntegrityStandarditems integrityStandarditems, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<IntegrityStandarditems> page = integrityStandarditemsService.findPage(new Page<IntegrityStandarditems>(request, response), integrityStandarditems); 
		model.addAttribute("page", page);
		return "modules/wlpt/integrity/integrityStandarditemsList";
	}

	@RequiresPermissions("wlpt:integrity:integrityStandarditems:view")
	@RequestMapping(value = "form")
	public String form(IntegrityStandarditems integrityStandarditems, Model model) {
		List<IntegrityStandard> isLst = integrityStandardService.findList(new IntegrityStandard());
		model.addAttribute("isLst", isLst);
		model.addAttribute("integrityStandarditems", integrityStandarditems);
		return "modules/wlpt/integrity/integrityStandarditemsForm";
	}

	@RequiresPermissions("wlpt:integrity:integrityStandarditems:edit")
	@RequestMapping(value = "save")
	public String save(IntegrityStandarditems integrityStandarditems, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, integrityStandarditems)){
			return form(integrityStandarditems, model);
		}
		integrityStandarditemsService.save(integrityStandarditems);
		addMessage(redirectAttributes, "保存诚信标准评分项成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/integrity/integrityStandarditems/?repage";
	}
	
	@RequiresPermissions("wlpt:integrity:integrityStandarditems:edit")
	@RequestMapping(value = "delete")
	public String delete(IntegrityStandarditems integrityStandarditems, RedirectAttributes redirectAttributes) {
		integrityStandarditemsService.delete(integrityStandarditems);
		addMessage(redirectAttributes, "删除诚信标准评分项成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/integrity/integrityStandarditems/?repage";
	}

}