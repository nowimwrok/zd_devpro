/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.base;

import java.util.Date;
import java.util.HashMap;

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
import com.thinkgem.jeesite.modules.wlpt.entity.base.BasePolicy;
import com.thinkgem.jeesite.modules.wlpt.service.base.BaseCategoriesService;
import com.thinkgem.jeesite.modules.wlpt.service.base.BasePolicyService;

/**
 * 政策公告Controller
 * @author 王铸
 * @version 2016-08-04
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/base/basePolicy")
public class BasePolicyController extends BaseController {

	@Autowired
	private BasePolicyService basePolicyService;
	@Autowired
	private BaseCategoriesService basecategoriesService;
	@ModelAttribute("basePolicy")
	public BasePolicy get(@RequestParam(required=false) String id) {
		BasePolicy entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = basePolicyService.get(id);
		}
		if (entity == null){
			entity = new BasePolicy();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:base:basePolicy:view")
	@RequestMapping(value = {"list", ""})
	public String list(BasePolicy basePolicy, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BasePolicy> page = basePolicyService.findPage(new Page<BasePolicy>(request, response), basePolicy); 
		model.addAttribute("page", page);
		return "modules/wlpt/base/basePolicyList";
	}

	@RequiresPermissions("wlpt:base:basePolicy:view")
	@RequestMapping(value = "form")
	public String form(@ModelAttribute("basePolicy") BasePolicy basePolicy, Model model) {
		model.addAttribute("basePolicy", basePolicy);
		model.addAttribute("baseCategories", basecategoriesService.getCategories(DataDic.POLICY_TYPE));
		return "modules/wlpt/base/basePolicyForm";
	}

	@RequiresPermissions("wlpt:base:basePolicy:edit")
	@RequestMapping(value = "save")
	public String save(BasePolicy basePolicy, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, basePolicy)){
			return form(basePolicy, model);
		}
		if (basePolicy.getIsNewRecord()){
			basePolicy.setReleaseTime(new Date());
		}
		basePolicy.setContent(Jsoup.parse(basePolicy.getContent()).text());
		basePolicyService.save(basePolicy);
		addMessage(redirectAttributes, DataDic.SAVE_POLICY_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/basePolicy/?repage";
	}
	
	@RequiresPermissions("wlpt:base:basePolicy:edit")
	@RequestMapping(value = "delete")
	public String delete(@ModelAttribute("basePolicy") BasePolicy basePolicy, RedirectAttributes redirectAttributes) {
		basePolicyService.delete(basePolicy);
		addMessage(redirectAttributes, DataDic.DELETE_POLICY_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/basePolicy/?repage";
	}
	/**
	 * 批量删除
	 * @param
	 * @return
	 */
	@RequiresPermissions("wlpt:base:basePolicy:edit")
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
		basePolicyService.deleteAll(map);
		addMessage(redirectAttributes, DataDic.DELETE_POLICY_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/basePolicy/?repage";
	}
}