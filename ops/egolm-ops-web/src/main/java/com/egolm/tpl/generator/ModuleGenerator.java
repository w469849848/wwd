package com.egolm.tpl.generator;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.velocity.VelocityContext;
import org.springframework.plugin.util.U;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.egolm.tpl.generator.bean.Advert;
import com.egolm.tpl.utils.HttpHandler;
import com.egolm.tpl.web.TplSettingPopController;


public abstract class ModuleGenerator {

	public abstract void generate(VelocityContext ctx, JSONObject jsonRoot,String zoneCode, String floorId, String sScopeTypeID);
	
	protected Advert getAdvert(String nApID,String zoneCode){
		Advert advert=new Advert();
		Map<String, String> rightMap=new HashMap<String,String>();
		rightMap.put("orgNO", zoneCode);//区域编号
		rightMap.put("apID", nApID);//广告位编号
		System.out.println("request parameber:::::::::::::::orgNO="+zoneCode+";apID="+nApID);
		JSONObject adJson = HttpHandler.post(TplSettingPopController.HTTP_AD,rightMap);
		JSONArray adArray=adJson.getJSONArray("DataList");
		if(adArray.size()>0){
			JSONObject adDataObject = adArray.getJSONObject(0);
			advert.setHeight(adDataObject.getString("nAdHeight"));
			advert.setId(adDataObject.getString("nAdID"));
			advert.setWidth(adDataObject.getString("nAdWidth"));
			advert.setImg("http://img.egolm.com/"+adDataObject.getString("sAdPathUrl")+"@"+adDataObject.getString("nAdHeight")+"h_"+adDataObject.getString("nAdWidth")+"w");
			advert.setUrl(adDataObject.getString("sAdJumpUrl"));
			if(U.isBlank(advert.getUrl())){
				advert.setUrl("javascript:void(0)");
			}else{
				advert.setUrl(" /egolm-shop-web/shop/advertRedirect?id="+advert.getId());
			}
			advert.setApId(nApID);
			//判断是显示广告图片，还是显示商品信息
			String nAdShowGoodsMsgID=adDataObject.getString("nAdShowGoodsMsgID");
			if("1".equals(nAdShowGoodsMsgID)){
				advert.setProductName(adDataObject.getString("sGoodsDesc"));
				advert.setProductPrice(formatPrice(adDataObject.getString("nRealSalePrice")));
				
				advert.setProductUnit(adDataObject.getString("sUnit"));
			}
		}else{//如果没有默认广告，就获取广告位默认信息
			JSONObject apJson = HttpHandler.post(TplSettingPopController.HTTP_APID,rightMap);
			JSONObject ap = apJson.getJSONObject("DataList");
			advert.setHeight(ap.getString("nApHeight"));
			advert.setId(ap.getString("nApID"));
			advert.setWidth(ap.getString("nApWidth"));
			advert.setImg("http://img.egolm.com/"+ap.getString("sApPathUrl")+"@"+ap.getString("nApHeight")+"h_"+ap.getString("nApWidth")+"w");
			advert.setUrl(ap.getString("sApJumpUrl"));
			if(U.isBlank(advert.getUrl())){
				advert.setUrl("javascript:void(0)");
			}else{
				advert.setUrl(" /egolm-shop-web/shop/advertRedirect?id="+advert.getId());
			}
			advert.setApId(nApID);
		}
		return advert;
	}
	
	private  String formatPrice(String price){
		try {
			DecimalFormat format=new DecimalFormat("######0.00");  
			return format.format(Double.parseDouble(price));
		} catch (Exception e) {
			e.printStackTrace();
			return price;
		}
	}
	
	protected List<Advert> getAdvertList(String nApID,String zoneCode){
		List<Advert> advertList=new ArrayList<Advert>();
		Map<String, String> map=new HashMap<String,String>();
		map.put("orgNO", zoneCode);//区域编号
		map.put("apID", nApID);//广告位编号
		JSONObject adJson = HttpHandler.post(TplSettingPopController.HTTP_AD,map);
		JSONArray adArray=adJson.getJSONArray("DataList");
		for (int i = 0; i < adArray.size(); i++) {
			JSONObject adObject = adArray.getJSONObject(i);
			Advert advert=new Advert();
			advert.setHeight(adObject.getString("nAdHeight"));
			advert.setId(adObject.getString("nAdID"));
			advert.setWidth(adObject.getString("nAdWidth"));
			advert.setImg("http://img.egolm.com/"+adObject.getString("sAdPathUrl")+"@"+adObject.getString("nAdHeight")+"h_"+adObject.getString("nAdWidth")+"w");
			advert.setUrl(adObject.getString("sAdJumpUrl"));
			if(U.isBlank(advert.getUrl())){
				advert.setUrl("javascript:void(0)");
			}else{
				advert.setUrl(" /egolm-shop-web/shop/advertRedirect?id="+advert.getId());
			}
			advert.setApId(nApID);
			
			//判断是显示广告图片，还是显示商品信息
			String nAdShowGoodsMsgID=adObject.getString("nAdShowGoodsMsgID");
			if("1".equals(nAdShowGoodsMsgID)){
				advert.setProductName(adObject.getString("sGoodsDesc"));
				advert.setProductPrice(formatPrice(adObject.getString("nRealSalePrice")));
				advert.setProductUnit(adObject.getString("sUnit"));
			}
			advertList.add(advert);
		}
		//如果没有默认广告，就获取广告位默认信息
		if(advertList.size()==0){
			Advert advert=new Advert();
			JSONObject apJson = HttpHandler.post(TplSettingPopController.HTTP_APID,map);
			JSONObject ap = apJson.getJSONObject("DataList");
			advert.setHeight(ap.getString("nApHeight"));
			advert.setId(ap.getString("nApID"));
			advert.setWidth(ap.getString("nApWidth"));
			advert.setImg("http://img.egolm.com/"+ap.getString("sApPathUrl")+"@"+ap.getString("nApHeight")+"h_"+ap.getString("nApWidth")+"w");
			advert.setUrl(ap.getString("sApJumpUrl"));
			if(U.isBlank(advert.getUrl())){
				advert.setUrl("javascript:void(0)");
			}else{
				advert.setUrl(" /egolm-shop-web/shop/advertRedirect?id="+advert.getId());
			}
			advert.setApId(nApID);
			advertList.add(advert);
		}
		
		return advertList;
	}
}
