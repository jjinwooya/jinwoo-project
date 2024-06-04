package itwillbs.p2c3.boogimovie.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import itwillbs.p2c3.boogimovie.mapper.MovieMapper;
import itwillbs.p2c3.boogimovie.vo.MovieGenreVO;
import itwillbs.p2c3.boogimovie.vo.MovieVO;

@Service
public class MovieInfoService {
	@Autowired
	private MovieMapper mapper;

	public List<MovieVO> getMovieList() {

		return mapper.selectMovieInfo();
	}

	public MovieVO getMovieInfo(MovieVO movie) {

		return mapper.selectMovie(movie);
	}

	public List<MovieVO> getMovieListLike() {

		return mapper.selectMovieInfoLike();
	}

	public List<MovieVO> getMovieListAbc() {

		return mapper.selectMovieInfoAbc();
	}

	public int getMovieGenreNum(MovieGenreVO movieGenre) {

		return mapper.selectMovieGenreNum(movieGenre);
	}

	public List<MovieVO> getMovieListGenre(Map<String, Object> genreList) {
		return mapper.selectMovieInfoGenre(genreList);
	}

	public List<MovieVO> getMovieFuture() {

		return mapper.selectMovieFuture();
	}

	public MovieVO getFutureMovieInfo(MovieVO futureMovie) {

		return mapper.selectFutureMovieInfo(futureMovie);
	}

	// 영화 트레일러 담는 곳
	public MovieVO getMovieTrail() {

		return mapper.selectMovieTrail();
	}

	public MovieVO getMovieFutureTrail() {

		return mapper.selectMovieFutureTrail();
	}

	// 상영영화 검색기
	public List<MovieVO> searchMovie(String searchKeyword) {
		return mapper.searchMovie(searchKeyword);
	}

}
