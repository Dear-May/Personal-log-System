package com.yyy.interceptor;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.yyy.entity.User;
import com.yyy.service.UserService;

//登录拦截器
public class LoginInterceptor implements HandlerInterceptor {
	
	@Autowired
	private UserService userService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		String path = request.getContextPath();
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("USER_SESSION");
		if (user != null) {
			return true;
		}
		else {
			String code = null;
			String token = null;	//cookie中需要存储token而非密码
			Cookie[] cookies = request.getCookies();
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					if ("USER_CODE".equals(cookie.getName())) {
						code = cookie.getValue();
					}
					else if ("USER_PAW".equals(cookie.getName())) {
						token = cookie.getValue();
					}
				}

				//如果出现cookie不全的情况，则直接要求登录
				if (code == null || token == null) {
					response.sendRedirect(path + "/login");
					return false;
				}
				//通过已有的数据寻找对应用户
				User user1 = userService.findUserByToken(code, token);

				//找不到该用户
				if (user1 == null) {
					response.sendRedirect(path + "/login");
					return false;
				}

				//用户数据正确，放行
				session.setAttribute("USER_SESSION", user1);
				return true;
			}
			else {
				//request.setAttribute("msg", "您还没有登录，请先登录！");
				response.sendRedirect(path + "/login");
				return false;
			}
		}
	}
	
	@Override
	public void postHandle(HttpServletRequest request, 
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}
	
	@Override
	public void afterCompletion(HttpServletRequest request, 
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}
	
	/*
	 * CST21030 (2023/7/2)：这个函数没有被引用，是否真的需要   CST21045:不需要请删去
	 */
    // 判断请求是否为Ajax请求
    private boolean isAjaxRequest(HttpServletRequest request) {
        String requestedWithHeader = request.getHeader("X-Requested-With");
        return "XMLHttpRequest".equals(requestedWithHeader);
    }
}
