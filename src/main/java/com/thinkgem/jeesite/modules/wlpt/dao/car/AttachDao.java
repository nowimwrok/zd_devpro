/**
 *
 */
package com.thinkgem.jeesite.modules.wlpt.dao.car;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Attach;

import java.util.List;

/**
 * 司机账户绑定DAO接口
 *
 * @author 饶江龙
 * @version 2016-07-26
 */
@MyBatisDao
public interface AttachDao extends CrudDao<Attach> {

    public List<Attach> findList1(Attach attach);

    /**
     * 查询绑定信息
     *
     * @param attach
     * @return
     */
    public Attach findAttach(Attach attach);

    /**
     * 获取用户的绑定司机数
     *
     * @param attach
     * @return
     */
    public int getUserDriverNum(Attach attach);
}