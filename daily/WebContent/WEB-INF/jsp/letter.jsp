<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="itheima" uri="http://itheima.com/common/"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

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
<title>私信</title>

<link href="<%=basePath%>static/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" />
<link href="<%=basePath%>static/vendor/css/style.css" rel="stylesheet" />
<link href="<%=basePath%>static/vendor/css/letter.css" rel="stylesheet" />

<script src="<%=basePath%>static/vendor/js/jquery-3.4.1.min.js"></script>
<script src="<%=basePath%>static/vendor/bootstrap/js/bootstrap.min.js"></script>

<style>
body {
	background-image:
		url("${pageContext.request.contextPath}/static/img/afternoon_home_wallpaper.jpg");
	/* 替换为您的背景图像路径 */
	background-size: cover; /* 背景图像覆盖整个容器 */
	background-repeat: no-repeat; /* 不重复平铺背景图像 */
}

.dark-mode body {
	background-image:
		url('${pageContext.request.contextPath}/static/img/evening_home_wallpaper.jpg');
	background-size: cover; /* 背景图像覆盖整个容器 */
	background-repeat: no-repeat; /* 不重复平铺背景图像 */
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
				<li class="nav-item"><a class="nav-link"
					href="${pageContext.request.contextPath}/daily/list"><button
							class="btn btn-outline-success ">
							&nbsp; <span class="glyphicon glyphicon-home"></span>&nbsp;&nbsp;
						</button></a></li>
				<li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/user/list"><button
							class="btn btn-outline-success">
							&nbsp; <span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;
						</button></a></li>
				<li class="nav-item "><a class="nav-link" href="#"><button
							class="btn btn-outline-success" type="button" id="comment1">
							&nbsp; <span class="glyphicon glyphicon-comment"></span>&nbsp;&nbsp;<span
								class="badge badge-light" id="send_number"></span>
						</button></a></li>
				<li class="nav-item active"><a class="nav-link" href="#"><button
							class="btn btn-outline-success active">
							&nbsp; <span class="glyphicon glyphicon-envelope"></span>&nbsp;&nbsp;
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
				onsubmit="return searchcheck()">
				<input class="form-control mr-sm-2" type="text" name="tag"
					placeholder="搜索一下" id="tag">
				<button class="btn btn-success" type="submit" data-toggle="modal"
					data-target="#search">搜索</button>
			</form>
		</div>
	</nav>

	<div class="container m-auto">
		<div class="row">
			<div class="col-lg-5 left ">
				<div class="mylist themeColor">
					<div class="row">
						<div class="col-lg-4 text-center hand " id="current">消息</div>
						<div class="col-lg-4 text-center hand" id="friend">好友</div>
						<div class="col-lg-4 text-center hand" id="moment">动态</div>
					</div>
					<div class="currentBody" id="currentBody"></div>

					<c:forEach items="${friendList}" var="friend">
						<div class="friendBody" id="friendBody">
							<div class="friend hand animated">
								<div class="friend hand">
									<div class="friend_list">
										<img class="middlePicture "
											src="${pageContext.request.contextPath}/static/img/${friend.friendPicture}" />
									</div>
									<div>
										<a
											href="${pageContext.request.contextPath}/letter/${friend.friend_id }/message">
											<c:if test="${friend.friend_id==sendto}">
												<span class="row text-primary text-success">${friend.friendName}</span>
											</c:if> <c:if test="${friend.friend_id!=sendto}">
												<span class="row text-primary">${friend.friendName}</span>
											</c:if>
										</a>

									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>


			</div>

			<div class="col-lg-6 right">
				<div class="mycontent themeColor" id="contentBody"
					style="border-radius: 20px; background-image: url('${pageContext.request.contextPath}/static/img/message.jpg'); backdrop-filter: blur(5px);">
					<c:forEach items="${messages }" var="message">
						<c:if test="${message.sender!=message.owner_id}">
							<div class="sender">
								<div>
									<img
										src="${pageContext.request.contextPath}/static/img/${friendPicture}">
								</div>
								<div>
									<div class="left_triangle"></div>
									<span> ${message.details } </span>
								</div>
							</div>
						</c:if>
						<c:if test="${message.sender==message.owner_id}">
							<div class="receiver">
								<div>
									<img
										src="${pageContext.request.contextPath}/static/img/${USER_SESSION.daily_picture}">
								</div>
								<div>
									<div class="right_triangle"></div>
									<span> ${message.details } </span>
								</div>
							</div>
						</c:if>
					</c:forEach>
				</div>


				<div class="navbar-fixed-bottom">
					<div class="inputBody">
						<div class="left_input">
							<input type="text" class="form-control" id="details"
								aria-describedby="emailHelp" placeholder="请输入想发送的内容">
						</div>
						<div>
							<button class="btn btn-success"
								onclick="send(${USER_SESSION.user_id},${sendto})">发送</button>
						</div>
					</div>
				</div>
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
            	    $('#commentPopup').hide();
            	});

                // 发送消息函数
                 function send(owner_id,sendto){
            	  var sender = owner_id;
            	  var receiver = sendto;
            	  var details =  $("#details").val();  
            	  if (details == ""){
            		  alert("请输入内容");
            		  return 
            	  }
              	var pattern = /<[a-z][\s\S]*>/i;
            	var containsHtmlTag = pattern.test(details);
            	if (containsHtmlTag) {
            		alert("文本包含HTML标签,不允许发送");
            		return
            		}
            	  var flag = false;
            	  var json = {"sender":sender,"receiver":receiver,"owner_id":owner_id,"details":details,"sendto":sendto};
            	  
            	  $.ajax({
            	        type : "post",
            	        url : "<%=basePath %>/letter/add.action",
            	        contentType : "application/json;charset=utf-8",
            	        dataType : "json",
            	        data: JSON.stringify(json),
            	        success : function(data){
            	            messageShow();
            	        },
            	        error : function(){
            	            alert("请求失败");
            	        }
            	    })
              }
              
              function messageShow(){
            	  window.location.href = "<%=basePath %>letter/${sendto}/message";
              }
              
        	function searchcheck(){
        		var tag = $("#tag").val();
        		if(tag == ""){
        			alert("请输入搜索内容！");
        			return false;
        			}
        		return true;
        		}	            
              
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
        		$("#send_number").html(data.length);
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
        		  })
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
	        	var html = "";
	        	if(data.length!=0)
	        		$("#send_number").html(data.length);
	        	for(i=0;i<data.length;i++){
	        		html += `<div class=""><span class="text-info hand">`+data[i]+`</span></div>`;
	        	}
	        	$("#commentPopup").html(html);
          }       
	            
          // 获取当前时间
          var now = new Date();
          var hour = now.getHours();
         
          // 判断是否晚上10点后
          if (hour >= 22 || hour < 6) {
        	  // 添加暗黑模式的 class
        	  document.body.classList.add('dark-mode');
        	  }
          
          </script>
</body>
</html>