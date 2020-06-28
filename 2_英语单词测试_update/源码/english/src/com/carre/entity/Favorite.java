package com.carre.entity;

import java.io.Serializable;
import java.util.Date;

public class Favorite implements Serializable {
	
	private Integer id;
	
	private Integer userId;
	
	private Integer wordId;
	
	private Date joinTime;
	
	private Word word;

	public Favorite() {
		super();
	}

	public Favorite(Integer id, Integer userId, Integer wordId, Date joinTime) {
		super();
		this.id = id;
		this.userId = userId;
		this.wordId = wordId;
		this.joinTime = joinTime;
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

	public Integer getWordId() {
		return wordId;
	}

	public void setWordId(Integer wordId) {
		this.wordId = wordId;
	}

	public Date getJoinTime() {
		return joinTime;
	}

	public void setJoinTime(Date joinTime) {
		this.joinTime = joinTime;
	}

	public Word getWord() {
		return word;
	}

	public void setWord(Word word) {
		this.word = word;
	}

	@Override
	public String toString() {
		return "Favorite [id=" + id + ", userId=" + userId + ", wordId=" + wordId + ", joinTime=" + joinTime + ", word="
				+ word + "]";
	}

}
