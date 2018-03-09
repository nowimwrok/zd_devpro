/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.consume;

import java.util.List;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumeaudit;
import org.apache.fop.fo.extensions.xmp.RDFElementMapping;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Deallog;
import com.thinkgem.jeesite.modules.wlpt.dao.consume.DeallogDao;

/**
 * 后台充值账户审核日志记录Service
 * @author 饶江龙
 * @version 2016-08-02
 */
@Service
@Transactional(readOnly = true)
public class DeallogService extends CrudService<DeallogDao, Deallog> {

	@Autowired
	private DeallogDao deallogDao;

	public Deallog get(String id) {
		return super.get(id);
	}


	/***
	 * 保存消费申请操作记录
	 *
	 * @param consumeaudit  用户对象要完整,交易流水信息要完整
     */
	@Transactional(readOnly = false)
	public void saveDealLog(Consumeaudit consumeaudit){
		Deallog deallog = new Deallog();
		deallog.preInsert();
		deallog.setConsumeaudit(consumeaudit);
		deallog.setDealtype(consumeaudit.getType());
		deallog.setDelstatus(consumeaudit.getAuditstatus());
		String remks="";
		switch (consumeaudit.getAuditstatus()){
			case DataDic.CONSUMEAUDIT_STATUS_NEWAUDIT:
				remks="新增了";
				break;
			case DataDic.CONSUMEAUDIT_STATUS_TRIAL:
				remks="审核通过了";
				break;
			case DataDic.CONSUMEAUDIT_STATUS_FINALJUDG:
				remks="终审通过了";
				break;
			case DataDic.CONSUMEAUDIT_STATUS_TOREVIEW:
				remks="复核了";
				break;
			case DataDic.CONSUMEAUDIT_STATUS_FAILED:
				remks="驳回了";
				break;
			case DataDic.CONSUMEAUDIT_STATUS_UNAUDIT:
				remks="新建了";
				break;
		}
		String desp="";
		if (Tools.IsNullOrWhiteSpace(consumeaudit.getConsume().getConsumewaydesp())){
			desp=consumeaudit.getRemarks();
		}else{
			desp=consumeaudit.getConsume().getConsumewaydesp();
		}
		deallog.setRemarks(UserUtils.getUser().getLoginName()+remks+desp);
		deallogDao.insert(deallog);
	}

	public List<Deallog> findList(Deallog deallog) {
		return super.findList(deallog);
	}
	
	public Page<Deallog> findPage(Page<Deallog> page, Deallog deallog) {
		return super.findPage(page, deallog);
	}
	
	@Transactional(readOnly = false)
	public void save(Deallog deallog) {
		super.save(deallog);
	}
	
	@Transactional(readOnly = false)
	public void delete(Deallog deallog) {
		super.delete(deallog);
	}
	
}