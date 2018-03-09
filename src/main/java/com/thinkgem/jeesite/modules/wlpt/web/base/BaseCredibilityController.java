/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.base;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.jsoup.Jsoup;
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
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseCategories;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseCredibility;
import com.thinkgem.jeesite.modules.wlpt.service.base.BaseCategoriesService;
import com.thinkgem.jeesite.modules.wlpt.service.base.BaseCredibilityService;

/**
 * 物流诚信Controller
 * @author 王铸
 * @version 2016-08-08
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/base/baseCredibility")
public class BaseCredibilityController extends BaseController {

	@Autowired
	private BaseCredibilityService baseCredibilityService;
	@Autowired
	private BaseCategoriesService baseCategoriesService;
	@ModelAttribute
	public BaseCredibility get(@RequestParam(required=false) String id) {
		BaseCredibility entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = baseCredibilityService.get(id);
		}
		if (entity == null){
			entity = new BaseCredibility();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:base:baseCredibility:view")
	@RequestMapping(value = {"list", ""})
	public String list(BaseCredibility baseCredibility, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BaseCredibility> page = baseCredibilityService.findPage(new Page<BaseCredibility>(request, response), baseCredibility); 
		model.addAttribute("page", page);
		return "modules/wlpt/base/baseCredibilityList";
	}

	@RequiresPermissions("wlpt:base:baseCredibility:view")
	@RequestMapping(value = "form")
	public String form(BaseCredibility baseCredibility, Model model) {
		model.addAttribute("baseCredibility", baseCredibility);
		return "modules/wlpt/base/baseCredibilityForm";
	}

	@RequiresPermissions("wlpt:base:baseCredibility:edit")
	@RequestMapping(value = "save")
	public String save(BaseCredibility baseCredibility, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, baseCredibility)){
			return form(baseCredibility, model);
		}
		if (baseCredibility.getIsNewRecord()){
			baseCredibility.setReleaseTime(new Date());//设置发布时间
			BaseCategories baseCategories=new BaseCategories();
			baseCategories.setName(DataDic.CREDIBILITY_TYPE);
			List<BaseCategories> list=baseCategoriesService.getCategoriesByCondition(baseCategories);
			if(list.size()!=0){
				long id=Long.parseLong(list.get(0).getId());//获取CategoryId
				baseCredibility.setCategoryId(id);
			}
		}
		baseCredibility.setContent(Jsoup.parse(baseCredibility.getContent()).text());
		baseCredibilityService.save(baseCredibility);
		addMessage(redirectAttributes, DataDic.SAVE_CREDIBILITY_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/baseCredibility/?repage";
	}
	
	@RequiresPermissions("wlpt:base:baseCredibility:edit")
	@RequestMapping(value = "delete")
	public String delete(BaseCredibility baseCredibility, RedirectAttributes redirectAttributes) {
		baseCredibilityService.delete(baseCredibility);
		addMessage(redirectAttributes, DataDic.DELETE_CREDIBILITY_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/baseCredibility/?repage";
	}
	
	/**
	 * 批量删除
	 * @param
	 * @return
	 */
	@RequiresPermissions("wlpt:base:baseCredibility:edit")
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
		baseCredibilityService.deleteAll(map);
		addMessage(redirectAttributes,DataDic.DELETE_CREDIBILITY_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/baseCredibility/?repage";
	}

}