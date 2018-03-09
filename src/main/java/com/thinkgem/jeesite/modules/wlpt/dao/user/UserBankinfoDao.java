/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.dao.user;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserBankinfo;

/**
 * 用户绑定银行卡DAO接口
 * @author 饶江龙
 * @version 2016-07-21
 */
@MyBatisDao
public interface UserBankinfoDao extends CrudDao<UserBankinfo> {

    /***
     * 通过用户和银行卡主键查询绑定信息
     * @param userBankinfo
     * @return
     */
    public UserBankinfo getBankByConditon(UserBankinfo userBankinfo);
	
}