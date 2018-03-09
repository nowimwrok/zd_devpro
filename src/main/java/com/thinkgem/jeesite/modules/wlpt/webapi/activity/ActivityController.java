package com.thinkgem.jeesite.modules.wlpt.webapi.activity;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.activity.ActivityBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityAwardrecord;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;

/**
 * @author 曾煜佳
 * 活动管理
 */
@Controller
@RequestMapping(value = "${frontPath}/wlpt/activity")
public class ActivityController extends BaseController {

	@Autowired
	private ActivityBiz activityBiz;
	
	/**
	 * 到中奖记录页面
	 * @param activityAwardrecord
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
    @RequestMapping(value = {"awardrecord_list", ""})
    public String awardrecord_list(ActivityAwardrecord activityAwardrecord,HttpServletRequest request, HttpServletResponse response, Model model) {

        model.addAttribute("activityAwardrecord", activityAwardrecord);
        return "modules/user_front/activity/awardrecord_list";
    }

    /**
     * 获取中奖记录
     * @param activityAwardrecord
     * @param pageNo
     * @param pageSize
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getAwardrecordList")
    public Object getAwardrecordList(ActivityAwardrecord activityAwardrecord, int pageNo, int pageSize, Model model) {
        Page pg = new Page();
        pg.setLength(4);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        //
        ////获取当前用户
        User curUser = UserUtils.getUser();
        if (curUser == null) {
            return null;
        }
        //activityAwardrecord.setUser(curUser);
        activityAwardrecord.setPhone(curUser.getPhone());
        Page<ActivityAwardrecord> page = activityBiz.awardrecordFindPage(pg, activityAwardrecord);
        for (ActivityAwardrecord awardrecord : page.getList()) {
        	awardrecord.setIssuename(DictUtils.getDictLabel(awardrecord.getIssue(), "issue", ""));
        	awardrecord.setGifttypename((DictUtils.getDictLabel(awardrecord.getWxgift().getGifttype(), "gifttype", "")));
        }
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }
}
