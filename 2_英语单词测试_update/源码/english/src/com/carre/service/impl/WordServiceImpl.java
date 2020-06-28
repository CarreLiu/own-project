package com.carre.service.impl;

import java.util.Date;
import java.util.List;

import com.carre.dao.WordDao;
import com.carre.entity.Word;
import com.carre.exception.InputEmptyException;
import com.carre.exception.WordEnglishExistException;
import com.carre.exception.WordNotFoundException;
import com.carre.factory.ObjectFactory;
import com.carre.service.WordService;
import com.carre.vo.WordVO;
import com.carre.vo.WordVO2;

public class WordServiceImpl implements WordService {

	@Override
	public void addWord(Word word) throws Exception {
		WordDao wordDao = (WordDao) ObjectFactory.getObject("wordDao");
		word.setCreateTime(new Date());
		wordDao.insertWord(word);
	}
	
	@Override
	public List<Word> findEnabledWordsByDate(WordVO2 word) {
		WordDao wordDao = (WordDao) ObjectFactory.getObject("wordDao");
		List<Word> wordList = wordDao.selectEnabledWordsByDate(word);
		
		return wordList;
	}

	@Override
	public List<Word> findEnabledWordsByIds(List<Integer> idList) {
		WordDao wordDao = (WordDao) ObjectFactory.getObject("wordDao");
		List<Word> wordList = wordDao.selectEnabledWordsByIds(idList);
		
		return wordList;
	}

	@Override
	public List<Word> findWordsByDate(WordVO2 word) {
		WordDao wordDao = (WordDao) ObjectFactory.getObject("wordDao");
		List<Word> wordList = wordDao.selectWordsByDate(word);
		
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
	public Word findByWordEnglish(Integer userId, String english) throws WordEnglishExistException {
		WordDao wordDao = (WordDao) ObjectFactory.getObject("wordDao");
		Word word = wordDao.selectByWordEnglish(userId, english);
		if (word != null) {
			throw new WordEnglishExistException("英文单词(" + english + ")已存在");
		}
		return word;
	}

	@Override
	public List<Word> findAllWords(WordVO2 word) {
		WordDao wordDao = (WordDao) ObjectFactory.getObject("wordDao");
		List<Word> wordList = wordDao.selectAllWords(word);
		
		return wordList;
	}

	@Override
	public Word findWordById(Integer id) {
		WordDao wordDao = (WordDao) ObjectFactory.getObject("wordDao");
		Word word = wordDao.selectWordById(id);
		
		return word;
	}

	@Override
	public void modifyWord(Word word) throws Exception {
		WordDao wordDao = (WordDao) ObjectFactory.getObject("wordDao");
		wordDao.updateWord(word);
	}
	
	@Override
	public Word findWordByEnglish(Integer userId, String english) throws InputEmptyException, WordNotFoundException {
		if (english == "" || english == null) {
			throw new InputEmptyException("请输入英文单词");
		}
		
		WordDao wordDao = (WordDao) ObjectFactory.getObject("wordDao");
		Word word = wordDao.selectByWordEnglish(userId, english);
		if (word == null) {
			throw new WordNotFoundException("单词不在词库中，请先添加单词");
		}
		
		return word;
	}

	@Override
	public void modifyWordCreateTime(Integer id) {
		WordDao wordDao = (WordDao) ObjectFactory.getObject("wordDao");
		wordDao.updateWordCreateTime(id, new Date());
	}

	@Override
	public void modifyWordStatus(Integer id, Integer status) {
		WordDao wordDao = (WordDao) ObjectFactory.getObject("wordDao");
		wordDao.updateWordStatus(id, status);
	}

	@Override
	public void modifyWordFavoriteStatus(Integer id, Integer isFavorite) {
		WordDao wordDao = (WordDao) ObjectFactory.getObject("wordDao");
		wordDao.updateWordFavoriteStatus(id, isFavorite);
	}

}
