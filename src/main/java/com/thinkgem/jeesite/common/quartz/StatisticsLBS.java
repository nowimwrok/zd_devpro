package com.thinkgem.jeesite.common.quartz;

import java.util.Date;
import java.util.List;

import org.quartz.JobDetail;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.utils.LBSUtil;
import com.thinkgem.jeesite.common.utils.PageData;
import com.thinkgem.jeesite.common.utils.ServiceHelper;
import com.thinkgem.jeesite.modules.wlpt.biz.lbsBiz.FeeDedutionBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.lbs.LbsWhitelist;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.service.lbs.LbsLocationinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.lbs.LbsRecentlocationinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.lbs.LbsReslogService;
import com.thinkgem.jeesite.modules.wlpt.service.lbs.LbsWhitelistService;
import com.thinkgem.jeesite.modules.wlpt.service.trade.OrderinfoService;

/**
 * 运单lbs定位任务
 * @author asus
 *
 */
@Transactional(readOnly = true)
public class StatisticsLBS  extends BaseQuartzJobBean{


	LbsWhitelistService whiteListService=ServiceHelper.getLbsWhitelistService();
	OrderinfoService orderService=ServiceHelper.getOrderinfoService();
	FeeDedutionBiz feeDedutionService= ServiceHelper.getFeeDedutionService();
	
    String USERNAME="网站定时任务",USERIP="127.0.0.1";
	protected void executeInternal(JobExecutionContext context)throws JobExecutionException { 
	   /*//白名单不是回复状态就查询
	   LbsWhitelist whiteList=new LbsWhitelist();
	   whiteList.setIsdelete(DataDic.DEL_FLAG_NORMEL);*/
	   
	   try{
		   /*List<LbsWhitelist> whiteLists=whiteListService.findList(whiteList);*/
		   //通过查找所有订单去定位
		    JobDetail job= context.getJobDetail();
		    String orderNo = context.getJobDetail().getName(); 
		    Orderinfo orderinfo = new Orderinfo();
		    orderinfo.setOrderno(orderNo);
		    List<Orderinfo> orders=orderService.findLocationOrder(orderinfo);
		    for(Orderinfo order : orders){
		    	    try{
		    		if(order.getOrderno().equals(orderNo))
		    	    	getSendLocation(order);  
		    	    }catch(Exception ex){
		    	    	ex.printStackTrace();
		    	    }
			    Thread.sleep(1000 * 60 * 1);
		    } 
	   }catch(Exception ex){
			  ex.printStackTrace();
	   }
	}
	
   /***
    * 获取手机的白名单状态	
    * @Description: TODO
    * @param @param whiteList   
    * @return void  
    * @throws
    * @author zyj
    * @date 2016年10月10日
    */
   public void getSendList(LbsWhitelist whiteList){
	   PageData result=LBSUtil.SendList(whiteList.getMobile(), "", 2,"","");  
	  //获取定位成功,并且状态不同更新状态
	  if(result.get("resid").equals("1")&&
			  (result.get("wliststatus").equals("2")))
	 {
		  whiteList.setReplytime(new Date());
		  whiteList.setIsreply("Y");
		  try {
			whiteListService.save(whiteList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 } 
   }
   
   
 
/***
   * 获取手机的定位并存入日志表
   * @Description: TODO
   * @param @param whiteList   
   * @return void  
   * @throws
   * @author zyj
   * @date 2016年10月10日
   */
   @Transactional(readOnly = false)
  public void getSendLocation(Orderinfo order){
	  PageData result=LBSUtil.SendLocation(order.getLocationmobile(),
			  order.getQuoteinfo().getCar().getCarnumber(),order.getId(),USERNAME,USERIP,true); 
	  //根据定位结果修改订单状态,账号余额不足关闭定时定位 
	  if(result.getString("resid").equals("0"))
	  {
			try {
				  feeDedutionService.feeDeductionOrder( order);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	
      }
   }
	
}
