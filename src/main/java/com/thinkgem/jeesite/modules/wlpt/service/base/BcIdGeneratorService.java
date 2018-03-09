/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.base;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BcIdGenerator;
import com.thinkgem.jeesite.modules.wlpt.dao.base.BcIdGeneratorDao;

/**
 * 业务结算单号Service
 * @author zyj
 * @version 2017-05-18
 */
@Service
@Transactional(readOnly = true)
public class BcIdGeneratorService extends CrudService<BcIdGeneratorDao, BcIdGenerator> {

	@Autowired
	private BcIdGeneratorDao bcIdGeneratorDao;

	/*public BcIdGenerator get(String id) {
		return super.get(id);
	}
*/

	/**
	 * 获取新的业务结算单号
	 * @param bcIdGenerator
	 * @return
	 */
	public BcIdGenerator getNewIdGeneratorInfo(BcIdGenerator bcIdGenerator){
		return bcIdGeneratorDao.getNewIdGeneratorInfo(bcIdGenerator);
	}
	
	/**
	 * 获取新的业务结算单号
	 * @param prefix
	 * @return
	 */
	public String getNewCalcId(String prefix,String policy){
		String calcId = "";
		BcIdGenerator idgenerator= bcIdGeneratorDao.getIdGeneratorByPrefix(prefix);
		if(idgenerator!=null){
			idgenerator.setPolicy(policy);
			BcIdGenerator big = bcIdGeneratorDao.getNewIdGeneratorInfo(idgenerator);
			if(big!=null && !Tools.IsNullOrWhiteSpace(big.getCalcId())){
				calcId = big.getCalcId();
			}
		}
		return calcId;
	}
	
	/**
	 * 获取最新的业务结算单号
	 * @param bcIdGenerator
	 * @return
	 */
	public BcIdGenerator getIdGeneratorByPrefix(String prefix){
		return bcIdGeneratorDao.getIdGeneratorByPrefix(prefix);
	}
	
	public List<BcIdGenerator> findList(BcIdGenerator bcIdGenerator) {
		return super.findList(bcIdGenerator);
	}
	
	public Page<BcIdGenerator> findPage(Page<BcIdGenerator> page, BcIdGenerator bcIdGenerator) {
		return super.findPage(page, bcIdGenerator);
	}
	
	@Transactional(readOnly = false)
	public void save(BcIdGenerator bcIdGenerator) {
		super.save(bcIdGenerator);
	}
	
	@Transactional(readOnly = false)
	public void delete(BcIdGenerator bcIdGenerator) {
		super.delete(bcIdGenerator);
	}
	
}