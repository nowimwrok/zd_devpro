/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.service.base;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.jsoup.Jsoup;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BasePolicy;
import com.thinkgem.jeesite.modules.wlpt.dao.base.BasePolicyDao;

/**
 * 政策公告Service
 * @author 王铸
 * @version 2016-08-04
 */
@Service
@Transactional(readOnly = true)
public class BasePolicyService extends CrudService<BasePolicyDao, BasePolicy> {

	@Autowired
	private BasePolicyDao basePolicyDao;

	public BasePolicy get(String id) {
		return super.get(id);
	}



	public List<BasePolicy> findList(BasePolicy basePolicy) {
		return super.findList(basePolicy);
	}
	
	public Page<BasePolicy> findPage(Page<BasePolicy> page, BasePolicy basePolicy) {
		return super.findPage(page, basePolicy);
	}
	
	@Transactional(readOnly = false)
	public void save(BasePolicy basePolicy) {
		super.save(basePolicy);
	}
	
	@Transactional(readOnly = false)
	public void delete(BasePolicy basePolicy) {
		super.delete(basePolicy);
	}
	/**
	 * 批量操作
	 * @param map
	 * @return
	 */
	@Transactional(readOnly = false)
	public void deleteAll(Map<String,String> map){
		basePolicyDao.deleteAll(map);
	}
	
	
public Page<BasePolicy> getPolicyList(Page page, BasePolicy basePolicy) {
		
		Page<BasePolicy> pagepolicy = findPage(page, basePolicy); 
		pagepolicy.setList(setModel(page.getList()));//格式数据
		return pagepolicy;
	}
	
	//设置数据格式
	private List<BasePolicy> setModel(List<BasePolicy> domestic){
		List<BasePolicy> Domestics = new ArrayList<BasePolicy>();
		for (BasePolicy news : domestic) {
			//时间格式
			//news.setReleaseTime(DateUtil.fomatDate(String.valueOf(news.getReleaseTime())));
			/*
			String summarys =news.getSummary().trim(); 
			news.setSummary(summarys);
			*/
			//格式内容
			String content =Jsoup.parse(news.getContent().replaceAll("&nbsp;","")).text().replaceAll("\\s*","");
			if(content.length()>101){
				content = content.substring(0,100)+"...";
			}
			news.setContent(content);
			
			//截取标题
			String title = news.getTitle().trim();
			if(title.length()>24){
				title = title.substring(0, 24)+"...";
			}
			news.setTitle(title);
			
			//关键字去逗号
			String keyword = news.getKeyword();
			if(!Tools.IsNullOrWhiteSpace(keyword)){
				keyword = keyword.replace(",", " ");
			}
			
			news.setKeyword(keyword);
			
			//截取图片，--图片只留一张
			String img = news.getPicture();
			if (!Tools.IsNullOrWhiteSpace(img)) {
				img =img.contains(",")? img.substring(0, img.indexOf(",")):img;
			}
			news.setPicture(img);
			Domestics.add(news);
		}
		return Domestics;
	}
	
}