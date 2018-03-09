package com.thinkgem.jeesite.modules.weixin.entity.template;

/**
 * 模板消息数据实体类
 * 
 * @author Administrator
 *
 */
public class TemplateMsg {
	/**
	 * 模板消息接收者：openid
	 */
	private String touser;
	/**
	 * 使用的模板对象ID
	 */
	private String template_id;
	/**
	 * 模板消息点击打开的链接
	 */
	private String url;
	/**
	 * 模板消息的头部颜色
	 */
	private String topcolor;
	/**
	 * 模板消息的数据
	 */
	private Object data;

	public TemplateMsg() {
		super();
	}

	public TemplateMsg(String touser, String templateid, String url, String topcolor, Object data) {
		super();
		this.touser = touser;
		this.template_id = templateid;
		this.url = url;
		this.topcolor = topcolor;
		this.data = data;
	}

	public String getTouser() {
		return touser;
	}

	public void setTouser(String touser) {
		this.touser = touser;
	}

	public String getTemplate_id() {
		return template_id;
	}

	public void setTemplate_id(String template_id) {
		this.template_id = template_id;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getTopcolor() {
		return topcolor;
	}

	public void setTopcolor(String topcolor) {
		this.topcolor = topcolor;
	}

	public Object getData() {
		return data;
	}

	public void setData(Object data) {
		this.data = data;
	}

}
