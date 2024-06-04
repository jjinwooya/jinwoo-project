package itwillbs.p2c3.boogimovie.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import itwillbs.p2c3.boogimovie.service.AdminService;
import itwillbs.p2c3.boogimovie.service.MovieInfoService;
import itwillbs.p2c3.boogimovie.service.ReviewService;
import itwillbs.p2c3.boogimovie.vo.MemberVO;
import itwillbs.p2c3.boogimovie.vo.MovieVO;
import itwillbs.p2c3.boogimovie.vo.ReviewVO;

@Controller
public class MovieController {
	@Autowired
	private MovieInfoService movieService;

	@Autowired
	AdminService adminService;

	@Autowired
	private ReviewService serviceReview;

	@GetMapping("movie")
	public String home(Model model, HttpSession session, MemberVO member, MovieVO movieTrail) {
		List<MovieVO> movieInfo = movieService.getMovieList();
		movieTrail = movieService.getMovieTrail();
		// System.out.println("무비트레일러"+movieTrail);
		model.addAttribute("movieTrail", movieTrail);
		model.addAttribute("movieInfo", movieInfo);
		// 여기까지는 영화 출력관련임.
		String member_id = (String) session.getAttribute("sId");

		model.addAttribute("member_id", member_id);
		// System.out.println(movieInfo);

		return "movie/movie";
	}

	@GetMapping("movieFutureInfo") // 상영예정작 상세보기
	public String movieFutureInfo(int movie_num, MovieVO futureMovie, Model model) {
		// System.out.println("여기는 상여예봉 무비" + movie_num); 정보확인완료
		MovieVO futureMov = movieService.getFutureMovieInfo(futureMovie);
		model.addAttribute("movieFutureInfo", futureMov);
		// System.out.println("각각의 개봉예정영화 정보" + futureMov);//정보확인완료

		return "movie/movieFuture_info";
	}

	@GetMapping("movieInfo")
	public String movieInfo(@RequestParam("movie_num") int movie_num,
			@RequestParam(value = "pageNum", defaultValue = "1") int pageNum, Model model, MovieVO movie) {
		// System.out.println(movie_num); 확인완료 주석처리
		// System.out.println("여기는 무비인포 현재로그인한 " +member_id); 확인완료 주석처리.
		// System.out.println("여기는 영화 상세페이지 " + pageNum);
		int listLimit = 5;

		int startRow = (pageNum - 1) * listLimit;
		MovieVO movie2 = movieService.getMovieInfo(movie);
		model.addAttribute("movie", movie2);
		// System.out.println(movie2); 확인완료 주석처리

		List<ReviewVO> reviews = serviceReview.getReviewList(movie_num, startRow, listLimit);
		int totalReviews = serviceReview.getTotalReviews(movie_num);
		int maxPage = (int) Math.ceil((double) totalReviews / listLimit);
		model.addAttribute("maxPage", maxPage);
		model.addAttribute("pageNum", pageNum);

		// System.out.println(reviews+"리뷰리스트확인"); 확인완료 주석처리
		model.addAttribute("reviews", reviews);
		return "movie/movie_info";
	}

	@GetMapping("movieFuture") // 상영예정작리스트
	public String movieFuture(Model model, MovieVO futureMovieTrail, MemberVO member, HttpSession session) {
		futureMovieTrail = movieService.getMovieFutureTrail();
		// System.out.println("무비트레일러"+movieTrail);
		model.addAttribute("futureMovieTrail", futureMovieTrail);
		List<MovieVO> movieFuture = movieService.getMovieFuture();
		model.addAttribute("movieFuture", movieFuture);
		// System.out.println("여기는 무비퓨처" + movieFuture);확인완료
		String member_id = (String) session.getAttribute("sId");
		model.addAttribute("member_id", member_id);

		return "movie/movieFuture";
	}

	@GetMapping("boxoffice")
	public String boxoffice() {

		return "movie/boxoffice";
	}

	// 영화검색
	@GetMapping("searchMovie")
	public String searchMovie(@RequestParam(defaultValue = "") String searchKeyword, Model model) {
		if (searchKeyword.isEmpty()) {
			// 검색어가 없는 경우
			model.addAttribute("msg", "검색어를 입력해주세요.");
			return "error/fail";
		}
		List<MovieVO> movieList = movieService.searchMovie(searchKeyword);

		if (!movieList.isEmpty()) {
			// 결과가 1개일 때는 바로 상세 페이지로 이동
			if (movieList.size() == 1) {
				int movieNum = movieList.get(0).getMovie_num();
				return "redirect:/movieInfo?movie_num=" + movieNum;
			} else {
				// 결과가 2개 이상일 때는 resultMovie 페이지로 이동
				model.addAttribute("movieList", movieList);
				model.addAttribute("movieResult", movieList.size());
				return "movie/resultMovie";
			}
		} else {
			model.addAttribute("msg", "죄송합니다 검색결과 없습니다.");

			return "error/fail";
		}

	}

	// 추천영화
	@GetMapping("recommand")
	public String recommandMovie(Model model, HttpSession session, MemberVO member, MovieVO movieTrail,
			Map<String, Object> map) {
		String member_id = (String) session.getAttribute("sId");

		member = adminService.SelectMember(member_id);
		model.addAttribute("member", member);
		// System.out.println("여기 영화인데 멤버 상세정보가 필요해 " + member.getMember_movie_genre());
		String member_movie_genre = member.getMember_movie_genre();
		model.addAttribute("memberCode", member_movie_genre);
		// System.out.println("사용자의 선호 장르: " + member_movie_genre);

		List<String> genreList = Arrays.asList(member_movie_genre.split(","));

		// 맵에 리스트 추가
		map = new HashMap<String, Object>();
		map.put("genreList", genreList);
		List<MovieVO> genreMovieList = movieService.getMovieListGenre(map);
		// System.out.println("맵의 내용: " + map);
		// genreBasedMovieList 출력하여 데이터 확인
		// System.out.println("선호 장르 기반 영화 리스트: " + genreMovieList);
		model.addAttribute("genreSize", genreMovieList.size());
		model.addAttribute("genreMovieList", genreMovieList);
		// System.out.println("장르추천" +genreMovieList);

		return "movie/recommandMovie";
	}
	// 특정 영화에 대한 유저가 쓴 리뷰

	@PostMapping("member_review")
	public String memberReview(Model model, int movie_num, @RequestParam("member_id") String member_id, MovieVO movie) {
		// System.out.println("특정유저 아이디" + member_id+ movie_num); 값은 잘 넘어옴.
		MovieVO movie2 = movieService.getMovieInfo(movie);
		model.addAttribute("movie", movie2);
		List<ReviewVO> reviews = serviceReview.getMemberReview(member_id, movie_num);
		// System.out.println("특정유저가 적은 댓글 "+ reviews);

		model.addAttribute("reviews", reviews);
		if (reviews.size() > 0) {
			return "movie/movie_info_member";
		} else {
			model.addAttribute("msg", "적으신 리뷰가 없습니다.");
			// model.addAttribute("targetURL", "movie");
			return "error/fail";
		}

	}

}
