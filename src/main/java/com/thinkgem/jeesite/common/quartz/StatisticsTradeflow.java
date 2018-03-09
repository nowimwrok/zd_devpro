package com.thinkgem.jeesite.common.quartz;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.LogStackTrace;
import com.thinkgem.jeesite.common.utils.ServiceHelper;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BaseJoblog;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscJob;
import com.thinkgem.jeesite.modules.wlpt.service.statistics.StatisticsTradeflowService;

/**
 * 运输流向统计
 * @author 曾煜佳
 *
 */
public class StatisticsTradeflow  extends BaseQuartzJobBean {

	StatisticsTradeflowService tradeflowService = ServiceHelper.getStatisticsTradeflowService();
	
	protected void executeInternal(JobExecutionContext context)throws JobExecutionException {
    	BscJob bscJob=new BscJob();
    	BaseJoblog baseJoblog=new BaseJoblog();
        Boolean isLog = true;
        try {
        	bscJob.setJobcode(Const.Job_Code.STATISTICS_TRADEFLOW.name());
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
        //运输流向统计
        tradeflowService.editTradeflow();
    }
}
