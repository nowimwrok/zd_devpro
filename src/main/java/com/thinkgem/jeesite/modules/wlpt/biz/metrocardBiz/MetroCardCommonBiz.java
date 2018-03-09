package com.thinkgem.jeesite.modules.wlpt.biz.metrocardBiz;

import com.alibaba.fastjson.JSONObject;
import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.utils.MetroCardUtil;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCard;
import com.thinkgem.jeesite.modules.wlpt.service.card.UserMetroCardService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

/**
 * 一卡通接口
 *
 * @author fjc
 */
@Service
@Transactional(readOnly = true)
public class MetroCardCommonBiz {

    /*@Autowired
    private AddressService addressService;*/

    @Autowired
    private UserMetroCardService userMetroCardService;

  /*  @Autowired
    private ConsumeRecodBiz consumeRecodBiz;*/

   
    /**
     * 获取绑定卡信息 根据userid
     * @param userid
     * @return
     */
    public UserMetroCard getUserMetroCardByUserid(String userid){
    	if(userid==null){
    		return null;
    	}
    	UserMetroCard userMetroCard=new UserMetroCard();
    	User user=new User();
    	user.setId(userid);
    	userMetroCard.setUser(user);
    	userMetroCard=userMetroCardService.getUserMetroCardByUserId(userMetroCard);
    	return userMetroCard;
    }
    
/*    *//**
     * 一卡通审核
     * @param userMetroCard
     * @return
     *//*
    @Transactional(readOnly=false)
    public Map<String, Object> audit(UserMetroCard userMetroCard){
        Map<String, Object> result = new HashMap<>();
        int state=DataDic.RETURN_STATUS_NORMAL;
        String message="保存成功";
        String status="";
        if(userMetroCard==null){
        	state=DataDic.RETURN_STATUS_AUTHBUG;
        	message="信息缺失";
        }
        if(userMetroCard!=null&&userMetroCard.getStatus()==null){
        	state=DataDic.RETURN_STATUS_AUTHBUG;
        	message="信息缺失";
        }

        try {
            if(state==DataDic.RETURN_STATUS_NORMAL){
            	status=userMetroCard.getStatus();
            	userMetroCard.setPassword(userMetroCard.getPassword());
            	if(DataDic.METRO_STATUS_SQZ.equals(status)||DataDic.METRO_STATUS_SQBTG.equals(status)){//审核中或者审核不通过
            		userMetroCard.setPassword(SystemService.entryptPassword(userMetroCard.getPassword()));
            		userMetroCardService.save(userMetroCard);
            	}else if(DataDic.METRO_STATUS_SQTG.equals(status)){//申请通过
            		 Map<String, Object> map= register(userMetroCard.getCardid(), userMetroCard.getPassword(),"0",userMetroCard.getUserAccount(), userMetroCard.getTrueName(), userMetroCard.getMobile(), userMetroCard.getIdcard(),userMetroCard.getSex(), userMetroCard.getBirth(),userMetroCard.getCardAddress());
            		 if(map!=null){
                		 String reStatus=map.get("status").toString();
                		 if(DataDic.METRO_REGISTER_RESULTSTATUS_SUCESS.equals(reStatus)){//成功
                			 message="成功注册一卡通账户";
                			 userMetroCard.setPassword(SystemService.entryptPassword(userMetroCard.getPassword()));
                			 userMetroCardService.save(userMetroCard);
                		 }else{
                			 state=DataDic.RETURN_STATUS_AUTHBUG;//失败
                		 }
            			 message=map.get("message").toString(); 
            		 }

            	}else{
            		userMetroCard.setPassword(SystemService.entryptPassword(userMetroCard.getPassword()));
       			    userMetroCardService.save(userMetroCard);
            	}
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            state=DataDic.RETURN_STATUS_AUTHBUG;//失败
        }
        result.put("state", state);
        result.put("message", message);
        return result;
    }*/
    
