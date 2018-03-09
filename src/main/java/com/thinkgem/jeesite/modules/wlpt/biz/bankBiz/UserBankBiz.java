package com.thinkgem.jeesite.modules.wlpt.biz.bankBiz;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.AccountUtils;
import com.thinkgem.jeesite.common.utils.BankUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.bid.BidBlinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.AccountBankinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.AccountBranchBankinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserBankinfo;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserBankinfoService;

import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.List;

/**
 * 诚信biz
 */
@Service
@Transactional(readOnly = false)
public class UserBankBiz {

    @Autowired
    private UserBankinfoService userBankinfoService;
    @Autowired
    private UserBiz userBiz;


    /***
     * 银行卡绑定
     * @param userBankinfo
     */
    @Transactional(readOnly = false)
    public Object bankBind(UserBankinfo userBankinfo) {
    	int state= DataDic.RETURN_STATUS_NORMAL;
		String message="保存成功";
    	User user=UserUtils.getUser();
        if (user.getId()==null){
        	state=DataDic.RETURN_STATUS_INFOBUG;
        	message="您还未登录";
        }
        if(Tools.IsNullOrWhiteSpace(userBankinfo.getBankcard())||Tools.IsNullOrWhiteSpace(userBankinfo.getBankname())
        		||Tools.IsNullOrWhiteSpace(userBankinfo.getBanktype())
        		||Tools.IsNullOrWhiteSpace(userBankinfo.getAccountName())||Tools.IsNullOrWhiteSpace(userBankinfo.getUnionpayNo())){
        	state=DataDic.RETURN_STATUS_INFOBUG;
        	message="银行卡信息缺失";
        }
        //userBankinfo.setUnionpayNo(DictUtils.getDictLabel(userBankinfo.getBanktype(),"unionpay_no",""));
        if(Tools.IsNullOrWhiteSpace(userBankinfo.getUnionpayNo())){
        	state=DataDic.RETURN_STATUS_INFOBUG;
        	message="平台暂不支持绑定  "+userBankinfo.getBanktype();
        }
        UserBankinfo ub=new UserBankinfo();
        ub.setUser(user);
        List<UserBankinfo> list = userBankinfoService.findList(ub);
        if(list.size()==3){
        	return Tools.getMapResult(DataDic.RETURN_STATUS_INFOBUG,"每个用户最多只能绑定3张不同的银行卡",null);
        }
        ub.setBankcard(userBankinfo.getBankcard());
        ///验证用户是否已经绑定银行卡信息对象
        list = userBankinfoService.findList(ub);
        ////如果验证对象不为空,说明银行卡信息存在
        if (list.size()>0){
        	state=DataDic.RETURN_STATUS_INFOBUG;
        	message="不可多次绑定相同卡号";
        }
        if (!userBiz.checkCashPwd(userBankinfo.getPassword())) {
			state = DataDic.RETURN_STATUS_SYSBUG;
			message = "提现密码错误!";
		}
        if(state== DataDic.RETURN_STATUS_NORMAL){
        	UserBankinfo ubk=new UserBankinfo();
            ubk.setUser(user);
            List<UserBankinfo> ubklist = userBankinfoService.findList(ubk);
            if(ubklist.size()==0){
            	userBankinfo.setIsdefault(1);
            }else{
            	boolean flag=true;
            	for(UserBankinfo u:ubklist){
            		if(u.getIsdefault()==1){
            			flag=false;
            		}
            	}
            	if(flag){
            		userBankinfo.setIsdefault(1);
            	}
            }
        	userBankinfo.setUser(user);
            userBankinfoService.save(userBankinfo);
        }
        return Tools.getMapResult(state,message,null);
    }
    
    public Object getNameByCard(String cardNo){
    	int state=1;
    	String message="";
        if(cardNo.length()<6){
        	state=-1;
		}else {
			if(BankUtils.checkBankCard(cardNo)){
				message=BankUtils.getname(cardNo);
			}else{
				state=-1;
			}
        	
        }
        return Tools.getMapResult(state, message, null);
    }
    
