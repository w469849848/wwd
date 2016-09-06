package com.egolm.driver.web;

import java.io.IOException;
import java.io.OutputStream;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.plugin.jdbc.PageSqlserver;
import org.springframework.plugin.util.Rjx;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.egolm.base.api.TOrgsQueryApi;
import com.egolm.common.EgolmException;
import com.egolm.dealer.api.AgentContractQueryApi;
import com.egolm.dealer.api.AgentQueryApi;
import com.egolm.domain.TAgent;
import com.egolm.domain.TYWDriveMan;
import com.egolm.sales.api.driver.DriverApi;
import com.egolm.sales.domain.enums.DriverState;
import com.egolm.security.utils.SecurityContextUtil;
import com.egolm.util.ExportExcelUtil;
import com.google.common.collect.Lists;

@Controller
@RequestMapping("/logistics/driver")
public class DriverController {

	@Resource
	private DriverApi driverApi;
	@Resource
	private AgentContractQueryApi contractApi;
	@Resource
	private AgentQueryApi agentApi;
	@Resource
	private TOrgsQueryApi  tOrgsQueryApi;
	
	@RequestMapping("/index")
	public ModelAndView index() {
		return queryDrivers(null, null, 1L, 10);
	}

	@RequestMapping("/queryDrivers")
	public ModelAndView queryDrivers(String sDrivemanNoAndName, DriverState driverState, Long index, Integer limit) {
		PageSqlserver pager = new PageSqlserver();
		pager.setIndex(null == index ? 1 : index);
		pager.setLimit(null == limit ? 10 : limit);
		pager.setLimitKey("dCreateDate desc");

		TYWDriveMan driver = new TYWDriveMan();
		if(null != driverState) {
			driver.setNTag(driverState.getCode());
		}
		String driverArg = StringUtils.trim(sDrivemanNoAndName);
		if(StringUtils.isNotBlank(driverArg)) {
			driver.setSDrivemanNo(driverArg);
			driver.setSDrivemanName(driverArg);
		}
		Map<String, Object> datas = new HashMap<String, Object>();
		ModelAndView mv = new ModelAndView("driver/list.jsp");
		try {
			datas = driverApi.queryDrivers(driver, pager);
			pager = (PageSqlserver) datas.get("page");
		} catch (EgolmException e) {
			U.logger.error("", e);
		} catch (Throwable e) {
			U.logger.error("", e);
		}
		mv.addObject("sDrivemanNoAndName", driverArg);
		mv.addObject("page", pager);
		mv.addObject("drivers", datas.get("result"));
		mv.addObject("driverState", driverState);
		return mv;
	}

	@RequestMapping(value = "/addDriver", method = { RequestMethod.GET })
	public ModelAndView addDriverPage() {
		ModelAndView mv = new ModelAndView("driver/add.jsp");
		return mv;
	}

	@RequestMapping(value = "/addDriver", method = { RequestMethod.POST })
	@ResponseBody
	public Rjx addDriverAction(TYWDriveMan driver) {
		if (null == driver) {
			return Rjx.jsonErr().set("message", "参数异常");
		}
		String userId = SecurityContextUtil.getUserId();
		try {
			driverApi.createDriver(userId, driver);
			return Rjx.jsonOk();
		} catch (EgolmException e) {
			U.logger.error("", e);
			return Rjx.jsonErr().set("message", e.getMessage());
		} catch (Throwable e) {
			U.logger.error("", e);
			return Rjx.jsonErr().set("message", "系统异常");
		}
	}

	@RequestMapping(value = "/modifyDriver", method = { RequestMethod.GET })
	public ModelAndView modifyDriverPage(String sDrivemanId) {
		ModelAndView mv = new ModelAndView("driver/modify.jsp");
		if (StringUtils.isBlank(sDrivemanId)) {
			return mv;
		}
		try {
			TYWDriveMan driver = driverApi.queryDriverById(sDrivemanId);
			Map<String, Object> map = agentApi.queryAgentContractByWareHouseNo(driver.getSWareHouseNo());
			String agentId = String.valueOf(map.get("nAgentID"));
			String sOrgNO = String.valueOf(map.get("sOrgNO"));
			TAgent agent = agentApi.queryTAgentById(Integer.valueOf(agentId));
			Map<String, Object> org = tOrgsQueryApi.queryProvinceOrgByCityOrgNO(sOrgNO);
			mv.addObject("driver", driver);
			mv.addObject("agent", agent);
			mv.addObject("org", org);
		} catch (Throwable e) {
			U.logger.error("", e);
		}
		return mv;
	}
	
