package com.carre.entity;

import java.io.Serializable;

public class University implements Serializable {
	
	private Integer id;
	
	private String name;
	
	private Integer number;

	public University() {
		super();
	}

	public University(Integer id, String name, Integer number) {
		super();
		this.id = id;
		this.name = name;
		this.number = number;
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

	public Integer getNumber() {
		return number;
	}

	public void setNumber(Integer number) {
		this.number = number;
	}

	@Override
	public String toString() {
		return "University [id=" + id + ", name=" + name + ", number=" + number + "]";
	}
	
}
