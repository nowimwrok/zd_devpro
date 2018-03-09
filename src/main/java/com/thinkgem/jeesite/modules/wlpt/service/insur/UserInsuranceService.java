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
import com.thinkgem.jeesite.modules.wlpt.dao.insur.UserInsuranceDao;
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsurance;

/**
 * 保险Service
 * @author 保险
 * @version 2016-12-19
 */
@Service
@Transactional(readOnly = true)
public class UserInsuranceService extends CrudService<UserInsuranceDao, UserInsurance> {

	@Autowired
	private UserInsuranceDao userInsuranceDao;

	public UserInsurance get(String id) {
		return super.get(id);
	}

	/**
	 * 根据统计获取单条数据
	 * @param userInsurance
	 * @return
	 */
	public UserInsurance getInsurInfo(UserInsurance userInsurance){
		return userInsuranceDao.getInsurInfo(userInsurance);
	}

	public List<UserInsurance> findList(UserInsurance userInsurance) {
		return super.findList(userInsurance);
	}
	
	public Page<UserInsurance> findPage(Page<UserInsurance> page, UserInsurance userInsurance) {
		return super.findPage(page, userInsurance);
	}
	
	@Transactional(readOnly = false)
	public void save(UserInsurance userInsurance) {
		super.save(userInsurance);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserInsurance userInsurance) {
		super.delete(userInsurance);
	}
	/**
	 * 修改测算信息
	 * @param userInsurance
	 * @return
	 */
	@Transactional(readOnly = false)
	public int updateMeasuresInfo(UserInsurance userInsurance){
		return userInsuranceDao.updateMeasuresInfo(userInsurance);
	}
	/**
	 * 批量添加险种记录
	 * @param userInsurance
	 * @return
	 */
	@Transactional(readOnly = false)
	public int insertInsuranceInfo(UserInsurance userInsurance){
		return userInsuranceDao.insertInsuranceInfo(userInsurance);
	}
}