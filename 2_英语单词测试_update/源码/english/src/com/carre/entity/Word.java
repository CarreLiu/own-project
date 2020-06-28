package com.carre.entity;

import java.io.Serializable;
import java.util.Date;

public class Word implements Serializable {
	
	private Integer id;
	
	private Integer userId;
	
	private String english;
	
	private String chinese;
	
	private Integer status;
	
	private Integer isFavorite;
	
	private Integer errorTimes;
	
	private Integer correctTimes;
	
	private Date createTime;
	
	public Word() {
		super();
	}

	public Word(Integer id, Integer userId, String english, String chinese, Integer status, Integer isFavorite,
			Integer errorTimes, Integer correctTimes, Date createTime) {
		super();
		this.id = id;
		this.userId = userId;
		this.english = english;
		this.chinese = chinese;
		this.status = status;
		this.isFavorite = isFavorite;
		this.errorTimes = errorTimes;
		this.correctTimes = correctTimes;
		this.createTime = createTime;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getEnglish() {
		return english;
	}

	public void setEnglish(String english) {
		this.english = english;
	}

	public String getChinese() {
		return chinese;
	}

	public void setChinese(String chinese) {
		this.chinese = chinese;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getIsFavorite() {
		return isFavorite;
	}

	public void setIsFavorite(Integer isFavorite) {
		this.isFavorite = isFavorite;
	}

	public Integer getErrorTimes() {
		return errorTimes;
	}

	public void setErrorTimes(Integer errorTimes) {
		this.errorTimes = errorTimes;
	}

	public Integer getCorrectTimes() {
		return correctTimes;
	}

	public void setCorrectTimes(Integer correctTimes) {
		this.correctTimes = correctTimes;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Override
	public String toString() {
		return "Word [id=" + id + ", userId=" + userId + ", english=" + english + ", chinese=" + chinese + ", status="
				+ status + ", isFavorite=" + isFavorite + ", errorTimes=" + errorTimes + ", correctTimes="
				+ correctTimes + ", createTime=" + createTime + "]";
	}


}
