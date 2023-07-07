package com.yyy.dao;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.yyy.entity.User;

public interface UserDao {

	public User findUser(@Param("usercode") String usercode,@Param("password") String password);   //查询指定用户账号和密码是否匹配
	
	public User findUserByToken(@Param("usercode") String usercode,@Param("token") String token);   //通过用户名和token登录(查询指定用户账号和TOKEN是否匹配)
	
	public String findUserPicture(Integer user_id);   //查询指定用户 ID 的头像地址
	
	public String findUserName(Integer user_id);   //查询指定用户 ID 的用户名
	
	public User findByUsercode(String usercode);	//通过用户 ID 找用户
	
	public List<User> findByUserName_tag(String username);	//通过用户名找用户(模糊查找)    //CST21030(2023/7/2)
	
	public int addUser(@Param("usercode")String usercode,@Param("username") String username,@Param("password") String password,@Param("tel") String tel);   //新添加了一个用户
	
	public int changeUserPassword(@Param("usercode") String usercode,@Param("password") String password);	//修改密码  		//CST21030(2023/7/2)：好好取名
	
	public int updateToken(@Param("usercode") String usercode,@Param("token") String token);	//更新token
	
	public int updateUserPicture(@Param("usercode") String usercode,@Param("pictureName") String pictureName);	//更新头像
	
	public int updateUserName(@Param("usercode") String usercode,@Param("newNickname")String newNickname);	//更新昵称
	
}
