package com.thinkgem.jeesite.modules.wlpt.webapi.consume;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.AccountUtils;
import com.thinkgem.jeesite.common.utils.BaiduLBSUtil;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.PageData;
import com.thinkgem.jeesite.common.utils.PreciseCompute;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.CarSyncService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.biz.IntegrityBiz.IntegrityBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;

import com.thinkgem.jeesite.modules.wlpt.biz.userBiz.UserBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.car.GpsCarLocs;
import com.thinkgem.jeesite.modules.wlpt.biz.metrocardBiz.UserMetroPosBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCardRecord;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroCardRecorditem;
import com.thinkgem.jeesite.modules.wlpt.entity.card.UserMetroPos;

import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumerecod;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserBankinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.UserPurse;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.UserMetroCardRecordVO;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.UserMetroCardRecorditemVO;
import com.thinkgem.jeesite.modules.wlpt.service.card.UserMetroCardRecordService;
import com.thinkgem.jeesite.modules.wlpt.service.card.UserMetroCardRecorditemService;
import com.thinkgem.jeesite.modules.wlpt.service.card.UserMetroPosService;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.codehaus.jackson.map.util.JSONPObject;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by ForHeart on 16/8/18.
 * 用户交易流水记录信息
 */

@Controller
@RequestMapping(value = "${frontPath}/wlpt/consume")
public class ConsumeController extends BaseController {
    @Autowired
    private ConsumeRecodBiz consumeRecodBiz;
    @Autowired
    private UserBiz userBiz;
    @Autowired
    private IntegrityBiz integrityBiz;
    @Autowired
    private UserMetroPosBiz userMetroPosBiz;
    @Autowired
    private UserMetroCardRecordService userMetroCardRecordService;

    /***
     * 财务中心首页
     * @param consumerecod
     * @param model
     * @return
     */
    @RequestMapping(value = "index")
    public String index(Consumerecod consumerecod, Model model) {

        //User user = UserUtils.findUser(UserUtils.getUser());

        //model.addAttribute("user", user);
        return "modules/user_front/account/user_info";
    }

    /***
     * 油气转账
     *
     * @param consumerecod
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "transferPetro")
    public Object transferPetro(Consumerecod consumerecod, Model model) {
        Map<String, Object> map = new HashMap<String, Object>();
        Map<String, Object> result = new HashMap<String, Object>();
        int status = DataDic.RETURN_STATUS_NORMAL;
        String message = "请求成功";
        User target = UserUtils.findUser(consumerecod.getTarget());
        if (target == null || UserUtils.getUser().getId() == null) {
            map.put("status", DataDic.RETURN_STATUS_INFOBUG);
            map.put("message", "用户不存在");
            return map;
        }
        if (target.getRole().getEnname().equals(DataDic.ROLE_ENTERPRISE) ||
                target.getRole().getEnname().equals(DataDic.ROLE_CAROWNER) ||
                target.getRole().getEnname().equals(DataDic.ROLE_GOODSOWNER) ||
                target.getRole().getEnname().equals(DataDic.ROLE_SYSTEMACCOUNT)) {
            String accountid = UserUtils.getUser().getId();
            String targetid = target.getId();
            double consumemony = Double.parseDouble(consumerecod.getConsumemony());
            result = (Map<String, Object>)consumeRecodBiz.transferPetroAppBiz(accountid, consumemony, targetid);
            status = (int) result.get("state");
            message = (String) result.get("message");
        }
        map.put("state", status);
        map.put("message", message);
        return map;
    }

    /**
     * 去油气转账页面
     *
     * @param consumerecod
     * @return
     */
    @RequestMapping(value = "toTransferPetro")
    public String toTransferPetro(Consumerecod consumerecod, Model model) {

        User user = UserUtils.findUser(UserUtils.getUser());
        if (user.getRole().getEnname().equals(DataDic.ROLE_ENTERPRISE) ||
                user.getRole().getEnname().equals(DataDic.ROLE_CAROWNER) ||
                user.getRole().getEnname().equals(DataDic.ROLE_GOODSOWNER)
                || user.getRole().getEnname().equals(DataDic.ROLE_SYSTEMACCOUNT)) {
            model.addAttribute("user", user);
            return "modules/wlpt_front/consume/transfer_petro";
        } else {
            model.addAttribute("flag", "flag");
            model.addAttribute("user", UserUtils.findUser(UserUtils.getUser()));
            model.addAttribute("consumerecod", consumerecod);
            return "modules/wlpt_front/consume/consume_list";
        }

    }

