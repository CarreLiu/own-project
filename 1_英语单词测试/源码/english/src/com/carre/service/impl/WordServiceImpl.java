package com.carre.service.impl;

import java.util.Date;
import java.util.List;

import com.carre.action.WordEnglishExistException;
import com.carre.dao.WordDao;
import com.carre.entity.Word;
import com.carre.factory.ObjectFactory;
import com.carre.service.WordService;
import com.carre.vo.WordVO;

public class WordServiceImpl implements WordService {

	@Override
	public void addWord(Word word) throws Exception {
		WordDao wordDao = (WordDao) ObjectFactory.getObject("wordDao");
		word.setCreateTime(new Date());
		wordDao.insertWord(word);
	}

	@Override
	public List<Word> findAllWords(Date beginDate, Date endDate) {
		WordDao wordDao = (WordDao) ObjectFactory.getObject("wordDao");
		List<Word> wordList = wordDao.selectAllWords(beginDate, endDate);
		
		return wordList;
	}

	@Override
	public void modifyErrorWords(List<WordVO> errorList) throws Exception {
		WordDao wordDao = (WordDao) ObjectFactory.getObject("wordDao");
		wordDao.updateErrorWords(errorList);
	}

	@Override
	public void modifyCorrectWords(List<WordVO> correctList) throws Exception {
		WordDao wordDao = (WordDao) ObjectFactory.getObject("wordDao");
		wordDao.updateCorrectWords(correctList);
	}

	@Override
	public List<Word> findWordsByIds(List<Integer> idList) {
		WordDao wordDao = (WordDao) ObjectFactory.getObject("wordDao");
		List<Word> wordList = wordDao.selectWordsByIds(idList);
		
		return wordList;
	}

	@Override
	public Word findByWordEnglish(String english) throws WordEnglishExistException {
		WordDao wordDao = (WordDao) ObjectFactory.getObject("wordDao");
		Word word = wordDao.selectByWordEnglish(english);
		if (word != null) {
			throw new WordEnglishExistException("英文单词(" + english + ")已存在");
		}
		return word;
	}

}
