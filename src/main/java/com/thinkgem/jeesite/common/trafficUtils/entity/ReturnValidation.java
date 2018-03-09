package com.thinkgem.jeesite.common.trafficUtils.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 返回验证类信息实体对象
 *
 * @author Shinelon
 */
public class ReturnValidation extends DataEntity<ReturnValidation> {

    /**
     *
     */
    private static final long serialVersionUID = 1L;


    private String result;  //返回的信息，多为查询验证类yes/no
    private int status;     //返回业务查询状态码

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

}
