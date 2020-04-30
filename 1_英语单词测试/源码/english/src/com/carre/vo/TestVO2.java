package com.carre.vo;

import java.io.Serializable;
import java.util.Date;

//用于查询给定时间区间的测试记录
public class TestVO2 implements Serializable {
	private Integer testType;
	private Date beginDate;
	private Date endDate;
	public TestVO2() {
		super();
	}
	public TestVO2(Integer testType, Date beginDate, Date endDate) {
		super();
		this.testType = testType;
		this.beginDate = beginDate;
		this.endDate = endDate;
	}
	public Integer getTestType() {
		return testType;
	}
	public void setTestType(Integer testType) {
		this.testType = testType;
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
		return "TestVO2 [testType=" + testType + ", beginDate=" + beginDate + ", endDate=" + endDate + "]";
	}
	
}
