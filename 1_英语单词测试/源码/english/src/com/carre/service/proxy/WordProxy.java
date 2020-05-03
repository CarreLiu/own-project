package com.carre.service.proxy;

import java.util.Date;
import java.util.List;

import com.carre.entity.Word;
import com.carre.exception.DataAccessException;
import com.carre.exception.ServiceException;
import com.carre.exception.WordEnglishExistException;
import com.carre.factory.ObjectFactory;
import com.carre.service.WordService;
import com.carre.transaction.TransactionManager;
import com.carre.vo.WordVO;

public class WordProxy implements WordService {

	@Override
	public void addWord(Word word) throws Exception {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		WordService wordService = (WordService) ObjectFactory.getObject("wordService");
		try {
			tran.beginTransaction();
			wordService.addWord(word);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
	}

	@Override
	public List<Word> findWordsByDate(Date beginDate, Date endDate) {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		WordService wordService = (WordService) ObjectFactory.getObject("wordService");
		List<Word> wordList = null;
		try {
			tran.beginTransaction();
			wordList = wordService.findWordsByDate(beginDate, endDate);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
		
		return wordList;
	}

	@Override
	public void modifyErrorWords(List<WordVO> errorList) throws Exception {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		WordService wordService = (WordService) ObjectFactory.getObject("wordService");
		try {
			tran.beginTransaction();
			wordService.modifyErrorWords(errorList);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
	}

	@Override
	public void modifyCorrectWords(List<WordVO> correctList) throws Exception {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		WordService wordService = (WordService) ObjectFactory.getObject("wordService");
		try {
			tran.beginTransaction();
			wordService.modifyCorrectWords(correctList);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
	}

	@Override
	public List<Word> findWordsByIds(List<Integer> idList) {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		WordService wordService = (WordService) ObjectFactory.getObject("wordService");
		List<Word> wordList = null;
		try {
			tran.beginTransaction();
			wordList = wordService.findWordsByIds(idList);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
		
		return wordList;
	}

	@Override
	public Word findByWordEnglish(String english) throws WordEnglishExistException {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		WordService wordService = (WordService) ObjectFactory.getObject("wordService");
		Word word = null;
		try {
			tran.beginTransaction();
			word = wordService.findByWordEnglish(english);
			tran.commit();
		} catch (WordEnglishExistException e) {
			throw e;
		}
		
		return word;
	}

	@Override
	public List<Word> findAllWords() {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		WordService wordService = (WordService) ObjectFactory.getObject("wordService");
		List<Word> wordList = null;
		try {
			tran.beginTransaction();
			wordList = wordService.findAllWords();
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
		
		return wordList;
	}

	@Override
	public Word findWordById(Integer id) {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		WordService wordService = (WordService) ObjectFactory.getObject("wordService");
		Word word = null;
		try {
			tran.beginTransaction();
			word = wordService.findWordById(id);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
		
		return word;
	}

	@Override
	public void modifyWord(Word word) throws Exception {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		WordService wordService = (WordService) ObjectFactory.getObject("wordService");
		try {
			tran.beginTransaction();
			wordService.modifyWord(word);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
	}

}
