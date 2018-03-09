
package com.thinkgem.jeesite.modules.wlpt.entity.base;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 任务日志Entity
 * @author 王铸
 * @version 2016-09-07
 */
public class BaseJoblog extends DataEntity<BaseJoblog> {
	
	private static final long serialVersionUID = 1L;
	private String jobid;		// 任务ID
	private Date starttime;		// 日志创建时间
	private String exceptioninfo;		// 任务异常信息
	
	public BaseJoblog() {
		super();
	}

	public BaseJoblog(String id){
		super(id);
	}
	
	@Length(min=0, max=32, message="任务ID长度必须介于 0 和 32 之间")
	public String getJobid() {
		return jobid;
	}

	public void setJobid(String jobid) {
		this.jobid = jobid;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getStarttime() {
		return starttime;
	}

	public void setStarttime(Date starttime) {
		this.starttime = starttime;
	}
	
	public String getExceptioninfo() {
		return exceptioninfo;
	}

	public void setExceptioninfo(String exceptioninfo) {
		this.exceptioninfo = exceptioninfo;
	}
	
}