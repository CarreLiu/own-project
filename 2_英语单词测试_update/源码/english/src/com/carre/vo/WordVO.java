package com.carre.vo;

import java.io.Serializable;
import java.util.Date;

public class WordVO implements Serializable {
	
	private Integer id;
	
	private Integer userId;
	
	private String english;
	
	private String answer;
	
	private String chinese;
	
	private Integer errorTimes;
	
	private Integer correctTimes;
	
	private Date createTime;
	
	public WordVO() {
		super();
	}

	public WordVO(Integer id, Integer userId, String english, String answer, String chinese, Integer errorTimes,
			Integer correctTimes, Date createTime) {
		super();
		this.id = id;
		this.userId = userId;
		this.english = english;
		this.answer = answer;
		this.chinese = chinese;
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
		return "WordVO [id=" + id + ", userId=" + userId + ", english=" + english + ", answer=" + answer + ", chinese="
				+ chinese + ", errorTimes=" + errorTimes + ", correctTimes=" + correctTimes + ", createTime="
				+ createTime + "]";
	}
	
	
}
