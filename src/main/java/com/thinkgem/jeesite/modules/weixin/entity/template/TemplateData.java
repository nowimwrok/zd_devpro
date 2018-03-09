package com.thinkgem.jeesite.modules.weixin.entity.template;

/**
 * 模板消息数据实体
 * 
 * @Description: TODO
 * @author txw 创建日期：2015年10月12日
 */
public class TemplateData {
	private Message first;
	private Message keyword1;
	private Message keyword2;
	private Message keyword3;
	private Message keyword4;
	private Message keyword5;
	private Message remark;

	public TemplateData() {
		super();
	}

	public TemplateData(Message first, Message keyword1, Message keyword2, Message keyword3, Message keyword4, Message keyword5, Message remark) {
		super();
		this.first = first;
		this.keyword1 = keyword1;
		this.keyword2 = keyword2;
		this.keyword3 = keyword3;
		this.keyword4 = keyword4;
		this.keyword5 = keyword5;
		this.remark = remark;
	}

	public Message getFirst() {
		return first;
	}

	public void setFirst(Message first) {
		this.first = first;
	}

	public Message getKeyword1() {
		return keyword1;
	}

	public void setKeyword1(Message keyword1) {
		this.keyword1 = keyword1;
	}

	public Message getKeyword2() {
		return keyword2;
	}

	public void setKeyword2(Message keyword2) {
		this.keyword2 = keyword2;
	}

	public Message getKeyword3() {
		return keyword3;
	}

	public void setKeyword3(Message keyword3) {
		this.keyword3 = keyword3;
	}

	public Message getKeyword4() {
		return keyword4;
	}

	public void setKeyword4(Message keyword4) {
		this.keyword4 = keyword4;
	}

	public Message getKeyword5() {
		return keyword5;
	}

	public void setKeyword5(Message keyword5) {
		this.keyword5 = keyword5;
	}

	public Message getRemark() {
		return remark;
	}

	public void setRemark(Message remark) {
		this.remark = remark;
	}

}
