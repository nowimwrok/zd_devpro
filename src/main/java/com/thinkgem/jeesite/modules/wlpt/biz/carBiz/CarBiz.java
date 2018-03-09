package com.thinkgem.jeesite.modules.wlpt.biz.carBiz;

import java.util.ArrayList;
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
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.collection.WlptCollection;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;
import com.thinkgem.jeesite.modules.wlpt.service.car.CarService;
import com.thinkgem.jeesite.modules.wlpt.service.car.GpsCarInfoService;

/**
 * Created by ForHeart on 16/8/18.
 * 获取车辆相关数据
 */
@Service
@Transactional(readOnly = true)
public class CarBiz extends BaseController{

    @Autowired
    private GpsCarInfoService carInfoService;   ////gps车辆信息
    @Autowired
    private CarService carService;
    @Autowired 
    private UserBiz userBiz;
    @Autowired
	private CollectionBiz collectionBiz;
	/***
	 * 车辆发布信息
	 * @param car
	 * @param curUser
     * @return
     */
	@Transactional(readOnly = false)
	public Object saveCarBiz(Car car,User curUser){
		int state= DataDic.RETURN_STATUS_NORMAL;
		String message="保存成功";
		if(curUser == null){
        	state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有登录！";
        }
        if(!userBiz.getUser().getUserinfo().getStatus().equals("2")){
        	state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有认证！";
        }
		//1.判断对象是否为空
		if (car == null){
			state=DataDic.RETURN_STATUS_INFOBUG;
			message="信息不完整";
		}else if (Tools.IsNullOrWhiteSpace(car.getCarnumber())||Tools.IsNullOrWhiteSpace(car.getCartype())||Tools.IsNullOrWhiteSpace(car.getIssocialcar())
				    ||Tools.IsNullOrWhiteSpace(car.getCarlength())||Tools.IsNullOrWhiteSpace(car.getLoadweight())){
			state=DataDic.RETURN_STATUS_INFOBUG;
			message="缺失发布信息";
		}else if (Tools.IsNullOrWhiteSpace(car.getMainroad())){
			state=DataDic.RETURN_STATUS_INFOBUG;
			message="请选择主营路线";
		}
		Car c=car;//查询
		c.setUser(curUser);
		List<Car> result=carService.findList(c);
        if(result != null && result.size() > 0){
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "车辆已经发布，请勿重新发布";
        }
		if (state==DataDic.RETURN_STATUS_NORMAL){
			///如果ID为null则是新增
			if (Tools.IsNullOrWhiteSpace(car.getId())){
				car.setUser(curUser);
			}

			carService.save(car);
			
			//统计发布车辆数
	        UserStatistics statistics = new UserStatistics();
	        statistics.setAddcarcount("1");
	        UserUtils.userDataSourceCount(statistics);	
		}

		return Tools.getMapResult(state,message,null);
	}
	
	/***
	 * 车辆认证
	 * @param car
	 * @param curUser
     * @return
     */
	@Transactional(readOnly = false)
	public Object authenticateBiz(Car car,User curUser){
		int state= DataDic.RETURN_STATUS_NORMAL;
		String message="成功申请认证";
		if(curUser == null){
        	state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有登录！";
        }
		Car c= get(car.getId());
		if(c.getStatus().equals(DataDic.AUTHENWAITING)){
			state = DataDic.RETURN_STATUS_INFOBUG;
            message = "车辆已申请认证！";
		}
		if(c.getStatus().equals(DataDic.AUTHENSUCCES)){
			state = DataDic.RETURN_STATUS_INFOBUG;
            message = "车辆已认证！";
		}
		if (state==DataDic.RETURN_STATUS_NORMAL){
			boolean savecar=carService.saveCar(car);
			if(!savecar){
				state = DataDic.RETURN_STATUS_INFOBUG;
	            message = "车辆认证失败";
			}
		}
		return Tools.getMapResult(state,message,null);
	}
	
