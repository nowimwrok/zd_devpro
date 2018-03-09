package com.thinkgem.jeesite.modules.wlpt.dao.accounts;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;

import java.util.Map;

/**
 * 对账
 * Created by 刘欣
 */

@MyBatisDao
public interface AccountsDao extends CrudDao<Map> {
     Double findAccountWebBalance();

}
