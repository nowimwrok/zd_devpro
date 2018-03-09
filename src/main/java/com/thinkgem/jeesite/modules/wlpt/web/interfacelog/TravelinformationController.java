/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.wlpt.web.interfacelog;


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
import com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz.TraveBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.Travelinformation;
import com.thinkgem.jeesite.modules.wlpt.service.interfacelog.TravelinformationService;

/**
 * 存储信息Controller
 * @author qiao
 * @version 2017-09-29
 */
@Controller
@RequestMapping(value = "${frontPath}/wlpt/trave")
public class TravelinformationController extends BaseController {

	@Autowired
	private TravelinformationService travelinformationService;
	@Autowired
	private TraveBiz traveBiz;
	
	@ModelAttribute
	public Travelinformation get(@RequestParam(required=false) String id) {
		Travelinformation entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = travelinformationService.get(id);
		}
		if (entity == null){
			entity = new Travelinformation();
		}
		return entity;
	}
	
	
	@RequestMapping(value = {"list", ""})
	public String list(Travelinformation travelinformation, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Travelinformation> page = travelinformationService.findPage(new Page<Travelinformation>(request, response), travelinformation); 
		model.addAttribute("page", page);
		return "modules/wlpt.trave/travelinformationList";
	}


	@RequestMapping(value = "form")
	public String form(Travelinformation travelinformation, Model model) {
		model.addAttribute("travelinformation", travelinformation);
		return "modules/wlpt.trave/travelinformationForm";
	}

	
	@RequestMapping(value = "save")
	public String save(String vclN,String vco, Model model, RedirectAttributes redirectAttributes) {
		Travelinformation travelinformation=traveBiz.traveQuery(vclN, vco);
		if (!beanValidator(model, travelinformation)){
			return form(travelinformation, model);
		}
		travelinformationService.save(travelinformation);
		addMessage(redirectAttributes, "保存保存信息成功成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt.trave/travelinformation/?repage";
	}
	
	
	@RequestMapping(value = "delete")
	public String delete(Travelinformation travelinformation, RedirectAttributes redirectAttributes) {
		travelinformationService.delete(travelinformation);
		addMessage(redirectAttributes, "删除保存信息成功成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt.trave/travelinformation/?repage";
	}

}