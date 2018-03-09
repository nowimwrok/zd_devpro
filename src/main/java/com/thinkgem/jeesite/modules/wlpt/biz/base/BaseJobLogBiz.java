package com.thinkgem.jeesite.modules.wlpt.biz.base;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseJoblog;
import com.thinkgem.jeesite.modules.wlpt.service.base.BaseJoblogService;

@Service
@Transactional(readOnly = true)
public class BaseJobLogBiz extends BaseController{

	@Autowired
	private BaseJoblogService  baseJoblogService;
	
	public BaseJoblog get(String id) {
		return baseJoblogService.get(id);
	} 



	public List<BaseJoblog> findList(BaseJoblog baseJoblog) {
		return baseJoblogService.findList(baseJoblog);
	}
	
	public Page<BaseJoblog> findPage(Page<BaseJoblog> page, BaseJoblog baseJoblog) {
		return baseJoblogService.findPage(page, baseJoblog);
	}
	
	public BaseJoblog findByCondition(BaseJoblog baseJoblog){
		return baseJoblogService.findByCondition(baseJoblog);
	}
	
	@Transactional(readOnly = false)
	public void save(BaseJoblog baseJoblog) {
		if(StringUtils.isNoneBlank(baseJoblog.getId())){
			baseJoblog.setId(IdGen.uuid());
			baseJoblog.setIsNewRecord(true);
			baseJoblog.setStarttime(new Date());
		}
		baseJoblogService.save(baseJoblog);
	}
	
	@Transactional(readOnly = false)
	public void delete(BaseJoblog baseJoblog) {
		baseJoblogService.delete(baseJoblog);
	}
}
