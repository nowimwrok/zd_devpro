/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.biz.qualitycertifyBiz;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.sms.util.SmsConfig;
import com.thinkgem.jeesite.common.sms.util.SmsUtil;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.modules.sys.dao.UserDao;
import com.thinkgem.jeesite.modules.sys.dao.UserinfoDao;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.Userinfo;
import com.thinkgem.jeesite.modules.sys.service.UserinfoService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.IntegrityBiz.IntegrityBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.carBiz.CarBiz;
import com.thinkgem.jeesite.modules.weixin.constant.ConstantWeChat;
import com.thinkgem.jeesite.modules.wlpt.biz.driverBiz.DriverBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Attach;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Driver;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompany;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserCompanypicture;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserIdcard;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserQualitycertify;
import com.thinkgem.jeesite.modules.wlpt.service.car.AttachService;
import com.thinkgem.jeesite.modules.wlpt.service.car.CarService;
import com.thinkgem.jeesite.modules.wlpt.service.car.DriverService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserCompanyService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserCompanypictureService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserIdcardService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserQualitycertifyService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 
 *资质认证接口
 * @author fjc
 * @version 2016-08-02
 */
@Service
@Transactional(readOnly = true)
public class QualityCertifyBiz {

	@Autowired
	private UserCompanypictureService userCompanypictureService;

	@Autowired
	private UserCompanyService userCompanyService;

	@Autowired
	private UserinfoService userinfoService;

	@Autowired
	private UserQualitycertifyService userQualitycertifyService;

	@Autowired
	private UserinfoDao userinfoDao;

	@Autowired
	private UserDao userDao;

	@Autowired
	private UserIdcardService userIdcardService;

	@Autowired
	private DriverService driverService;
	
	@Autowired
	private AttachService attachService;
	
	@Autowired
	private CarService carService;
	
	@Autowired
	private CarBiz carBiz;
	
	@Autowired
	private IntegrityBiz integrityBiz;