    /***
     * 卓币转账
     *
     * @param consumerecod
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "transferCoin")
    public Object transferCoin(Consumerecod consumerecod, Model model) {
        User target = UserUtils.findUser(consumerecod.getTarget());
        if (target == null || UserUtils.getUser().getId() == null) {
            return new JSONPObject("callback", DataDic.RETURN_STATUS_INFOBUG);
        }
        if (target.getRole().getEnname().equals(DataDic.ROLE_ENTERPRISE) ||
                target.getRole().getEnname().equals(DataDic.ROLE_CAROWNER) ||
                target.getRole().getEnname().equals(DataDic.ROLE_GOODSOWNER) ||
                target.getRole().getEnname().equals(DataDic.ROLE_SYSTEMACCOUNT)) {
            String accountid = UserUtils.getUser().getId();
            String targetid = target.getId();
            double consumemony = Double.parseDouble(consumerecod.getConsumemony());
            int result = consumeRecodBiz.transferCoinBiz(accountid, consumemony, targetid);
            return new JSONPObject("callback", result);
        } else {
            return new JSONPObject("callback", 3);
        }
    }

    /**
     * 去转账页面
     *
     * @param consumerecod
     * @return
     */
    @RequestMapping(value = "toTransferCoin")
    public String toTransferCoin(Consumerecod consumerecod, Model model) {

        User user = UserUtils.findUser(UserUtils.getUser());
        if (user.getRole().getEnname().equals(DataDic.ROLE_ENTERPRISE) ||
                user.getRole().getEnname().equals(DataDic.ROLE_CAROWNER) ||
                user.getRole().getEnname().equals(DataDic.ROLE_GOODSOWNER)
                || user.getRole().getEnname().equals(DataDic.ROLE_SYSTEMACCOUNT)) {
            model.addAttribute("user", user);
            return "modules/wlpt_front/consume/transfer_coin";
        } else {
            model.addAttribute("flag", "flag");
            model.addAttribute("user", UserUtils.findUser(UserUtils.getUser()));
            model.addAttribute("consumerecod", consumerecod);
            return "modules/wlpt_front/consume/consume_list";
        }

    }

