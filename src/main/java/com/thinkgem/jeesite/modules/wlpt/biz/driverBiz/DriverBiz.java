package com.thinkgem.jeesite.modules.wlpt.biz.driverBiz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Attach;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Driver;
import com.thinkgem.jeesite.modules.wlpt.service.car.AttachService;
import com.thinkgem.jeesite.modules.wlpt.service.car.DriverService;

/**
 * 王铸
 * 获取司机相关数据
 */
@Service
@Transactional(readOnly = true)
public class DriverBiz {
    @Autowired
    private AttachService attachService;
    @Autowired
    private UserBiz userBiz;
    
    @Autowired
    private DriverService driverService;
	/***
	 * 发起绑定
	 * @param attach
	 * @param curUser
     * @return
     */
	@Transactional(readOnly = false)
	public Object saveAttach(Attach attach,User curUser){
		int state= DataDic.RETURN_STATUS_NORMAL;
		String message="保存成功";
		if(curUser == null){
        	state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有登录！";
        }
		if(attach.getReuser().getId().equals(curUser.getId())){
			state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您不能绑定自己！";
		}
        if(!userBiz.getUser().getUserinfo().getStatus().equals("2")){
        	state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有认证！";
        }
		//1.判断对象是否为空
		if (attach == null){
			state=DataDic.RETURN_STATUS_INFOBUG;
			message="信息不完整";
		}else if (Tools.IsNullOrWhiteSpace(attach.getReuser().getId())){
			state=DataDic.RETURN_STATUS_INFOBUG;
			message="缺失发布信息";
		}
		if(!UserUtils.get(attach.getReuser().getId()).getUserinfo().getStatus().equals("2")){
			state = DataDic.RETURN_STATUS_INFOBUG;
            message = "用户没有认证！";
		}
		Attach at=new Attach();//查询信息
		at.setUser(userBiz.getUser());
		at.setReuser(attach.getReuser());
		at.setIsagree("0");
		List<Attach> result1=attachService.findList(at);
		at.setIsagree("1");
		List<Attach> result2=attachService.findList(at);
		if (result1 != null && result1.size() > 0) {
			state = DataDic.RETURN_STATUS_OVERCONTROLBUG;///已发起申请
			message="已发起申请";
        }
		if (result2 != null && result2.size() > 0) {
			state = DataDic.RETURN_STATUS_OVERCONTROLBUG;///已发起申请
			message="已经绑定";
        }
		if (state==DataDic.RETURN_STATUS_NORMAL){
			///如果ID为null则是新增
			if (Tools.IsNullOrWhiteSpace(attach.getId())){
				attach.setUser(curUser);
			}

			attachService.save(attach);
		}

		return Tools.getMapResult(state,message,null);
	}
	
	/***
	 * 保存
	 * @param attach
	 * @param curUser
     * @return
     */
	@Transactional(readOnly = false)
	public Object save(Attach attach,User curUser){
		int state= DataDic.RETURN_STATUS_NORMAL;
		String message="保存成功";
		if (attach == null){
			state=DataDic.RETURN_STATUS_INFOBUG;
			message="信息不完整";
		}else if (Tools.IsNullOrWhiteSpace(attach.getIsagree())){
			state=DataDic.RETURN_STATUS_INFOBUG;
			message="缺失发布信息";
		}
		if(!curUser.getId().equals(attach.getUser().getId())){
			attachService.save(attach);
		}else{
			state=DataDic.RETURN_STATUS_INFOBUG;
			message="您不能操作";
		}
		return Tools.getMapResult(state,message,null);
	}
	
	public Page<Attach> findPage(Page<Attach> page, Attach attach) {
		return attachService.findList1(page, attach);
	}
    @Transactional(readOnly = false)
    public void delete(Attach attach) {
    	attachService.delete(attach);
    }
	public Attach get(String id) {
		return attachService.get(id);
	}
	
	/**
	 * 获取司机
	 * @param attach
	 * @return
	 */
	public List<Attach> findList(Attach attach) {
		return attachService.findList(attach);
	}
	
	/**
	 * 根据用户ID获取司机
	 * @param userId
	 * @return
	 */
	public Driver getDriverByUserId(String userId) {
		return driverService.getDriverByUserId(userId);
	}
}
