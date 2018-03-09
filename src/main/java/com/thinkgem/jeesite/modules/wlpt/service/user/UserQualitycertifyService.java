/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.user;

import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Driver;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompany;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompanypicture;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserIdcard;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserQualitycertify;
import com.thinkgem.jeesite.modules.wlpt.service.car.CarService;
import com.thinkgem.jeesite.modules.wlpt.service.car.DriverService;
import com.thinkgem.jeesite.modules.sys.dao.UserDao;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.Userinfo;
import com.thinkgem.jeesite.modules.sys.service.UserinfoService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.dao.user.UserQualitycertifyDao;

/**
 * 资质认证Service
 * 
 * @author fjc
 * @version 2016-08-01
 */
@Service
@Transactional(readOnly = true)
public class UserQualitycertifyService extends CrudService<UserQualitycertifyDao, UserQualitycertify> {

	@Autowired
	private UserQualitycertifyDao userQualitycertifyDao;

	@Autowired
	private UserCompanyService userCompanyService;

	@Autowired
	private UserinfoService userinfoService;

	@Autowired
	private UserIdcardService userIdcardService;

	@Autowired
	private UserCompanypictureService userCompanypictureService;

	@Autowired
	private DriverService driverService;

	@Autowired
	private CarService carService;

	@Autowired
	private UserDao userDao;

	public UserQualitycertify get(String id) {
		return super.get(id);
	}

	public UserQualitycertify getQualitycertifyInfo(UserQualitycertify userQualitycertify) {
		return userQualitycertifyDao.getQualitycertifyInfo(userQualitycertify);
	}
	
	
	public List<UserQualitycertify> findList(UserQualitycertify userQualitycertify) {
		return super.findList(userQualitycertify);
	}

	public Page<UserQualitycertify> findPage(Page<UserQualitycertify> page, UserQualitycertify userQualitycertify) {
		return super.findPage(page, userQualitycertify);
	}

	@Transactional(readOnly = false)
	public void save(UserQualitycertify userQualitycertify) {
		super.save(userQualitycertify);
	}

	@Transactional(readOnly = false)
	public void delete(UserQualitycertify userQualitycertify) {
		super.delete(userQualitycertify);
	}



	/**
	 * 获取车辆信息
	 * 
	 * @param id
	 * @return
	 */
	public Model getCarInfo(String id) {
		Model model = null;
		Car car = new Car();
		try {
			car.setId(id);
			car = carService.get(car);
		} catch (Exception e) {
			// TODO: handle exception
		}
		model.addAttribute("car", car);
		return model;
	}


}