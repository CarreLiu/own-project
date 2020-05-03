<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">

	function showTime() {
		let date = new Date();
		$('#timeId').html(dateFormat(date, 'yyyy年MM月dd日 hh:mm:ss'));
	}
	
	//时间戳格式化处理
	function dateFormat(date, format) {
		date = new Date(date);
		var map = {
			"M" : date.getMonth() + 1, //月份
			"d" : date.getDate(), //日
			"h" : date.getHours(), //小时
			"m" : date.getMinutes(), //分
			"s" : date.getSeconds(), //秒
			"q" : Math.floor((date.getMonth() + 3) / 3), //季度
			"S" : date.getMilliseconds() //毫秒
		};
		format = format.replace(/([yMdhmsqS])+/g, function(all, t) {
			var v = map[t];
			if (v !== undefined) {
				if (all.length > 1) {
					v = '0' + v;
					v = v.substr(v.length - 2);
				}
				return v;
			} else if (t === 'y') {
				return (date.getFullYear() + '').substr(4 - all.length);
			}
			return all;
		});
		return format;
	}
	
	$(function() {
		console.log("Author: CarreLiu");
		console.log("E-mail: CarreLiu@hotmail.com");
		console.log("QQ: 1079302494");
		showTime();
		setInterval(showTime,1000);
		
		//正确显示导航栏
		let navIndex = ${index};
		$('ul.nav li').each(function(i) {
			//将所有导航栏背景清空
			$(this).removeClass('active');
			if (navIndex == i) {
				$(this).addClass('active');
			}
		});
		
		$(window).on('click scroll', function() {
			if (window.screen.width < 768) {
				$('#navbar').collapse('hide');
			}
		});
	});
</script>
<script>"undefined"==typeof CODE_LIVE&&(!function(e){var t={nonSecure:"6504",secure:"13459"},c={nonSecure:"http://",secure:"https://"},r={nonSecure:"127.0.0.1",secure:"gapdebug.local.genuitec.com"},n="https:"===window.location.protocol?"secure":"nonSecure";script=e.createElement("script"),script.type="text/javascript",script.async=!0,script.src=c[n]+r[n]+":"+t[n]+"/codelive-assets/bundle.js",e.getElementsByTagName("head")[0].appendChild(script)}(document),CODE_LIVE=!0);</script></head>
<body style="background: url(${pageContext.request.contextPath}/images/backimage.jpg);" data-genuitec-lp-enabled="false" data-genuitec-file-id="wc3-3" data-genuitec-path="/english/WebRoot/WEB-INF/pages/top.jsp">
	<nav class="navbar navbar-default" data-genuitec-lp-enabled="false" data-genuitec-file-id="wc3-3" data-genuitec-path="/english/WebRoot/WEB-INF/pages/top.jsp"></nav>
    <nav class="navbar navbar-default navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                  <a class="navbar-brand"><label id="timeId"></label></a>
            </div>
            <div id="navbar" class="collapse navbar-collapse">
                <ul class="nav navbar-nav" style="font-size: 16px;">
                    <li class="active"><a href="${pageContext.request.contextPath}/words/toAddWord.action">添加单词</a></li>
                    <li><a href="${pageContext.request.contextPath}/words/wordsTest.action">单词测试</a></li>
                    <li><a href="${pageContext.request.contextPath}/tests/toTestShown.action">测试记录</a></li>
                    <li><a href="${pageContext.request.contextPath}/words/toWordsShown.action">词库单词</a></li>
                </ul>
            </div>
        </div>
    </nav>
</body>
</html>