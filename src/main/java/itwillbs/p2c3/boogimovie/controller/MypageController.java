package itwillbs.p2c3.boogimovie.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import itwillbs.p2c3.boogimovie.service.AdminService;
import itwillbs.p2c3.boogimovie.service.CouponService;
import itwillbs.p2c3.boogimovie.service.MypageService;
import itwillbs.p2c3.boogimovie.service.OtoService;
import itwillbs.p2c3.boogimovie.service.PaymentService;
import itwillbs.p2c3.boogimovie.service.TheaterService;
import itwillbs.p2c3.boogimovie.vo.CartVO;
import itwillbs.p2c3.boogimovie.vo.CouponVO;
import itwillbs.p2c3.boogimovie.vo.MemberVO;
import itwillbs.p2c3.boogimovie.vo.OTOReplyVO;
import itwillbs.p2c3.boogimovie.vo.OTOVO;
import itwillbs.p2c3.boogimovie.vo.PageInfo;
import itwillbs.p2c3.boogimovie.vo.PayVO;
import itwillbs.p2c3.boogimovie.vo.PointVO;
import itwillbs.p2c3.boogimovie.vo.ScreenSessionVO;
import itwillbs.p2c3.boogimovie.vo.StorePayVO;
import itwillbs.p2c3.boogimovie.vo.TheaterVO;

@Controller
public class MypageController {
	
	@Autowired
	private MypageService mypageService;
	
	@Autowired
	private OtoService otoService;

	@Autowired
	private CouponService couponService;
	
	@Autowired
	private	PaymentService paymentService;
	
	@Autowired
	private TheaterService theaterService;
	
	@Autowired
	private HttpSession session;
	
	@Autowired
	private AdminService service;
	
	//중복되는 코드 - 파일 가상 저장 path
	String uploadDir = "/resources/upload";
	
