package com.egolm.goods.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;

import org.apache.commons.lang.StringUtils;
import org.springframework.plugin.util.StringUtil;
import org.springframework.plugin.util.To;

public class ReadText {
	static String filePath = "d:/read.txt";
	public static void main(String[] args) {
		try {
			String encoding="UTF-8"; 
			File file=new File(filePath);
			if(file.isFile() && file.exists()){ //判断文件是否存在
			    InputStreamReader read = new InputStreamReader(
			    new FileInputStream(file),encoding);//考虑到编码格式
			    BufferedReader bufferedReader = new BufferedReader(read);
			    String lineTxt = null;
			    String str  = "";
			    while((lineTxt = bufferedReader.readLine()) != null){
			        if(StringUtils.isNotEmpty(lineTxt)){
			        	lineTxt = lineTxt.trim();
			        	//打印request 方法
				        //String a = "\""+lineTxt+"\"";
				        //System.out.println(" String  "+lineTxt+"   = request.getParameter("+a+"); ");
			        	//System.out.println(To.toMap(lineTxt));
			        	//System.out.println(lineTxt);
			        	
			        	 String[] strArry = lineTxt.split("@");
			        	 
			        	StringBuffer sbuf = new StringBuffer();
			        	sbuf.append(" update tShopAdvert  set  sAdJumpTypeId = 'goods' , sAdJumpType ='商品' , ");
			        	sbuf.append("  sAdJumpNo = (select sGoodsNO from tGoods where sMainBarcode in ('"+strArry[0]+"')  ) , ");
			        	sbuf.append("  sAdJumpUrl = '/egolm-shop-web/goods/detail?goodsID='+(select sGoodsNO from tGoods where sMainBarcode in ('"+strArry[0]+"') )  ");
			        	sbuf.append("  where sAdTitle = '"+strArry[1]+"' and  sAdZoneCodeID = 'SUZU'; "); 
			        	
			        	System.out.println(sbuf.toString()); 
			        	
			        	//str +="'"+lineTxt.trim()+"',";
			        }
			        
			    }
			   /* str = str.substring(0,str.length()-1);
			    System.out.println(str);*/
			    read.close();
			}
		}   catch (IOException e) {
 			e.printStackTrace();
		}
		 
		//System.out.println("五粮液52度整箱装500ml*6瓶".contains("23"));
		/*boolean isSelectByCategoryNo = true; 
		boolean isSelectBysBrandNo = true; 
		boolean isSelectByDescOrBarcode = false;
		
		if(isSelectByCategoryNo || isSelectBysBrandNo || isSelectByDescOrBarcode){
			System.out.println("中");
		}else{
			System.out.println("未中");
		}
		
		String a1 = "";
		String a2= "";
		String a3 = "";
		if(!StringUtil.isNotEmpty(a1) && !StringUtil.isNotEmpty(a2)  && !StringUtil.isNotEmpty(a3)){
			System.out.println("为空");
		}else{
			System.out.println("不为空");
		}*/
	} 
}
