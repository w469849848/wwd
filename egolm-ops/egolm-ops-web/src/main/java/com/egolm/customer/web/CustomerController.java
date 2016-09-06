package com.egolm.customer.web;

import java.io.Writer;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.plugin.jdbc.Page;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.Egox;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.egolm.common.EgolmLogger;
import com.egolm.common.cust.CustContants;
import com.egolm.common.enums.UserType;
import com.egolm.customer.api.ICustomerInfo;
import com.egolm.customer.api.IGradeInfo;
import com.egolm.domain.TCustCustomerInfo;
import com.egolm.member.api.user.UserApi;
import com.egolm.member.domain.throwables.MemberException;
import com.egolm.sales.api.SalesManQueryApi;
import com.egolm.security.utils.SecurityContextUtil;

/**
 * @Title: 会员信息controller
 * @author TZH_PC
 *
 */
@SuppressWarnings("unchecked")
@Controller
@RequestMapping("/customer")
public class CustomerController extends BaseCustController{

	@Resource(name="idCustomerApi")
	private ICustomerInfo customerApi;
	@Resource(name = "idGradeApi")
	private IGradeInfo gradeApi;
	@Resource(name = "salesManQueryApi")
	private SalesManQueryApi salesManQueryApi;
	@Resource
	private UserApi userApi;
	
	@InitBinder("page")
	public void initBinder1(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("page.");
	}
	
	@RequestMapping(value="/customerList")
	public ModelAndView customerList(HttpServletRequest request, @ModelAttribute("page") PageSqlserver page) {
		Map<String, Object> map = new HashMap<String, Object>();

		String sCustName = request.getParameter("sCustName");
		try {
			List<String> regionIds = SecurityContextUtil.getRegionIds();
			if (page == null || page.getLimitKey() == null) {
				page.setLimit(10);
			}
			Map<String, Object> params = searchSQL(request, page, "par", "com.egolm.domain.TCustCustomerInfo");
			Map<String, Object> resultmap = customerApi.queryTCustCustomerInfo(regionIds, params, page);

			boolean result = (boolean) resultmap.get("IsValid");
			if (result) {
				List<Map<String, Object>> dataList = (List<Map<String, Object>>) resultmap.get("DataList");

				for (Map<String, Object> data : dataList) {
					if (null != data.get("nTag")) {
						data.put("nTag", (int) data.get("nTag") & 1);
					} else {
						data.put("nTag", 0);
					}
				}

				page = U.objTo(resultmap.get("page"), PageSqlserver.class);
				map.put("datas", dataList);
				map.put("page", page);
			}

		} catch (Exception e) {
			U.logger.error("会员信息查询请求出错", e);
		}
		ModelAndView mv = new ModelAndView("/customer/cust-manage.jsp", map);
		mv.addObject("sCustName", sCustName);
		return mv;
	}
	
