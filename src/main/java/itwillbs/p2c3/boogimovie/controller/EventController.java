package itwillbs.p2c3.boogimovie.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import itwillbs.p2c3.boogimovie.service.EventService;
import itwillbs.p2c3.boogimovie.vo.CouponVO;
import itwillbs.p2c3.boogimovie.vo.EventTypeVO;
import itwillbs.p2c3.boogimovie.vo.EventVO;

@Controller
public class EventController {

	@Autowired
	private EventService eventService;
	
	// 이벤트 메인 페이지
		@GetMapping("event")
		public String eventMain(Model model) {
			List<EventVO> eventList = eventService.getEventList();
			List<EventTypeVO> eventTypeList = eventService.getEventTypeList();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			
			for(EventVO event : eventList) {
		        event.setEvent_start(dateFormat.format(event.getEvent_start_date()));
		        event.setEvent_end(dateFormat.format(event.getEvent_end_date()));
		    }
			
			model.addAttribute("eventList", eventList);
			model.addAttribute("eventTypeList", eventTypeList);
			return "event/event_main";
		}
		
		// 이벤트 타입 선택에 따른 ajax 처리
		@ResponseBody
		@GetMapping("eventType")
		public List<EventVO> eventType(@RequestParam String eventType) {
			System.out.println("eventType: " + eventType);
			List<EventVO> eventList = eventService.getEventList();
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			
			List<EventVO> movieEventList = new ArrayList<EventVO>();
			List<EventVO> theaterEventList = new ArrayList<EventVO>();
			List<EventVO> discountEventList = new ArrayList<EventVO>();
			
			for(EventVO event : eventList) {
				String formattedStartDate = dateFormat.format(event.getEvent_start_date());
				String formattedEndDate = dateFormat.format(event.getEvent_end_date());
		        event.setEvent_start(formattedStartDate);
		        event.setEvent_end(formattedEndDate);
		        
				if(event.getEvent_type_num() == 1) {
					movieEventList.add(event);
				} else if(event.getEvent_type_num() == 2) {
					theaterEventList.add(event);
				} else if(event.getEvent_type_num() == 3) {
					discountEventList.add(event);
				}
			}
			
			if(eventType.equals("0")) {
//				System.out.println("eventList로 간다 : " + eventList);
				return eventList;
			} else if(eventType.equals("1")) {
//				System.out.println("movieEventList로 간다 : " +movieEventList);
				return movieEventList;
			} else if(eventType.equals("2")) {
//				System.out.println("theaterEventList로 간다 : " + theaterEventList);
				return theaterEventList;
			} else {
//				System.out.println("discountEventList로 간다 : " + discountEventList);
				return discountEventList;
			}
		}
		
	
	// 썸네일 클릭시 
		@GetMapping("eventDetail")
		public String eventDetail(EventVO event, Model model) {
			event = eventService.getEvent(event.getEvent_num());
			model.addAttribute("event", event);
			
			return "event/event_detail";
		}
		
	// 쿠폰 발급
		@GetMapping("giveCoupon")
		public String giveCoupon(CouponVO coupon, HttpSession session, Model model, EventVO event) {
			String id = (String)session.getAttribute("sId");
			
			if(id == null) { // 실패
				model.addAttribute("msg", "잘못된 접근입니다");
				model.addAttribute("targetURL", "member_login");
				return "error/fail";
			} 
			
			// 쿠폰 중복검사
			int isCouponExist = eventService.isCouponExist(id, coupon.getCoupon_type_num());
			
			if(isCouponExist > 0) {
				model.addAttribute("msg", "이미 발급된 쿠폰입니다!");
				return "error/fail";
			} else {
				// 이벤트 삽입
				int insertCount = eventService.insertCoupon(id, coupon.getCoupon_type_num());

				if(insertCount > 0) {
					model.addAttribute("msg", "쿠폰이 발급되었습니다");
					model.addAttribute("targerURL", "redirect:/eventDetail?event_num=" + event.getEvent_num());
					return "error/fail";
				} else {
					model.addAttribute("msg", "쿠폰등록 오류!");
					return "error/fail";
				}
			}
			
			
			
		}
}
