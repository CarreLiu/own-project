package com.carre.service;

import java.util.List;

import com.carre.entity.Word;
import com.carre.exception.InputEmptyException;
import com.carre.exception.WordEnglishExistException;
import com.carre.exception.WordNotFoundException;
import com.carre.vo.WordVO;
import com.carre.vo.WordVO2;

public interface WordService {
	public void addWord(Word word) throws Exception;
	
	public List<Word> findEnabledWordsByDate(WordVO2 word);
	
	public List<Word> findEnabledWordsByIds(List<Integer> idList);

	public List<Word> findWordsByDate(WordVO2 word);

	public void modifyErrorWords(List<WordVO> errorList) throws Exception;

	public void modifyCorrectWords(List<WordVO> correctList) throws Exception;

	public List<Word> findWordsByIds(List<Integer> idList);

	public Word findByWordEnglish(Integer userId, String english) throws WordEnglishExistException;

	public List<Word> findAllWords(WordVO2 word);

	public Word findWordById(Integer id);

	public void modifyWord(Word modifyWord) throws Exception;
	
	public Word findWordByEnglish(Integer userId, String english) throws InputEmptyException, WordNotFoundException;

	public void modifyWordCreateTime(Integer id);

	public void modifyWordStatus(Integer id, Integer status);

	public void modifyWordFavoriteStatus(Integer id, Integer isFavorite);

}
