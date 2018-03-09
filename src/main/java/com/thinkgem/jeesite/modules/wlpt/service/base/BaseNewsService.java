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
import com.thinkgem.jeesite.common.utils.DateUtil;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseNews;
import com.thinkgem.jeesite.modules.wlpt.dao.base.BaseNewsDao;

/**
 * 新闻管理Service
 * @author 王铸
 * @version 2016-08-04
 */
@Service
@Transactional(readOnly = true)
public class BaseNewsService extends CrudService<BaseNewsDao, BaseNews> {

	@Autowired
	private BaseNewsDao baseNewsDao;

	public BaseNews get(String id) {
		return super.get(id);
	}



	public List<BaseNews> findList(BaseNews baseNews) {
		return super.findList(baseNews);
	}
	
	public Page<BaseNews> findPage(Page<BaseNews> page, BaseNews baseNews) {
		return super.findPage(page, baseNews);
	}
	
	@Transactional(readOnly = false)
	public void save(BaseNews baseNews) {
		super.save(baseNews);
	}
	
	@Transactional(readOnly = false)
	public void delete(BaseNews baseNews) {
		super.delete(baseNews);
	}
	
	/**
	 * 批量操作
	 * @param map
	 * @return
	 */
	@Transactional(readOnly = false)
	public void deleteAll(Map<String,String> map){
		baseNewsDao.deleteAll(map);
	}
	
	
	public Page<BaseNews> getNewsList(Page page, BaseNews baseNews) {
		
		Page<BaseNews> pagenews = findPage(page, baseNews); 
		pagenews.setList(setModel(page.getList()));//格式数据
		return pagenews;
	}
	
	//设置数据格式
	private List<BaseNews> setModel(List<BaseNews> domestic){
		List<BaseNews> Domestics = new ArrayList<BaseNews>();
		for (BaseNews news : domestic) {
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