	@RequestMapping("modifyDriver")
	@ResponseBody
	public Rjx modifyDriver(TYWDriveMan driver) {
		if (null == driver || StringUtils.isBlank(driver.getSDrivemanId())) {
			return Rjx.jsonErr().set("message", "参数异常");
		}
		String userId = SecurityContextUtil.getUserId();
		try {
			driverApi.modifyDriverInfo(userId, driver);
			return Rjx.jsonOk();
		} catch (EgolmException e) {
			U.logger.error("", e);
			return Rjx.jsonErr().set("message", "系统异常");
		} catch (Throwable e) {
			U.logger.error("", e);
			return Rjx.jsonErr().set("message", "系统异常");
		}

	}

	@RequestMapping(value = "/exeproExcel")
	public void exeproExcel(String sDrivemanNoAndName, DriverState driverState, String sDrivemanIds,
			HttpServletResponse response) {
		TYWDriveMan driver = new TYWDriveMan();
		if (null != driverState) {
			driver.setNTag(driverState.getCode());
		}
		List<TYWDriveMan> dataset = Lists.newArrayList();
		List<String> idsArray = Lists.newArrayList();
		if (StringUtils.isNotBlank(sDrivemanIds)) {
			idsArray.addAll(Arrays.asList(sDrivemanIds.split(",")));
		}
		String driverArg = StringUtils.trim(sDrivemanNoAndName);
		if(StringUtils.isNotBlank(driverArg)) {
			driver.setSDrivemanNo(driverArg);
			driver.setSDrivemanName(driverArg);
		}
		try {
			dataset = driverApi.exportDrivers(idsArray, driver, new PageSqlserver());
		} catch (EgolmException e) {
			U.logger.error("", e);
		} catch (Throwable e) {
			U.logger.error("", e);
		}
		String[] headers = { "司机编号", "姓名", "密码", "联系方式", "所属仓库", "状态", "备注" };
		String[] columns = { "sDrivemanNo", "sDrivemanName", "sDrivemanPwd", "sTel", "sWarehouseName", "nTag",
				"sMemo" };
		List<DriverVO> vos = Lists.newArrayList();
		try {
			for (TYWDriveMan data : dataset) {
				DriverVO vo = new DriverVO();
				BeanUtils.copyProperties(data, vo);
				DriverState state = DriverState.parse(String.valueOf(data.getNTag()));
				vo.setNTag(state.getDescription());
				vos.add(vo);
			}
		} catch (Exception e) {
			U.logger.error("", e);
		}

		ExportExcelUtil<DriverVO> tydexcute = new ExportExcelUtil<DriverVO>();
		OutputStream out = null;
		try {
			out = response.getOutputStream();// 输出流
			response.reset();// 清空输出流
			response.setHeader("Content-disposition", "attachment; filename=" + new String("司机列表".getBytes("GB2312"), "8859_1") + ".xls");// 设定输出文件头
			response.setContentType("application/msexcel");// 定义输出类型
			tydexcute.exportExcel("司机列表", headers, columns, vos, out, "");
			out.flush();
		} catch (Exception e) {
			U.logger.error("", e);
		} finally {
			if (null != out) {
				try {
					out.close();
				} catch (IOException e) {
					U.logger.error("", e);
				}
			}
		}
	}
	