    /**
     * 导出用户数据
     *
     * @param consumerecod
     * @param request
     * @param response
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "export", method = RequestMethod.POST)
    public Object exportFile(Consumerecod consumerecod, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {

        try {
            consumerecod.setAccount(UserUtils.getUser());
            consumerecod.setIssysrecode(DataDic.ISSYSRECODE_NO);
            String fileName = "财务数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
            List<Consumerecod> list = consumeRecodBiz.findList(consumerecod);
            new ExportExcel("财务数据", Consumerecod.class).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception e) {
            addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
        }
        return "redirect:" + frontPath + "/wlpt/consume/toPurse?repage";
    }


    /***
     * 去钱包账户页面
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = {"toPurse", ""})
    public String consumeList(Consumerecod consumerecod, HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("user", UserUtils.findUser(UserUtils.getUser()));
        model.addAttribute("consumerecod", consumerecod);
        //return "modules/wlpt_front/consume/consume_list";
        return "modules/user_front/finance/index";
    }

    /***
     * 去我的账单页面
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = {"toConsumeRecord", ""})
    public String consumeRecordList(Consumerecod consumerecod, HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("user", UserUtils.findUser(UserUtils.getUser()));
        model.addAttribute("consumerecod", consumerecod);
        return "modules/wlpt_front/consume/consumerecord_list";
    }

    /***
     * 交易流水
     * @param consumerecod
     * @param pageNo
     * @param pageSize
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = {"getRecodeList", ""})
    public Object getRecodeList(Consumerecod consumerecod, int pageNo, int pageSize, Model model) {
        Page pg = new Page();
        pg.setLength(4);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        //
        ////获取当前用户
        consumerecod.setAccount(UserUtils.getUser());

        // 查询用户交易流水--除去系统记录
        consumerecod.setIssysrecode(DataDic.ISSYSRECODE_NO);

        Page<Consumerecod> page = consumeRecodBiz.findPage(pg, consumerecod);
        for (Consumerecod var : page.getList()) {
            // gds.setGsoddtype(DictUtils.getDictLabel(gds.getGsoddtype(), "gsoddtype", ""));
            var.setConsumetype(DictUtils.getDictLabel(var.getConsumetype(), "consumerecode_type", null));
            var.setConsumeway(DictUtils.getDictLabel(var.getConsumeway(), "consumerecode_way", null));
            var.setConsumestatus(DictUtils.getDictLabel(var.getConsumestatus(), "consume_status", null));
        }
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }

    /***
     * 去我的pos机页面
     *
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = {"myMetroPosList", ""})
    public String myMetroPosList(UserMetroPos metroPos, HttpServletRequest request, HttpServletResponse response, Model model) {
        User user = UserUtils.findUser(UserUtils.getUser());
        if (user == null) {
            return "redirect:" + Global.getFrontPath() + "/login?login=login";
        } else if (user != null && !user.getIsposuser().equals("1")) {
            return "redirect:" + Global.getFrontPath() + "/wlpt/consume/toPurse/?repage";
        }

        model.addAttribute("user", user);
        model.addAttribute("metroPos", metroPos);
        return "modules/wlpt_front/consume/metropos_list";
    }

    /***
     * 我的pos机列表数据
     *
     * @param metroPos
     * @param pageNo
     * @param pageSize
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = {"getMetroPosList", ""})
    public Object getMetroPosList(UserMetroPos metroPos, int pageNo, int pageSize, Model model) {
        Page pg = new Page();
        pg.setLength(8);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        //
        ////获取当前用户
        metroPos.setUser(UserUtils.getUser());

        Page<UserMetroPos> page = userMetroPosBiz.findPage(pg, metroPos);

        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }

    /***
     * 去油气消费记录页面
     * @param request
     * @param response
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @RequestMapping(value = {"toPetrolconsumeList", ""})
    public String PetrolconsumeList(UserMetroCardRecord userMetroCardRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
        model.addAttribute("user", UserUtils.findUser(UserUtils.getUser()));
        model.addAttribute("userMetroCardRecord", userMetroCardRecord);
        //return "modules/wlpt_front/consume/petrolconsume_list";
        return "modules/user_front/finance/post_list";
    }

    /***
     * 我的油气消费记录数据
     *
     * @param userMetroCardRecord
     * @param pageNo
     * @param pageSize
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = {"getPetrolconsumeList", ""})
    public Object getPetrolconsumeList(UserMetroCardRecord userMetroCardRecord, int pageNo, int pageSize, Model model) {
        Page pg = new Page();
        pg.setLength(8);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        //
        ////获取当前用户
        User user = UserUtils.getUser();
        if (user != null && DataDic.YES.equals(user.getIsposuser())) {
            userMetroCardRecord.setPosuser(user.getId());
        } else {
            userMetroCardRecord.setPosuser("");
            userMetroCardRecord.setUser(user);
        }
        Page<UserMetroCardRecord> page = userMetroCardRecordService.finditemList(pg, userMetroCardRecord);

        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }

    /**
     * 导出用户数据
     *
     * @param recordVO
     * @param request
     * @param response
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "petrolexport", method = RequestMethod.POST)
    public Object petrolexport(UserMetroCardRecordVO recordVO, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {

        try {
            User user = UserUtils.getUser();
            if (user != null && DataDic.YES.equals(user.getIsposuser())) {
                recordVO.setPosuser(user.getId());
            } else {
                recordVO.setPosuser("");
                recordVO.setUser(user);
            }
            String fileName = "一卡通消费记录数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
            List<UserMetroCardRecordVO> list = userMetroCardRecordService.finditembyexportList(recordVO);

            new ExportExcel("一卡通消费记录数据", UserMetroCardRecordVO.class).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            addMessage(redirectAttributes, "导出一卡通消费记录数据失败！失败信息：" + e.getMessage());
        }
        return "redirect:" + frontPath + "/wlpt/consume/toPetrolconsumeList?repage";
    }

    /***
     * 油气兑换余额
     *
     * @param consumerecod
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "exchangePetro")
    public Object exchangePetro(Consumerecod consumerecod, Double coinnum, Model model) {


        User user = UserUtils.findUser(UserUtils.getUser());
        if (user == null || UserUtils.getUser().getId() == null) {
            return new JSONPObject("callback", DataDic.RETURN_STATUS_INFOBUG);
        }
        //不能小于等于0元
        if (coinnum <= 0) {
            return new JSONPObject("callback", DataDic.RETURN_STATUS_RECHARGEBUG);
        }
        double consumemony = Double.parseDouble(consumerecod.getConsumemony());
        //账户可用油气余额是否足够
        if (user.getUserPurse() == null || user.getUserPurse().getPetrolbalance() < consumemony) {
            return new JSONPObject("callback", DataDic.RETURN_STATUS_MONEYBUG);
        }
        String accountid = user.getId();
        int result = consumeRecodBiz.exchangePetroBiz(accountid, consumemony, coinnum);
        return new JSONPObject("callback", result);

    }

    /**
     * 去油气兑换余额页面
     *
     * @param consumerecod
     * @return
     */
    @RequestMapping(value = "toExchangePetro")
    public String toExchangePetro(Consumerecod consumerecod, Model model) {

        User user = UserUtils.findUser(UserUtils.getUser());
        if (user.getUserPurse() == null) {
            user.setUserPurse(new UserPurse());
        }
        UserPurse up = user.getUserPurse();
        up.setWebbalance(PreciseCompute.round(up.getWebbalance(), 2));
        up.setAvailablebalance(PreciseCompute.round(up.getAvailablebalance(), 2));
        up.setPetrolbalance(PreciseCompute.round(up.getPetrolbalance(), 2));
        user.setUserPurse(up);
        model.addAttribute("user", user);
        return "modules/wlpt_front/consume/petro_exchange";

    }

