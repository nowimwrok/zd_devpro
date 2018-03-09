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
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseNews;
import com.thinkgem.jeesite.modules.wlpt.service.base.BaseCategoriesService;
import com.thinkgem.jeesite.modules.wlpt.service.base.BaseNewsService;

/**
 * 新闻管理Controller
 * @author 王铸
 * @version 2016-08-04
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/base/baseNews")
public class BaseNewsController extends BaseController {

	@Autowired
	private BaseNewsService baseNewsService;
	@Autowired
	private BaseCategoriesService baseCategoriesService;
	
	@ModelAttribute("baseNews")
	public BaseNews get(@RequestParam(required=false) String id) {
		BaseNews entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = baseNewsService.get(id);
		}
		if (entity == null){
			entity = new BaseNews();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:base:baseNews:view")
	@RequestMapping(value = {"list", ""})
	public String list(BaseNews baseNews, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BaseNews> page = baseNewsService.findPage(new Page<BaseNews>(request, response), baseNews); 
		model.addAttribute("page", page);
		return "modules/wlpt/base/baseNewsList";
	}

	@RequiresPermissions("wlpt:base:baseNews:view")
	@RequestMapping(value = "form")
	public String form(@ModelAttribute("baseNews") BaseNews baseNews, Model model) {
		model.addAttribute("baseNews", baseNews);
		model.addAttribute("baseCategories", baseCategoriesService.getCategories(DataDic.NEWS_TYPE));
		return "modules/wlpt/base/baseNewsForm";
	}

	@RequiresPermissions("wlpt:base:baseNews:edit")
	@RequestMapping(value = "save")
	public String save(BaseNews baseNews, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, baseNews)){
			return form(baseNews, model);
		}
		if (baseNews.getIsNewRecord()){
			baseNews.setReleaseTime(new Date());
		}
		baseNews.setContent(Jsoup.parse(baseNews.getContent()).text());
		baseNewsService.save(baseNews);
		addMessage(redirectAttributes, DataDic.SAVE_NEWS_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/baseNews/?repage";
	}
	
	@RequiresPermissions("wlpt:base:baseNews:edit")
	@RequestMapping(value = "delete")
	public String delete(@ModelAttribute("baseNews") BaseNews baseNews, RedirectAttributes redirectAttributes) {
		baseNewsService.delete(baseNews);
		addMessage(redirectAttributes, DataDic.DELETE_NEWS_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/baseNews/?repage";
	}
	/**
	 * 批量删除
	 * @param
	 * @return
	 */
	@RequiresPermissions("wlpt:base:baseNews:edit")
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
		baseNewsService.deleteAll(map);
		addMessage(redirectAttributes, DataDic.DELETE_NEWS_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/baseNews/?repage";
	}
}