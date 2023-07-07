package com.yyy.entity;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

//日志
public class Daily implements Serializable {
	private static final long serialVersionUID = 1L;

	private Integer daily_id; // 日记的唯一标识符，使用自动生成的主键
	private String daily_details; // 日记的内容
	private String daily_author; // 日记作者的名称
	private Date daily_createtime; // 日记创建时间
	private Integer user_id; // 日记作者的用户ID
	private String daily_picture; // 日记的配图
	private String privacy; // 日记的访问权限
	private List<Comment> comments; // 日记下的评论列表
	private List<Like> likes; // 日记下的评论列表
	private Integer likeCount; // 日记的点赞数

	public Integer getDaily_id() {
		return daily_id;
	}

	public void setDaily_id(Integer daily_id) {
		this.daily_id = daily_id;
	}

	public String getDaily_details() {
		return daily_details;
	}

	public void setDaily_details(String daily_details) {
		this.daily_details = daily_details;
	}

	public String getDaily_author() {
		return daily_author;
	}

	public void setDaily_author(String daily_author) {
		this.daily_author = daily_author;
	}

	public Date getDaily_createtime() {
		return daily_createtime;
	}

	public void setDaily_createtime(Date daily_createtime) {
		this.daily_createtime = daily_createtime;
	}

	public String getDaily_picture() {
		return daily_picture;
	}

	public void setDaily_picture(String daily_picture) {
		this.daily_picture = daily_picture;
	}

	public Integer getUser_id() {
		return user_id;
	}

	public void setUser_id(Integer user_id) {
		this.user_id = user_id;
	}

	public String getPrivacy() {
		return privacy;
	}

	public void setPrivacy(String privacy) {
		this.privacy = privacy;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public List<Like> getLikes() {
		return likes;
	}

	public void setLikes(List<Like> likes) {
		this.likes = likes;
	}

	public Integer getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

}
