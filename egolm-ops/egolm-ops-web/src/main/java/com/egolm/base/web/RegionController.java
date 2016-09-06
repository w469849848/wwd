package com.egolm.base.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.plugin.util.Rjx;
import org.springframework.plugin.util.U;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.egolm.base.api.RegionApi;

/**
 * @author coyzeng@gmail.com
 */

@Controller
@RequestMapping("/base/region")
public class RegionController {

	@Resource
	private RegionApi regionApi;

	@RequestMapping("allProvince")
	@ResponseBody
	public Rjx allProvince() {
		try {
			List<Map<String, Object>> provinces = regionApi.queryAllProvince();
			return Rjx.jsonOk().set("provinces", provinces);
		} catch (Throwable e) {
			U.logger.error("", e);
			return Rjx.jsonErr();
		}
	}

	@RequestMapping("allCityInProvince")
	@ResponseBody
	public Rjx allCityInProvince(String provinceNO) {
		try {
			List<Map<String, Object>> provinces = regionApi.queryAllCityByProvinceNO(provinceNO);
			return Rjx.jsonOk().set("cities", provinces);
		} catch (Throwable e) {
			U.logger.error("", e);
			return Rjx.jsonErr();
		}
	}

	@RequestMapping("allCountyInCity")
	@ResponseBody
	public Rjx allCountyInCity(String cityNO) {
		try {
			List<Map<String, Object>> provinces = regionApi.queryAllCountyByCityNO(cityNO);
			return Rjx.jsonOk().set("counties", provinces);
		} catch (Throwable e) {
			U.logger.error("", e);
			return Rjx.jsonErr();
		}
	}
}
