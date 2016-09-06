package com.egolm.tpl.generator.module;

import java.util.ArrayList;
import java.util.List;

import org.apache.velocity.VelocityContext;
import org.springframework.stereotype.Component;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.egolm.tpl.generator.ModuleGenerator;
import com.egolm.tpl.generator.bean.Product;

@Component("product1ModuleGenerator")
public class Product1ModuleGenerator extends ModuleGenerator {
	

	@Override
	public void generate(VelocityContext ctx,JSONObject jsonRoot,String zoneCode,String floorId,String sScopeTypeID) {
		List<Product> productList=new ArrayList<Product>();//商品分类集合;
		
		JSONArray productJsonArray = jsonRoot.getJSONArray("datas");
		
		for (int i = 0; i < productJsonArray.size(); i++) {
			JSONObject productObject = productJsonArray.getJSONObject(i);
			Product product=new Product();
			String title=productObject.getString("name");
			JSONArray productArray=productObject.getJSONArray("goods");
			List<Product> childProductList=new ArrayList<Product>();
			for (int j = 0; j < productArray.size(); j++) {
				JSONObject productObject2 = productArray.getJSONObject(j);
				Product childProduct=new Product();
				childProduct.setId(productObject2.getString("goodsId"));
				childProduct.setImg(productObject2.getString("imgPath")+"@!160_180");
				childProduct.setTitle(productObject2.getString("goodsName"));
				childProduct.setPrice(productObject2.getString("normalSalesPrice"));
				childProductList.add(childProduct);
			}
			product.setProductList(childProductList);
			product.setTitle(title);
			productList.add(product);
		}
		ctx.put("productList", productList);
	}
	
}
