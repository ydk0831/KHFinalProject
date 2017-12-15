package com.kh.fitnessground.gym.controller;

import java.io.File;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.swing.plaf.synth.SynthSeparatorUI;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kh.fitnessground.common.util.GymFileUtils;
import com.kh.fitnessground.community.model.vo.MeetingBoard;
import com.kh.fitnessground.gym.model.service.GymService;
import com.kh.fitnessground.gym.model.vo.Gym;
import com.kh.fitnessground.gym.model.vo.GymSchedule;
import com.kh.fitnessground.gym.model.vo.PublicGym;

import oracle.sql.DATE;



@Controller
public class GymController {
	@Autowired
	private GymService gymService;
	@Autowired
	private GymFileUtils gymfileutils;
	
	// 헬스장 이미지 등록
	@RequestMapping(value="/imagereg.do", method=RequestMethod.POST)
	public ModelAndView multiImageUpload(Gym gym, Map<String, Object> map, HttpServletRequest request, HttpServletResponse response) throws Exception{		
		List<Map<String, Object>> list = gymfileutils.parseInsertFileInfo(request);
		String originalFileName = "";
		String renameFileName = "";
		
		for(int i = 0; i < list.size(); i++) {
			originalFileName += list.get(i).get("original_fileName")+",";
			renameFileName += list.get(i).get("rename_fileName")+",";
		}
		if(originalFileName != "" || !originalFileName.equals("")) {
			gym.setOriginal_image(originalFileName);
			gym.setRename_image(renameFileName);
		}
		gymService.RegisterGymImage(gym);
		
		ModelAndView mv = new ModelAndView();
		Gym g = gymService.selectfromImg(gym);
		mv.addObject("gym", g);
		mv.setViewName("jsonView");
		return mv;
	}
	
	//헬스장 내용 등록
	@RequestMapping(value="/contentreg.do", method=RequestMethod.POST)
	public void registerGym(Gym gym, HttpServletRequest request, HttpServletResponse response) {
		gymService.RegisterGymContent(gym);
	}
	
	//헬스장 일정 등록
	@RequestMapping(value="/OneSchedule.do", method=RequestMethod.POST)
	public void OneSchedule(HttpServletRequest request, HttpServletResponse response) throws ParseException {
		GymSchedule gs = new GymSchedule();
		java.util.Date utilDate = new java.util.Date();
		
		gs.setGym_no(Integer.parseInt(request.getParameter("gym_no")));
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		utilDate = sdf.parse(request.getParameter("day"));
		java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
		gs.setDay(sqlDate);
		
		gs.setSchedule_time(request.getParameter("schedule_time"));
		gs.setTitle(request.getParameter("title"));
		gymService.OneSchedule(gs);
	}
	
