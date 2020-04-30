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
<script>"undefined"==typeof CODE_LIVE&&(!function(e){var t={nonSecure:"6504",secure:"13459"},c={nonSecure:"http://",secure:"https://"},r={nonSecure:"127.0.0.1",secure:"gapdebug.local.genuitec.com"},n="https:"===window.location.protocol?"secure":"nonSecure";script=e.createElement("script"),script.type="text/javascript",script.async=!0,script.src=c[n]+r[n]+":"+t[n]+"/codelive-assets/bundle.js",e.getElementsByTagName("head")[0].appendChild(script)}(document),CODE_LIVE=!0);</script></head>
<body data-genuitec-lp-enabled="false" data-genuitec-file-id="wc3-3" data-genuitec-path="/english/WebRoot/WEB-INF/pages/top.jsp">
	<div class="nav-style" data-genuitec-lp-enabled="false" data-genuitec-file-id="wc3-3" data-genuitec-path="/english/WebRoot/WEB-INF/pages/top.jsp">
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