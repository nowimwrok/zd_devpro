package com.thinkgem.jeesite.common.utils;

import com.thinkgem.jeesite.modules.sms.service.SendLogService;
import com.thinkgem.jeesite.modules.sms.service.TemplateService;
import com.thinkgem.jeesite.modules.sys.service.CarSyncService;
import com.thinkgem.jeesite.modules.wlpt.biz.IntegrityBiz.IntegrityBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.base.BaseJobLogBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.base.JobAccountBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.base.JobBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.carBiz.CarSourceBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.lbsBiz.FeeDedutionBiz;
import com.thinkgem.jeesite.modules.wlpt.service.activity.ActivityAwardrecordService;
import com.thinkgem.jeesite.modules.wlpt.service.base.BcIdGeneratorService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidBlinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidOrderinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BiddinginfoService;
import com.thinkgem.jeesite.modules.wlpt.service.bid.BidinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.car.CarService;
import com.thinkgem.jeesite.modules.wlpt.service.consume.ConsumerecodService;
import com.thinkgem.jeesite.modules.wlpt.service.exchange.UserPetrolExchangeService;
import com.thinkgem.jeesite.modules.wlpt.service.lbs.LbsLocationinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.lbs.LbsRecentlocationinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.lbs.LbsReslogService;
import com.thinkgem.jeesite.modules.wlpt.service.lbs.LbsWhitelistService;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsAuthenService;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsBusinessService;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsCarService;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsRegisterService;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsRoleService;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsScoreService;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsTradeflowService;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsTradetypeService;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsUsermoneyService;
import com.thinkgem.jeesite.modules.wlpt.service.trade.OrderinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserAccountService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserApplicationAccountService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserStatisticsService;

/**
 * @author Administrator
 * 获取Spring容器中的service bean
 */
public final class ServiceHelper {
	
	public static Object getService(String serviceName){
		//WebApplicationContextUtils.
		return Const.WEB_APP_CONTEXT.getBean(serviceName);
	}
	/**
	 * @Description: 短信发送日志表 
	 * @return SmsSendLogService  
	 * @throws
	 * @author 饶江龙
	 * @date 2015年5月8日
	 */
	public static SendLogService getSmssendLogService(){
		return (SendLogService) getService("sendLogService");
	}

	/***
	 * 获取短信模版
	 * @return
     */
	public static TemplateService getSmstemplateService(){
		return (TemplateService)getService("templateService");
	}

	

	public static ConsumerecodService getConsumeService(){
		return (ConsumerecodService) getService("consumerecodService");
	}

	public static BidBlinfoService getBlinfoService(){
		return (BidBlinfoService) getService("bidBlinfoService");
	}

	public static BidOrderinfoService getBidOrderService(){
		return (BidOrderinfoService) getService("bidOrderinfoService");
	}

	public static BidinfoService getBidinfoService(){
		return (BidinfoService) getService("bidinfoService");
	}

	public static BiddinginfoService getBiddingService(){
		return (BiddinginfoService) getService("biddinginfoService");
	}

	public static UserPetrolExchangeService getUserPetrolExchangeService(){
		return (UserPetrolExchangeService) getService("userPetrolExchangeService");
	}

	public static ActivityAwardrecordService getActivityAwardrecordService(){
		return (ActivityAwardrecordService) getService("activityAwardrecordService");
	}
	
	/**
	 * 获取任务
	 * @return
	 */
	public static JobBiz getJobService(){
		return (JobBiz) getService("jobBiz");
	}

	/**
	 * 任务日志
	 * @return
	 */
	public static BaseJobLogBiz getJobLogService(){
		return (BaseJobLogBiz) getService("baseJobLogBiz");
	}
	
	
	/**
	 * 用户认证统计
	 * @return
	 */
	public static StatisticsAuthenService getStatisticsAuthenService(){
		return (StatisticsAuthenService) getService("statisticsAuthenService");
	}
	
	/**
	 * 业务数据统计
	 * @return
	 */
	public static StatisticsBusinessService getStatisticsBusinessService(){
		return (StatisticsBusinessService) getService("statisticsBusinessService");
	}
	
	/**
	 * 平台车辆统计
	 * @return
	 */
	public static StatisticsCarService getStatisticsCarService(){
		return (StatisticsCarService) getService("statisticsCarService");
	}
	
	/**
	 * 注册统计
	 * @return
	 */
	public static StatisticsRegisterService getStatisticsRegisterService(){
		return (StatisticsRegisterService) getService("statisticsRegisterService");
	}
	
	/**
	 * 角色会员总量统计
	 * @return
	 */
	public static StatisticsRoleService getStatisticsRoleService(){
		return (StatisticsRoleService) getService("statisticsRoleService");
	}
	
	/**
	 * 诚信积分统计
	 * @return
	 */
	public static StatisticsScoreService getStatisticsScoreService(){
		return (StatisticsScoreService) getService("statisticsScoreService");
	}
	
	/**
	 * 运输流向统计
	 * @return
	 */
	public static StatisticsTradeflowService getStatisticsTradeflowService(){
		return (StatisticsTradeflowService) getService("statisticsTradeflowService");
	}
	
	/**
	 * 货源运输量统计
	 * @return
	 */
	public static StatisticsTradetypeService getStatisticsTradetypeService(){
		return (StatisticsTradetypeService) getService("statisticsTradetypeService");
	}
	
