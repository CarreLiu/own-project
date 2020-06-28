package com.carre.vo;

import java.util.Date;

public class WordVO2 {

	private Integer userId;
	
	private Integer status;
	
	private String English;
	
	private String Chinese;
	
	private Date beginDate;
	
	private Date endDate;

	public WordVO2() {
		super();
	}

	public WordVO2(Integer userId, Integer status, String english, String chinese, Date beginDate, Date endDate) {
		super();
		this.userId = userId;
		this.status = status;
		English = english;
		Chinese = chinese;
		this.beginDate = beginDate;
		this.endDate = endDate;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getEnglish() {
		return English;
	}

	public void setEnglish(String english) {
		English = english;
	}

	public String getChinese() {
		return Chinese;
	}

	public void setChinese(String chinese) {
		Chinese = chinese;
	}

	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}

	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	@Override
	public String toString() {
		return "WordVO2 [userId=" + userId + ", status=" + status + ", English=" + English + ", Chinese=" + Chinese
				+ ", beginDate=" + beginDate + ", endDate=" + endDate + "]";
	}
	
	
}
