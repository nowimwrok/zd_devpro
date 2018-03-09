package com.thinkgem.jeesite.modules.wlpt.biz.base;

import java.util.List;
import java.util.UUID;


import org.quartz.CronTrigger;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.Const;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.utils.Const.Job_Execycle;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.wlpt.entity.base.BscJob;
import com.thinkgem.jeesite.modules.wlpt.service.base.BscJobService;

@Service("jobBiz")
@Transactional(readOnly = true)
public class JobBiz extends BaseController{

	@Autowired
	private BscJobService bscJobService;
	@Autowired
	private Scheduler myscheduler;
 
	/*
	* 新增
	*/
	@Transactional(readOnly = false)
	public void save(BscJob bscJob)throws Exception{
		bscJobService.save(bscJob);
		//启用则启动任务
		JobDetail jdetail = getTask(bscJob.getJobcode());
		if(jdetail!=null){
			endTask(bscJob.getJobcode());
		}
		//启用则启动任务
		if(1 ==Integer.parseInt(bscJob.getIsenable())){
			startTask(bscJob);
		}
	}
	
	/*
	* 删除
	*/
	@Transactional(readOnly = false)
	public void delete(BscJob bscJob)throws Exception{
		BscJob jobPd=this.findByCondition(bscJob);
        endTask(jobPd.getJobcode());
        bscJobService.delete(bscJob);
	}
	
	/*
	* 修改
	*/
	@Transactional(readOnly = false)
	public void edit(BscJob bscJob)throws Exception{
		String oldTaskCode = this.findById(bscJob).getJobcode();
		//结束定时调度
		//endTask(oldTaskCode);
		bscJobService.save(bscJob);
		//启用则启动任务
		JobDetail jdetail = getTask(bscJob.getJobcode());
		if(jdetail!=null){
			endTask(bscJob.getJobcode());
		}
		if(1 == Integer.parseInt(bscJob.getIsenable())){
			startTask(bscJob);
		}
	}
	
	/*
	*列表
	*/
	public Page<BscJob> findPage(Page page,BscJob bscJob)throws Exception{
		return bscJobService.findPage(page,bscJob);
	}
	
	/*
	*列表(全部)
	*/
	public List<BscJob> listAll(BscJob bscJob)throws Exception{
		return bscJobService.findList(bscJob);
	}
	
	/*
	* 通过id获取数据
	*/
	public BscJob findById(BscJob bscJob)throws Exception{
		return bscJobService.get(bscJob.getId());
	}
	
	/*
	* 批量删除
	*/
//	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
//		dao.delete("JobMapper.deleteAll", Tools.getPageDataByStrArr(ArrayDATA_IDS));
//	}
	
	/*
	* 通过查询条件获取数据
	*/
	public BscJob findByCondition(BscJob bscJob)throws Exception{
		return bscJobService.findByCondition(bscJob);
	}
	
	/*
	* 通过查询条件获取查询数据的总条数
	*/
//	public Integer getTotalCount(PageData pd)throws Exception{
//		return (Integer)dao.findForObject("JobMapper.getTotalCount", pd);
//	}
	
	/***
	 * 启动任务
	 * @Description: TODO
	 * @param @param task
	 * @param @param taskCode   
	 * @return void  
	 * @throws Exception 
	 * @throws
	 * @author lqz
	 * @date 2015年6月10日
	 */
	private void startTask(BscJob task) throws Exception{
	     	if(!isRun())
	          { myscheduler.shutdown();
	     		return;
	     		}
			String taskCode=task.getJobcode();
			String cronExpress = getCronExpression(task);
			if(!Tools.IsNullOrWhiteSpace(cronExpress)){
				JobDetail jobDetail = new JobDetail();
				jobDetail.setName(taskCode);
				jobDetail.setGroup(Scheduler.DEFAULT_GROUP);
				//判断要执行的类存不存在
				try {

					Class aClass = Class.forName(task.getJobclass());


					} catch (ClassNotFoundException e) {

					// TODO Auto-generated catch block

					e.printStackTrace();
					System.out.println("此类不存在");
					return;

					}
				jobDetail.setJobClass(getClassByTask(task.getJobclass()));
				CronTrigger cronTrigger = new CronTrigger("cron_" + taskCode,Scheduler.DEFAULT_GROUP, jobDetail.getName(),Scheduler.DEFAULT_GROUP);
				cronTrigger.setCronExpression(cronExpress);
				myscheduler.scheduleJob(jobDetail, cronTrigger); 
				
			}
	}

	
	/*
	* 中止任务
	*/
	private void endTask(String taskName) throws SchedulerException{
		 
		myscheduler.deleteJob(taskName, Scheduler.DEFAULT_GROUP);
		
	}
	
