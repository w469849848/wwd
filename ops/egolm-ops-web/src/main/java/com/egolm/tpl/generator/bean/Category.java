package com.egolm.tpl.generator.bean;

import java.util.ArrayList;
import java.util.List;

/**
 * 首页商品分类值对象
 * @author zhangzhi
 *
 */
public class Category {

	private String id;
	private String name;
	private List<Category> children=new ArrayList<Category>();
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public List<Category> getChildren() {
		return children;
	}
	public void setChildren(List<Category> children) {
		this.children = children;
	}
}
