package itwillbs.p2c3.boogimovie.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import itwillbs.p2c3.boogimovie.service.MemberService;
import itwillbs.p2c3.boogimovie.service.MovieInfoService;
import itwillbs.p2c3.boogimovie.service.TheaterService;
import itwillbs.p2c3.boogimovie.service.TicketingService;
import itwillbs.p2c3.boogimovie.vo.FeeAgeVO;
import itwillbs.p2c3.boogimovie.vo.MemberVO;
import itwillbs.p2c3.boogimovie.vo.MovieVO;
import itwillbs.p2c3.boogimovie.vo.MyTheaterVO;
import itwillbs.p2c3.boogimovie.vo.ScreenSessionVO;
import itwillbs.p2c3.boogimovie.vo.TheaterVO;
import itwillbs.p2c3.boogimovie.vo.TicketVO;

@Controller
public class TicketingController {
		
	@Autowired
	private MovieInfoService movieService;
	@Autowired
	private TheaterService theaterService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private TicketingService ticketingService;
	
	
	
	
	@GetMapping("tic_ticketing")
	public String ticketing(HttpSession session, Model model) {
		System.out.println("tic_ticketing()");
		
//		--로그인판별--
		
		if(session.getAttribute("sId") == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다. 로그인 하시겠습니까?");
			model.addAttribute("targetURL", "member_login");
			return "error/confirm";
		}
		
		List<MovieVO> movieList = movieService.getMovieList();
		List<TheaterVO> theaterList = theaterService.getTheatersOrderbyName();
		
		model.addAttribute("movieList", movieList);
		model.addAttribute("theaterList", theaterList);
		
		return "ticketing/tic_ticketing";
	}
	
	
	@PostMapping("tic_choose_seat")
	public String choose_seat(String final_list_data, Model model) {
		String keyword = "";
		//data 쪼개서 저장
		String movie_name  = final_list_data.split("/")[1];
		String start_time = final_list_data.split("/")[2];
		String end_time = final_list_data.split("/")[3];
		String theater_name = final_list_data.split("/")[4];
		int screen_cinema_num = Integer.parseInt(final_list_data.split("/")[5]);
		String selected_day = final_list_data.split("/")[6];
		// 포스터 가져오기
		MovieVO movie = new MovieVO();
		movie.setMovie_name(movie_name);
		MovieVO dbMovie = movieService.getMovieInfo(movie);
		String movie_poster = dbMovie.getMovie_poster();
		// 날짜와 시간 형식 지정 및 합치기
//		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		String formattedStartDateTime = selected_day + " " + start_time + ":00";
//		String formattedEndDateTime = selected_day + " " + end_time + ":00";
//		Timestamp start_date = null;
//		Timestamp end_date = null;
		// 날짜 파싱 및 Timestamp 객체 생성
//		try {
//		    java.util.Date parsedStartDate = dateFormat.parse(formattedStartDateTime);
//		    java.util.Date parsedEndDate = dateFormat.parse(formattedEndDateTime);
//		    start_date = new Timestamp(parsedStartDate.getTime());
//		    end_date = new Timestamp(parsedEndDate.getTime());
//
//		    System.out.println(start_date);
//		    System.out.println(end_date);
//		} catch (ParseException e) {
//		    e.printStackTrace();
//		}
		//Selected_day Date로 변환
		Date date = null;
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		 try {
	            // 문자열을 Date 객체로 변환
	            date = formatter.parse(selected_day);
	        } catch (ParseException e) {
	            e.printStackTrace();
	        }
		//theater_num 가지고오기
        int theater_num = theaterService.getTheaterName(theater_name);
        //movie_num 가지고오기
        int movie_num = dbMovie.getMovie_num();
		//screen_sessionVO 에 넣기	
		ScreenSessionVO scs = new ScreenSessionVO();
		scs.setMovie_num(movie_num);
		scs.setTheater_num(theater_num);
		scs.setScs_start_time(start_time);
		scs.setScs_end_time(end_time);
		scs.setScs_date(date);
		scs.setScreen_cinema_num(screen_cinema_num);
		//db에서 값 가져오기
		
		ScreenSessionVO dbScs = ticketingService.chooseSeatSelect(scs);
		//뷰에 가져갈 값 저장하기
		dbScs.setMovie_poster(movie_poster);
		dbScs.setMovie_name(movie_name);
		dbScs.setTheater_name(theater_name);
		//seats 2차원 배열 만들기
		List<String> seats = new ArrayList<>();
		char endRow = dbScs.getScreen_seat_col().charAt(0);
		int endCol = Integer.parseInt(dbScs.getScreen_seat_row());
		
		
	    for (char row = 'A'; row <= endRow; row++) {
	        for (int num = 1; num <= endCol; num++) {
	            seats.add("" + row + num);
	        }
	    }
        //복도 공백
        int first_road = 3;
        int second_road = endCol - 3;
		//시간으로 조조,심야 걸러내기
        String fee_time_keyword = "GT";
        DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("HH:mm");
        LocalTime time = LocalTime.parse(start_time, formatter2);
        
        LocalTime morningLimit = LocalTime.of(10, 0);
        LocalTime nightLimit = LocalTime.of(23, 0);
        
        if (time.isBefore(morningLimit)) {
        	fee_time_keyword = "MT";
        } else if(time.isAfter(nightLimit)){
        	fee_time_keyword = "NT";
        }
        
        //주말 공휴일 걸러내기
        String fee_day_keyword = "WD";
        DateTimeFormatter formatter3 = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDate date2 = LocalDate.parse(selected_day, formatter3);
        DayOfWeek day = date2.getDayOfWeek();
        boolean isWeekend = (day == DayOfWeek.SATURDAY || day == DayOfWeek.SUNDAY);
        
        if (isWeekend) {
        	fee_day_keyword = "HD";
        }
        //2D , 3D 걸러내기
        String fee_dimension_keyword = dbScs.getScreen_dimension();
        
        //걸러낸값으로 select 해오기
        Map<String, String> params = new HashMap<String, String>();
        params.put("fee_day_keyword", fee_day_keyword);
        params.put("fee_time_keyword", fee_time_keyword);
        params.put("fee_dimension_keyword", fee_dimension_keyword);
        System.out.println(params);
        Map<String, Object> fee_info = ticketingService.feeCalc(params);
        
        keyword = fee_dimension_keyword + fee_day_keyword + fee_time_keyword;
       List<Integer> pay_nums = ticketingService.selectPayNum(dbScs.getScs_num());
        
        String seats2 = "";
        for(int pay_num : pay_nums) {
        	List<TicketVO> tickets = ticketingService.selectPayedSeat(pay_num);
            for(TicketVO ticket : tickets) {
            	seats2 += "/" + ticket.getTicket_seat_info();
            }
        }
        System.out.println(seats2);
        
		//model에 저장
        model.addAttribute("keyword", keyword);
		model.addAttribute("scs", dbScs);
		model.addAttribute("seats", seats);
        model.addAttribute("firstRoad", first_road);
        model.addAttribute("secondRoad", second_road);
        model.addAttribute("endRow", endRow);
        model.addAttribute("endCol", endCol);
        model.addAttribute("fee_time_discount", fee_info.get("fee_time_discount"));
        model.addAttribute("fee_day_discount", fee_info.get("fee_day_discount"));
        model.addAttribute("fee_dimension_discount", fee_info.get("fee_dimension_discount"));
        model.addAttribute("start_time", start_time);
        model.addAttribute("end_time", end_time);
        model.addAttribute("scs_date", date);
        model.addAttribute("payedSeats", seats2);
        
		return "ticketing/tic_choose_seat";
	}
	