    @Transactional(readOnly = false)
    public List<UserBankinfo> findBankList(UserBankinfo userBankinfo){
        List<UserBankinfo> list = userBankinfoService.findList(userBankinfo);
        return list;
    }

    @Transactional(readOnly = false)
    public void saveBank(UserBankinfo userBankinfo){
        userBankinfoService.save(userBankinfo);
    }


    @Transactional(readOnly = false)
    public void deteleBank(UserBankinfo userBankinfo){
        userBankinfoService.delete(userBankinfo);
    }
    
    public Page<AccountBankinfo> findBankinfoPage(String keyword,String page,String rows) {
    	Page<AccountBankinfo> pagelist = new Page<>();
    	
    	ObjectMapper mapper = new ObjectMapper();
        mapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
        mapper.disable(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES);
        mapper.configure(SerializationConfig.Feature.FAIL_ON_EMPTY_BEANS, false);
        try {
	    	AccountUtils autils = new AccountUtils();
	    	JSONObject  json= (JSONObject)autils.getBankNameList(keyword, page, rows);
	    	if(json!=null){
	    		JSONObject bodyOuter=(JSONObject) json.get("body");
	    		if(bodyOuter==null){
	    			return pagelist;
	    		}
	        	JSONObject paginatorOuter=(JSONObject) bodyOuter.get("paginator");
	        	if(paginatorOuter==null){
	    			return pagelist;
	    		}
	        	String totalCountOuter=paginatorOuter.getString("totalCount");
	        	pagelist.setCount(paginatorOuter.getLong("totalCount"));
	        	pagelist.setPageSize(paginatorOuter.getInteger("limit"));
	        	pagelist.setPageNo(paginatorOuter.getInteger("page"));
	        	if(!totalCountOuter.equals("0")){
	        		String bankinfo=bodyOuter.getString("records");
	    			if(!Tools.IsNullOrWhiteSpace(bankinfo)){
	    				List<AccountBankinfo> bankinfoList = Arrays.asList(mapper.readValue(bankinfo, AccountBankinfo[].class));
	    				pagelist.setList(bankinfoList);
	    			}
	        	}
	    	}
        } catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
		return pagelist;
	}
    
    /**
     * 获取账户系统支行信息
     * @param name
     * @param keyword
     * @param page
     * @param rows
     * @return
     */
    public Page<AccountBranchBankinfo> findBranchBankinfoPage(String name,String keyword,String page,String rows) {
    	Page<AccountBranchBankinfo> pagelist = new Page<>();
    	if(Tools.IsNullOrWhiteSpace(name)){
    		return pagelist;
    	}
    	ObjectMapper mapper = new ObjectMapper();
        mapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
        mapper.disable(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES);
        mapper.configure(SerializationConfig.Feature.FAIL_ON_EMPTY_BEANS, false);
        try {
	    	AccountUtils autils = new AccountUtils();
	    	JSONObject  json= (JSONObject)autils.getFullNameList(keyword, name, page, rows);
	    	if(json!=null){
	    		JSONObject bodyOuter=(JSONObject) json.get("body");
	    		if(bodyOuter==null){
	    			return pagelist;
	    		}
	        	JSONObject paginatorOuter=(JSONObject) bodyOuter.get("paginator");
	        	if(paginatorOuter==null){
	    			return pagelist;
	    		}
	        	String totalCountOuter=paginatorOuter.getString("totalCount");
	        	pagelist.setCount(paginatorOuter.getLong("totalCount"));
	        	pagelist.setPageSize(paginatorOuter.getInteger("limit"));
	        	pagelist.setPageNo(paginatorOuter.getInteger("page"));
	        	if(!totalCountOuter.equals("0")){
	        		String bankinfo=bodyOuter.getString("records");
	    			if(!Tools.IsNullOrWhiteSpace(bankinfo)){
	    				List<AccountBranchBankinfo> bankinfoList = Arrays.asList(mapper.readValue(bankinfo, AccountBranchBankinfo[].class));
	    				pagelist.setList(bankinfoList);
	    			}
	        	}
	    	}
        } catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
		return pagelist;
	}
	public UserBankinfo get(UserBankinfo userBankinfo) {
		return userBankinfoService.get(userBankinfo);
	}
}
