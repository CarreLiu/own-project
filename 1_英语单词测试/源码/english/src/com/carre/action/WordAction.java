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
import com.carre.factory.ObjectFactory;
import com.carre.service.TestService;
import com.carre.service.WordService;
import com.carre.vo.TestVO2;

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
			wordList = wordProxy.findAllWords(beginDate, endDate);
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
	
}
