/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.base;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.entity.base.ChinaArea;
import com.thinkgem.jeesite.modules.wlpt.service.base.BaseChinaAreasService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 获取中国地址信息Controller
 * @author 饶江龙
 * @version 2016-07-24
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/base/chinaarea")
public class BaseChinaAreaController extends BaseController {

	@Autowired
	private BaseChinaAreasService baseChinaAreaService;


	
	@ModelAttribute
	public ChinaArea get(@RequestParam(required=false) String id) {
		ChinaArea entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = baseChinaAreaService.get(id);
		}
		if (entity == null){
			entity = new ChinaArea();
		}
		return entity;
	}

	/***
	 * 获取城市信息
	 * @param isSearchHotCity
	 * @param parentCode
     * @return
     */
	@ResponseBody
	@RequestMapping(value = "getArea")
	public List<ChinaArea> getArea(String isSearchHotCity, String parentCode,String code) {
		ChinaArea chinaarea=new ChinaArea();
		chinaarea.setParentcode(parentCode);
		chinaarea.setCode(code);
		if ("true".equals(isSearchHotCity)){
			chinaarea.setIshotcity("1");
		}
			List<ChinaArea> result= baseChinaAreaService.getAreaByCondition(chinaarea);

		return result;
	}
	
	@RequiresPermissions("wlpt:base:chinaarea:view")
	@RequestMapping(value = {"list", ""})
	public String list(ChinaArea chinaarea, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ChinaArea> page = baseChinaAreaService.findPage(new Page<ChinaArea>(request, response), chinaarea);
		model.addAttribute("page", page);
		return "modules/wlpt/base/chinaareaList";
	}

	@RequiresPermissions("wlpt:base:chinaarea:view")
	@RequestMapping(value = "form")
	public String form(ChinaArea chinaarea, Model model) {
		model.addAttribute("chinaarea", chinaarea);
		return "modules/wlpt/base/chinaareaForm";
	}

	@RequiresPermissions("wlpt:base:chinaarea:edit")
	@RequestMapping(value = "save")
	public String save(ChinaArea chinaarea, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, chinaarea)){
			return form(chinaarea, model);
		}
		baseChinaAreaService.save(chinaarea);
		addMessage(redirectAttributes, "保存中国地址成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/chinaarea/?repage";
	}
	
	@RequiresPermissions("wlpt:base:chinaarea:edit")
	@RequestMapping(value = "delete")
	public String delete(ChinaArea chinaarea, RedirectAttributes redirectAttributes) {
		baseChinaAreaService.delete(chinaarea);
		addMessage(redirectAttributes, "删除中国地址成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/chinaarea/?repage";
	}

}