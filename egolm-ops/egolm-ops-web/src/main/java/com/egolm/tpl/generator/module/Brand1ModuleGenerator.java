package com.egolm.tpl.generator.module;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.velocity.VelocityContext;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.egolm.tpl.generator.ModuleGenerator;
import com.egolm.tpl.generator.bean.Advert;
import com.egolm.tpl.generator.bean.Brand;
import com.egolm.tpl.generator.bean.Category;
import com.egolm.tpl.generator.bean.Subject;
import com.egolm.tpl.utils.HttpHandler;
import com.egolm.tpl.web.TplSettingPopController;

@Component("brand1ModuleGenerator")
public class Brand1ModuleGenerator extends ModuleGenerator {
	

	@Override
	public void generate(VelocityContext ctx,JSONObject jsonRoot,String zoneCode,String floorId,String sScopeTypeID) {
		List<Brand> brandList=new ArrayList<Brand>();//商品分类集合;
		List<Advert> advertList=new ArrayList<Advert>();
		
		//1.左侧广告位
		JSONObject adObject = jsonRoot.getJSONObject("adPos");
		advertList=getAdvertList(adObject.getString("nApID"), zoneCode);
		
		
		//1.解析品牌列表
		JSONArray brandJsonArray = jsonRoot.getJSONArray("brand");
		
		for (int i = 0; i < brandJsonArray.size(); i++) {
			JSONObject brandObject = brandJsonArray.getJSONObject(i);
			Brand brand=new Brand();
			brand.setId(brandObject.getString("brandId"));
			brand.setImg(brandObject.getString("imgPath"));
			brand.setName(brandObject.getString("brandName"));
			brandList.add(brand);
		}
		Random rand = new Random();
		int random = rand.nextInt(); 
		ctx.put("random", random);
		ctx.put("brandList", brandList);
		ctx.put("advertList", advertList);
	}
	
}
