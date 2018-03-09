/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.entity.base;

import org.hibernate.validator.constraints.Length;
import com.fasterxml.jackson.annotation.JsonBackReference;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * categoriesEntity
 * @author 王铸
 * @version 2016-08-04
 */
public class BaseCategories extends DataEntity<BaseCategories> {
	
	private static final long serialVersionUID = 1L;
	private String id;           //主键
	private String name;		// 分类名称
	private String despcription;		// 分类描述
	private BaseCategories parent;		// 父级ID
	private String isdelete;		// 是否删除:0否1删除;
	
	public BaseCategories() {
		super();
	}

	public BaseCategories(String id){
		super(id);
	}
	
	public String getId(){
		return id;
	}
	public void setId(String id){
		this.id=id;
	}
	@Length(min=0, max=512, message="分类名称长度必须介于 0 和 512 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getDespcription() {
		return despcription;
	}

	public void setDespcription(String despcription) {
		this.despcription = despcription;
	}
	
	@JsonBackReference
	public BaseCategories getParent() {
		return parent;
	}

	public void setParent(BaseCategories parent) {
		this.parent = parent;
	}
	
	@Length(min=0, max=11, message="是否删除:0否1删除;长度必须介于 0 和 11 之间")
	public String getIsdelete() {
		return isdelete;
	}

	public void setIsdelete(String isdelete) {
		this.isdelete = isdelete;
	}
	
}