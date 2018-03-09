package com.thinkgem.jeesite.modules.wlpt.biz.contacts;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.contacts.UserCommonContacts;
import com.thinkgem.jeesite.modules.wlpt.service.contacts.UserCommonContactsService;

/**
 * 常用联系人接口
 *
 * @author zyj
 * @version 2017-04-11
 */
@Service
@Transactional(readOnly = true)
public class CommonContactsBiz {

	@Autowired
	private UserCommonContactsService userCommonContactsService;
	
	public UserCommonContacts get(String id) {
		return userCommonContactsService.get(id);
	}


	/***
	 * 添加联系人
	 * @param contacts
	 * @param curUser
     * @return
     */
	@Transactional(readOnly = false)
	public Object saveContacts(UserCommonContacts contacts,User curUser){
		int state= DataDic.RETURN_STATUS_NORMAL;
		String message="保存成功";
		if(curUser == null){
        	state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有登录！";
            return Tools.getMapResult(state,message,null);
        }
		
        if(!curUser.getUserinfo().getStatus().equals("2")){
        	state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您还没有认证！";
            return Tools.getMapResult(state,message,null);
        }
		//1.判断对象是否为空
		if (contacts == null){
			state=DataDic.RETURN_STATUS_INFOBUG;
			message="信息不完整";
			return Tools.getMapResult(state,message,null);
			
		}else if (Tools.IsNullOrWhiteSpace(contacts.getTarget().getId())){
			state=DataDic.RETURN_STATUS_INFOBUG;
			message="缺失发布信息";
			return Tools.getMapResult(state,message,null);
		}
		if(contacts.getTarget().getId().equals(curUser.getId())){
			state = DataDic.RETURN_STATUS_INFOBUG;
            message = "您不能添加自己！";
            return Tools.getMapResult(state,message,null);
		}
		if(!UserUtils.get(contacts.getTarget().getId()).getUserinfo().getStatus().equals("2")){
			state = DataDic.RETURN_STATUS_INFOBUG;
            message = "用户没有认证！";
            return Tools.getMapResult(state,message,null);
		}
		UserCommonContacts common=new UserCommonContacts();//查询信息
		common.setUser(curUser);
		common.setTarget(contacts.getTarget());
		List<UserCommonContacts> result1=findList(common);
		
		if (result1 != null && result1.size() > 0) {
			state = DataDic.RETURN_STATUS_OVERCONTROLBUG;///已发起申请
			message="该用户已是您的联系人，请勿重复添加";
			return Tools.getMapResult(state,message,null);
        }
		
		if (state==DataDic.RETURN_STATUS_NORMAL){
			///如果ID为null则是新增
			if (Tools.IsNullOrWhiteSpace(contacts.getId())){
				contacts.setUser(curUser);
				//contacts.preInsert();
				contacts.setCreateDate(new Date());
				contacts.setUpdateDate(new Date());
			}

			save(contacts);
		}

		return Tools.getMapResult(state,message,null);
	}
	

	public List<UserCommonContacts> findList(UserCommonContacts userCommonContacts) {
		return userCommonContactsService.findList(userCommonContacts);
	}
	
	public Page<UserCommonContacts> findPage(Page<UserCommonContacts> page, UserCommonContacts userCommonContacts) {
		return userCommonContactsService.findPage(page, userCommonContacts);
	}
	
	@Transactional(readOnly = false)
	public void save(UserCommonContacts userCommonContacts) {
		userCommonContactsService.save(userCommonContacts);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserCommonContacts userCommonContacts) {
		userCommonContactsService.delete(userCommonContacts);
	}
}
