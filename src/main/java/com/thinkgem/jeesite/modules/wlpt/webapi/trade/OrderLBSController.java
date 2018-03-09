package com.thinkgem.jeesite.modules.wlpt.webapi.trade;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.PreciseCompute;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.lbsBiz.FeeDedutionBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.tradeBiz.TradeBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.service.trade.OrderinfoService;

/**
 * 运单定位
 * @author zyj
 *
 */
@Controller
@RequestMapping(value = "${frontPath}/wlpt/orderlbs")
public class OrderLBSController  extends BaseController {
	
	@Autowired
	private TradeBiz tradeBiz;  
	

	
   
	///添加运单信息RedPacket
	/**
	 * 开启定位
	 * @return
	 */
	@RequestMapping(value = "/subinfo")
	@ResponseBody
	public Object submitorderlbs(Orderinfo orderinfo){
		
		return tradeBiz.torderlbs(orderinfo);
	}	


	/*** 
	 * 根据定位参数向上取整统计出定位所花费的金钱
	 * @Description: TODO
	 * @param @param locationRate 定位频率:隔多长时间定位一次
	 * @param @param locationRateType 定位频率类型:1分钟2小时
	 * @param @param locationTimeSection 定位时间长度
	 * @param @param locationTimeSectionType 定位时间类型：1小时2天，从开启定位时候开始算
	 * @param @return   
	 * @return double  
	 * @throws
	 * @author lqz
	 * @date 2015年8月16日
	 */
	public  double getLocationAmount(int locationRate,int locationRateType,int locationTimeSection,int locationTimeSectionType){
	    double LBSCost=0;
	    double result=0;
		try {
			LBSCost = Double.parseDouble(Const.LBS_COST);
			   if(locationTimeSectionType==2){
					if(locationRateType==2){
						result= Math.ceil(locationTimeSection*24/locationRate)*LBSCost;
					}else{
						result=Math.ceil(locationTimeSection*24*60/locationRate)*LBSCost;
					}
				}else{
					if(locationRateType==2){
						result= Math.ceil(locationTimeSection/locationRate)*LBSCost;
					}else{
						result= Math.ceil(locationTimeSection*60/locationRate)*LBSCost;
					}
				}
		}  catch (Exception e) { 
			e.printStackTrace();
		}
	    return result;
	}
}