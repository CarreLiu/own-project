<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="添加单词页面">
    <meta name="author" content="CarreLiu">

    <title>英语单词测试</title>

    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrapValidator.min.css" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrapValidator.min.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/english.css">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="${pageContext.request.contextPath}/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="${pageContext.request.contextPath}/assets/js/ie10-viewport-bug-workaround.js"></script>
    <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico">
    
    <script type="text/javascript">
	    function setMarginTop() {	//根据屏幕大小设定上外边距
	    	let val;
	    	if (window.screen.height > 600)
	    		val = window.screen.height / 8 + "px";
	    	else
	    		val = "0px";
	    	$('#containers').css('marginTop', val);
	    }
	    
	    function frmAddWordValidator() {
		    $('#frmAddWord').bootstrapValidator({
	            feedbackIcons: {
	                valid: 'glyphicon glyphicon-ok',
	                invalid: 'glyphicon glyphicon-remove',
	                validating: 'glyphicon glyphicon-refresh'
	            },
	            fields:{
	                "word.english": {
	                    validators: {
	                        notEmpty: {
	                            message: '英文单词不能为空'
	                        },
	                        regexp: {
	                            regexp: /^[a-zA-Z0-9_-\s]+$/,
	                            message: '请输入合法的英文单词'
	                        },
	                        remote: {	//远程校验
	                        	type: 'post',
	                        	url: '${pageContext.request.contextPath}/word/findByWordEnglish.action'
	                        }
	                    }
	                },
	                "word.chinese": {
	                    validators: {
	                        notEmpty: {
	                            message: '中文释义不能为空'
	                        }
	                    }
	                }
	            }
	        });
	    }
	    
	    function modifyWordCreateTime() {
	    	let english = $('#english').val();
    		$.post('${pageContext.request.contextPath}/word/modifyWordCreateTime.action',
   	    			{'english': english},
   	    			function(data) {
   	    				if (data.status == 1) {
   	                        layer.msg(data.message, {
   	                            time:2000,
   	                            skin:'successMsg'
   	                        });
   	                    }
   	                    else {
   	                        layer.msg(data.message, {
   	                            time:2000,
   	                            skin:'errorMsg'
   	                        });
   	                    }
   	    			}, 'json');
	    }
	    
    	$(function() {
    		
    		//登录成功服务器端校验
            let loginSuccessMsg = '${loginSuccessMsg}';
            if (loginSuccessMsg != '') {
                layer.msg(loginSuccessMsg,{
                    time:2000,
                    skin:'successMsg'
                });
            }
    		
    		//添加单词服务器端校验
            let successMsg = '${successMsg}';
            let errorMsg = '${errorMsg}';
            if (successMsg != '') {
                layer.msg(successMsg,{
                    time:2000,
                    skin:'successMsg'
                });
            }
            if (errorMsg != '') {
                layer.msg(errorMsg, {
                    time:2000,
                    skin:'errorMsg'
                });
            }
    		
	    	setMarginTop();
	    	window.addEventListener('orientationchange', setMarginTop);	//当屏幕旋转时触发
	    	setTimeout(function() {
				$('#english').focus();
			}, 500);
	    	
	    	frmAddWordValidator();
	    	
	    	$('#english').on('input propertychange', function() {
	    		if ($.trim($('#english').val()) == '') {
	    			$('#chinese').val('');
	    		}
	    	});
			
			$('#requestChinese').on('click', function() {
	    		let english = $('#english').val();
	    		if (english != "" && english != null) {
	    			//ajax同步方式提交数据
	   				$.ajaxSettings.async = false;
	    			$.post('${pageContext.request.contextPath}/allword/findChinese.action',
	    	    			{'english': english},
	    	    			function(data) {
	    	    				if (data != "null")
	    	    					$('#chinese').val(data);
	    	    			}, 'text');
	    			$('#frmAddWord').data('bootstrapValidator').destroy();
	        		$('#frmAddWord').data('bootstrapValidator', null);
	        		frmAddWordValidator();
	        		let validator = $('#frmAddWord').data("bootstrapValidator");
	            	validator.validate();
	    		}
	    	});
	    });
    </script>
    
  </head>

  <body>
	<% request.setAttribute("index", 0); %>
	<jsp:include page="top.jsp"/>
    <div class="container" id="containers">
        <form class="form-horizontal" id="frmAddWord"
        	action="${pageContext.request.contextPath}/word/addWord.action"
        	method="post">
            <div class="form-group col-md-8">
            	<div class="h2 col-md-4 col-md-offset-7 col-xs-7 col-xs-offset-2 col-sm-4 col-sm-offset-4" style="margin-bottom: 20px;">添&nbsp;加&nbsp;新&nbsp;单&nbsp;词</div>
            </div>
            <div class="form-group form-group-lg">
                <label class="sr-only">英文</label>
                <div class="col-md-4 col-md-offset-4 col-xs-10 col-xs-offset-1 col-sm-6 col-sm-offset-3">
                    <input class="form-control" type="text" id="english" placeholder="English" name="word.english" />
                </div>
            </div>
            <div class="form-group form-group-lg">
            	<div class="col-md-2 col-md-offset-4 col-xs-5 col-xs-offset-1 col-sm-3 col-sm-offset-3">
                	<input onclick="modifyWordCreateTime()" class="btn btn-success" type="button" value="更新单词时间">
                </div>
            </div>
            <div class="form-group form-group-lg">
                <label class="sr-only">中文释义</label>
                <div class="col-md-4 col-md-offset-4 col-xs-10 col-xs-offset-1 col-sm-6 col-sm-offset-3">
                    <input class="form-control" type="text" id="chinese" placeholder="中文释义" name="word.chinese" />
                </div>
            </div>
            <div class="form-group">
            	<div class="col-md-2 col-md-offset-4 col-xs-5 col-xs-offset-1 col-sm-3 col-sm-offset-3">
            		<input id="requestChinese" type="button" class="btn btn-primary btn-block" value="获取中文" />
            	</div>
                <div class="col-md-2 col-xs-5 col-sm-3">
                    <input id="addBtn" type="submit" class="btn btn-primary btn-block" value="添加" />
                </div>
            </div>
        </form>
    </div>


	<!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="${pageContext.request.contextPath}/assets/js/ie10-viewport-bug-workaround.js"></script>    
  </body>
</html>