	@GetMapping("myp_main")
	public String mypMain(Model model, MemberVO member, HttpSession session) {
		String id = (String)session.getAttribute("sId");
//		System.out.println( "session ID 값 : " + id);
		
		if(id == null) { // 실패
			model.addAttribute("msg", "로그인이 필요한 페이지입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		} else { // 성공
			
			// 메인페이지 아이디 
			member = mypageService.getMember(id);
			model.addAttribute("member", member);
			
			// My극장 극장 전체리스트
			List<TheaterVO> infoTheater = mypageService.getTheater();
			model.addAttribute("theater", infoTheater);
			
			// My극장 자주가는 영화관
			MemberVO infoMyTheater = mypageService.getMyTheater(member);
			model.addAttribute("infoMyTheater", infoMyTheater);
			String member_id = member.getMember_id();

			// 예매내역
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("status", "결제");
			param.put("member_id", member_id);
			List<Map<String , Object>> movieReservation = mypageService.getMovieReservation(param);
			model.addAttribute("movieReservation", movieReservation);
			
			//답변문의 수정 시 해당 사항을 세션에 저장
			String updateMessage = (String)session.getAttribute("updateMessage");
			if(updateMessage != null) {
				model.addAttribute("updateMessage", updateMessage);
				session.removeAttribute("updateMessage");
			}
			
			return"mypage/myp_main";
		}
		
	}

	// ============================= My극장 체크박스 =============================
	@PostMapping("MyTheaterList") // 마이페이지 My극장 모달폼 극장 전체 리스트
	public String handleFormSubmit(@RequestParam(name = "theaterIds", required = false, defaultValue = "") List<String> theaterIds, HttpSession session, TheaterVO theater) {
		
	        return "redirect:/myp_main";
    }
	
	// 나의극장 업데이트
	@ResponseBody
	@PostMapping(value = "api/myp_my_theater", produces = "application/json")
	public String mypMyTheater(@RequestBody Map<String, Object> check, Model model, MemberVO member){
		//  List<String> checkedValues랑 String member_id를 map으로 가져옴
	    System.out.println("Member ID: " + check.get("member_id"));

	    List<String> checkedValues = (List<String>) check.get("checkedValues");
	    String member_id = (String) check.get("member_id");

	    if(checkedValues == null || checkedValues.isEmpty()) {
	    	return "false";
	    }

	    mypageService.myTheater(checkedValues, member_id, member);

	    return "true";
	}
	
    @ResponseBody
    @PostMapping("updateTheater")
    public ResponseEntity<String> updateTheater(@RequestParam String theater, @RequestParam int theaterNumber) {
        try {
            String id = (String)session.getAttribute("sId");
            
            mypageService.updateTheater(id, theater, theaterNumber);
            return ResponseEntity.ok("성공적으로 업데이트되었습니다.");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("업데이트 실패");
        }
        
    }
	
	// ============================= 포인트 =============================
	
	@GetMapping("myp_point")
	public String mypPoint(Model model, MemberVO member, @RequestParam(defaultValue = "1") int pageNum) {
		System.out.println("myp_point");
		
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인이 필요한 페이지입니다");
			model.addAttribute("targetURL", "member_login");
			return"error/fail";
		}
		
		member.setMember_id(id);
		member = mypageService.getDbMember(member);
		
		PayVO pay = new PayVO();
		pay.setMember_id(id);
		List<PayVO> payList = paymentService.selectPayInfo(pay);
		List<StorePayVO> storePayList = paymentService.selectStorePayInfo(id);
		List<PointVO> combinedList = new ArrayList<PointVO>();
		int scs_num = 0;
        for (PayVO pay2 : payList) {
        	scs_num = pay2.getScs_num();
        	ScreenSessionVO scs = paymentService.getScreenSession(scs_num);
        	TheaterVO theater = new TheaterVO();
        	theater.setTheater_num(scs.getTheater_num());
        	TheaterVO dbTheater = theaterService.getTheater(theater);
            combinedList.add(new PointVO(pay2.getTicket_pay_price()/10, pay2.getUse_point(), pay2.getTicket_pay_date(), pay2.getTicket_pay_type(), dbTheater.getTheater_name()));
        }
        
        LocalDate currentDate = LocalDate.now();
        LocalDateTime localDateTime = null;
        
        for (StorePayVO storePay : storePayList) {
        	combinedList.add(new PointVO(storePay.getStore_pay_price()/10, storePay.getUse_point(), storePay.getStore_pay_date(), storePay.getStore_pay_type(), "스토어"));
        }
        
            	
        Collections.sort(combinedList, Comparator.comparing(PointVO::getDate));
        
		model.addAttribute("member", member);
		model.addAttribute("combinedList", combinedList);
		
		return "mypage/myp_point";
	}
	
	// ============================= 정보수정 =============================

