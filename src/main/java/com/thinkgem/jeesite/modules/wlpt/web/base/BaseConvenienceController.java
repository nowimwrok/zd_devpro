/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.base;

import java.util.HashMap;

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

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseConvenience;
import com.thinkgem.jeesite.modules.wlpt.service.base.BaseCategoriesService;
import com.thinkgem.jeesite.modules.wlpt.service.base.BaseConvenienceService;

/**
 * 便民服务Controller
 * @author 王铸
 * @version 2016-08-08
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/base/baseConvenience")
public class BaseConvenienceController extends BaseController {

	@Autowired
	private BaseConvenienceService baseConvenienceService;
	@Autowired
	private BaseCategoriesService baseCategoriesService;
	@ModelAttribute
	public BaseConvenience get(@RequestParam(required=false) String id) {
		BaseConvenience entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = baseConvenienceService.get(id);
		}
		if (entity == null){
			entity = new BaseConvenience();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:base:baseConvenience:view")
	@RequestMapping(value = {"list", ""})
	public String list(BaseConvenience baseConvenience, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BaseConvenience> page = baseConvenienceService.findPage(new Page<BaseConvenience>(request, response), baseConvenience); 
		model.addAttribute("page", page);
		return "modules/wlpt/base/baseConvenienceList";
	}

	@RequiresPermissions("wlpt:base:baseConvenience:view")
	@RequestMapping(value = "form")
	public String form(BaseConvenience baseConvenience, Model model) {
		model.addAttribute("baseConvenience", baseConvenience);
		model.addAttribute("baseCategories", baseCategoriesService.getCategories(DataDic.CONVENIENCE_TYPE));
		return "modules/wlpt/base/baseConvenienceForm";
	}

	@RequiresPermissions("wlpt:base:baseConvenience:edit")
	@RequestMapping(value = "save")
	public String save(BaseConvenience baseConvenience, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, baseConvenience)){
			return form(baseConvenience, model);
		}
		baseConvenienceService.save(baseConvenience);
		addMessage(redirectAttributes, DataDic.SAVE_CONVENIENCE_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/baseConvenience/?repage";
	}
	
	@RequiresPermissions("wlpt:base:baseConvenience:edit")
	@RequestMapping(value = "delete")
	public String delete(BaseConvenience baseConvenience, RedirectAttributes redirectAttributes) {
		baseConvenienceService.delete(baseConvenience);
		addMessage(redirectAttributes, DataDic.DELETE_CONVENIENCE_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/baseConvenience/?repage";
	}
	
	/**
	 * 批量删除
	 * @param
	 * @return
	 */
	@RequiresPermissions("wlpt:base:baseConvenience:edit")
	@RequestMapping(value = "deleteAll")
	public String deleteAll(@RequestParam(required=false) String DATA_IDS,RedirectAttributes redirectAttributes) {
		StringBuilder sb=new StringBuilder();
		String ArrayDATA_IDS[] = DATA_IDS.split(",");
		sb.append("('");
		for (String item : ArrayDATA_IDS) {
			sb.append(item + "','");
		}
		String delteArrayStr = sb.substring(0, sb.lastIndexOf("','"))
				+ "')";
		HashMap<String,String> map=new HashMap<String,String>();
		map.put("delteArrayStr", delteArrayStr);
		baseConvenienceService.deleteAll(map);
		addMessage(redirectAttributes, DataDic.DELETE_CONVENIENCE_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/baseConvenience/?repage";
	}

}