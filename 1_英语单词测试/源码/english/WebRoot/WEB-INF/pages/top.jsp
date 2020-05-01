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
	});
</script>
</head>
<body style="background: url(${pageContext.request.contextPath}/images/backimage.jpg);">
	<nav class="navbar navbar-default"></nav>
    <nav class="navbar navbar-default navbar-fixed-top">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                  <a class="navbar-brand">英语单词测试</a>
            </div>
            <div id="navbar" class="collapse navbar-collapse">
                <ul class="nav navbar-nav" style="font-size: 16px;">
                    <li class="active"><a href="${pageContext.request.contextPath}/words/toAddWord.action">添加单词</a></li>
                    <li><a href="${pageContext.request.contextPath}/words/wordsTest.action">单词测试</a></li>
                    <li><a href="${pageContext.request.contextPath}/tests/toTestShown.action">测试记录</a></li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="container">
        <div class="row">
            <div class="col-sm-2 col-sm-offset-10 col-xs-7 col-xs-offset-5">
                <p id="timeId"></p>
            </div>
        </div>
    </div>
</body>
</html>