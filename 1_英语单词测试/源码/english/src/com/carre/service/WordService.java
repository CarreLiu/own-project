package com.carre.service;

import java.util.Date;
import java.util.List;

import com.carre.action.WordEnglishExistException;
import com.carre.entity.Word;
import com.carre.vo.WordVO;

public interface WordService {
	public void addWord(Word word) throws Exception;

	public List<Word> findAllWords(Date beginDate, Date endDate);

	public void modifyErrorWords(List<WordVO> errorList) throws Exception;

	public void modifyCorrectWords(List<WordVO> correctList) throws Exception;

	public List<Word> findWordsByIds(List<Integer> idList);

	public Word findByWordEnglish(String english) throws WordEnglishExistException;
}
