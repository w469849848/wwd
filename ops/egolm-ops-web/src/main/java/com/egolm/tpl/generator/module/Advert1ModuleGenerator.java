package com.egolm.tpl.generator.module;

import java.util.HashMap;
import java.util.Map;

import org.apache.velocity.VelocityContext;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.egolm.tpl.generator.ModuleGenerator;
import com.egolm.tpl.generator.bean.Advert;
import com.egolm.tpl.utils.HttpHandler;
import com.egolm.tpl.web.TplSettingPopController;

@Component("advert1ModuleGenerator")
public class Advert1ModuleGenerator extends ModuleGenerator {
	

	@Override
	public void generate(VelocityContext ctx,JSONObject jsonRoot,String zoneCode,String floorId,String sScopeTypeID) {
		Advert advert=new Advert();
		
		
		Map<String, String> rightMap=new HashMap<String,String>();
		advert=getAdvert(jsonRoot.getString("nApID"), zoneCode);
		
		ctx.put("advert", advert);
	}
	
}
