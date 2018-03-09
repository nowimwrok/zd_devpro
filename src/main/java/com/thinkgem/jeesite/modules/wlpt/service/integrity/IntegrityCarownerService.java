/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.integrity;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityCarowner;
import com.thinkgem.jeesite.modules.wlpt.dao.integrity.IntegrityCarownerDao;

/**
 * 诚信车主Service
 * 
 * @author fjc
 * @version 2016-07-27
 */
@Service
@Transactional(readOnly = true)
public class IntegrityCarownerService extends CrudService<IntegrityCarownerDao, IntegrityCarowner> {

	@Autowired
	private IntegrityCarownerDao integrityCarownerDao;

	public IntegrityCarowner get(String id) {
		return super.get(id);
	}
	/**
	 * 获取车主信息
	 * @param integrityCarowner
	 * @return
	 */
	public IntegrityCarowner findCarowner(IntegrityCarowner integrityCarowner) {
		return integrityCarownerDao.findCarowner(integrityCarowner);
	}

	public List<IntegrityCarowner> findList(IntegrityCarowner integrityCarowner) {
		return super.findList(integrityCarowner);
	}

	public Page<IntegrityCarowner> findPage(Page<IntegrityCarowner> page, IntegrityCarowner integrityCarowner) {
		return super.findPage(page, integrityCarowner);
	}

	@Transactional(readOnly = false)
	public void save(IntegrityCarowner integrityCarowner) {
		super.save(integrityCarowner);
	}

	@Transactional(readOnly = false)
	public void delete(IntegrityCarowner integrityCarowner) {
		super.delete(integrityCarowner);
	}

	@Transactional(readOnly = false)
	public boolean deletes(IntegrityCarowner integrityCarowner,Model model) {
		boolean falg = false;
		int state = 1;
		String message = "操作失败";
		if(integrityCarowner.getId()==null){
			state=0;
			message="信息不存在";
		}
		if(state==1){
			super.delete(integrityCarowner);
			falg = true;
			message="success";
		}
		model.addAttribute("message", message);
		model.addAttribute("state", state);
		return falg;
	}

	@Transactional(readOnly = false)
	public boolean saves(IntegrityCarowner integrityCarowner, Model model) {
		int state = 1;
		String message = "保存失败";
		boolean falg = false;
		if (integrityCarowner == null) {
			state = 0;
			message = "车主信息异常";
		}
		if (integrityCarowner.getName() == null) {
			state = 0;
			message = "车主名字信息异常";
		}
		if (integrityCarowner.getLinkphone() == null) {
			state = 0;
			message = "联系电话信息异常";
		}
		if (integrityCarowner.getIdcard() == null) {
			state = 0;
			message = "身份证信息异常";
		}
		if (integrityCarowner.getDriverlicense() == null) {
			state = 0;
			message = "驾驶证信息异常";
		}
		if (integrityCarowner.getOwncar() == null) {
			state = 0;
			message = "自由车辆证明信息异常";
		}
		if (integrityCarowner.getQualifycertficate() == null) {
			state = 0;
			message = "从业资格证信息异常";
		}
		if (integrityCarowner.getCarnumber() == null) {
			state = 0;
			message = "车牌号码信息异常";
		}
		if (integrityCarowner.getBodywork() == null) {
			state = 0;
			message = "车身照片信息异常";
		}
		if (integrityCarowner.getAuditrecord() == null) {
			state = 0;
			message = "年审记录信息异常";
		}
		if (integrityCarowner.getInsurance() == null) {
			state = 0;
			message = "保险资料信息异常";
		}
		if (state == 1) {
			super.save(integrityCarowner);
			message = "success";
			falg = true;
		}
		model.addAttribute("message", message);
		model.addAttribute("state", state);
		return falg;
	}
}