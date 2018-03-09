package com.thinkgem.jeesite.modules.wlpt.biz.IntegrityBiz;


import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.IdGen;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.entity.Userinfo;
import com.thinkgem.jeesite.modules.sys.service.UserinfoService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityMemberlevel;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityRecord;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityStandard;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityStandarditems;
import com.thinkgem.jeesite.modules.wlpt.entity.integrity.IntegrityStandardlog;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserStatistics;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.IntegrityRecordVO;
import com.thinkgem.jeesite.modules.wlpt.service.integrity.IntegrityMemberlevelService;
import com.thinkgem.jeesite.modules.wlpt.service.integrity.IntegrityRecordService;
import com.thinkgem.jeesite.modules.wlpt.service.integrity.IntegrityStandardService;
import com.thinkgem.jeesite.modules.wlpt.service.integrity.IntegrityStandarditemsService;
import com.thinkgem.jeesite.modules.wlpt.service.integrity.IntegrityStandardlogService;
import com.thinkgem.jeesite.modules.wlpt.service.user.UserStatisticsService;

/**
 * 诚信biz
 */
@Service
@Transactional(readOnly = false)
public class IntegrityBiz {

    @Autowired
    private IntegrityMemberlevelService memberlevelService;

    @Autowired
    private IntegrityRecordService recordService;

    @Autowired
    private IntegrityStandardService standardService;

    @Autowired
    private IntegrityStandardlogService standardlogService;

    @Autowired
    private IntegrityStandarditemsService standarditemsService;

    @Autowired
    private UserStatisticsService userStatisticsService;

    @Autowired
    private UserinfoService userinfoService;
    
//    @Autowired
//    private IntegrityExchaneBiz integrityExchaneBiz;
//    
//    @Autowired
//	  private IntegralexchangeService integralexchangeService;
    
    /**
     * 更新用户会员等级
     *
     * @param
     */
    public void updateUserMemberLevel(User user) throws Exception {
        user = UserUtils.findUser(user);
        Date newdate = new Date();
        if (user != null && user.getId() != null && user.getUserinfo()!=null) {
            Userinfo userinfo = user != null ? user.getUserinfo() : null;
            int pointlevle = 0;  //会员等级
            Date countdate =  userinfo.getCountdate();
            if(countdate==null || (newdate.getMonth() - countdate.getMonth())>=3){
            	
            
            UserStatistics userstatistics = new UserStatistics();
            userstatistics.setUser(user);
            //根据用户id获取记录
            UserStatistics statistics = userStatisticsService.findIntegrityinfo(userstatistics);
            IntegrityMemberlevel memberLevel = new IntegrityMemberlevel();
            Map<String, List<IntegrityMemberlevel>> iMap = new LinkedHashMap<>();  //等级配置

            memberLevel.setMembertype(user.getRole().getEnname());  //查找会员类型 等级配置
            List<IntegrityMemberlevel> mlist = memberlevelService.findList(memberLevel);
            if (mlist.size() > 0) {
                for (IntegrityMemberlevel mlevel : mlist) {
                    if (iMap.get(mlevel.getMemberlevel()) != null) {
                        iMap.get(mlevel.getMemberlevel()).add(mlevel);
                    } else {
                        List<IntegrityMemberlevel> levelList = new ArrayList<>();
                        levelList.add(mlevel);
                        iMap.put(mlevel.getMemberlevel(), levelList);
                    }
                }
            }
            if (pointlevle < Integer.parseInt(DataDic.INTEGRITY_LEVEL_THIRD) && userinfo.getStatus().equals(DataDic.AUTHENSUCCES)) {   //判断用户是否认证
            	pointlevle = Integer.parseInt(DataDic.INTEGRITY_LEVEL_THIRD);
            }if (!userinfo.getStatus().equals(DataDic.AUTHENSUCCES)) {   //判断用户是否认证
            	pointlevle = Integer.parseInt(DataDic.INTEGRITY_LEVEL_FIRST);
            }
            
            //有等级分类时执行
            if(iMap.size()>0&&pointlevle >= Integer.parseInt(DataDic.INTEGRITY_LEVEL_THIRD)){
            	for (String k : iMap.keySet()) {      //判断用户等级
                    List<IntegrityMemberlevel> integrityMemberlevels = iMap.get(k);
                    boolean b = true;
                    for (IntegrityMemberlevel m : integrityMemberlevels) {
                        String s = "get" + m.getIntegritycode().replaceFirst(m.getIntegritycode().substring(0, 1), m.getIntegritycode().substring(0, 1).toUpperCase());
                        Object o = invokeMethod(statistics, s, new Object[0]);
                        if (o != null) {
                            BigDecimal big = new BigDecimal(o.toString());   //用户当前值
                            BigDecimal big1 = new BigDecimal(m.getStandardvalue());    //标准值
                            if (big.compareTo(big1) < 0) {
                                b = false;
                            } else {
                                b = true;
                                break;
                            }
                        } else {
                            b = false;
                        }
                    }
                    if (b&&pointlevle<Integer.parseInt(DataDic.INTEGRITY_LEVEL_FIRFTH)) {
                    	pointlevle = pointlevle+1;
                    }else if(pointlevle > Integer.parseInt(DataDic.INTEGRITY_LEVEL_THIRD)){
                    	pointlevle = pointlevle-1;
                    }
                   
                }
            }
            if (pointlevle < Integer.parseInt(DataDic.INTEGRITY_LEVEL_THIRD) && userinfo.getStatus().equals(DataDic.AUTHENSUCCES)) {   //判断用户是否认证
            	pointlevle = Integer.parseInt(DataDic.INTEGRITY_LEVEL_THIRD);
            }
            if (userinfo.getPointlevle() != pointlevle) {
                userinfo.setPointlevle(pointlevle);
                userinfo.setCountdate(newdate);
                userinfoService.save(userinfo);
            }
            }
        }
    }


