package com.thinkgem.jeesite.modules.sys.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.thinkgem.jeesite.modules.wlpt.entity.car.GpsCarLocs;
import com.thinkgem.jeesite.modules.wlpt.service.car.GpsCarLocsService;
import java.util.List;

/**
 * 车辆同步
 */
@Service
public class CarSyncService {

    @Autowired
    private GpsCarLocsService gpsCarLocsService;

    public  List<GpsCarLocs> listAll() throws Exception {
    	GpsCarLocs gpsCarLocs=new GpsCarLocs();
    	return gpsCarLocsService.findList(gpsCarLocs);
        //return (List<PageData>) dao.findForList("LBSCarLocsMapper.listAll", null);
    }




}
