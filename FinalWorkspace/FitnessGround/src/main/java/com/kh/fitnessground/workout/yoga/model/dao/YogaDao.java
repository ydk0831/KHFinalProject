package com.kh.fitnessground.workout.yoga.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.fitnessground.workout.yoga.model.vo.Yoga;

@Repository("yogaDao")
public class YogaDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public ArrayList<Yoga> selectAllYList() {
		List<Yoga> ylist = sqlSession.selectList("yoga.selectAllYList");
		ArrayList<Yoga> list = new ArrayList<Yoga>(ylist);
		return list;
	}
	
	public ArrayList<Yoga> selectAllPList() {
		List<Yoga> ylist = sqlSession.selectList("yoga.selectAllPList");
		ArrayList<Yoga> list = new ArrayList<Yoga>(ylist);
		return list;
	}

	public ArrayList<Yoga> selectCList(Yoga yoga) {
		List<Yoga> ylist = sqlSession.selectList("yoga.selectCList", yoga);
		return new ArrayList<Yoga>(ylist);
	}

	public Yoga selectYoga(int no) {
		return (Yoga)sqlSession.selectOne("yoga.selectYoga", no);
	}
	public void insertYoga(List<Yoga> ylist) {
		for(Yoga yoga : ylist) {
			sqlSession.insert("yoga.insertYoga", yoga);
		}
	}

	public void updateYoga(Yoga yoga) {
		sqlSession.update("yoga.updateYoga", yoga);
	}

	public void deleteYoga(Yoga yoga) {
		sqlSession.delete("yoga.deleteYoga", yoga);
	}

	public void deleteYogaList(List<Yoga> dellist) {
		sqlSession.delete("yoga.deleteYogaList", dellist);
	}

	public void addReadCount(int v_no) {
		sqlSession.update("yoga.addReadCount", v_no);
	}

	public ArrayList<Yoga> selectAllList() {
		List<Yoga> ylist = sqlSession.selectList("yoga.selectAllList");
		ArrayList<Yoga> list = new ArrayList<Yoga>(ylist);
		return list;
	}

	public ArrayList<Yoga> selectWList(Yoga yoga) {
		List<Yoga> ylist = sqlSession.selectList("yoga.selectWList", yoga);
		return new ArrayList<Yoga>(ylist);
	}

}