    /***
     * 个人中心财务交易流水
     * @param consumerecod
     * @param pageNo
     * @param pageSize
     * @param model
     * @return
     */
    @ResponseBody
    @RequestMapping(value = {"personalGetRecodeList", ""})
    public Object personalGetRecodeList(Consumerecod consumerecod, int pageNo, int pageSize, Model model) {
        Page pg = new Page();
        pg.setLength(4);
        pg.setPageNo(pageNo);
        pg.setPageSize(pageSize);
        //
        ////获取当前用户
        consumerecod.setAccount(UserUtils.getUser());

        // 查询用户交易流水--除去系统记录
        consumerecod.setIssysrecode(DataDic.ISSYSRECODE_NO);

        Page<Consumerecod> page = consumeRecodBiz.findPage(pg, consumerecod);
        for (Consumerecod var : page.getList()) {
            // gds.setGsoddtype(DictUtils.getDictLabel(gds.getGsoddtype(), "gsoddtype", ""));
            var.setConsumetype(DictUtils.getDictLabel(var.getConsumetype(), "consumerecode_type", null));
            var.setConsumeway(DictUtils.getDictLabel(var.getConsumeway(), "consumerecode_way", null));
            var.setConsumestatus(DictUtils.getDictLabel(var.getConsumestatus(), "consume_status", null));
        }
        model.addAttribute("page", page);
        return new JSONPObject("callback", page);
    }

    /**
     * 个人中心首页财务导出用户交易数据
     *
     * @param consumerecod
     * @param request
     * @param response
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "personalExport")
    public Object personalExportFile(Consumerecod consumerecod, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {

        try {
            consumerecod.setAccount(UserUtils.getUser());
            consumerecod.setIssysrecode(DataDic.ISSYSRECODE_NO);
            String fileName = "财务数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
            List<Consumerecod> list = consumeRecodBiz.findList(consumerecod);
            new ExportExcel("财务数据", Consumerecod.class).setDataList(list).write(response, fileName).dispose();
            return null;
        } catch (Exception e) {
            addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
        }
        return null;
    }

    /**
     * 去转账页面
     *
     * @param consumerecod
     * @return
     */
    @RequestMapping(value = "toTransfer")
    public String toTransfer(Consumerecod consumerecod, Model model) {
        User user = UserUtils.findUser(UserUtils.getUser());
        if (user.getRole().getEnname().equals(DataDic.ROLE_ENTERPRISE) ||
                user.getRole().getEnname().equals(DataDic.ROLE_CAROWNER) ||
                user.getRole().getEnname().equals(DataDic.ROLE_GOODSOWNER)
                || user.getRole().getEnname().equals(DataDic.ROLE_SYSTEMACCOUNT)) {
            model.addAttribute("user", user);
            //return "modules/wlpt_front/consume/transfer";
            return "modules/user_front/finance/transfer_balance";
        } else {
            model.addAttribute("flag", "flag");
            model.addAttribute("user", UserUtils.findUser(UserUtils.getUser()));
            model.addAttribute("consumerecod", consumerecod);
            //return "modules/wlpt_front/consume/consume_list";
            return "modules/user_front/finance/index";

        }

    }

