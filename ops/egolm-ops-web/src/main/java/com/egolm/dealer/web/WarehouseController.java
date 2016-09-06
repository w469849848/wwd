/**
 *  Copyright (c) 2016-2100 egolm, Inc. All rights reserved.
 */
package com.egolm.dealer.web;

import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.ArrayUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.plugin.util.Rjx;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.egolm.common.EgolmException;
import com.egolm.dealer.api.AgentContractQueryApi;
import com.egolm.dealer.api.WarehouseApi;
import com.egolm.domain.TWarehouse;

/**
 * @author coyzeng@gmail.com
 */
@Controller
@RequestMapping("/warehouse")
public class WarehouseController {

	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Resource
	private AgentContractQueryApi contractApi;
	@Resource
	private WarehouseApi warehouseApi;
	
	@RequestMapping("/queryByAgentNO")
	@ResponseBody
	public Rjx queryByAgentNO(Integer nAgentId) {
		try {
			List<TWarehouse> warehouses = warehouseApi.queryWarehouseByAgentId(nAgentId);
			return Rjx.jsonOk().set("warehouses", warehouses);
		} catch (EgolmException e) {
			logger.error("", e);
			return Rjx.jsonErr().set("message", "系统异常");
		} catch (Throwable e) {
			logger.error("", e);
			return Rjx.jsonErr().set("message", "系统异常");
		}
	}
	
	
	@RequestMapping("/queryByCityIds")
	@ResponseBody
	public Rjx queryByCityIds(String[] cityIds) {
		if (ArrayUtils.isEmpty(cityIds)) {
			return Rjx.jsonErr().set("message", "请选择城市");
		}
		try {
			List<TWarehouse> warehouses = warehouseApi.queryWarehouseByRegionIds(Arrays.asList(cityIds));
			return Rjx.jsonOk().set("warehouses", warehouses);
		} catch (EgolmException e) {
			logger.error("", e);
			return Rjx.jsonErr().set("message", "系统异常");
		} catch (Throwable e) {
			logger.error("", e);
			return Rjx.jsonErr().set("message", "系统异常");
		}
	}
}