	/**
	 * 保存认证信息
	 * 
	 * @param userid
	 *            申请认证用户id
	 * @param id
	 *            认证目标id
	 * @param type
	 *            认证类型 0个人 1企业 2车辆 3司机
	 */
	@Transactional(readOnly = false)
	public Boolean addQualitycertify(String userid, String id, String type) {
		Boolean result = false;
		String guid = "";
		try {
			User us = UserUtils.getUser();
			String[] keyword = {us.getLoginName(),us.getPhone()};
			guid = id;
			int statu = 0;
			UserCompany userCompany = new UserCompany();
			
			if (type.equals(DataDic.AUTHEN_PERSONAL)) {// 个人
				if (UserUtils.get(guid) != null) {
					statu = 1;
	                
				}
			} else if (type.equals(DataDic.AUTHEN_COMPANY)) {// 企业
				userCompany = userCompanyService.get(guid);
				if (userCompany != null) {
					statu = 1;
	                
				}
				statu = 1;
			}else if(type.equals(DataDic.AUTHEN_CAR)){//车辆
				
				UserQualitycertify userQualitycertify = new UserQualitycertify();
				User user = new User();
				user.setId(userid);
				userQualitycertify.setRequestuser(user);
				userQualitycertify.setRequesttime(new Date());
				userQualitycertify.setCertifytype(type);
				userQualitycertify.setCertifystatus(DataDic.QUALITY_WAITING);// 等待审核
				userQualitycertify.setTargetid(guid);
				userQualitycertifyService.save(userQualitycertify);
				
				
                SmsUtil.sendSmsMesge(null, DataDic.SMSCODE_Apply, Const.SMSFUN_APPLY_PHONE, Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_AUTHEN, keyword, null, null, true,SmsConfig.smsUserapply);
				return true;
			}

			if (statu == 1) {
				UserQualitycertify userQualitycertify = new UserQualitycertify();
				User user = new User();
				user.setId(userid);
				userQualitycertify.setRequestuser(user);
				userQualitycertify.setRequesttime(new Date());
				userQualitycertify.setCertifytype(type);
				userQualitycertify.setCertifystatus(DataDic.QUALITY_WAITING);// 等待审核
				userQualitycertify.setTargetid(guid);
				userQualitycertifyService.save(userQualitycertify);

				User loginuser = UserUtils.getUser();
				Userinfo userinfo = new Userinfo();
				userinfo.setStatus(DataDic.AUTHENWAITING);// 认证中
				if (type.equals(DataDic.AUTHEN_PERSONAL)) {// 个人
					userinfo.setId(loginuser.getUserinfo().getId());
					userinfo.preUpdate();
					userinfoDao.update(userinfo);
				} else if (type.equals(DataDic.AUTHEN_COMPANY)) {// 企业
					userinfo.setId(loginuser.getUserinfo().getId());
					userinfo.preUpdate();
					userinfoDao.update(userinfo);
					userCompany.setUser(loginuser);
					userCompany.setStatus(DataDic.AUTHENWAITING);
					userCompanyService.save(userCompany);
				}
				

                SmsUtil.sendSmsMesge(null, DataDic.SMSCODE_Apply, Const.SMSFUN_APPLY_PHONE, Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_AUTHEN, keyword, null, null, true,SmsConfig.smsUserapply);
				result = true;
			} else {
				User loginuser = UserUtils.getUser();
				Userinfo userinfo = new Userinfo();
				userinfo.setStatus(DataDic.UNAUTHEN);// 未认证
				if (type.equals(DataDic.AUTHEN_PERSONAL)) {// 个人
					userinfo.setId(loginuser.getUserinfo().getId());
					userinfo.preUpdate();
					userinfoDao.update(userinfo);
				} else if (type.equals(DataDic.AUTHEN_COMPANY)) {// 企业
					userinfo.setId(loginuser.getUserinfo().getId());
					userinfo.preUpdate();
					userinfoDao.update(userinfo);
					userCompany.setUser(loginuser);
					userCompany.setStatus(DataDic.UNAUTHEN);
					userCompanyService.save(userCompany);
				}
				result = false;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = false;
		}

		return result;
	}

	/**
	 * 获取企业信息 返回 UserCompanypicture对象
	 * 
	 * @return
	 */
	public UserCompanypicture getCompanyInfo() {
		UserCompany userCompany = new UserCompany();
		UserCompanypicture userCompanypicture = new UserCompanypicture();
		User user = UserUtils.getUser();
		try {
			if (user != null) {
				userCompany = userCompanyService.get(user.getUserinfo().getUserCompany().getId());
				userCompanypicture.setUserCompany(userCompany);
				userCompanypicture = userCompanypictureService.get(userCompanypicture);
				userCompany.setUser(user);
				userCompanypicture.setUserCompany(userCompany);
				;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return userCompanypicture;
	}

	/**
	 * 获取企业信息 返回 UserCompany对象
	 * 
	 * @return
	 */
	public UserCompany getCompanyAndPictureInfo() {
		UserCompany userCompany = new UserCompany();
		User user = UserUtils.getUser();
		try {
			if (user.getId() != null) {
				userCompany = userCompanyService.get(user.getUserinfo().getUserCompany().getId());
				user = UserUtils.findUser(user);
				userCompany.setUser(user);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return userCompany;
	}

	/**
	 * 企业认证
	 * 
	 * @param companyName
	 *            公司名称
	 * @param companyAddress
	 *            公司地址
	 * @param legalPerson
	 *            公司联系人
	 * @param businesslicenceNum
	 *            营业执照号
	 * @param businesslicenceNumImg
	 *            营业执照图片
	 * @param headMobile
	 *            手机号码
	 * @param idcardImg
	 *            身份证图片 正反面2张 ;拼接
	 * @param transportcardImg
	 *            运输许可证图片
	 * @return
	 */
	@Transactional(readOnly = false)
	public Boolean cpy_authen(String companyName,String provinceCityDistrict, String companyAddress, String legalPerson, String businesslicenceNum,
			String businesslicenceNumImg, String headMobile, String idcardImg, String transportcardImg) {
		Boolean result = false;
		User user = new User();
		String status = "";
		String companyid = "";
		try {
			// 登陆的用户
			User loginuser = UserUtils.getUser();
			if (loginuser != null) {
				user = UserUtils.getUserById(loginuser.getId());
			}
			if (user != null) {
				status = user.getUserinfo().getStatus();
				companyid = user.getUserinfo().getUserCompany().getId();
			}
			if (status.equals(DataDic.AUTHENWAITING)) {// 等待认证
				return result;
			} else if (status.equals(DataDic.UNAUTHEN) || status.equals(DataDic.AUTHENFAILED)) {// 用户状态为未认证
																								// 或者认证不通过
				// 保存用户认证状态
				Userinfo userinfo = new Userinfo();
				userinfo.setStatus(DataDic.AUTHENWAITING);// 认证中
				userinfo.setId(user.getUserinfo().getId());
				userinfo.preUpdate();
				userinfoDao.update(userinfo);

				// 查询companyid信息
				UserCompany userCompany = new UserCompany();
				userCompany = userCompanyService.get(companyid);
				// 保存企业基本信息
				userCompany.preUpdate();
				userCompany.setCompanyname(companyName);
				userCompany.setStatus(DataDic.AUTHENWAITING);
				userCompany.setProvinceCityDistrict(provinceCityDistrict);
				userCompany.setCompanyaddress(companyAddress);
				userCompany.setLegalperson(legalPerson);
				userCompany.setBusinesslicencenum(businesslicenceNum);
				userCompany.setHeadermobile(headMobile);
				userCompanyService.save(userCompany);
				// 保存企业图片信息
				UserCompanypicture userCompanypicture = new UserCompanypicture();
				userCompanypicture.setUserCompany(userCompany);
				userCompanypicture = userCompanypictureService.get(userCompanypicture);
				if (userCompanypicture == null) {
					userCompanypicture = new UserCompanypicture();
					userCompanypicture.preInsert();
					userCompanypicture = new UserCompanypicture();
					userCompanypicture.setUserCompany(userCompany);
				}
				userCompanypicture.preUpdate();
				userCompanypicture.setBusinesslicencenumimg(businesslicenceNumImg);
				userCompanypicture.setIdcardimg(idcardImg);
				userCompanypicture.setTransportcardimg(transportcardImg);
				userCompanypictureService.save(userCompanypicture);

				Boolean bl = addQualitycertify(user.getId(), userCompany.getId(), DataDic.AUTHEN_COMPANY);
				if (bl) {
					result = true;
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 获取个人信息
	 * 
	 * @param id
	 * @return
	 */
	public User getUserPersonalInfo() {
		User user = new User();
		Userinfo userinfo = new Userinfo();
		try {
			user = UserUtils.findUser(UserUtils.getUser());
			if (user.getId() != null) {
				userinfo = userinfoService.getAndIdcard(user.getId());
				if (userinfo != null) {
					user.setUserinfo(userinfo);
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return user;

	}

	/**
	 * 个人认证
	 * 
	 * @param name
	 *            姓名
	 * @param identityCard
	 *            身份证号
	 * @param slocalphoto
	 *            身份证图片
	 * @return
	 */
	@Transactional(readOnly = false)
	public Boolean personalAuthen(String name, String identityCard, String slocalphoto) {
		Boolean result = false;
		try {
			User user = UserUtils.getUser();
			String status = user.getUserinfo().getStatus();
			if (status.equals(DataDic.AUTHENWAITING)) {
				return result;
			} else if (status.equals(DataDic.UNAUTHEN) || status.equals(DataDic.AUTHENFAILED)) {
				// 保存身份证信息
				UserIdcard userIdcard = new UserIdcard();
				userIdcard.setSname(name);
				userIdcard.setIdcardnum(identityCard);
				userIdcard.setSlocalphoto(slocalphoto);
				userIdcard.setTlocaltime(new Date());
				userIdcard.setSuploader(user.getName());

				UserIdcard idcard = new UserIdcard();
				idcard = userIdcardService.getByIdcard(identityCard);
				if (idcard == null) {
					userIdcardService.save(userIdcard);
				} else {
					userIdcard.setId(idcard.getId());
					userIdcardService.save(userIdcard);
				}
				// 保存userinfo用户认证状态
				Userinfo userinfo = new Userinfo();
				userinfo.setStatus(DataDic.AUTHENWAITING);// 认证中
				userinfo.setId(user.getUserinfo().getId());
				userinfo.setIdentitycard(identityCard);
				userinfo.preUpdate();
				userinfoDao.update(userinfo);
				// 更新用户user信息
				User updateuser = new User();
				updateuser.setId(user.getId());
				updateuser.setName(name);
				updateuser.preUpdate();
				userDao.update(updateuser);

				// 保存认证信息
				Boolean bl = addQualitycertify(user.getId(), user.getId(), DataDic.AUTHEN_PERSONAL);
				if (bl) {
					result = true;
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 获取司机信息 返回 driver对象
	 * 
	 * @param id
	 * @return
	 */
	public Driver getDriverInfo() {
		User user = new User();
		Driver driver = new Driver();
		try {
			user = UserUtils.getUser();
			if (user != null) {
				driver = driverService.getDriverByUserId(user.getId());
				driver.setUser(user);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return driver;

	}

	/**
	 * 获取司机信息 返回 user对象
	 * 
	 * @param id
	 * @return
	 */
	public User getUserAndDriverInfo() {
		User user = new User();
		try {
			user = UserUtils.findUser(UserUtils.getUser());
			if (user.getId() != null) {
				Driver driver = driverService.getDriverByUserId(user.getId());
				user.setDriver(driver);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return user;

	}

	/**
	 * 车主认证
	 * 
	 * @param name
	 *            司机姓名
	 * @param identityCard
	 *            身份证号码
	 * @param driverMobile
	 *            手机号码
	 * @param driverheadImg
	 *            司机头像
	 * @param idcardImg
	 *            身份证证图片正反面2张 ;分隔
	 * @param driverlicImg
	 *            驾驶证图片正反面2张 ;分隔
	 * @return
	 */
	@Transactional(readOnly = false)
	public Boolean percar_authens(String name, String identityCard, String driverMobile, String driverheadImg,
			String idcardImg, String driverlicImg) {
		Boolean result = false;
		try {
			User user = UserUtils.findUser(UserUtils.getUser());
			String status = user.getUserinfo().getStatus();
			if (status.equals(DataDic.AUTHENWAITING)) {
				return result;
			} else if (status.equals(DataDic.UNAUTHEN) || status.equals(DataDic.AUTHENFAILED)) {
				// 保存身份证信息
				UserIdcard userIdcard = new UserIdcard();
				userIdcard.setSname(name);
				userIdcard.setIdcardnum(identityCard);
				userIdcard.setSlocalphoto(idcardImg);
				userIdcard.setTlocaltime(new Date());
				userIdcard.setSuploader(name);

				UserIdcard idcard = new UserIdcard();
				idcard = userIdcardService.getByIdcard(identityCard);
				if (idcard == null) {
					userIdcardService.save(userIdcard);
				} else {
					userIdcard.setId(idcard.getId());
					userIdcardService.save(userIdcard);
				}

				// 保存用户认证状态
				Userinfo userinfo = new Userinfo();
				userinfo.setStatus(DataDic.AUTHENWAITING);// 认证中
				userinfo.setId(user.getUserinfo().getId());
				userinfo.preUpdate();
				userinfoDao.update(userinfo);
				
				User users=new User();
				users.setId(user.getId());
				users.setName(name);
				users.preUpdate();
				userDao.update(users);

				// 保存认证信息
				Boolean bl = addQualitycertify(user.getId(), user.getId(), DataDic.AUTHEN_PERSONAL);
				if (bl) {
					// 保存司机信息
					Driver driver = new Driver();
					driver.setUser(user);
					driver.setDrivername(name);
					driver.setDrivermobile(driverMobile);
					driver.setIdcardnum(identityCard);
					driver.setStatus(DataDic.AUTHENWAITING);
					driver.setIdcardimg(idcardImg);
					driver.setDriverlicimg(driverlicImg);
					driver.setDriverheadimg(driverheadImg);
					driverService.save(driver);
					
					
					
					Attach attach= new Attach();
					Attach newattach= new Attach();
					attach.setUser(user);
					attach.setReuser(user);
					attach.setIsagree(DataDic.DRIVER_ISAGREE_YES);
					newattach=attachService.findAttach(attach);
					if(newattach==null){
						attachService.save(attach);
					}					
					result = true;
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 车辆认证
	 * 
	 * @param car
	 * @return
	 */
	@Transactional(readOnly = false)
	public Boolean car_authens(Car car){
		Boolean result = false;
		car=carService.get(car.getId());
		if(car.getStatus().equals(DataDic.AUTHENWAITING)||car.getStatus().equals(DataDic.AUTHENSUCCES)){
			return result;
		}
		car.setStatus(DataDic.AUTHENWAITING);//认证中
		carService.save(car);
		// 保存认证信息
		Boolean bl = addQualitycertify(UserUtils.getUser().getId(), car.getId(), DataDic.AUTHEN_CAR);
		if(bl){
			return true;
		}
		return result;
	}

	/**
	 * 跳转认证审核
	 * 
	 * @param qualityId
	 * @param targeid
	 * @param certifytpe
	 * @return
	 */
	public Map<String, Object> goAudit(String qualityId, String targeid, String certifytpe) {
		Map<String, Object> map = new HashMap<String, Object>();
		String redirectView = "";
		UserQualitycertify userQualitycertify = new UserQualitycertify();
		userQualitycertify = userQualitycertifyService.get(qualityId);
		try {
			if (userQualitycertify != null && targeid != null && !targeid.equals("")) {
				certifytpe = userQualitycertify.getCertifytype();
				targeid = userQualitycertify.getTargetid();

				User user = new User();
				user.setId(targeid);
				user = UserUtils.findUser(user);

				if (certifytpe.equals(DataDic.AUTHEN_PERSONAL)) {// 个人
					if (user != null && user.getRole().getEnname().equals(DataDic.ROLE_CAROWNER)) {// 如果是车主的个人信息
						Driver driver = new Driver();
						driver = driverService.getDriverByUserId(targeid);
						map.put("info", driver);
						redirectView = "driver";
					} else {
						Userinfo userinfo = new Userinfo();
						userinfo = userinfoService.getAndIdcard(targeid);
						map.put("info", userinfo);
						redirectView = "personal";
					}
				}
				if (certifytpe.equals(DataDic.AUTHEN_COMPANY)) {// 企业
					UserCompany userCompany = new UserCompany();
					UserCompanypicture userCompanypicture = new UserCompanypicture();
					userCompany = userCompanyService.get(targeid);
					userCompanypicture.setUserCompany(userCompany);
					userCompanypicture = userCompanypictureService.get(userCompanypicture);
					map.put("info", userCompanypicture);
					redirectView = "company";
				}
				if (certifytpe.equals(DataDic.AUTHEN_CAR)) {// 车辆
					Car car=carService.get(targeid);
					map.put("info", car);
					redirectView = "car";
				}
				if (certifytpe.equals(DataDic.AUTHEN_DRIVER)) {// 司机
					Driver driver = new Driver();
					driver = driverService.getDriverByUserId(targeid);
					map.put("info", driver);
					redirectView = "driver";
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		map.put("redirectView", redirectView);
		return map;
	}

	/**
	 * 后台审核
	 * 
	 * @param certifyId
	 * @param certifystatus
	 * @param certifyComment
	 * @return
	 */
	@Transactional(readOnly = false)
	public Boolean editCertify(String certifyId, String certifyStatus, String certifyComment) {
		Boolean result = false;
		UserQualitycertify userQualitycertify = new UserQualitycertify();
		UserCompany userCompany = new UserCompany();
		Userinfo userinfo = new Userinfo();
		try {
			User user = UserUtils.getUser();

			UserQualitycertify qualitycertify = userQualitycertifyService.get(certifyId);
			userQualitycertify.setId(qualitycertify.getId());
			userQualitycertify.setCertifystatus(certifyStatus);
			userQualitycertify.setCertifytime(new Date());
			userQualitycertify.setCertifycomment(certifyComment);
			userQualitycertify.setCertifyuser(user);
			userQualitycertifyService.save(userQualitycertify);
			/// 短信内容
			/*String[] keyword = {};*/
			
			String sms="";
			String smsCode = DataDic.SMSCODE_AUTHENSUCCES;
			String smsAuthSuccess=SmsConfig.smsAuthSuccess;
			if (certifyStatus.equals(DataDic.QUALITY_SUCCES)) {// 审核通过
				userinfo.setStatus(DataDic.AUTHENSUCCES);// 认证通过
				userCompany.setStatus(DataDic.AUTHENSUCCES);
				smsCode = DataDic.SMSCODE_AUTHENSUCCES;
				smsAuthSuccess = SmsConfig.smsAuthSuccess;
			} else if (certifyStatus.equals(DataDic.QUALITY_FAILED)) {// 审核不通过
				userinfo.setStatus(DataDic.AUTHENFAILED);// 用户状态-认证不通过
				userCompany.setStatus(DataDic.AUTHENFAILED);// 公司状态-认证不通过
				sms = userQualitycertify.getCertifycomment()+"}}";
				smsCode = DataDic.SMSCODE_AUTHENFILED;
				smsAuthSuccess = SmsConfig.smsAuthFiled;
			}
			if (qualitycertify.getCertifytype().equals(DataDic.AUTHEN_PERSONAL)) {// 个人
				userinfo.setId(qualitycertify.getRequestuser().getUserinfo().getId());
				Userinfo userinfoss= userinfoService.get(userinfo);
				userinfo.setPoint(userinfoss.getPoint());
				System.out.println("===========================资质认证前的积分"+userinfoss.getPoint()+"===========================");
				userinfo.preUpdate();
				userinfoDao.update(userinfo);

				if(DataDic.QUALITY_SUCCES.equals(certifyStatus) && !DataDic.QUALITY_SUCCES.equals(qualitycertify.getCertifystatus())){
					userinfo.setUser(qualitycertify.getRequestuser());
					integrityBiz.updateIntegrityPoint(userinfo,DataDic.INTEGRITY_POINT_AUTHENSUCES,DataDic.ROLE_GOODSOWNER);//更新诚信积分
				}

			} else if (qualitycertify.getCertifytype().equals(DataDic.AUTHEN_COMPANY)) {// 企业
				userinfo.setId(qualitycertify.getRequestuser().getUserinfo().getId());
				Userinfo userinfoss= userinfoService.get(userinfo);
				userinfo.preUpdate();
				userinfo.setPoint(userinfoss.getPoint());
				System.out.println("===========================资质认证前的积分"+userinfoss.getPoint()+"===========================");
				userinfoDao.update(userinfo);
				userCompany.setId(qualitycertify.getTargetid());
				userCompanyService.save(userCompany);

				if(DataDic.QUALITY_SUCCES.equals(certifyStatus) && !DataDic.QUALITY_SUCCES.equals(qualitycertify.getCertifystatus())){
					userinfo.setUser(qualitycertify.getRequestuser());
					integrityBiz.updateIntegrityPoint(userinfo,DataDic.INTEGRITY_POINT_AUTHENSUCES,DataDic.ROLE_ENTERPRISE);//更新诚信积分
				}
			}else if (qualitycertify.getCertifytype().equals(DataDic.AUTHEN_CAR)) {// 车辆
				Car car=carService.get(qualitycertify.getTargetid());
				if(certifyStatus.equals(DataDic.QUALITY_WAITING)){
					car.setStatus(DataDic.AUTHENWAITING);
				}else if (certifyStatus.equals(DataDic.QUALITY_SUCCES)) {// 审核通过
					car.setStatus(DataDic.AUTHENSUCCES);
					//推送
					carBiz.sendCarSourceInfo(car.getId());
				} else if (certifyStatus.equals(DataDic.QUALITY_FAILED)) {// 审核不通过
					car.setStatus(DataDic.AUTHENFAILED);
				}
				carService.save(car);
			}
			int num = Integer.valueOf(certifyStatus)*1;  //转换为数字
			
			boolean issend = num!=0?true:false;
			SmsUtil.sendSmsMesge(null, smsCode, qualitycertify.getRequestuser().getPhone(),
					Const.System_Module_Enum.LogisticsWebSystem, Const.SMSFUN_AUTHEN, sms.split("}}"), null, null, issend,smsAuthSuccess);

			result = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = false;
		}
		return result;
	}
	//获取数据
	public UserQualitycertify get(String certifyId){
		return userQualitycertifyService.get(certifyId);
	}
	public UserQualitycertify getQualitycertifyInfo(UserQualitycertify userQualitycertify) {
		return userQualitycertifyService.getQualitycertifyInfo(userQualitycertify);
	}
}