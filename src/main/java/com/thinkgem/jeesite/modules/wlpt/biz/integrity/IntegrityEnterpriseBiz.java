package com.thinkgem.jeesite.modules.wlpt.biz.integrity;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityCarowner;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityEnterprise;
import com.thinkgem.jeesite.modules.wlpt.service.integrity.IntegrityEnterpriseService;

/**
 * 企业诚信信息
 *
 * @author 曾煜佳
 * @version 2016-08-20
 */
@Service
@Transactional(readOnly = true)
public class IntegrityEnterpriseBiz {
	@Autowired
	private IntegrityEnterpriseService integrityEnterpriseService;
	
	/**
	 * 获取企业诚信信息
	 * @param integrityEnterprise
	 * @return
	 */
	@ModelAttribute
	public IntegrityEnterprise getEnterpriseInfo(IntegrityEnterprise  integrityEnterprise) {
		User user = UserUtils.getUser();
		if (StringUtils.isNotBlank(user.getId())){
			integrityEnterprise.setUser(user);
			integrityEnterprise = integrityEnterpriseService.findEnterprise(integrityEnterprise);
		}
		if (integrityEnterprise == null){
			integrityEnterprise = new IntegrityEnterprise();
		}
		return integrityEnterprise;
	}
	/**
	 * 根据user ID获取企业诚信信息
	 * @param integrityEnterprise
	 * @return
	 */
	public IntegrityEnterprise findEnterprise(IntegrityEnterprise  integrityEnterprise) {
		integrityEnterprise = integrityEnterpriseService.findEnterprise(integrityEnterprise);
		if(integrityEnterprise!=null){
		  if(integrityEnterprise.getCompanyinfo()!=null){
			if(integrityEnterprise.getCompanyinfo().length()>200){
				integrityEnterprise.setCompanyinfo(integrityEnterprise.getCompanyinfo().substring(0, 200)+"...");
			}
		  }
		}
		return  integrityEnterprise;

	}
	/**
	  * 添加或修改企业诚信信息
	  * @param integrityEnterprise
	  * @return
	  */ 
	 @Transactional(readOnly = false)
	 public int saveEnterpriseInfo(IntegrityEnterprise  integrityEnterprise){
		 
		 int result = DataDic.RETURN_STATUS_NORMAL;
		 //获取当前登录用户
		 User user = UserUtils.getUser();
		 try { 
			 //判断当前登录用户是否为空
			 if (StringUtils.isNotBlank(user.getId())){
				 integrityEnterprise.setUser(user);
				 //判断企业id是否有值
				 if(!StringUtils.isNotBlank(integrityEnterprise.getId())){
					 integrityEnterprise.setId(IdGen.uuid());
					 integrityEnterprise.setIsNewRecord(true);
					 integrityEnterprise.setCreatetime(new Date());
			    	}
				 integrityEnterprise.setUpdatetime(new Date());
				 integrityEnterpriseService.save(integrityEnterprise);//保存企业诚信信息
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
