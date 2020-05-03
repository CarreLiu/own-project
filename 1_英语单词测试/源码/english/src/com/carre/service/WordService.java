package com.carre.service;

import java.util.Date;
import java.util.List;

import com.carre.entity.Word;
import com.carre.exception.WordEnglishExistException;
import com.carre.vo.WordVO;

public interface WordService {
	public void addWord(Word word) throws Exception;

	public List<Word> findWordsByDate(Date beginDate, Date endDate);

	public void modifyErrorWords(List<WordVO> errorList) throws Exception;

	public void modifyCorrectWords(List<WordVO> correctList) throws Exception;

	public List<Word> findWordsByIds(List<Integer> idList);

	public Word findByWordEnglish(String english) throws WordEnglishExistException;

	public List<Word> findAllWords();

	public Word findWordById(Integer id);

	public void modifyWord(Word modifyWord) throws Exception;
}
