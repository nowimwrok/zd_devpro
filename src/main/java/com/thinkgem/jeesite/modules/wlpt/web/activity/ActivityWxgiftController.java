/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.activity;

import java.util.Date;

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
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityWxgift;
import com.thinkgem.jeesite.modules.wlpt.service.activity.ActivityWxgiftService;

/**
 * 奖品列表Controller
 * @author 曾煜佳
 * @version 2016-08-04
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/activity/activityWxgift")
public class ActivityWxgiftController extends BaseController {

	@Autowired
	private ActivityWxgiftService activityWxgiftService;
	
	@ModelAttribute
	public ActivityWxgift get(@RequestParam(required=false) String id) {
		ActivityWxgift entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = activityWxgiftService.get(id);
		}
		if (entity == null){
			entity = new ActivityWxgift();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:activity:activityWxgift:view")
	@RequestMapping(value = {"list", ""})
	public String list(ActivityWxgift activityWxgift, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ActivityWxgift> page = activityWxgiftService.findPage(new Page<ActivityWxgift>(request, response), activityWxgift); 
		model.addAttribute("page", page);
		return "modules/wlpt/activity/activityWxgiftList";
	}

	@RequiresPermissions("wlpt:activity:activityWxgift:view")
	@RequestMapping(value = "form")
	public String form(ActivityWxgift activityWxgift, Model model) {
		model.addAttribute("activityWxgift", activityWxgift);
		return "modules/wlpt/activity/activityWxgiftForm";
	}

	@RequiresPermissions("wlpt:activity:activityWxgift:edit")
	@RequestMapping(value = "save")
	public String save(ActivityWxgift activityWxgift, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, activityWxgift)){
			return form(activityWxgift, model);
		}
		//判断当前奖品是添加或是修改
		if(Tools.IsNullOrWhiteSpace(activityWxgift.getId())){
			activityWxgift.setId(IdGen.uuid());
			activityWxgift.setIsNewRecord(true);
			activityWxgift.setUpdatetime(new Date());
			activityWxgift.setCreatetime(new Date());
			activityWxgift.setSurplusnum(activityWxgift.getGiftnum());
		}else {
			activityWxgift.setUpdateDate(new Date());
		}
		activityWxgiftService.save(activityWxgift);
		addMessage(redirectAttributes, "保存奖品成功");
		//判断上一个页面是否是活动信息列表
		if(activityWxgift.getPagetype().equals("info")){
			return "redirect:"+Global.getAdminPath()+"/wlpt/activity/activityWxinfo/?repage";
		}
				
		return "redirect:"+Global.getAdminPath()+"/wlpt/activity/activityWxgift/?repage";
	}
	
	@RequiresPermissions("wlpt:activity:activityWxgift:edit")
	@RequestMapping(value = "delete")
	public String delete(ActivityWxgift activityWxgift, RedirectAttributes redirectAttributes) {
		activityWxgiftService.delete(activityWxgift);
		addMessage(redirectAttributes, "删除奖品成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/activity/activityWxgift/?repage";
	}

}