package com.carre.entity;

import java.io.Serializable;

public class TestDetail implements Serializable {
	
	private Integer id;
	
	private String allWords;
	
	private String errorWords;
	
	private String correctWords;

	public TestDetail() {
		super();
	}

	public TestDetail(Integer id, String allWords, String errorWords, String correctWords) {
		super();
		this.id = id;
		this.allWords = allWords;
		this.errorWords = errorWords;
		this.correctWords = correctWords;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
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

	@Override
	public String toString() {
		return "TestDetail [id=" + id + ", allWords=" + allWords + ", errorWords=" + errorWords + ", correctWords="
				+ correctWords + "]";
	}
	
}
