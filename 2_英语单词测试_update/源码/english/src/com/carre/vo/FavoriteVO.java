package com.carre.vo;

import java.io.Serializable;
import java.util.Date;

public class FavoriteVO implements Serializable {
	
	private Integer userId;
	
	private Date beginDate;
	
	private Date endDate;

	public FavoriteVO() {
		super();
	}

	public FavoriteVO(Integer userId, Date beginDate, Date endDate) {
		super();
		this.userId = userId;
		this.beginDate = beginDate;
		this.endDate = endDate;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
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
		return "FavoriteVO [userId=" + userId + ", beginDate=" + beginDate + ", endDate=" + endDate + "]";
	}
	
	
}
