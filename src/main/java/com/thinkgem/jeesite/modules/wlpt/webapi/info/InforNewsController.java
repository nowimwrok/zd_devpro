package com.thinkgem.jeesite.modules.wlpt.webapi.info;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseNews;
import com.thinkgem.jeesite.modules.wlpt.service.base.BaseAdvertisementService;
import com.thinkgem.jeesite.modules.wlpt.service.base.BaseCategoriesService;
import com.thinkgem.jeesite.modules.wlpt.service.base.BaseNewsService;

/**
 * 资讯新闻Controller
 *
 * @author 曾煜佳
 * @version 2016-08-08
 */
@Controller
@RequestMapping(value = "${frontPath}/wlpt/info")
public class InforNewsController extends BaseController{
	//新闻
	@Autowired
	private BaseNewsService baseNewsService;
	//新闻分类
	@Autowired
	private BaseCategoriesService baseCategoriesService;
	//广告
	@Autowired
	private BaseAdvertisementService baseAdvertisementService;
	
	@ModelAttribute
	public BaseNews get(@RequestParam(required=false) String id) {
		BaseNews entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = baseNewsService.get(id);
		}
		if (entity == null){
			entity = new BaseNews();
		}
		return entity;
	}
	/**
	 * 物流资讯
	 * @param baseNews
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = {"index", ""})
	public String index(BaseNews baseNews, HttpServletRequest request, HttpServletResponse response, Model model) {
		//新闻分类
				model.addAttribute("baseCategories", baseCategoriesService.getCategories(DataDic.NEWS_TYPE));
		//获取广告信息
		model.addAttribute("adverlist", baseAdvertisementService.getAdvertisementList("infor_index"));
		return "modules/wlpt_front/info/infor_index";
	}
	/**
	 * 物流要闻
	 * @param baseNews
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = {"news", ""})
	public String news(BaseNews baseNews, HttpServletRequest request, HttpServletResponse response, Model model) {
		//新闻分类
		model.addAttribute("baseCategories", baseCategoriesService.getCategories(DataDic.NEWS_TYPE));
		//获取广告信息
		model.addAttribute("adverlist", baseAdvertisementService.getAdvertisementList("infor_index"));
		return "modules/wlpt_front/info/news/news_list";
	}

	
	
	/**
	 * 获取最新新闻
	 * @param baseNews
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
    @ResponseBody
    @RequestMapping(value = "getnewslist")
    public Object getnewslist(BaseNews baseNews,int pageNo,int pageSize, Model model){
        Page pg = new Page();
        pg.setLength(3);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
    	//
		Page<BaseNews> page = baseNewsService.getNewsList(pg, baseNews); 
		
		model.addAttribute("page", page);
		return new JSONPObject("callback", page);
    }
    
    /**
	 * 获取头条新闻
	 * @param baseNews
	 * @param pageNo
	 * @param pageSize
	 * @param model
	 * @return
	 */
    @ResponseBody
    @RequestMapping(value = "gethotnewslist")
    public Object gethotnewslist(BaseNews baseNews,int pageNo,int pageSize, Model model){
        Page pg = new Page();
        pg.setLength(3);//设置显示分页数字码
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        baseNews.setHot(1L);//点击量
		Page<BaseNews> page = baseNewsService.getNewsList(pg, baseNews); 
		
		model.addAttribute("page", page);
		return new JSONPObject("callback", page);
    }
	
    /**
	 * 获取详情
	 * @param baseNews
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = {"getinfornewsddetail", ""})
	public String getinfornewsddetail(BaseNews baseNews, HttpServletRequest request, HttpServletResponse response, Model model) {
		
		model.addAttribute("baseNews", baseNews);
		return "modules/wlpt_front/info/infor_detail";
	}
}
