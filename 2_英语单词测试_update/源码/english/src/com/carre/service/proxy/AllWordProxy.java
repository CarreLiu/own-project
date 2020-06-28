package com.carre.service.proxy;

import java.util.List;

import com.carre.entity.Word;
import com.carre.exception.DataAccessException;
import com.carre.exception.ServiceException;
import com.carre.factory.ObjectFactory;
import com.carre.service.AllWordService;
import com.carre.transaction.TransactionManager;

public class AllWordProxy implements AllWordService {

	@Override
	public String findChinese(String english) {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		AllWordService allWordService = (AllWordService) ObjectFactory.getObject("allWordService");
		String chinese = null;
		try {
			tran.beginTransaction();
			chinese = allWordService.findChinese(english);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
		
		return chinese;
	}

	@Override
	public List<Word> findWordByCondition(Word word) {
		TransactionManager tran = (TransactionManager) ObjectFactory.getObject("transaction");
		AllWordService allWordService = (AllWordService) ObjectFactory.getObject("allWordService");
		List<Word> wordList = null;
		try {
			tran.beginTransaction();
			wordList = allWordService.findWordByCondition(word);
			tran.commit();
		} catch (DataAccessException e) {
			tran.rollback();
			throw new ServiceException(e);
		}
		
		return wordList;
	}

}
