package com.carre.entity;

import java.io.Serializable;
import java.util.Date;

public class User implements Serializable {
	
	private Integer id;
	
	private String username;
	
	private String password;
	
	private String name;
	
	private Integer gender;
	
	private String info;
	
	private String email;
	
	private Integer universityId;
	
	private Date RegistTime;
	
	private University university;

	public User() {
		super();
	}

	public User(Integer id, String username, String password, String name, Integer gender, String info, String email,
			Integer universityId, Date registTime) {
		super();
		this.id = id;
		this.username = username;
		this.password = password;
		this.name = name;
		this.gender = gender;
		this.info = info;
		this.email = email;
		this.universityId = universityId;
		RegistTime = registTime;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getGender() {
		return gender;
	}

	public void setGender(Integer gender) {
		this.gender = gender;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Integer getUniversityId() {
		return universityId;
	}

	public void setUniversityId(Integer universityId) {
		this.universityId = universityId;
	}

	public Date getRegistTime() {
		return RegistTime;
	}

	public void setRegistTime(Date registTime) {
		RegistTime = registTime;
	}

	public University getUniversity() {
		return university;
	}

	public void setUniversity(University university) {
		this.university = university;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", username=" + username + ", password=" + password + ", name=" + name + ", gender="
				+ gender + ", info=" + info + ", email=" + email + ", universityId=" + universityId + ", RegistTime="
				+ RegistTime + ", university=" + university + "]";
	}
	
}
