/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.base;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 物流诚信Entity
 * @author 王铸
 * @version 2016-08-08
 */
public class BaseCredibility extends DataEntity<BaseCredibility> {
	
	private static final long serialVersionUID = 1L;
	private String title;		// 标题
	private Date releaseTime;		// 发布时间
	private Long categoryId;		// 分类编码
	private String content;		// 内容
	private Date beginReleaseTime;		// 开始 发布时间
	private Date endReleaseTime;		// 结束 发布时间
	
	public BaseCredibility() {
		super();
	}

	public BaseCredibility(String id){
		super(id);
	}

	@Length(min=0, max=512, message="标题长度必须介于 0 和 512 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getReleaseTime() {
		return releaseTime;
	}

	public void setReleaseTime(Date releaseTime) {
		this.releaseTime = releaseTime;
	}
	
	public Long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}
	
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public Date getBeginReleaseTime() {
		return beginReleaseTime;
	}

	public void setBeginReleaseTime(Date beginReleaseTime) {
		this.beginReleaseTime = beginReleaseTime;
	}
	
	public Date getEndReleaseTime() {
		return endReleaseTime;
	}

	public void setEndReleaseTime(Date endReleaseTime) {
		this.endReleaseTime = endReleaseTime;
	}
		
}