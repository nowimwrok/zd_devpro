/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.base;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseAdvertisement;
import com.thinkgem.jeesite.modules.wlpt.dao.base.BaseAdvertisementDao;

/**
 * base_advertisementService
 * @author 王铸
 * @version 2016-08-06
 */
@Service
@Transactional(readOnly = true)
public class BaseAdvertisementService extends CrudService<BaseAdvertisementDao, BaseAdvertisement> {

	@Autowired
	private BaseAdvertisementDao baseAdvertisementDao;

	public BaseAdvertisement get(String id) {
		return super.get(id);
	}



	public List<BaseAdvertisement> findList(BaseAdvertisement baseAdvertisement) {
		return super.findList(baseAdvertisement);
	}
	
	public Page<BaseAdvertisement> findPage(Page<BaseAdvertisement> page, BaseAdvertisement baseAdvertisement) {
		return super.findPage(page, baseAdvertisement);
	}
	
	@Transactional(readOnly = false)
	public void save(BaseAdvertisement baseAdvertisement) {
		super.save(baseAdvertisement);
	}
	
	@Transactional(readOnly = false)
	public void delete(BaseAdvertisement baseAdvertisement) {
		super.delete(baseAdvertisement);
	}
	
	/**
	 * 批量操作
	 * @param map
	 * @return
	 */
	@Transactional(readOnly = false)
	public void deleteAll(Map<String,String> map){
		baseAdvertisementDao.deleteAll(map);
	}
	
	/**
	 * 根据广告名称获取广告信息
	 * @param advertname
	 * @return
	 */
	public List<BaseAdvertisement> getAdvertisementList(String advertname){
		BaseAdvertisement ba = new BaseAdvertisement();
		ba.setAdvertname(advertname);//广告名称
		ba.setIsdelete(DataDic.DEL_FLAG_NORMEL);//获取显示的数据
		List<BaseAdvertisement> list = findList(ba);
		
		return list;
	}
}