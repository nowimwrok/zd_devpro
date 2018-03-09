package com.thinkgem.jeesite.modules.weixin.controller.collection;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.collection.CollectionBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Attach;
import com.thinkgem.jeesite.modules.wlpt.entity.car.Car;
import com.thinkgem.jeesite.modules.wlpt.entity.collection.WlptCollection;
import com.thinkgem.jeesite.modules.wlpt.entity.insur.UserInsurance;

/**
 * 我的关注
 * @author zyj
 *
 */
@Controller
@RequestMapping(value = "${weixinPath}/weixin/collection")
public class CollectionWeiXinController {
	@Autowired
	private CollectionBiz collectionBiz;
	
	@Autowired 
	private UserBiz userBiz;
	
	@RequestMapping("toCollectionList")
	public String collectionlist(Model model,String type){	
		
		User user = UserUtils.getUser();
		if(StringUtils.isBlank(user.getId())){
			return null;
		}
		WlptCollection wlptCollection = new WlptCollection();
		wlptCollection.setUser(user);
		//获取关注车源条数
		wlptCollection.setTargettype(DataDic.COLLECTION_TYPE_CAR);
		model.addAttribute("carcount", collectionBiz.countcollection(wlptCollection));
		
		//获取关注货源条数
		wlptCollection.setTargettype(DataDic.COLLECTION_TYPE_GOODS);
		model.addAttribute("goodscount", collectionBiz.countcollection(wlptCollection));
		
		//获取关注招标条数
		wlptCollection.setTargettype(DataDic.COLLECTION_TYPE_BID);
		model.addAttribute("bidcount", collectionBiz.countcollection(wlptCollection));
		model.addAttribute("type", type);
		return "modules/wx_front/collection/collection_list";
	}
	
	@ResponseBody
	@RequestMapping(value="list")
	public Object list(WlptCollection wlptCollection, Page page,Model model){
		User user = UserUtils.getUser();
		if(StringUtils.isBlank(user.getId())){
			return null;
		}
		wlptCollection.setUser(user);
		Page<WlptCollection> dest = collectionBiz.findPage(page, wlptCollection);
	    for (WlptCollection collec : dest.getList()) {
	    	collec.setTypename(DictUtils.getDictLabel(collec.getTargettype(), "collectionType", ""));
	            
	    }
		return page;
	}
	
	 /**
     * 到关注信息编辑页面
     *
     * @param wlptCollection实体
     * @param model
     * @return
     */
    @RequestMapping(value = "toCollectionAdd")
    public String toCollectionAdd(WlptCollection wlptCollection,Model model) {
    	if(!Tools.IsNullOrWhiteSpace(wlptCollection.getId())){
    		wlptCollection = collectionBiz.get(wlptCollection.getId());
    	}
        model.addAttribute("user", userBiz.getUser());
        model.addAttribute("collection", wlptCollection);
        return "modules/wx_front/collection/collection_add";
    }

    /***
     * 添加关注信息
     *
     * @param wlptCollection实体
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "savecollection")
    public Object save(WlptCollection wlptCollection, Model model) {

        Object result=collectionBiz.savecollection(wlptCollection, UserUtils.getUser());
        //UserUtils.clearCache( UserUtils.getUser());
        model.addAttribute("user", userBiz.getUser());
        return new JSONPObject("callback", result);
    }
    
    /***
     * 解除关注
     *
     * @param Collection id
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "deleteCollection")
    public Object deleteCollection(@RequestParam(required = false) String id, Model model) {
    	WlptCollection collec = collectionBiz.get(id);
 	    collectionBiz.delete(collec);
 	    return new JSONPObject("callback", "成功取消关注");
    }

}
