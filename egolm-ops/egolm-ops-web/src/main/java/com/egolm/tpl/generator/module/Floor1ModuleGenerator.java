package com.egolm.tpl.generator.module;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.apache.velocity.VelocityContext;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.egolm.tpl.generator.ModuleGenerator;
import com.egolm.tpl.generator.bean.Advert;
import com.egolm.tpl.generator.bean.Product;

@Component("floor1ModuleGenerator")
public class Floor1ModuleGenerator extends ModuleGenerator {
	

	@Override
	public void generate(VelocityContext ctx, JSONObject jsonRoot,String zoneCode,String floorId,String sScopeTypeID) {
		List<Advert> advertList=new ArrayList<Advert>();//商品分类集合;
		String floorName=null;
		
		//1.楼层名称
		floorName = jsonRoot.getString("floorName");
		
		//2.广告解析
		JSONArray advertJsonArray = jsonRoot.getJSONArray("datas");
		for (int i = 0; i < advertJsonArray.size(); i++) {
			JSONObject advertObject = advertJsonArray.getJSONObject(i);
			Advert advert=new Advert();
			String title=advertObject.getString("name");
			advert.getChildAdvertList().add(getAdvertList(advertObject.getJSONObject("ap_L").getString("nApID"), zoneCode));
			advert.getChildAdvertList().add(getAdvertList(advertObject.getJSONObject("ap_R").getString("nApID"), zoneCode));
			advert.getChildAdvertList().add(getAdvertList(advertObject.getJSONObject("ap_M1").getString("nApID"), zoneCode));
			advert.getChildAdvertList().add(getAdvertList(advertObject.getJSONObject("ap_M2").getString("nApID"), zoneCode));
			advert.getChildAdvertList().add(getAdvertList(advertObject.getJSONObject("ap_M3").getString("nApID"), zoneCode));
			advert.getChildAdvertList().add(getAdvertList(advertObject.getJSONObject("ap_M4").getString("nApID"), zoneCode));
			advert.setTabTitle(title);
			advertList.add(advert);
		}
		
		
		Random rand = new Random();
		int random = rand.nextInt(); 
		ctx.put("random", random);
		ctx.put("advertList", advertList);
		ctx.put("floorName", floorName);
		ctx.put("floorId", floorId);
	}
	
}
