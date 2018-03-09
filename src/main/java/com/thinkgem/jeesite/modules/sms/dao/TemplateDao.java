/**
 * 
 */
package com.thinkgem.jeesite.modules.sms.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sms.entity.Template;

/**
 * 消息模版DAO接口
 * @author 饶江龙
 * @version 2016-07-20
 */
@MyBatisDao
public interface TemplateDao extends CrudDao<Template> {

    /***
     * 获取短信模版信息
     * @param smstemplate
     * @return
     */
    public Template findSmsTemplate(Template smstemplate);
	
}