	@RequestMapping("/changeState")
	@ResponseBody
	public Rjx changeState(DriverState driverState, String[] driverIds) {
		if (null == driverState || ArrayUtils.isEmpty(driverIds)) {
			return Rjx.jsonErr().set("message", "参数异常");
		}
		String userId = SecurityContextUtil.getUserId();
		try {
			driverApi.changeDriversState(userId, Arrays.asList(driverIds), driverState);
			return Rjx.jsonOk();
		} catch (EgolmException e) {
			U.logger.error("", e);
			return Rjx.jsonErr().set("message", "系统异常");
		} catch (Throwable e) {
			U.logger.error("", e);
			return Rjx.jsonErr().set("message", "系统异常");
		}
	}
	
	@RequestMapping("/deleteDriver")
	@ResponseBody
	public Rjx deleteDriver(String[] driverIds) {
		if (ArrayUtils.isEmpty(driverIds)) {
			return Rjx.jsonErr().set("message", "参数异常");
		}
		String userId = SecurityContextUtil.getUserId();
		try {
			driverApi.deleteDriver(userId, Arrays.asList(driverIds));
			return Rjx.jsonOk();
		} catch (EgolmException e) {
			U.logger.error("", e);
			return Rjx.jsonErr().set("message", "系统异常");
		} catch (Throwable e) {
			U.logger.error("", e);
			return Rjx.jsonErr().set("message", "系统异常");
		}
	}
	
	public class DriverVO {
		private String sDrivemanId;
		private String sDrivemanNo;
		private String sDrivemanPwd;
		private String sDrivemanName;
		private String sWareHouseNo;
		private String sWarehouseName;
		private String nTag;
		private String sCreateUser;
		private Date dCreateDate;
		private String sConfirmUser;
		private Date dConfirmDate;
		private Date dLastUpdateTime;
		private String sTel;
		private String sMemo;

		public void setSDrivemanId(String sDrivemanId) {
			this.sDrivemanId = sDrivemanId;
		}
		public String getSDrivemanId() {
			return sDrivemanId;
		}
		public void setSDrivemanNo(String sDrivemanNo) {
			this.sDrivemanNo = sDrivemanNo;
		}
		public String getSDrivemanNo() {
			return sDrivemanNo;
		}
		public void setSDrivemanPwd(String sDrivemanPwd) {
			this.sDrivemanPwd = sDrivemanPwd;
		}
		public String getSDrivemanPwd() {
			return sDrivemanPwd;
		}
		public void setSDrivemanName(String sDrivemanName) {
			this.sDrivemanName = sDrivemanName;
		}
		public String getSDrivemanName() {
			return sDrivemanName;
		}
		public void setSWareHouseNo(String sWareHouseNo) {
			this.sWareHouseNo = sWareHouseNo;
		}
		public String getSWareHouseNo() {
			return sWareHouseNo;
		}
		public String getSWarehouseName() {
			return sWarehouseName;
		}
		public void setSWarehouseName(String sWarehouseName) {
			this.sWarehouseName = sWarehouseName;
		}
		public void setNTag(String nTag) {
			this.nTag = nTag;
		}
		public String getNTag() {
			return nTag;
		}
		public void setSCreateUser(String sCreateUser) {
			this.sCreateUser = sCreateUser;
		}
		public String getSCreateUser() {
			return sCreateUser;
		}
		public void setDCreateDate(Date dCreateDate) {
			this.dCreateDate = dCreateDate;
		}
		public Date getDCreateDate() {
			return dCreateDate;
		}
		public void setSConfirmUser(String sConfirmUser) {
			this.sConfirmUser = sConfirmUser;
		}
		public String getSConfirmUser() {
			return sConfirmUser;
		}
		public void setDConfirmDate(Date dConfirmDate) {
			this.dConfirmDate = dConfirmDate;
		}
		public Date getDConfirmDate() {
			return dConfirmDate;
		}
		public void setDLastUpdateTime(Date dLastUpdateTime) {
			this.dLastUpdateTime = dLastUpdateTime;
		}
		public Date getDLastUpdateTime() {
			return dLastUpdateTime;
		}
		public void setSTel(String sTel) {
			this.sTel = sTel;
		}
		public String getSTel() {
			return sTel;
		}
		public void setSMemo(String sMemo) {
			this.sMemo = sMemo;
		}
		public String getSMemo() {
			return sMemo;
		}
	}
}
