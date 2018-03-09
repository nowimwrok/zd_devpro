/**
 * 
 */
package com.thinkgem.jeesite.modules.sys.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sys.entity.Userinfo;

import java.util.List;


/**
 * 用户管理DAO接口
 * @author 饶江龙
 * @version 2016-07-13
 */
@MyBatisDao
public interface UserinfoDao extends CrudDao<Userinfo> {

    /***
     * 获取用户列表信息
     * @param userinfo
     * @return
     */
    public List<Userinfo> findList(Userinfo userinfo);

    public List<Userinfo> findPage();

    /***
     * 修改提现密码
     * @param userinfo
     * @return
     */
    public int updateCashPwdById(Userinfo userinfo);
    
    /**
     * 通过userinfoid获取包括idcard信息
     * @param id
     * @return
     */
    public Userinfo getAndIdcard(String id);
    
    
    /**
     * 验证QQ
     * @param info
     * @return
     */
    public Userinfo ValidateQQ(Userinfo info);
    /**
     * 验证登录名
     * @param info
     * @return
     */
    public Userinfo ValidateLoginName(Userinfo info);
    /**
	 * 清空openid
	 * @return
	 */
	public int updateOpenIdByOpenId(String openId);
	
}