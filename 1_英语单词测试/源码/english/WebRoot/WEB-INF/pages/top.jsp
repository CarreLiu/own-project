<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(function() {
		//正确显示导航栏
		let navIndex = ${index};
		$('ul.nav li').each(function(i) {
			//将所有导航栏背景清空
			$(this).removeClass('active1');
			if (navIndex == i) {
				$(this).addClass('active1');
			}
		});
	});
</script>
</head>
<body>
	<div class="nav-style">
		<div class="container">
			<div class="col-sm-12">
				<ul class="nav nav-pills">
					<li class="active1"><a href="${pageContext.request.contextPath}/words/toAddWord.action">添加单词</a></li>
					<li><a href="${pageContext.request.contextPath}/words/wordsTest.action">单词测试</a></li>
					<li><a href="${pageContext.request.contextPath}/tests/toTestShown.action">测试记录</a></li>
				</ul>
			</div>
		</div>
	</div>
</body>
</html>