	private JobDetail getTask(String taskName) throws SchedulerException{
		return myscheduler.getJobDetail(taskName,  Scheduler.DEFAULT_GROUP);
	}
	
	private Boolean isRun(){
		String isRun=Tools.readTxtFileForThread(Const.TASKISRUN);
		if(isRun.equalsIgnoreCase("true"))
			return true;
		return false;
	}
	
	/**
	 * 系统初始加载任务
	 */
	/*@PostConstruct*/
	public void loadTask()throws Exception{
		if(!isRun())
          return;
		List<BscJob> tasks = this.listAll(null);
		if(tasks.size()>0){
			for (int i = 0; i < tasks.size(); i++) {
				BscJob task=tasks.get(i);
				//启用则启动任务
				JobDetail jdetail = getTask(task.getJobcode());
				if(jdetail!=null){
					endTask(task.getJobcode());
				}
				//任务开启状态 执行任务调度
				if(1 ==Integer.parseInt(task.getIsenable()) ){
					     String taskCode=task.getJobcode();
						JobDetail jobDetail = new JobDetail();
						//设置任务名称
						if(StringUtils.isNotBlank(taskCode)){
							jobDetail.setName(taskCode);
						}else{
							UUID uuid=UUID.randomUUID();
							taskCode=uuid.toString();
							jobDetail.setName(taskCode);
							task.setJobcode(taskCode);
							this.edit(task);
						}
						jobDetail.setGroup(Scheduler.DEFAULT_GROUP);
						//判断要执行的类存不存在
						try {

							Class aClass = Class.forName(task.getJobclass());


							} catch (ClassNotFoundException e) {

							// TODO Auto-generated catch block

							//e.printStackTrace();
							System.out.println("此类不存在");
							return;

							}
						
						//设置任务执行类
						jobDetail.setJobClass(getClassByTask(task.getJobclass()));
						//添加任务参数
						//jobDetail.setJobDataMap(getJobDataMap(task.getAttr()));
						CronTrigger cronTrigger = new CronTrigger("cron_" + i,Scheduler.DEFAULT_GROUP, jobDetail.getName(),Scheduler.DEFAULT_GROUP);
						cronTrigger.setCronExpression(getCronExpression(task));
						//调度任务
						myscheduler.scheduleJob(jobDetail, cronTrigger); 
					 
				}                                                                                                                                                                             
			}
		}
	}
	
	
	 
	
	/**
	 * 
	 * @param taskClassName 任务执行类名
	 * @return
	 * @throws ClassNotFoundException
	 */
	@SuppressWarnings("rawtypes")
	private Class getClassByTask(String taskClassName) throws ClassNotFoundException{
		return Class.forName(taskClassName);
	}
	
	/**
	 * 获取Cron表达式
	 */
	public String getCronExpression(BscJob task) throws Exception {
		if(null != task){
			if (1 ==Integer.parseInt(task.getExecycle())) {
				return task.getCronexpression();
			} else {
				Integer execycle =Integer.parseInt(task.getJobIntervalUnit());
				String excep="" ;
				if (execycle.equals(Job_Execycle.EXECYCLE_MONTH.ordinal())) {
					excep="0  "+task.getMinute()+" "+task.getHour()+" "
				+ task.getDayOfMonth() +" * ?";
				} else if (execycle.equals(Job_Execycle.EXECYCLE_WEEK.ordinal())) {
					excep="0  "+task.getMinute() +" "+task.getHour()+" "
				+" ? " +" * "+task.getDayOfWeek();
				} else if (execycle.equals(Job_Execycle.EXECYCLE_DAY.ordinal())) {
					excep="0  "+task.getMinute() +" "+task.getHour()+" "+" * * ?";
				} else if (execycle.equals(Job_Execycle.EXECYCLE_HOUR.ordinal())) {
					excep="0 0 */"+task.getIntervalhour()+" * * ?";
				} else if (execycle.equals(Job_Execycle.EXECYCLE_MINUTE.ordinal())) {
					excep="0  */"+task.getIntervalminute() +" * * * ?";
				}
				return excep;
			}
		}
		return "";
	}
}
