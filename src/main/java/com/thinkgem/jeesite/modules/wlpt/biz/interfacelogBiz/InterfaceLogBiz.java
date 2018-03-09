package com.thinkgem.jeesite.modules.wlpt.biz.interfacelogBiz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.trafficUtils.ZhiyunOpenapi;
import com.thinkgem.jeesite.common.trafficUtils.ZhiyunReturnBean;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.dao.interfacelog.InterfaceLogDao;
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.InterfaceLog;
import com.thinkgem.jeesite.modules.wlpt.entity.interfacelog.InterfaceToken;
import com.thinkgem.jeesite.modules.wlpt.service.interfacelog.InterfaceLogService;
import com.thinkgem.jeesite.modules.wlpt.service.interfacelog.InterfaceTokenService;

@Service
public class InterfaceLogBiz {

	@Autowired
	InterfaceLogService interfaceLogService;
	@Autowired
	private InterfaceLogDao interfaceLogDao;
	
	@Autowired
	InterfaceTokenService interfaceTokenService;
	

	/**
	 * 
	 * @param user
	 *            用户
	 * @param interfacetype
	 *            接口类型
	 * @param interfacename
	 *            接口名称
	 * @param interfacesource
	 *            接口来源
	 * @param querydata
	 *            是否查询到数据
	 * @param msgFlag
	 *            数据开关
	 * @param price
	 *            金额
	 */
	@Transactional(readOnly = false)
	public int addBiz(User user, String interfaceType, String interfaceName, String interfaceSource, String msgFlag,
			String price) {
		int result = DataDic.RETURN_STATUS_NORMAL;
		if (user == null) {
			result = DataDic.RETURN_STATUS_INFOBUG;
		} else if (Tools.IsNullOrWhiteSpace(interfaceType)) {
			result = DataDic.RETURN_STATUS_INFOBUG;

		} else if (Tools.IsNullOrWhiteSpace(interfaceName)) {
			result = DataDic.RETURN_STATUS_INFOBUG;
		} else if (Tools.IsNullOrWhiteSpace(interfaceSource)) {
			result = DataDic.RETURN_STATUS_INFOBUG;
		} else if (Tools.IsNullOrWhiteSpace(msgFlag)) {
			result = DataDic.RETURN_STATUS_INFOBUG;
		} else if (Tools.IsNullOrWhiteSpace(price)) {
			result = DataDic.RETURN_STATUS_INFOBUG;
		} else {
			InterfaceLog interfaceLog = new InterfaceLog();
			User curUser = UserUtils.getUser();
			interfaceLog.setUserid(curUser.getId());
			interfaceLog.setPhone(user.getPhone());
			interfaceLog.setInterfaceType(interfaceType);
			interfaceLog.setInterfaceName(interfaceName);
			interfaceLog.setInterfaceSource(interfaceSource);
			interfaceLog.setMsgFlag(msgFlag);
			interfaceLog.setPrice(price);
			interfaceLog.setCreateBy(user.getCreateBy());
			interfaceLog.setUpdateBy(user.getUpdateBy());
			interfaceLogService.save(interfaceLog);

		}
		return result;
	}

	/**
	 * 返回统计的结果
	 * 
	 * @return
	 */
	public List<InterfaceLog> statistical() {

		List<InterfaceLog> list = interfaceLogDao.findcount();

		return list;
	}
	
	 /**
     * 定时任务，生成接口令牌信息
     */
    @Transactional(readOnly = false)
    public String interfacetoken() {
    	InterfaceToken inter=new InterfaceToken();
    	ZhiyunReturnBean bean = ZhiyunOpenapi.login();
    	String token = bean.getResult() + "";
    	if(token!=null && token !="") {
    		inter.setToken(token);
        	inter.setId(DataDic.FIXED_IDONE);
        	User user=new User();
        	user.setId(DataDic.FIXED_ID);
        	inter.setCreateBy(user);
        	inter.setUpdateBy(user);
        	interfaceTokenService.save(inter);
    	}else {
    		return "生成失败";
    	}
    	return "生成成功";
    }
	/**
	 * 查询数据库中的接口令牌信息
	 * @return
	 */
	public InterfaceToken interfacetokens() {
		InterfaceToken inter=interfaceTokenService.get("1");
    	if(null!=inter.getToken()) {
    		return inter;
    	}
    	return inter;
	}

}
