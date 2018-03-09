package com.thinkgem.jeesite.modules.wlpt.webapi.exchange;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.SerializationConfig;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.PreciseCompute;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.exchange.PetrolExchangeBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCardRecord;
import com.thinkgem.jeesite.modules.wlpt.entity.exchange.UserPetrolExchange;
import com.thinkgem.jeesite.modules.wlpt.service.card.UserMetroCardRecordService;

/**
 * 油气兑换余额
 * @author Administrator
 *
 */
@Controller
@RequestMapping(value = "${frontPath}/wlpt/petrolexchange")
public class PetrolExchangeController extends BaseController{

	@Autowired
    private PetrolExchangeBiz petrolExchangeBiz; 
	
	@Autowired
    private UserMetroCardRecordService cardRecordService;
	
	/***
     * 去油气兑换余额列表页面
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = {"myPetrolExchangeList", ""})
    public String myPetrolExchangeList(UserPetrolExchange petrolexchange, HttpServletRequest request, HttpServletResponse response, Model model) {
    	User user= UserUtils.findUser(UserUtils.getUser());
    	if(user==null){
    		return "redirect:"+Global.getFrontPath()+"/login?login=login";
    	}
        if(!DataDic.YES.equals(user.getIsposuser())){
        	return "redirect:"+Global.getFrontPath()+"/wlpt/consume/toPurse";
        }
        model.addAttribute("user",user);
        model.addAttribute("petrolexchange", petrolexchange);
        //return "modules/wlpt_front/exchange/petrolexchange_list";
        return "modules/user_front/exchange/petrolexchange_list";
    }
    
    /***
     * 获取油气兑换余额申请数据
     *
     * @param petrolexchange
     * @param pageNo
     * @param pageSize
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = {"getPetrolExchangeList", ""})
    public Object getPetrolExchangeList(UserPetrolExchange petrolexchange, int pageNo, int pageSize, Model model) {
        Page pg = new Page();
        pg.setLength(8);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        //
        ////获取当前用户
        petrolexchange.setUser(UserUtils.getUser());

        Page<UserPetrolExchange> page = petrolExchangeBiz.findPage(pg, petrolexchange);
        for (UserPetrolExchange pe : page.getList()) {
        	pe.setStatusName(DictUtils.getDictLabel(pe.getStatus(), "exchange_status", ""));
        	pe.setInvoiceStatusName(DictUtils.getDictLabel(pe.getInvoiceStatus(), "invoice_status", ""));
        }
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }
    
    /***
     * 去油气兑换余额申请页面
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = {"toApplyPetrolExchange", ""})
    public String toApplyPetrolExchange(UserPetrolExchange petrolexchange, HttpServletRequest request, HttpServletResponse response, Model model) {
    	User user= UserUtils.findUser(UserUtils.getUser());
    	if(user==null){
    		return "redirect:"+Global.getFrontPath()+"/login?login=login";
    	}
    	UserMetroCardRecord cardRecord = new UserMetroCardRecord();
/*    	cardRecord.setStatus("0");
        cardRecord.setWay("2");
        if(user!=null && DataDic.YES.equals(user.getIsposuser())){
        	cardRecord.setPosuser(user.getId());
        	Page<UserMetroCardRecord> page = cardRecordService.finditemList(new Page<UserMetroCardRecord>(), cardRecord);
        	
        	if(page != null && page.getList().size()>0){
        		double totalpaid = 0.0;
        		for (UserMetroCardRecord item : page.getList()) {
        			totalpaid += Double.parseDouble(item.getTotalpaid());
				}
        		List<UserMetroCardRecord> recordList = page.getList();
        		model.addAttribute("addValueTotalpaid", PreciseCompute.round(totalpaid,2));
        		model.addAttribute("addvaluecardRecordList",recordList);
        	}
        	
        }*/
    	
    	
        model.addAttribute("user",user);
        model.addAttribute("petrolexchange", petrolexchange);
        //return "modules/wlpt_front/exchange/petrolexchange_add";
        return "modules/user_front/exchange/petrolexchange_add";
    }
    
    /***
     * 去油气兑换余额详情页面
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = {"toPetrolExchangeInfo", ""})
    public String toPetrolExchangeInfo(UserPetrolExchange petrolexchange, HttpServletRequest request, HttpServletResponse response, Model model) {
    	User user= UserUtils.findUser(UserUtils.getUser());
    	if(user==null){
    		return "redirect:"+Global.getFrontPath()+"/login?login=login";
    	}
    	petrolexchange = petrolExchangeBiz.get(petrolexchange.getId());
        model.addAttribute("user",user);
        model.addAttribute("petrolexchange", petrolexchange);
        //return "modules/wlpt_front/exchange/petrolexchange_info";
        return "modules/user_front/exchange/petrolexchange_info";
    }
    
    /**
     * 列表
     *
     * @param cardRecord
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getmcrList")
    public Object getmcrList( UserMetroCardRecord cardRecord, Model model) {
        Page<UserMetroCardRecord> pg = new Page<>();
        pg.setPageNo(1);
        pg.setPageSize(Integer.MAX_VALUE);
        cardRecord.setStatus("0");
        cardRecord.setWay("1");
    ////获取当前用户
        User user = UserUtils.getUser();
        if(user!=null && DataDic.YES.equals(user.getIsposuser())){
        	cardRecord.setPosuser(user.getId());
        }else{
        	model.addAttribute("page", pg);
            return new JSONPObject("callback", pg);
        }
        Page<UserMetroCardRecord> page = cardRecordService.finditemList(pg, cardRecord);
        /*for (UserMetroCardRecord b : page.getList()) {
            b.setStatus(DictUtils.getDictLabel(b.getStatus(), "card_status", ""));
        }*/
        model.addAttribute("page", page);
        return new JSONPObject("callback", page.getList());
    }
    
    /**
     * 列表
     *
     * @param cardRecord
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "getmcrListByNo")
    public Object getmcrListByNo( UserPetrolExchange userPetrolExchange, Model model) {
        Page<UserMetroCardRecord> pg = new Page<>();
        pg.setList(petrolExchangeBiz.getPetrolExchangeRecordInfo(userPetrolExchange.getExchangeNo()));
        
        model.addAttribute("page", pg);
        return new JSONPObject("callback", pg);
    }

    
    /**
     * 修改开票状态
     *
     * @param petrolexchange
     * @param request
     * @param response
     * @return
     * @throws IOException
     */
    @ResponseBody
    @RequestMapping(value = "editInvoiceStatus")
    public Object editInvoiceStatus(UserPetrolExchange petrolexchange, HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user = UserUtils.getUser(true);
        String result;
        if (user != null && user.getId() != null&&DataDic.AUTHENSUCCES.equals(user.getUserinfo().getStatus())) {
        	int state = petrolExchangeBiz.editInvoiceStatus(petrolexchange.getId(),petrolexchange.getInvoiceStatus());
        	if(state==1){
        		 result = "1";
        	}else{
        		 result = "0";
        	}
           
        } else {
            result = "0";
        }
        return new JSONPObject("callback", result);
    }
    /**
     * 保存申请
     *
     * @param petrolexchange
     * @param request
     * @param response
     * @return
     * @throws IOException
     */
    @ResponseBody
    @RequestMapping(value = "petrolexchangeSave", produces = "application/json", method = RequestMethod.POST)
    public Object petrolexchangeSave(UserPetrolExchange petrolexchange, HttpServletRequest request, HttpServletResponse response) throws IOException {
        User user = UserUtils.getUser(true);
        String result;
        if (user != null && user.getId() != null&&DataDic.AUTHENSUCCES.equals(user.getUserinfo().getStatus())) {
            ObjectMapper mapper = new ObjectMapper();
            mapper.setDateFormat(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
            mapper.disable(DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES);
            mapper.configure(SerializationConfig.Feature.FAIL_ON_EMPTY_BEANS, false);
            String cardRecordListStr = request.getParameter("cardRecordList");
            if (cardRecordListStr != null && StringUtils.isNotEmpty(cardRecordListStr)) {
                List<UserMetroCardRecord> cardrecordlist = Arrays.asList(mapper.readValue(cardRecordListStr, UserMetroCardRecord[].class));
                petrolexchange.setCardRecordList(cardrecordlist);
                petrolexchange.setUser(user);
                if(petrolexchange.getAddvaluecardRecordList().size()>0){
                	cardrecordlist.addAll(petrolexchange.getAddvaluecardRecordList());
                }
                
                petrolExchangeBiz.petrolexchangeSave(petrolexchange);
                //biddingBiz.publishBid(bidinfo);
            }
            result = "1";
        } else {
            result = "0";
        }
        return new JSONPObject("callback", result);
    }
    
}
