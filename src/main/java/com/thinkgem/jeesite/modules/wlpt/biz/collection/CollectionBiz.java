package com.thinkgem.jeesite.modules.wlpt.biz.collection;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.collection.WlptCollection;
import com.thinkgem.jeesite.modules.wlpt.service.collection.WlptCollectionService;

/**
 * 我的关注
 * @author zyj
 *
 */
@Service
@Transactional(readOnly = true)
public class CollectionBiz {

	@Autowired
	private WlptCollectionService wlptCollectionService;
	
	
	@Transactional(readOnly = false)
	public Object savecollection(WlptCollection wlptCollection,User curUser){
		int state= DataDic.RETURN_STATUS_NORMAL;
		String message="保存成功";
		if(curUser == null){
        	state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有登录！";
        }
        if(!curUser.getUserinfo().getStatus().equals("2")){
        	state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有认证！";
        }
        //1.判断对象是否为空
  		if (wlptCollection == null){
  			state=DataDic.RETURN_STATUS_INFOBUG;
  			message="信息不完整";
  		}else if (Tools.IsNullOrWhiteSpace(wlptCollection.getFromprovince())||Tools.IsNullOrWhiteSpace(wlptCollection.getFromcity())
				    ||Tools.IsNullOrWhiteSpace(wlptCollection.getToprovince())||Tools.IsNullOrWhiteSpace(wlptCollection.getTocity())){
			state=DataDic.RETURN_STATUS_INFOBUG;
			message="缺失路线信息";
		}else if (Tools.IsNullOrWhiteSpace(wlptCollection.getTargettype())){
  			state=DataDic.RETURN_STATUS_INFOBUG;
  			message="缺失关注类型信息";
  		}
  		WlptCollection collec= wlptCollection;//查询
  		collec.setUser(curUser);
		List<WlptCollection> result=findList(collec);
        if(result != null && result.size() > 0){
            state = DataDic.RETURN_STATUS_INFOBUG;
            message = "该路线已经关注，请勿重复关注";
        }
		if (state==DataDic.RETURN_STATUS_NORMAL){
			///如果ID为null则是新增
			if (Tools.IsNullOrWhiteSpace(wlptCollection.getId())){
				wlptCollection.setUser(curUser);
			}
			save(wlptCollection);
		}
        return Tools.getMapResult(state,message,null);
	}
	
	
	
	public WlptCollection get(String id) {
		return wlptCollectionService.get(id);
	}



	public List<WlptCollection> findList(WlptCollection wlptCollection) {
		return wlptCollectionService.findList(wlptCollection);
	}
	
	public Page<WlptCollection> findPage(Page<WlptCollection> page, WlptCollection wlptCollection) {
		return wlptCollectionService.findPage(page, wlptCollection);
	}
	
	@Transactional(readOnly = false)
	public void save(WlptCollection wlptCollection) {
		wlptCollectionService.save(wlptCollection);
	}
	
	@Transactional(readOnly = false)
	public void delete(WlptCollection wlptCollection) {
		wlptCollectionService.delete(wlptCollection);
	}
	
	/***
	 * 获取当前条数
	 * @return  获取条数:int类型
	 */
	public int countcollection(WlptCollection wlptCollection){
		return wlptCollectionService.countcollection(wlptCollection);
	}
}
