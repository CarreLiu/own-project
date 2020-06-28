package com.carre.dao;

import java.util.Date;
import java.util.List;

import com.carre.entity.Word;
import com.carre.exception.DataAccessException;
import com.carre.vo.WordVO;
import com.carre.vo.WordVO2;

public interface WordDao {
	public void insertWord(Word word) throws DataAccessException;
	
	public List<Word> selectEnabledWordsByDate(WordVO2 word);

	public List<Word> selectEnabledWordsByIds(List<Integer> idList);

	public List<Word> selectWordsByDate(WordVO2 word);

	public void updateErrorWords(List<WordVO> errorList) throws DataAccessException;

	public void updateCorrectWords(List<WordVO> correctList) throws DataAccessException;

	public List<Word> selectWordsByIds(List<Integer> idList);

	public Word selectByWordEnglish(Integer userId, String english);

	public List<Word> selectAllWords(WordVO2 word);

	public Word selectWordById(Integer id);

	public void updateWord(Word word) throws DataAccessException;

	public void updateWordCreateTime(Integer id, Date date);

	public void updateWordStatus(Integer id, Integer status);

	public void updateWordFavoriteStatus(Integer id, Integer isFavorite);

}
