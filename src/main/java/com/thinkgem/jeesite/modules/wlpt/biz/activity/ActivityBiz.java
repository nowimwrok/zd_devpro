package com.thinkgem.jeesite.modules.wlpt.biz.activity;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.thinkgem.jeesite.common.utils.OrderNumberUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtil;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityAwardrecord;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityWxgift;
import com.thinkgem.jeesite.modules.wlpt.entity.activity.ActivityWxinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumeaudit;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumerecod;
import com.thinkgem.jeesite.modules.wlpt.service.activity.ActivityAwardrecordService;
import com.thinkgem.jeesite.modules.wlpt.service.activity.ActivityWxgiftService;
import com.thinkgem.jeesite.modules.wlpt.service.activity.ActivityWxinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserPurseService;

/**
 * Created by ForHeart on 16/9/05.
 * 活动管理
 */
@Service
@Transactional(readOnly = true)
public class ActivityBiz {
	@Autowired
	private ActivityAwardrecordService activityAwardrecordService;
	
	@Autowired
	private ActivityWxgiftService activityWxgiftService;
	
	@Autowired
	private ActivityWxinfoService activityWxinfoService;
	
	@Autowired
	private UserPurseService userPurseService;
	
	@Autowired
	private ConsumeRecodBiz consumeRecodBiz;

	
	/***
     * 获取活动信息
     * @param activity_Id
     * @return
     * @throws Exception
     */
    public ActivityWxinfo getActivityInfo(String activity_Id) throws Exception {
    	return activityWxinfoService.get(activity_Id);
    }

    /**
     * 
     * @param giftid
     * @return
     */
    @Transactional(readOnly = false)
    public Object savaGiftinfo(String giftid,User user){
        int state = DataDic.RETURN_STATUS_NORMAL;

        String message = "保存成功";
        
        
        ActivityWxgift wxgift = activityWxgiftService.get(giftid);
        if(wxgift!=null){
        	ActivityAwardrecord award = new ActivityAwardrecord();
        	award.setWxinfo(wxgift.getWxinfo());
        	award.setWxgift(wxgift);
        	award.setUser(user);
        	award.setCreateDate(new Date());
        	award.setUpdatetime(new Date());
        	award.setIssue(DataDic.ACTIVITYGIFT_STATUS_GRANT);//发送
        	award.setIsNewRecord(true);
        	award.setId(IdGen.uuid());
        	awardrecordSave(award);
        	consumeRecodBiz.activityRecodeBiz(user.getId(),Double.parseDouble(wxgift.getGiftworth()));//添加消费
        	activityWxinfoService.updateWinNum(wxgift.getWxinfo().getId());
        	activityWxinfoService.updateScanNum(wxgift.getWxinfo().getId());
        	activityWxgiftService.updateWinNum(wxgift.getId());
        }else{
        	state=DataDic.RETURN_STATUS_INFOBUG;
        	message="活动不存在";
        }
        return  Tools.getMapResult(state,message,null);
    }

    /***
     * 获取最新的活动信息，并且是已开启的活动信息,如果没有活动信息，页面提示活动已结束
     * @return
     */
    @Transactional(readOnly = false)
    public Object getNowActivityBiz(ActivityWxinfo activityWxinfo){
        int state = 1;
        int code = 1;
        String message = "保存成功";
        List<ActivityWxinfo> list=new ArrayList<ActivityWxinfo>();
        List<ActivityWxgift> varList=new ArrayList<ActivityWxgift>();
        Map<String, Object> map = new HashMap<String, Object>();

        Date nowtime= new Date();
        activityWxinfo.setIseffective("1");
        activityWxinfo.setActivitytime(nowtime);
        try {
            list=activityWxinfoService.findList(activityWxinfo);
            if (list.size()>0){
            	activityWxinfo=list.get(0);
                List<String> Ids=new ArrayList<>();
                Ids.add(0,activityWxinfo.getId());

                ///获取礼物列表
                varList=activityWxgiftService.findGiftByActivityId(Ids);
                //activityWxinfoService.updateScanNum(activityWxinfo.getId());

            }else{
                state = 0;
                code = 2;
                message = "暂无活动信息";
            }
            map.put("activityWxinfo",activityWxinfo);
            map.put("varList",varList);
        } catch (Exception e) {
            e.printStackTrace();
            state = 0;
            code = -1;
            message = "获取失败";
        }

        return  Tools.getMapResult(state,message,map);
    }



