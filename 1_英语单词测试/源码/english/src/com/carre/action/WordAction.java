package com.carre.action;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.alibaba.fastjson.JSON;
import com.carre.constant.Constant;
import com.carre.entity.Test;
import com.carre.entity.Word;
import com.carre.exception.WordEnglishExistException;
import com.carre.factory.ObjectFactory;
import com.carre.service.TestService;
import com.carre.service.WordService;
import com.carre.vo.PageInfo;
import com.carre.vo.TestVO2;
import com.github.pagehelper.PageHelper;

public class WordAction {
	private Word word;
	public Word getWord() {
		return word;
	}
	public void setWord(Word word) {
		this.word = word;
	}
	
	public String toAddWord() {
		return "toAddWord";
	}
	
	public String addWord() throws Exception {
		WordService wordProxy = (WordService) ObjectFactory.getObject("wordProxy");
		wordProxy.addWord(word);
		
		return "addWord";
	}
	
	public String wordsTest() throws Exception {
		
		return "wordsTest";
	}
	
	public void searchWords() throws ParseException, IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType(Constant.CONTENT_TYPE);
		String beginDateStr = request.getParameter("beginDate");
		String endDateStr = request.getParameter("endDate");
		int testType = Integer.parseInt(request.getParameter("testType"));
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date beginDate = simpleDateFormat.parse(beginDateStr);
		Date endDate = simpleDateFormat.parse(endDateStr);
		WordService wordProxy = (WordService) ObjectFactory.getObject("wordProxy");
		TestService testProxy = (TestService) ObjectFactory.getObject("testProxy");
		List<Word> wordList = null;
		if (testType == 0) {	//词库中的单词
			wordList = wordProxy.findWordsByDate(beginDate, endDate);
		}
		else if (testType == 1) {	//测试中的错误单词
			TestVO2 test = new TestVO2(-1, beginDate, endDate);	//-1是指检索所有测试记录
			List<Integer> idList = new LinkedList<Integer>();
			TreeSet<Integer> idSet = new TreeSet<Integer>();	//使用set是为了去重复
			List<Test> testList = testProxy.findTestsByDate(test);
			if (!testList.isEmpty()) {
				for (Test test2 : testList) {
					String errorWords = test2.getErrorWords();
					if (errorWords != null && errorWords != "") {	//重点
						String []arrays = errorWords.split(",");
						for (String arr : arrays) {
							if (arr != "" && arr != null)	//重点
								idSet.add(Integer.valueOf(arr));
						}
					}
				}
			}
			if (!idSet.isEmpty()) {
				for (Integer id : idSet) {
					idList.add(id);
				}
				wordList = wordProxy.findWordsByIds(idList);
			}
		}
		else if (testType == 2) {	//测试中的正确单词
			TestVO2 test = new TestVO2(-1, beginDate, endDate);	//-1是指检索所有测试记录
			List<Integer> idList = new LinkedList<Integer>();
			TreeSet<Integer> idSet = new TreeSet<Integer>();	//使用set是为了去重复
			List<Test> testList = testProxy.findTestsByDate(test);
			if (!testList.isEmpty()) {
				for (Test test2 : testList) {
					String correctWords = test2.getCorrectWords();
					if (correctWords != null && correctWords != "") {	//重点
						String []arrays = correctWords.split(",");
						for (String arr : arrays) {
							if (arr != "" && arr != null)	//重点
								idSet.add(Integer.valueOf(arr));
						}
					}
				}
			}
			if (!idSet.isEmpty()) {
				for (Integer id : idSet) {
					idList.add(id);
				}
				wordList = wordProxy.findWordsByIds(idList);
			}
		}
		if (wordList == null) {
			wordList = new LinkedList<Word>();	//使jsp页面显示共0个单词
		}
		else if (!wordList.isEmpty()) {
			Collections.shuffle(wordList);		//乱序,让测试单词乱序显示
		}
		
		
		response.getWriter().print(JSON.toJSON(wordList));
	}
	
	//校验英文单词是否已存在
	public void findByWordEnglish() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType(Constant.CONTENT_TYPE);
		String english = request.getParameter("word.english");
		WordService wordProxy = (WordService) ObjectFactory.getObject("wordProxy");
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			wordProxy.findByWordEnglish(english);
			map.put("valid", true);//设置valid属性,在false时,输出message所对应的值
		} catch (WordEnglishExistException e) {
			map.put("valid", false);
			map.put("message", e.getMessage());
		}
		//返回2个值:message,是否输出该消息:valid
		response.getWriter().print(JSON.toJSON(map));
	}
	
	public String toWordsShown() {
		
		return "toWordsShown";
	}
	
	public void findWordsByPage() throws ParseException, IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		WordService wordProxy = (WordService) ObjectFactory.getObject("wordProxy");
		String pageNoStr = request.getParameter("pageNo");
		String pageSizeStr = request.getParameter("pageSize");
		int pageNo = 0;
		int pageSize = 0;
		if (pageNoStr == null) {
			pageNo = Constant.PAGE_NO;
		}
		else {
			pageNo = Integer.parseInt(pageNoStr);
		}
		if (pageSizeStr == null) {
			pageSize = Constant.PAGE_SIZE;
		}
		else {
			pageSize = Integer.parseInt(pageSizeStr);
		}
		int allTime = Integer.parseInt(request.getParameter("allTime"));
		String beginDateStr = request.getParameter("beginDate");
		String endDateStr = request.getParameter("endDate");
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date beginDate = null;
		Date endDate = null;
		if (beginDateStr != "")
			beginDate = simpleDateFormat.parse(beginDateStr);
		if (endDateStr != "")
			endDate = simpleDateFormat.parse(endDateStr);
		List<Word> wordList = null;
		if (allTime == 1) {	//查询全部时间
			PageHelper.startPage(pageNo, pageSize);
			wordList = wordProxy.findAllWords();
			
		}
		else if (allTime == 0) {	//查询给定时间区间
			PageHelper.startPage(pageNo, pageSize);
			wordList = wordProxy.findWordsByDate(beginDate, endDate);
		}
		PageInfo<Word> pageInfo = new PageInfo<Word>(wordList);
		response.setContentType(Constant.CONTENT_TYPE);
		response.getWriter().print(JSON.toJSON(pageInfo));
	}
	
	public void findWordById() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType(Constant.CONTENT_TYPE);
		WordService wordProxy = (WordService) ObjectFactory.getObject("wordProxy");
		Integer id = Integer.valueOf(request.getParameter("id"));
		Word modifyWord = wordProxy.findWordById(id);
		response.getWriter().print(JSON.toJSON(modifyWord));
	}
	
	//校验英文单词是否已存在,但不包括原单词
	public void findByWordEnglish2() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType(Constant.CONTENT_TYPE);
		String english = request.getParameter("english");
		String primeEnglish = request.getParameter("primeEnglish");
		WordService wordProxy = (WordService) ObjectFactory.getObject("wordProxy");
		Map<String, Object> map = new HashMap<String, Object>();
		if (english.equals(primeEnglish) || english.trim().equals(primeEnglish)) {
			map.put("valid", true);
		}
		else {
			try {
				wordProxy.findByWordEnglish(english);
				map.put("valid", true);//设置valid属性,在false时,输出message所对应的值
			} catch (WordEnglishExistException e) {
				map.put("valid", false);
				map.put("message", e.getMessage());
			}
		}
		//返回2个值:message,是否输出该消息:valid
		response.getWriter().print(JSON.toJSON(map));
	}
	
	public void modifyWord() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType(Constant.CONTENT_TYPE);
		Integer id = Integer.valueOf(request.getParameter("id"));
		String english = request.getParameter("english");
		String chinese = request.getParameter("chinese");
		String property = request.getParameter("property");
		Word modifyWord = new Word(id, english, chinese, property, null, null, null);
		
		WordService wordProxy = (WordService) ObjectFactory.getObject("wordProxy");
		wordProxy.modifyWord(modifyWord);
	}
}