    /**
     * 更新用户诚信信息
     */
    public void txMethodUpdateUserIntegrity(User user) throws Exception {
    	user = UserUtils.findUser(user);
        if (user != null && user.getId() != null && user.getUserinfo()!=null) {
        	Userinfo userinfo = user != null ? user.getUserinfo() : null;

            int pointLevel = 0;

            UserStatistics userstatistics = new UserStatistics();
            userstatistics.setUser(user);
            
            //根据用户id获取记录
            UserStatistics statistics = userStatisticsService.getConditon(userstatistics);
            if(statistics==null){
            	statistics = new UserStatistics();
            }
            //获取当天记录
            userstatistics.setCreatetime(new Date());
            UserStatistics statisticsrecord = userStatisticsService.getRecordConditon(userstatistics);
            if(statisticsrecord==null){
            	statisticsrecord= new UserStatistics();
            }
            IntegrityStandard standard = new IntegrityStandard();
            
                standard.setMembertype(user.getRole().getEnname());
                List<IntegrityStandard> slist = standardService.findList(standard);
                if (slist.size() > 0) {
                    for (IntegrityStandard stand : slist) {
                        int integral = 0;
                        IntegrityStandarditems standarditems = new IntegrityStandarditems();
                        standarditems.setStandard(stand);
                        List<IntegrityStandarditems> standarditemses = standarditemsService.findList(standarditems);
                        for (IntegrityStandarditems item : standarditemses) {
                            int scoreValue = 0;
                            if (item.getScorevalue() != null) {
                                scoreValue = item.getScorevalue();
                            }
                            String s = "get" + item.getIntegritycode().replaceFirst(item.getIntegritycode().substring(0, 1), item.getIntegritycode().substring(0, 1).toUpperCase());
                            String s1 = "get" + item.getIntegritycode().replaceFirst(item.getIntegritycode().substring(0, 1), item.getIntegritycode().substring(0, 1).toUpperCase());
                            Object o = invokeMethod(statistics, s, new Object[0]);//当前数据
                            
                            Object record = invokeMethod(statisticsrecord, s1, new Object[0]);//前一天记录
                            switch (item.getScoreway()) {
                                case "1":   //等于条件值
                                    if (o != null && o.equals(scoreValue)) {
                                    	updateIntegrityRecord(userinfo, item, item.getIntegral());
                                        integral += item.getIntegral();
                                    }
                                    break;
                                case "2":  //大于等于条件值
                                    if (o != null && Integer.parseInt(o.toString()) >= scoreValue) {
                                        updateIntegrityRecord(userinfo, item, item.getIntegral());
                                        integral += item.getIntegral();
                                    }
                                    break;
                                case "3":  //小于等于条件值
                                    if (o != null && Integer.parseInt(o.toString()) <= scoreValue) {
                                        updateIntegrityRecord(userinfo, item, item.getIntegral());
                                        integral += item.getIntegral();
                                    }
                                    break;
                                case "4":  //除以条件值取整
                                    if (o != null) {
                                        int i = (int) Double.parseDouble(o.toString()) / scoreValue;
                                        if (i > 0) {
                                            int ital = i * item.getIntegral();
                                            updateIntegrityRecord(userinfo, item, item.getIntegral());
                                            integral += ital;
                                        }
                                    }
                                    break;
                                case "5":  //第一次数据
                                	if (o != null && o.equals(scoreValue)) {
                                    	//新订单
                                    	if(record==null&&o.equals(1)){
                                    		updateIntegrityRecord(userinfo, item, item.getIntegral());
                                    	}
                                        
                                        integral += item.getIntegral();
                                    }
                                	break;
                                case "6":  //其他
                                	if(o!=null){
                                		
                                		if(record!=null){
                                			int num = (int) Double.parseDouble(o.toString()) - (int) Double.parseDouble(record.toString());
                                			if(num>0){
                                				int ital = num * item.getIntegral();
                                                updateIntegrityRecord(userinfo, item, ital);//更新积分数据
                                			}
                                		}
                                	}
                                	break;
                            }
                        }
                        /*if (integral >= stand.getStandardvalue()) {
                            pointLevel += 1;
                        }*/
                    }
                    //userinfo.setPointlevle(pointLevel);
                    //userinfoService.save(userinfo);
                }
            }
    }