    /**
     * 转账
     *
     * @param consumerecod
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "transfer")
    public Object transfer(Consumerecod consumerecod, String payway, Model model) {
        User target = UserUtils.findUser(consumerecod.getTarget());
        if (target == null || UserUtils.getUser().getId() == null) {
            return new JSONPObject("callback", DataDic.RETURN_STATUS_INFOBUG);
        }
        if (UserUtils.getUser().getRole().getEnname().equals(DataDic.ROLE_ENTERPRISE) ||
                UserUtils.getUser().getRole().getEnname().equals(DataDic.ROLE_CAROWNER) ||
                UserUtils.getUser().getRole().getEnname().equals(DataDic.ROLE_GOODSOWNER) ||
                UserUtils.getUser().getRole().getEnname().equals(DataDic.ROLE_SYSTEMACCOUNT)) {
            String accountid = UserUtils.getUser().getId();
            String targetid = target.getId();
            double consumemony = Double.parseDouble(consumerecod.getConsumemony());
            int result = consumeRecodBiz.transferBiz(accountid, consumemony, targetid, payway);
            return new JSONPObject("callback", result);
        } else {
            return new JSONPObject("callback", 3);
        }

    }

    /**
     * 去卓币充值页面
     *
     * @param consumerecod
     * @return
     */
    @RequestMapping(value = "toCoinRecharge")
    public String toCoinRecharge(Consumerecod consumerecod, Model model) {
        User user = UserUtils.findUser(UserUtils.getUser());
        if (user.getUserPurse() == null) {
            user.setUserPurse(new UserPurse());
        }
        UserPurse up = user.getUserPurse();
        up.setWebbalance(PreciseCompute.round(up.getWebbalance(), 2));
        up.setAvailablebalance(PreciseCompute.round(up.getAvailablebalance(), 2));
        up.setAvailablecoin(PreciseCompute.round(up.getAvailablecoin(), 2));
        up.setPetrolbalance(PreciseCompute.round(up.getPetrolbalance(), 2));
        user.setUserPurse(up);
        model.addAttribute("user", user);
        return "modules/wlpt_front/consume/coin_recharge";
    }

    /**
     * 卓币充值
     *
     * @param consumerecod
     * @param coinnum
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "coinRecharge")
    public Object coinRecharge(Consumerecod consumerecod, double coinnum, Model model) {
        User user = UserUtils.findUser(UserUtils.getUser());
        if (user == null || UserUtils.getUser().getId() == null) {
            return new JSONPObject("callback", DataDic.RETURN_STATUS_INFOBUG);
        }
        //至少充值一卓币
        if (coinnum < 1) {
            return new JSONPObject("callback", DataDic.RETURN_STATUS_RECHARGEBUG);
        }
        double consumemony = Double.parseDouble(consumerecod.getConsumemony());
        //账户可用余额是否足够
        if (user.getUserPurse() == null || user.getUserPurse().getAvailablebalance() < consumemony) {
            return new JSONPObject("callback", DataDic.RETURN_STATUS_MONEYBUG);
        }

        int result = consumeRecodBiz.rechargeCoinBiz(UserUtils.getUser().getId(), consumemony, coinnum, consumerecod.getConsumeway());
        return new JSONPObject("callback", result);
    }


    /**
     * 去油气充值页面
     *
     * @param consumerecod
     * @return
     */
    @RequestMapping(value = "toPetroRecharge")
    public String toPetroRecharge(Consumerecod consumerecod, Model model) {
        User user = UserUtils.findUser(UserUtils.getUser());
        if (user.getUserPurse() == null) {
            user.setUserPurse(new UserPurse());
        }
        UserPurse up = user.getUserPurse();
        up.setWebbalance(PreciseCompute.round(up.getWebbalance(), 2));
        up.setAvailablebalance(PreciseCompute.round(up.getAvailablebalance(), 2));
        up.setAvailablecoin(PreciseCompute.round(up.getAvailablecoin(), 2));
        up.setPetrolbalance(PreciseCompute.round(up.getPetrolbalance(), 2));
        user.setUserPurse(up);
        model.addAttribute("user", user);
        return "modules/wlpt_front/consume/petro_recharge";
    }

