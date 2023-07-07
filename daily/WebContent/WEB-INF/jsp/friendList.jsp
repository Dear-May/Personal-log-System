<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<title>日志</title>

<link href="<%=basePath%>static/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" />
<link href="<%=basePath%>static/vendor/css/style.css" rel="stylesheet" />
<link href="<%=basePath%>static/vendor/css/letter.css" rel="stylesheet" />

<script src="<%=basePath%>static/vendor/css/popper.min.js"></script>
<script src="<%=basePath%>static/vendor/js/jquery-3.4.1.min.js"></script>
<script src="<%=basePath%>static/vendor/bootstrap/js/bootstrap.min.js"></script>

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
</style>
</head>

<body>
	<nav class="navbar navbar-expand-lg transparent-navbar">
		<a class="navbar-brand" href="#"> <img
			src="${pageContext.request.contextPath}/static/img/logo_home.png" alt="Logo" class="logo-img">
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
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/list"><button
							class="btn btn-outline-success">
							&nbsp; <span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;<span
								class="badge badge-light"></span>
						</button></a></li>
				<li class="nav-item"><a class="nav-link" href="#"><button
							class="btn btn-outline-success" type="button" id="comment1">
							&nbsp; <span class="glyphicon glyphicon-comment"></span>&nbsp;&nbsp;<span
								class="badge badge-light"></span>
						</button></a></li>
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath }/letter/list"><button
							class="btn btn-outline-success">
							&nbsp; <span class="glyphicon glyphicon-envelope"></span>&nbsp;&nbsp;<span
								class="badge badge-light"></span>
						</button></a></li>
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath }/logout"><button
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
		style="background-color: rgba(240, 255, 255, 0.8);"></div>

	<div class="container">
		<div class="row">
			<div class="col-lg-4" style="margin-top: 7px">
				<div class="row">
					<div class="row m-auto bg"
						style="width:380px;height:110px;background: url('<%=basePath%>static/img/background.jpg')">
						<img class="headPicture"
							src="${pageContext.request.contextPath}/static/img/${USER_SESSION.daily_picture}" />
					</div>

					<div class="container-fluid bordeShadow">
						<div class="row" style="margin-top: 20px; margin-bottom: 20px">
							<div class="col-lg-4 m-auto hand" onclick="mylist()">
								<div class="row m-auto">
									<span>日志</span>
								</div>
								<span class="text-center">${dailyCount }</span>
							</div>

							<div class="col-lg-4 m-auto hand" onclick="dailyfriend()">
								<div class="row m-auto">好友</div>
								<span class="text-center">${friendCount}</span>
							</div>
							<div class="col-lg-4 m-auto hand">
								<div class="row m-auto">访问记录</div>
								<span class="text-center">3</span>
							</div>
						</div>
					</div>

				</div>
			</div>


			<div class="col-lg-8" style="margin-top: 7px;">

				<c:forEach items="${dailyList}" var="daily">
					<div class="message themeColor rounded-top"
						style="background-color: rgba(128, 128, 128, 0.5);">
						<div class="row">
							<div class="col-lg-1">
								<img class="middleHeadPicture"
									src="<%=basePath %>static/img/${daily.daily_picture}" />
							</div>
							<div class="col-lg-11">
								<span class="author"> <strong>${daily.daily_author}</strong>
								</span>
								<div class="logContext">
									<pre class="text-primary">${daily.daily_details}</pre>
								</div>
							</div>
						</div>

					</div>
				</c:forEach>

				<c:forEach items="${myList}" var="mydaily">
					<div class="message themeColor rounded-top"
						style="background-color: rgba(128, 128, 128, 0.5);">
						<div class="row">
							<div class="col-lg-1">
								<img class="middleHeadPicture"
									src="<%=basePath %>static/img/${mydaily.daily_picture}" />
							</div>
							<div class="col-lg-11">
								<div style="clear: both">
									<div style="width: 84px; float: left">
										<span class="author"> <strong>${mydaily.daily_author}</strong>
										</span>
									</div>
									<div style="margin-left: 610px">
										<div class="btn-group">
											<button type="button"
												class="btn btn-default dropdown-toggle dropdown-toggle-split"
												data-toggle="dropdown"></button>
											<div class="dropdown-menu">
												<a class="dropdown-item"
													href="<%=basePath %>mylist/${mydaily.daily_id}/delete.action">删除</a>
											</div>
										</div>
									</div>
								</div>
								<div class="logContext">
									<pre class="text-primary">${mydaily.daily_details}</pre>
								</div>
							</div>
						</div>
					</div>

					<div class="row themeColor commentBody rounded-bottom"
						style="background-color: rgba(128, 128, 128, 0.5)"
						id="bc${daily.daily_id}">
						<c:forEach items="${mydaily.comments}" var="comment">
							<div class="commentDiv">
								<span class="user hand">${comment.user_name}&nbsp;&nbsp;:&nbsp;&nbsp;</span>
								<span class="comment hand">${comment.com_detail}</span>
							</div>
						</c:forEach>
					</div>

				</c:forEach>

			</div>
		</div>
	</div>


	<script>
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
              
              function dailyfriend(){
					window.location.href = "<%=basePath %>dailyFriend";
				}
              function mylist(){
  				window.location.href = "<%=basePath %>mylist";
  			}
              
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
	            	console.log(friend_id);
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
	            
	      		function mycheck(){
	    		    var tag = $("#tag").val();
	    		    if(tag == ""){
	    		    	alert("请输入搜索内容！");
	    		        return false;
	    		    }
	    		    return true;
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