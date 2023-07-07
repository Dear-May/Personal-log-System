package com.yyy.entity;

import java.io.Serializable;//用于标记实现了它的类可以被对象序列化和反序列化。对象序列化可以将Java中的对象转换为字节流，以便在网络上传输或将其保存到磁盘上。而反序列化则将字节流还原为Java对象

//评论
public class Like implements Serializable {
	private static final long serialVersionUID = 1L;

	private Integer id; // 点赞的唯一标识符，使用自动生成的主键
	private Integer daily_id; // 被点赞的日记的 ID
	private Integer author_id; // 作者ID
	private Integer user_id; // 评论者的用户 ID
	private String user_name; // 点赞者的ID

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getDaily_id() {
		return daily_id;
	}

	public void setDaily_id(Integer daily_id) {
		this.daily_id = daily_id;
	}

	public Integer getAuthor_id() {
		return author_id;
	}

	public void setAuthor_id(Integer author_id) {
		this.author_id = author_id;
	}

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

}
