<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="单词测试页面">
    <meta name="author" content="CarreLiu">

    <title>英语单词测试</title>

    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrapValidator.min.css" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrapValidator.min.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/english.css">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="${pageContext.request.contextPath}/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico">
	
	<script type="text/javascript">
	  let list = new Array();
	  let testTypeId;
	  
	  function frmSearchWordsValidator() {
	  	$('#frmSearchWords').bootstrapValidator({
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields:{
                beginDate: {
                	verbose: false,
                    validators: {
                        notEmpty: {
                            message: '开始时间不能为空'
                        },
                        date: {
                        	message: '日期非法'
                        },
                        callback: {
                            message: '开始时间不能大于结束时间',
                            callback: function(value, validator) {
                            	let start = new Date(value.replace(/-/g, '/'));
                            	if (start > Date.now()) {
                                	validator.updateMessage('beginDate', 'callback', '时间不能大于今天');
                                	return false;
                                }
                                let other = validator.getFieldElements('endDate').val();
                                if (other == '')
                                    return true;
                                let end = new Date(other.replace(/-/g, '/'));
                                if (start > end) {
                                	validator.updateMessage('beginDate', 'callback', '开始时间不能大于结束时间');
                                    return false;
                                }
                                return true;
                            }
                        }
                    }
                },
                endDate: {
                	verbose: false,
                    validators: {
                        notEmpty: {
                            message: '结束时间不能为空'
                        },
                        date: {
                        	message: '日期非法'
                        },
                        callback: {
                            message: '结束时间不能小于开始时间',
                            callback: function(value, validator) {
                            	let end = new Date(value.replace(/-/g, '/'));
                                if (end > Date.now()) {
                                	validator.updateMessage('endDate', 'callback', '时间不能大于今天');
                                	return false;
                                }
                                let other = validator.getFieldElements('beginDate').val();
                                if (other == '')
                                    return true;
                                let start = new Date(other.replace(/-/g, '/'));
                                if (start > end) {
                                	validator.updateMessage('endDate', 'callback', '结束时间不能小于开始时间');
                                    return false;
                                }
                                return true;
                            }
                        }              
                    }
                },
                testTypeId: {
                	validators: {
                		notEmpty: {
                			message: '请选择题目类型'
                		}
                	}
                }
            }
        });
	  }
	  
      $(function() {
    	  
    	  //服务器端校验
          let errorMsg = '${errorMsg}';
          if (errorMsg != '') {
              layer.msg(errorMsg, {
                  time:2000,
                  skin:'errorMsg'
              });
          }
    	
        frmSearchWordsValidator();
        $('#frmSearchWords').on('change', function() {
        	$('#frmSearchWords').bootstrapValidator('addField', 'beginDate',{
    			verbose: false,
                validators: {
                    notEmpty: {
                        message: '开始时间不能为空'
                    },
                    date: {
                    	message: '日期非法'
                    },
                    callback: {
                        message: '开始时间不能大于结束时间',
                        callback: function(value, validator) {
                        	let start = new Date(value.replace(/-/g, '/'));
                        	if (start > Date.now()) {
                            	validator.updateMessage('beginDate', 'callback', '时间不能大于今天');
                            	return false;
                            }
                            let other = validator.getFieldElements('endDate').val();
                            if (other == '')
                                return true;
                            let end = new Date(other.replace(/-/g, '/'));
                            if (start > end) {
                            	validator.updateMessage('beginDate', 'callback', '开始时间不能大于结束时间');
                                return false;
                            }
                            return true;
                        }
                    }
                }
	        });
    		$('#frmSearchWords').bootstrapValidator('addField', 'endDate',{
    			verbose: false,
                validators: {
                    notEmpty: {
                        message: '结束时间不能为空'
                    },
                    date: {
                    	message: '日期非法'
                    },
                    callback: {
                        message: '结束时间不能小于开始时间',
                        callback: function(value, validator) {
                        	let end = new Date(value.replace(/-/g, '/'));
                            if (end > Date.now()) {
                            	validator.updateMessage('endDate', 'callback', '时间不能大于今天');
                            	return false;
                            }
                            let other = validator.getFieldElements('beginDate').val();
                            if (other == '')
                                return true;
                            let start = new Date(other.replace(/-/g, '/'));
                            if (start > end) {
                            	validator.updateMessage('endDate', 'callback', '结束时间不能小于开始时间');
                                return false;
                            }
                            return true;
                        }
                    }              
                }
    		});
        	
        	let validator = $('#frmSearchWords').data("bootstrapValidator");	//获取validator对象
        	validator.validate();	//手动触发验证
        	if (validator.isValid()) {	//通过验证
        		$('#searchBtn').removeAttr('disabled');
        	}
        	else {
        		$('#searchBtn').attr('disabled', true);
        	}
        });
        
        $('#searchBtn').on('click', function() {
        	let validator = $('#frmSearchWords').data("bootstrapValidator");
        	validator.validate();
        	if (validator.isValid()) {
        		//post请求,查询符合条件的单词
        		let beginDate = $('#beginDate').val();
        		let endDate = $('#endDate').val();
        		testTypeId = $('#testTypeId').val();
        		$.post('${pageContext.request.contextPath}/word/searchEnabledWords.action',
        			{'beginDate':beginDate,'endDate':endDate,'testTypeId':testTypeId},
        			function(wordList){
        				let result = '';
        				result += '<div class="form-group">';
        		        result += '<div class="h2 col-xs-6 col-xs-offset-3 col-sm-3 col-sm-offset-4 col-md-3 col-md-offset-5">共' + wordList.length + '个单词</div>';
        		        result += '</div>';
        		        for (let i = 0; i < wordList.length; i++) {
        		        	result += '<div class="form-group">';
            		        result += '<label class="col-xs-10 col-xs-offset-1 col-sm-8 col-sm-offset-2 col-md-3 col-md-offset-3" for="word-' + i + '">' + (i+1) + '. ';
            		        result += wordList[i].chinese + '</label>';
            		        result += '<div class="col-xs-10 col-xs-offset-1 col-sm-8 col-sm-offset-2 col-md-3 col-md-offset-0">';
            		        result += '<input class="form-control" type="text" id="word-' + i + '" name="words[' + i + '].answer" />';
            		        result += '<input type="hidden" value="' + wordList[i].id + '" name="words[' + i + '].id" />';
            		        result += '<input type="hidden" id="english-' + i + '" name="words[' + i + '].english" />';
            		        result += '</div>';
            		        result += '</div>';
            		        list[i] = wordList[i].english;
        		        }
        		        if (wordList.length != 0) {
        		        	result += '<div class="form-group">';
	        		        result += '<input type="hidden" id="testTypeId2" name="testTypeId" />';
	        		        result += '</div>';
	        		        
	        		        result += '<div class="form-group">';
	        		        result += '<div class="col-xs-6 col-xs-offset-3 col-sm-4 col-sm-offset-4 col-md-2 col-md-offset-5">';
	        		        result += '<input type="submit" class="btn btn-primary btn-block" value="提交答案" />';
	        		        result += '</div>';
	        		        result += '</div>';
        		        }
        		        
        		        //动态生成单词题目表单
        		        $('#frmWordsTest').html(result);
        		        //动态添加form表单验证
        		        for (let i = 0; i < wordList.length; i++) {
        		        	$('#frmWordsTest').bootstrapValidator('addField', 'words[' + i + '].answer',{
            		        	validators: {
            		        		notEmpty: {
            		        			message: '答案不能为空'
            		        		}
            		        	}
            		        });
        		        }
        		        if (wordList.length != 0) {
        		        	setTimeout(function() {
        						$('#word-0').focus();
        					}, 500);
        		        }
        		        
        		        $('#frmSearchWords').data('bootstrapValidator').destroy();
                		$('#frmSearchWords').data('bootstrapValidator', null);
                		if (wordList.length == 0) {
                			frmSearchWordsValidator();
                		}
                		else {
                			$('#searchBtn').attr('disabled', true);
                			$('#frmSearchWords').off('change');
                		}
        		        
        			}, 'json');
        		
        	}
        	else {
        		$('#searchBtn').attr('disabled', true);
        	}
        });
		
        //将题目的正确答案和题目类型放入input
        $('#frmWordsTest').submit(function() {
        	for (let i = 0; i < list.length; i++) {
        		$('#english-'+i).val(list[i]);
        	}
        	$('#testTypeId2').val(testTypeId);
        	
        	layer.msg("提交中，请稍等", {
                time:2000,
                skin:'successMsg'
            });
        });
      });
      
    </script>
	
  </head>

  <body>
	<% request.setAttribute("index", 1); %>
	<jsp:include page="top.jsp"/>
    <div class="container text-center" style="margin-top: 20px;">
      <form class="form-inline" id="frmSearchWords" action="" method="post">
        <div class="form-group">
          <label style="font-size: 1.2em; margin-right: 10px;">开始时间:</label>
          <input class="form-control" type="date" style="margin-right: 25px;" name="beginDate" id="beginDate" />
        </div>
        <div class="form-group">
          <label style="font-size: 1.2em; margin-right: 10px;">结束时间:</label>
          <input class="form-control" type="date" style="margin-right: 25px;" name="endDate" id="endDate" />
        </div>
        <div class="form-group">
          <label style="font-size: 1.2em; margin-right: 10px;">题目类型:</label>
          <select class="form-control" style="margin-right: 25px;" name="testTypeId" id="testTypeId">
            <option selected="selected" value="">--请选择--</option>
            <c:forEach items="${testTypes}" var="testType">
            	<option value="${testType.id}">${testType.name}</option>
            </c:forEach>
          </select>
        </div>
        <div class="form-group">
          <input class="btn btn-primary btn-block" id="searchBtn" type="button" value="查询单词" />
        </div>
      </form>
    </div>
    
    <div class="container" style="margin-top: 50px;">
      <form class="form-horizontal" id="frmWordsTest" action="${pageContext.request.contextPath}/test/testSubmit.action" method="post">
      
      </form>
    </div>


    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="${pageContext.request.contextPath}/assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>