    /**
     * 更新用户诚信积分
     *
     * @param userinfo     用户信息
     * @param tandardItems 评分项
     * @param integral     所得分
     */
    private void updateIntegrityRecord(Userinfo userinfo, IntegrityStandarditems tandardItems, Integer integral) {
        if (userinfo != null && userinfo.getId() != null && tandardItems.getId() != null) {
        	
            
            IntegrityRecord rpd = new IntegrityRecord();  //用户积分
            rpd.setUser(userinfo.getUser());
            rpd.setStandarditems(tandardItems);
            try {
            	
            	List<IntegrityRecord> recordlist = recordService.findList(rpd);   //积分记录
                Integer point = userinfo.getPoint();   //用户当前积分
                if(point>=0&&(point+integral)>0) {
                	if (recordlist.size()>0) {   //如果有积分记录
                    	rpd = recordlist.get(0);
                        Integer recordIntegral = rpd.getIntegral();

                        rpd.setIntegral(integral);
                        recordService.save(rpd);

                        IntegrityStandardlog standardlog = new IntegrityStandardlog();
                        standardlog.setUser(userinfo.getUser());
                        standardlog.setStandarditems(tandardItems);
                        standardlog.setPointvalue(integral);
                        standardlog.setPointbefore(point);
                        standardlog.setPointafter(point + integral);
                        standardlog.setIsNewRecord(true);
                        standardlog.setId(IdGen.uuid());
                        standardlogService.save(standardlog);

                        userinfo.setPoint(point + integral);
                        userinfoService.save(userinfo);
                    }else{
                    	rpd = new IntegrityRecord();  //用户积分
                        rpd.setUser(userinfo.getUser());
                        rpd.setStandarditems(tandardItems);
                        rpd.setIntegral(integral);
                        rpd.setIsNewRecord(true);
                        rpd.setId(IdGen.uuid());
                        recordService.save(rpd);

                        IntegrityStandardlog standardlog = new IntegrityStandardlog();
                        standardlog.setUser(userinfo.getUser());
                        standardlog.setStandarditems(tandardItems);
                        standardlog.setPointvalue(integral);
                        standardlog.setPointbefore(point);
                        standardlog.setPointafter(point + integral);
                        standardlog.setIsNewRecord(true);
                        standardlog.setId(IdGen.uuid());
                        standardlogService.save(standardlog);

                        userinfo.setPoint(point + integral);
                        userinfoService.save(userinfo);
                    }
                }
                

            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    /**
     * 更新用户诚信积分
     *
     * @param userinfo     用户信息
     * @param code 评分项
     * @param enename 会员类型
     */
    @Transactional(readOnly = false)
    public void updateIntegrityPoint(Userinfo userinfo,String code,String enename) {
    	
    	
        if (userinfo != null && userinfo.getId() != null ) {

        	
        	IntegrityStandarditems tandardItems = new IntegrityStandarditems();
        	IntegrityStandard isd = new IntegrityStandard();
        	isd.setMembertype(enename);
        	tandardItems.setStandard(isd);
        	tandardItems.setIntegritycode(code);
        	List<IntegrityStandarditems> itemlist = standarditemsService.findList(tandardItems);
        	if(itemlist.size()>0){
        		tandardItems = itemlist.get(0);
        		IntegrityRecord rpd = new IntegrityRecord();  //用户积分
            	
                rpd.setUser(userinfo.getUser());
                rpd.setStandarditems(tandardItems);
                try {

                    List<IntegrityRecord> recordlist = recordService.findList(rpd);   //积分记录
                    Integer point = userinfo.getPoint();   //用户当前积分
                    System.out.println("++++++++++++++++++++"+point+"+++++++++++++++++");
                    if (recordlist.size()>0) {   //如果有积分记录
                    	System.out.println("==============有积分记录================");
                    	rpd = recordlist.get(0);
                        Integer recordIntegral = rpd.getIntegral();
                        Integer i = tandardItems.getIntegral() + recordIntegral;   //变更的积分

                        rpd.setIntegral(i);
                        recordService.save(rpd);

                        IntegrityStandardlog standardlog = new IntegrityStandardlog();
                        standardlog.setUser(userinfo.getUser());
                        standardlog.setStandarditems(tandardItems);
                        standardlog.setPointvalue(tandardItems.getIntegral());
                        standardlog.setPointbefore(point);
                        standardlog.setPointafter(point + tandardItems.getIntegral());
                        standardlog.setIsNewRecord(true);
                        standardlog.setId(IdGen.uuid());
                        standardlogService.save(standardlog);
                        userinfo.setPoint(point + tandardItems.getIntegral());
                        System.out.println("=================变化后的积分是"+userinfo.getPoint()+"================");
                        userinfoService.save(userinfo);
                    }else{
                    	System.out.println("==============无积分记录================");
                    	rpd = new IntegrityRecord();  //用户积分
                        Integer i = tandardItems.getIntegral();   //变更的积分
                        rpd.setUser(userinfo.getUser());
                        rpd.setStandarditems(tandardItems);
                        rpd.setIntegral(i);
                        rpd.setIsNewRecord(true);
                        rpd.setId(IdGen.uuid());
                        recordService.save(rpd);

                        IntegrityStandardlog standardlog = new IntegrityStandardlog();
                        standardlog.setUser(userinfo.getUser());
                        standardlog.setStandarditems(tandardItems);
                        standardlog.setPointvalue(i);
                        standardlog.setPointbefore(point);
                        standardlog.setPointafter(point + i);
                        standardlog.setIsNewRecord(true);
                        standardlog.setId(IdGen.uuid());
                        standardlogService.save(standardlog);
                        userinfo.setPoint(point + i);
                        System.out.println("=================变化后的积分是"+userinfo.getPoint()+"================");
                        userinfoService.save(userinfo);
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }
        	}
        	
        }
    }

    /**
     * 积分扣除
     * @param userinfo
     * @param code
     * @param enename
     */
    @Transactional(readOnly = false)
    public int deletIntegrityPoint(Userinfo userinfo,String code,String enename,int deduct,IntegrityStandarditems tandardItems) {
    	
    	
        if (userinfo != null && userinfo.getId() != null ) {

    
        	IntegrityStandard isd = new IntegrityStandard();
        	System.out.println(code);
        	
        	System.out.println(enename);
        	isd.setMembertype(enename);
        	tandardItems.setStandard(isd);
        	tandardItems.setIntegritycode(code);
        	List<IntegrityStandarditems> itemlist=new ArrayList<IntegrityStandarditems>();
        	itemlist = standarditemsService.findList(tandardItems);
        	if(userinfo.getPoint()<deduct) {         //积分小于要兑换的积分，返回积分不足
        		return DataDic.RETURN_STATUS_MONEYBUG;
        	}
        	if(itemlist.size()>0){
        		tandardItems = itemlist.get(0);
        		IntegrityRecord rpd = new IntegrityRecord();  //用户积分
        		int integrity=0;
                rpd.setUser(userinfo.getUser());
                rpd.setStandarditems(tandardItems);
                try {
                	
                    //List<IntegrityRecord> recordlist = recordService.findList(rpd);   //积分记录
                    Integer point = userinfo.getPoint();   //用户当前积分
                    	rpd = new IntegrityRecord();  //用户积分
                    	// Integer i = deduct;   //变更的积分
                        rpd.setUser(userinfo.getUser());
                        rpd.setStandarditems(tandardItems);
                        rpd.setIntegral(deduct);
                        rpd.setIsNewRecord(true);
                        rpd.setId(IdGen.uuid());
                        recordService.save(rpd);

                        IntegrityStandardlog standardlog = new IntegrityStandardlog();
                        standardlog.setUser(userinfo.getUser());
                        standardlog.setStandarditems(tandardItems);
                        standardlog.setPointvalue(-deduct);
                        standardlog.setPointbefore(point);
                        standardlog.setPointafter(point - deduct);
                        standardlog.setIsNewRecord(true);
                        standardlog.setId(IdGen.uuid());
                        standardlogService.save(standardlog);
                        userinfo.setPoint(point - deduct);
                        System.out.println("=================变化后的积分是"+userinfo.getPoint()+"================");
                        userinfoService.save(userinfo);
                   // }
                    return DataDic.RETURN_STATUS_NORMAL;
                } catch (Exception e) {
                    e.printStackTrace();
                    return 0;
                }
        	}
        	
        }
		return 0;
    }
    
    /**
     * 获取当天登陆用户
     *
     * @return
     */
    public List<User> getLoginUsers() {
        List<UserStatistics> loginUsers = userStatisticsService.getLoginUsers();
        return loginUsers.stream().map(UserStatistics::getUser).collect(Collectors.toList());
    }
    /**
     * 获取当天没有登陆的用户DAYSWITHOUTLOGIN
     * @return
     */
    public Object getWithLoginUsers(){
    	List<UserStatistics> WithLoginUsers=userStatisticsService.getWithLoginUsers();
    	int daysWithout=0;
    	System.out.println("-----------------------------------------------");
    	System.out.println("====================定时任务开始====================");
    	System.out.println("-----------------------------------------------");
    	int a=0;
    	System.err.println(WithLoginUsers.size());
    	if(WithLoginUsers.size()>0) {
    		for(UserStatistics userStatistics:WithLoginUsers) {
    			
    			if(Tools.IsNullOrWhiteSpace(userStatistics.getDaysWithoutLogin())) {
    				userStatistics.setDaysWithoutLogin("0");
    			}
    			daysWithout= Integer.parseInt(userStatistics.getDaysWithoutLogin());
    			for(int i=1;i<13;i++) {
    				if((i*30)==daysWithout) {//每满30天就扣除一次积分
    					System.err.println("iiiii"+i);
    					//调用扣除积分方法
    					IntegrityStandarditems tandardItems=new IntegrityStandarditems();
    					tandardItems.setIntegritycode(DataDic.INTEGRITY_POINT_WITHLOGIN);
    					IntegrityStandard integrity=new IntegrityStandard();
    					if(Tools.IsNullOrWhiteSpace(userStatistics.getUser().getUserType())) {
    						integrity.setMembertype(DataDic.ROLE_CAROWNER);
    					}else {
    						integrity.setMembertype(userStatistics.getUser().getUserType());
    					}
    					tandardItems.setStandard(integrity);
    					List<IntegrityStandarditems>tandardItemslist=standarditemsService.getByName(tandardItems);
    					this.updateIntegrityRecord(userStatistics.getUserinfo(),tandardItemslist.get(0),-5);
    				}
    			}
        		daysWithout++;
        		userStatistics.setDaysWithoutLogin(Integer.toString(daysWithout));
        		int i= userStatisticsService.updateDaysWithoutLogin(userStatistics);
        	}
    	}
    	return null;
    }
    
    /**
     * 执行对象的方法
     *
     * @param owner
     * @param methodName
     * @param args
     * @return
     * @throws Exception
     */
    private Object invokeMethod(Object owner, String methodName, Object[] args) throws Exception {

        Class ownerClass = owner.getClass();
        Class[] argsClass = new Class[args.length];

        for (int i = 0, j = args.length; i < j; i++) {
            argsClass[i] = args[i].getClass();
        }
        Method method = ownerClass.getMethod(methodName, argsClass);
        return method.invoke(owner, args);
    }


    //--------------------------------------------------------积分日志--------------------------------------------------
    public Page<IntegrityStandardlog> findPage(Page<IntegrityStandardlog> page, IntegrityStandardlog integrityStandardlog) {
        return standardlogService.findPage(page, integrityStandardlog);
    }
    /**
     * 获取积分统计
     * @param integrityRecordVO
     * @return
     */
    public IntegrityRecordVO getSumPointvalueData(IntegrityRecordVO integrityRecordVO){
        IntegrityRecordVO iRecordVO = new IntegrityRecordVO();
        int totalValue = 0;//总获得
        int tradeValue = 0;//交易获得
        int shopValue = 0;//商城消费获得
        int otherValue = 0;//其他获得
        int consumeValue = 0;//消费
        IntegrityStandardlog standardlog = new IntegrityStandardlog();
        standardlog.setUser(integrityRecordVO.getUser());
        List<IntegrityStandardlog> islList =  standardlogService.findSumPointvalueData(standardlog);
        if(islList.size()>0){
            for (IntegrityStandardlog data:islList) {
                if ("线上支付结算".equals(data.getStandarditems().getScoreitem())||"线上业务交易".equals(data.getStandarditems().getScoreitem())
                        ||"业务积累".equals(data.getStandarditems().getScoreitem())){
                    tradeValue+=data.getPointvalue();
                }else if ("商城消费".equals(data.getStandarditems().getScoreitem())){
                    shopValue+=data.getPointvalue();
                }else if ("保证金充值".equals(data.getStandarditems().getScoreitem())||"资料完善".equals(data.getStandarditems().getScoreitem())
                        ||"平台登录".equals(data.getStandarditems().getScoreitem())||"好评记录".equals(data.getStandarditems().getScoreitem())){
                    otherValue+=data.getPointvalue();
                }else{
                    consumeValue+=data.getPointvalue();
                }
            }
            totalValue = tradeValue+shopValue+otherValue-consumeValue;
        }
        iRecordVO.setTradeValue(tradeValue);
        iRecordVO.setShopValue(shopValue);
        iRecordVO.setConsumeValue(consumeValue);
        iRecordVO.setOtherValue(otherValue);
        iRecordVO.setTotalValue(totalValue);
        return iRecordVO;
    }

    /**
     * 获取积分统计报表
     * @param integrityRecordVO
     * @return
     */
    public Page<IntegrityRecordVO>  findSumPointvalueList(Page<IntegrityRecordVO> page, IntegrityRecordVO integrityRecordVO){
        return standardlogService.findSumPointvalueList(page,integrityRecordVO);
    }
   
}
