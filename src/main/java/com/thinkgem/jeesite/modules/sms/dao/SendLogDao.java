/**
 * 
 */
package com.thinkgem.jeesite.modules.sms.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sms.entity.SendLog;

/**
 * 消息发送日志DAO接口
 * @author 饶江龙
 * @version 2016-07-20
 */
@MyBatisDao
public interface SendLogDao extends CrudDao<SendLog> {

    /***
     * 获取验证码对象
     * @param smssendlog
     * @return
     */
    public SendLog findByPhoneVerCodeAndFun(SendLog smssendlog);
}