package com.carre.vo;

import java.io.Serializable;
import java.util.Date;

//用于查询给定时间区间的测试记录
public class TestVO implements Serializable {
	
	private Integer userId;
	
	private Integer testTypeId;
	
	private Date beginDate;
	
	private Date endDate;

	public TestVO() {
		super();
	}

	public TestVO(Integer userId, Integer testTypeId, Date beginDate, Date endDate) {
		super();
		this.userId = userId;
		this.testTypeId = testTypeId;
		this.beginDate = beginDate;
		this.endDate = endDate;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public Integer getTestTypeId() {
		return testTypeId;
	}

	public void setTestTypeId(Integer testTypeId) {
		this.testTypeId = testTypeId;
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
		return "TestVO2 [userId=" + userId + ", testTypeId=" + testTypeId + ", beginDate=" + beginDate + ", endDate="
				+ endDate + "]";
	}
	
	
}