	@GetMapping("myp_info_modify")
	public String mypInfoModify(MemberVO member, Model model) {
		
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "./");
			return"error/fail";
		}
		
		member.setMember_id(id);
		member = mypageService.getDbMember(member);
		String[] addrArr = member.getMember_addr().split("/");
		member.setMember_post_code(addrArr[0]);
		member.setMember_address1(addrArr[1]);
		member.setMember_address2(addrArr[2]);
		model.addAttribute("member", member);
		
        return "mypage/myp_info_modify";
		
	}
	
	// ---------------------------------------------------------------------
	
	@PostMapping("myp_info_modify_pro")
	public String mypInfoModifyPro(MemberVO member, Model model, BCryptPasswordEncoder passwordEncoder) {
		
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "./");
			return "error/fail";
		}
		//postcode,address1,address2 문자열결합 후 addr에 저장
		String aadr= member.getMember_post_code() + "/" + member.getMember_address1() + "/" + member.getMember_address2();
		member.setMember_addr(aadr);
		
		if(!member.getMember_pwd().equals("")) {
			member.setMember_pwd(passwordEncoder.encode(member.getMember_pwd()));
		}
		
		int updateCount = mypageService.modifyMember(member);
		model.addAttribute("member", updateCount);
		
		if(updateCount > 0) { // 정보수정 성공 시
			model.addAttribute("msg", "회원정보가 수정되었습니다");
			model.addAttribute("targetURL", "myp_info_modify");
			return "redirect:/myp_info_modify";
		} else { // 정보수정 실패 시
			model.addAttribute("msg", "회원정보 수정에 실패했습니다");
			model.addAttribute("targetURL", "myp_info_modify");
			return "error/fail";
		}
		
	}
	
	// ============================= 쿠폰 =============================

	@GetMapping("myp_coupon")
	public String mypCoupon(MemberVO member, Model model, CouponVO coupon) {
		String id = (String)session.getAttribute("sId");
		
		if(id == null) { // 아이디 없을 경우 로그인 페이지 이동 
			model.addAttribute("msg", "로그인이 필요한 페이지입니다");
			model.addAttribute("targetURL", "member_login");
			return"error/fail";
		}
		
		member.setMember_id(id);
		member = mypageService.getDbMember(member);
		model.addAttribute("member", member);
		
		List<CouponVO> couponList = couponService.getCoupon(member);
		model.addAttribute("list", couponList);
		
		return "mypage/myp_coupon";
	}
	
	// ============================= 예매 =============================
	
	// 예매내역
	@GetMapping("myp_reservation")
	public String mypReservation(MemberVO member, Model model, @RequestParam(defaultValue = "1")int pageNum, @RequestParam(defaultValue = "결제")String status) {
		String id = (String)session.getAttribute("sId");
		
		if(id == null) { // 아이디 없을 경우 로그인 페이지 이동 
			model.addAttribute("msg", "로그인이 필요한 페이지입니다");
			model.addAttribute("targetURL", "member_login");
			return"error/fail";
		}
		member = mypageService.getMember(id);
		model.addAttribute("member", member);
	    
		PayVO pay = new PayVO();
		Map<String, Object> param = new HashMap<>();
		pay.setTicket_pay_status("결제");
		param.put("status", "결제");
		if ("취소".equals(status)) {
	        pay.setTicket_pay_status("취소");
	        param.put("status", "취소");
	    } 
	    
		int listLimit = 4;
		int startRow = (pageNum - 1) * listLimit;
		String member_id = member.getMember_id();
		
		param.put("startRow", startRow);
		param.put("listLimit", listLimit);
		param.put("member_id", member_id);
		
		// 페이징
		List<Map<String, Object>> movieReservation = mypageService.getMovieReservation(param);
		// -----------------------------------------------------------------------------------------
	    int listCount = mypageService.getResvCount(member_id,status);
	    // -----------------------------------------------------------------------------------------
	    System.out.println("listCount : sdkfjl@@@@@@@@@@@@@@@@" + listCount);
		int pageListLimit = 3; // 뷰에 표시할 페이지 갯수
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0); //카운트 한 게시물 + 1 한 페이지
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1; // 첫번째 페이지 번호 
		int endPage = startPage + pageListLimit - 1; //마지막 페이지 번호
		if(endPage > maxPage) { // 마지막 페이지가 최대 페이지를 넘어갈때 
			endPage = maxPage;
		}
		PageInfo pageList = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
		model.addAttribute("movieReservation", movieReservation);
		model.addAttribute("pageList", pageList);
	    model.addAttribute("status", status); 

		
		return "mypage/myp_reservation";
	}
	
	// ============================= 예매취소 =============================
	
	@ResponseBody
	@PostMapping("myp_cancel_movie")
	public String mypCancelMovie(Model model, MemberVO member, int ticket_pay_num, HttpSession session) {
		String id = (String)session.getAttribute("sId");
		
		if(id == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "./");
			return "result_process/fail";
		}
		
		member.setMember_id(id);
		int removeMovie = mypageService.removeMovie(id, ticket_pay_num);
		
		if(removeMovie > 0) { // 성공 시  
			return "true";
		} else { // 실패 시
			return "false";
		}
		
	}
	
	// ============================= 스토어 취소 =============================
	
	@ResponseBody
	@PostMapping("myp_cancel_store")
	public String cancelStore(StorePayVO storePay, Model model) {
		String id = (String)session.getAttribute("sId");
		
		if(id == null) {
			model.addAttribute("msg", "잘못된 접근입니다!");
			model.addAttribute("targetURL", "./");
			return "result_process/fail";
		}
		storePay.setMember_id(id);
		int removeCount = mypageService.removeStore(storePay);
		if(removeCount > 0) { // 성공 시  
			return "true";
		} else { // 실패 시
			return "false";
		}
	}
	
	// ============================= 스토어 =============================
	
	@GetMapping("myp_store")
	public String mypStore(MemberVO member, Model model, StorePayVO storepay) {
		String id = (String)session.getAttribute("sId");
		
		if(id == null) { // 아이디 없을 경우 로그인 페이지 이동 
			model.addAttribute("msg", "로그인이 필요한 페이지입니다");
			model.addAttribute("targetURL", "member_login");
			return"error/fail";
		}
		member = mypageService.getMember(id);
		model.addAttribute("member", member);
		
		
		List<StorePayVO> storePay = mypageService.getStorePay(member);
		for(StorePayVO store : storePay) {
			List<CartVO> carts = service.selectCart(store.getStore_pay_num());
			StringBuilder resultStr = new StringBuilder();
			for (CartVO cart : carts) {
			    resultStr.append(cart.getItem_info_name())
			             .append(" : ")
			             .append(cart.getItem_quantity())
			             .append("개   ");
			}
			String result = resultStr.toString();
			store.setStore_pay_detail(result);
		}
		
		model.addAttribute("storePay", storePay);
		
		return "mypage/myp_store";
	}
	
	// ============================= 탈퇴 =============================
	
	// 탈퇴 안내 페이지 (탈퇴1)
	@GetMapping("myp_withdraw_info")
	public String mypWithdrawInfo(Model model) {
		String id = (String)session.getAttribute("sId");
		System.out.println("myp_withdraw_info");
		if(id == null) { // 실패
			model.addAttribute("msg", "로그인이 필요한 페이지입니다");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		} 
		return "mypage/myp_withdraw_info";
	}
	
	// 탈퇴 비밀번호 재입력 페이지 (탈퇴2)
	@GetMapping("myp_withdraw_passwd")
	public String mypWithdrawPasswd(Model model) {
		System.out.println("myp_withdraw_passwd()");
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "./");
			return"error/fail";
		}
		return "mypage/myp_withdraw_passwd";
	}
	
	// 탈퇴처리
	@PostMapping("myp_withdraw_finish_pro")
	public String mypWithdrawFinishPro(@RequestParam("password")String password, MemberVO member, Model model, BCryptPasswordEncoder passwordEncoder) {
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "./");
			return"error/fail";
		}
		
		member.setMember_id(id);
		MemberVO dbMember = mypageService.getDbMember(member);
		if(dbMember != null && passwordEncoder.matches(password, dbMember.getMember_pwd())) { // 비번이 같을 때 
			int updateCount = mypageService.withdrawMember(member);
		// 로그인 정보 제거하기 위해 세션 초기화 후 메인페이지로 리다이렉트
			if(updateCount > 0) { // 탈퇴 성공 시
				
				session.invalidate();
				return "redirect:/myp_withdraw_finish";
			} else { // 실패시
				model.addAttribute("msg", "탈퇴에 실패했습니다");
				model.addAttribute("targetURL", "myp_withdraw_info"); 
				return"error/fail";
			}
		} else { // 비번이 일치하지 않을 경우
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다");
			model.addAttribute("targetURL", "myp_withdraw_passwd");
			return"error/fail";
		}
	}
	
	// 탈퇴 후 보여지는 페이지
	@GetMapping("myp_withdraw_finish")
	public String mypWithdrawFinish(MemberVO member, Model model, BCryptPasswordEncoder passwordEncoder) {
		return "mypage/myp_withdraw_finish";
	}
	
	// ============================= CSC =============================
	
	// CSC 관련 List
	@RequestMapping(value = "myp_oto_breakdown", method = {RequestMethod.POST, RequestMethod.GET})
	public String mypOtoBreakdown(Model model,
								  @RequestParam(defaultValue = "1")int pageNum,
								  @RequestParam(required = false)String faqCategory,
								  @RequestParam(required = false)String theaterName,
								  HttpSession session) {
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "./");
			return "error/fail";
		}
		
		int listLimit = 10;
		int startRow = (pageNum - 1) * listLimit;
		List<OTOVO> otoList = otoService.getOtoList(startRow, listLimit, faqCategory, theaterName, id);
		
		
		int listCount = otoService.getOtoListCount(faqCategory, theaterName, id); //총 공지사항 갯수
		int pageListLimit = 5; //뷰에 표시할 페이지갯수
		int maxPage = listCount / listLimit + (listCount % listLimit > 0 ? 1 : 0); //카운트 한 게시물 + 1 한 페이지
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1; // 첫번째 페이지 번호
		int endPage = startPage + pageListLimit - 1; //마지막 페이지 번호
		
		if(endPage > maxPage) { // 마지막 페이지가 최대 페이지를 넘어갈때 
			endPage = maxPage;
		}
		PageInfo pageList = new PageInfo(listCount, pageListLimit, maxPage, startPage, endPage);
		
		
		

		model.addAttribute("pageList", pageList);
		model.addAttribute("otoList", otoList);
		return "mypage/myp_oto_breakdown";
	}
	
	//1대1 문의 삭제
	@GetMapping("myp_oto_detail")
	public String mypOtoDetail(int oto_num,
							   Model model,
							   @RequestParam(defaultValue = "1")String pageNum) {
		OTOVO oto = otoService.getOto(oto_num);
		String otoDate = oto.getOto_date().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		

		model.addAttribute("otoDate", otoDate);
		model.addAttribute("oto", oto);
		return "mypage/myp_oto_detail";
	}
	
	@GetMapping("myp_oto_modifyForm")
	public String mypOtoModifyForm(int oto_num, Model model) {
		OTOVO oto = otoService.getOto(oto_num);
		String otoDate = oto.getOto_date().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
		
		//file 배열
		String[] arrFileNames = {
			oto.getOto_file1(),	
			oto.getOto_file2()
		};
		
		model.addAttribute("fileNames", arrFileNames);
		model.addAttribute("otoDate", otoDate);
		model.addAttribute("oto", oto);
		return "mypage/myp_oto_modifyForm";
	}
	
	//파일삭제 ajax 호출------
	@ResponseBody
	@PostMapping("otoDeleteFile")
	public String otoDeleteFile(OTOVO oto, HttpSession session) {
		int removeCount = otoService.removeOtoFile(oto);
		
		if(removeCount > 0) {
			String saveDir = session.getServletContext().getRealPath(uploadDir);
			if(!oto.getOto_file1().equals("")) {
				try {
					Path path = Paths.get(saveDir + "/" + oto.getOto_file1());
					Files.deleteIfExists(path);
					
					return "true";
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return "false";
	}
	
	// 1대1 문의 수정
	@PostMapping("myp_oto_modifyPro")
	public String myOtoModifyPro(@RequestParam(defaultValue = "1")String pageNum, OTOVO oto, Model model) {
		String saveDir = session.getServletContext().getRealPath(uploadDir); //실제 경로
		LocalDate now = LocalDate.now();
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		String subDir = now.format(dtf);
		
		//실제 경로에 서브 디렉토리 경로 결합
		saveDir += "/" + subDir;
		
		//서버 파일 업로드 처리
		try {
			Path path = Paths.get(saveDir); //경로 관리 path 객체 생성
			Files.createDirectories(path); //업로드
		} catch (IOException e) {
			e.printStackTrace();
		} 
		//----------------------------------------------------------
		// 파일명 중복 방지 
		//실제 파일 정보가 관리되는 MultuPartFile 타입 객체 활용
		MultipartFile mFile1 = oto.getFile1();
		MultipartFile mFile2 = oto.getFile2();
		
		oto.setOto_file1("");
		oto.setOto_file2("");
		
		//업로드 파일명을 저장할 fileNameX 변수를 ""으로 초기화
		String fileName1 = "";
		String fileName2 = "";
		
		if(mFile1 != null && !mFile1.getOriginalFilename().equals("")) {
			fileName1 = UUID.randomUUID().toString().substring(0, 8) + "_" + mFile1.getOriginalFilename();
			//boarVO 객체의 board_fileX 멤버변수에 업로드 경로명 + "/" + 파일명 문자열 결합 저장
			oto.setOto_file1(subDir + "/" + fileName1);
		}
		if(mFile2 != null && !mFile2.getOriginalFilename().equals("")) {
			fileName2 = UUID.randomUUID().toString().substring(0, 8) + "_" + mFile2.getOriginalFilename();
			//boarVO 객체의 board_fileX 멤버변수에 업로드 경로명 + "/" + 파일명 문자열 결합 저장
			oto.setOto_file2(subDir + "/" + fileName2);
		}
		
		int updateCount = otoService.updateOto(oto);
		if(updateCount > 0) {
			try {
				if(!oto.getOto_file1().equals("")) {
					//multipartFile을 경로는 savDir, 이름은 fileName1(UUID + "_" + mFile.getOriginalFilename()
					mFile1.transferTo(new File(saveDir, fileName1));
				}
				if(!oto.getOto_file2().equals("")) {
					mFile2.transferTo(new File(saveDir, fileName2));
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			//글 상세정보조회 페이지 리다이렉트
			return "redirect:/myp_oto_detail?oto_num=" + oto.getOto_num() + "&pageNum=" + pageNum;
			
		} else {
			// "글 수정 실패!" 출력 및 이전페이지 돌아가기 처리
			model.addAttribute("msg", "글 수정 실패!");
			return "error/fail";
		}
	}
	//1대1 문의 삭제
	@GetMapping("myp_oto_delete")
	public String myOtoDelete(int oto_num, Model model, HttpSession session) {
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 필요합니다!");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		}
		OTOVO oto = otoService.getOto(oto_num);
		
		if(oto == null && !id.equals(oto.getMember_id())) {
			model.addAttribute("msg", "잘못된 접근입니다");
			return "error/fail";
		}
		
		int deleteOtoCount = otoService.deleteOto(oto_num);
		if(deleteOtoCount == 0) {
			model.addAttribute("msg", "삭제 실패");
		}
		//실제 경로
		String saveDir = session.getServletContext().getRealPath(uploadDir);
		
		String[] arrFileNames = {
			oto.getOto_file1(),	
			oto.getOto_file2()	
		};
		//실제 파일이 저장된 디렉토리의 파일 지우기
		for(String fileName : arrFileNames) {
			Path path = Paths.get(saveDir + "/" + fileName);
			try {
				Files.deleteIfExists(path);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		return "redirect:/myp_oto_breakdown";
	}
	
	//1대1 문의 답변
	@GetMapping("myp_oto_reply")
	public String mpyOtoReply(@RequestParam(defaultValue = "1")String pageNum, Model model, HttpSession session, OTOVO oto) {
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("targetURL", "./");
			return "error/fail";
		}
		//등록된 문의
		oto = otoService.getOto(oto.getOto_num());
		if(oto == null) {
			model.addAttribute("msg", "답변이 없습니다");
			return "error/fail";
		}
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String oto_date = oto.getOto_date().format(dtf);
		
		OTOReplyVO reply = new OTOReplyVO();
		//답변 바인딩
		reply = otoService.getOtoReply(oto.getOto_num());
		String oto_reply_date = reply.getOto_reply_date().format(dtf);
		
		
		model.addAttribute("otoDate", oto_date);
		model.addAttribute("otoReplyDate", oto_reply_date);
		model.addAttribute("oto", oto);
		model.addAttribute("oto_reply", reply);
		
		return "mypage/myp_oto_reply";
	}
}
