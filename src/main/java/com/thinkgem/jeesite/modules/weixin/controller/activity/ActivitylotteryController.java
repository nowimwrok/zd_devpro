package com.thinkgem.jeesite.modules.weixin.controller.activity;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.common.config.DataDic;
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
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityWxinfo;

/**
 * 微信活动Controller
 *
 * @author
 * @version 2016-09-05
 */
@Controller
@RequestMapping(value = "${weixinPath}/weixin/activitylottery")
public class ActivitylotteryController extends BaseController {
	@Autowired
	private ActivityBiz activityBiz;

	/**
	 * 到我的中奖记录页面
	 * @param activityAwardrecord
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = {"toaward", ""})
	public String toaward(ActivityAwardrecord activityAwardrecord,HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("activityAwardrecord", activityAwardrecord);
        return "modules/wx_front/pay/activity";
	}
	
	
	 /**
     * 获取用户自己的中奖纪录
     * @param activityAwardrecord
     * @param pg
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getOwnerAward")
    public Object getOwnerAward(ActivityAwardrecord activityAwardrecord, Page pg, Model model) {

        pg.setLength(4);
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
        return page;
    }
	
	/**
	 * 跳转大转盘抽奖页面
	 */
	@RequestMapping(value = {"lottery", ""})
	public String lottery() {
		return "modules/wx_front/lottery/index";
	}

	/**
	 * 获取活动信息
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="getlotterty")
	public Object getlottery() {
		ActivityWxinfo activityWxinfo =new ActivityWxinfo();
		activityWxinfo.setType(DataDic.ACTIVITY_TYPE_TURNTABLE);
		activityWxinfo.setIseffective(DataDic.ACTIVITY_STATUS_OPEN);
		return activityBiz.getNowActivityBiz(activityWxinfo);

	}



	/* 保存中奖信息
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/savelotterty")
	public Object savelottery(String giftid,String activityid,String phone) {
		User user = UserUtils.getUser();
		String userid = "";
		if(user!=null){
			userid = user.getId();
		}

		return activityBiz.txMethodSaveBiz(giftid,activityid,phone,userid);
	}
}
