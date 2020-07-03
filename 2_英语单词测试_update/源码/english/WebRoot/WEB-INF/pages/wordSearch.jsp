<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="description" content="单词查询页面">
    <meta name="author" content="CarreLiu">

    <title>英语单词测试</title>

    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrapValidator.min.css" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap/css/bootstrap-table.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrap-table.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/bootstrap/js/bootstrapValidator.min.js"></script>
    <script src="${pageContext.request.contextPath}/layer/layer.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/english.css">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="${pageContext.request.contextPath}/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <link rel="icon" href="${pageContext.request.contextPath}/images/favicon.ico">
	
	<script type="text/javascript">
		function frmModifyWordValidator() {
		  $('#frmModifyWord').bootstrapValidator({
		  	feedbackIcons: {
	        	valid: 'glyphicon glyphicon-ok',
	            invalid: 'glyphicon glyphicon-remove',
	            validating: 'glyphicon glyphicon-refresh'
	        },
	        fields: {
	        	english: {
	        		validators: {
	        			notEmpty: {
	        				message: '英语单词不能为空'
	        			},
                      regexp: {
                          regexp: /^[a-zA-Z0-9_-\s]+$/,
                          message: '请输入合法的英文单词'
                      },
                      remote: {	//远程校验,此处修改了源码,改为了同步方式
                      	type: 'post',
                      	url: '${pageContext.request.contextPath}/word/findByWordEnglish2.action',
                      	data: {
                      		primeEnglish: $('#primeEnglish').val()
                      	}
                      }
	        		}
	        	},
	        	chinese: {
	        		validators: {
	        			notEmpty: {
	        				message: '中文释义不能为空'
	        			}
	        		}
	        	}
	        }
		  });
	  	}	
	
	
	  	function initTable() {
			//先销毁表格  
			$('#cusTable').bootstrapTable('destroy');
			//初始化表格,动态从服务器加载数据  
			$("#cusTable").bootstrapTable({
				method : 'post',
				contentType : "application/x-www-form-urlencoded", //post请求必须要有！
				url : "${pageContext.request.contextPath}/allword/findWordByCondition.action", //要请求数据的文件路径
				striped : true, //是否显示行间隔色
				pageNumber : 1, //初始化加载第一页，默认第一页
				pagination : true, //是否分页
				queryParamsType : 'limit', //查询参数组织方式
				queryParams : queryParams, //请求服务器时所传的参数
				sidePagination : 'server', //指定服务器端分页
				pageSize : 10, //单页记录数
				pageList : [ 5, 10, 15], //分页步进值
				showRefresh : false, //刷新按钮
				showColumns : false,
				clickToSelect : false, //是否启用点击选中行
				toolbarAlign : 'right', //工具栏对齐方式
				buttonsAlign : 'right', //按钮对齐方式
				undefinedText : "空", //当数据为 undefined 时显示的字符  
				columns : [
					{
						title : 'English',
						field : 'english',
						align : 'center'
					},
					{
						title : '音',
						field : 'english',
						align : 'center',
						formatter : function(value, row, index) {
							let id = row.id;
							if (row.createTime==null) {	//防止个人单词库和总库id重复
								id = '-1' + id;
							}
							let english = value;
							let result = '';
							result += '<span id="voiceBtn-' + id + '" onclick="playVoice(' + id + ',&quot;' + english + '&quot;)" ';
							result += 'class="glyphicon glyphicon-volume-down" aria-hidden="true" style="cursor: pointer;">';
							result += '<audio id="mp3Btn-' + id + '" onended="playEnd(' + id + ')"></audio></span>';
							return result;
						}
					},
					{
						title : '中文释义',
						field : 'chinese',
						align : 'left'
					},
					{
			          	title:'状态',
			          	field:'status',
			          	align:'center',
			          	formatter:function(value, row, index){
			          		if (row.createTime == null) {
			          			return '不在词库中';
			          		}
			          		else {
			          			let result = (row.isFavorite == 0 ? '未收藏':'已收藏');
			          			result += '&nbsp;' + (value == 0 ? '禁用':'启用');
			          			return result;
			          		}
			          	}
			        },
					{
						title : '操作',
						field : 'id',
						align : 'center',
						formatter : actionFormatter
					}
				]
			});
		}
		
		//操作栏的格式化
		function actionFormatter(value, row, index) {
			let id = value;
			let object = row;
			
			let result = "";
			
			if (row.createTime == null) {
				result += "<button type='button' class='btn btn-info btn-xs' onclick='addWord(&quot;"+object.english+"&quot;,&quot;"+object.chinese+"&quot;)'>加入用户个人词库</button>";
			}
			else {
				if (object.isFavorite == 1) {
					result += "<button type='button' class='btn btn-warning btn-xs' onclick='changeFavoriteStatus("+object.id+","+object.userId+","+object.isFavorite+")'>取消收藏</button>&nbsp;&nbsp;&nbsp;";
				}
				else {
					result += "<button type='button' class='btn btn-success btn-xs' onclick='changeFavoriteStatus("+object.id+","+object.userId+","+object.isFavorite+")'>加入收藏</button>&nbsp;&nbsp;&nbsp;";
				}
				if (object.status == 1) {
					result += "<button type='button' class='btn btn-warning btn-xs' onclick='changeStatus("+object.id+","+object.status+")'>禁用</button>&nbsp;&nbsp;&nbsp;";
				}
				else {
					result += "<button type='button' class='btn btn-success btn-xs' onclick='changeStatus("+object.id+","+object.status+")'>启用</button>&nbsp;&nbsp;&nbsp;";
				}
				result += "<a class='btn btn-info btn-xs' onclick='modifyWord(" + id + ")'>修改</a>";
			}
			
			return result;
		}
		
		//请求服务数据时所传参数
		function queryParams(params) {
    		let pageNo = (params.offset / params.limit) + 1;
    		let english = $('#english').val();
    		let chinese = $('#chinese').val();
    		
			return {
				//页码  
				pageNo : pageNo,
				//页面大小
				pageSize : params.limit,
				
				english : english,
				
				chinese : chinese
			}
	    }
		
		//单词加入个人词库
		function addWord(english, chinese) {
			$.post('${pageContext.request.contextPath}/word/addWordAjax.action',
					{'english':english, 'chinese':chinese},
					function(data) {
						$('#cusTable').bootstrapTable('refresh');
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
		
		//修改单词状态
   		function changeStatus(id, status) {
   			let flag;
			if(status == '1')
				flag = 0;
			else
				flag = 1;
			$.post('${pageContext.request.contextPath}/word/modifyWordStatus.action',
					{'id':id, 'status':flag},
					function(data) {
						$('#cusTable').bootstrapTable('refresh');
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
		
   		//修改单词收藏状态
   		function changeFavoriteStatus(id, userId, isFavorite) {
   			let flag;
			if(isFavorite == '1')
				flag = 0;
			else
				flag = 1;
			$.post('${pageContext.request.contextPath}/word/modifyWordFavoriteStatus.action',
					{'id':id, 'userId':userId, 'isFavorite':flag},
					function(data) {
						$('#cusTable').bootstrapTable('refresh');
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
   	  	setTimeout(function() {
			$('#english').focus();
		}, 500);  
    	
    	//ajax生成bootstrap表格
  		initTable();
    	  
        $('#english').on('input propertychange', function() {
        	initTable();
        });
        
        $('#chinese').on('input propertychange', function() {
        	initTable();
        });
        
        $('#frmModifyWord').on('input propertychange', function() {
        	let validator = $('#frmModifyWord').data("bootstrapValidator");	//获取validator对象
        	validator.validate();	//手动触发验证
           	if (validator.isValid()) {	//通过验证
           		$('#modifyBtn').prop('disabled', false);
           	}
           	else {
           		$('#modifyBtn').prop('disabled', true);
           	}        		
        });
        
        $('#requestChinese').on('click', function() {
    		let english = $('#english2').val();
    		if (english != "" && english != null) {
    			//ajax同步方式提交数据
   				$.ajaxSettings.async = false;
    			$.post('${pageContext.request.contextPath}/allword/findChinese.action',
    	    			{'english': english},
    	    			function(data) {
    	    				if (data != "null")
    	    					$('#chinese2').val(data);
    	    			}, 'text');
    			$('#frmModifyWord').data('bootstrapValidator').destroy();
        		$('#frmModifyWord').data('bootstrapValidator', null);
        		frmModifyWordValidator();
        		let validator = $('#frmModifyWord').data("bootstrapValidator");
            	validator.validate();
            	$('#modifyBtn').prop('disabled', false);
    		}
    	});
        
        $('#modifyBtn').on('click', function() {
        	let validator = $('#frmModifyWord').data("bootstrapValidator");
        	validator.validate();
       		if (validator.isValid()) {
           		let id = $('#id').val();
           		let english = $('#english2').val();
           		let chinese = $('#chinese2').val();
           		//ajax同步方式提交数据
   				$.ajaxSettings.async = false;
           		$.post('${pageContext.request.contextPath}/word/modifyWord.action',
           			{'id':id,'english':english,'chinese':chinese},
           			function(data) {
						$('#cusTable').bootstrapTable('refresh');
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
					} ,'json');
           		$('#modifyWord').modal('hide');
           		$('#cusTable').bootstrapTable('refresh');
           	}
           	else {
           		$('#modifyBtn').prop('disabled', true);
           	}
        });
        
        
      });
      
      function modifyWord(id) {
    	  $('#modifyBtn').prop('disabled', false);
    	  frmModifyWordValidator();	//防止destroy不能被调用
    	  $('#frmModifyWord').data('bootstrapValidator').destroy();
  		  $('#frmModifyWord').data('bootstrapValidator', null);
    	  $.post('${pageContext.request.contextPath}/word/findWordById.action',
    		{'id':id},
    		function(word) {
    			$('#id').val(word.id);
    			$('#primeEnglish').val(word.english);
    			$('#english2').val(word.english);
    			$('#chinese2').val(word.chinese);
    	    	$('#modifyWord').modal('show');
    	    	frmModifyWordValidator();
    	  }, 'json');
    	  
      }
        
      //开始播放
      function playVoice(id, english) {
      	let audio = $('#mp3Btn-'+id)[0];
		event.stopPropagation();	//防止冒泡
		if(audio.paused) {	//如果当前是暂停状态
			audio.src = 'http://dict.youdao.com/dictvoice?audio=' + english + '&type=1"';	//type=1为英式,2为美式
			let playPromise = audio.play();	//播放
			if (playPromise != undefined) {
				playPromise.then(function() {
					$('#voiceBtn-'+id).removeClass('glyphicon-volume-down');
					$('#voiceBtn-'+id).addClass('glyphicon-volume-up');
				}).catch(function(error) {
					alert('无网络');
				});
			}
			
		}
      }
      
      //播放完毕
      function playEnd(id) {
      	$('#voiceBtn-'+id).removeClass('glyphicon-volume-up');
      	$('#voiceBtn-'+id).addClass('glyphicon-volume-down');
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
      
    </script>
	
  </head>

  <body>
	<% request.setAttribute("index", 4); %>
	<jsp:include page="top.jsp"/>
    <div class="container text-center" style="margin-top: 20px;">
      <form class="form-inline">
        <div class="form-group">
	       	<label style="font-size: 1.2em; font-weight: bold;">英文单词:</label>
	       	<input class="form-control" type="text" style="margin-right: 50px;" name="english" id="english" />
        </div>
        <div class="form-group">
        	<label style="font-size: 1.2em; font-weight: bold;">中文释义:</label>
        	<input class="form-control" type="text" name="chinese" id="chinese" />
        </div>
      </form>
    </div>
    
    <div class="container" style="margin-top: 50px;">
      <table id="cusTable">
      	<!--使用设置每一列的宽度-->
		<colgroup>
			<col style="width:15%;">
			<col style="width:5%;">
			<col style="width:45%;">
			<col style="width:15%;">
			<col style="width:20%;">
		</colgroup>
      </table>
    </div>
    
    <!-- 修改单词模态框begin -->
	<div class="modal fade" id="modifyWord" tabindex="-1" role="dialog">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">修改单词</h4>
	      </div>
	      <div class="modal-body">
	      	<form id="frmModifyWord" class="form-horizontal" method="post" action="">
	      		<input type="hidden" id="id">
	      		<input type="hidden" id="primeEnglish">
	      		<div class="form-group">
	      			<label class="col-sm-3 col-sm-offset-1 col-xs-4 control-label text-right">English:</label>
	      			<div class="col-sm-5 col-xs-6">
	      				<input class="form-control" type="text" id="english2" name="english">
	      			</div>
	      		</div>
	      		<div class="form-group">
	      			<label class="col-sm-3 col-sm-offset-1 col-xs-4 control-label text-right">中文释义:</label>
	      			<div class="col-sm-5 col-xs-6">
	      				<input class="form-control" type="text" id="chinese2" name="chinese">
	      			</div>
	      		</div>
	      		<div class="form-group">
			       <div class="col-sm-6 col-sm-offset-3 col-xs-8 col-xs-offset-2">
			       	 <div class="col-sm-6 col-xs-6">
				         <input type="button" id="requestChinese" class="btn btn-primary btn-block" value="获取中文">
			       	 </div>
			       	 <div class="col-sm-6 col-xs-6">
			       	 	 <button type="button" id="modifyBtn" class="btn btn-primary btn-block">确认修改</button>
			       	 </div>
			       </div>
			    </div>
	      	</form>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
    <!-- 修改单词模态框end -->
    
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="${pageContext.request.contextPath}/assets/js/ie10-viewport-bug-workaround.js"></script>
  </body>
</html>

