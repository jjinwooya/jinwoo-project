package itwillbs.p2c3.boogimovie.controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.Payment;

import itwillbs.p2c3.boogimovie.service.CouponService;
import itwillbs.p2c3.boogimovie.service.ItemInfoService;
import itwillbs.p2c3.boogimovie.service.MemberService;
import itwillbs.p2c3.boogimovie.service.MovieInfoService;
import itwillbs.p2c3.boogimovie.service.PaymentService;
import itwillbs.p2c3.boogimovie.service.TicketingService;
import itwillbs.p2c3.boogimovie.vo.CartVO;
import itwillbs.p2c3.boogimovie.vo.CouponVO;
import itwillbs.p2c3.boogimovie.vo.FeeAgeVO;
import itwillbs.p2c3.boogimovie.vo.ItemInfoVO;
import itwillbs.p2c3.boogimovie.vo.MemberVO;
import itwillbs.p2c3.boogimovie.vo.MovieVO;
import itwillbs.p2c3.boogimovie.vo.PayVO;
import itwillbs.p2c3.boogimovie.vo.ScreenSessionVO;
import itwillbs.p2c3.boogimovie.vo.StorePayVO;
import itwillbs.p2c3.boogimovie.vo.TheaterVO;
import itwillbs.p2c3.boogimovie.vo.TicketVO;

@Controller
public class PaymentController {
	
	private static final Object scs_date = null;

	private IamportClient api;
	
	@Autowired
	private PaymentService service;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CouponService couponService;
	
	@Autowired
	private MovieInfoService movieService;
	
	@Autowired
	private TicketingService ticketService;
	
