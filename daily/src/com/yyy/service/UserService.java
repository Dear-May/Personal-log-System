package com.yyy.service;
import java.util.List;

import com.yyy.entity.User;

public interface UserService {
	
	public User findUser(String usercode,String password);
	
	public String findUserName(Integer user_id);
	
	public String findUserPicture(Integer user_id);
	
	public User findByUsercode(String usercode);
	
	public List<User> findByUserName_tag(String username);
	
	public int addUser(String usercode,String username,String password,String tel);
	
	public int changeUserPassword(String usercode,String password);
	
	public int updateToken(String usercode,String token);
	
	public User findUserByToken(String usercode,String token);	//CST21030(2023/7/1)添加
	
	public int updateUserPicture(String usercode, String pictureName);	//CST21030(2023/7/3)添加
	
	public int updateUserName(String usercode, String newNickname);
	
}
