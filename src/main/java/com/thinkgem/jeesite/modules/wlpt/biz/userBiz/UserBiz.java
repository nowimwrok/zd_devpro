package com.thinkgem.jeesite.modules.wlpt.biz.userBiz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.sms.util.SmsConfig;
import com.thinkgem.jeesite.common.sms.util.SmsUtil;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.Userinfo;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.service.UserinfoService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Address;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserBankinfo;
import com.thinkgem.jeesite.modules.wlpt.service.user.AddressService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserBankinfoService;
import com.thinkgem.jeesite.modules.wlpt.service.user.WlptUserService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by ForHeart on 16/8/14. 用户基本信息、地址、等信息接口
 */
@Service
@Transactional(readOnly = true)
public class UserBiz {

	@Autowired
	private AddressService addressService;

	@Autowired
	private UserinfoService userinfoService;

	@Autowired
	private WlptUserService wlptUserService;

	@Autowired
	private UserBankinfoService userBankinfoService;

	@Autowired
	private SystemService systemService;

	/***
	 * 获取用户地址列表信息
	 *
	 * @param page
	 * @param address
	 * @return
	 */
	public Page<Address> getAddressBiz(Page page, Address address, User curUser) {
		address.setUser(curUser);
		return page = addressService.findPage(page, address);
	}

	/***
	 * 保存用户地址信息
	 *
	 * @param address
	 * @param curUser
	 * @return
	 */
	@Transactional(readOnly = false)
	public Object saveAddressBiz(Address address, User curUser) {
		int state = DataDic.RETURN_STATUS_NORMAL;
		/// 判断地址信息是否完整
		//
		if (Tools.IsNullOrWhiteSpace(address.getType()) || Tools.IsNullOrWhiteSpace(address.getProvince())) {
			state = DataDic.RETURN_STATUS_INFOBUG;
		}

		if (state == DataDic.RETURN_STATUS_NORMAL) {
			if (Tools.IsNullOrWhiteSpace(address.getId())) {
				address.setUser(curUser);
				address.setIsNewRecord(true);
				address.setDelFlag(DataDic.DEL_FLAG_NORMEL);
				address.setId(IdGen.uuid());
			}
			addressService.save(address);
		}
		return Tools.getMapResult(state, Tools.statusMessage(state, "保存地址"), address);
	}

	/**
	 * 获取用户信息
	 * 
	 * @param userinfo
	 * @return
	 */
	public Userinfo getUserInfo(Userinfo userinfo) {
		User user = UserUtils.getUser();
		userinfo = userinfoService.get(user.getUserinfo().getId());
		
		// 判断用户信息是否为空
		if (userinfo == null) {
			userinfo = new Userinfo();

		}
		return userinfo;
	}
	
	public User getUser(){
		User user = UserUtils.getUser();
		return wlptUserService.getById(user.getId());
	}

	/***
	 * 修改账户支付密码--支付密码
	 *
	 * @param newPassword
	 *            新密码
	 * @param model
	 *            对象
	 * @return
	 */
	@Transactional(readOnly = false)
	public String modifyPwd( String newPassword) {
		String message = "修改成功";
		User user = UserUtils.getUser();
		Userinfo userinfo = userinfoService.get(user.getUserinfo().getId());
		if (StringUtils.isNotBlank(newPassword)) {
			
			userinfoService.updateCashPwdById(userinfo.getId(), newPassword);
			message = "修改支付密码成功";
			
		} else {
			message = "请填写修改信息";
		}
		return message;
	}

	/**
	 * 清空openid
	 * 
	 * @param openId
	 * @return
	 */
	@Transactional(readOnly = false)
	public Boolean deleteOpenId(String openId) {
		Boolean result = false;
		try {
			userinfoService.updateOpenIdByOpenId(openId);
			result = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = false;
		}
		return result;
	}

	/**
	 * 注册用户
	 * 
	 * @param user
	 * @return
	 */
	@Transactional(readOnly = false)
	public Boolean registerUser(User user) {
		Boolean result = false;
		try {
			wlptUserService.registerSave(user);
			result = true;
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			result = false;
		}
		return result;
	}

