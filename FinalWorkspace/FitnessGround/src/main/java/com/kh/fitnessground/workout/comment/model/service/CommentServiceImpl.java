package com.kh.fitnessground.workout.comment.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.fitnessground.workout.comment.model.dao.CommentDao;
import com.kh.fitnessground.workout.comment.model.vo.Comment;

@Service("commentService")
public class CommentServiceImpl implements CommentService{
	@Autowired
	CommentDao commentDao;

	@Override
	public ArrayList<Comment> selectCommentList(int v_no) {
		
		return commentDao.selectCommentlist(v_no);
	}

	@Override
	public void insertComment(Comment comment) {
		System.out.println("Service Date Type: " + comment.getReply_date());
		System.out.println("Service String Type : " + comment.getStringReplyDate());
		commentDao.insertComment(comment);
		
	}

	@Override
	public void deleteComment(Comment comment) {
		commentDao.deleteComment(comment);		
	}

	

}
