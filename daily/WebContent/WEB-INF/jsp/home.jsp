<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="itheima" uri="http://itheima.com/common/"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="robots" content="noimageindex, noarchive">


<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/static/img/favicon.ico"
	type="image/x-icon">
<link rel="icon"
	href="${pageContext.request.contextPath}/static/img/favicon.ico"
	type="image/x-icon">
<title>首页</title>

<link href="<%=basePath%>static/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" />
<link href="<%=basePath%>static/vendor/css/style.css" rel="stylesheet" />
<link href="<%=basePath%>static/vendor/css/letter.css" rel="stylesheet" />

<script src="<%=basePath%>static/vendor/css/popper.min.js"></script>
<script src="<%=basePath%>static/vendor/js/jquery-3.4.1.min.js"></script>
<script src="<%=basePath%>static/vendor/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript">
        var dailyId=null; 
        var selectedFile = null; // 用于保存用户选择的文件数据
        
		function sendDaily(){
        	  var daily_details =  $("#daily_details").val();  <!-- 获取了ID为daily_details的元素中用户编写的日报内容 -->	
        	  if (daily_details == ""){
        		  alert("日志内容不能为空！")
        		  return
        	  }
        	  var pattern = /<[a-z][\s\S]*>/i;
        	  var containsHtmlTag = pattern.test(daily_details);
        	  if (containsHtmlTag) {
        	      alert("文本包含HTML标签,不允许发送");
        	      return
        	  }
        	  var privacy = "0"; <!-- 日志公开状态 -->	
        	  if($("#privacy").val()=="私密"){
        		  privacy = "1";
        	  }
        	  
        	  // 对日报内容中的#xxxxx#进行替换
        	  var basePath = '<%=basePath %>';
        	  var forwardUrl = basePath + 'daily' + '/searchtag/$1';
        	  daily_details = daily_details.replace(/#([^#]+)#/g, '<a href="' + forwardUrl + '">$&</a>');
        	  
        	  var json = {"daily_details":daily_details,"privacy":privacy}; <!-- 将用户输入的日报内容和公开状态打包成一个JSON字符串 -->	
        	  
        	  if (selectedFile) {
        		    // 创建文件上传表单数据
        		    var formData = new FormData();
        		    formData.append('file', selectedFile);

        		    // 发送文件到后端
        		    $.ajax({
        		      type: 'post',
        		      url: '<%=basePath %>multi-media/upload',
        		      data: formData,
        		      processData: false,
        		      contentType: false,
        		      success: function(response) {
        		    	  var fileUrl = response;  // 获取fileUrl的值

        		          var imgTag = '<hr><img src="' + fileUrl + '" style="max-width:300px; max-height:200px;">';
        		        daily_details += imgTag;

        		        // 继续发送日报内容到后端
        		        json.daily_details = daily_details;
        		        sendDailyRequest(json);
        		      },
        		      error: function(error) {
        		        alert('文件上传失败');
        		      }
        		    });
        		  } else {
        		    sendDailyRequest(json);
        		  }
        		}
          
		function sendDailyRequest(json) {
			  $.ajax({
			    type: "post",
			    url: "<%=basePath %>daily/create",
			    contentType: "application/json;charset=utf-8",
			    dataType: "json",
			    data: JSON.stringify(json),
			    success: function(data) {
			    	alert('日志发送成功，草稿已清除');
			      showDaily();
			    },
			    error: function() {
			      showDaily();
			    }
			  });
			}
        
          function showDaily(){
          	document.getElementById('daily_details').innerHTML=""; //清空原文本框内的内容	
        	    window.location.href = "<%=basePath %>daily/list"; // 更新日志内容	
          } 
          
  		function mycheck(){
		    var tag = $("#tag").val();
		    if(tag == ""){
		    	alert("请输入搜索内容！");
		        return false;
		    }
		    return true;
		}
          
        </script>
<style>
pre {
	white-space: pre-wrap; /* css-3 */
	white-space: -moz-pre-wrap; /* Mozilla, since 1999 */
	white-space: -pre-wrap; /* Opera 4-6 */
	white-space: -o-pre-wrap; /* Opera 7 */
	word-wrap: break-word; /* Internet Explorer 5.5+ */
	font-family: "微软雅黑";
	font-size: 15px;
}

p {
	font-family: "微软雅黑";
	font-size: 15px;
}
</style>
</head>

<body>
	<nav class="navbar navbar-expand-lg transparent-navbar">
		<a class="navbar-brand" href="#"> <img
			src="${pageContext.request.contextPath}/static/img/logo_home.png"
			alt="Logo" class="logo-img">
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarColor03" aria-controls="navbarColor03"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse m-auto" id="navbarColor03">
			<ul class="navbar-nav m-auto">
				<li class="nav-item active"><a class="nav-link"
					href="${pageContext.request.contextPath}/daily/list"><button
							class="btn btn-outline-success active">
							&nbsp; <span class="glyphicon glyphicon-home"></span>&nbsp;&nbsp;<span
								class="badge badge-light"></span>
						</button></a></li>
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath}/user/list"><button
							class="btn btn-outline-success">
							&nbsp; <span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;<span
								class="badge badge-light"></span>
						</button></a></li>
				<li class="nav-item"><a class="nav-link" href="#"><button
							class="btn btn-outline-success" type="button" id="comment1">
							&nbsp; <span class="glyphicon glyphicon-comment"></span>&nbsp;&nbsp;<span
								class="badge badge-light" id="send_number"></span>
						</button></a></li>
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath}/letter/list"><button
							class="btn btn-outline-success">
							&nbsp; <span class="glyphicon glyphicon-envelope"></span>&nbsp;&nbsp;<span
								class="badge badge-light"></span>
						</button></a></li>
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath}/logout"><button
							class="btn btn-outline-success">
							&nbsp; <span class="glyphicon glyphicon-log-out"></span>&nbsp;&nbsp;<span
								class="badge badge-light"></span>
						</button></a></li>
			</ul>
			<form class="form-inline m-auto"
				action="${pageContext.request.contextPath}/searchtext" method="post"
				onsubmit="return mycheck()">
				<input class="form-control mr-sm-2" type="text" name="tag"
					placeholder="搜索一下" id="tag">
				<button class="btn btn-success" type="submit" data-toggle="modal"
					data-target="#search">搜索</button>
			</form>

		</div>
	</nav>
	<div class="commentPopup themeColor" id="commentPopup" tabindex='-1'
		style="background-color: rgba(240, 255, 255, 0.8);">
		<!--私信-->

	</div>

	<div class="container">
		<div class="row">
			<div class="col-lg-4 rounded" style="margin-top: 7px">
				<div class="row">
					<div class="row m-auto bg"
						style="width:380px;height:110px;background: url('<%=basePath %>static/img/background.jpg')">
						<img class="headPicture"
							src="${pageContext.request.contextPath}/static/img/${USER_SESSION.daily_picture}" />
					</div>

					<div class="container-fluid bordeShadow">
						<div class="row" style="margin-top: 20px; margin-bottom: 20px">
							<div class="col-lg-4 m-auto hand" onclick="mylist()">
								<div class="row m-auto">
									<span>博客</span>
								</div>
								<span class="text-center"><%=session.getAttribute("dailyCount") %></span>
							</div>

							<div class="col-lg-4 m-auto hand" onclick="dailyfriend()">
								<div class="row m-auto">好友</div>
								<span class="text-center"><%=session.getAttribute("friendCount") %></span>
							</div>
							<div class="col-lg-4 m-auto hand">
								<div class="row m-auto">访问记录</div>
								<span class="text-center"><%=session.getAttribute("friendCount") %></span>
							</div>

							<div id="userSession_id" style="display: none;">${USER_SESSION.user_id}</div>
							<div id="userSession_name" style="display: none;">${USER_SESSION.user_name}</div>

						</div>
					</div>

				</div>
			</div>


			<div class="col-lg-8" style="margin-top: 7px;">

				<div class="row themeColor hand transparent-navbar bg-primary"
					style="padding-top: 12px;" data-toggle="modal"
					data-target="#logModal">
					<div class="col-lg-1">
						<img class="smallHeadPicture"
							src="${pageContext.request.contextPath}/static/img/${USER_SESSION.daily_picture}" />
					</div>

					<div class="col-lg-8">
						<div class="form-group">
							<div class="row">
								<input class="form-control form-control hand" type="text"
									placeholder="分享一下今天的日常" id="inputLarge">
							</div>
						</div>
					</div>
					<div class="col-lg-2">
						<button class="btn btn-primary">发日志</button>
					</div>

				</div>

				<div class="modal fade show" id="logModal" tabindex="-1"
					role="dialog" aria-labelledby="exampleModalLongTitle"
					aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLongTitle">日志</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<div class="form-group">
									<textarea class="form-control" id="daily_details" rows="15"></textarea>
								</div>
								<div id="preview"></div>
							</div>
							<div class="modal-footer">
								<button class="btn btn-outline-success active "
									onclick="triggerFileInput()">
									<span class="glyphicon glyphicon-plus-sign" id="uploadIcon"></span>
								</button>
								<input type="file" id="mediaFileInput" accept="image/*, video/*"
									style="display: none;"><select class="btn" id="privacy">
									<option selected="selected">公共</option>
									<option>私密</option>
								</select>

								<button type="button" class="btn btn-secondary"
									data-dismiss="modal" onclick="confirmSaveDocument()">关闭</button>
								<button type="button" class="btn btn-primary"
									onclick="sendDaily()">发送</button>
								<!-- 发送日志 -->

							</div>
						</div>
					</div>
				</div>

				<!-- 展示日志 -->
				<c:forEach items="${dailyList}" var="daily">
					<div class="message themeColor rounded-top"
						style="background-color: rgba(128, 128, 128, 0.5);">
						<div class="row">
							<div class="col-lg-1">
								<img class="middleHeadPicture"
									src="<%=basePath %>static/img/${daily.daily_picture}"
									onclick="location.href='<%=basePath %>dailyFriend/'+${daily.user_id}+'/list'">
							</div>
							<div class="col-lg-11">
								<div style="clear: both">
									<div style="width: 84px; float: left">
										<span class="author"> <strong>${daily.daily_author}</strong>
										</span>
									</div>
									<div style="margin-left: 610px">
										<div class="btn-group">
											<button type="button"
												class="btn btn-default dropdown-toggle dropdown-toggle-split"
												data-toggle="dropdown"></button>
											<c:if test="${USER_SESSION.user_id== daily.user_id}">
												<div class="dropdown-menu">
													<a class="dropdown-item"
														href="<%=basePath %>daily/${daily.daily_id}/delete">删除</a>
												</div>
											</c:if>
										</div>
									</div>
								</div>

								<!-- 编辑本人日志 -->
								<c:if test="${USER_SESSION.user_id == daily.user_id}">
									<div class="logContext">
										<p class="text-primary"
											onblur="updateDaily(${daily.daily_id}, ${USER_SESSION.user_id}, ${daily.user_id})"
											id="detail${daily.daily_id}" contenteditable="true">${daily.daily_details}</p>
									</div>
								</c:if>
								<c:if test="${USER_SESSION.user_id!= daily.user_id }">
									<div class="logContext">
										<pre class="text-primary">${daily.daily_details}</pre>
									</div>
								</c:if>
							</div>
						</div>

						<div class="row text-right">
							<div class="col-lg-2">
								<button class="btn">
									<span class="glyphicon glyphicon-comment"> </span>
								</button>
							</div>

							<!-- 转发 -->
							<div id="daily_author${daily.daily_id}" style="display: none;">${daily.daily_author}</div>
							<div id="daily_details${daily.daily_id}" style="display: none;">${daily.daily_details}</div>
							<div id="user_id${daily.daily_id}" style="display: none;">${daily.user_id}</div>
							<div class="col-lg-2">
								<button class="btn">
									<span class="glyphicon glyphicon-share-alt"
										onclick="showForwardModal(this)"
										data-daily-id="${daily.daily_id}"> </span>
								</button>
							</div>
							<div class="modal fade show" id="forwardModal" tabindex="-1"
								role="dialog" aria-labelledby="exampleModalLongTitle"
								aria-hidden="true">
								<div class="modal-dialog" role="document">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title" id="exampleModalLongTitle">转发</h5>
											<button type="button" class="close" data-dismiss="modal"
												aria-label="Close" onclick="hideForwardModal()">
												<span aria-hidden="true">&times;</span>
											</button>
										</div>
										<div class="modal-body">
											<div class="form-group">
												<textarea class="form-control" id="commentInput" rows="5"
													placeholder="请输入评论内容"></textarea>
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-dismiss="modal" onclick="hideForwardModal()">关闭</button>
											<button type="button" class="btn btn-primary"
												onclick="forwardArticle()">转发</button>
										</div>
									</div>
								</div>
							</div>

							<!-- 点赞 -->
							<div class="col-lg-2">
								<div id="likeContainer">
									<%boolean islike=false; %>
									<c:forEach items="${daily.likes}" var="like">
										<c:if test="${like.user_id eq USER_SESSION.user_id}">
											<button class="btn" id="likedButton${daily.daily_id}"
												onclick="unlikePost(${daily.daily_id},${like.id})">
												<span class="glyphicon glyphicon-thumbs-up red"
													id="liketag${daily.daily_id}"> </span>
											</button>
											<%islike=true; %>
										</c:if>
									</c:forEach>
									<%if (islike==false){%>
									<button class="btn" id="likeButton${daily.daily_id}"
										onclick="likePost(${daily.daily_id},${daily.user_id})"
										data-daily-id="${daily.daily_id}">
										<span class="glyphicon glyphicon-thumbs-up"
											id="liketag${daily.daily_id}"> </span>
									</button>
									<%} %>
									<span id="likeCount${daily.daily_id}">${daily.likeCount}</span>
								</div>
							</div>
						</div>
					</div>

					<!-- 评论区 -->
					<div class="row themeColor commentBody rounded-bottom"
						style="background-color: rgba(128, 128, 128, 0.5)"
						id="bc${daily.daily_id}">
						<c:forEach items="${daily.comments}" var="comment">
							<div class="commentDiv">
								<span class="user hand">${comment.user_name}&nbsp;&nbsp;:&nbsp;&nbsp;</span>
								<span class="comment hand">${comment.com_detail}</span>
								<c:if test="${USER_SESSION.user_id== comment.user_id}">
									<button type="button"
										class="btn btn-default dropdown-toggle dropdown-toggle-split small-transparent-btn"
										data-toggle="dropdown"></button>
									<div class="dropdown-menu">
										<a class="dropdown-item"
											href="<%=basePath %>daily/${daily.daily_id}/comment/${comment.id}/delete">删除</a>
									</div>
								</c:if>
							</div>
						</c:forEach>
					</div>

					<div class=" input-group mb-3" style="margin-top: 5px;">
						<input type="text" class="form-control"
							aria-describedby="emailHelp" placeholder="说说你的评论"
							id="c${daily.daily_id}" />
						<div class="input-group-append">
							<button class="btn btn-success" type="button"
								onclick="sendComment(${daily.daily_id})">发送</button>
						</div>
					</div>
				</c:forEach>

			</div>
		</div>
	</div>

	<script>
            <!-- 加好友区功能 -->	
              $(document).ready(function(){
                $('#commentPopup').hide();
              });
              $('#comment1').focus(function(){
                $('#commentPopup').show();
                $('#commentPopup').focus();
              });
              $('#commentPopup').blur(function(){
            	  $.ajax({
	        	        type : "get",
	        	        url : "<%=basePath%>read",
	        	        dataType:"json",
	        	        success : function(data){
	        	        	$("#commentPopup").html("");
	        	        	$("#send_number").html("");
	        	        	$('#commentPopup').hide();
	        	        },
	        	        error : function(){
	        	        }
	        	    })
              });            			
		            
              var length=null;
		            window.onload = function() {
		            	  var noticePromise = getNotice();
		            	  var likeMessagePromise = getLikeMessage();

		            	  Promise.all([noticePromise, likeMessagePromise])
		            	    .then(function(results) {
		            	      var noticeData = results[0];
		            	      var likeMessageData = results[1];

		            	      notice(noticeData);
		            	      likemessage(likeMessageData);
		            	    })
		            	    .catch(function(error) {
		            	      console.error(error);
		            	    });
		            	};
		            	
		            	function getNotice() {
		            		  return new Promise(function(resolve, reject) {
		            		    $.ajax({
		            		      type: "get",
		            		      url: "<%=basePath%>notice",
		            		      dataType: "json",
		            		      success: function(data) {
		            		        resolve(data);
		            		        console.log(data);
		            		      },
		            		      error: function() {
		            		        reject(new Error("Failed to get notice data."));
		            		      }
		            		    });
		            		  });
		            		}
		            	
		            function notice(data){
		            	var i;
      	        	var html = "";
      	        	if(data.length!=0)
      	        		length=data.length;
      	        	for(i=0;i<data.length;i++){
      	        		var msg = data[i].user_id;
      	        		html += `<div class=""><span class="text-info hand">`+data[i].user_name+`</span><span>&nbsp;&nbsp;请求添加好友&nbsp;&nbsp;</span><span href="#" class="text-info hand" onclick=agree(`+msg+`)>同意</span><span style="display:none">`+data[i].user_id+`</span></div>`;
      	        	}
      	        	$("#commentPopup").html(html);
		            }
		            
		            function agree(friend_id){
		            	$.ajax({
		        	        type : "post",
		        	        url : "<%=basePath%>agree",
		        	        dataType:"json",
		        	        data: {"friend_id":friend_id},
		        	        success : function(data){
		        	        },
		        	        error : function(){
		        	        }
		        	    });
		            } 
		            
		            <!-- 点赞消息区功能 -->
		            function getLikeMessage() {
		            	  return new Promise(function(resolve, reject) {
		            	    $.ajax({
		            	      type: "get",
		            	      url: "<%=basePath%>likemessage",
		            	      dataType: "json",
		            	      success: function(data) {
		            	        resolve(data);
		            	      },
		            	      error: function() {
		            	        reject(new Error("Failed to get like message data."));
		            	      }
		            	    });
		            	  });
		            	}
		            function likemessage(data){
		            	var i;
		            	var html = $("#commentPopup").html() || "";
        	        	if(data.length!=0)
        	        		$("#send_number").html(data.length+length);
        	        	else
        	        		if (length != 0)
        	        			$("#send_number").html(length);
        	        	for(i=0;i<data.length;i++){
        	        		html += `<div class=""><span class="text-info hand">`+data[i]+`</span></div>`;
        	        	}
        	        	$("#commentPopup").html(html);
		            }           

				function sendComment(daily_id){
					var name = "c"+daily_id;
					var bc = "bc"+daily_id;
					
					var com_detail = document.getElementById(name).value;
					if (com_detail == ""){
						alert("评论内容不能为空！");
						return
					}
		        	var pattern = /<[a-z][\s\S]*>/i;
		        	var containsHtmlTag = pattern.test(com_detail);
		        	if (containsHtmlTag) {
		        		alert("文本包含HTML标签,不允许发送");
		        		return
		        		}
					document.getElementById(name).value = "";
					$.ajax({
	        	        type : "post",
	        	        url : "<%=basePath%>comment",
	        	        dataType:"json",
	        	        data: {"daily_id":daily_id,"com_detail":com_detail},
	        	        success : function(data){
	        	        	var html = "";
	        	        	html = document.getElementById(bc).innerHTML;
	        	        	html += `<div class="commentDiv"><span class="user hand">`+data.user_name+`:</span><span class="comment hand">`+com_detail+`</span></div>`;
	        	        	document.getElementById(bc).innerHTML=html;
	        	        },
	        	        error : function(){
	        	        }
	        	    });
				}
				
				function dailyfriend(){
					window.location.href = "<%=basePath%>dailyFriend";
				}
				
				function mylist(){
					window.location.href = "<%=basePath%>mylist";
				}
				
			    function updateDaily(daily_id, user, id) {
			        var d = "detail" + daily_id;
			        if (user !== id) {
			            return;
			        }
			        var daily_details = document.getElementById(d).innerHTML.trim();
			        if (daily_details === '') {
			            alert("日志内容不能为空！");
			            location.reload();
			            return;
			        }
			        console.log(daily_details);
			        $.ajax({
			            type: "post",
			            url: "<%=basePath%>daily/update",
			            dataType: "json",
			            data: {"daily_id": daily_id, "daily_details": daily_details},
			            success: function (data) {
			                alert("修改成功！");
			            },
			            error: function () {
			                // 处理失败的回调
			            }
			        });
			    }
				
				//草稿功能
				function confirmSaveDocument() {
					var documentContent = $('#daily_details').val();
    
					if (documentContent.trim() !== '') {
						var confirmSave = confirm("文档已修改，是否保存？");
						
						if (confirmSave) {
							// 发送保存请求给后端
							saveDocument(documentContent);
							}
						}
					}
				
				function saveDocument(content) {
				    var data = { content: content };
				    $.ajax({
				        type: 'POST', // 指定请求方法为POST
				        url: '<%=basePath %>saveDocument',
				        data: JSON.stringify(data), // 将数据转换为 JSON 字符串
				        contentType: 'application/json', // 指定请求的内容类型为 JSON
				        success: function(response) {
				            alert("文档保存成功");
				        },
				        error: function(xhr, status, error) {
				            var errorMessage = xhr.responseText;
				            alert("文档保存失败：" + errorMessage);
				        }
				    });
				}
				
				//草稿内容填充
				$(document).ready(function() {
					// 页面加载完成时，获取草稿表的内容
					$.ajax({
						type: 'post',
						url: '<%=basePath %>getDraftContent',
						success: function(response) {
							// 将获取到的内容设置到文本区域中
							$('#daily_details').val(response.content);
							},
							error: function(xhr, status, error) {
								// 处理错误响应
								var errorMessage = xhr.responseText;
								alert("获取草稿内容失败：" + errorMessage);
								}
							});
					});
				
				  //多媒体文件上传
		        function triggerFileInput() {
		        	document.getElementById('mediaFileInput').click();
		        	}
		        
		        // 监听文件选择框的change事件
		        document.getElementById('mediaFileInput').addEventListener('change', handleFileSelect, false);

		        function handleFileSelect(event) {
		        	  var file = event.target.files[0];

		        	  // 根据文件类型和大小进行限制
		        	  if (file.type.startsWith('image/') && file.size > 5 * 1024 * 1024) {
		        	    alert('图片文件大小不能超过5MB');
		        	    return;
		        	  } else if (file.type.startsWith('video/') && file.size > 20 * 1024 * 1024) {
		        	    alert('视频文件大小不能超过20MB');
		        	    return;
		        	  }
		        	  
		        	  selectedFile = file; // 保存用户选择的文件

		        	  // 创建文件预览图
		        	  var reader = new FileReader();
		        	  reader.onload = function(event) {
		        	    var preview = document.getElementById('preview');
		        	    preview.innerHTML = '';

		        	    // 创建包含图片的容器
		        	    var container = document.createElement('div');
		        	    container.style.position = 'relative';
		        	    container.style.display = 'inline-block';

		        	    // 根据文件类型创建不同的预览元素
		        	    if (file.type.startsWith('image/')) {
		        	      var imgWrapper = document.createElement('div');
		        	      imgWrapper.className = 'image-wrapper';

		        	      var img = document.createElement('img');
		        	      img.src = event.target.result;
		        	      img.style.maxWidth = '50%';
		        	      img.style.maxHeight = '50%';
		        	      imgWrapper.appendChild(img);

		        	      // 创建关闭按钮（×）
		        	      var closeButton = document.createElement('button');
		        	      closeButton.innerHTML = '×';
		        	      closeButton.className = 'close-button';
		        	      closeButton.onclick = function() {
		        	        preview.innerHTML = '';
		        	        selectedFile = null; // 清除选择的文件
		        	      };

		        	      // 将关闭按钮添加到图片容器中
		        	      imgWrapper.appendChild(closeButton);

		        	      // 将图片容器添加到预览容器中
		        	      container.appendChild(imgWrapper);
		        	    } else if (file.type.startsWith('video/')) {
		        	      var video = document.createElement('video');
		        	      video.src = event.target.result;
		        	      video.style.maxWidth = '50%';
		        	      video.style.maxHeight = '50%';
		        	      video.controls = true;
		        	      container.appendChild(video);

		        	      // 创建关闭按钮（×）
		        	      var closeButton = document.createElement('button');
		        	      closeButton.innerHTML = '×';
		        	      closeButton.className = 'close-button';
		        	      closeButton.onclick = function() {
		        	        preview.innerHTML = '';
		        	        selectedFile = null; // 清除选择的文件
		        	      };

		        	      // 将关闭按钮添加到预览容器中
		        	      container.appendChild(closeButton);
		        	    }

		        	    // 将预览容器添加到预览区域中
		        	    preview.appendChild(container);
		        	  };

		        	  reader.readAsDataURL(file);
		        	}
				
				//转发
				function showForwardModal(button) {
					
					dailyId = button.getAttribute("data-daily-id");
					  // 隐藏转发模态框
					  $('#forwardModal').hide();

					  // 显示转发模态框，并添加淡入效果
					  $('#forwardModal').fadeIn('fast', function() {
					    $('#forwardModal').show();
					  });
					  }

				function hideForwardModal() {
					
					// 隐藏转发模态框，并添加淡出效果
					$('#forwardModal').fadeOut('fast', function() {
						$('#forwardModal').hide();
						});
					}
				
				function getCommentContent() {
					return $('#commentInput').val();
					}
				
			    function getDailyId(dailyId) {
			        return dailyId;
			    }
				
				function forwardArticle() {
					  var comment = getCommentContent();
					  if (comment === '') {
					    comment = '转发博客';
					  }
					  var daily_author = document.getElementById("daily_author" + dailyId);
					  var authorName = daily_author.innerHTML;
					  console.log(authorName);
					  var daily_details = document.getElementById("daily_details" + dailyId);
					  var articleContent= daily_details.innerHTML;
					  console.log(articleContent);
					  var user_id = document.getElementById("user_id" + dailyId);
					  var UserId = user_id.innerHTML;
					  console.log(UserId);
					  var privacy = "0"; 
					  var basePath = '<%=basePath%>';
					  var forwardUrl = basePath + 'dailyFriend/' + UserId + '/list';
					  var forwardContent = comment + '<hr>' + '<a href="' + forwardUrl + '">' + '@' +authorName + ':</a><br>' + articleContent;
		        	  var json = {"daily_details":forwardContent,"privacy":privacy};
		        	  
		        	  $.ajax({
		      	        type : "post",
		      	        url : "<%=basePath%>daily/create",
		      	        contentType : "application/json;charset=utf-8",
		      	        dataType : "json",
		      	        data: JSON.stringify(json),
		      	        success : function(data){
		      	        	hideForwardModal();
		      	            showDaily();
		      	            
		      	        },
		      	        error : function(){
		      	        	showDaily();
		      	        }
		      	    })
					  
					}
				
				//点赞
				function likePost(DailyId,Author_id) {
					
				    // 增加点赞数,发送 AJAX 请求
				    $.ajax({
				    	type: "POST",
				    	url: "<%=basePath%>daily/"+DailyId+"/"+Author_id+"/updatelike",
				    	success: function(likeCount) {
				    		// 更新点赞数的显示
				    	    var likeCountElement = document.getElementById("likeCount"+DailyId);
				    	    likeCountElement.innerText = likeCount; 
				    	    
				    	    // 创建一个新的元素来显示点赞数
				    	    var newLikeCountElement = $("<span>").text(likeCount);
				    	    
				    	    // 将新元素添加到页面中，并进行动画效果
				    	    $(likeCountElement).fadeOut(200, function() {
				    	        $(likeCountElement).replaceWith(newLikeCountElement);
				    	        $(newLikeCountElement).hide().fadeIn(500);
				    	    });
				    	    
				    	    // 添加点赞图标变亮的动画效果
				    	    var thumbsUpIcon = document.getElementById("liketag"+DailyId);
				    	    thumbsUpIcon.classList.add("active");
				    	    
				    	},
				    	error: function(xhr, status, error) {
				    	}
				    	});
					
					// 发送点赞消息给作者
					var user_name = document.getElementById('userSession_name');//用户昵称
					var nickname= user_name.innerHTML;
					
					var user_id = document.getElementById('userSession_id');//用户ID
					var id= user_id.innerHTML;
					
					var daily_details = document.getElementById("daily_details" + DailyId);//文章内容
					var articleTitle= daily_details.innerHTML;
					articleTitle = articleTitle.replace(/<[^>]+>/g, '');
					
					var basePath = '<%=basePath%>';
					var forwardUrl = basePath + 'dailyFriend/' + id + '/list';
					var message = '用户<a href="' + forwardUrl + '">' + nickname + "</a> 点赞了您的 " + articleTitle.substring(0, 10) + "...";
					
					var data = {
							  author_id: Author_id,
							  message: message
							};
					
					// 发送点赞消息给作者
					$.ajax({
						type: "POST",
						url: "<%=basePath%>like/send-like-message",
						data: JSON.stringify(data),
						contentType: "application/json",
						success: function(response) {
							location.reload();
							},
							error: function(error) {
								alert("请求失败！")
								}
							});
					}

				function unlikePost(DailyId,Id) {
				    // 增加点赞数,发送 AJAX 请求
				    $.ajax({
				    	type: "POST",
				    	url: "<%=basePath%>daily/"+DailyId+"/"+Id+"/deletelike",
				    	success: function(likeCount) {
				    		// 更新点赞数的显示
				    	    var likeCountElement = document.getElementById("likeCount"+DailyId);
				    	    likeCountElement.innerText = likeCount; 
				    	    
				    	    // 创建一个新的元素来显示点赞数
				    	    var newLikeCountElement = $("<span>").text(likeCount);
				    	    
				    	    // 将新元素添加到页面中，并进行动画效果
				    	    $(likeCountElement).fadeOut(200, function() {
				    	        $(likeCountElement).replaceWith(newLikeCountElement);
				    	        $(newLikeCountElement).hide().fadeIn(500);
				    	    });
			                
				    	    var thumbsUpIcon = document.getElementById("liketag"+DailyId);
				    	    thumbsUpIcon.classList.remove("red");
				    	    
				    	    location.reload();
				    	    
				    	},
				    	error: function(xhr, status, error) {
				    		location.reload();
				    	}
				    	});				
					}
				
			    // 获取当前时间
			    var now = new Date();
			    var hour = now.getHours();
			  
			    // 根据时间设置不同的壁纸
			    if (hour >= 6 && hour < 12) {
			        document.body.style.backgroundImage = "url('${pageContext.request.contextPath}/static/img/morning_home_wallpaper.jpg')";
			    } else if (hour >= 12 && hour < 18) {
			        document.body.style.backgroundImage = "url('${pageContext.request.contextPath}/static/img/afternoon_home_wallpaper.jpg')";
			    } else {
			        document.body.style.backgroundImage = "url('${pageContext.request.contextPath}/static/img/evening_home_wallpaper.jpg')";
			    }
			    
			</script>
</body>
</html>