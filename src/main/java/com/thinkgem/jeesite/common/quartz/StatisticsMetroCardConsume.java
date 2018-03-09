package com.thinkgem.jeesite.common.quartz;


import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.LogStackTrace;
import com.thinkgem.jeesite.common.utils.ServiceHelper;
import com.thinkgem.jeesite.modules.wlpt.biz.metrocardBiz.MetroCardBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseJoblog;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscJob;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsCarService;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 * 一卡通消费记录同步
 * @author 刘欣
 *
 */
public class StatisticsMetroCardConsume extends BaseQuartzJobBean {
	MetroCardBiz metroCardBiz = (MetroCardBiz) ServiceHelper.getService("metroCardBiz");
	protected void executeInternal(JobExecutionContext context)throws JobExecutionException {
    	BscJob bscJob=new BscJob();
    	BaseJoblog baseJoblog=new BaseJoblog();
        Boolean isLog = true;
        try {
        	bscJob.setJobcode(Const.Job_Code.STATISTICS_METRO_CARD_CONSUME.name());
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
        //一卡通消费记录同步
        metroCardBiz.syncConsumption();
    }
}
