package com.carre.service.impl;

import java.util.List;

import com.carre.dao.AllWordDao;
import com.carre.entity.Word;
import com.carre.factory.ObjectFactory;
import com.carre.service.AllWordService;

public class AllWordServiceImpl implements AllWordService {

	@Override
	public String findChinese(String english) {
		AllWordDao allWordDao = (AllWordDao) ObjectFactory.getObject("allWordDao");
		String chinese = allWordDao.selectChinese(english);
		
		return chinese;
	}

	@Override
	public List<Word> findWordByCondition(Word word) {
		AllWordDao allWordDao = (AllWordDao) ObjectFactory.getObject("allWordDao");
		List<Word> wordList = allWordDao.selectWordByCondition(word);
		
		return wordList;
	}

}
