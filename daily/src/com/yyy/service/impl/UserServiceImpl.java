package com.yyy.service.impl;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.yyy.dao.UserDao;
import com.yyy.entity.User;
import com.yyy.service.UserService;

@Service("userService")
@Transactional

public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserDao userDao;
	
	@Override
	public User findUser(String usercode, String password) {
		User user = this.userDao.findUser(usercode, password);
		return user;
	}
	
	@Override
	public String findUserName(Integer user_id) {
	    String user = this.userDao.findUserName(user_id);
	    return user;
	}
	
	@Override
	public String findUserPicture(Integer user_id) {
	    String user = this.userDao.findUserPicture(user_id);
	    return user;
	}
	
	@Override
	public User findByUsercode(String usercode) {
		User user=this.userDao.findByUsercode(usercode);
		return user;
	}
	
	@Override
	public List<User> findByUserName_tag(String username) {
		username = "%"+username+"%";
		List<User> user=this.userDao.findByUserName_tag(username);
		return user;
	}
	@Override
	public int addUser(String usercode,String username,String password,String tel) {
	    return userDao.addUser(usercode,username,password,tel);
	}
	
	@Override
	public int changeUserPassword(String usercode,String password) {
	    return userDao.changeUserPassword(usercode,password);
	}
	
	@Override
	public int updateToken(String usercode,String token) {
	    return userDao.updateToken(usercode,token);
	}
	
	public User findUserByToken(String usercode,String token) {
		return userDao.findUserByToken(usercode,token);
	}
	
	public int updateUserPicture(String usercode, String pictureName) {
		return userDao.updateUserPicture(usercode,pictureName);
	}

	@Override
	public int updateUserName(String usercode, String newNickname) {
		return userDao.updateUserName(usercode, newNickname);
	}
	
}
