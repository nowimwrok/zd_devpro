package com.thinkgem.jeesite.modules.wlpt.biz.insur;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsurance;
import com.thinkgem.jeesite.modules.wlpt.service.insur.UserInsuranceService;

/**
 * 保险
 *
 * @author zyj
 */
@Service
@Transactional(readOnly = true)
public class InsurBiz {
	@Autowired
	private UserInsuranceService userInsuranceService;
	
	
	
	public UserInsurance get(String id) {
		return userInsuranceService.get(id);
	}
	/**
	 * 根据统计获取单条数据
	 * @param UserInsurance
	 * @return
	 */
	public UserInsurance getInsurInfo(UserInsurance userInsurance){
		return userInsuranceService.getInsurInfo(userInsurance);
	}
	public List<UserInsurance> findList(UserInsurance userInsurance) {
		return userInsuranceService.findList(userInsurance);
	}
	
	public Page<UserInsurance> findPage(Page<UserInsurance> page, UserInsurance userInsurance) {
		return userInsuranceService.findPage(page, userInsurance);
	}
	
	@Transactional(readOnly = false)
	public void save(UserInsurance userInsurance) {
		userInsuranceService.save(userInsurance);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserInsurance userInsurance) {
		userInsuranceService.delete(userInsurance);
	}
}
