package com.carre.service;

import java.util.List;

import com.carre.entity.Word;

public interface AllWordService {

	public String findChinese(String english);

	public List<Word> findWordByCondition(Word word);
	
}
