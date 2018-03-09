package com.thinkgem.jeesite.modules.wlpt.api.base;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.collection.CollectionBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.collection.WlptCollection;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by fjc on 2017-11-28.
 */
@Controller
@RequestMapping("${appPath}/api/collection")
public class CollectionAppController extends BaseController {

    @Autowired
    private CollectionBiz collectionBiz;

    /**
     * 获取关注线路列表
     *
     * @param wlptCollection
     * @param pageNo
     * @param pageSize
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "collectionList", method = RequestMethod.GET)
    public Object collectionList(WlptCollection wlptCollection, Integer pageNo, Integer pageSize) {

        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (pageNo == null || pageSize == null) {
            map.put("state", DataDic.RETURN_STATUS_INFOBUG);
            map.put("message", "页码参数缺失");
            return map;
        }
        try {
            Page pg = new Page();
            pg.setPageNo(pageNo);
            pg.setPageSize(pageSize);
            wlptCollection.setUser(UserUtils.getUser());
            Page<WlptCollection> page = collectionBiz.findPage(pg, wlptCollection);
            for (WlptCollection collection : page.getList()) {
                collection.setTypename(DictUtils.getDictLabel(collection.getTargettype(), "collectionType", ""));

            }
            int totlaCount = (int) page.getCount();

            map.put("totlaCount", totlaCount);
            map.put("pageCount", Math.ceil((double) (totlaCount) / page.getPageSize()));
            map.put("pageNo", pageNo);
            map.put("pageSize", pageSize);

            result.put("list", page.getList());
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }

    /**
     * 保存关注线路
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "saveCollection", method = RequestMethod.POST)
    public Object saveCollection(WlptCollection wlptCollection) {

        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        try {
            return collectionBiz.savecollection(wlptCollection, UserUtils.getUser());
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }

    /**
     * 删除关注线路
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "deleteCollection", method = RequestMethod.POST)
    public Object deleteCollection(String id) {

        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        if (StringUtils.isBlank(UserUtils.getUser().getId())) {
            map.put("state", "1006");
            map.put("message", "登录过期");
            return map;
        }
        if (StringUtils.isBlank(id)) {
            map.put("state", DataDic.RETURN_STATUS_INFOBUG);
            map.put("message", "线路id信息缺失");
            return map;
        }
        try {
            WlptCollection wlptCollection = collectionBiz.get(id);
            if (wlptCollection == null) {
                map.put("state", DataDic.RETURN_STATUS_INFOBUG);
                map.put("message", "线路信息不存在");
                return map;
            }
            collectionBiz.delete(wlptCollection);
        } catch (Exception e) {
            state = DataDic.RETURN_STATUS_SYSBUG;
            message = "服务器异常";
        }
        map.put("state", state);
        map.put("message", message);
        map.put("data", result);
        return map;
    }

}
