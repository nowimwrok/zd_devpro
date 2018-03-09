package com.thinkgem.jeesite.common.quartz;
/*import org.quartz.DisallowConcurrentExecution;*/
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
/*import org.quartz.PersistJobDataAfterExecution;*/
import org.springframework.scheduling.quartz.QuartzJobBean;
import com.thinkgem.jeesite.common.utils.ServiceHelper;
import com.thinkgem.jeesite.modules.wlpt.biz.base.BaseJobLogBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.base.JobBiz;

/*@DisallowConcurrentExecution
@PersistJobDataAfterExecution*/
public  class BaseQuartzJobBean extends  QuartzJobBean {
	JobBiz jobBiz=ServiceHelper.getJobService();
	BaseJobLogBiz baseJobLogBiz=ServiceHelper.getJobLogService();
 
	@Override
	protected void executeInternal(JobExecutionContext arg0)
			throws JobExecutionException {
		// TODO Auto-generated method stub
		
	}
}