	@ResponseBody
	@GetMapping(value = "api/movieAbc", produces = "application/json")
	public List<MovieVO> movieAbc(){
		List<MovieVO> movies = movieService.getMovieList();
		return movies; 
	}
	
	@ResponseBody
	@GetMapping(value = "api/movieLike", produces = "application/json")
	public List<MovieVO> movieLike(){
		List<MovieVO> movies = movieService.getMovieListLike();
		if(movies.get(0) == null) {
			MovieVO movie = new MovieVO();
			movie.setMovie_name("영화X");
			movies.add(movie);
		}
		return movies; 
	}
	
	@ResponseBody
	@GetMapping(value = "api/movieLikeMovie", produces = "application/json")
	public List<MovieVO> movieLikeMovie(@RequestParam String sId){
		//세션에 저장된 아이디를 이용해 회원장르 추출
		
		String memberMovieGenre = memberService.movieGenreSearch(sId);
		//,로 쪼개서 배열에 저장
		String[] movieGenres = memberMovieGenre.split(",");
		//배열에 저장된 요소들을 리스트에 저장
		List<String> genreList = new ArrayList<String>();
		for(String genres : movieGenres) {
			genreList.add(genres);
		}
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("genreList", genreList);
		
		List<MovieVO> movies = movieService.getMovieListGenre(param);
		
		return movies;
	}
		
	@ResponseBody
	@GetMapping(value = "api/theaterMyTheater", produces = "application/json")
	public List<MyTheaterVO> theaterMyTheater(@RequestParam String sId){
		MemberVO member = memberService.selectTheatersMyTheater(sId);
		List<MyTheaterVO> myTheaters = new ArrayList<MyTheaterVO>();
		
		myTheaters.add(new MyTheaterVO(member.getMember_my_theater1()));
		myTheaters.add(new MyTheaterVO(member.getMember_my_theater2()));
		myTheaters.add(new MyTheaterVO(member.getMember_my_theater3()));
		if(myTheaters.isEmpty()) {
			return null;
		}
		
		return myTheaters;
	}
	
