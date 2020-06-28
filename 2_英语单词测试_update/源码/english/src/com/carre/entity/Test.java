package com.carre.entity;

import java.io.Serializable;
import java.util.Date;

public class Test implements Serializable {
	
	private Integer id;
	
	private Integer userId;
	
	private Integer ownTestId;
	
	private Integer totalWords;
	
	private Double correctRate;
	
	private Integer testDetailId;
	
	private Integer testTypeId;
	
	private Date createTime;
	
	private TestDetail testDetail;
	
	private TestType testType;

	public Test() {
		super();
	}

	public Test(Integer id, Integer userId, Integer ownTestId, Integer totalWords, Double correctRate,
			Integer testDetailId, Integer testTypeId, Date createTime) {
		super();
		this.id = id;
		this.userId = userId;
		this.ownTestId = ownTestId;
		this.totalWords = totalWords;
		this.correctRate = correctRate;
		this.testDetailId = testDetailId;
		this.testTypeId = testTypeId;
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

	public Integer getOwnTestId() {
		return ownTestId;
	}

	public void setOwnTestId(Integer ownTestId) {
		this.ownTestId = ownTestId;
	}

	public Integer getTotalWords() {
		return totalWords;
	}

	public void setTotalWords(Integer totalWords) {
		this.totalWords = totalWords;
	}

	public Double getCorrectRate() {
		return correctRate;
	}

	public void setCorrectRate(Double correctRate) {
		this.correctRate = correctRate;
	}

	public Integer getTestDetailId() {
		return testDetailId;
	}

	public void setTestDetailId(Integer testDetailId) {
		this.testDetailId = testDetailId;
	}

	public Integer getTestTypeId() {
		return testTypeId;
	}

	public void setTestTypeId(Integer testTypeId) {
		this.testTypeId = testTypeId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public TestDetail getTestDetail() {
		return testDetail;
	}

	public void setTestDetail(TestDetail testDetail) {
		this.testDetail = testDetail;
	}

	public TestType getTestType() {
		return testType;
	}

	public void setTestType(TestType testType) {
		this.testType = testType;
	}

	@Override
	public String toString() {
		return "Test [id=" + id + ", userId=" + userId + ", ownTestId=" + ownTestId + ", totalWords=" + totalWords
				+ ", correctRate=" + correctRate + ", testDetailId=" + testDetailId + ", testTypeId=" + testTypeId
				+ ", createTime=" + createTime + ", testDetail=" + testDetail + ", testType=" + testType + "]";
	}
	
	
}
