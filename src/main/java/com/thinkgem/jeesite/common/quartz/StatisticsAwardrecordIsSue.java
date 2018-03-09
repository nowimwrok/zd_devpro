package com.thinkgem.jeesite.common.quartz;


import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.LogStackTrace;
import com.thinkgem.jeesite.common.utils.ServiceHelper;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseJoblog;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscJob;
import com.thinkgem.jeesite.modules.wlpt.service.activity.ActivityAwardrecordService;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 * 更新奖品状态：过期和发放
 * @author 曾煜佳
 *
 */
public class StatisticsAwardrecordIsSue extends BaseQuartzJobBean {
    ActivityAwardrecordService activityAwardrecordCardBiz = (ActivityAwardrecordService) ServiceHelper.getService("activityAwardrecordService");
	protected void executeInternal(JobExecutionContext context)throws JobExecutionException {
    	BscJob bscJob=new BscJob();
    	BaseJoblog baseJoblog=new BaseJoblog();
        Boolean isLog = true;
        try {
        	bscJob.setJobcode(Const.Job_Code.STATISTICS_ACTIVITY_ISSUER.name());
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
        //更新已过期的奖品
        activityAwardrecordCardBiz.updateIsSueInvalid();
        //更新已发放的奖品
        activityAwardrecordCardBiz.updateIsSueGrant();
    }
}