	/**
	 * 账户资金统计
	 * @return
	 */
	public static StatisticsUsermoneyService getStatisticsUsermoneyService(){
		return (StatisticsUsermoneyService) getService("statisticsUsermoneyService");
	}
	
	
	/**
	 * 统计诚信
	 * @return
	 */
	public static IntegrityBiz getIntegrityBiz(){
		return (IntegrityBiz) getService("integrityBiz");
	}
	/**
	 * 账户资金统计
	 * @return
	 */
	public static UserStatisticsService getUserStatisticsService(){
		return (UserStatisticsService) getService("userStatisticsService");
	}
	
	/**
	 * 用户认证统计
	 * @return
	 */
	public static CarSourceBiz getCarSourceBiz(){
		return (CarSourceBiz) getService("carSourceBiz");
	}
	
	/**
	 * 账户系统办卡
	 * @return
	 */
	public static UserApplicationAccountService getUserApplicationAccountService(){
		return (UserApplicationAccountService) ServiceHelper.getService("userApplicationAccountService");
	}
	
	
//	/**
//	public static RatingScaleService getRatingScaleService(){
//		return (RatingScaleService) getService("ratingscaleService");
//	}
//	public static  DataGeneralizationService getDataGeneralizationService(){
//		return (DataGeneralizationService) getService("datageneralizationService");
//	}
//	
//	public static  OwnerService getOwnerService(){
//		return (OwnerService) getService("ownerService");
//	}
//	
//	public static  SearchService getSearchService(){
//		return (SearchService) getService("searchService");
//	} 
//	public static  CatchSendSourceService getCatchSendSourceService(){
//		return (CatchSendSourceService) getService("catchsendsourceService");
//	}
//	public static  GoodsService getGoodsService(){
//		return (GoodsService) getService("goodsService");
//	} 
//	
//	
//	public static  CatchCarSourceService getCatchCarSourceService(){
//		return (CatchCarSourceService) getService("catchcarsourceService");
//	}
//	public static  CarSourceService getCarSourceService(){
//		return (CarSourceService) getService("carsourceService");
//	} 
//	public static  LineInfoService getLineInfoService(){
//		return (LineInfoService) getService("lineinfoService");
//	} 
	public static  CarService getCarService(){
		return (CarService) getService("carService");
	}
//	public static ChinaAreaService getChinaAreaService()
//	{
//		return  (ChinaAreaService) getService("chinaAreaService");
//	}
//	
//	public static  FillInUserService getFillInUserService(){
//		return (FillInUserService) getService("fillinuserService");
//	}
//	
//	public static  UserSubscriptionService getUserSubscriptionService(){
//		return (UserSubscriptionService) getService("usersubscriptionService");
//	}
//	public static  TxMessageService getTxMessageService(){
//		return (TxMessageService) getService("txMessageService");
//	}
//	public static  MessageConfigService getMessageConfigService(){
//		return (MessageConfigService) getService("messageconfigService");
//	}
//	public static  UserMessageService getUserMessageService(){
//		return (UserMessageService) getService("usermessageService");
//	}
//	public static  CatchCarSourceCheWangService getCatchCarSourceCheWangService(){
//		return (CatchCarSourceCheWangService) getService("catchcarsourcechewangService");
//	}
	public static  LbsWhitelistService getLbsWhitelistService(){
		return (LbsWhitelistService) getService("lbsWhitelistService");
	}
	public static  LbsReslogService getLbsReslogService(){
		return (LbsReslogService) getService("lbsReslogService");
	}
	public static  LbsLocationinfoService getLbsLocationinfoService(){
		return (LbsLocationinfoService) getService("lbsLocationinfoService");
	}
//	public static  FriendlyLinkService getFriendlylinkService(){
//		return (FriendlyLinkService) getService("friendlylinkService");
//	}
//	
	public static  LbsRecentlocationinfoService getRecentlocationinfoService(){
		return (LbsRecentlocationinfoService) getService("lbsRecentlocationinfoService");
	}
	public static  OrderinfoService getOrderinfoService(){
		return (OrderinfoService) getService("orderinfoService");
	}
	
	public static  OrderinfoService getOrderService(){
		return (OrderinfoService) getService("orderinfoService");
	}

//	
//	public static  InterfaceconfigService getInterfaceconfigService(){
//		return (InterfaceconfigService) getService("interfaceconfigService");
//	}
//	
//	public static  AppVersionService getAppVersionService(){
//		return (AppVersionService) getService("appversionService");
//	}
//	
//	public static  AdvertisementService getAdvertisementService(){
//		return (AdvertisementService) getService("advertisementService");
//	}
//	
	public static  FeeDedutionBiz getFeeDedutionService(){
		return (FeeDedutionBiz) getService("feeDedutionBiz");
	} 
//	public static  GPSCarLocsService getGPSCarLocsService(){
//		return (GPSCarLocsService) getService("gpscarlocsService");
//	}
//*/
	public static CarSyncService getCarSyncService() {
		return (CarSyncService)getService("carSyncService");
	}
	
	public static JobAccountBiz getJobAccountService() {
		return (JobAccountBiz)getService("jobAccountBiz");
	}
	
	public static  UserAccountService getUserAccountService(){
		return (UserAccountService) getService("userAccountService");
	}
	
	public static  BcIdGeneratorService getBcIdGeneratorService(){
		return (BcIdGeneratorService) getService("bcIdGeneratorService");
	}
	
	
}
