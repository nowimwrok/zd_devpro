/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.insur;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsuranceInfo;
import com.thinkgem.jeesite.modules.wlpt.dao.insur.UserInsuranceInfoDao;

/**
 * 保险险种记录Service
 * @author zyj
 * @version 2017-11-17
 */
@Service
@Transactional(readOnly = true)
public class UserInsuranceInfoService extends CrudService<UserInsuranceInfoDao, UserInsuranceInfo> {

	@Autowired
	private UserInsuranceInfoDao userInsuranceInfoDao;

	public UserInsuranceInfo get(String id) {
		return super.get(id);
	}



	public List<UserInsuranceInfo> findList(UserInsuranceInfo userInsuranceInfo) {
		return super.findList(userInsuranceInfo);
	}
	
	public Page<UserInsuranceInfo> findPage(Page<UserInsuranceInfo> page, UserInsuranceInfo userInsuranceInfo) {
		return super.findPage(page, userInsuranceInfo);
	}
	
	@Transactional(readOnly = false)
	public void save(UserInsuranceInfo userInsuranceInfo) {
		super.save(userInsuranceInfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserInsuranceInfo userInsuranceInfo) {
		super.delete(userInsuranceInfo);
	}
	
}