package itwillbs.p2c3.boogimovie.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class MovieVO {
	private int movie_num;
	private String movie_name;
	private String movie_director;
	private String movie_poster;
	private String movie_trailler;
	private Date movie_open_date;
	private Date movie_end_date;
	private String movie_status;
	private String movie_grade;
	private String movie_summary;
	private String movie_runtime;
	private String movie_stillCut;
	private String movie_stillCut2;
	private String movie_stillCut3;
	private String movie_genre;
	
}
	
	
	