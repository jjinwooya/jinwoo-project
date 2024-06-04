package itwillbs.p2c3.boogimovie.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import itwillbs.p2c3.boogimovie.service.AdminService;
import itwillbs.p2c3.boogimovie.service.EventService;
import itwillbs.p2c3.boogimovie.service.FaqService;
import itwillbs.p2c3.boogimovie.service.NoticeService;
import itwillbs.p2c3.boogimovie.service.OtoService;
import itwillbs.p2c3.boogimovie.service.ScreenService;
import itwillbs.p2c3.boogimovie.service.TheaterService;
import itwillbs.p2c3.boogimovie.service.TicketingService;
import itwillbs.p2c3.boogimovie.vo.CartVO;
import itwillbs.p2c3.boogimovie.vo.CouponVO;
import itwillbs.p2c3.boogimovie.vo.EventVO;
import itwillbs.p2c3.boogimovie.vo.FAQVO;
import itwillbs.p2c3.boogimovie.vo.ItemInfoVO;
import itwillbs.p2c3.boogimovie.vo.MemberVO;
import itwillbs.p2c3.boogimovie.vo.MovieVO;
import itwillbs.p2c3.boogimovie.vo.NoticeVO;
import itwillbs.p2c3.boogimovie.vo.OTOReplyVO;
import itwillbs.p2c3.boogimovie.vo.OTOVO;
import itwillbs.p2c3.boogimovie.vo.PageInfo;
import itwillbs.p2c3.boogimovie.vo.ReviewVO;
import itwillbs.p2c3.boogimovie.vo.ScreenInfoVO;
import itwillbs.p2c3.boogimovie.vo.ScreenSessionVO;
import itwillbs.p2c3.boogimovie.vo.StorePayVO;
import itwillbs.p2c3.boogimovie.vo.TheaterVO;

@Controller
public class AdminController {
	
	@Autowired
	private AdminService service;
	
	@Autowired
	private OtoService otoService;
	
	@Autowired
	private TheaterService theaterService;
	
	@Autowired
	private EventService eventService;
	
	@Autowired
	private TicketingService ticService;
	
	@Autowired
	private ScreenService screenService;
	
	@Autowired
	private FaqService faqService;
	
	@Autowired
	private NoticeService noticeService;
	
	
	@GetMapping("Admin")
	public String goToAdmin(HttpSession session) {
		session.setAttribute("sId", "admin");
		return "redirect:/admin_main";
	}
	
	// admin 메인 연결
	@GetMapping("admin_main")
	public String adminMain(Model model, HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		} 
		
		// 회원 수
		int memberCount = service.countMemberList();
		model.addAttribute("memberCount", memberCount);
		
		// 현재 상영작 수
		int movieCount = service.movieCount();
		model.addAttribute("movieCount", movieCount);
		
		// 금일 상영 영화 수
		int moviePlanCount = service.countMoviePlan();
		model.addAttribute("moviePlanCount", moviePlanCount);
		
		// 금일 예매 수
		int reserveCount = service.countReserve();
		model.addAttribute("reserveCount", reserveCount);
		
		// 극장 리스트 이름 가져오기
		List<Map<String, String>> theaterList = service.getTheaterList();
		model.addAttribute("theaterList", theaterList);
		
		// 월간 매출 가져오기
		List<Map<String, String>> MonthSalesList = service.getMonthSales();
		model.addAttribute("MonthSalesList", MonthSalesList);
		
		return "admin/admin_main/admin_main";
	}
	
	//--------------------------------------------------------------------
	// 관리자 고객센터
	// faq List view에 포워딩
	@GetMapping("admin_faq")
	public String adminFAQ(@RequestParam(defaultValue = "1")int pageNum, Model model, @RequestParam(required = false)String faqCategory) {
		int listLimit = 10;
		int startRow = (pageNum  - 1) * listLimit;
		
		int listCount = faqService.getFaqListCount(faqCategory); //총 공지사항 갯수
		int pageListLimit = 5; //뷰에 표시할 페이지갯수
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0); //카운트 한 게시물 + 1 한 페이지
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1; // 첫번째 페이지 번호
		int endPage = startPage + pageListLimit - 1; //마지막 페이지 번호
		System.out.println("maxPage: " + maxPage);
		if(endPage > maxPage) { // 마지막 페이지가 최대 페이지를 넘어갈때 
			endPage = maxPage;
		}
		PageInfo pageList = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
		List<FAQVO> faqList = faqService.getFaqList(listLimit, startRow, faqCategory);
		
		model.addAttribute("pageList", pageList);
		model.addAttribute("faqList", faqList);
		return "admin/admin_csc/admin_faq";
	}
	
	//faq 삭제
	@GetMapping("admin_faq_delete")
	public String adminFAQdelete(FAQVO faq, Model model) {
		int deleteCount = faqService.deleteFaq(faq);
		
		if(deleteCount == 0) {
			model.addAttribute("msg", "삭제 실패!");
			return "error/fail";
		}
		return "redirect:/admin_faq";
	}
	
	//faq form 이동
	@GetMapping("admin_faq_form")
	public String adminFAQform(@RequestParam(defaultValue = "1")String pageNum, Model model) {
		model.addAttribute("pageNum", pageNum);
		return "admin/admin_csc/admin_faq_form";
	}
	
	//faq 등록(pro) 
	@PostMapping("admin_faq_pro")
	public String adminFAQpro(FAQVO faq, Model model, @RequestParam(defaultValue = "1")String pageNum) {
		if(faq.getFaq_category().equals("")) {
			model.addAttribute("msg", "유형을 선택해 주세요");
			return "error/fail";
		}
		
		int insertCount = faqService.insertFaq(faq);
		
		if(insertCount == 0) {
			model.addAttribute("msg", "faq 등록 실패");
			return "error/fail";
		}
		model.addAttribute("pageNum", pageNum);
		return "redirect:/admin_faq";
	}
	
	//faq modify form 이동
	@GetMapping("admin_faq_modify")
	public String adminFAQModify(FAQVO faq, Model model, @RequestParam(defaultValue = "1")String pageNum) {
		faq = faqService.getFaq(faq);
		
		if(faq == null) {
			model.addAttribute("msg", "조회되는 게시물이 없습니다.");
			return "error/fail";
		}
		
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("faq", faq);
		return "admin/admin_csc/admin_faq_modify";
	}
	
	//faq update
	@PostMapping("admin_faq_modify")
	public String adminFAQModifyPro(FAQVO faq, Model model, @RequestParam(defaultValue = "1")String pageNum) {
		int updateCount = faqService.updateFaq(faq);
		
		if(updateCount == 0) {
			model.addAttribute("msg", "수정을 실패하였습니다");
		}
		model.addAttribute("pageNum", pageNum);
		return "redirect:/admin_faq";
	}
	
	//-------------------------------------
	//공지사항 관리 controller
	//listLimit으로 목록 10개 가져오기
	@GetMapping("admin_notice")
	public String adminNotice(@RequestParam(defaultValue = "1")int pageNum, Model model, String theater_name) {
		int listLimit = 10;
		int startRow = (pageNum  - 1) * listLimit;
		System.out.println("극장명: " + theater_name);
		
		List<NoticeVO> noticeList = noticeService.getNoticeList(listLimit, startRow, theater_name);
		
		int listCount = noticeService.getNoticeListCountCag(theater_name);
		int pageListLimit = 5; //뷰에 표시할 페이지갯수
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0); //카운트 한 게시물 + 1 한 페이지
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1; // 첫번째 페이지 번호
		int endPage = startPage + pageListLimit - 1; //마지막 페이지 번호