	//등록한 헬스장 갯수 및 리스트
	@RequestMapping(value="/mygymlist.do", method=RequestMethod.POST)
	public ModelAndView mygymlist(Gym gym, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		int gymcount = gymService.regCount(gym);
		ArrayList<Gym> list = gymService.mygymlist(gym);
		mv.addObject("gymcount", gymcount);
		mv.addObject("list", list);
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 검색한 헬스장 갯수 및 리스트
	@RequestMapping(value="/gymsearch.do", method=RequestMethod.POST)
	public ModelAndView gymSearch(Gym gym, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		int gymcount = gymService.regCountName(gym);
		ArrayList<Gym> list = gymService.mygymlistName(gym);
		mv.addObject("gymcount", gymcount);
		mv.addObject("list", list);
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 헬스장 수정
	@RequestMapping(value="/updategym.do")
	public ModelAndView updateGym(Gym gym, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		System.out.println("헬스장 업데이트" + gym);
		return mv;
	}
	
	// 헬스장 삭제
	@RequestMapping(value="/deletegym.do", method=RequestMethod.POST)
	public ModelAndView deleteGym(Gym gym, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		System.out.println(gym);
		gymService.deleteGym(gym);
		mv.addObject("gym", 1);
		mv.setViewName("jsonView");
		return mv;
	}
	
	// 헬스장 디테일 뷰
	@RequestMapping(value="/detailgym.do")
	public ModelAndView detailGym(Gym gym, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView("gym/detailgym");
		Gym g = gymService.selectOne(gym);
		mv.addObject("gym", g);
		return mv;
	}
	
	// gymreview
	@RequestMapping(value="reviewwindow.do")
	public ModelAndView reviewWindow() // 리뷰 등록 화면 호출
	{
		ModelAndView mv = new ModelAndView();
		
		return mv;
	}
	
	@RequestMapping(value="enrollreview.do")
	public ModelAndView enrollReview() // 리뷰 등록
	{
		ModelAndView mv = new ModelAndView();
		
		return mv;
	}
	
	@RequestMapping(value="updatereview.do")
	public ModelAndView updateReview()
	{
		ModelAndView mv = new ModelAndView();
		
		return mv;
	}
	
	@RequestMapping(value="deletereviw.do")
	public void deleteReview()
	{
		
	}
	
	// findgym
		@RequestMapping(value = "findgym.do")
		public ModelAndView findGym(HttpServletRequest request, HttpServletResponse response) {
			ModelAndView mv = new ModelAndView("findgym/findgym");
			int currentPage = 1;
			int pcurrentPage = 1;
			
			int limit = 5;
			Map<String, Object> map = new HashMap<String, Object>();
			int listCount = gymService.getListCount(); // 헬스장
			int plistCount = gymService.getPublicListCount(); // 공공시설
					
			ArrayList<Gym> list = gymService.healthList(currentPage, limit);
			ArrayList<PublicGym> plist = gymService.publicList(currentPage, limit);
			
			int maxPage = (int) ((double) listCount / limit + 0.9);
			int pmaxPage = (int) ((double) plistCount/ limit + 0.9);
			
			int startPage = (((int) ((double) currentPage / limit + 0.9)) - 1) * limit + 1;
			int pstartPage = (((int) ((double) pcurrentPage / limit + 0.9)) - 1) * limit + 1;
			
			int endPage = startPage + limit - 1;
			int pendPage = pstartPage + limit - 1;

			if (maxPage < endPage)
				endPage = maxPage;
			
			if(pmaxPage < pendPage)
				pendPage = pmaxPage;
			
			System.out.println("listCount = " + listCount);
			System.out.println(list);
			map.put("currentPage", currentPage);
			map.put("pcurrentPage", pcurrentPage);
			map.put("listCount", listCount);
			map.put("plistCount", plistCount);
			map.put("maxPage", maxPage);
			map.put("pmaxPage", pmaxPage);
			map.put("startPage", startPage);
			map.put("pstartPage", pstartPage);
			map.put("endPage", endPage);
			map.put("pendPage", pendPage);
			map.put("limit", limit);
			map.put("list", list);
			map.put("plist", plist);
			
			mv.addObject("gympage",map);
			
			return mv;
		}

		@SuppressWarnings("unchecked")
		@RequestMapping(value = "findhealth.do")
		@ResponseBody
		public ModelAndView findHealth(ModelAndView mv, @RequestParam("page") int page) {

			int currentPage = page;
			int limit = 5;
			Map<String, Object> map = new HashMap<String, Object>();

			int listCount = gymService.getListCount();
			ArrayList<Gym> list = gymService.healthList(currentPage, limit);

			int maxPage = (int)((double) listCount / limit + 0.9);

			int startPage = (((int)((double) currentPage / limit + 0.9)) - 1) * limit + 1;

			int endPage = startPage + limit - 1;

			if (maxPage < endPage)
				endPage = maxPage;
			
			System.out.println("listCount = " + listCount);
			System.out.println("maxPage =" + maxPage);
			System.out.println("startPage = " + startPage);
			System.out.println("endPage = " + endPage);
			System.out.println(list);

			map.put("currentPage", currentPage);
			map.put("listCount", listCount);
			map.put("maxPage", maxPage);
			map.put("startPage", startPage);
			map.put("endPage", endPage);
			map.put("limit", limit);

			JSONObject sendjson = new JSONObject(); // 전송용 최종 객체
			JSONArray jar = new JSONArray();

			for (Gym gym : list) {
				JSONObject jgym = new JSONObject();
				jgym.put("gym_name", gym.getGym_name());
				jgym.put("location", gym.getLocation());
				jgym.put("rename_image", gym.getRename_image());

				jar.add(jgym);
			}

			map.put("gymlist", jar);

			mv.addAllObjects(map);

			mv.setViewName("jsonView");

			return mv;

		}
		
		@RequestMapping(value="findpublic.do")
		@ResponseBody
		public ModelAndView findPublic(ModelAndView mv, @RequestParam("ppage") int page)
		{
			int currentPage = page;
			
			int limit = 5;
			Map<String, Object> map = new HashMap<String, Object>();

			int listCount = gymService.getPublicListCount();
			ArrayList<PublicGym> list = gymService.publicList(currentPage, limit);

			int maxPage = (int)((double) listCount / limit + 0.9);

			int startPage = (((int)((double) currentPage / limit + 0.9)) - 1) * limit + 1;

			int endPage = startPage + limit - 1;

			if (maxPage < endPage)
				endPage = maxPage;
			
			System.out.println("listCount = " + listCount);
			System.out.println("maxPage =" + maxPage);
			System.out.println("startPage = " + startPage);
			System.out.println("endPage = " + endPage);
			System.out.println(list);

			map.put("pcurrentPage", currentPage);
			map.put("plistCount", listCount);
			map.put("pmaxPage", maxPage);
			map.put("pstartPage", startPage);
			map.put("pendPage", endPage);
			map.put("plimit", limit);

			JSONObject sendjson = new JSONObject(); // 전송용 최종 객체
			JSONArray jar = new JSONArray();

			for (PublicGym publicgym : list) {
				JSONObject jpgym = new JSONObject();
				jpgym.put("public_name", publicgym.getPublic_name());
				jpgym.put("location", publicgym.getLocation());
				jpgym.put("homepage", publicgym.getHomepage());

				jar.add(jpgym);
			}

			map.put("publiclist", jar);

			mv.addAllObjects(map);

			mv.setViewName("jsonView");
			return mv;
		}
}
