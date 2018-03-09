/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.collection;

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
import com.thinkgem.jeesite.modules.wlpt.biz.collection.CollectionBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.collection.WlptCollection;

/**
 * 我关注的路线信息Controller
 * @author zyj
 * @version 2017-04-19
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/collection/wlptCollection")
public class WlptCollectionController extends BaseController {

	@Autowired
	private CollectionBiz collectionBiz;
	
	@ModelAttribute
	public WlptCollection get(@RequestParam(required=false) String id) {
		WlptCollection entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = collectionBiz.get(id);
		}
		if (entity == null){
			entity = new WlptCollection();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:collection:wlptCollection:view")
	@RequestMapping(value = {"list", ""})
	public String list(WlptCollection wlptCollection, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<WlptCollection> page = collectionBiz.findPage(new Page<WlptCollection>(request, response), wlptCollection); 
		model.addAttribute("page", page);
		return "modules/wlpt/collection/wlptCollectionList";
	}

	@RequiresPermissions("wlpt:collection:wlptCollection:view")
	@RequestMapping(value = "form")
	public String form(WlptCollection wlptCollection, Model model) {
		model.addAttribute("wlptCollection", wlptCollection);
		return "modules/wlpt/collection/wlptCollectionForm";
	}

	@RequiresPermissions("wlpt:collection:wlptCollection:edit")
	@RequestMapping(value = "save")
	public String save(WlptCollection wlptCollection, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, wlptCollection)){
			return form(wlptCollection, model);
		}
		collectionBiz.save(wlptCollection);
		addMessage(redirectAttributes, "保存我的关注成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/collection/wlptCollection/?repage";
	}
	
	@RequiresPermissions("wlpt:collection:wlptCollection:edit")
	@RequestMapping(value = "delete")
	public String delete(WlptCollection wlptCollection, RedirectAttributes redirectAttributes) {
		collectionBiz.delete(wlptCollection);
		addMessage(redirectAttributes, "删除我的关注成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/collection/wlptCollection/?repage";
	}

}