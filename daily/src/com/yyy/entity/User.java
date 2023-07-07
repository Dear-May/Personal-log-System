package com.yyy.entity;
import java.io.Serializable;

//用户
public class User implements Serializable{
	private static final long serialVersionUID = 1L;

	private int user_id;   //用户id 
	private String user_code;   //用户账号
	private String user_name;   //用户名称
	private String user_password;   //用户密码
	private String daily_picture;   //用户头像
    private String profile;   //个人简介
    private String tel;
    private String token;		//用户登录TOKEN，用于COOKIE登录
	
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}
	
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	
	public String getUser_code() {
		return user_code;
	}
	public void setUser_code(String user_code) {
		this.user_code = user_code;
	}
	
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	
	public String getUser_password() {
		return user_password;
	}
	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}
	
	public String getDaily_picture() {
	    return daily_picture;
	}
	public void setDaily_picture(String daily_picture) {
	    this.daily_picture = daily_picture;
	}
	
	public String getProfile() {
		return profile;
	}
	public void setProfile(String profile) {
		this.profile = profile;
	}
	
	public String getToken() {
		return token;
	}
	public void setToken(String token) {
		this.token = token;
	}
}
