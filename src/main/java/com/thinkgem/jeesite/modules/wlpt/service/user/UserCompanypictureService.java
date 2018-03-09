/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.user;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompanypicture;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserCompanypictureDao;

/**
 * 企业图片信息Service
 * 
 * @author fjc
 * @version 2016-07-27
 */
@Service
@Transactional(readOnly = true)
public class UserCompanypictureService extends CrudService<UserCompanypictureDao, UserCompanypicture> {

	@Autowired
	private UserCompanypictureDao userCompanypictureDao;

	public UserCompanypicture get(String id) {
		return super.get(id);
	}

	/**
	 * 获取企业图片信息 单条
	 */
	public UserCompanypicture get(UserCompanypicture userCompanypicture) {
		return userCompanypictureDao.getByUserCompanypicture(userCompanypicture);
	}
	
	public List<UserCompanypicture> findList(UserCompanypicture userCompanypicture) {
		return super.findList(userCompanypicture);
	}

	public Page<UserCompanypicture> findPage(Page<UserCompanypicture> page, UserCompanypicture userCompanypicture) {
		return super.findPage(page, userCompanypicture);
	}

	@Transactional(readOnly = false)
	public void save(UserCompanypicture userCompanypicture) {
		super.save(userCompanypicture);
	}

	@Transactional(readOnly = false)
	public void delete(UserCompanypicture userCompanypicture) {
		super.delete(userCompanypicture);
	}

	@Transactional(readOnly = false)
	public boolean saves(UserCompanypicture userCompanypicture, Model model) {
		boolean falg = false;
		int state = 1;
		String message = "保存失败";
		if (userCompanypicture == null) {
			state = 0;
			message = "信息不存在";
		}
		if (state == 1) {
			super.save(userCompanypicture);
			falg = true;
			message = "success";
		}
		model.addAttribute("message", message);
		model.addAttribute("state", state);
		return falg;
	}
	/**
	 * 获取图片信息
	 * @param usercompanypicture
	 * @return
	 */
	public UserCompanypicture findPicture(UserCompanypicture userCompanypicture) {
		return userCompanypictureDao.findPicture(userCompanypicture);
	}
}