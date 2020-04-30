package com.carre.vo;

import java.io.Serializable;
import java.util.Date;

public class TestVO implements Serializable {
	private Integer id;
	private Date createTime;
	private Integer totalWords;
	private Double correctRate;
	private Integer testType;
	public TestVO() {
		super();
	}
	public TestVO(Integer id, Date createTime, Integer totalWords, Double correctRate, Integer testType) {
		super();
		this.id = id;
		this.createTime = createTime;
		this.totalWords = totalWords;
		this.correctRate = correctRate;
		this.testType = testType;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
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
	public Integer getTestType() {
		return testType;
	}
	public void setTestType(Integer testType) {
		this.testType = testType;
	}
	@Override
	public String toString() {
		return "TestVO [id=" + id + ", createTime=" + createTime + ", totalWords=" + totalWords + ", correctRate="
				+ correctRate + ", testType=" + testType + "]";
	}
	
}
