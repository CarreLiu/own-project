package com.carre.action;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

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
import com.carre.vo.PageInfo;
import com.carre.vo.TestVO;
import com.carre.vo.TestVO2;
import com.carre.vo.WordVO;
import com.github.pagehelper.PageHelper;

public class TestAction {
	private List<WordVO> words;

	public List<WordVO> getWords() {
		return words;
	}

	public void setWords(List<WordVO> words) {
		this.words = words;
	}
	
	public String toTestShown() {
		return "toTestShown";
	}
	
	//查询测试记录
	public void findTestsByPage() throws ParseException, IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		TestService testProxy = (TestService) ObjectFactory.getObject("testProxy");
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
		Integer testType = Integer.valueOf(request.getParameter("testType"));
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date beginDate = null;
		Date endDate = null;
		if (beginDateStr != "")
			beginDate = simpleDateFormat.parse(beginDateStr);
		if (endDateStr != "")
			endDate = simpleDateFormat.parse(endDateStr);
		
		List<Test> testList = null;
		if (allTime == 1) {	//查询全部时间
			PageHelper.startPage(pageNo, pageSize);
			testList = testProxy.findAllTests(testType);
			
		}
		else if (allTime == 0) {	//查询给定时间区间
			TestVO2 test = new TestVO2(testType, beginDate, endDate);
			PageHelper.startPage(pageNo, pageSize);
			testList = testProxy.findTestsByDate(test);
		}
		PageInfo<Test> pageInfo = new PageInfo<Test>(testList);
		response.setContentType(Constant.CONTENT_TYPE);
		response.getWriter().print(JSON.toJSON(pageInfo));
	}
	
	//提交测试题
	public String testSubmit() throws Exception {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType(Constant.CONTENT_TYPE);
		if (words != null) {
			Collections.sort(words, new Comparator<WordVO>() {	//提交的单词按id排序

				@Override
				public int compare(WordVO o1, WordVO o2) {
					return o1.getId() - o2.getId();
				}
				
			});
			String allWords = "";
			String error = "";
			String correct = "";
			List<WordVO> errorList = new ArrayList<WordVO>();
			List<WordVO> correctList = new ArrayList<WordVO>();
			for (WordVO word : words) {
				allWords += word.getId() + ",";
				if ((word.getAnswer().toLowerCase()).equals(word.getEnglish().toLowerCase())) {
					correct += word.getId() + ",";
					correctList.add(word);
				}
				else {
					error += word.getId() + ",";
					errorList.add(word);
				}
			}
			
			//数据库更新
			WordService wordProxy = (WordService) ObjectFactory.getObject("wordProxy");
			if (!errorList.isEmpty())
				wordProxy.modifyErrorWords(errorList);
			if (!correctList.isEmpty())
				wordProxy.modifyCorrectWords(correctList);
			
			HttpServletRequest request = ServletActionContext.getRequest();
			Integer testType = Integer.valueOf(request.getParameter("testType"));
			TestService testProxy = (TestService) ObjectFactory.getObject("testProxy");
			Test test = new Test(null, Integer.valueOf(words.size()), correctList.size()*1.0/words.size(), allWords, error, correct, testType, null);
			testProxy.addTest(test);
		}
		
		return "testSubmit";
	}
	
	public String toTestDetail() {
		HttpServletRequest request = ServletActionContext.getRequest();
		Integer id = Integer.valueOf(request.getParameter("id"));
		TestService testProxy = (TestService) ObjectFactory.getObject("testProxy");
		Test test = testProxy.findTestById(id);
		TestVO testVO = new TestVO(test.getId(),test.getCreateTime(),test.getTotalWords(),test.getCorrectRate(),test.getTestType());
		request.setAttribute("test", testVO);
		
		return "toTestDetail";
	}
	
	public void findSingleTestByPage() throws IOException {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		TestService testProxy = (TestService) ObjectFactory.getObject("testProxy");
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
		
		Integer id = Integer.valueOf(request.getParameter("id"));
		int testType = Integer.parseInt(request.getParameter("testType"));
		Test test = testProxy.findTestById(id);
		
		List<Integer> idList = null;
		if (testType == 0) {	//全部题目
			String allWords = test.getAllWords();
			if (allWords != null && allWords != "") {
				String []arrays = allWords.split(",");
				List<Integer> list = new LinkedList<Integer>();
				for (String arr : arrays) {
					if (arr != "" && arr != null)
						list.add(Integer.valueOf(arr));
				}
				idList = list;
			}
		}
		else if (testType == 1) {	//错误题目
			String errorWords = test.getErrorWords();
			if (errorWords != null && errorWords != "") {
				String []arrays = errorWords.split(",");
				List<Integer> list = new LinkedList<Integer>();
				for (String arr : arrays) {
					if (arr != "" && arr != null)
						list.add(Integer.valueOf(arr));
				}
				idList = list;
			}
		}
		else if (testType == 2) {	//正确题目
			String correctWords = test.getCorrectWords();
			if (correctWords != null && correctWords != "") {
				String []arrays = correctWords.split(",");
				List<Integer> list = new LinkedList<Integer>();
				for (String arr : arrays) {
					if (arr != "" && arr != null)
						list.add(Integer.valueOf(arr));
				}
				idList = list;
			}
		}
		
		WordService wordProxy = (WordService) ObjectFactory.getObject("wordProxy");
		PageHelper.startPage(pageNo, pageSize);
		List<Word> wordList = wordProxy.findWordsByIds(idList);
		PageInfo<Word> pageInfo = new PageInfo<Word>(wordList);
		response.setContentType(Constant.CONTENT_TYPE);
		response.getWriter().print(JSON.toJSON(pageInfo));
	}
}