    /**
     * 判断是否绑定一卡通
     * @param user
     * @return
     */
    public boolean isBindMetroCard(User user){
    	boolean falg = true;
    	UserMetroCard userMetroCard= getUserMetroCardByUserid(user.getId());
    	if(userMetroCard==null||Tools.IsNullOrWhiteSpace(userMetroCard.getCardid())||Tools.IsNullOrWhiteSpace(userMetroCard.getUserAccount())){
    		falg = false;
    	}
    	return falg;
    }
    
    /**
     * 充值一卡通
     * @param user
     * @param money
     * @return
     */
    @Transactional(readOnly = false)
    public Map<String, Object> metroCardRecharge(User user,Double money){
    	  Map<String, Object> result = new HashMap<>();
          int state=DataDic.RETURN_STATUS_NORMAL;
          String message="保存成功";
          try {
        	   User users=UserUtils.findUser(user);
        	   UserMetroCard userMetroCard= getUserMetroCardByUserid(users.getId());
        	   if(users.getId()==null){
        		   state= DataDic.RETURN_STATUS_INFOBUG;
        		   message="登陆失效,请重新登陆";
        	   }
        	   if(userMetroCard==null){
        		   state= DataDic.RETURN_STATUS_INFOBUG;
        		   message="请先申请一卡通账户";
        	   }else if(userMetroCard.getCardid()==null){
        		   state= DataDic.RETURN_STATUS_INFOBUG;
        		   message="请先绑定一卡通账户";
        	   }else if(userMetroCard.getUserAccount()==null){
        		   state= DataDic.RETURN_STATUS_INFOBUG;
        		   message="一卡通账户信息缺失";
        	   }
        	   
        	   if(state==DataDic.RETURN_STATUS_NORMAL){
        		   Map<String, Object> map=recharge(userMetroCard.getCardid(), userMetroCard.getUserAccount(), money,0.0, money, "一卡通充值");
        		   if(map!=null){
        			   String reStatus=map.get("status").toString();
        			   if(DataDic.METRO_REGISTER_RESULTSTATUS_SUCESS.equals(reStatus)){//充值成功
        				   state=DataDic.RETURN_STATUS_NORMAL;
        			   }else{
        				   state=DataDic.RETURN_STATUS_AUTHBUG;//充值失败
        			   }
        			   message=map.get("message").toString(); 
        		   }
        	   }
        	   
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			state=DataDic.RETURN_STATUS_AUTHBUG;//失败
		}
          result.put("state", state);
          result.put("message", message);
          return result;
    }
    
    
    /**
     * 一卡通消费
     * @param user
     * @param money
     * @return
     */
    @Transactional(readOnly = false)
    public Map<String, Object> metroCardConsume(User user,Double money){
    	  Map<String, Object> result = new HashMap<>();
          int state=DataDic.RETURN_STATUS_NORMAL;
          String message="保存成功";
          try {
        	   User users=UserUtils.findUser(user);
        	   UserMetroCard userMetroCard= getUserMetroCardByUserid(users.getId());
        	   if(users.getId()==null){
        		   state= DataDic.RETURN_STATUS_INFOBUG;
        		   message="登陆失效,请重新登陆";
        	   }
        	   if(userMetroCard==null){
        		   state= DataDic.RETURN_STATUS_INFOBUG;
        		   message="请先申请一卡通账户";
        	   }else if(userMetroCard.getCardid()==null){
        		   state= DataDic.RETURN_STATUS_INFOBUG;
        		   message="请先绑定一卡通账户";
        	   }else if(userMetroCard.getUserAccount()==null){
        		   state= DataDic.RETURN_STATUS_INFOBUG;
        		   message="一卡通账户信息缺失";
        	   }
        	   
        	   if(state==DataDic.RETURN_STATUS_NORMAL){
        		   Map<String, Object> map=consume(userMetroCard.getCardid(), userMetroCard.getUserAccount(), money, "一卡通转账");
        		   if(map!=null){
        			   String reStatus=map.get("status").toString();
        			   System.out.println("一卡通转账reStatus：========================="+reStatus);
        			   if(DataDic.METRO_REGISTER_RESULTSTATUS_SUCESS.equals(reStatus)){//转账成功
        				   state=DataDic.RETURN_STATUS_NORMAL;
        			   }else{
        				   state=DataDic.RETURN_STATUS_AUTHBUG;//转账失败
        			   }
        			   message=map.get("message").toString(); 
        		   }
        	   }
        	   
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			state=DataDic.RETURN_STATUS_AUTHBUG;//失败
		}
          result.put("state", state);
          result.put("message", message);
          return result;
    }
    /**
     * 申请一卡通
     *
     * @return
     */
/*    @Transactional(readOnly = false)
    public Map<String, Object> applicationMetroCard(Address address) {
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "申请成功";

        if (Tools.IsNullOrWhiteSpace(address.getCity())
                || Tools.IsNullOrWhiteSpace(address.getProvince())
                || Tools.IsNullOrWhiteSpace(address.getDistrict())
                || Tools.IsNullOrWhiteSpace(address.getAddress())
                || Tools.IsNullOrWhiteSpace(address.getLinkman())
                || Tools.IsNullOrWhiteSpace(address.getLinkmobile())
                || Tools.IsNullOrWhiteSpace(address.getPostcode())
                ) {
            state = DataDic.RETURN_STATUS_INFOBUG;
            message="信息缺失，请填写完整";
        }
        UserMetroCard userMetroCard=new UserMetroCard();
        userMetroCard.setUser(UserUtils.getUser());
        UserMetroCard metroCard = userMetroCardService.get(userMetroCard);
        if (metroCard!=null && (DataDic.METRO_STATUS_SQTG.equals(metroCard.getStatus())|| DataDic.METRO_STATUS_SQZ.equals(metroCard.getStatus()))){
            state = DataDic.RETURN_STATUS_INFOBUG;
            message="已经申请过";
        }

        if (state == DataDic.RETURN_STATUS_NORMAL) {
            if (Tools.IsNullOrWhiteSpace(address.getId())) {
                address.setUser(UserUtils.getUser());     //保存 申请地址
                address.setIsNewRecord(true);
                address.setType(DataDic.ADDRESS_TYPE_YKTSH);
                address.setDelFlag(DataDic.DEL_FLAG_NORMEL);
                address.setId(IdGen.uuid());
                addressService.save(address);

                if (metroCard==null){
                    userMetroCard.setUser(UserUtils.getUser());    //保存到用户一卡通表
                    userMetroCard.setStatus(DataDic.METRO_STATUS_SQZ);
                    userMetroCard.setIsNewRecord(true);
                    userMetroCard.setId(IdGen.uuid());
                    userMetroCard.setAddress(address);
                    userMetroCardService.save(userMetroCard);
                }
            }
        }
        return Tools.getMapResult(state, message, null);
    }*/

