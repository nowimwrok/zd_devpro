/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.base;

import org.hibernate.validator.constraints.Length;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.text.SimpleDateFormat;
import java.util.Date;
import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 新闻管理Entity
 * @author 王铸
 * @version 2016-08-04
 */
public class BaseNews extends DataEntity<BaseNews> {
	
	private static final long serialVersionUID = 1L;
	private String id;           //主键
	private String title;		// 标题
	private Long categoryId;		// 分类
	private String content;		// 内容
	private String source;		// 新闻来源
	private String author;		// 作者
	private Long hot;		// 点击量
	private Date releaseTime;		// 发布时间
	private String sourceLink;		// 来源链接
	private String picture;		// 广告图片，可能存在多张，以英文分号隔开每个图片路径
	private String keyword;		// 关键字，可以有多个关键字，以英文的分号隔开每个关键字
	private String summary;		// 内容摘要
	private String time;        //发布时间 yyyy-MM-dd HH:mm:ss
	private Date beginReleaseTime;		// 开始 发布时间
	private Date endReleaseTime;		// 结束 发布时间
	private BaseCategories baseCategories;		// 新闻分类
	public BaseNews() {
		super();
	}

	public BaseCategories getBaseCategories() {
		return baseCategories;
	}

	public void setBaseCategories(BaseCategories baseCategories) {
		this.baseCategories = baseCategories;
	}

	public BaseNews(String id){
		super(id);
	}
	
	public String getId(){
		return id;
	}
	
	public void setId(String id){
		this.id=id;
	}

	@Length(min=0, max=512, message="标题长度必须介于 0 和 512 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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
	
	@Length(min=0, max=512, message="新闻来源长度必须介于 0 和 512 之间")
	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}
	
	@Length(min=0, max=512, message="作者长度必须介于 0 和 512 之间")
	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}
	
	public Long getHot() {
		return hot;
	}

	public void setHot(Long hot) {
		this.hot = hot;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getReleaseTime() {
		return releaseTime;
	}
	public String getTime(){
		return time;
	}

	public void setReleaseTime(Date releaseTime) {
		this.releaseTime = releaseTime;
		this.time = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(releaseTime);
	}
	
	public String getSourceLink() {
		return sourceLink;
	}

	public void setSourceLink(String sourceLink) {
		this.sourceLink = sourceLink;
	}
	
	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}
	
	@Length(min=0, max=512, message="关键字，可以有多个关键字，以英文的分号隔开每个关键字长度必须介于 0 和 512 之间")
	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	@Length(min=0, max=512, message="内容摘要长度必须介于 0 和 512 之间")
	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
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