	/**
	 * 进入增加会员页面
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddCustomer")
	public String toAddCustomer(HttpServletRequest request){
		List<Map<String, Object>> gradeList = gradeApi.findAllByTag(CustContants.TAG_0);
		request.setAttribute("gradeList", gradeList);
		return "/customer/editCustomerPage.jsp";
	}
	
	/**
	 * 进入编辑会员页面
	 * @param request
	 * @return
	 */
	@RequestMapping("/toAddOrEditCust")
	public ModelAndView toEditPageForm(HttpServletRequest request,@RequestParam("editCustId") String editCustId){
		TCustCustomerInfo custInfo = customerApi.findById(editCustId);
		List<Map<String, Object>> gradeList = gradeApi.findAllByTag(CustContants.TAG_0);
		request.setAttribute("custInfo", custInfo);
		request.setAttribute("gradeList", gradeList);
		if(custInfo!=null){
			if(custInfo.getSSalesmanNO1()!=null){
				request.setAttribute("sSalesNO1", salesManQueryApi.queryTSalesManById(custInfo.getSSalesmanNO1()));
			}
			if(custInfo.getSSalesmanNO2()!=null){
				request.setAttribute("sSalesNO2", salesManQueryApi.queryTSalesManById(custInfo.getSSalesmanNO2()));
			}
		}
		return new ModelAndView("customer/editCustomerPage.jsp");
	}
	/**
	 * 会员密码管理列表页面
	 * @param page PageSqlserver 分页对象
	 * @param request HttpServletRequest
	 * @return String jsp路径
	 */
	@RequestMapping("/custPswManage")
	public ModelAndView custPswManage(@ModelAttribute("page") PageSqlserver page, HttpServletRequest request){
		Map<String, Object> map = new HashMap<String, Object>();
		ModelAndView mv = null;
		String sCustName=request.getParameter("sCustName");
		try {
			List<String> regionIds = SecurityContextUtil.getRegionIds();
			if (page == null || page.getLimitKey() == null) {
				page.setLimit(10);
			}
			Map<String, Object> params = searchSQL(request,page,"par","com.egolm.domain.TCustCustomerInfo");
			Map<String, Object> resultmap = customerApi.queryTCustCustomerInfo(regionIds, params, page);
			
			boolean result = (boolean)resultmap.get("IsValid");
			if(result){
				List<Map<String, Object>> dataList = (List<Map<String, Object>>) resultmap.get("DataList");
				
				page =U.objTo(resultmap.get("page"),PageSqlserver.class);
				map.put("datas", dataList);
				map.put("page", page);
			}

			mv = new ModelAndView("/customer/custPswManage.jsp", map);
			mv.addObject("sCustName", sCustName);
		} catch (Exception e) { 
			U.logger.error("会员信息查询请求出错,", e);
		}
		return mv;
	}
	
	/**
	 * 会员详情页面
	 * @param request HttpServletRequest
	 * @return String jsp路径
	 */
	@RequestMapping("/custDetail")
	public String custDetail(@RequestParam String id, HttpServletRequest request){
		
		TCustCustomerInfo custInfo = customerApi.findById(id);
		if(custInfo!=null){
			if(custInfo.getSSalesmanNO1()!=null){
				request.setAttribute("sSalesNO1", salesManQueryApi.queryTSalesManById(custInfo.getSSalesmanNO1()));
			}
			if(custInfo.getSSalesmanNO2()!=null){
				request.setAttribute("sSalesNO2", salesManQueryApi.queryTSalesManById(custInfo.getSSalesmanNO2()));
			}
		}
		request.setAttribute("custInfo", custInfo);
		return "/customer/custDetail.jsp";
	}
	
	
	
	
	/**
	 * 重置密码页面
	 * @param request HttpServletRequest
	 * @return String jsp路径
	 */
	@RequestMapping("/resetPsw")
	public String resetPsw(@RequestParam String ids, HttpServletRequest request){
		
		request.setAttribute("ids", ids);
		return "/customer/resetPsw.jsp";
	}
	
	/**
	 * do重置密码
	 * @param request HttpServletRequest
	 * @return String jsp路径
	 */
	@RequestMapping("/resetPswForm")
	@ResponseBody
	public void resetPswFirm(@RequestParam String ids,@RequestParam String password, HttpServletRequest request,Writer writer){
		try{
			Map<String, Object> returnMsg = customerApi.resetPswfirm(ids,password);
			Egox.egox(returnMsg).write(writer);
		} catch (Exception e) {
			U.logger.error("重置会员密码出错,", e);
			Egox.egoxErr().write(writer); 
		} 
	}
	
	/**
	 * 更新OR新增会员信息
	 * @param dto CustomerDTO
	 * @param request
	 * @param writer
	 */
	@RequestMapping("/editOrAddCust")
	public void custBasicUpdate(TCustCustomerInfo tCustParam,HttpServletRequest request,Writer writer) {
		TCustCustomerInfo tCust=null;
		
		if(tCustParam.getSCustNO()!=null&&!"".equals(tCustParam.getSCustNO())){
			tCust = customerApi.findById(tCustParam.getSCustNO());
			tCust.setSCustLeveType(tCustParam.getSCustLeveType());
			tCust.setSCustLeveTypeID(tCustParam.getSCustLeveTypeID());
			tCust.setSCustName(tCustParam.getSCustName());
			tCust.setSEmail(tCustParam.getSEmail());
			tCust.setSFax(tCustParam.getSFax());
			tCust.setSMobile(tCustParam.getSMobile());
			tCust.setSOpenID(tCustParam.getSOpenID());
			tCust.setSSalesmanNO1(tCustParam.getSSalesmanNO1());
			tCust.setSSalesmanNO2(tCustParam.getSSalesmanNO2());
		}else{
			tCust = new TCustCustomerInfo();
			tCust.setSConfirmUser(SecurityContextUtil.getUserId());
			tCust.setSCreateUser(SecurityContextUtil.getUserId());
			tCust.setDConfirmDate(new Date());
			tCust.setDCreateDate(new Date());
			tCust.setNTag(CustContants.TAG_0);
		}
		tCust.setDLastUpdateTime(new Date());
		Map<String, Object> returnMsg = customerApi.updateBasicTCust(tCust);
		Egox.egox(returnMsg).write(writer);
	}
	
