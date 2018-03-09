package com.thinkgem.jeesite.common.quartz;
/*import org.quartz.DisallowConcurrentExecution;
import org.quartz.Job;
import org.quartz.PersistJobDataAfterExecution;*/
import org.quartz.StatefulJob;

import com.thinkgem.jeesite.common.utils.ServiceHelper;
import com.thinkgem.jeesite.modules.wlpt.biz.base.BaseJobLogBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.base.JobBiz;
/*import com.thinkgem.jeesite.modules.wlpt.service.base.BaseJoblogService;*/

/*@DisallowConcurrentExecution
@PersistJobDataAfterExecution*/
public abstract  class BaseStatefulQuartzJobBean implements StatefulJob  {
	JobBiz jobBiz=ServiceHelper.getJobService();
	BaseJobLogBiz baseJobLogBiz=ServiceHelper.getJobLogService();
 
}
