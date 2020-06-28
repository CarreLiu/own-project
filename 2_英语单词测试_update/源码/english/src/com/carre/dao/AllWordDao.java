package com.carre.dao;

import java.util.List;

import com.carre.entity.Word;

public interface AllWordDao {

	public String selectChinese(String english);

	public List<Word> selectWordByCondition(Word word);

}
