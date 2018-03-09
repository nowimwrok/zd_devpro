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
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityEnterprise;
import com.thinkgem.jeesite.modules.wlpt.dao.integrity.IntegrityEnterpriseDao;

/**
 * 诚信企业Service
 * 
 * @author fjc
 * @version 2016-07-27
 */
@Service
@Transactional(readOnly = true)
public class IntegrityEnterpriseService extends CrudService<IntegrityEnterpriseDao, IntegrityEnterprise> {

	@Autowired
	private IntegrityEnterpriseDao integrityEnterpriseDao;

	public IntegrityEnterprise get(String id) {
		return super.get(id);
	}

	/**
	 * 获取企业诚信信息
	 * @param integrityEnterprise
	 * @return
	 */
	public IntegrityEnterprise findEnterprise(IntegrityEnterprise integrityEnterprise){
		return integrityEnterpriseDao.findEnterprise(integrityEnterprise);
	}
	
	public List<IntegrityEnterprise> findList(IntegrityEnterprise integrityEnterprise) {
		return super.findList(integrityEnterprise);
	}

	public Page<IntegrityEnterprise> findPage(Page<IntegrityEnterprise> page, IntegrityEnterprise integrityEnterprise) {
		return super.findPage(page, integrityEnterprise);
	}

	@Transactional(readOnly = false)
	public void save(IntegrityEnterprise integrityEnterprise) {
		super.save(integrityEnterprise);
	}

	@Transactional(readOnly = false)
	public void delete(IntegrityEnterprise integrityEnterprise) {
		super.delete(integrityEnterprise);
	}

	@Transactional(readOnly = false)
	public boolean saves(IntegrityEnterprise integrityEnterprise, Model model) {
		int state = 1;
		String message = "保存失败";
		boolean falg = false;
		if (integrityEnterprise == null) {
			state = 0;
			message = "企业信息异常";
		}
		if (integrityEnterprise.getName() == null) {
			state = 0;
			message = "法人姓名信息异常";
		}
		if (integrityEnterprise.getLinkphone() == null) {
			state = 0;
			message = "联系方式信息异常";
		}
		if (integrityEnterprise.getIdcard() == null) {
			state = 0;
			message = "身份证信息异常";
		}
		if (integrityEnterprise.getPersionaladdress() == null) {
			state = 0;
			message = "个人地址信息异常";
		}
		if (integrityEnterprise.getCertificateproperty() == null) {
			state = 0;
			message = "房产证图片信息异常";
		}
		if (integrityEnterprise.getCompanyname() == null) {
			state = 0;
			message = "公司名称信息异常";
		}
		if (integrityEnterprise.getCompanyaddress() == null) {
			state = 0;
			message = "公司地址信息异常";
		}
		if (integrityEnterprise.getOperationyears() == null) {
			state = 0;
			message = "经营年限信息异常";
		}
		if (integrityEnterprise.getCompanyinfo() == null) {
			state = 0;
			message = "企业信息介绍信息异常";
		}
		if (integrityEnterprise.getStallscorporate() == null) {
			state = 0;
			message = "档口和法人照片信息异常";
		}
		if (integrityEnterprise.getOfficespace() == null) {
			state = 0;
			message = "办公场所信息异常";
		}
		if (integrityEnterprise.getStorageplace() == null) {
			state = 0;
			message = "仓库存储信息异常";
		}
		if (integrityEnterprise.getStaffphoto() == null) {
			state = 0;
			message = "员工合照信息异常";
		}
		if (integrityEnterprise.getBusinesslicense() == null) {
			state = 0;
			message = "营业执照信息异常";
		}
		if (integrityEnterprise.getBankopening() == null) {
			state = 0;
			message = "银行开户信息异常";
		}
		if (integrityEnterprise.getRoadtransport() == null) {
			state = 0;
			message = "道路运输信息异常";
		}
		if (integrityEnterprise.getOwncar() == null) {
			state = 0;
			message = "自由车辆证明信息异常";
		}
		if (integrityEnterprise.getUpstreamcontract() == null) {
			state = 0;
			message = "上游运输合同信息异常";
		}
		if (integrityEnterprise.getOperationyearstime() == null) {
			state = 0;
			message = "企业成立时间信息异常";
		}
		if (state == 1) {
			super.save(integrityEnterprise);
			message = "success";
			falg = true;
		}
		model.addAttribute("message", message);
		model.addAttribute("state", state);
		return falg;
	}

	@Transactional(readOnly = false)
	public boolean deletes(IntegrityEnterprise integrityEnterprise,Model model) {
		boolean falg = false;
		int state = 1;
		String message = "操作失败";
		if(integrityEnterprise.getId()==null){
			state=0;
			message="信息不存在";
		}
		if(state==1){
			super.delete(integrityEnterprise);
			falg = true;
			message="success";
		}
		model.addAttribute("message", message);
		model.addAttribute("state", state);
		return falg;
	}
}