    /***
     * 修改发放奖品
     *
     * @param id  中奖ID
     * @param issue //是否发放：0未发放，1已发放2作废
     * @return
     */
    @Transactional(readOnly = false)
    public String txMethodEditBiz(String id, int issue) {
        int state = 1;
        String message = "保存成功";
        try {
            //获取中奖记录信息
            ActivityAwardrecord aad  = awardrecordGet(id);

            if (aad == null) {
                state = 0;
                message = "保存失败,信息不存在";
            } else {
                //是否发放：0未发放，1已发放2作废
                int oldissue = Integer.parseInt(aad.getIssue());
                if (oldissue == 1 && issue == 1) {
                    state = 0;
                    message = "保存失败,奖品已发放";
                } else if (oldissue == 3 && issue == 3) {
                    state = 0;
                    message = "保存失败,奖品已兑换";
                } else if (oldissue == 1 && issue == 2) {
                    state = 0;
                    message = "作废失败,奖品已发放";
                } else if (oldissue == 1 && issue == 0) {
                    state = 0;
                    message = "奖品已发放";
                } else if (oldissue == 2 && issue == 0) {
                    state = 0;
                    message = "奖品已作废";
                } else if (oldissue == 2 && issue == 1) {
                    state = 0;
                    message = "奖品已作废";
                }
                //获取用户信息
                User user=UserUtils.getUserById(aad.getUser().getId());
                if(user==null){
                    state = 0;
                    message="该用户不存在";
                }
                if (state == 1) {
                    ///获取当前活动礼品信息
                    ActivityWxgift awg = activityWxgiftService.get(aad.getWxgift().getId());
                    int giftType = Integer.parseInt(awg.getGifttype());
                    //0是现金红包，发放直接发放到用户
                    	/*f (oldissue == 1 && issue == 3 && giftType == 0) {
                            // 修改账户金额
                        	userPurseService.editPureWebBalance(user, Double.parseDouble(awg.getGiftworth()), "0");
                        }*/
                    aad.setIssue(String.valueOf(issue));
                    aad.setUpdatetime(new Date());
                    awardrecordSave(aad);//修改


                }

            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "保存失败";
        }
        return message;
    }


    /**
     * 保存中奖记录
     * @param giftid 招聘id
     * @param activityid 活动id
     * @param phone 手机号码
     * @param userid 用户id
     * @return
     */
    @Transactional(readOnly = false)
    public Object txMethodSaveBiz(String giftid, String activityid,String phone,String userid) {
        int state = 1;
        String message = "保存奖品成功";
        try {
            //获取中奖记录信息
            ActivityAwardrecord aad  = getAwardlistInfo(phone,activityid);

            if (aad == null) {
                aad = new ActivityAwardrecord();
                //获取活动信息
                ActivityWxinfo wxinfo = getActivityInfo(activityid);
                if(wxinfo ==null){
                    state = 0;
                    message = "无该活动";
                    return Tools.getMapResult(state,message,null);
                }
                ///获取当前活动礼品信息
                ActivityWxgift awg = activityWxgiftService.get(giftid);
                if(awg==null){
                    state = 0;
                    message = "无该礼品";
                    return Tools.getMapResult(state,message,null);
                }

                //获取用户信息
                /*User user=UserUtils.getUserById(userid);
                if(!Tools.IsNullOrWhiteSpace(userid)){
                    aad.setUser(user);
                    aad.setIssue(DataDic.ACTIVITYGIFT_STATUS_GRANT);//已发放
                }else {}*/
                User user = UserUtils.getByPhone(phone);
                if(user!=null){
                    aad.setUser(user);
                    aad.setIssue(DataDic.ACTIVITYGIFT_STATUS_GRANT);//已发放
                }else{
                    aad.setIssue(DataDic.ACTIVITYGIFT_STATUS_CREATE);//未发放
                }
                aad.setPhone(phone);
                aad.setWxinfo(wxinfo);
                aad.setGifttypename(awg.getGiftname());
                aad.setStarttime(awg.getStarttime());
                aad.setEndtime(awg.getEndtime());
                aad.setWxgift(awg);
                aad.setCreatetime(new Date());
                aad.setUpdatetime(new Date());

                //获奖兑换号
                String awardno = OrderNumberUtil.getOrderNo(DataDic.MODEL_ACTIVITY);
                aad.setAwardno(awardno);
                awardrecordSave(aad);//修改
                activityWxgiftService.updateWinNum(giftid);//更新中奖次数
            } else {
                state = 0;
                message = "已参与活动";

            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "保存失败";
        }
        return Tools.getMapResult(state,message,null);
    }


    /**
	 * 根据获奖id获取中奖记录
	 * @param id
	 * @return
	 */
	public ActivityAwardrecord awardrecordGet(String id) {
		return activityAwardrecordService.get(id);
	}

    /**
     * 根据用户手机和活动id获取中奖记录
     * @param phone 手机号码
     * @param activityid 活动id
     * @return
     */
    public ActivityAwardrecord getAwardlistInfo(String phone,String activityid){
        ActivityAwardrecord activityAwardrecord = new ActivityAwardrecord();
        ActivityWxinfo wxinfo = new ActivityWxinfo();
        wxinfo.setId(activityid);
        activityAwardrecord.setWxinfo(wxinfo);
        activityAwardrecord.setPhone(phone);
        return activityAwardrecordService.getAwardlistInfo(activityAwardrecord);
    }

	/**
	 * 获取未分页的中奖记录列表
	 * @param activityAwardrecord
	 * @return
	 */
	public List<ActivityAwardrecord> awardrecordFindList(ActivityAwardrecord activityAwardrecord) {
		return activityAwardrecordService.findList(activityAwardrecord);
	}
	
	/**
	 * 获取分页的中奖记录列表
	 * @param page
	 * @param activityAwardrecord
	 * @return
	 */
	public Page<ActivityAwardrecord> awardrecordFindPage(Page<ActivityAwardrecord> page, ActivityAwardrecord activityAwardrecord) {
		return activityAwardrecordService.findPage(page, activityAwardrecord);
	}
	/**
	 * 修改或保存中奖记录
	 * @param activityAwardrecord
	 */
	@Transactional(readOnly = false)
	public void awardrecordSave(ActivityAwardrecord activityAwardrecord) {
		activityAwardrecordService.save(activityAwardrecord);
	}
	

	/**
	 * 删除中奖记录
	 * @param activityAwardrecord
	 */
	@Transactional(readOnly = false)
	public void awardrecordDelete(ActivityAwardrecord activityAwardrecord) {
		activityAwardrecordService.delete(activityAwardrecord);
	}
	
	public List<ActivityWxgift> findWxgiftList(ActivityWxgift activityWxgift) {
		return activityWxgiftService.findList(activityWxgift);
	}

    /**
     * 更新奖品状态
     */
    @Transactional(readOnly = false)
    public void updateIsSue(ActivityAwardrecord activityAwardrecord){

        activityAwardrecordService.updateIsSue(activityAwardrecord);
    }

    /**
     * 根据中奖编号获取中奖记录
     * @param awardno
     * @return
     */
    public ActivityAwardrecord getAwardlistInfoByAwardNo(String awardno){
        return activityAwardrecordService.getAwardlistInfoByAwardNo(awardno);
    }
}
