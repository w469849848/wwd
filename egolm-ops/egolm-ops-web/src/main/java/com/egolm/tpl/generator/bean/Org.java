package com.egolm.tpl.generator.bean;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Org {
	private String id;
	private String name;
	private List<Org> children = new ArrayList<Org>();
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
	public List<Org> getChildren() {
		return children;
	}
	public void setChildren(List<Org> children) {
		this.children = children;
	}
}
