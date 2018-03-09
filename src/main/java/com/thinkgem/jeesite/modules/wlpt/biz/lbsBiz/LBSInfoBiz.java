package com.thinkgem.jeesite.modules.wlpt.biz.lbsBiz;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.utils.Enum.FeeDecutionWay;
import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.LBSUtil;
import com.thinkgem.jeesite.common.utils.PageData;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.lbs.LbsLocationinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.lbs.LbsWhitelist;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.service.lbs.LbsLocationinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.lbs.LbsReslogService;
import com.thinkgem.jeesite.modules.wlpt.service.lbs.LbsWhitelistService;
import com.thinkgem.jeesite.modules.wlpt.service.trade.OrderinfoService;

/**
 * lbs定位
 * 
 * @author 曾煜佳
 * @version 2016-10-19
 *
 */
@Service
@Transactional(readOnly = true)
public class LBSInfoBiz {

	
	//定位信息locationinfoService 
	@Autowired
	private LbsLocationinfoService locationinfoService;
	
	@Autowired
	private OrderinfoService orderService;
	
	@Autowired
	private LbsWhitelistService whiteListService;
	
	@Autowired
	private LbsReslogService reslogService;
	
	@Autowired
	private FeeDedutionBiz feeDedutionbiz;
	 
	
	///添加定位白名单
	@Transactional(readOnly = false)
	public Object addLbs(LbsWhitelist whiteList){
		int state= DataDic.RETURN_STATUS_NORMAL;
		String message = "保存成功";
		User user = UserUtils.getUser();
		try {
			List<LbsWhitelist> wl=whiteListService.findList(whiteList);
			
			//加入白名单
			if(wl.size()<=0){
				String lbsInfo1=Tools.readTxtFileForThread(Const.LBSINFO);
				String[] config = lbsInfo1.split(",");
				String companyId=config[2];
				String companyPwd=config[3];
				whiteList.setIsNewRecord(true);
				whiteList.setId(IdGen.uuid());
				whiteList.setIsdelete(DataDic.DEL_FLAG_NORMEL);
				whiteList.setRegistertime(new Date());
				whiteList.setCreatetime(new Date());
				whiteList.setCompanyid(companyId);
				whiteList.setCompanypwd(companyPwd);
				whiteListService.save(whiteList);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			message = "保存失败";
			state = DataDic.RETURN_STATUS_INFOBUG;
		}
		return Tools.getMapResult(state, message, null);
	}
	
    ///获取定位信息
	@Transactional(readOnly = false)
	public Object getlocation(Orderinfo orderinfo,LbsLocationinfo lbsLocationinfo,Page page){
		int state= DataDic.RETURN_STATUS_NORMAL;
		String message = "定位成功";
		
		Orderinfo order= new Orderinfo();
		Page<LbsLocationinfo> location=null;
		try {
			///获取订单信息
			order=orderService.getByOrderinfo(orderinfo);
			if(order==null){
				message = "运单不存在";
				state = DataDic.RETURN_STATUS_INFOBUG;
				return Tools.getMapResult(state, message, location);
			}
			lbsLocationinfo.setTradeorderid(order.getId());
			lbsLocationinfo.setMobile(order.getLocationmobile());
			location=locationinfoService.findPage(page, lbsLocationinfo);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return Tools.getMapResult(state, message, location);
	}
	@Transactional(readOnly = false)
	public Object sendLocation(String mobile,String carnumber,String orderId){
		
		PageData locationPd=new PageData();
		boolean isFeeDeduction=true;
		int state= 2;
		String message = "定位成功";
		try{
			User user=UserUtils.getUser();
			
			String userip=UserUtils.getRequest().getRemoteHost();
		
			if(!Tools.IsNullOrWhiteSpace(mobile)){ 
				Double LBSCost = Double.parseDouble(Const.LBS_COST);
				locationPd=feeDedutionbiz.txMethodSendLocation(mobile, carnumber, "",user.getLoginName(),userip
						,user.getId(),FeeDecutionWay.CoinBalance, LBSCost,true);
				 if(!Tools.IsNullOrWhiteSpace(locationPd.getString("errormessage")))
				locationPd=feeDedutionbiz.txMethodSendLocation(mobile, carnumber, "",user.getLoginName(),userip
					,user.getId(),FeeDecutionWay.WebBalance, LBSCost,true);
			
				if(!Tools.IsNullOrWhiteSpace(locationPd.getString("errormessage"))){
					state = DataDic.RETURN_STATUS_SYSBUG;
					message =locationPd.getString("errormessage");
				}else{
				String res = locationPd.getString("resid");
				if(Integer.valueOf(res) == 0){ //定位成功
					/*data.put("locationInfo", locationPd.getString("locationaddr"));
					data.put("locationTime", locationPd.getString("locationtime"));*/
					message =locationPd.getString("resmsg");
					state= 2;
				}else if(Integer.valueOf(res) == -1){
					state = DataDic.RETURN_STATUS_SYSBUG;
					message =locationPd.getString("resmsg");
					
					locationPd=LBSUtil.SendList(mobile, carnumber, 1,user.getLoginName(),userip);
					if(Integer.valueOf(locationPd.getString("resid")) != 1){
						message =locationPd.getString("resmsg");
					}
				}else if(Integer.valueOf(res) == -2){
					state = DataDic.RETURN_STATUS_SYSBUG;
					message = locationPd.getString("resmsg");
					
				}else{
					state = DataDic.RETURN_STATUS_SYSBUG;
					message = "未知错误，请联系客服。";
				}
			}}else{
				message = "请绑定定位号码";
				state = DataDic.RETURN_STATUS_SYSBUG;
				isFeeDeduction=false;
			}
		} catch(Exception e){
			e.printStackTrace();
			message = "定位失败";
			state = DataDic.RETURN_STATUS_SYSBUG;
			isFeeDeduction=false;
		}
		
        /*if(isFeeDeduction){
        	feeDedutionbiz.feeDeduction(orderId,FeeDecutionWay.GuaranteeMoney,1);
        }*/
		return Tools.getMapResult(state, message, null);
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
   @Transactional(readOnly = false)
   public void getSendList(LbsWhitelist whiteList){
	   //PageData result=LBSUtil.SendList(whiteList.getMobile(), "", 2,"","");  
	  //获取定位成功,并且状态不同更新状态
	  /*if(result.get("result").equals("1")&&
			  (result.get("wliststatus").equals("2")))
	 {*/
		  whiteList.setReplytime(new Date());
		  whiteList.setIsreply("y");
		  try {
			whiteListService.save(whiteList);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	 /*}*/ 
   }
   @Transactional(readOnly = false)
	public String SendList(String mobile,String carnumber){
		PageData locationPd=new PageData();
		String result="success"; 
		 
		try{
			
			if(!Tools.IsNullOrWhiteSpace(mobile)){
				locationPd=LBSUtil.SendList(mobile, carnumber, 2,"","");
				result=locationPd.getString("resid");
				if(locationPd.get("resid").equals("1")){
					LbsWhitelist whiteList = new LbsWhitelist();
					whiteList.setMobile(mobile);
					getSendList(whiteList);
				}
			}
		} catch(Exception e){

			result="error"; 
		}
		

		return result;
	}
}