    /**
     * 油气充值
     *
     * @param consumerecod
     * @param coinnum
     * @param paytype
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "petroRecharge")
    public Object petroRecharge(Consumerecod consumerecod, Double coinnum, String paytype, Model model) {
        User user = UserUtils.findUser(UserUtils.getUser());
        int result = 0;
        if (user == null || UserUtils.getUser().getId() == null) {
            return new JSONPObject("callback", DataDic.RETURN_STATUS_INFOBUG);
        }
        //至少消费一卓币
        if (coinnum < 1) {
            return new JSONPObject("callback", DataDic.RETURN_STATUS_RECHARGEBUG);
        }
        Double consumemony = Double.parseDouble(consumerecod.getConsumemony());
        if (!Tools.IsNullOrWhiteSpace(paytype) && DataDic.CONSUMERECODE_WAY_COIN.equals(paytype)) {//卓币支付
            //账户可用卓币余额是否足够
            if (user.getUserPurse() == null || user.getUserPurse().getAvailablecoin() < consumemony) {
                return new JSONPObject("callback", DataDic.RETURN_STATUS_MONEYBUG);
            }
        } else {
            //账户可用余额是否足够
            if (user.getUserPurse() == null || user.getUserPurse().getAvailablebalance() < consumemony) {
                return new JSONPObject("callback", DataDic.RETURN_STATUS_MONEYBUG);
            }
        }
        result = consumeRecodBiz.rechargePetroBiz(UserUtils.getUser().getId(), consumemony, coinnum, paytype,null);

        return new JSONPObject("callback", result);
    }

    /**
     * 去保证金充值页面
     *
     * @param consumerecod
     * @return
     */
    @RequestMapping(value = "toGueanRecharge")
    public String toGueanRecharge(Consumerecod consumerecod, Model model) {
        User user = UserUtils.findUser(UserUtils.getUser());
        if (user.getUserPurse() == null) {
            user.setUserPurse(new UserPurse());
        }
        UserPurse up = user.getUserPurse();
        up.setWebbalance(PreciseCompute.round(up.getWebbalance(), 2));
        up.setAvailablebalance(PreciseCompute.round(up.getAvailablebalance(), 2));
        up.setGuaranteemone(PreciseCompute.round(up.getGuaranteemone(), 2));
        user.setUserPurse(up);
        model.addAttribute("user", user);
        return "modules/wlpt_front/consume/guean_recharge";
    }

    /**
     * 保证金充值
     *
     * @param consumerecod
     * @param model
     * @return
     */
    @RequiresPermissions("user")
    @ResponseBody
    @RequestMapping(value = "gueanRecharge")
    public Object gueanRecharge(Consumerecod consumerecod, Model model) {
        User user = UserUtils.findUser(UserUtils.getUser());
        if (user == null || UserUtils.getUser().getId() == null) {
            return new JSONPObject("callback", DataDic.RETURN_STATUS_INFOBUG);
        }
        double consumemony = Double.parseDouble(consumerecod.getConsumemony());
        //账户可用余额是否足够
        if (user.getUserPurse() == null || user.getUserPurse().getAvailablebalance() < consumemony) {
            return new JSONPObject("callback", DataDic.RETURN_STATUS_MONEYBUG);
        }

        Consumerecod consum = new Consumerecod();
        consum.setTarget(user);
        consum.setConsumetype(DataDic.CONSUMERECODE_TYPE_GUNERECHAGE);
        List<Consumerecod> conlist = consumeRecodBiz.findList(consum);//查询是否第一次
        if (conlist.size() == 0) {
            integrityBiz.updateIntegrityPoint(user.getUserinfo(), DataDic.INTEGRITY_POINT_GUARANTEEMONE, user.getRole().getEnname());//更新诚信积分
        }
        int result = consumeRecodBiz.rechargeGueanBiz(UserUtils.getUser().getId(), consumemony);
        return new JSONPObject("callback", result);
    }

