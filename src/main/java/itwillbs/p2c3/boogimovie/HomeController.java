package itwillbs.p2c3.boogimovie;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import itwillbs.p2c3.boogimovie.service.MovieInfoService;
import itwillbs.p2c3.boogimovie.vo.MemberVO;
import itwillbs.p2c3.boogimovie.vo.MovieVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	private MovieInfoService movieService;
	
	@Autowired
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/", method = {RequestMethod.GET, RequestMethod.POST})
	public String home(Model model , HttpSession session,MemberVO member, MovieVO movieTrail) {
		//System.out.println("�쁽�옱 �븘�씠�뵒" + member.getMember_id());
		List<MovieVO> movieInfo = movieService.getMovieList();
		movieTrail = movieService.getMovieTrail();
		//System.out.println("臾대퉬�듃�젅�씪�윭"+movieTrail);
		model.addAttribute("movieTrail", movieTrail);
		model.addAttribute("movieInfo", movieInfo);
//		session.setAttribute("sId", "admin");
		String member_id = (String) session.getAttribute("sId");
		//System.out.println("�쁽�옱濡쒓렇�씤�븳 " +member_id);
		model.addAttribute("member_id", member_id);
		//System.out.println(movieInfo);
		return "movie/movie";
	}
}

//	@GetMapping("movieFuture")// �긽�쁺�삁�젙�옉由ъ뒪�듃
//	public String movieFuture(Model model) {
//		
//		List<MovieVO> movieFuture = movieService.getMovieFuture();
//		model.addAttribute("movieFuture", movieFuture);
//		//System.out.println("�뿬湲곕뒗 臾대퉬�벂泥�" + movieFuture);�솗�씤�셿猷�
//	    return "movie/movieFuture";
//	}
//}
