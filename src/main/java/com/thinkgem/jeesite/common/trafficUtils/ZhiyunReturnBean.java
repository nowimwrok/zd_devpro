package com.thinkgem.jeesite.common.trafficUtils;

/***
 * 登录接口返回值Bean
 */
public class ZhiyunReturnBean {

    private Object result;//数据内容
    private String status;//状态码

    public Object getResult() {
        return result;
    }

    public void setResult(Object result) {
        this.result = result;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
