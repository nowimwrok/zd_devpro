/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.activity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.common.config.DataDic;
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
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityWxgift;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityWxinfo;
import com.thinkgem.jeesite.modules.wlpt.service.activity.ActivityWxgiftService;
import com.thinkgem.jeesite.modules.wlpt.service.activity.ActivityWxinfoService;

/**
 * 活动信息Controller
 * @author 曾煜佳
 * @version 2016-08-04
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/activity/activityWxinfo")
public class ActivityWxinfoController extends BaseController {

	@Autowired
	private SystemService systemService;
	@Autowired
	private ActivityWxinfoService activityWxinfoService;
	
	@Autowired
	private ActivityWxgiftService activityWxgiftService;
	
	@ModelAttribute
	public ActivityWxinfo get(@RequestParam(required=false) String id) {
		ActivityWxinfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = activityWxinfoService.get(id);
		}
		if (entity == null){
			entity = new ActivityWxinfo();
		}
		return entity;
	}
	
	@RequiresPermissions("wlpt:activity:activityWxinfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(ActivityWxinfo activityWxinfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ActivityWxinfo> page = activityWxinfoService.findPage(new Page<ActivityWxinfo>(request, response), activityWxinfo); 
		//获取奖品列表
		List<ActivityWxgift> groupList = activityWxgiftService.findGiftByActivityListId(page);
        
		model.addAttribute("page", page);
		model.addAttribute("groupList", groupList);
		return "modules/wlpt/activity/activityWxinfoList";
	}

	@RequiresPermissions("wlpt:activity:activityWxinfo:view")
	@RequestMapping(value = "form")
	public String form(ActivityWxinfo activityWxinfo, Model model) {
		model.addAttribute("activityWxinfo", activityWxinfo);
		model.addAttribute("allRoles", systemService.findAllRole());
		return "modules/wlpt/activity/activityWxinfoForm";
	}

	@RequiresPermissions("wlpt:activity:activityWxinfo:edit")
	@RequestMapping(value = "save")
	public String save(ActivityWxinfo activityWxinfo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, activityWxinfo)){
			return form(activityWxinfo, model);
		}
		if(Tools.IsNullOrWhiteSpace(activityWxinfo.getId())
				&& DataDic.ACTIVITY_TYPE_TURNTABLE.equals(activityWxinfo.getType())
				&& DataDic.ACTIVITY_STATUS_OPEN.equals(activityWxinfo.getIseffective())){

			ActivityWxinfo awxinfo =new ActivityWxinfo();
			awxinfo.setType(DataDic.ACTIVITY_TYPE_TURNTABLE);
			awxinfo.setIseffective(DataDic.ACTIVITY_STATUS_OPEN);
			List<ActivityWxinfo> list = activityWxinfoService.findList(awxinfo);
			if(list.size()>0){
				addMessage(redirectAttributes, "活动已经存在,请停止其他相同类型的活动");
				return form(activityWxinfo, model);
			}
		}

		//判断当前活动是添加或是修改
		if(Tools.IsNullOrWhiteSpace(activityWxinfo.getId())){
			activityWxinfo.setId(IdGen.uuid());
			activityWxinfo.setIsNewRecord(true);
			activityWxinfo.setUpdatetime(new Date());
			activityWxinfo.setCreatetime(new Date());
		}else {
			activityWxinfo.setUpdateDate(new Date());
		}
		activityWxinfoService.save(activityWxinfo);
		addMessage(redirectAttributes, "保存活动信息成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/activity/activityWxinfo/?repage";
	}
	
	@RequiresPermissions("wlpt:activity:activityWxinfo:edit")
	@RequestMapping(value = "delete")
	public String delete(ActivityWxinfo activityWxinfo, RedirectAttributes redirectAttributes) {
		activityWxinfoService.delete(activityWxinfo);
		addMessage(redirectAttributes, "删除活动信息成功");
		return "redirect:"+Global.getAdminPath()+"/wlpt/activity/activityWxinfo/?repage";
	}

}