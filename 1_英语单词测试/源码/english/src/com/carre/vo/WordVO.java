package com.carre.vo;

import java.io.Serializable;
import java.util.Date;

public class WordVO implements Serializable {
	private Integer id;
	private String english;
	private String answer;
	private String chinese;
	private Date createTime;
	private Integer errorTimes;
	private Integer correctTimes;
	public WordVO() {
		super();
	}
	public WordVO(Integer id, String english, String answer, String chinese, Date createTime, Integer errorTimes,
			Integer correctTimes) {
		super();
		this.id = id;
		this.english = english;
		this.answer = answer;
		this.chinese = chinese;
		this.createTime = createTime;
		this.errorTimes = errorTimes;
		this.correctTimes = correctTimes;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getEnglish() {
		return english;
	}
	public void setEnglish(String english) {
		this.english = english;
	}
	public String getAnswer() {
		return answer;
	}
	public void setAnswer(String answer) {
		this.answer = answer;
	}
	public String getChinese() {
		return chinese;
	}
	public void setChinese(String chinese) {
		this.chinese = chinese;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
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
	@Override
	public String toString() {
		return "WordVO [id=" + id + ", english=" + english + ", answer=" + answer + ", chinese=" + chinese
				+ ", createTime=" + createTime + ", errorTimes=" + errorTimes + ", correctTimes=" + correctTimes + "]";
	}
	
}