	/**
	 * 修改密码
	 * 
	 * @param oldpassword
	 * @param password
	 * @param confirmpwd
	 * @return
	 */
	@Transactional(readOnly = false)
	public Object changePwd(String oldpassword, String password, String confirmpwd) {
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "修改密码成功";
		User us = UserUtils.getUser();
		// 判断数据是否为空
		if (StringUtils.isNotBlank(oldpassword) && StringUtils.isNotBlank(password)
				&& StringUtils.isNotBlank(confirmpwd)) {
			// 判断旧密码是否正确
			if (SystemService.validatePassword(oldpassword, us.getPassword())) {
				// 判断两次密码是否相同
				if (password.equals(confirmpwd)) {
					//新旧密码不能相同
					if(!oldpassword.equals(confirmpwd)){
						try {
							// 修改密码
							wlptUserService.updatePasswordById(us.getId(), password);
						} catch (Exception e) {
							state = DataDic.RETURN_STATUS_SYSBUG;
							message = "修改密码失败";
						}
					}else{
						state = DataDic.RETURN_STATUS_SYSBUG;
						message = "新旧密码不能相同";
					}
					
				} else {
					state = DataDic.RETURN_STATUS_SYSBUG;
					message = "两次密码不一致";
				}
			} else {
				state = DataDic.RETURN_STATUS_SYSBUG;
				message = "旧密码错误";
			}
		} else {
			state = DataDic.RETURN_STATUS_SYSBUG;
			message = "参数为空";// 参数不能为空
		}

		return Tools.getMapResult(state, message, us);
	}

	/**
	 * 绑定银行卡信息
	 * 
	 * @param userbankinfo
	 * @param cashpassword
	 * @return
	 */
	@Transactional(readOnly = false)
	public Object saveBankCard(UserBankinfo userbankinfo, String cashpassword) {
		int state = DataDic.RETURN_STATUS_NORMAL;
		String message = "保存成功";
		User us = UserUtils.getUser();



		// 判断数据是否为空
		if (userbankinfo != null && StringUtils.isNotBlank(userbankinfo.getBankcard())
				&& StringUtils.isNotBlank(userbankinfo.getBankname())
				&& StringUtils.isNotBlank(userbankinfo.getBanktype())
				&& StringUtils.isNotBlank(userbankinfo.getBindphone()) && StringUtils.isNotBlank(cashpassword)) {
			// 实例化一个新的用户对象
			UserBankinfo userbank = new UserBankinfo();
			userbank.setUser(us);
			// 查询是否有查询银行卡信息
			userbank = userBankinfoService.getBankByConditon(userbank);
			// 判断银行卡信息是否为空
			if (!checkCashPwd(cashpassword)) {
				state = DataDic.RETURN_STATUS_SYSBUG;
				message = "提现密码错误!";
			}
			if (state == DataDic.RETURN_STATUS_NORMAL) {
				try {
					// 保存银行卡信息
					userBankinfoService.save(userbankinfo);
					// 保存提现密码
					userinfoService.updateCashPwdById(us.getUserinfo().getId(), cashpassword);

				} catch (Exception e) {
					state = DataDic.RETURN_STATUS_SYSBUG;
					message = "保存失败";
				}
			}

		} else {
			state = DataDic.RETURN_STATUS_SYSBUG;
			message = "参数不能为空";// 参数不能为空
		}
		return Tools.getMapResult(state, message, us);
	}

	/**
	 * 验证提现密码
	 * 
	 * @param cashpassword
	 * @return
	 */
	public boolean checkCashPwd(String cashpassword) {
		User user = UserUtils.getUser();
		Userinfo userinfo = userinfoService.get(user.getUserinfo().getId());
		if (!StringUtils.isNotBlank(userinfo.getCashpassword())) {
			return true;
		}
		return SystemService.validatePassword(cashpassword, userinfo.getCashpassword());
	}

