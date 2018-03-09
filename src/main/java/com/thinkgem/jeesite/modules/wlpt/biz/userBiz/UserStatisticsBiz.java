package com.thinkgem.jeesite.modules.wlpt.biz.userBiz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.IntegrityBiz.IntegrityBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumerecod;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;
import com.thinkgem.jeesite.modules.wlpt.service.consume.ConsumerecodService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserStatisticsService;
import com.thinkgem.jeesite.modules.wlpt.service.user.WlptUserService;

/**
 * 用户数据统计
 *
 * @author 曾煜佳
 * @version 2016-08-31
 */
@Service(value = "userStatisticsBiz")
@Transactional(readOnly = true)
public class UserStatisticsBiz {
	 @Autowired
	 private UserStatisticsService userStatisticsService;
	 
	 @Autowired
	 private WlptUserService wlptUserService;
	 
	 @Autowired
	 private ConsumerecodService consumerecodService;
	
	 @Autowired
	 private IntegrityBiz integrityBiz;
	/**
	 * 用户统计
	 * @param userstatistics
	 * @return
	 */
	 @Transactional(readOnly = false)
	 public int saveUserStatistics(UserStatistics userstatistics) {
		 User user = UserUtils.getUser();//获取当前登录用户
		 if(userstatistics.getUser()==null){
			 userstatistics.setUser(user);
		 }
		 
		 //根据用户id获取记录
		 UserStatistics statistics = userStatisticsService.getConditon(userstatistics);
		 int result = DataDic.RETURN_STATUS_NORMAL;
		 //判断是添加还是修改
		 if(statistics==null){
		 	 userstatistics.setId(IdGen.uuid());
    		 userstatistics.setIsNewRecord(true);
	     }else{
	    	 userstatistics.setId(statistics.getId());
	     } 
		 UserStatistics ustatistics = userStatisticsService.get(userstatistics.getId());
		 //判断是不是第一次统计
		 if(ustatistics!=null){
			//累计登录天数
			 if(StringUtils.isNoneBlank(userstatistics.getAccruelogincount())){
				 User us = userstatistics.getUser();
				 us.setIntervalday(1);//获取前天登录数据
				 int count = wlptUserService.findLoginCount(us);
				 
				 if(count>0){
					 //判断是否是连续登录
					 userstatistics.setContinuelogincount("2");//累计天数
					integrityBiz.updateIntegrityPoint(user.getUserinfo(),DataDic.INTEGRITY_POINT_USERLOGIN,user.getRole().getEnname());//更新诚信积分
				 }else{
					 us.setIntervalday(0);//获取当天登录数据
					 count =  wlptUserService.findLoginCount(us);
					 //如果登录数据是当天的那么不统计登录次数
					 if(count==0){
						 userstatistics.setContinuelogincount("1");//累计天数归零
						 integrityBiz.updateIntegrityPoint(user.getUserinfo(),DataDic.INTEGRITY_POINT_USERLOGIN,user.getRole().getEnname());//更新诚信积分
					 }else{
						 userstatistics.setAccruelogincount("");//如果当天的登录记录不为空，不记录
					 }
					 
				 }
				 
			 }
			 //接单
			 if(StringUtils.isNoneBlank(userstatistics.getTradeordercount())){
				 
			 }
			 
			 //评价次数
			 if(StringUtils.isNoneBlank(userstatistics.getGoodjudge())||StringUtils.isNoneBlank(userstatistics.getMiddlejudge())
					 ||StringUtils.isNoneBlank(userstatistics.getBadjudge())){
				 userstatistics.setJudgetrade("1");
			 }
			//累计充值金额
			 if(StringUtils.isNoneBlank(userstatistics.getRechargemoney())){
				 Consumerecod consumerecod = new Consumerecod();
				 consumerecod.setSearchinfo("account");
				 consumerecod.setTarget(userstatistics.getUser());
				 //获取当前登录用户的充值记录总额
				 consumerecod = consumerecodService.findCountConsumerecod(consumerecod);
				 if(consumerecod!=null){
					 userstatistics.setRechargemoney(consumerecod.getConsumemony());
				 }
			 }
		 }else{
			 userstatistics.setContinuelogincount("1");//累计天数归零
		 }
		 
		 userStatisticsService.save(userstatistics);
		 return result;
	 }
	 
	 public UserStatistics get(String id) {
			return userStatisticsService.get(id);
	}
	public UserStatistics getConditon(UserStatistics userStatistics) {
		return userStatisticsService.getConditon(userStatistics);
	}


	public List<UserStatistics> findList(UserStatistics userStatistics) {
		return userStatisticsService.findList(userStatistics);
	}
	
	public Page<UserStatistics> findPage(Page<UserStatistics> page, UserStatistics userStatistics) {
		return userStatisticsService.findPage(page, userStatistics);
	}

	/***
	 * 查找用户分页信息
	 * @param page
	 * @param userStatistics
     * @return
     */
	public Page<UserStatistics> findUinfoPage(Page<UserStatistics> page, UserStatistics userStatistics) {
		return userStatisticsService.findUinfoPage(page, userStatistics);
	}
	@Transactional(readOnly = false)
	public void save(UserStatistics userStatistics) {
		userStatisticsService.save(userStatistics);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserStatistics userStatistics) {
		userStatisticsService.delete(userStatistics);
	}
	
}