//		System.out.println("maxPage: " + maxPage);
		if(endPage > maxPage) { // 마지막 페이지가 최대 페이지를 넘어갈때 
			endPage = maxPage;
		}
		PageInfo pageList = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
		
		
		//LocalDateTIme format
		for(NoticeVO notice : noticeList) {
			notice.setNotice_fdt(notice.getNotice_date().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
		}
		model.addAttribute("theater_name", theater_name);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pageList", pageList);
		
		return "admin/admin_csc/admin_notice";
	}
	
	@GetMapping("admin_notice_form")
	public String adminNoticeForm() {
		return "admin/admin_csc/admin_notice_form";
	}
	
	@PostMapping("admin_notice_pro")
	public String adminNoticePro(NoticeVO notice, Model model, String theater_name) {
		int theater_num = 0;
//		System.out.println("극장 이름: " + theater_name);
		
		if(!theater_name.equals("") && theater_name != null) {
			notice.setTheater_name(notice.getTheater_name().replace(",", ""));
			theater_num = noticeService.getTheaterNum(notice.getTheater_name());
//			System.out.println("극장번호: " + theater_num);
		} else if(notice.getTheater_name().equals("none")){
			notice.setNotice_num(0);
//			System.out.println("셋극장 넘버: " + notice.getNotice_num());
		}
		
		int noticeCount = service.InsertNotice(notice,theater_num);
		
		if(noticeCount == 0) {
			model.addAttribute("msg", "입력 실패!");
			
			return "error/fail";
		}
		
		
		return "redirect:/admin_notice";
	}
	
	//notice_modify 연결
	@GetMapping("admin_notice_modify")
	public String adminNoticeModify(NoticeVO notice, Model model) {
		notice = service.getNotice(notice);
		System.out.println(notice);
		
		model.addAttribute("notice", notice);
		return "admin/admin_csc/admin_notice_modify";
	}
	
	//notice_modify 
	@PostMapping("admin_notice_modify")
	public String adminNoticeModifyPro(NoticeVO notice, Model model) {
//		System.out.println("PRO notice: " + notice);
//		if(!notice.getTheater_name().equals("")) {
//			int theaterNum = noticeService.getTheaterNum(notice.getTheater_name());
//			System.out.println("극장번호 : " + theaterNum);
//			notice.setNotice_num(theaterNum);
//		}
		
		int updateCount = noticeService.updateNotice(notice);
		
		if(updateCount == 0) {
			model.addAttribute("msg", "수정 실패!");
			return "error/fail";
		}
		
		
//		model.addAttribute("notice", notice);
		return "redirect:/admin_notice";
	}
	
	@GetMapping("admin_notice_delete")
	public String adminNoticeDelete(int notice_num, Model model) {
		int deleteCount = service.deleteNotice(notice_num);
		if(deleteCount == 0) {
			model.addAttribute("msg", "공지사항 삭제 실패");
			return "error/fail";
		}
		return "redirect:/admin_notice";
	}
	
	@GetMapping("admin_notice_detail")
	public String adminNoticeDetail(NoticeVO notice, Model model) {
//		notice = service.getNotice(notice);
		notice = noticeService.getNotice(notice.getNotice_num());
		notice.setNotice_fdt(notice.getNotice_date().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"))); 
		int maxNotice = service.getMaxNotice(notice);
		int minNotice = service.getMinNotice(notice);
		
		model.addAttribute("minNotice", minNotice);
		model.addAttribute("maxNotice", maxNotice);
		model.addAttribute("notice", notice);
		return "admin/admin_csc/admin_notice_detail";
	}
	
	//---------------------------
	//일대일 문의 controller
	@GetMapping("admin_oto")
	public String adminOto(@RequestParam(defaultValue = "1")int pageNum,
						   Model model,
						   String faqCategory,
						   String theaterName,
						   @RequestParam(required = false)String id) {
		int listLimit = 10;
		int startRow = (pageNum  - 1) * listLimit;
		
		List<OTOVO> otoList = otoService.getOtoList(startRow, listLimit, faqCategory, theaterName, id);
		

		model.addAttribute("faqCategory", faqCategory);
		if(faqCategory != null && !faqCategory.equals("")) {model.addAttribute("faqCategory", faqCategory);} 
		if(theaterName != null && !theaterName.equals("")) {model.addAttribute("theaterName", theaterName);} 
			

		PageInfo pageList = pageInfoCategory(pageNum, listLimit, startRow, faqCategory, theaterName, id); //faq 페이지네이션
		
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("pageList", pageList);
		model.addAttribute("otoList", otoList);
		
		return "admin/admin_csc/admin_oto";
	}

	// 페이징
	public PageInfo pageInfoCategory(int pageNum, int listLimit, int startRow,  String faqCategory, String theaterName, String id) {
		
		int listCount = otoService.getOtoListCount(faqCategory, theaterName, id); //총 공지사항 갯수
		int pageListLimit = 5; //뷰에 표시할 페이지갯수
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0); //카운트 한 게시물 + 1 한 페이지
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1; // 첫번째 페이지 번호
		int endPage = startPage + pageListLimit - 1; //마지막 페이지 번호
		
		if(endPage > maxPage) { // 마지막 페이지가 최대 페이지를 넘어갈때 
			endPage = maxPage;
		}
		return new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
	}
	
	
	
	//1대1 문의 답변하기
	@GetMapping("admin_oto_detail")
	public String adminOtoDetail(Model model, int oto_num) {
		OTOVO oto = otoService.getOto(oto_num);
		String otoDate = oto.getOto_date().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		
		model.addAttribute("otoDate", otoDate);
		model.addAttribute("oto", oto);
		return "admin/admin_csc/admin_oto_detail";
	}
	@PostMapping("admin_oto_detail")
	public String adminOtoDetailPro(OTOReplyVO reply, Model model) {
		System.out.println(reply);
		int insertCount = service.replyRegist(reply, reply.getOto_num());
		if(insertCount == 0) {
			model.addAttribute("msg", "일대일문의 답변 실패");
			return "error/fail";
		}
		int updateCount = otoService.updateOtoResponse(reply.getOto_num());
		if(updateCount == 0) {
			model.addAttribute("msg", "답변 변경 실패");
		}
		
		return "redirect:/admin_oto";
	}
	@GetMapping("admin_oto_modify")
	public String adminOtoModify(Model model, int oto_num, String pageNum) {
		OTOVO oto = otoService.getOto(oto_num);
		String otoDate = oto.getOto_date().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		OTOReplyVO reply = otoService.getOtoReply(oto_num);
		
		model.addAttribute("reply", reply);
		model.addAttribute("otoDate", otoDate);
		model.addAttribute("oto", oto);
		model.addAttribute("pageNum", pageNum);
		return "admin/admin_csc/admin_oto_modify";
	}
	@PostMapping("admin_oto_modify")
	public String adminOtoModifyPro(OTOReplyVO reply, Model model,@RequestParam(defaultValue = "1")String pageNum, HttpSession session) {
		System.out.println(reply.getOto_num());
		OTOVO oto = otoService.getOto(reply.getOto_num());
		
		int updateCount = otoService.updateOtoContent(reply);
		
		String id = (String)session.getAttribute("sId");
		if (updateCount > 0 && id.equals(oto.getMember_id())) {
	        session.setAttribute("updateMessage", oto.getOto_subject() + "의 답변이 수정되었습니다. 확인하시겠습니까?");
	        System.out.println("ㅇㅇㅇㅇㅇ: " + session.getAttribute("updateMessage"));
	    }
		
		return "redirect:/admin_oto?pageNum=" + pageNum;
	}
	
	//관리자 고객센터 controller 끝 =========================================================

	
	// 관리자 회원 페이지

	// 2) 리뷰 페이지
	@GetMapping("admin_review")
	public String adminReview(@RequestParam(defaultValue = "1") int pageNum, 
			  				  @RequestParam(defaultValue = "") String searchKeyword, Model model, HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		} 
		
		
		// 한 페이지에 표시할 갯수
		int listLimit = 10;
		// 조회 시작 행 번호
		int startRow = (pageNum - 1) * listLimit;
		// 리뷰목록 조회
		List<ReviewVO> reviewList = service.getReviewList(searchKeyword, startRow, listLimit);
		int listCount = service.getReviewListCount(searchKeyword, startRow, listLimit);
		
		int pageListLimit = 5;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1: 0);
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("pageInfo", pageInfo);
		return "admin/admin_member/admin_review";
	}
	
	// 리뷰 삭제
	@GetMapping("admin_review_delete")
	public String adminReviewDelete(String review_num, Model model, HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		}
		
		int deleteCount = service.deleteReview(review_num);
		if(deleteCount > 0) {
			return "redirect:/admin_review";
		} else {
			model.addAttribute("msg", "삭제에 실패하였습니다");
			return "error/fail";
		}
	}
	
	// 3) 회원페이지
	@GetMapping("admin_member")
	public String adminMember(@RequestParam(defaultValue = "1") int pageNum, 
							  @RequestParam(defaultValue = "") String searchKeyword, Model model, HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		} 
		// 한 페이지에 표시할 갯수
		int listLimit = 10;
		// 조회 시작 행 번호
		int startRow = (pageNum - 1) * listLimit;
		
		// 회원목록 조회
		List<MemberVO> memberList = service.getMemberList(searchKeyword, startRow, listLimit);
		
		int listCount = service.getMemberListCount(searchKeyword, startRow, listLimit);
		// 페이징 숫자 갯수
		int pageListLimit = 5;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1: 0);
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
		model.addAttribute("memberList", memberList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "admin/admin_member/admin_member";
	}
	
	// 회원정보 상세
	@GetMapping("admin_member_editForm")
	public String adminMemberEditForm(MemberVO member , Model model, HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		} 
		System.out.println(member.getMember_id());
		member = service.SelectMember(member.getMember_id());
		model.addAttribute("member", member);
		
		return "admin/admin_member/admin_member_editForm";
	}
	
	// 회원 삭제
	@GetMapping("admin_member_withdraw")
	public String adminMemberWithdraw(MemberVO member, Model model, HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		}
		
		int updateCount = service.deleteMember(member.getMember_id());
		
		if(updateCount > 0) {
			return "redirect:/admin_member";
		} else {
			model.addAttribute("msg", "회원삭제에 실패하였습니다");
			return "error/fail";
		}
	}
	
	//--------------------------------------------------------------------
	// 관리자 상영관리 페이지
	@GetMapping("admin_moviePlan")
	public String adminMoviePlan(@RequestParam(defaultValue = "1") int pageNum, Model model, HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		} 
		
		List<Map<String, String>> movieList = service.getmovieList();
		List<Map<String, String>> theaterNameList = service.getTheaterList();
		
		// 한 페이지에 표시할 갯수
		int listLimit = 10;
		// 조회 시작 행 번호
		int startRow = (pageNum - 1) * listLimit;
		
		List<Map<String, String>> moviePlanList = service.selectMoviePlanList(startRow, listLimit);
		
		int listCount = service.selectMoviePlanListCount(startRow, listLimit);
		
		// 페이징 숫자 갯수
		int pageListLimit = 5;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1: 0);
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("movieList", movieList);
		model.addAttribute("moviePlanList", moviePlanList);
		model.addAttribute("theaterNameList", theaterNameList);
		
		return "admin/admin_movie/admin_moviePlan";
	}
	
	// 상영일정 등록
	@PostMapping("admin_moviePlan_reg")
	public String adminMoviePlanReg(ScreenSessionVO screenSession, Model model, HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		} 
		
		// 상영일정 등록시 빈자리값 계산해서 넣어주기
		ScreenInfoVO seatInfo = service.getSeatInfo(screenSession);
		String col = seatInfo.getScreen_seat_col();
		String row = seatInfo.getScreen_seat_row();
		
		// ASCII 값으로 변환
        int seatRowAscii = Integer.parseInt(row);
        int seatColAscii = (int) col.charAt(0);
        // 'A'의 ASCII 값
        int asciiA = (int) 'A';
        // 계산 및 대입
        int emptySeat = seatRowAscii * (seatColAscii - asciiA + 1);
        screenSession.setScs_empty_seat(emptySeat);
		
		int insertCount = service.insertMoviePlan(screenSession);
		
		if(insertCount > 0) {
			model.addAttribute("msg", "상영일정이 등록되었습니다");
			model.addAttribute("targetURL", "admin_moviePlan");
			return "error/fail";
		} else {
			model.addAttribute("msg", "일정등록에 실패하였습니다");
			return "error/fail";
		}
		
	}
	
	// 상영일정 삭제 
	@GetMapping("admin_moviePlan_delete")
	public String adminMoviePlanDelete(ScreenSessionVO screenSession, Model model, HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		}
		
		int deleteCount = service.deleteMoviePlan(screenSession.getScs_num());
		if(deleteCount > 0) {
			return "redirect:/admin_moviePlan";
		} else {
			model.addAttribute("msg", "삭제에 실패하였습니다");
			return "error/fail";
		}
	}
	
