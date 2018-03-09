/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.user;

import java.util.List;

import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserBankinfo;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserBankinfoDao;

/**
 * 用户绑定银行卡Service
 * @author 饶江龙
 * @version 2016-07-21
 */
@Service
@Transactional(readOnly = true)
public class UserBankinfoService extends CrudService<UserBankinfoDao, UserBankinfo> {

	@Autowired
	private UserBankinfoDao userBankinfoDao;


	public UserBankinfo get(String id) {
		return super.get(id);
	}

	/***
	 * 通过银行-用户对象获取信息
	 * @param userBankinfo
	 * @return
     */
	public UserBankinfo getBankByConditon(UserBankinfo userBankinfo) {
		return userBankinfoDao.getBankByConditon(userBankinfo);
	}
	
	public List<UserBankinfo> findList(UserBankinfo userBankinfo) {
		return super.findList(userBankinfo);
	}
	
	public Page<UserBankinfo> findPage(Page<UserBankinfo> page, UserBankinfo userBankinfo) {
		return super.findPage(page, userBankinfo);
	}

	/***
	 * 保存用户银行信息--验证是否已绑定
	 * @param userBankinfo
     */
	@Transactional(readOnly = false)
	public void save(UserBankinfo userBankinfo) {
		super.save(userBankinfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(UserBankinfo userBankinfo) {
		super.delete(userBankinfo);
	}
	
}