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
import com.egolm.tpl.generator.bean.Category;
import com.egolm.tpl.generator.bean.Product;

@Component("floor2ModuleGenerator")
public class Floor2ModuleGenerator extends ModuleGenerator {
	

	@Override
	public void generate(VelocityContext ctx, JSONObject jsonRoot,String zoneCode,String floorId,String sScopeTypeID) {
		String floorName=null;
		List<Advert> advertList=new ArrayList<Advert>();//商品分类集合;
		
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
			advert.getChildAdvertList().add(getAdvertList(advertObject.getJSONObject("ap_1st").getString("nApID"), zoneCode));
			advert.getChildAdvertList().add(getAdvertList(advertObject.getJSONObject("ap_2nd").getString("nApID"), zoneCode));
			advert.getChildAdvertList().add(getAdvertList(advertObject.getJSONObject("ap_3rd").getString("nApID"), zoneCode));
			advert.getChildAdvertList().add(getAdvertList(advertObject.getJSONObject("ap_4th").getString("nApID"), zoneCode));
			advert.getChildAdvertList().add(getAdvertList(advertObject.getJSONObject("ap_5th").getString("nApID"), zoneCode));
			advert.getChildAdvertList().add(getAdvertList(advertObject.getJSONObject("ap_6th").getString("nApID"), zoneCode));
			
			advert.setTabTitle(title);
			
			
			//3.商品分类
			
			JSONArray categoryJsonArray = advertObject.getJSONArray("category");
			if(categoryJsonArray!=null){
				List<Category> categoryList=new ArrayList<Category>();
				for (int j = 0; j < categoryJsonArray.size(); j++) {
					JSONObject categoryJsonObject = categoryJsonArray.getJSONObject(j);
					Category category=new Category();
					category.setId(categoryJsonObject.getString("categoryID"));
					category.setName(categoryJsonObject.getString("categoryName"));
					categoryList.add(category);
				}
				advert.setCategoryList(categoryList);
			}
			
			
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
