
package com.thinkgem.jeesite.modules.wlpt.dao.insur;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import java.util.List;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsurance;

/**
 * 保险DAO接口
 * @author 保险
 * @version 2016-12-19
 */
@MyBatisDao
public interface UserInsuranceDao extends CrudDao<UserInsurance> {

	/**
	 * 根据统计获取单条数据
	 * @param UserInsurance
	 * @return
	 */
	UserInsurance getInsurInfo(UserInsurance userInsurance);
	
	/**
	 * 修改测算信息
	 * @param UserInsurance
	 * @return
	 */
	int updateMeasuresInfo(UserInsurance userInsurance);

	/**
	 * 批量添加险种记录
	 * @param userInsurance
	 * @return
	 */
	int insertInsuranceInfo(UserInsurance userInsurance);
}