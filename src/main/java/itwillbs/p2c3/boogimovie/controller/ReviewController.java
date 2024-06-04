package itwillbs.p2c3.boogimovie.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import itwillbs.p2c3.boogimovie.service.ReviewService;
import itwillbs.p2c3.boogimovie.vo.ReviewVO;

@Controller
public class ReviewController {
	@Autowired
	private ReviewService service;

	@PostMapping("reviewPro")
	public String reviewInfo(Model model, ReviewVO review, HttpSession session) {

		// System.out.println("리뷰" + review);
		String sessionId = (String) session.getAttribute("sId");

		if (sessionId == null || !sessionId.equals(review.getMember_id())) {
			model.addAttribute("msg", "권한이 없습니다!");
			return "error/fail";
		} else {
			int insertCount = service.registReview(review);
			int movieNum = review.getMovie_num();
			return "redirect:/movieInfo?movie_num=" + movieNum;
		}

	}

	@PostMapping("reviewUpdate")
	public String reviewUpdate(ReviewVO review2, Model model, HttpSession session) {
		// 여기 팝업창이라서 팝업창을 클로즈함.
		// System.out.println("리뷰업데이트 데이터 확인" + review2 ); 데이터 전송확인 완료 주석처리함.
		String sessionId = (String) session.getAttribute("sId");
		// System.out.println("수정" + review2.getMember_id());
		if (sessionId == null || !sessionId.equals(review2.getMember_id())) {
			model.addAttribute("msg", "수정 권한이 없습니다!");
			return "error/fail";
		}

		int updateCount = service.updateReview(review2);
		if (updateCount > 0) {
			model.addAttribute("msg", "성공적으로 수정했습니다!");
			return "error/close";
		} else {
			model.addAttribute("msg", "별점 및 관람평 수정 실패!");
			return "error/fail";
		}

	}

	@GetMapping("reviewModify")
	public String reviewModify(int review_num, Model model, HttpSession session, ReviewVO review) {
		// System.out.println("여기는 리뷰모디파이"+ review_id); 확인완료주석처리
		String sessionId = (String) session.getAttribute("sId");
		review = service.getReviewId(review_num);
		// System.out.println("수정폼" +review.getMember_id()+ review);
//        if (sessionId.equals(review.getMember_id())) {
//        	model.addAttribute("reviews", review);
//        	return "movie/review_modify";
//        } else {
//		    model.addAttribute("msg", "수정 권한이 없습니다!");
//		    return "error/fail"; // 권한 없음 페이지로 리다이렉트
//		}
//        
		if (sessionId == null || !sessionId.equals(review.getMember_id())) {
			model.addAttribute("msg", "수정 권한이 없습니다!");
			return "error/fail";
		}

		// 권한이 있는 경우 리뷰 수정 페이지로 이동
		model.addAttribute("reviews", review);
		return "movie/review_modify";

	}

	@GetMapping("deleteReview")
	public String deleteReview(int review_num, Model model, ReviewVO review, HttpSession session) {
		// System.out.println("삭제리뷰"+ review_num);
		String sessionId = (String) session.getAttribute("sId");
		
	

		int deleteCount = service.deleteReview(review_num);
		if (deleteCount > 0) {
			model.addAttribute("msg", "성공적으로 삭제했습니다!");
			return "error/close";
		} else {
			model.addAttribute("msg", "삭제 실패!");
			return "error/fail";
		}

	}

}