    /**
     * 去账户充值页面
     *
     * @param
     * @return
     */
    @RequestMapping(value = "toAccountRecharge")
    public String toAccountRecharge(Model model) {
        User user = UserUtils.findUser(UserUtils.getUser());
        model.addAttribute("user", user);
        return "modules/wlpt_front/consume/account_recharge";
    }

    /**
     * 刷新钱包
     *
     * @param
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "flushWeb")
    public Object flushWeb(UserPurse userPurse, Model model) {
        int result = consumeRecodBiz.flushWeb(userPurse);
        return new JSONPObject("callback", result);
    }

    /**
     * 去提现页面
     *
     * @param
     * @return
     */
    @RequestMapping(value = "toCash")
    public String toCash(Model model) {
        User user = UserUtils.findUser(UserUtils.getUser());
        UserBankinfo userBankinfo = new UserBankinfo();
        userBankinfo.setUser(user);
        List<UserBankinfo> userBankList = userBiz.findUserBankList(userBankinfo);
        for (UserBankinfo u : userBankList) {
            u.setBankcard(u.getBankcard().substring(0, 4) + " **** **** " + u.getBankcard().substring(u.getBankcard().length() - 4, u.getBankcard().length()));
        }
        model.addAttribute("userBankList", userBankList);
        model.addAttribute("user", user);
       // return "modules/wlpt_front/consume/account_cash";
        return "modules/user_front/finance/cash_balance";
    }

    /**
     * 申请提现
     *
     * @param passWord
     * @param cashMoney
     * @param bankid
     * @param passWord
     * @param cashMoney
     * @param payway
     * @return
     */
    @ResponseBody
    @RequestMapping(value = {"accountCash", ""})
    public Object accountCash(String bankid, String passWord, String cashMoney, String payway) {
        Map<String, Object> map = new HashMap<String, Object>();
        int state = DataDic.RETURN_STATUS_NORMAL;
        String message = "";

        UserBankinfo userbank = userBiz.getBankById(bankid);

        if (passWord == null || cashMoney == null) {
            state = DataDic.RETURN_STATUS_AUTHBUG;
            message = "信息缺失";
        }
        if (UserUtils.getUser().getId() == null) {
            state = DataDic.RETURN_STATUS_AUTHBUG;
            message = "登陆失效,请重新登陆";
        }
        if (userbank == null) {
            state = DataDic.RETURN_STATUS_AUTHBUG;
            message = "请先去绑定银行卡信息";
        }
        if (state == DataDic.RETURN_STATUS_NORMAL) {

            Consumerecod accountCode = new Consumerecod();
            accountCode.setCashpassword(passWord);
            accountCode.setConsumemony(cashMoney);
            accountCode.setUserBankinfo(userbank);
            accountCode.setConsumeway(payway);
            state = consumeRecodBiz.chashConsumeCodesBiz(accountCode);
            if (state == 2) {
                message = "信息缺失";
            } else if (state == 4) {
                message = "提现密码错误";
            } else if (state == 5) {
                message = "您的账户余额不足";
            } else if (state == 8) {
                message = "提现金额大于单笔交易最高限额";
            } else if (state == 10) {
                message = "电子钱包最低留存额度不足";
            } else if (state == 11) {
                message = "提现金额大于单日交易最高限额";
            } else if (state == 12) {
                message = "提现金额大于单日累计提现限额";
            } else if (state == -1) {
                message = "账户系统异常";
            } else if (state == 7) {
                message = "操作频繁";
            }
        }
        map.put("state", state);
        map.put("message", message);
        return map;
    }

    /**
     * 查询虚拟子账户列表
     *
     * @param memberId
     * @param status
     * @return
     */
    @ResponseBody
    @RequestMapping(value = {"virtAcctList", ""})
    public Object virtAcctList(@RequestParam(required = false) String memberId, @RequestParam(required = false) String status) {
        AccountUtils utils = new AccountUtils();
        return utils.virtAcctList(memberId, status);
    }
}
