package com.thinkgem.jeesite.modules.wlpt.webapi.financial;

import com.haitun56.saas.client.api.SaasApi;
import com.haitun56.saas.client.entity.SaasRequest;
import com.haitun56.saas.client.entity.SecretKey;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * Created by Xillen on 2017/8/1.
 */

@Controller
@RequestMapping(value = "${frontPath}/wlpt/financial")
public class FinancialContoller extends BaseController {

    @ResponseBody
    @RequestMapping(value = {"/acctclient"})
    public Map<String, Object> acctclient(HttpServletRequest request, HttpServletResponse response) {
        SaasRequest saasRequest = new SaasRequest();
        SecretKey secretKey = new SecretKey();
        saasRequest.setAppMemberName(UserUtils.getUser().getLoginName());
        saasRequest.setAppId(saasUtil.APPID);
        saasRequest.setAppMemberId(UserUtils.getUser().getId());
        saasRequest.setUrl("http://project.haitun56.com.cn:2017/f/index/acctclient");
        secretKey.setAESKey(saasUtil.AES_KEY);
        secretKey.setRSAPublicKey(saasUtil.RSA_PUBLIC_KEY);
        secretKey.setRSAPrivateKey(saasUtil.RSA_PRIVATE_KEY);
        Map map = SaasApi.acctclient(request, response, saasRequest, secretKey);
        return map;
    }

}

