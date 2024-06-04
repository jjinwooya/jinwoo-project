package itwillbs.p2c3.boogimovie.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import itwillbs.p2c3.boogimovie.service.MemberService;
import itwillbs.p2c3.boogimovie.service.MypageService;
import itwillbs.p2c3.boogimovie.service.TheaterService;
import itwillbs.p2c3.boogimovie.vo.EventVO;
import itwillbs.p2c3.boogimovie.vo.FeeAgeVO;
import itwillbs.p2c3.boogimovie.vo.MemberVO;
import itwillbs.p2c3.boogimovie.vo.NoticeVO;
import itwillbs.p2c3.boogimovie.vo.TheaterFacilityVO;
import itwillbs.p2c3.boogimovie.vo.TheaterVO;

@Controller
public class TheaterController {
	
	@Autowired
	private TheaterService service;
	
	
	@Autowired
	private MypageService mypageService;
	
	
	
	
	
	
	@GetMapping("theater")
	public String theater(Model model, TheaterVO theater, MemberVO member, HttpSession session, EventVO event) {
		// 로그인한 경우
		String sId = (String)session.getAttribute("sId");
		
		
		if(sId != null) {
			member.setMember_id(sId);
			Map<String, String> myTheaterMap = service.getMyTheater(member);
			model.addAttribute("myTheater", myTheaterMap);
		}
		
		// 극장 카테고리 공지사항 리스트 조회
		List<NoticeVO> noticeList = service.getNoticeList();
		// 극장 전체 리스트 조회
		List<TheaterVO> theaterList = service.getTheater();
		// 극장 이벤트 조회
		List<EventVO> eventList = service.getTheaterEventList();
		
		
		JsonArray jsonList = new JsonArray();
		
		for(TheaterVO theater1  : theaterList) {
			JsonObject json = new JsonObject();
			json.addProperty("theater_name", theater1.getTheater_name());
			json.addProperty("map_x", theater1.getTheater_map_x());
			json.addProperty("map_y", theater1.getTheater_map_y());
			jsonList.add(json);
			System.out.println(json);
		}
		
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("theaterList", theaterList);
		model.addAttribute("eventList", eventList);
		model.addAttribute("mapTheater", jsonList.toString());
		
		
				
		return "theater/theater_main";
		
	} // theater()
	 
	@GetMapping("theater_detail")
	public String theaterDetail(TheaterVO theater, TheaterFacilityVO facility, NoticeVO notice, MemberVO member, Model model, HttpSession session) {
		
		// 로그인한 경우
		String sId = (String)session.getAttribute("sId");
		if(sId != null) {
			member.setMember_id(sId);
//			member = mypageService.getDbMember(member);
//			model.addAttribute("member", member);
			Map<String, String> myTheaterMap = service.getMyTheater(member);
			model.addAttribute("myTheater", myTheaterMap);
		}
		
		List<TheaterVO> theaterList = service.getTheater();
		theater = service.getTheater(theater);
		List<TheaterFacilityVO> facilityList = service.getFacility(facility);
		List<NoticeVO> theaterNoticeList = service.getTheaterNoticeList(notice);
		List<FeeAgeVO> feeList = service.getFeeList();
		
		Map<String, Integer> feeMap = new HashMap<String, Integer>();
		for(FeeAgeVO fee : feeList) {
			int price = 15000;
			String keyword = "";
			keyword += fee.getFee_dimension_keyword();
			price *= fee.getFee_dimension_discount() / 100.0;
			keyword += fee.getFee_day_keyword();
			price *= fee.getFee_day_discount() / 100.0;
			keyword += fee.getFee_time_keyword();
			price *= fee.getFee_time_discount() / 100.0;
			keyword += fee.getFee_age_keyword();
			price *= fee.getFee_age_discount() / 100.0;
			// 반내림 계산
            price = (int) (Math.floor(price / 500.0) * 500);
			feeMap.put(keyword, price);
			
		}
		
		model.addAttribute("theater", theater);
		model.addAttribute("theaterList", theaterList);
		model.addAttribute("facilityList", facilityList);
		model.addAttribute("theaterNoticeList", theaterNoticeList);
		JSONObject json = new JSONObject(feeMap);
        model.addAttribute("feeMap", json.toString());
		
		
		return "theater/theater_detail";
		
	} // theaterDetail()
	
	
	
	@GetMapping("theater_test")
	public String theaterTest() {
		return "theater/theater_test";
	}
	
	@ResponseBody
	@PostMapping("timetable")
	public String timetable(@RequestParam(defaultValue = "1")int theater_num, String scs_date) {
		
		
		System.out.println("theater_num : " + theater_num);
		System.out.println("scs_date : " + scs_date);
		
		
		List<Map<String, Object>> theaterScsList = service.getTheaterScsList(theater_num, scs_date);
		
		JsonArray jsonScsList = new JsonArray();
		
		for(Map<String, Object> maplist : theaterScsList) {
			
			JsonObject json = new JsonObject();
			json.addProperty("scs_num", (int)maplist.get("scs_num"));
			json.addProperty("scs_empty_seat", (int)maplist.get("scs_empty_seat"));
			json.addProperty("screen_dimension", (String)maplist.get("screen_dimension"));
			String scs_date1 = (Date)maplist.get("scs_date")+"";
			json.addProperty("scs_date", scs_date1);
			json.addProperty("scs_start_time", (String)maplist.get("scs_start_time"));
			json.addProperty("scs_end_time", (String)maplist.get("scs_end_time"));
			json.addProperty("movie_grade", (String)maplist.get("movie_grade"));
			json.addProperty("movie_name", (String)maplist.get("movie_name"));
			json.addProperty("movie_runtime", (String)maplist.get("movie_runtime"));
			json.addProperty("screen_cinema_num", (int)maplist.get("screen_cinema_num"));
			
			String screen_seat_col = (String) maplist.get("screen_seat_col");
			String screen_seat_row = (String) maplist.get("screen_seat_row");

	        // 알파벳을 숫자로 변환하여 seat_size를 계산합니다.
	        int seat_size = getSeatSize(screen_seat_col, screen_seat_row);
	        json.addProperty("seat_size", seat_size);

			jsonScsList.add(json);
			System.out.println("###############" + json);
			
		}
		
		
		return jsonScsList.toString();
		
	} // timetable()
	

	
	
	
	
	// 알파벳을 숫자로 변환하고 row * col (timetable 에서 사용)
	private int getSeatSize(String alphabet, String screen_seat_row) {
	    alphabet = alphabet.toUpperCase();
	    int colToNumber = alphabet.charAt(0) - 'A' + 1;
	    int seat_size = colToNumber * Integer.parseInt(screen_seat_row);
	    
	    return seat_size;
	}
	
	
	
	
} // TheaterController


