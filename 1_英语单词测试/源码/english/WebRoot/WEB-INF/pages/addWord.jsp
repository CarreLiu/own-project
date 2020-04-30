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

    <title>添加新单词</title>

    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrapValidator.min.css" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mycss.css" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrapValidator.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="${pageContext.request.contextPath}/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="${pageContext.request.contextPath}/assets/js/ie10-viewport-bug-workaround.js"></script>
    
    <script type="text/javascript">
	    $(function() {
			setTimeout(function() {
				$('#english').focus();
			}, 500);
	    	
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
	                        	url: '${pageContext.request.contextPath}/words/findByWordEnglish.action'
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
	    });
    </script>
    
  </head>

  <body>
	<% request.setAttribute("index", 0); %>
	<jsp:include page="top.jsp"/>
    <div class="container" style="margin-top: 150px;">
        <form class="form-horizontal" id="frmAddWord"
        	action="${pageContext.request.contextPath}/words/addWord.action"
        	method="post">
            <div class="form-group">
            	<div class="h2 col-sm-offset-4" style="margin-bottom: 20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;添&nbsp;加&nbsp;新&nbsp;单&nbsp;词</div>
            </div>
            <div class="form-group form-group-lg">
                <label class="sr-only">英文</label>
                <div class="col-sm-3 col-sm-offset-4">
                    <input class="form-control" type="text" id="english" placeholder="English" name="word.english" />
                </div>
            </div>
            <div class="form-group form-group-lg">
                <label class="sr-only">中文释义</label>
                <div class="col-sm-3 col-sm-offset-4">
                    <input class="form-control" type="text" id="chinese" placeholder="中文释义" name="word.chinese" />
                </div>
            </div>
            <div class="form-group">
                <div class="col-sm-3 col-sm-offset-4">
                    <input type="submit" class="btn btn-primary btn-block" value="添加" />
                </div>
            </div>
        </form>
    </div>


    
  </body>
</html>

