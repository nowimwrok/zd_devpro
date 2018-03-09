/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.user;

import java.util.ArrayList;
import java.util.List;

import com.thinkgem.jeesite.modules.sys.dao.RoleDao;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;

/**
 * 平台角色Service
 * @author 饶江龙
 * @version 2016-07-18
 */
@Service
@Transactional(readOnly = true)
public class WlptRoleService extends CrudService<RoleDao, Role> {

	
	public Role get(String id) {
		Role Role = super.get(id);
		return Role;
	}

	public List<Role> findRole(){
		List<Role> varList=new ArrayList<>();
		Office office=new Office();
		office.setName("");
		return varList;
	}
	
	public List<Role> findList(Role Role) {
		return super.findList(Role);
	}
	
	public Page<Role> findPage(Page<Role> page, Role Role) {
		return super.findPage(page, Role);
	}
	
	@Transactional(readOnly = false)
	public void save(Role Role) {
		super.save(Role);
	}
	
	@Transactional(readOnly = false)
	public void delete(Role Role) {
		super.delete(Role);
	}
	
}