	/**
	 * 修改会员状态
	 * @return
	 */
	@RequestMapping(value="/updateTag",method=RequestMethod.POST)
	public void status(String[] sCustNOs, Integer nTag, Writer writer) {
		if (ArrayUtils.isEmpty(sCustNOs) || null == nTag) {
			Egox.egoxErr().setReturnValue("请选择需要操作的会员").write(writer);
			return;
		}
		try {
			Map<String, Object> resultMap = customerApi.updateCustTag(Arrays.asList(sCustNOs), nTag);
			Egox.egox(resultMap).write(writer);
		} catch (Exception e) {
			U.logger.error("修改会员状态失败", e);
			Egox.egoxErr().setReturnValue("修改会员状态失败").write(writer);
		}
	}
	
	/**
	 * 删除会员信息
	 * @return
	@RequestMapping(value="/delete",method=RequestMethod.POST)
	public void delete(HttpServletRequest request,Writer writer){
		String sCustNO = request.getParameter("sCustNO");
		try {
			Map<String,Object> resultMap = customerApi.deleteCust(sCustNO);
			Egox.egox(resultMap).write(writer);
		} catch (Exception e) { 
			U.logger.error("删除会员信息出错失败", e);
			Egox.egoxErr().setReturnValue("删除会员信息出错失败").write(writer);
		}
	}
	*/
	
	/**
	 * 选择业务员窗口
	 * @param request
	 * @param page
	 * @return
	 */
	@RequestMapping(value="/salesmanNOList")
	public ModelAndView salesmanNOList(HttpServletRequest request,String sSalChineseName,@ModelAttribute("page") PageSqlserver page){
		ModelAndView mv  = new ModelAndView();
		if (page == null || page.getLimitKey() == null) {
			page.setLimit(10);
			page.setLimitKey("dCreateTime DESC");
		}
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if(U.isNotEmpty(sSalChineseName)){
			paramMap.put("sSalChineseName",sSalChineseName);
		}
		List<String> regionIds = SecurityContextUtil.getRegionIds();
		Map<String, Object> datas = salesManQueryApi.querySalesMans(regionIds, paramMap, page);
		Page pageReturn = (Page) datas.get("page");
		mv.addObject("datas", datas);
		mv.addObject("page", pageReturn);
		mv.addObject("sSalChineseName", sSalChineseName);
		mv.setViewName("/customer/salesmanNO.jsp");
		mv.addObject("saleNO",request.getParameter("saleNO"));
		return mv;
	}
	
	@RequestMapping(value = "/resetPassword")
	public void resetPassword(String[] sCustNOs, String newPassword, Writer writer) {
		if (ArrayUtils.isEmpty(sCustNOs)) {
			Egox.egoxErr().setReturnValue("请选择需要重置密码的会员").write(writer);
			return;
		}
		try {
			String operatorId = SecurityContextUtil.getUserId();
			String password = StringUtils.defaultIfBlank(newPassword, "123456");
			userApi.setPassword(operatorId, UserType.CUSTOMER, Arrays.asList(sCustNOs), password);
			Egox.egoxOk().setReturnValue("重置会员密码成功").write(writer);
		} catch (MemberException e) {
			EgolmLogger.MemberLogger.error(e.getError().getCause());
			Egox.egoxErr().setReturnValue(e.getError().getCause()).write(writer);
		} catch (Throwable e) {
			EgolmLogger.MemberLogger.error("", e);
			Egox.egoxErr().setReturnValue("系统异常").write(writer);
		}
	}
}
