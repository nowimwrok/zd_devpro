package com.thinkgem.jeesite.common.quartz;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.beans.factory.annotation.Autowired;

import com.thinkgem.jeesite.common.utils.BaiduLBSUtil;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.LogStackTrace;
import com.thinkgem.jeesite.common.utils.PageData;
import com.thinkgem.jeesite.common.utils.ServiceHelper;
import com.thinkgem.jeesite.modules.sys.service.CarSyncService;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseJoblog;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscJob;
import com.thinkgem.jeesite.modules.wlpt.entity.car.GpsCarLocs;


public class LBSUpload extends BaseQuartzJobBean {
    private CarSyncService carSyncService = ServiceHelper.getCarSyncService();
    private static BaiduLBSUtil baiduLBSUtil = new BaiduLBSUtil();
//    @Autowired
//    private CarSyncService carSyncService;
    private static String ak = "DSYi3VkjBcTkHoxSjBS9130D";
    private static String geotable_id = "172513";

    protected void executeInternal(JobExecutionContext context)throws JobExecutionException {
    	BscJob bscJob=new BscJob();
    	BaseJoblog baseJoblog=new BaseJoblog();
        Boolean isLog = true;
        try {
        	bscJob.setJobcode(Const.Job_Code.LBSUPLOAD.name());
            bscJob = jobBiz.findByCondition(bscJob);
            baseJoblog.setJobid(bscJob.getId());
            isLog = bscJob.getIslog().equals("1");
            acquStart(bscJob,baseJoblog, isLog);
        } catch (Exception ex) {
            try {
            	baseJoblog.setExceptioninfo(LogStackTrace.getLogStackTraceInfo(ex));
                if (isLog){
                	baseJobLogBiz.save(baseJoblog);
                }
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();

            }
        }
    }

    private void acquStart(BscJob pdJobLog,BaseJoblog baseJoblog, Boolean isLog) throws Exception {
        if(isLog){
        	baseJobLogBiz.save(baseJoblog);
        }
        List<GpsCarLocs> pageDatas = carSyncService.listAll();
        for (GpsCarLocs gpsCarLocs :pageDatas){
        	PageData pd=new PageData();
        	if(gpsCarLocs.getName()==null||gpsCarLocs.getInfo()==null||gpsCarLocs.getLng()==null||gpsCarLocs.getLat()==null
        			||gpsCarLocs.getMobile()==null||gpsCarLocs.getState()==null||gpsCarLocs.getRecvtime()==null
        			||gpsCarLocs.getFormatgpstime()==null){
        		continue;
        	}
        	pd.put("title",gpsCarLocs.getName());
        	pd.put("address", gpsCarLocs.getInfo());
        	pd.put("longitude", gpsCarLocs.getLng());
        	pd.put("latitude", gpsCarLocs.getLat());
        	pd.put("coord_type", 1);
        	pd.put("mobile", gpsCarLocs.getMobile());
        	pd.put("state", gpsCarLocs.getState());
        	pd.put("direct", gpsCarLocs.getDirect());
        	
        	String recvtime=gpsCarLocs.getRecvtime();
        	if(recvtime.startsWith("-")){
        		recvtime=recvtime.substring(1);
        	}
        	String gpstime=gpsCarLocs.getGpstime();
        	if(gpstime.startsWith("-")){
        		gpstime=gpstime.substring(1);
        	}
        	
        	pd.put("recvtime", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(Long.parseLong(recvtime))));
        	pd.put("gpstime",new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date(Long.parseLong(gpstime))));
            pd.put("ak", ak);
            pd.put("geotable_id",geotable_id);
            baiduLBSUtil.updatePOI(pd);
        }
    }
}