	@Autowired
	private ItemInfoService itemService;
	
	
	public PaymentController() {
		this.api = new IamportClient("3531856454755108", "ue5UeHzRddcp4PozEatgw9W9SD1To4172hH0vQZebn5ZqW95F8WDgrZ3mD7EIyhoKuaEIHZ1HiYMz1TJ");
	} // constructor
	
	
	//String >> Date 변환용
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }
	
	
	
	@PostMapping("payment")
	public String paymentReserve(MemberVO member, HttpSession session, Model model, ScreenSessionVO scs, MovieVO movie,
			String selected_seats, String person_info, String total_fee, String scs_date2, TheaterVO theater, String keyword) {
		
		// 세션 확인
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 후 다시 시도해주세요.");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		}
		
//		System.out.println("%%%%%%%%%%%%%%%%%%%%$---------------scs : " + scs);
//		System.out.println("%%%%%%%%%%%%%%%%%%%%$---------------movie : " + movie);
		
		member.setMember_id(id);
		member = memberService.isCorrectUser(member);
		List<CouponVO> couponList = couponService.getMemberCoupon(member);
		movie = movieService.getMovieInfo(movie);
		ScreenSessionVO dbscs = service.getScreenSession(scs.getScs_num());
		dbscs.setTheater_name(scs.getTheater_name());
		dbscs.setMovie_name(movie.getMovie_name());
		dbscs.setMovie_poster(movie.getMovie_poster());
		
//		System.out.println("&&&&&&&&&&&&&&&&&&&&&---------------movie : " + movie);
//		System.out.println("&&&&&&&&&&&&&&&&&&&&&---------------dbscs : " + dbscs);
		
		// 선택 날짜 String scs_date2 > Date 변환  > "yyyy.MM.dd(E)" 형식으로 재가공
		SimpleDateFormat originalFormat = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy", Locale.ENGLISH);
		Date date = null;
		try {
		        // 문자열을 Date 객체로 변환
			date = originalFormat.parse(scs_date2);
		} catch (ParseException e) {
		    e.printStackTrace();
		}
        SimpleDateFormat targetFormat = new SimpleDateFormat("yyyy.MM.dd(E)");
        String formattedDate  = targetFormat.format(date);
		
        
        model.addAttribute("keyword", keyword);
		model.addAttribute("member", member);
		model.addAttribute("couponList", couponList);
		model.addAttribute("scs", dbscs);
		model.addAttribute("formattedDate", formattedDate);
		model.addAttribute("selected_seats", selected_seats);
		model.addAttribute("person_info", person_info);
		model.addAttribute("total_fee", total_fee);
		
		return "payment/payment_reservation";
		
	} // paymentPro()
	

	// ================================================================================
	
	// 포인트 적용 버튼 (입력 값 디비값과 비교)
	@ResponseBody
	@GetMapping("memberPoint")
	public String memberPoint(MemberVO member, int use_point, Model model){
		
		System.out.println("아이디 : " + member.getMember_id() + ", use_point : " + use_point);
		
		member = service.getMember(member);
		if(member.getMember_point() < use_point) {
			return "false";
		} 
		
		return "true"; 
		
	} // memberPoint()
	
	
	// ================================================================================
	// 예매 결제 검증 및 DB 업데이트
	@ResponseBody
	@PostMapping("payVerify{imp_uid}")
	public boolean payVerify(@PathVariable(value = "imp_uid") String imp_uid, String use_point, String coupon_num, MemberVO member, String amount, 
	        MovieVO movie, String theater_name, String screen_cinema_num, ScreenSessionVO scs, String person_info, PayVO pay, 
	        String selected_seats, TicketVO ticket, String keyword) throws IamportResponseException, IOException {

	    System.out.println("%%%%%%%%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$---------------scs : " + scs);
	    Payment payment = this.api.paymentByImpUid(imp_uid).getResponse(); // 검증처리

	    if(payment.getStatus().equals("paid")) {
	        // 리턴받은 payment의 status가 결제완료이면 DB조작 메소드 실행
	        System.out.println("payVerify - paid ");
	        
	        int amountInt = Integer.parseInt(amount);
	        int usePointInt = Integer.parseInt(use_point);
	        double savePointDouble = amountInt * 0.1;
	        int savePoint = (int)(savePointDouble / 100) * 100;
	        int apply_point = savePoint - usePointInt;
	         
	        member = service.getMember(member);
	        member.setMember_point(member.getMember_point() + apply_point);
	        service.updateMemberPoint(member);
	        couponService.useCoupon(coupon_num);
	        
	        pay.setMember_id(member.getMember_id());
	        pay.setMerchant_uid(payment.getMerchantUid());
	        pay.setTicket_pay_price(amountInt);
	        pay.setUse_point(usePointInt);
	        pay.setScs_num(scs.getScs_num());
	        pay.setTicket_pay_status("결제");
	        pay.setTicket_pay_type(payment.getPgProvider());
	        pay.setCoupon_num(Integer.parseInt(coupon_num));
	        pay.setSave_point(savePoint);
	        
	        service.savePayInfo(pay); // pay 테이블에 결제 정보 저장
	        System.out.println("pay  : " + pay);
	        
	        PayVO payInfo = service.getPayInfo(pay.getMerchant_uid());
	        System.out.println("kkkkkkkkkkkkkkkeeeeeeeeeeeyyyyyyyyyword : " + keyword);
	        // 티켓처리
	        String[] keywordArr = splitString(keyword, 2);
	        
	        // person_info에서 숫자만 남기기
	        String[] parts = person_info.split(",\\s*");
	        int[] numbers = new int[parts.length];
	        for (int i = 0; i < parts.length; i++) {
	            String part = parts[i];
	            String numberStr = part.replaceAll("[^0-9]", ""); // 숫자만 남기기
	            numbers[i] = Integer.parseInt(numberStr);
	        }

	        String[] seats = selected_seats.split(",");
	        int NP_num = 0;
	        int YP_num = 0;
	        int OP_num = 0;

	        Map<String, String> fee_map = new HashMap<>();
	        fee_map.put("fee_dimension_keyword", keywordArr[0]);
	        fee_map.put("fee_day_keyword", keywordArr[1]);
	        fee_map.put("fee_time_keyword", keywordArr[2]);

	        for(int i = 0; i < numbers.length; i++) {
	            double fee = 15000;
	            Map<String, Object> dbfee_map = ticketService.feeCalc(fee_map);
	            fee = fee * ((int)dbfee_map.get("fee_day_discount") / 100.0) 
	                        * ((int)dbfee_map.get("fee_time_discount") / 100.0) 
	                        * ((int)dbfee_map.get("fee_dimension_discount") / 100.0);
	            
	            List<FeeAgeVO> feeAge = ticketService.feeCalcAge();
	            String ageCategory = "";
	            switch (i) {
	                case 0:
	                    NP_num = numbers[i];
	                    ageCategory = "NP";
	                    break;
	                case 1:
	                    YP_num = numbers[i];
	                    ageCategory = "YP";
	                    break;
	                case 2:
	                    OP_num = numbers[i];
	                    ageCategory = "OP";
	                    break;
	            }
	            for(FeeAgeVO fa : feeAge) {
	                if(fa.getFee_age_keyword().equals(ageCategory)) {
	                    fee = fee * (fa.getFee_age_discount() / 100.0);
	                }
	            }
	            fee = Math.floor(fee / 500) * 500;
	            int pay_num = payInfo.getTicket_pay_num();

	            ticket.setTicket_keyword(keyword + ageCategory);
	            ticket.setTicket_pay_num(pay_num);
	            ticket.setTicket_price((int)fee);

	            int seatStartIndex = (i == 0) ? 0 : (i == 1) ? NP_num : NP_num + YP_num;
	            int seatCount = (i == 0) ? NP_num : (i == 1) ? YP_num : OP_num;
	            for (int j = 0; j < seatCount; j++) {
	                if (seatStartIndex + j < seats.length) {
	                    ticket.setTicket_seat_info(seats[seatStartIndex + j]);
	                    service.saveTicketInfo(ticket);
	                } else {
	                    System.out.println("Warning: Not enough seats provided for the ticket count.");
	                }
	            }//ticket업데이트 종료
	            
	        }
            //empty_seat 업데이트
            int totalPeople = NP_num + YP_num + OP_num;
            int scs_num = scs.getScs_num();
            
            int updateCount = service.updateEmptySeat(scs_num, totalPeople);
            if(updateCount < 1) {
            	System.out.println("emptyseat 업데이트 실패");
            	return false;
            }
	        
	        return true;
	    } else if(payment.getStatus().equals("failed")) {
	        System.out.println("payVerify - failed ");
	        return false; 
	    }
	    return false; 
	}


	
	// ================================================================================
	// 최종 결제 완료 페이지로
	@GetMapping("success_reserve{merchant_uid}")
	public String successReserve(@PathVariable("merchant_uid") String merchant_uid, Model model, PayVO pay, Map<String, Object>map) {
		
		pay = service.getPayInfo(merchant_uid);
		System.out.println("%%%%%%%%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$---------------pay : " + pay);
		map = service.getPaymentInfoView(pay.getTicket_pay_num());
		System.out.println("%%%%%%%%$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$---------------map : " + map);
		CouponVO coupon = service.getCoupon(pay.getCoupon_num());
		
		model.addAttribute("pay", pay);
		model.addAttribute("payInfo", map);
		model.addAttribute("coupon", coupon);
		
		
		
		return "payment/payment_success_reserve";
		
	} // successReserve()
	
	
	
	// ================================================================================
	// 스토어 결제 화면으로
	
	@PostMapping("payment_store")
	public String paymentStore(String itemName, String quantity, String totalPrice, Model model,  HttpSession session, MemberVO member) {
		// 세션 확인
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 후 다시 시도해주세요.");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		}
		member.setMember_id(id);
		member = memberService.isCorrectUser(member);
		
		String[] items = itemName.split(",");
		String[] quantities = quantity.split(",");
		String[] totalPrices = totalPrice.split(",");
		List<CartVO> cartList = new ArrayList<CartVO>();
		
		Random random = new Random();
		int rNum = random.nextInt(9000000) + 1000000;
		String cart_id = rNum + "_"+ id;
		
		int total_fee = 0;
		
		for(int i = 0; i < items.length;i++) {
			CartVO cart = new CartVO();
			int item_num = itemService.getItemNum(items[i]);
			String item_image = itemService.getItemImage(item_num);
			cart.setItem_info_num(item_num);
			int quan = Integer.parseInt(quantities[i]);
			int price = Integer.parseInt(totalPrices[i]);
			cart.setItem_quantity(quan);
			cart.setItem_info_name(items[i]);
			cart.setItem_total_price(price);
			cart.setItem_info_image(item_image);
			cart.setItem_price(price/quan);
			cart.setMember_id(id);
			cart.setCart_id(cart_id);
			cartList.add(cart);
			total_fee += price;
		}
		List<CouponVO> couponList = couponService.getMemberCoupon(member);
		
		model.addAttribute("couponList", couponList);
		model.addAttribute("member", member);
		model.addAttribute("cartList", cartList);
		model.addAttribute("cart_id", cart_id);
		model.addAttribute("total_fee", total_fee);
		session.setAttribute("cartList", cartList);
		
		
		return "payment/payment_store";
	}
	

	//================================================================================
	// 스토어 결제 검증 및 DB 업데이트
	@ResponseBody
	@PostMapping("payVerifyStore{imp_uid}")
	public boolean payVerifyStore(@PathVariable(value = "imp_uid") String imp_uid, String use_point, String coupon_num, MemberVO member, String amount, 
			StorePayVO storePay, String cart_id, HttpSession session) throws IamportResponseException, IOException{
		
		Payment payment = this.api.paymentByImpUid(imp_uid).getResponse(); // 검증처리
		if(payment.getStatus().equals("paid")) {
			System.out.println("payVerifyStore - paid ");
			
			int amountInt = Integer.parseInt(amount);
			int usePointInt = Integer.parseInt(use_point);
			double savePointDouble = amountInt * 0.1;
			int savePoint = (int)(savePointDouble / 100) * 100;
			int apply_point = savePoint - usePointInt;
			 
			member = service.getMember(member);
			member.setMember_point(member.getMember_point() + apply_point);
			service.updateMemberPoint(member);
			couponService.useCoupon(coupon_num);
			
			List<CartVO> cartList = (List<CartVO>)session.getAttribute("cartList");
			for(CartVO cart : cartList) {
				service.insertCart(cart);
				System.out.println("####$## cart : " + cart);
			}
			
			storePay.setStore_pay_type(payment.getPgProvider());
			storePay.setStore_pay_status("결제");
			storePay.setMerchant_uid(payment.getMerchantUid());
			storePay.setStore_pay_price(amountInt);
			storePay.setCoupon_num(Integer.parseInt(coupon_num));
			storePay.setMember_id(member.getMember_id());
			storePay.setUse_point(usePointInt);
			storePay.setCart_id(cart_id);
			storePay.setSave_point(savePoint);
			System.out.println("%%%%%%% storePay : " + storePay);
			service.saveStorePayInfo(storePay);
			
			return true; 
			
		} else if(payment.getStatus().equals("failed")) {
			System.out.println("payVerifyStore - failed ");
			
			return false; 
			
		}
		
		return false; 
		
		
		
		
	} // payVerifyStore()
	

	//================================================================================
	// 스토어 최종 결제 완료 페이지로
	@GetMapping("success_store{merchant_uid}")
	public String successStore(@PathVariable("merchant_uid") String merchant_uid, Model model, StorePayVO store_pay, HttpSession session, ItemInfoVO item) {
		System.out.println("merchant_uid : " + merchant_uid);
		
		// 세션 확인
		String id = (String)session.getAttribute("sId");
		if(id == null) {
			model.addAttribute("msg", "로그인 후 다시 시도해주세요.");
			model.addAttribute("targetURL", "member_login");
			return "error/fail";
		}

		store_pay = service.getStorePayInfo(merchant_uid);
		List<CartVO> cartList = service.getCartInfo(store_pay.getCart_id());
		int total_fee = 0;
		
		
		for(CartVO cart : cartList) {
			item = service.getItemInfo(cart.getItem_info_num());
			cart.setItem_info_name(item.getItem_info_name());
			cart.setItem_info_image(item.getItem_info_image());
			total_fee += cart.getItem_price()*cart.getItem_quantity();
		}
		CouponVO coupon = service.getCoupon(store_pay.getCoupon_num());
		System.out.println("cartList : " + cartList);
		model.addAttribute("store_pay", store_pay);
		model.addAttribute("cartList", cartList);
		model.addAttribute("total_fee", total_fee);
		model.addAttribute("coupon", coupon);
		
		return "payment/payment_success_store";
	} // successStore()
	
	
	
	// ======================================================================
	
    public static String[] splitString(String input, int size) {
        int arraySize = (int) Math.ceil((double) input.length() / size);
        String[] result = new String[arraySize];

        for (int i = 0; i < arraySize; i++) {
            int start = i * size;
            int end = Math.min(start + size, input.length());
            result[i] = input.substring(start, end);
        }

        return result;
    }
	
	
	
} // PaymentController()

