/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.base;

import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

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
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscFriendlylink;
import com.thinkgem.jeesite.modules.wlpt.service.base.BscFriendlylinkService;

/**
 * 友情链接Controller
 * @author 王铸
 * @version 2016-08-09
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/base/bscFriendlylink")
public class BscFriendlylinkController extends BaseController {

	@Autowired
	private BscFriendlylinkService bscFriendlylinkService;
	
	@ModelAttribute
	public BscFriendlylink get(@RequestParam(required=false) String id) {
		BscFriendlylink entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bscFriendlylinkService.get(id);
		}
		if (entity == null){
			entity = new BscFriendlylink();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:base:bscFriendlylink:view")
	@RequestMapping(value = {"list", ""})
	public String list(BscFriendlylink bscFriendlylink, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BscFriendlylink> page = bscFriendlylinkService.findPage(new Page<BscFriendlylink>(request, response), bscFriendlylink); 
		model.addAttribute("page", page);
		return "modules/wlpt/base/bscFriendlylinkList";
	}

	@RequiresPermissions("wlpt:base:bscFriendlylink:view")
	@RequestMapping(value = "form")
	public String form(BscFriendlylink bscFriendlylink, Model model) {
		model.addAttribute("bscFriendlylink", bscFriendlylink);
		return "modules/wlpt/base/bscFriendlylinkForm";
	}

	@RequiresPermissions("wlpt:base:bscFriendlylink:edit")
	@RequestMapping(value = "save")
	public String save(BscFriendlylink bscFriendlylink, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bscFriendlylink)){
			return form(bscFriendlylink, model);
		}
		if (bscFriendlylink.getIsNewRecord()){
			bscFriendlylink.setFriendlylinkId(UUID.randomUUID().toString().trim().replaceAll("-", ""));
			bscFriendlylink.setCreatetime(new Date());
			bscFriendlylink.setUpdatetime(new Date());
		}else{
			bscFriendlylink.setUpdatetime(new Date());
		}
		bscFriendlylinkService.save(bscFriendlylink);
		addMessage(redirectAttributes,DataDic.SAVE_FRIENDLYLINK_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/bscFriendlylink/?repage";
	}
	
	@RequiresPermissions("wlpt:base:bscFriendlylink:edit")
	@RequestMapping(value = "delete")
	public String delete(BscFriendlylink bscFriendlylink, RedirectAttributes redirectAttributes) {
		bscFriendlylinkService.delete(bscFriendlylink);
		addMessage(redirectAttributes, DataDic.DELETE_FRIENDLYLINK_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/bscFriendlylink/?repage";
	}
	
	/**
	 * 批量删除
	 * @param
	 * @return
	 */
	@RequiresPermissions("wlpt:base:bscFriendlylink:edit")
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
		bscFriendlylinkService.deleteAll(map);
		addMessage(redirectAttributes,DataDic.DELETE_FRIENDLYLINK_SUCCES);
		return "redirect:"+Global.getAdminPath()+"/wlpt/base/bscFriendlylink/?repage";
	}

}