	/**
	 * 验证提现密码,用于提现
	 * 
	 * @param cashpassword
	 * @return
	 */
	public boolean checkCashPwdbyCash(String cashpassword) {
		User user = UserUtils.getUser();
		Userinfo userinfo = userinfoService.get(user.getUserinfo().getId());
		if (!StringUtils.isNotBlank(userinfo.getCashpassword())) {
			return false;
		}
		return SystemService.validatePassword(cashpassword, userinfo.getCashpassword());
	}

	
	/**
	 * 获取银行卡信息
	 * 
	 * @param userbank
	 * @return
	 */
	public UserBankinfo getUserBankInfo(UserBankinfo userbank) {
		return userBankinfoService.getBankByConditon(userbank);
	}
	
	
	/**
	 * 获取银行卡信息--用户默认
	 * 
	 * @param userbank
	 * @return
	 */
	public UserBankinfo getUserBankInfo(User user){
		UserBankinfo bankinfo=new UserBankinfo();
		bankinfo.setIsdefault(DataDic.YES_INT);//默认银行卡
		bankinfo.setUser(user);
		UserBankinfo bank1=userBankinfoService.getBankByConditon(bankinfo);
		if(bank1!=null){
			return bank1;
		}else{
			UserBankinfo bank2=new UserBankinfo();
			bank2.setUser(user);
			List<UserBankinfo> banks=findUserBankList(bank2);
			if(banks==null||banks.size()==0){
				return null;
			}else{
				return banks.get(0);
			}
		}
	}
	
	public UserBankinfo getBankById(String bankId) {
		return userBankinfoService.get(bankId);
	}
	
	/**
	 * 获取银行卡list信息
	 * 
	 * @param userBankinfo
	 * @return
	 */
	public List<UserBankinfo> findUserBankList(UserBankinfo userBankinfo) {
		return userBankinfoService.findList(userBankinfo);
	}

	/**
	 * 编辑用户个人信息
	 * 
	 * @param userinfo
	 * @return
	 */
	@Transactional(readOnly = false)
	public Userinfo editUserInfo(Userinfo userinfo) {
		User user = UserUtils.getUser();
		userinfo.setId(user.getUserinfo().getId());
		userinfo.getUser().setId(user.getId());
		return wlptUserService.editUserInfo(userinfo);
	}

	/**
	 * 发送注册验证码
	 * 
	 * @param phone
	 * @return
	 */
	@Transactional(readOnly = false)
	public Boolean sendRegCode(String phone) {
		Boolean returnResult = false;
		if ("".equals(phone) || phone == null) {
			return returnResult;
		} else if (systemService.getUserByPhone(phone) != null) {
			return returnResult;
		}
		String tempSmsCode = String.valueOf(Tools.getRandomNum()); // 获取验证码
		System.out.println(tempSmsCode);
		String[] keyword = { tempSmsCode };
		int result = SmsUtil.sendSmsMesge(null, "registerSMS", phone, Const.System_Module_Enum.CeShi,
				Const.SMSFUN_REGCODE, keyword, null, null, true,SmsConfig.smsValidateCode);
		if (result == 1) {
			returnResult = true;
		}
		return returnResult;
	}

	/**
	 * 验证登陆名是否已存在
	 * 
	 * @param loginName
	 * @return true不存在
	 */
	public Boolean checkLoginName(String loginName) {
		Boolean returnResult = false;
		if ("".equals(loginName) || loginName == null) {
			return returnResult;
		}
		if (systemService.getUserByLoginName(loginName) == null) {
			returnResult = true;
		}
		return returnResult;
	}

	/**
	 * 验证phone是否已存在
	 * 
	 * @param phone
	 * @return true不存在
	 */
	public Boolean checkPhone(String phone) {
		Boolean returnResult = false;
		if ("".equals(phone) || phone == null) {
			return returnResult;
		}
		if (systemService.getUserByPhone(phone) == null) {
			returnResult = true;
		}
		return returnResult;
	}
	
	/**
	 * 获取我的子账户列表
	 * @param page
	 * @param user
	 * @return
	 */
	public Page<User> getAccountList(Page<User> page,User user) {
		return systemService.findMyUser(page, user);
	}
	
	/**
	 * 删除我的子账户
	 * @param user
	 * @return
	 */
	@Transactional(readOnly = false)
	public void deleteMyUserAccount(User user) {
		systemService.deleteUser(user);
	}
	
	/**
	 * 添加我的子账户
	 * @param user
	 * @return
	 */
	@Transactional(readOnly = false)
	public void saveMyUserAccount(User user) {
		systemService.saveMyUser(user);
	}

	@Transactional(readOnly = false)
	public String modifyPwdForApp(String phone, String newPassword) {
		String message = "修改成功";
		User user = UserUtils.getByPhone(phone);
		Userinfo userinfo = userinfoService.get(user.getUserinfo().getId());
		if (StringUtils.isNotBlank(newPassword)) {

			userinfoService.updateCashPwdById(userinfo.getId(), newPassword);
			message = "修改支付密码成功";

		} else {
			message = "请填写修改信息";
		}
		return message;
	}
}
