package com.thinkgem.jeesite.modules.weixin.entity.template;

/**
 * 模板消息数据对象实体
 * 
 * @author Administrator
 *
 */
public class Message {
	/**
	 * 消息内容
	 */
	private String value;
	/**
	 * 消息颜色
	 */
	private String color;

	public Message() {
		super();
	}

	public Message(String value, String color) {
		super();
		this.value = value;
		this.color = color;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

}
