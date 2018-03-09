package com.thinkgem.jeesite.modules.wlpt.biz.integrity;

import java.util.Date;

import org.jsoup.Jsoup;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityCarowner;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompany;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompanypicture;
import com.thinkgem.jeesite.modules.wlpt.service.integrity.IntegrityCarownerService;

/**
 * 个人诚信信息
 *
 * @author 曾煜佳
 * @version 2016-08-20
 */
@Service
@Transactional(readOnly = true)
public class IntegrityCarownerBiz {
	@Autowired
	private IntegrityCarownerService integrityCarownerService;
	
	@ModelAttribute
	public IntegrityCarowner getCarownerInfo(IntegrityCarowner integrityCarowner) {
		User user = UserUtils.getUser();
		if (StringUtils.isNotBlank(user.getId())){
			integrityCarowner.setUser(user);
			integrityCarowner = integrityCarownerService.findCarowner(integrityCarowner);
		}
		if (integrityCarowner == null){
			integrityCarowner = new IntegrityCarowner();
		}
		return integrityCarowner;
	}
	/**
	 * 根据user ID获取carowner诚信信息
	 * @param integrityEnterprise
	 * @return
	 */
	public IntegrityCarowner findCarowner(IntegrityCarowner integrityCarowner) {
		
		integrityCarowner = integrityCarownerService.findCarowner(integrityCarowner);

		return integrityCarowner;
	}
	 /**
	  * 添加或修改车主诚信信息
	  * @param integrityCarowner
	  * @return
	  */
	 @Transactional(readOnly = false)
	 public int saveCarownerInfo(IntegrityCarowner integrityCarowner){
		 
		 int result = DataDic.RETURN_STATUS_NORMAL;
		//获取当前登录用户
		 User user = UserUtils.getUser();
		 try {
			//判断当前登录用户是否为空
			 if (StringUtils.isNotBlank(user.getId())){
				 integrityCarowner.setUser(user);
				 //判断企业id是否有值
				 if(!StringUtils.isNotBlank(integrityCarowner.getId())){
					 integrityCarowner.setId(IdGen.uuid());
					 integrityCarowner.setIsNewRecord(true);
					 
					 integrityCarowner.setCreatetime(new Date());
			    	}
			 	 integrityCarowner.setUpdatetime(new Date());
			 	 integrityCarownerService.save(integrityCarowner);//保存车主诚信信息
			 }else{
				 result = DataDic.RETURN_STATUS_SYSBUG;
			 }
		} catch (Exception e) {
			result = DataDic.RETURN_STATUS_SYSBUG;
			e.printStackTrace();
		}
		 return result;
	 }
	 
	
	
}