    /**
     * 注册会员
     * @param cardId 卡号
     * @param password 密码
     * @param memberGroupName 会员级别
     * @param userAccount 工号
     * @param trueName 姓名
     * @param mobile 手机
     * @param idCard 身份证号码
     * @param sex 性别 1男 2女
     * @param birth 生日 2000-01-01
     * @param address 地址
     * @return
     */
/*    @Transactional(readOnly=false)
    public Map<String, Object> register(String cardId,String password,String memberGroupName,String userAccount,String trueName,String mobile,String idCard,String sex,String birth,String address){
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> data = new HashMap<>();
        data.put("cardId", cardId);
        data.put("password",password);
        data.put("memberGroupName",memberGroupName);
        data.put("trueName", trueName);
        data.put("userAccount",userAccount);
        data.put("sex", sex);
        data.put("birth",birth);
        data.put("mobile", mobile);
        data.put("idCard", idCard);
        data.put("address", address);
        try {
        	MetroCardUtil metroCardUtil=new MetroCardUtil();
            JSONObject jsonObject = JSONObject.parseObject(metroCardUtil.callHttpPost("Add_Member",data));
            int status = jsonObject.getIntValue("status");
            String message = jsonObject.getString("message");

            result.put("status", status);
            result.put("message", message);
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return result;
    }*/


     
 
