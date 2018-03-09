/**
 * 
 */
package com.thinkgem.jeesite.modules.wlpt.web.consume;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.wlpt.entity.vo.*;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.DataDic;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.Tools;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.AccountBiz;
import com.thinkgem.jeesite.modules.wlpt.biz.consumeBiz.ConsumeRecodBiz;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.AccountAmount;
import com.thinkgem.jeesite.modules.wlpt.entity.consume.Consumerecod;
import com.thinkgem.jeesite.modules.wlpt.entity.trade.Orderinfo;
import com.thinkgem.jeesite.modules.wlpt.entity.user.Account;
import com.thinkgem.jeesite.modules.wlpt.service.consume.ConsumerecodService;

/**
 * 用户账户信息表Controller
 * 
 * @author lijintao
 * @version 2016-08-27
 */
@Controller
@RequestMapping(value = "${adminPath}/wlpt/consume/useraccount")
public class UserAccountController extends BaseController {

	@Autowired
	private ConsumerecodService consumerecodService;
	@Autowired
	private SystemService systemService;
	@Autowired
	private AccountBiz accountBiz;
	@ModelAttribute
	public Account get(@RequestParam(required = false) String id) {
		Account entity = null;
		if (StringUtils.isNotBlank(id)) {
		}
		if (entity == null) {
			entity = new Account();
		}
		return entity;
	}

	/**
	 * 钱包管理-用户所有交易类型统计列表
	 * 
	 * @param account
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("wlpt:consume:useraccount:list")
	@RequestMapping(value = { "list", "" })
	public String list(Account account, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Account> page = consumerecodService.findUserAccount(new Page<Account>(request, response), account);
		model.addAttribute("page", page);
		return "modules/wlpt/consume/useracountManage";
	}

	/**
	 * 卓币报表
	 * @param coinVO 卓币报表对象
	 * @param request
	 * @param response
	 * @param model
     * @return
     */
	@RequestMapping(value = { "coinVo", "" })
	public String coinVoList(Account coinVO, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Account> page = consumerecodService.findUserAccount(new Page<Account>(request, response), coinVO);
		model.addAttribute("page", page);
		return "modules/wlpt/report/accountCoinList";
	}

