package com.thinkgem.jeesite.modules.wlpt.biz.gps;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONArray;
import com.thinkgem.jeesite.common.utils.GPSUtil;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * gps数据处理接口
 *
 * @author zjs
 */
@Service
@Transactional(readOnly = true)
public class GpsInfoBiz {


  
    public Object getNewTrackInof(String carNumber) {                               //地图定位方法
        List<Map<String, Object>> mapListJson = new ArrayList<>();
        Map<String, Object> testMap = new HashMap<>();
        User curUser = UserUtils.getUser(); // 获取当前用户
        testMap.put("licensePlate", carNumber);
        GPSUtil gpsUtil = new GPSUtil();
        JSONArray jsonArray = JSONArray.parseArray(gpsUtil.callHttpPost("GetVehicleDynamicTrack", testMap));
        mapListJson = (List) jsonArray;
        
        return mapListJson;
    }

    public Object getTrackList(String carNumber, String beginTime, String endTime) {                //轨迹方法
        List<Map<String, Object>> mapListJson = new ArrayList<>();
        Map<String, Object> testMap = new HashMap<>();
        User curUser = UserUtils.getUser(); // 获取当前用户
        double money = 0.0;
        testMap.put("licensePlate", carNumber);
        testMap.put("beginTime", beginTime);
        testMap.put("endTime", endTime);
        GPSUtil gpsUtil = new GPSUtil();
        JSONArray jsonArray = JSONArray.parseArray(gpsUtil.callHttpPost("GetHistoryQueryResult", testMap));
        mapListJson = (List) jsonArray;
       
        return mapListJson;
    }

}
