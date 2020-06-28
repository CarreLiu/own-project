package com.carre.entity;

import java.io.Serializable;

public class TestType implements Serializable {

	private Integer id;

	private String name;
	
	private String info;

	public TestType() {
		super();
	}

	public TestType(Integer id, String name, String info) {
		super();
		this.id = id;
		this.name = name;
		this.info = info;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	@Override
	public String toString() {
		return "TestType [id=" + id + ", name=" + name + ", info=" + info + "]";
	}
	
	
}
