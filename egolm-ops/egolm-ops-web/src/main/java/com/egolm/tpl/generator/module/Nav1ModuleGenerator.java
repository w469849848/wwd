package com.egolm.tpl.generator.module;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.velocity.VelocityContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.egolm.tpl.generator.ModuleGenerator;
import com.egolm.tpl.generator.bean.Advert;
import com.egolm.tpl.generator.bean.Category;
import com.egolm.tpl.generator.bean.Subject;
import com.egolm.tpl.service.CategoryService;
import com.egolm.tpl.utils.HttpHandler;
import com.egolm.tpl.web.TplSettingPopController;

@Component("nav1ModuleGenerator")
public class Nav1ModuleGenerator extends ModuleGenerator {
	
	@Autowired
	private CategoryService categoryService;

	@Override
	public void generate(VelocityContext ctx, JSONObject jsonRoot,String zoneCode,String floorId,String sScopeTypeID) {
		List<Category> categoryList=null;//商品分类集合;
		List<Subject> subjectList=new ArrayList<Subject>();//专区集合
		List<Advert> advertList=new ArrayList<Advert>();//滚动图片广告
		List<Advert> rightAdvertList=new ArrayList<Advert>();//右侧广告
		
		//1、解析商品分类
		categoryList=categoryService.queryCategoryForTpl(zoneCode, sScopeTypeID);
		
		//2.解析专区
		JSONArray navArray = jsonRoot.getJSONArray("nav");
		for (int i = 0; i < navArray.size(); i++) {
			JSONObject navObject = navArray.getJSONObject(i);
			Subject subject=new Subject();
			subject.setId(navObject.getString("sTplNo"));
			subject.setName(navObject.getString("sTplName"));
			subjectList.add(subject);
		}
		
		//3.解析轮播广告位广告图片
		JSONObject adPosLeftObject = jsonRoot.getJSONObject("ap_M");
		advertList=getAdvertList(adPosLeftObject.getString("nApID"), zoneCode);
		
		
		//4.解决右下角广告位
		JSONObject adPosRightObject = jsonRoot.getJSONObject("ap_R");
		rightAdvertList=getAdvertList(adPosRightObject.getString("nApID"), zoneCode);
		Random rand = new Random();
		int random = rand.nextInt(); 
		ctx.put("random", random);
		
		ctx.put("categoryList", categoryList);
		ctx.put("subjectList", subjectList);
		ctx.put("advertList", advertList);
		ctx.put("rightAdvertList", rightAdvertList);
		
	}
	
}
