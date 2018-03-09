package com.thinkgem.jeesite.modules.wlpt.webapi.lbsInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.biz.lbsBiz.LBSInfoBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.lbs.LbsLocationinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.lbs.LbsWhitelist;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;


/**
 * lbs定位类
 * @author zyj
 *
 */
@Controller
@RequestMapping(value="${frontPath}/wlpt/lbsinfo")
public class LBSInfoController extends BaseController {
	@Autowired
	private LBSInfoBiz lbsInfoBiz ;
	
	
	///添加定位白名单
	@RequestMapping(value = "/addLbs")
	@ResponseBody
	public Object addLbs(String mobile){
		LbsWhitelist whiteList = new LbsWhitelist();
		whiteList.setMobile(mobile);
		return lbsInfoBiz.addLbs(whiteList);
	}
    ///获取定位信息
	@RequestMapping(value = "/getlocation")
	@ResponseBody
	public Object getlocation(LbsLocationinfo lbsLocationinfo,String orderNo, Model model){
		
		Orderinfo orderinfo = new Orderinfo();
		orderinfo.setOrderno(orderNo);
		Page pg = new Page();
        pg.setLength(4);
        pg.setPageNo(1);
        pg.setPageSize(Integer.MAX_VALUE);
		return lbsInfoBiz.getlocation(orderinfo, lbsLocationinfo, pg);
	}
	
	@ResponseBody 
	@RequestMapping(value="/sendLocation",  produces = "application/json;charset=UTF-8")
	public Object sendLocation(String mobile,String carnumber,String orderId){
		return lbsInfoBiz.sendLocation(mobile, carnumber, orderId);
	}


	
	@ResponseBody 
	@RequestMapping(value="/SendList",  produces = "application/json;charset=UTF-8")
	public String SendList(String mobile,String carnumber){
		return lbsInfoBiz.SendList(mobile, carnumber);
	}
}
