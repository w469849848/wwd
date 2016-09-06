package com.egolm.tpl.generator.bean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 首页banner广告图片值对象
 * @author zhangzhi
 *
 */
public class Advert {
	
	private String tabTitle;
	private String id;
	private String apId;
	private String img;
	private String width;
	private String height;
	private String url;
	
	private String productName;
	private String productPrice;
	private String productUnit;
	
	
	private List<Advert> advertList=new ArrayList<Advert>();
	
	private List<Category> categoryList=new ArrayList<Category>();
	
	private List<List<Advert>> childAdvertList=new ArrayList<List<Advert>>();
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getWidth() {
		return width;
	}
	public void setWidth(String width) {
		this.width = width;
	}
	public String getHeight() {
		return height;
	}
	public void setHeight(String height) {
		this.height = height;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getTabTitle() {
		return tabTitle;
	}
	public void setTabTitle(String tabTitle) {
		this.tabTitle = tabTitle;
	}
	public List<Advert> getAdvertList() {
		return advertList;
	}
	public void setAdvertList(List<Advert> advertList) {
		this.advertList = advertList;
	}
	public String getApId() {
		return apId;
	}
	public void setApId(String apId) {
		this.apId = apId;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(String productPrice) {
		this.productPrice = productPrice;
	}
	public String getProductUnit() {
		return productUnit;
	}
	public void setProductUnit(String productUnit) {
		this.productUnit = productUnit;
	}
	public List<Category> getCategoryList() {
		return categoryList;
	}
	public void setCategoryList(List<Category> categoryList) {
		this.categoryList = categoryList;
	}
	public List<List<Advert>> getChildAdvertList() {
		return childAdvertList;
	}
	public void setChildAdvertList(List<List<Advert>> childAdvertList) {
		this.childAdvertList = childAdvertList;
	}
	
}
