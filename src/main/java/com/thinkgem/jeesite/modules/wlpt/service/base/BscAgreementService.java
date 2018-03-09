/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.base;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscAgreement;
import com.thinkgem.jeesite.modules.wlpt.dao.base.BscAgreementDao;

/**
 * 系统文案Service
 * @author 王铸
 * @version 2016-08-03
 */
@Service
@Transactional(readOnly = true)
public class BscAgreementService extends CrudService<BscAgreementDao, BscAgreement> {

	@Autowired
	private BscAgreementDao bscAgreementDao;

	public BscAgreement get(String id) {
		return super.get(id);
	}



	public List<BscAgreement> findList(BscAgreement bscAgreement) {
		return super.findList(bscAgreement);
	}
	
	public Page<BscAgreement> findPage(Page<BscAgreement> page, BscAgreement bscAgreement) {
		return super.findPage(page, bscAgreement);
	}
	
	@Transactional(readOnly = false)
	public void save(BscAgreement bscAgreement) {
		super.save(bscAgreement);
	}
	
	@Transactional(readOnly = false)
	public void delete(BscAgreement bscAgreement) {
		super.delete(bscAgreement);
	}
	/**
	 * 批量操作
	 * @param map
	 * @return
	 */
	@Transactional(readOnly = false)
	public void deleteAll(Map<String,String> map){
		bscAgreementDao.deleteAll(map);
	}
}