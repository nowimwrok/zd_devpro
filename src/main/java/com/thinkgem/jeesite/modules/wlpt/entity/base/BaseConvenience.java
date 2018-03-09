/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.base;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 便民服务Entity
 * @author 王铸
 * @version 2016-08-08
 */
public class BaseConvenience extends DataEntity<BaseConvenience> {
	
	private static final long serialVersionUID = 1L;
	private String title;		// 服务标题
	private String link;		// 服务链接
	private Long categoryId;		// 类别ID，参照BASE_CATEGORIES
	private String description;		// 服务描述
	private String picture;		// 图片，可能存在多张，以英文分号隔开每个图片路径
	
	public BaseConvenience() {
		super();
	}

	public BaseConvenience(String id){
		super(id);
	}

	@Length(min=0, max=768, message="服务标题长度必须介于 0 和 768 之间")
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}
	
	public Long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Long categoryId) {
		this.categoryId = categoryId;
	}
	
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@Length(min=0, max=3072, message="图片，可能存在多张，以英文分号隔开每个图片路径长度必须介于 0 和 3072 之间")
	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}
	
}