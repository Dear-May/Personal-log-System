<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="itheima" uri="http://itheima.com/common/"%>
<%
// 检查会话是否存在
boolean islogin=true;
if (session.getAttribute("USER_SESSION") != null) {
} else {
    // 会话不存在
    islogin=false;
}
%>
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
<title>出错了</title>

<style>
body {
	text-align: center; /* 水平居中 */
	justify-content: center; /* 水平居中 */
	align-items: center; /* 垂直居中 */
	font-family: "楷体", KaiTi, cursive; /* 楷体字体 */
	background-repeat: no-repeat;
	background-size: cover;
	background-position: center center;
	display: block;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}

.logo {
	margin: 0 auto; /* 水平居中 */
	width: 200px; /* 调整图片的大小 */
}

p {
	font-size: 35px; /* 字号变大 */
}
</style>

<script>
        // 定义倒计时函数
        function countdown() {
            var count = 5; // 倒计时秒数
            var countdownElement = document.getElementById("countdown");

            // 更新倒计时显示
            function updateCountdown() {
                countdownElement.innerText = count + "秒后返回页面";
                count--;

                // 倒计时结束后跳转页面
                if (count < 0) {
                    // 检查是否登录并跳转页面
                    var isLogin = <%= islogin %>;
                    if (isLogin) {
                        // 返回上一个页面
                        history.back();
                    } else {
                        window.location.href = "<%=basePath %>login";
                    }
                } else {
                    // 继续倒计时
                    setTimeout(updateCountdown, 1000);
                }
            }

            updateCountdown();
        }
    </script>
</head>
<body onload="countdown()">
	<img class="logo" src="${pageContext.request.contextPath}/static/img/logo.png" />
	<br>
	<p>出错了！！！！！</p>
	<br>
	<p id="countdown"></p>
</body>

<script>

    // 获取当前时间
    var now = new Date();
    var hour = now.getHours();
  
    // 根据时间设置不同的壁纸
    if (hour >= 6 && hour < 12) {
        document.body.style.backgroundImage = "url('${pageContext.request.contextPath}/static/img/morning_wallpaper.jpg')";
    } else if (hour >= 12 && hour < 18) {
        document.body.style.backgroundImage = "url('${pageContext.request.contextPath}/static/img/afternoon_wallpaper.jpg')";
    } else {
        document.body.style.backgroundImage = "url('${pageContext.request.contextPath}/static/img/evening_wallpaper.jpg')";
    }
</script>
</html>