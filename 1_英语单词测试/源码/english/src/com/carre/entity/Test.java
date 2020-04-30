package com.carre.entity;

import java.io.Serializable;
import java.util.Date;

public class Test implements Serializable {
	private Integer id;
	private Integer totalWords;
	private Double correctRate;
	private String allWords;
	private String errorWords;
	private String correctWords;
	private Integer testType;
	private Date createTime;
	public Test() {
		super();
	}
	public Test(Integer id, Integer totalWords, Double correctRate, String allWords, String errorWords,
			String correctWords, Integer testType, Date createTime) {
		super();
		this.id = id;
		this.totalWords = totalWords;
		this.correctRate = correctRate;
		this.allWords = allWords;
		this.errorWords = errorWords;
		this.correctWords = correctWords;
		this.testType = testType;
		this.createTime = createTime;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
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
	public String getAllWords() {
		return allWords;
	}
	public void setAllWords(String allWords) {
		this.allWords = allWords;
	}
	public String getErrorWords() {
		return errorWords;
	}
	public void setErrorWords(String errorWords) {
		this.errorWords = errorWords;
	}
	public String getCorrectWords() {
		return correctWords;
	}
	public void setCorrectWords(String correctWords) {
		this.correctWords = correctWords;
	}
	public Integer getTestType() {
		return testType;
	}
	public void setTestType(Integer testType) {
		this.testType = testType;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	@Override
	public String toString() {
		return "Test [id=" + id + ", totalWords=" + totalWords + ", correctRate=" + correctRate + ", allWords="
				+ allWords + ", errorWords=" + errorWords + ", correctWords=" + correctWords + ", testType=" + testType
				+ ", createTime=" + createTime + "]";
	}
	
	
	
}
