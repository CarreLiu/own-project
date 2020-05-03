package com.carre.dao;

import java.util.Date;
import java.util.List;

import com.carre.entity.Word;
import com.carre.exception.DataAccessException;
import com.carre.vo.WordVO;

public interface WordDao {
	public void insertWord(Word word) throws DataAccessException;

	public List<Word> selectWordsByDate(Date beginDate, Date endDate);

	public void updateErrorWords(List<WordVO> errorList) throws DataAccessException;

	public void updateCorrectWords(List<WordVO> correctList) throws DataAccessException;

	public List<Word> selectWordsByIds(List<Integer> idList);

	public Word selectByWordEnglish(String english);

	public List<Word> selectAllWords();

	public Word selectWordById(Integer id);

	public void updateWord(Word word) throws DataAccessException;
}