	@ResponseBody
	@GetMapping(value = "api/fee_calc", produces = "application/json")
	public int feeCalc(        @RequestParam("NP") Integer np_num,
					        	@RequestParam("YP") Integer yp_num,
					        	@RequestParam("OP") Integer op_num,
					        	@RequestParam("fee_middle") Integer fee_middle) {
		//요금 정책 가져오기
		List<FeeAgeVO> list = ticketingService.feeCalcAge();
		double total_np = 0;
		double total_yp = 0;
		double total_op = 0;
		
		//나이요금정책에 따른 현재 가져온값에 최종적인 한명당 가격 책정
	    for (FeeAgeVO feeAge : list) {
	        switch (feeAge.getFee_age_keyword()) {
	            case "NP":
	                total_np = (fee_middle * (feeAge.getFee_age_discount() / 100));
	                break;
	            case "YP":
	            	double yp_fee = feeAge.getFee_age_discount() / 100.0;
	            	total_yp = fee_middle * yp_fee;
	            	break;
	            case "OP":
	            	double op_fee = feeAge.getFee_age_discount() / 100.0;
	            	total_op = fee_middle * op_fee;
	            	break;
	        }
	    }
	    //500원 기준 반내림
	    total_np = Math.floor(total_np / 500) * 500;
	    total_yp = Math.floor(total_yp / 500) * 500;
	    total_op = Math.floor(total_op / 500) * 500;
		
	    //총가격 구하기
	    total_np *= np_num;
	    total_yp *= yp_num;
	    total_op *= op_num;
	    
	    int totalFee = (int)(total_np + total_yp + total_op);
	    
		return totalFee;
	}
				
	
	@ResponseBody
	@GetMapping(value = "api/finalList", produces = "application/json")
	public List<ScreenSessionVO> finalList(@RequestParam String selectedMovie,@RequestParam String selectedTheater,@RequestParam String selectedDay){
		//가져온 영화이름정보로 무비번호 가져오기
		MovieVO movie = new MovieVO();
		System.out.println(selectedMovie);
		movie.setMovie_name(selectedMovie);
		MovieVO dbMovie = movieService.getMovieInfo(movie);
		int movie_num = dbMovie.getMovie_num();
		
		//가져온 극장 정보로 극장번호 가져오기
		TheaterVO theater = new TheaterVO();
		theater.setTheater_name(selectedTheater);
		int theater_num = theaterService.getTheaterName(selectedTheater);
		
		//종합한 정보를 vo에 담아 db접근
		ScreenSessionVO scs = new ScreenSessionVO();
		scs.setMovie_num(movie_num);
		scs.setTheater_num(theater_num);
		Date date = null;
		//포멧
		try {
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			date = formatter.parse(selectedDay);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		
		scs.setScs_date(date);
		scs.setCurrent_date(new Date());
		List<ScreenSessionVO> final_list = ticketingService.finalListSelect(scs);
		
		
		
		//final_list값 수정,채워넣기
		for(ScreenSessionVO dbscs : final_list) {
			//영화이름 채워넣기
			dbscs.setMovie_name(selectedMovie);
			//관 이름 채워넣기
			dbscs.setTheater_name(selectedTheater);
			//seat_row,seat_col 값 곱해서 총좌석 계산
			// screenSeatRow를 정수로 변환
	        int numRows = Integer.parseInt(dbscs.getScreen_seat_row());
	        // screenSeatCol을 정수로 변환 (A=1, B=2, ..., H=8)
	        int numCols = dbscs.getScreen_seat_col().charAt(0) - 'A' + 1;
	        dbscs.setTotal_seat(numRows * numCols);
		}
	        
		System.out.println(final_list);
		
			
			
		return final_list;
	}
	
	
	
	@ResponseBody
	@GetMapping(value = "api/theaterEntireTheater", produces = "application/json")
	public List<TheaterVO> theaterEntireTheater (){
		System.out.println("전체 극장 목록 조회");
		List<TheaterVO> theaterList = theaterService.getTheatersOrderbyName();
		
		return theaterList;
	}
	
	@ResponseBody
	@PostMapping("movieSearch")
	public String movieSearch(@RequestParam(defaultValue = "1") int movie_num){
		List<Map<String, Integer>> list = ticketingService.selectTheaterByMovie(movie_num);
		JSONArray  ja = new JSONArray(list);
		
		
		return ja.toString();
	}

}