    @Transactional(readOnly = false)
    public void delete(Car car) {
    	
        carService.delete(car);
    }
    public List<Car> findList(Car car) {
        return carService.findList(car);
    }
	public List<Car> findAllList(Car car) {
		return carService.findAllList(car);
	}
	public Car get(String id) {
		return carService.get(id);
	}
	//车源大厅获取车源信息
	public Car gethallinfo(String id,String carsourceid) {
		Car car = new Car();
		car.setId(id);
		if(!Tools.IsNullOrWhiteSpace(carsourceid)){
			car.setCarsourceid(carsourceid);
		}
		
		Car c = carService.gethallinfo(car);
		//如果该数据为车源数据
		if(c!=null&&!Tools.IsNullOrWhiteSpace(carsourceid)){
			if(!Tools.IsNullOrWhiteSpace(c.getCarsourcemainroad())){
				c.setMainroad(c.getCarsourcemainroad());
			}
			if(!Tools.IsNullOrWhiteSpace(c.getContactname())){
				c.setOwnername(c.getContactname());
			}
			if(!Tools.IsNullOrWhiteSpace(c.getContactmobile())){
				c.setOwnermobile(c.getContactmobile());
			}
			
		}
		return c;
	}
	public Page<Car> findPage(Page<Car> page, Car car) {
		return carService.findPage(page, car);
	}
	
	/***
	 * 获取当前用户的车辆
	 * @return
     */
	public List<Car> getMyCar(){
		return carService.getMyCar();
	}
	
	
	public void sendCarSourceInfo(String id){
    	new Thread(){
            public void run(){
            	///获取货源信息
            	Car car = get(id);
                if(car!=null){
                	String url = getOauthUrl(ConstantWeChat.SERVICE_URLS+ "car/car_detail?id=" + car.getId(), "UTF-8", ConstantWeChat.SCOPE_SNSAPI_USERINFO);
                	String mainroad = car.getMainroad();
                	String addressStart = "";//起点
                    String addressEnd = "";//终点
        			if (mainroad != null && !mainroad.equals("")) {
        				int index = mainroad.indexOf("-");
        				if (index != -1) {
        					addressStart = mainroad.substring(0, index);
        					if(!Tools.IsNullOrWhiteSpace(addressStart) && addressStart.length()>3){
        						addressStart = addressStart.substring(addressStart.length()-3);
        					}
        					addressEnd = mainroad.substring(index + 1);
        					if(!Tools.IsNullOrWhiteSpace(addressEnd) && addressEnd.length()>3){
        						addressEnd = addressEnd.substring(addressEnd.length()-3);
        					}
        				}

        			}
        			if(!Tools.IsNullOrWhiteSpace(addressStart) && !Tools.IsNullOrWhiteSpace(addressEnd)){
        				String lengthunit = StringUtils.isNoneBlank(car.getLengthunit())?car.getLengthunit():"米";
                    	String weightunit = StringUtils.isNoneBlank(car.getWeightunit())?car.getWeightunit():"吨";
                    	String carinfo = car.getCartype()+"/"+car.getCarlength()+lengthunit+"/"+car.getLoadweight()+weightunit;
                        String[] keyword = {"车辆", car.getCarnumber(),carinfo,addressStart+"/"+addressEnd,Tools.date2Str(car.getDeparturetime(),"yyyy-MM-dd"),Tools.date2Str(car.getCreateDate(),"yyyy-MM-dd"), Global.LINK_TEL};
                        sendallUser(keyword,url,addressStart,addressEnd);//推送
        			}
        			
                }
            	
           }
        }.start();
    }
    
    /**
     * 推送发布的货源给关注的用户
     * @param keyword
     * @param url
     */
 	public void sendallUser( String[] keyword, String url,String fromcity,String tocity ) {
 		try {
 			WlptCollection wlptCollection = new WlptCollection();
 			//获取关注货源条数
 			wlptCollection.setTargettype(DataDic.COLLECTION_TYPE_CAR);
 			wlptCollection.setFromcity(fromcity);
 			wlptCollection.setTocity(tocity);
 			
 			List<WlptCollection> list = collectionBiz.findList(wlptCollection);
 			if(list.size()>0){
 				for (WlptCollection collec : list) {
 					if(collec!=null){
 						String openId = collec.getOpenid();
 						if(StringUtils.isNoneBlank(openId)){
 							//发送推送
 							SmsUtil.sendSmsMesge(openId, DataDic.SMSCODE_DELIVERGOODS, null, Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_CONSUME, keyword, ConstantWeChat.CARS_SOURCE, url, false, SmsConfig.smsGoodsEnd);
 						}
 					}
 				}
 			}
 			
 		} catch (Exception e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 		}
 	}
 	
 	/**
 	 * 通过车牌号查找所有的carid
 	 */
 	public List<String> findIdByCarnumber(String carnumber){
 		System.out.println("=========="+carnumber+"==================");
 		if(!Tools.IsNullOrWhiteSpace(carnumber)){
 			List<String> carList = carService.findIdByCarnumber(carnumber);
 			return carList;
 		}else{
 			return new ArrayList<>();
 		}
 	}
}
