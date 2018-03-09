/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.user;

import java.util.List;

import com.thinkgem.jeesite.common.utils.CacheUtils;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Address;
import com.thinkgem.jeesite.modules.wlpt.dao.user.AddressDao;

/**
 * 用户地址管理Service
 * @author 饶江龙
 * @version 2016-07-24
 */
@Service
@Transactional(readOnly = true)
public class AddressService extends CrudService<AddressDao, Address> {

	public Address get(String id) {
		return super.get(id);
	}
	
	public List<Address> findList(Address address) {
		return super.findList(address);
	}
	
	public Page<Address> findPage(Page<Address> page, Address address) {
		return super.findPage(page, address);
	}




	@Transactional(readOnly = false)
	public void save(Address address) {
		super.save(address);
	}
	
	@Transactional(readOnly = false)
	public void delete(Address address) {
		super.delete(address);
	}
	
}