package com.carre.service.proxy;

import java.util.List;

import com.carre.entity.Word;
import com.carre.exception.DataAccessException;
import com.carre.exception.InputEmptyException;
import com.carre.exception.ServiceException;
import com.carre.exception.WordEnglishExistException;
import com.carre.exception.WordNotFoundException;
import com.carre.factory.ObjectFactory;
import com.carre.service.WordService;
import com.carre.transaction.TransactionManager;
import com.carre.vo.WordVO;
import com.carre.vo.WordVO2;

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
	public List<Word> findEnabledWordsByDate(WordVO2 word) {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		WordService wordService = (WordService) ObjectFactory.getObject("wordService");
		List<Word> wordList = null;
		try {
			tran.beginTransaction();
			wordList = wordService.findEnabledWordsByDate(word);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
		
		return wordList;
	}

	@Override
	public List<Word> findEnabledWordsByIds(List<Integer> idList) {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		WordService wordService = (WordService) ObjectFactory.getObject("wordService");
		List<Word> wordList = null;
		try {
			tran.beginTransaction();
			wordList = wordService.findEnabledWordsByIds(idList);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
		
		return wordList;
	}

	@Override
	public List<Word> findWordsByDate(WordVO2 word) {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		WordService wordService = (WordService) ObjectFactory.getObject("wordService");
		List<Word> wordList = null;
		try {
			tran.beginTransaction();
			wordList = wordService.findWordsByDate(word);
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
	public Word findByWordEnglish(Integer userId, String english) throws WordEnglishExistException {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		WordService wordService = (WordService) ObjectFactory.getObject("wordService");
		Word word = null;
		try {
			tran.beginTransaction();
			word = wordService.findByWordEnglish(userId, english);
			tran.commit();
		} catch (WordEnglishExistException e) {
			throw e;
		}
		
		return word;
	}

	@Override
	public List<Word> findAllWords(WordVO2 word) {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		WordService wordService = (WordService) ObjectFactory.getObject("wordService");
		List<Word> wordList = null;
		try {
			tran.beginTransaction();
			wordList = wordService.findAllWords(word);
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
	
	@Override
	public Word findWordByEnglish(Integer userId, String english) throws InputEmptyException, WordNotFoundException {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		WordService wordService = (WordService) ObjectFactory.getObject("wordService");
		Word word = null;
		try {
			tran.beginTransaction();
			word = wordService.findWordByEnglish(userId, english);
			tran.commit();
		} catch (Exception e) {
			tran.rollback();
			throw e;
		}
		
		return word;
	}

	@Override
	public void modifyWordCreateTime(Integer id) {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		WordService wordService = (WordService) ObjectFactory.getObject("wordService");
		try {
			tran.beginTransaction();
			wordService.modifyWordCreateTime(id);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
	}

	@Override
	public void modifyWordStatus(Integer id, Integer status) {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		WordService wordService = (WordService) ObjectFactory.getObject("wordService");
		try {
			tran.beginTransaction();
			wordService.modifyWordStatus(id, status);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
	}

	@Override
	public void modifyWordFavoriteStatus(Integer id, Integer isFavorite) {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		WordService wordService = (WordService) ObjectFactory.getObject("wordService");
		try {
			tran.beginTransaction();
			wordService.modifyWordFavoriteStatus(id, isFavorite);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
	}

}
