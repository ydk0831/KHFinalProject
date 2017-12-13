package com.kh.fitnessground.workout.health.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.kh.fitnessground.workout.commentlike.vo.Comment;
import com.kh.fitnessground.workout.commentlike.vo.Like;
import com.kh.fitnessground.workout.health.model.service.HealthService;
import com.kh.fitnessground.workout.health.model.vo.Health;

@Controller
public class HealthController {
	@Autowired
	private HealthService healthService;
	
	@RequestMapping(value="/healthMain.do")	//메인 페이지 이동
	public ModelAndView boardListMethod(HttpServletRequest request, HttpServletResponse response){
		
		ModelAndView mv = new ModelAndView("workout/healthMain");
		
		return mv;
	}
	
	//헬스
	@RequestMapping(value="/part.do")	//부위별 카테고리 ajax 통신 들어오는 카테고리에 따라서 리스트 뿌리기
	public void selectCategorytListMethod(Health health,HttpServletResponse response) throws IOException{
		
				
		ArrayList<Health> list = healthService.selectWorkoutCategoryList(health);
				
				
		JSONObject sendJson = new JSONObject();
		JSONArray jarr = new JSONArray();
		
		for(Health h : list){
			JSONObject jhealth = new JSONObject();
			jhealth.put("v_no", h.getV_no());
			jhealth.put("title", URLEncoder.encode(h.getTitle(),"utf-8"));
			jhealth.put("content", URLEncoder.encode(h.getContent(),"utf-8"));
			jhealth.put("category1", URLEncoder.encode(h.getCategory1(),"utf-8"));
			jhealth.put("category2", URLEncoder.encode(h.getCategory2(),"utf-8"));
			jhealth.put("url", URLEncoder.encode(h.getUrl(),"utf-8"));
			jhealth.put("readcount", h.getReadcount());
			
			jarr.add(jhealth);
		}
		
		sendJson.put("list", jarr);
		
		response.setContentType("aplication/json; charset=utf-8"); 
		PrintWriter out = response.getWriter();
		out.println(sendJson.toJSONString());
		out.flush();
		out.close();
	
	}
	
	@RequestMapping(value="/detail.do")	//썸네일 누르면 누른 v_no로 모달창에서 동영상 재생.. 썸네일은 어케하지..
	public ModelAndView workOutDetail(Health health, HttpServletResponse response){
		//v_no를 파라미터로 보내면 v_no에 따른 health 객체 v_no 만
		int v_no = health.getV_no();
		
		ModelAndView mv = new ModelAndView("workout/detailView");	//모달 jsp 페이지로
		
		healthService.addReadCount(health.getV_no());	//조회수 증가
		
		Health detailHealth = healthService.selectOneWorkout(v_no);
		
		mv.addObject("health",detailHealth);
		mv.setViewName("jsonView");
		
		return mv;
	}	
	//기본 메인페이지 네이버 동영상 끝
	
		
		
	//관리자 youtube 에서 플레이리스트 동영상
	
	
	
	//다양한 헬스운동 페이지 이동 
	
	@RequestMapping(value="/youtubePlaylistView.do")
	public String playListView(){
		return "/workout/playlistview";
	}
	
	@RequestMapping(value="/playListinsert.do")	//input 태그에 playlist 값 입력 하면 db에 데이터를 넣어야됨..	//미향 부분 view 페이지 보고 참조...
	public ModelAndView HealthInsertMethod(ArrayList<Health> healthList,HttpServletRequest request){
		//insert 작업 해야됨
		
		ModelAndView mv = new ModelAndView("/workout/healthPlaylist");
		
		return mv;
	}
	@RequestMapping(value="/updateview.do") //수정하는 뷰로 이동하는 메서드
	public ModelAndView healthUpdateViewMethod(HttpServletRequest request){
		ModelAndView mv = new ModelAndView("/workout/videoUpdateView");
		Health health = healthService.selectOneWorkout(Integer.parseInt(request.getParameter("v_no")));
		mv.addObject("health",health);
		
		return mv;
	}
	
	@RequestMapping(value="/healthupdate.do") //관리자 영상 내용 수정
	public ModelAndView healthUpdateMethod(Health health){
		String category1 = health.getCategory1();
		ModelAndView mv = new ModelAndView("/workout/healthPlaylist");
		healthService.updateHealth(health.getV_no());
		ArrayList<Health> list = healthService.selectAllList(category1);
		mv.addObject("list",list);
		return mv;
	}
	
	@RequestMapping(value="/hdelete.do") //관리자 한개 영상 삭제
	public ModelAndView healthDeleteMethod(Health health){
		String category1 = health.getCategory1();
		ModelAndView mv = new ModelAndView("/workout/healthPlaylist");
		healthService.deleteHealth(health.getV_no());
		ArrayList<Health> list = healthService.selectAllList(category1);
		mv.addObject("list",list);
		return mv;
		
	}
	
	@RequestMapping(value="/listdelete.do")	//관리자 영상 복수 삭제
	public ModelAndView healthListDeleteMethod(ArrayList<Health> dellist,Health health){
		String category1 = health.getCategory1();
		ModelAndView mv = new ModelAndView("/workout/healthPlaylist");
		healthService.deleteHealthList(dellist);
		ArrayList<Health> list = healthService.selectAllList(category1);
		mv.addObject("list",list);
		
		return mv;
	}
	
	//헬스 끝
	
	//주변 헬스장 검색 페이지 이동
	@RequestMapping(value="aroundFitenessCenter.do")
	public String aroundFitnessMethod(){
		return "";
	}
	
	//맨몸운동... 다양한 헬스 운동 하고 나서 .. 생각.. 필요한 메서드들은 다양한 헬스운동과 같음
	
		
	//댓글 
	@RequestMapping(value="/selectComment.do")
	public ModelAndView selectCommentList(Comment comment){
			
		ModelAndView mv = new ModelAndView("workout/detailView");
	
		ArrayList<Comment> list = healthService.selectCommentList(comment.getV_no());
		
		mv.addObject("commentList",list);
		mv.setViewName("jsonView");
			
		return mv;
	}
	
	//댓글 insert 날짜 데이터..
	@RequestMapping(value="/insertReply.do",method=RequestMethod.POST)
	public void insertComment(Comment comment){
		//db엔 날짜 들어감 insert 할때 Date 타입 sysdate로 insert
		//select 할때 to_char()로 문자열로 가져옴
		System.out.println("가져온 날짜 : " + comment.getReply_date()); //null
			
		//datebase 엔 insert 가 되는데 mapper 을 사용해서 자동 매칭이 안됨
		//resultMap 새로 만들어보기..

			
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd, hh:mm:ss a");
					
		healthService.insertComment(comment);
	}
		
	
	//댓글 삭제
	@RequestMapping(value="/deleteReply.do",method=RequestMethod.POST)
	public void deleteComment(Comment comment){
		healthService.deleteComment(comment);
	}
	
	//좋아요
	@RequestMapping(value="/likeUp.do",method=RequestMethod.POST)
	public void updateLike(Like like){
		System.out.println("like : " + like);
		//좋아요 테이블 리스트를 불러오기
		ArrayList<Like> list = healthService.selectLikeList();
		
		int result = healthService.checkLikeTable(like); //좋아요 테이블에 있는지 확인하는 변수
		// 있으면 1 없으면 0
		System.out.println(result);
		
		if(result==1){	//있으면
			//좋아요 취소
			
		}else{ //없으면
			//좋아요 누르기
		}
		
		
	}
		
	
	
}
