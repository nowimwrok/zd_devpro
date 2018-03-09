package com.thinkgem.jeesite.modules.wlpt.biz.carBiz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.sms.util.SmsConfig;
import com.thinkgem.jeesite.common.sms.util.SmsUtil;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.weixin.constant.ConstantWeChat;
import com.thinkgem.jeesite.modules.wlpt.biz.collection.CollectionBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.car.CarSource;
import com.thinkgem.jeesite.modules.wlpt.entity.collection.WlptCollection;
import com.thinkgem.jeesite.modules.wlpt.entity.goods.Goods;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;
import com.thinkgem.jeesite.modules.wlpt.service.car.CarSourceService;

/**
 * 
 * 获取车辆相关数据
 */
@Service
@Transactional(readOnly = true)
public class CarSourceBiz extends BaseController{

	@Autowired
    private CarSourceService carSourceService;
	@Autowired
	private CarBiz carBiz;
	
	@Autowired
	private CollectionBiz collectionBiz;
	/***
	 * 车辆发布信息
	 * @param car
	 * @param curUser
     * @return
     */
	@Transactional(readOnly = false)
	public Object saveCarSourceBiz(CarSource carsource,User curUser){
		int state= DataDic.RETURN_STATUS_NORMAL;
		String message="保存成功";
		if(curUser == null){
        	state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有登录！";
        }
		//1.判断对象是否为空
		if (carsource == null){
			state=DataDic.RETURN_STATUS_INFOBUG;
			message="信息不完整";
		}else if (carsource.getCar()==null){
			state=DataDic.RETURN_STATUS_INFOBUG;
			message="车辆信息为空";
		}else if (Tools.IsNullOrWhiteSpace(carsource.getFromaddress())||Tools.IsNullOrWhiteSpace(carsource.getToaddress())){
			state=DataDic.RETURN_STATUS_INFOBUG;
			message="主营线路信息为空";
		}
		Car c= new Car();
		if(carsource.getCar()!=null && !Tools.IsNullOrWhiteSpace(carsource.getCar().getId())){
			c=carBiz.get(carsource.getCar().getId());
			if(c==null){
				state=DataDic.RETURN_STATUS_INFOBUG;
				message="车辆不存在";
			}
		}
        
		if (state==DataDic.RETURN_STATUS_NORMAL){
			///如果ID为null则是新增
			if (Tools.IsNullOrWhiteSpace(carsource.getId())){
				carsource.setUser(curUser);
				carsource.setCar(c);
				carsource.setCarnumber(c.getCarnumber());
				
			}
			carsource.setMainroad(carsource.getFromaddress() + "-" + carsource.getToaddress());
			carsource.setStatus(DataDic.CARSOURCE_STATUS_PUB);
			save(carsource);
			//推送信息
			carBiz.sendCarSourceInfo(carsource.getCar().getId());
		}

		return Tools.getMapResult(state,message,null);
	}
	
	
	public CarSource get(String id) {
		return carSourceService.get(id);
	}

	public List<CarSource> findList(CarSource carSource) {
		return carSourceService.findList(carSource);
	}
	
	public Page<CarSource> findPage(Page<CarSource> page, CarSource carSource) {
		return carSourceService.findPage(page, carSource);
	}
	
	@Transactional(readOnly = false)
	public void save(CarSource carSource) {
		carSourceService.save(carSource);
	}
	
	@Transactional(readOnly = false)
	public void delete(CarSource carSource) {
		carSourceService.delete(carSource);
	}
	/**
	 * 修改车源为已过期状态
	 */
	@Transactional(readOnly = false)
	public void updateStatus() {
		carSourceService.updateStatus();
	}
	
	
}