//	@GetMapping("admin_moviePlan_form")
//	public String adminMoviePlanForm() {
//		return "admin/admin_movie/admin_moviePlan_form";
//	}
//	
//	@PostMapping("admin_moviePlan_pro")
//	public String adminMoviePlanPro() {
//		return "redirect:/admin_moviePlan";
//	}
	
	// 상영관리 AJAX
	@GetMapping("getScreens")
	@ResponseBody
	public List<ScreenInfoVO> getScreens(@RequestParam("theater_num") String theater_num) {
		List<ScreenInfoVO> screen_info = service.getScreensByTheater(theater_num);
		System.out.println(screen_info);
		return screen_info;
	}
	
	// 끝나는 시간 계산 ajax
	@GetMapping("movieEndTime")
	@ResponseBody
	public ResponseEntity<String> movieEndTime(@RequestParam String hourSelect, @RequestParam String movieSelect) {
		MovieVO movie = service.SelectMovie(Integer.parseInt(movieSelect));
		String runtime = movie.getMovie_runtime();
		
     	String[] parts = hourSelect.split(":"); // 시간을 시와 분으로 분할
	    int hours = Integer.parseInt(parts[0], 10); // 시간 부분을 정수로 변환
	    int mins = Integer.parseInt(parts[1], 10); // 분 부분을 정수로 변환

	    mins += Integer.parseInt(runtime); // 분에 분을 더함
	    hours += Math.floor(mins / 60); // 60분을 초과한 부분을 시간에 추가
	    mins = mins % 60; // 분을 60으로 나눈 나머지를 계산하여 분에 할당

	    // 24시간 형식으로 시간 조정
	    hours = (hours + 24) % 24;

	    // 시간과 분을 2자리로 포맷팅
	    var hoursFormatted = String.format("%02d", hours);
	    var minsFormatted = String.format("%02d", mins);

	    String endTime = "";
	    endTime = hoursFormatted + ':' + minsFormatted;
	    System.out.println(endTime);
		
		return ResponseEntity.ok().body(endTime);
	}
	
	// 상영일정 타임리스트 ajax
	@GetMapping("moviePlan_time")
	@ResponseBody
	public List<Map<String, String>> moviePlanTime(@RequestParam int theaterSelect, @RequestParam int screenSelect, @RequestParam Date scs_date) {
		List<Map<String, String>> movieTimeList = service.getMovieTimeList(theaterSelect, screenSelect, scs_date);
		System.out.println("movieTimeList: " + movieTimeList);
		return movieTimeList;
	}
	
	// 상영일정 조회하기 ajax
	@GetMapping("searchMoviePlanList")
	@ResponseBody
	public List<ScreenSessionVO> searchMoviePlanList(@RequestParam int searchTheater, @RequestParam Date searchDate, @RequestParam(defaultValue = "0") int searchScreen) {
//		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		// 한 페이지에 표시할 갯수
//		int listLimit = 10;
		// 조회 시작 행 번호
//		int startRow = (pageNum - 1) * listLimit;
		
//		List<ScreenSessionVO> searchMovieList = service.getMoivePlanList(searchTheater, searchDate, startRow, listLimit);
		List<ScreenSessionVO> searchMovieList = service.getMoivePlanList(searchTheater, searchDate, searchScreen);
		
//		int listCount = service.getMoivePlanListCount(searchTheater, searchDate, startRow, listLimit);
//		
//		// 페이징 숫자 갯수
//		int pageListLimit = 3;
//		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1: 0);
//		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
//		int endPage = startPage + pageListLimit - 1;
//		if(endPage > maxPage) {
//			endPage = maxPage;
//		}
//		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
//		resultMap.put("searchMovieList", searchMovieList);
//		resultMap.put("pageInfo", pageInfo);
		
		
//		return new JSONObject(resultMap).toString();
		return searchMovieList;
	}
	

	//--------------------------------------------------------------------
	// 영화 리스트 조회 
	@GetMapping("admin_movie")
	public String adminMovie(@RequestParam(defaultValue = "1") int pageNum, 
						 	 @RequestParam(defaultValue = "") String searchKeyword, Model model, HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		} 
		
		// 한 페이지에 표시할 갯수
		int listLimit = 10;
		// 조회 시작 행 번호
		int startRow = (pageNum - 1) * listLimit;
		
		// 영화목록 조회
		List<MovieVO> movieList = service.searchMovieList(searchKeyword, startRow, listLimit);
		
		int listCount = service.getMovieListCount(searchKeyword, startRow, listLimit);
		// 페이징 숫자 갯수
		int pageListLimit = 5;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1: 0);
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
		model.addAttribute("movieList", movieList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "admin/admin_movie/admin_movie";
	}
	
	// 영화 삭제
	@GetMapping("admin_movie_delete")
	public String adminMovieDelete(@RequestParam String movie_num, Model model, HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		}
		
		System.out.println("moviedelete");
		int deleteCount = service.deleteMovie(movie_num);
		
		if(deleteCount > 0) {
			model.addAttribute("msg", "영화가 삭제되었습니다");
			model.addAttribute("targetURL", "admin_movie");
			return "error/fail";
		} else {
			model.addAttribute("msg", "영화삭제 실패");
			return "redirect:/error/fail";
		}
	}
	
	// 영화 등록 폼
	@GetMapping("admin_movie_reg_form")
	public String adminMovieRegForm(HttpSession session, Model model) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		} 
		
		return "admin/admin_movie/admin_movie_reg_form";
	}
	
	// 영화 등록 프로
	@PostMapping("admin_movie_reg_pro")
	public String adminMovieGetPro(@ModelAttribute MovieVO movie, Model model, HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		} 
		
		// db에 영화가 있는지 판별
		MovieVO dbMovie = service.getMovie(movie.getMovie_name().trim()); 
		if(dbMovie != null) {
			model.addAttribute("msg", "이미 등록된 영화입니다!");
			return "error/fail";
		}
		// db에 영화 삽입
		// 영화 이름에 공백 제거
		movie.setMovie_name(movie.getMovie_name().trim());
		int insertCount = service.InsertMovie(movie);
		if(insertCount > 0) {
			return "redirect:admin_movie";
		} else {
			model.addAttribute("msg", "영화등록 실패");
			return "error/fail";
		}
		
	}
	
	// 영화 수정 폼
	@GetMapping("admin_movie_edit_form")
	public String adminMovieEditForm(MovieVO movie, Model model, HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		} 
		
		movie = service.SelectMovie(movie.getMovie_num());
		model.addAttribute("movie", movie);
		
		return "admin/admin_movie/admin_movie_edit_form";
	}
	
	// 영화 수정 프로
	@PostMapping("admin_movie_edit_pro")
	public String adminMovieEditPro(@ModelAttribute MovieVO movie, Model model, HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		} 
		
		int updateCount = service.UpdateMovie(movie);
		System.out.println(movie);
		
		if(updateCount > 0) {
			return "redirect:admin_movie";			
		} else {
			model.addAttribute("msg", "영화수정 실패");
			return "error/fail";
		}
	}
	
	
	//--------------------------------------------------------------------
	// 날짜 변환기
	@InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
    }
	
	// 관리자 이벤트 
	@GetMapping("admin_event")
	public String adminEvent(@RequestParam(defaultValue = "1") int pageNum, 
		 	 				 @RequestParam(defaultValue = "") String searchKeyword, Model model, HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		} 
		
		// 한 페이지에 표시할 갯수
		int listLimit = 10;
		// 조회 시작 행 번호
		int startRow = (pageNum - 1) * listLimit;
		
		// 영화목록 조회
		List<EventVO> eventList = eventService.getEventListSearch(searchKeyword, startRow, listLimit);
		
		int listCount = eventService.getEventListCount(searchKeyword, startRow, listLimit);
		// 페이징 숫자 갯수
		int pageListLimit = 5;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1: 0);
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {
		endPage = maxPage;
		}
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("eventList",eventList);
		return "admin/admin_event/admin_event";
	}
	
	// 이벤트 등록 폼
	@GetMapping("admin_event_form")
	public String adminEventForm(Model model, HttpSession session) {
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		} 
		
		List<Map<String, String>> couponTypeList = service.getCouponTypeList();
		model.addAttribute("couponTypeList", couponTypeList);
		
		return "admin/admin_event/admin_event_form";
	}
	
	// 이벤트 등록 프로
	@PostMapping("admin_event_pro")
	public String adminEventPro(HttpServletRequest request, HttpSession session, EventVO event, Model model) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		}
		
		String uploadDir = "/resources/upload";
		String saveDir = session.getServletContext().getRealPath(uploadDir);
		System.out.println("실제 업로드 경로(session): " + saveDir);
		// 실제 업로드 경로
		
		String subDir = "";
		LocalDate today = LocalDate.now();
		String datePattern = "yyyy/MM/dd";
		
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern(datePattern);
		System.out.println(today.format(dtf));
		subDir = today.format(dtf);
		
		saveDir += "/" + subDir;
		System.out.println(saveDir);
		
		Path path = Paths.get(saveDir);
		
		try {
			// Files 클래스의 createDirectories() 메서드 호출하여 실제 경로 생성
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		MultipartFile mfile1 = event.getEvent_thumbFile();
		MultipartFile mfile2 = event.getEvent_imageFile();
		String uuid = UUID.randomUUID().toString();
		
		event.setEvent_thumbnail("");
		event.setEvent_image("");
		
		String fileName1 = UUID.randomUUID().toString().substring(0, 8) + "_" + mfile1.getOriginalFilename();
		String fileName2 = UUID.randomUUID().toString().substring(0, 8) + "_" + mfile2.getOriginalFilename();
		
		if(!mfile1.getOriginalFilename().equals("")) {
			event.setEvent_thumbnail(subDir + "/" + fileName1);      
		}
		if(!mfile2.getOriginalFilename().equals("")) {
			event.setEvent_image(subDir + "/" + fileName2);      
		}
		
//		System.out.println("업로드 파일명: " + event.getEvent_thumbnail());
//		System.out.println("업로드 파일명: " + event.getEvent_image());
		
		int insertCount = service.InsertEvent(event);
		
		if(insertCount > 0) {
			try {
				if(!mfile1.getOriginalFilename().equals("")) {
					mfile1.transferTo(new File(saveDir, fileName1));
				}
				if(!mfile2.getOriginalFilename().equals("")) {
					mfile2.transferTo(new File(saveDir, fileName2));
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			return "redirect:/admin_event";
		} else {
			return "error/fail";
		}
	}
	// 이벤트 등록 수정 폼
	@GetMapping("admin_event_modify")
	public String adminEventModify(HttpSession session, EventVO event, Model model) {
		event = eventService.getEvent(event.getEvent_num());
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		}
		
		if(event == null) {
			model.addAttribute("msg", "이벤트를 불러오는데 실패하였습니다");
			return "error/fail";
		} else {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			event.setEvent_start(dateFormat.format(event.getEvent_start_date()));
			event.setEvent_end(dateFormat.format(event.getEvent_end_date()));
			model.addAttribute("event", event);
			return "admin/admin_event/admin_event_modify";
		}
	}
	// 이벤트 등록 수정 프로
	@PostMapping("admin_event_modify_pro")
	public String adminEventModifyPro(EventVO event, Model model, HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		}
		
		int updateCount = service.updateEvent(event);
		if(updateCount > 0) {
			return "redirect:/admin_event";
		} else {
			model.addAttribute("msg", "이벤트 수정에 실패하였습니다");
			return "error/fail";
		}
	}
	// 이벤트 삭제
	@GetMapping("admin_event_delete")
	public String adminEventDelete(HttpSession session, EventVO event, Model model) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		}
		
		EventVO dbEvent = eventService.getEvent(event.getEvent_num());
		
		int deleteCount = service.deleteEvent(event);
		if(deleteCount > 0) {
			String uploadDir = "/resources/upload";
			String saveDir = session.getServletContext().getRealPath(uploadDir);
			
			String[] arrFileNames = {
				dbEvent.getEvent_thumbnail(),
				dbEvent.getEvent_image()
			};
			
			for(String fileName : arrFileNames) {
				if(!fileName.equals("")) {
					Path path = Paths.get(saveDir + "/" + fileName);
					try {
						Files.deleteIfExists(path);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}
			
			return "redirect:/admin_event";
		} else {
			model.addAttribute("msg", "이벤트 수정에 실패했습니다");
			return "error/fail";
		}
	}
	
	// 쿠폰 페이지
	@GetMapping("admin_coupon")
	public String adminCoupon(HttpSession session, Model model, @RequestParam(defaultValue = "1") int pageNum, 
				 @RequestParam(defaultValue = "") String searchKeyword) {
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		} 
		// 한 페이지에 표시할 갯수
		int listLimit = 10;
		// 조회 시작 행 번호
		int startRow = (pageNum - 1) * listLimit;
		
		// 쿠폰목록 조회
		List<CouponVO> couponTypeList = service.getCouponTypeListSearch(searchKeyword, startRow, listLimit);
		
		int listCount = service.getCouponListCount(searchKeyword, startRow, listLimit);
		// 페이징 숫자 갯수
		int pageListLimit = 5;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1: 0);
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {
		endPage = maxPage;
		}
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("couponTypeList", couponTypeList);
		
		return "admin/admin_event/admin_coupon";
	}
	
	
	// 쿠폰 등록 폼
	@GetMapping("admin_coupon_form")
	public String adminCouponForm(Model model, HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		} 
		
		return "admin/admin_event/admin_coupon_form";
	}

	// 쿠폰 등록 프로
	@PostMapping("admin_coupon_pro")
	public String adminCouponPro(Model model, HttpSession session, CouponVO coupon) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		} 
		// 쿠폰등록
		int insertCount = service.insertCoupon(coupon);
		if(insertCount > 0) {
			return "redirect:/admin_coupon";
		} else {
			model.addAttribute("msg", "쿠폰등록에 실패했습니다");
			return "error/fail";
		}
		
	}
	
	@GetMapping("admin_coupon_delete")
	public String adminCouponDelete(CouponVO coupon, HttpSession session, Model model) {
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		} 
		// 쿠폰 삭제
		int deleteCount = service.deleteCoupon(coupon);
		if(deleteCount > 0) {
			return "redirect:/admin_coupon";
		} else {
			model.addAttribute("msg", "쿠폰삭제에 실패했습니다");
			return "error/fail";
		}
		
	}

	//--------------------------------------------------------------------
	// 관리자 결제 페이지
	@GetMapping("admin_pay")
	public String adminPay(@RequestParam(defaultValue = "1") int pageNum, 
						   @RequestParam(defaultValue = "") String searchKeyword, Model model, HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		}
		
		// 한 페이지에 표시할 갯수
		int listLimit = 10;
		// 조회 시작 행 번호
		int startRow = (pageNum - 1) * listLimit;
		
		List<StorePayVO> store_pay_list = service.selectStorePayList(searchKeyword, startRow, listLimit);
		