    /**
     * 充值
     * @param cardId 卡号
     * @param userAccount 工号
     * @param value 充值金额
     * @param valuePlus 赠送金额
     * @param paidMoney 实付金额
     * @param meno 充值备注
     * @return
     */
    public Map<String, Object> recharge(String cardId,String userAccount,Double value,Double valuePlus,Double paidMoney,String meno){
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> data = new HashMap<>();
        data.put("cardId", cardId);
        data.put("userAccount",userAccount);
        data.put("value",value);
        data.put("valuePlus", valuePlus);
        data.put("paidMoney",paidMoney);
        data.put("meno", meno);
        try {
        	MetroCardUtil metroCardUtil=new MetroCardUtil();
            JSONObject jsonObject = JSONObject.parseObject(metroCardUtil.callHttpPost("Add_Value",data));
            int status = jsonObject.getIntValue("status");
            String message = jsonObject.getString("message");
            System.out.println("一卡通充值message：========================="+message);
            result.put("status", status);
            result.put("message", message);
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 消费
     * @param cardId 卡号
     * @param userAccount 工号
     * @param value 消费金额
     * @param valuePlus 赠送金额
     * @param paidMoney 实付金额
     * @param meno 消费备注
     * @return
     */
    public Map<String, Object> consume(String cardId,String userAccount,Double value,String meno){
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> data = new HashMap<>();
        data.put("userAccount",userAccount);
        data.put("cardId", cardId);
        //data.put("password", DataDic.METRO_CARD_PWD);
        data.put("value",-value);
        data.put("meno", meno);
        try {
        	MetroCardUtil metroCardUtil=new MetroCardUtil();
            JSONObject jsonObject = JSONObject.parseObject(metroCardUtil.callHttpPost("Update_MemberValue",data));
            int status = jsonObject.getIntValue("status");
            String message = jsonObject.getString("message");
            System.out.println("一卡通转账message：========================="+message);
            result.put("status", status);
            result.put("message", message);
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 同步 消费记录
     * @return
     */
/*    @Transactional(readOnly = false)
    public Map<String,Object> syncConsumption(){
        Map<String, Object> testMap = new HashMap<>();
        Consumerecod newCodeBiz = consumeRecodBiz.getNewCodeBiz(null, DataDic.CONSUMERECODE_TYPE_PETROLCONSUME, DataDic.CONSUMERECODE_MODEL_PETROL, DataDic.CONSUMERECODE_WAY_PETROL);
        if (newCodeBiz!=null){
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String dateString = formatter.format(newCodeBiz.getCreateDate());
            testMap.put("where", "1=1 and operateTime >= '"+dateString+"'");
        }
        testMap.put("pageIndex", 0);
        testMap.put("pageSize", 1);
        testMap.put("userAccount", "10000");
        try {
            MetroCardUtil metroCardUtil=new MetroCardUtil();
            JSONObject jsonObject = JSONObject.parseObject(metroCardUtil.callHttpPost("Get_ConsumeNotePagedV2",testMap));
            if (jsonObject!=null){
                int status = jsonObject.getIntValue("status");
                int total=jsonObject.getIntValue("total");
                testMap.put("pageSize", total);   //查询所有
                if (status==0){
                    JSONObject jsonObjectAll = JSONObject.parseObject(metroCardUtil.callHttpPost("Get_ConsumeNotePagedV2",testMap));
                    if (jsonObjectAll!=null){
                        JSONArray array = jsonObjectAll.getJSONArray("data");
                        if (array!=null){
                            for (int i = 0; i < array.size(); i++) {
                                JSONObject object = array.getJSONObject(i);
                                UserMetroCard userMetroCard = userMetroCardService.getUserMetroCardByCardId(object.getString("CardId"));
                                if (userMetroCard!=null){
                                    consumeRecodBiz.consumePetroBiz(userMetroCard.getUser().getId(),object.getDouble("TotalPaid"),object.getString("Guid")); //保存消费记录
                                }
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        return null;
    }*/


}