	/**
	 * 卓币管理-统计导出
	 *
	 * @param coinVO
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "coinVoExport", method = RequestMethod.POST)
	public String coinVoExport(Account coinVO , HttpServletRequest request, HttpServletResponse response,
								RedirectAttributes redirectAttributes) {
		try {
			String fileName = "卓币报表信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Account> page = consumerecodService.findUserAccount(new Page<Account>(), coinVO);

			List<Account> list = page.getList();

			List<CoinVO> accountBalanceVOs = new ArrayList<CoinVO>();
			for (Account account2 : list) {
				CoinVO accountBalanceVO = new CoinVO();
				BeanUtils.copyProperties(account2, accountBalanceVO);
				accountBalanceVOs.add(accountBalanceVO);
			}
			new ExportExcel("卓币报表信息数据", CoinVO.class).setDataList(list).write(response, fileName)
					.dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出卓币报表失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + adminPath + "/wlpt/consume/useraccount/";
	}


	/**
	 * 余额报表
	 * @param balanceVo 余额报表对象
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "balanceVo", "" })
	public String balanceVoList(Account balanceVo, HttpServletRequest request, HttpServletResponse response, Model model) {
		balanceVo.setIsmemberAccount("2");//余额报表
		Page<Account> page = consumerecodService.findUserWebAccount(new Page<Account>(request, response), balanceVo);
		model.addAttribute("page", page);
		return "modules/wlpt/report/useracountManage";
	}

	/**
	 * 余额报表
	 * @param balanceVo 余额报表对象
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "accountBalanceVoList", "" })
	public String accountBalanceVoList(Account balanceVo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Account> page = consumerecodService.findUserWebAccount(new Page<Account>(request, response), balanceVo);
		model.addAttribute("page", page);
		return "modules/wlpt/report/useracountManage";
	}
	/**
	 * 余额管理-统计导出
	 *
	 * @param balanceVO
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "balanceVoExport", method = RequestMethod.POST)
	public String balanceVoExport(Account balanceVO, HttpServletRequest request, HttpServletResponse response,
								  RedirectAttributes redirectAttributes) {
		try {
			String fileName = "用户余额信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Account> page = consumerecodService.findUserWebAccount(new Page<Account>(), balanceVO);

			List<Account> list = page.getList();

			List<BalanceVO> accountBalanceVOs = new ArrayList<BalanceVO>();
			for (Account account2 : list) {
				BalanceVO accountBalanceVO = new BalanceVO();
				BeanUtils.copyProperties(account2, accountBalanceVO);
				accountBalanceVOs.add(accountBalanceVO);
			}
			new ExportExcel("余额管理信息数据", BalanceVO.class).setDataList(list).write(response, fileName)
					.dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + adminPath + "/wlpt/consume/useraccount/";
	}

	/**
	 * 账号体系报表
	 * @param balanceVo 账号体系报表对象
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = { "userAccountBalanceVoList", "" })
	public String userAccountBalanceVoList(Account balanceVo, HttpServletRequest request, HttpServletResponse response, Model model) {
		balanceVo.setIsmemberAccount("1");//账号系统
		Page<Account> page = consumerecodService.findUserWebAccount(new Page<Account>(request, response), balanceVo);
		
		List<Account> list = page.getList();
		List<Account> accountlist = new ArrayList<Account>();
		for (Account account2 : list) {
		    User user=new User();
		    AccountAmount accountAmount=new AccountAmount();
		    accountAmount.setAvailableBalance(0.0);
	    	accountAmount.setFreezeBalance(0.0);
	    	accountAmount.setLockBalance(0.0);
	    	accountAmount.setUndeterminedBalance(0.0);
	    	if(!Tools.IsNullOrWhiteSpace(account2.getUser().getMemberId())){
	    		//获取memberId
	    		user.setMemberId(account2.getUser().getMemberId());
	    		//请求查询账户接口，获取用户的余额信息
	    		accountAmount=accountBiz.getAccountAmount(user);
	    	}
	    	account2.setAvailableBalance(accountAmount.getAvailableBalance());
	    	account2.setFreezeBalance(accountAmount.getFreezeBalance());
	    	account2.setLockBalance(accountAmount.getLockBalance());
	    	account2.setUndeterminedBalance(accountAmount.getUndeterminedBalance());	
			accountlist.add(account2);
		}
		page.setList(accountlist);
		
		model.addAttribute("page", page);
		return "modules/wlpt/report/useracountsystemManage";
	}
	
	
	/**
	 * 账号体系报表-统计导出
	 *
	 * @param balanceVO
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "userAccountBalanceVoExport", method = RequestMethod.POST)
	public String userAccountBalanceVoExport(Account balanceVO, HttpServletRequest request, HttpServletResponse response,
								  RedirectAttributes redirectAttributes) {
		try {
			String fileName = "用户账号系统余额信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			balanceVO.setIsmemberAccount("1");//账号系统
			Page<Account> page = consumerecodService.findUserWebAccount(new Page<Account>(), balanceVO);

			List<Account> list = page.getList();

			List<UserAccountBalanceVO> accountBalanceVOs = new ArrayList<UserAccountBalanceVO>();
			for (Account account2 : list) {
				User user=new User();
				AccountAmount accountAmount=new AccountAmount();
			    accountAmount.setAvailableBalance(0.0);
		    	accountAmount.setFreezeBalance(0.0);
		    	accountAmount.setLockBalance(0.0);
		    	accountAmount.setUndeterminedBalance(0.0);
		    	if(!Tools.IsNullOrWhiteSpace(account2.getUser().getMemberId())){
		    		//获取memberId
		    		user.setMemberId(account2.getUser().getMemberId());
		    		//请求查询账户接口，获取用户的余额信息
		    		accountAmount=accountBiz.getAccountAmount(user);
		    	}
		    	account2.setAvailableBalance(accountAmount.getAvailableBalance());
		    	account2.setFreezeBalance(accountAmount.getFreezeBalance());
		    	account2.setLockBalance(accountAmount.getLockBalance());
		    	account2.setUndeterminedBalance(accountAmount.getUndeterminedBalance());
				
		    	UserAccountBalanceVO accountBalanceVO = new UserAccountBalanceVO();
				BeanUtils.copyProperties(account2, accountBalanceVO);
				accountBalanceVOs.add(accountBalanceVO);
			}
			new ExportExcel("账号系统余额管理信息数据", UserAccountBalanceVO.class).setDataList(accountBalanceVOs).write(response, fileName)
					.dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出账号系统余额管理信息数据失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + adminPath + "/wlpt/consume/useraccount/";
	}



	/**
	 * 余额管理-统计列表
	 * 
	 * @param account
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("wlpt:consume:useraccount:list")
	@RequestMapping(value = { "balanceManageList", "" })
	public String balanceManageList(Account account, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		Page<Account> page = consumerecodService.findUserAccount(new Page<Account>(request, response), account);
		model.addAttribute("page", page);
		return "modules/wlpt/consume/balanceManage";
	}

	/**
	 * 余额管理-统计导出
	 * 
	 * @param account
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "balanceExport", method = RequestMethod.POST)
	public String balanceExport(Account account, HttpServletRequest request, HttpServletResponse response,
			RedirectAttributes redirectAttributes) {
		try {
			String fileName = "用户账户余额信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Account> page = consumerecodService.findUserAccount(new Page<Account>(), account);

			List<Account> list = page.getList();

			List<AccountBalanceVO> accountBalanceVOs = new ArrayList<AccountBalanceVO>();
			for (Account account2 : list) {
				AccountBalanceVO accountBalanceVO = new AccountBalanceVO();
				BeanUtils.copyProperties(account2, accountBalanceVO);
				accountBalanceVOs.add(accountBalanceVO);
			}
			new ExportExcel("余额管理信息数据", AccountBalanceVO.class).setDataList(accountBalanceVOs).write(response, fileName)
					.dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + adminPath + "/wlpt/consume/useraccount/";
	}

	/**
	 * 流水管理-用户各类型流水统计列表
	 * 
	 * @param models
	 * @param account
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("wlpt:consume:useraccount:list")
	@RequestMapping(value = { "typeList", "" })
	public String typeList(String models, Account account, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		Page<Account> page = consumerecodService.findUserAccountByParameterType(models,
				new Page<Account>(request, response), account);
		List<Account> list = page.getList();
		List<Account> accountlist = new ArrayList<Account>();
		for (Account account2 : list) {
		    User user=new User();
		    AccountAmount accountAmount=new AccountAmount();
		    accountAmount.setAvailableBalance(0.0);
	    	accountAmount.setFreezeBalance(0.0);
	    	accountAmount.setLockBalance(0.0);
	    	accountAmount.setUndeterminedBalance(0.0);
	    	if(!Tools.IsNullOrWhiteSpace(account2.getUser().getMemberId())){
	    		//获取memberId
	    		user.setMemberId(account2.getUser().getMemberId());
	    		//请求查询账户接口，获取用户的余额信息
	    		accountAmount=accountBiz.getAccountAmount(user);
	    	}
	    	account2.setAvailableBalance(accountAmount.getAvailableBalance());
	    	account2.setFreezeBalance(accountAmount.getFreezeBalance());
	    	account2.setLockBalance(accountAmount.getLockBalance());
	    	account2.setUndeterminedBalance(accountAmount.getUndeterminedBalance());	
			accountlist.add(account2);
		}
		page.setList(accountlist);
		model.addAttribute("page", page);
		String view = "useracountManage";
		if (models.equals(DataDic.TRADE_PARAMETER_TYPE_RECHARGE)) {// 充值
			view = "accountRechargeList";
		} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_CASH)) {// 提现
			view = "accountCashList";
		} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_TRADEORDER)) {// 运单
			view = "accountTradeOrderList";
		} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_TRANSFER)) {// 转账
			view = "accountTransferList";
		} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_BIDDING)) {// 竞标
			view = "accountBiddingList";
		} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_BID)) {// 招标
			view = "accountBidList";
		} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_OTHER)) {// 其他类型
			view = "accountOtherList";
		} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_PETROL)) {// 油气类型
			view = "accountPetrolList";
		} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_COIN)) {// 卓币类型
			view = "accountCoinList";
		}
		return "modules/wlpt/consume/" + view;
	}

	/**
	 * 流水管理-用户各类型流水统计报表导出
	 * 
	 * @param models
	 * @param account
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "typeExport", method = RequestMethod.POST)
	public String typeExportFile(String models, Account account, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String title = "";
			if (models.equals(DataDic.TRADE_PARAMETER_TYPE_RECHARGE)) {// 充值
				title = "用户充值交易流水统计";
			} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_CASH)) {// 提现
				title = "用户提现交易流水统计";
			} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_TRADEORDER)) {// 运单
				title = "用户运单交易交易流水统计";
			} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_TRANSFER)) {// 转账
				title = "用户转账交易流水统计";
			} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_BIDDING)) {// 竞标
				title = "用户竞标交易流水统计";
			} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_BID)) {// 招标
				title = "用户招标结算交易流水统计";
			} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_OTHER)) {// 其他类型
				title = "用户其他类型交易流水统计";
			} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_PETROL)) {// 油气
				title = "用户油气交易流水统计";
			} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_COIN)) {// 卓币
				title = "用户卓币交易流水统计";
			}
			String fileName = title + "信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Account> page = consumerecodService.findUserAccount(new Page<Account>(), account);

			List<Account> list = page.getList();

			if (models.equals(DataDic.TRADE_PARAMETER_TYPE_RECHARGE)) {// 充值
				List<AccountRechargeVO> accountRechargeVOs = new ArrayList<AccountRechargeVO>();
				for (Account account2 : list) {
					AccountRechargeVO accountRechargeVO = new AccountRechargeVO();
					BeanUtils.copyProperties(account2, accountRechargeVO);
					accountRechargeVOs.add(accountRechargeVO);
				}
				new ExportExcel(title + "信息数据", AccountRechargeVO.class).setDataList(accountRechargeVOs)
						.write(response, fileName).dispose();

			} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_CASH)) {// 提现
				List<AccountCashVO> accountCashVOs = new ArrayList<AccountCashVO>();

				for (Account account2 : list) {
					AccountCashVO accountCashVO = new AccountCashVO();
					BeanUtils.copyProperties(account2, accountCashVO);
					accountCashVOs.add(accountCashVO);
				}
				new ExportExcel(title + "信息数据", AccountCashVO.class).setDataList(accountCashVOs)
						.write(response, fileName).dispose();

			} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_TRADEORDER)) {// 运单
				List<AccountTradeOrderVO> accountTradeOrderVOs = new ArrayList<AccountTradeOrderVO>();

				for (Account account2 : list) {
					AccountTradeOrderVO accountTradeOrderVO = new AccountTradeOrderVO();
					BeanUtils.copyProperties(account2, accountTradeOrderVO);
					accountTradeOrderVOs.add(accountTradeOrderVO);
				}
				new ExportExcel(title + "信息数据", AccountTradeOrderVO.class).setDataList(accountTradeOrderVOs)
						.write(response, fileName).dispose();

			} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_TRANSFER)) {// 转账
				List<AccountTransferVO> transferVOs = new ArrayList<AccountTransferVO>();

				for (Account account2 : list) {
					AccountTransferVO accountTransferVO = new AccountTransferVO();
					BeanUtils.copyProperties(account2, accountTransferVO);
					transferVOs.add(accountTransferVO);
				}
				new ExportExcel(title + "信息数据", AccountTransferVO.class).setDataList(transferVOs)
						.write(response, fileName).dispose();

			} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_BIDDING)) {// 竞标
				List<AccountBiddingVO> accountBiddingVOs = new ArrayList<AccountBiddingVO>();

				for (Account account2 : list) {
					AccountBiddingVO accountBiddingVO = new AccountBiddingVO();
					BeanUtils.copyProperties(account2, accountBiddingVO);
					accountBiddingVOs.add(accountBiddingVO);
				}
				new ExportExcel(title + "信息数据", AccountBiddingVO.class).setDataList(accountBiddingVOs)
						.write(response, fileName).dispose();

			} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_BID)) {// 招标
				List<AccountBidVO> accountBidVOs = new ArrayList<AccountBidVO>();

				for (Account account2 : list) {
					AccountBidVO accountBidVO = new AccountBidVO();
					BeanUtils.copyProperties(account2, accountBidVO);
					accountBidVOs.add(accountBidVO);
				}
				new ExportExcel(title + "信息数据", AccountBidVO.class).setDataList(accountBidVOs).write(response, fileName)
						.dispose();

			} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_OTHER)) {// 其他类型
				List<AccountOtherVO> accountOtherVOs = new ArrayList<AccountOtherVO>();

				for (Account account2 : list) {
					AccountOtherVO accountOtherVO = new AccountOtherVO();
					BeanUtils.copyProperties(account2, accountOtherVO);
					accountOtherVOs.add(accountOtherVO);
				}
				new ExportExcel(title + "信息数据", AccountOtherVO.class).setDataList(accountOtherVOs)
						.write(response, fileName).dispose();

			} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_PETROL)) {// 油气
				List<AccountPetrolVO> accountPetrolVOs = new ArrayList<AccountPetrolVO>();

				for (Account account2 : list) {
					AccountPetrolVO accountPetrolVO = new AccountPetrolVO();
					BeanUtils.copyProperties(account2, accountPetrolVO);
					accountPetrolVOs.add(accountPetrolVO);
				}
				new ExportExcel(title + "信息数据", AccountPetrolVO.class).setDataList(accountPetrolVOs)
						.write(response, fileName).dispose();

			} else if (models.equals(DataDic.TRADE_PARAMETER_TYPE_COIN)) {// 卓币
				List<AccountCoinVO> accountCoinVOs = new ArrayList<AccountCoinVO>();

				for (Account account2 : list) {
					AccountCoinVO accountCoinVO = new AccountCoinVO();
					BeanUtils.copyProperties(account2, accountCoinVO);
					accountCoinVOs.add(accountCoinVO);
				}
				new ExportExcel(title + "信息数据", AccountCoinVO.class).setDataList(accountCoinVOs)
						.write(response, fileName).dispose();

			}
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + adminPath + "/wlpt/consume/useraccount/";
	}

	/**
	 * 用户全部类型交易流水统计列表
	 * 
	 * @param account
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequestMapping(value = "export", method = RequestMethod.POST)
	public String exportFile(Account account, HttpServletRequest request, HttpServletResponse response,
			RedirectAttributes redirectAttributes) {
		try {
			String fileName = "用户账户信息数据" + DateUtils.getDate("yyyyMMddHHmmss") + ".xlsx";
			Page<Account> page = consumerecodService.findUserAccount(new Page<Account>(request, response), account);

			new ExportExcel("账户信息数据", Account.class).setDataList(page.getList()).write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出用户失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + adminPath + "/wlpt/consume/useraccount/";
	}

	/**
	 * 用户所有类型交易流水详情
	 * 
	 * @param consumerecod
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "detail")
	public String detail(Consumerecod consumerecod, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		String userId = request.getParameter("id");
		consumerecod.setId(userId);
		Page<Consumerecod> page = consumerecodService.findWebDetailById(new Page<Consumerecod>(request, response),
				consumerecod);
		model.addAttribute("page", page);
		model.addAttribute("userid", userId);
		return "modules/wlpt/consume/useraccountDetail";
	}

	/**
	 * 按流水类型获取用户各类型流水详情
	 * 
	 * @param id
	 * @param tradeType
	 * @param consumerecod
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "detailByType")
	public String detailByType(String id, String trademodel, String tradeType, Consumerecod consumerecod,
			HttpServletRequest request, HttpServletResponse response, Model model) {
		consumerecod.setId(id);// 用户id
		/* consumerecod.setSearchinfo(tradeType); */// 流水类型
		consumerecod.setTrademodel(trademodel);
		Page<Consumerecod> page = consumerecodService.findDetailBySearchinfo(new Page<Consumerecod>(request, response),
				consumerecod);
		model.addAttribute("page", page);
		model.addAttribute("tradeType", tradeType);
		model.addAttribute("trademodel", trademodel);
		model.addAttribute("userid", id);
		return "modules/wlpt/consume/useraccountDetailByType";
	}
	
	/**
	 * 按流水类型获取用户各类型流水详情
	 * 
	 * @param id
	 * @param tradeType
	 * @param consumerecod
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "detailByway")
	public String detailByway(String id, String consumeway,String tradeType,  ConsumerecodPetrolVO consumerecod,
			HttpServletRequest request, HttpServletResponse response, Model model) {
		consumerecod.setId(id);// 用户id
		/* consumerecod.setSearchinfo(tradeType); */// 流水类型
		consumerecod.setConsumeway(consumeway);
		Page<ConsumerecodPetrolVO> page = consumerecodService.findPetrolDetailBySearchinfo(new Page<ConsumerecodPetrolVO>(request, response),
				consumerecod);
		model.addAttribute("page", page);
		model.addAttribute("consumeway", consumeway);
		model.addAttribute("tradeType", tradeType);
		model.addAttribute("userid", id);
		return "modules/wlpt/consume/useraccountDetailByWay";
	}
}