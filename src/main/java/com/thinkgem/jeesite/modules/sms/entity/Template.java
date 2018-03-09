/**
 * 
 */
package com.thinkgem.jeesite.modules.sms.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 消息模版Entity
 * @author 饶江龙
 * @version 2016-07-20
 */
public class Template extends DataEntity<Template> {
	
	private static final long serialVersionUID = 1L;
	private String name;		// 模板名字
	private String code;		// 编码
	private String template;		// 模板
	private String description;		// 描述
	
	public Template() {
		super();
	}

	public Template(String id){
		super(id);
	}

	@Length(min=0, max=255, message="模板名字长度必须介于 0 和 255 之间")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Length(min=0, max=255, message="编码长度必须介于 0 和 255 之间")
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	
	@Length(min=0, max=255, message="模板长度必须介于 0 和 255 之间")
	public String getTemplate() {
		return template;
	}

	public void setTemplate(String template) {
		this.template = template;
	}
	
	@Length(min=0, max=255, message="描述长度必须介于 0 和 255 之间")
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
}