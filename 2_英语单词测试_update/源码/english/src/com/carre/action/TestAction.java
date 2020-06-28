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
import com.carre.entity.TestDetail;
import com.carre.entity.TestType;
import com.carre.entity.User;
import com.carre.entity.Word;
import com.carre.factory.ObjectFactory;
import com.carre.service.TestDetailService;
import com.carre.service.TestService;
import com.carre.service.TestTypeService;
import com.carre.service.WordService;
import com.carre.vo.PageInfo;
import com.carre.vo.TestVO;
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
		HttpServletRequest request = ServletActionContext.getRequest();
		TestTypeService testTypeProxy = (TestTypeService) ObjectFactory.getObject("testTypeService");
		List<TestType> testTypes = testTypeProxy.findTestType();
		request.setAttribute("testTypes", testTypes);
		
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
		
		User userSession = (User) request.getSession().getAttribute("user");
		Integer userId = userSession.getId();
		
		int allTime = Integer.parseInt(request.getParameter("allTime"));
		String beginDateStr = request.getParameter("beginDate");
		String endDateStr = request.getParameter("endDate");
		Integer testTypeId = Integer.valueOf(request.getParameter("testTypeId"));
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date beginDate = null;
		Date endDate = null;
		if (beginDateStr != "")
			beginDate = simpleDateFormat.parse(beginDateStr);
		if (endDateStr != "")
			endDate = simpleDateFormat.parse(endDateStr);
		
		List<Test> testList = null;
		if (allTime == 1) {	//查询全部时间
			TestVO test = new TestVO(userId, testTypeId, null, null);
			PageHelper.startPage(pageNo, pageSize);
			testList = testProxy.findAllTests(test);
			
		}
		else if (allTime == 0) {	//查询给定时间区间
			TestVO test = new TestVO(userId, testTypeId, beginDate, endDate);
			PageHelper.startPage(pageNo, pageSize);
			testList = testProxy.findTestsByDate(test);
		}
		PageInfo<Test> pageInfo = new PageInfo<Test>(testList);
		response.setContentType(Constant.CONTENT_TYPE);
		response.getWriter().print(JSON.toJSON(pageInfo));
	}
	
	//提交测试题
	public String testSubmit() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType(Constant.CONTENT_TYPE);
		
		try {
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
				
				Integer testTypeId = Integer.valueOf(request.getParameter("testTypeId"));
				TestService testProxy = (TestService) ObjectFactory.getObject("testProxy");
				TestDetailService testDetailProxy = (TestDetailService) ObjectFactory.getObject("testDetailProxy");
				
				User userSession = (User) request.getSession().getAttribute("user");
				Integer userId = userSession.getId();
				TestDetail testDetail = new TestDetail(null, allWords, error, correct);
				testDetailProxy.addTestDetail(testDetail);
				Integer testDetailId = testDetail.getId();
				Integer ownTestId = testProxy.findMaxOwnTestId(userId);
				Test test = new Test(null, userId, ownTestId + 1, Integer.valueOf(words.size()), correctList.size()*1.0/words.size(), testDetailId, testTypeId, null);
				testProxy.addTest(test);
			}
		} catch (Exception e) {
			request.setAttribute("errorMsg", "测试提交失败");
			TestTypeService testTypeProxy = (TestTypeService) ObjectFactory.getObject("testTypeService");
			List<TestType> testTypes = testTypeProxy.findTestType();
			request.setAttribute("testTypes", testTypes);
			
			return "fail";
		}
		
		return "success";
	}
	
	public String testSubmitSuccess() throws InterruptedException {
		HttpServletRequest request = ServletActionContext.getRequest();
		TestTypeService testTypeProxy = (TestTypeService) ObjectFactory.getObject("testTypeService");
		List<TestType> testTypes = testTypeProxy.findTestType();
		request.setAttribute("testTypes", testTypes);
		Thread.currentThread();
		Thread.sleep(3000);
		request.setAttribute("successMsg", "测试提交成功");
		
		return "testSubmitSuccess";
	}
	
	public String toTestDetail() {
		HttpServletRequest request = ServletActionContext.getRequest();
		Integer id = Integer.valueOf(request.getParameter("id"));
		try {
			TestService testProxy = (TestService) ObjectFactory.getObject("testProxy");
			Test test = testProxy.findTestById(id);
			request.setAttribute("test", test);
		} catch (Exception e) {
			TestTypeService testTypeProxy = (TestTypeService) ObjectFactory.getObject("testTypeService");
			List<TestType> testTypes = testTypeProxy.findTestType();
			request.setAttribute("testTypes", testTypes);
			request.setAttribute("serviceBusyMsg", "服务器繁忙，请刷新页面");
			return "fail";
		}
		
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
		
		try {
			String idStr = request.getParameter("id");
			Integer id = Integer.valueOf(idStr);
			int wordsType = Integer.parseInt(request.getParameter("wordsType"));
			Test test = testProxy.findTestById(id);
			
			List<Integer> idList = null;
			if (wordsType == 1) {	//全部题目
				String allWords = test.getTestDetail().getAllWords();
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
			else if (wordsType == 2) {	//错误题目
				String errorWords = test.getTestDetail().getErrorWords();
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
			else if (wordsType == 3) {	//正确题目
				String correctWords = test.getTestDetail().getCorrectWords();
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
			PageInfo<Word> pageInfo = null;
			if (idList != null) {
				PageHelper.startPage(pageNo, pageSize);
				List<Word> wordList = wordProxy.findWordsByIds(idList);
				pageInfo = new PageInfo<Word>(wordList);
			}
			else {
				pageInfo = new PageInfo<Word>();
			}
			response.setContentType(Constant.CONTENT_TYPE);
			response.getWriter().print(JSON.toJSON(pageInfo));
		} catch (Exception e) {
			// TODO Auto-generated catch block
		}
	}
}