//		 이거 주석 처리 해놓은거 풀고 쓰시면 됩니다
//		List<Map<String, String>> payList = service.getPayList(searchKeyword, startRow, listLimit);
//		
		int listCount = service.getStorePayListCount(searchKeyword, startRow, listLimit);
//		
//		// 페이징 숫자 갯수
		int pageListLimit = 5;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1: 0);
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {
		endPage = maxPage;
		}
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
//		model.addAttribute("payList", payList);
		model.addAttribute("pageInfo", pageInfo);
		
		
		
		model.addAttribute("store_pay_list", store_pay_list);
		
		
		
		return "admin/admin_pay/admin_pay";
	}
	@GetMapping("admin_pay_cancel")
	public String adminPayCancel() {
		return "redirect:/admin_pay";
	}
	
	//----------------------------------------------------------------------
	//	예매관리 페이지
	@GetMapping("admin_reserve")
	public String adminReserve(@RequestParam(defaultValue = "1") int pageNum, 
							   @RequestParam(defaultValue = "") String searchKeyword, Model model, HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		}
		
		// 한 페이지에 표시할 갯수
		int listLimit = 10;
		// 조회 시작 행 번호
		int startRow = (pageNum - 1) * listLimit;
		
		List<Map<String, String>> reserveList = service.getReserveList(searchKeyword, startRow, listLimit);
		
		int listCount = service.getReserveListCount(searchKeyword, startRow, listLimit);
		// 페이징 숫자 갯수
		int pageListLimit = 5;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1: 0);
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		if(endPage > maxPage) {
		endPage = maxPage;
		}
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		model.addAttribute("reserveList", reserveList);
		model.addAttribute("pageInfo", pageInfo);
		
		return "admin/admin_member/admin_reserve";
	}
	
	// 예매 상세 페이지
	@GetMapping("admin_reserve_detail")
	public String adminReserveDetail(@RequestParam int ticket_num, @RequestParam int ticket_pay_num, Model model, HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		}
		
		// 예매정보 가져오기
		Map<String, String> reserveDetail = service.selectReserveDetail(ticket_num);
		// 좌석 정보 가져오기
		List<Map<String, String>> seatArr = service.selectSeatInfo(ticket_pay_num);
		System.out.println(seatArr);
		// 좌석정보 통합
		String seatInfo = "";
		for(Map<String,String> seat : seatArr) {
			seatInfo += seat.get("ticket_seat_info") + "/";
        }
		// / 제거
		if (seatInfo.endsWith("/")) {
			seatInfo = seatInfo.substring(0, seatInfo.length() - 1);
        }
		System.out.println(seatInfo);
		
		model.addAttribute("reserveDetail", reserveDetail);
		model.addAttribute("seatInfo", seatInfo);
		return "admin/admin_member/admin_reserve_detail";
	}
	
	//--------------------------------------------------------------------
	// 관리자 스토어 페이지
	@GetMapping("admin_store")
	public String adminStore(Model model, HttpSession session) {
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		}
		
		//전체리스트를 담는 걸 하나 만듬.
		
		List<ItemInfoVO> itemFull = service.getItmeListFull();
		model.addAttribute("itemFull", itemFull);
		//전체리스트 담는 거 확인완료
				
		return "admin/admin_store/admin_store";
	}
	// 아이템 수정폼으로 일단 와서
	@GetMapping("admin_store_modify")
	public String adminStoreModify(@RequestParam String item_info_name, ItemInfoVO item, Model model) {
		
		//System.out.println("여기는 스토어 아이템수정 " + item_info_name);
		item = service.getItem(item_info_name);
		//System.out.println("여기는 스토어 아이템수정 "+ item);
		model.addAttribute("updateItem", item);
		
		return "admin/admin_store/admin_store_modify";
	}
	// 여기서 아이템 업데이트 폼을 다시 리다이렉트
	
	@PostMapping("admin_store_modifyPro")
	public String adminStoreForm(ItemInfoVO updateItem, Model model, HttpSession session) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		}
		
		//System.out.println("진짜 스낵수정폼 수정" + updateItem); 데이터 확인완료 주석처리
		int updateCount = service.updateItem(updateItem);
		if(updateCount > 0) {
			return "redirect:/admin_store";
		} else {
			model.addAttribute("msg", "스토어 아이템 수정에 실패하였습니다");
			return "error/fail";
		}
	}
	@GetMapping("admin_store_form")
	public String adminStoreInsert() {
		
		return "admin/admin_store/admin_store_form";
	}
	
	
	
	@PostMapping("admin_store_pro")
	public String adminStorePro(ItemInfoVO insertItem,Model model, HttpSession session, ItemInfoVO item) {
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		}
		
		//System.out.println("여기는 스토어프로 인설트 아이템 확인" + insertItem); 데이터 확인완료
		ItemInfoVO dbItem =  service.getItem(insertItem.getItem_info_name());
		String uploadDir = "resources/images"; 
		String saveDir = session.getServletContext().getRealPath(uploadDir);
		System.out.println("실제 업로드 경로(session): " + saveDir);
		// 실제 업로드 경로
		
		Path path = Paths.get(saveDir);
		
		try {
			// Files 클래스의 createDirectories() 메서드 호출하여 실제 경로 생성
			Files.createDirectories(path);
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		//MultipartFile mfile1 = insertItem.getItem_info_image();
		
		if(dbItem != null) {
			model.addAttribute("msg", "이미 등록된 스토어 아이템입니다!");
			return "error/fail";
		}
		
		int insertCount = service.insertItem(insertItem);
		if(insertCount > 0) {
			return "redirect:/admin_store";
		} else {
			model.addAttribute("msg", "스토어아이템 등록 실패");
			return "error/fail";
		}
		
	}
	
	
	@GetMapping("admin_store_delete")
	public String adminStoreDelete(@RequestParam String item_info_name, Model model, HttpSession session) {
		System.out.println("storedelete");
		
		String id = (String)session.getAttribute("sId");
		
		if(id == null || !id.equals("admin")) { // 실패
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		}
		
		int deleteCount = service.deleteItem(item_info_name);
		if(deleteCount > 0) {
			return "redirect:/admin_store";
		} else {
			model.addAttribute("msg", "스토어 아이템 삭제에 실패했습니다");
			return "error/fail";
		}
		
			
	}
	
	//--------------------------------------------------------------------
	// 관리자 극장 페이지 메인
	@GetMapping("admin_theater")
	public String adminTheater(TheaterVO theater, Model model, ScreenInfoVO screen_info) {
		
		// 극장 리스트 조회
		List<TheaterVO> theaterList = theaterService.getTheater();
		
		model.addAttribute("theaterList", theaterList);
		
		return "admin/admin_theater/admin_theater";
	}
	
	// 극장 관리 > 극장 수정 폼으로
	@GetMapping("admin_theater_modify")
	public String adminTheaterModifyForm(TheaterVO theater, Model model) {
		// 수정할 극장 조회
		theater = theaterService.getTheater(theater);
		
		model.addAttribute("theater", theater);
		
		return "admin/admin_theater/admin_theater_modify_form";
	}
	
	// 극장 관리 > 극장 수정 등록 비즈니스
	@PostMapping("admin_theater_modify")
	public String adminTheaterModifyPro(TheaterVO theater, Model model) {
		
		int updateCount = theaterService.modifyTheater(theater);
		
		
		if(updateCount < 1) {
			model.addAttribute("msg", "극장 정보 수정 실패!");
			return "error/fail";
		} 
		return "redirect:/admin_theater";
	}
	
	// 극장 관리 > 새 극장 등록 폼
	@GetMapping("admin_theater_form")
	public String adminTheaterForm() {
		return "admin/admin_theater/admin_theater_form";
	}
	
	// 극장 관리 > 새 극장 등록 비즈니스
	@PostMapping("admin_theater_pro")
	public String adminTheaterPro(TheaterVO theater, Model model) {
		
		int insertCount = theaterService.registTheater(theater);
		
		if(insertCount < 1) {
			model.addAttribute("msg", "극장 정보 등록 실패!");
			return "error/fail";
		}
		
		return "redirect:/admin_theater";
	}
	
	// 극장 관리 > 극장 삭제
	@GetMapping("admin_theater_delete")
	public String adminTheaterDelete(TheaterVO theater, Model model) {
		
		int deleteCount = theaterService.deleteTheater(theater);
		
		if(deleteCount < 1) {
			model.addAttribute("msg", "극장 삭제 실패!");
			return "error/fail";
		}
		
		return "redirect:/admin_theater";
	}
	
	// 상영관 관리 > 상영관 리스트
	@GetMapping("admin_booth")
	public String adminBooth(@RequestParam(defaultValue = "1") int pageNum, 
							@RequestParam(defaultValue = "") String searchKeyword, Model model) {
		
		// 한 페이지에 표시할 갯수
		int listLimit = 10;
		// 조회 시작 행 번호
		int startRow = (pageNum - 1) * listLimit;
		
		// 상영관 리스트 조회
		List<ScreenInfoVO> screenInfoList = service.getScreenInfo(searchKeyword, startRow, listLimit);
		
		String screen_seat_col = "";
		String screen_seat_row = "";
		int seat_size = 0;
		for(ScreenInfoVO si : screenInfoList) {
			screen_seat_col = si.getScreen_seat_col();
			screen_seat_row = si.getScreen_seat_row();
			seat_size = getSeatSize(screen_seat_col, screen_seat_row);
			si.setSeat_size(seat_size);
		}
		System.out.println("screenInfoList : " + screenInfoList);
		
		int listCount = service.getScreenInfoCount(searchKeyword, startRow, listLimit);
		// 페이징 숫자 갯수
		int pageListLimit = 5;
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1: 0);
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		PageInfo pageInfo = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
		model.addAttribute("pageInfo", pageInfo);
		
		// 극장 리스트 조회
		List<TheaterVO> theaterList = theaterService.getTheater();
		model.addAttribute("theaterList", theaterList);
		
		model.addAttribute("screenInfoList", screenInfoList);
		
		
		return "admin/admin_theater/admin_booth";
	}
	
	// 알파벳을 숫자로 변환하고 row * col (adminBooth 에서 사용)
	private int getSeatSize(String alphabet, String screen_seat_row) {
	    alphabet = alphabet.toUpperCase();
	    int colToNumber = alphabet.charAt(0) - 'A' + 1;
	    int seat_size = colToNumber * Integer.parseInt(screen_seat_row);
	    
	    return seat_size;
	}
	
	
	
	// 상영관 관리 > 상영관 수정 폼으로
	@GetMapping("admin_booth_modify")
	public String adminBoothModifyForm(TheaterVO theater, ScreenInfoVO screenInfo, Model model) {
		// 극장 리스트 조회
		List<TheaterVO> theaterList = theaterService.getTheater();
		
		// 수정할 상영관 조회
		screenInfo = screenService.getScreenInfo(screenInfo);
		
		model.addAttribute("screenInfo", screenInfo);
		model.addAttribute("theaterList", theaterList);
		
		return "admin/admin_theater/admin_booth_modify_form";
	}
	
	// 상영관 관리 > 상영관 수정 비즈니스 
	@PostMapping("admin_booth_modify")
	public String adminBoothModifyPro(ScreenInfoVO screenInfo, Model model) {
		
		String theater_name = screenInfo.getTheater_name();
		screenInfo.setTheater_num(theaterService.getTheaterName(theater_name));
		
		int updateCount = screenService.modifyScreenInfo(screenInfo);
		
		if(updateCount < 1) {
			model.addAttribute("msg", "상영관 정보 수정 실패!");
			return "error/fail";
		}
		
		return "redirect:/admin_booth";
	}
	
	
	// 상영관 관리 > 새 상영관 등록 폼으로
	@GetMapping("admin_booth_form")
	public String adminBoothForm(TheaterVO theater, ScreenInfoVO screenInfo, Model model) {
		// 극장 리스트 조회
		List<TheaterVO> theaterList = theaterService.getTheater();
		// 기존 등록된 상영관의 극장별 마지막 번호+1 값 가져오기
		
		
		model.addAttribute("theaterList", theaterList);
		
		return "admin/admin_theater/admin_booth_form";
	}
	
	// 상영관 등록 폼 ajax
	@ResponseBody
	@GetMapping("new_cinema_num")
	public String newCinemaNum(@RequestParam(defaultValue = "1") int theater_num) {
		
		int new_cinema_num = screenService.getNewCinemaNum(theater_num);
		
		return String.valueOf(new_cinema_num);
	}
	
	// 상영관 관리 > 새 상영관 등록 비즈니스
	@PostMapping("admin_booth_pro")
	public String adminBoothPro(ScreenInfoVO screenInfo, Model model) {
		System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"+screenInfo);
		String theater_name = screenInfo.getTheater_name();
		screenInfo.setTheater_num(theaterService.getTheaterName(theater_name));
		
		int insertCount = screenService.registTheater(screenInfo);
		
		if(insertCount < 1) {
			model.addAttribute("msg",  "상영관 정보 등록 실패!");
			return "error/fail";
		}
		
		return "redirect:/admin_booth";
	}
	

	
	// 상영관 관리 > 상영관 삭제
	@GetMapping("admin_booth_delete")
	public String adminBoothDelete(ScreenInfoVO screenInfo, Model model) {
		
		int deleteCount = screenService.deleteScreenInfo(screenInfo);
		
		if(deleteCount < 1) {
			model.addAttribute("msg", "상영관 삭제 실패!");
			return "error/fail";
		}
		
		return "redirect:/admin_booth";
	}
	
	// ===============================================================================
	
	@GetMapping("StorePayDetail")
	public String storePayDetail(int store_pay_num, Model model) {
		
		StorePayVO store_pay = service.selectStorePayDetail(store_pay_num);
		List<CartVO> carts = service.selectCart(store_pay_num);
		StringBuilder resultStr = new StringBuilder();
		for (CartVO cart : carts) {
		    resultStr.append(cart.getItem_info_name())
		             .append(" : ")
		             .append(cart.getItem_quantity())
		             .append("개   ");
		}
		String result = resultStr.toString();
		
		model.addAttribute("store_pay", store_pay);
		model.addAttribute("cart", result);
		
		return "admin/admin_pay/admin_pay_detail";
	}
	
	
	
	
}
